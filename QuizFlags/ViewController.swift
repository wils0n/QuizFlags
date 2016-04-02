//
//  ViewController.swift
//  QuizFlags
//
//  Created by Wilson Mejía on 2/04/16.
//  Copyright © 2016 NinjaLABS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgQuestion: UIImageView!
    
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    
    @IBOutlet weak var viewFeedback: UIView!
    @IBOutlet weak var lbFeedback: UILabel!
    @IBOutlet weak var btnFeedback: UIButton!
    
    var questions: [Question]!
    
    var currentQuestion = 0
    var grade = 0.0
    var quizEnded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let q0answer0 = Answer(answer: "Peru", isCorrect: true)
        let q0answer1 = Answer(answer: "Argentina", isCorrect: false)
        let q0answer2 = Answer(answer: "Brasil", isCorrect: false)
        let q0answer3 = Answer(answer: "Bolivia", isCorrect: false)
        let question0 = Question(strImageFileName: "peru", answers: [q0answer0, q0answer1, q0answer2, q0answer3])
        
        let q1answer0 = Answer(answer: "Brasil", isCorrect: true)
        let q1answer1 = Answer(answer: "Colombia", isCorrect: false)
        let q1answer2 = Answer(answer: "Bolivia", isCorrect: false)
        let q1answer3 = Answer(answer: "Uruguay", isCorrect: false)
        let question1 = Question(strImageFileName: "brasil", answers: [q1answer0, q1answer1, q1answer2, q1answer3])
        
        let q2answer0 = Answer(answer: "Bolivia", isCorrect: true)
        let q2answer1 = Answer(answer: "Colombia", isCorrect: false)
        let q2answer2 = Answer(answer: "Peru", isCorrect: false)
        let q2answer3 = Answer(answer: "Argentina", isCorrect: false)
        let question2 = Question(strImageFileName: "bolivia", answers: [q2answer0, q2answer1, q2answer2, q2answer3])
        
        let q3answer0 = Answer(answer: "Argentina", isCorrect: true)
        let q3answer1 = Answer(answer: "Uruguay", isCorrect: false)
        let q3answer2 = Answer(answer: "Ecuador", isCorrect: false)
        let q3answer3 = Answer(answer: "Paraguay", isCorrect: false)
        let question3 = Question(strImageFileName: "argentina", answers: [q3answer0, q3answer1, q3answer2, q3answer3])
        
        let q4answer0 = Answer(answer: "Colombia", isCorrect: true)
        let q4answer1 = Answer(answer: "Uruguay", isCorrect: false)
        let q4answer2 = Answer(answer: "Ecuador", isCorrect: false)
        let q4answer3 = Answer(answer: "Paraguay", isCorrect: false)
        let question4 = Question(strImageFileName: "colombia", answers: [q4answer0, q4answer1, q4answer2, q4answer3])
        
        let q5answer0 = Answer(answer: "Uruguay", isCorrect: true)
        let q5answer1 = Answer(answer: "Colombia", isCorrect: false)
        let q5answer2 = Answer(answer: "Ecuador", isCorrect: false)
        let q5answer3 = Answer(answer: "Paraguay", isCorrect: false)
        let question5 = Question(strImageFileName: "uruguay", answers: [q5answer0, q5answer1, q5answer2, q5answer3])
        
        
        questions = [question0, question1, question2, question3, question4, question5]
        
        startQuiz()
    }
    
    func startQuiz(){
        questions.shuffle()
        for(var i=0; i < questions.count; i++){
            questions[i].answers.shuffle()
        }
        quizEnded = false
        grade = 0.0
        currentQuestion = 0
        
        showQuestion(0) // muestra la primera pregunta
    }
    
    func showQuestion(questionid: Int){
        
        btnAnswer1.enabled = true
        btnAnswer2.enabled = true
        btnAnswer3.enabled = true
        btnAnswer4.enabled = true
        
        //lbQuestion.text = questions[questionid].strQuestion
        imgQuestion.image = questions[questionid].imgQuestion
        btnAnswer1.setTitle(questions[questionid].answers[0].strAnswer, forState: UIControlState.Normal)
        btnAnswer2.setTitle(questions[questionid].answers[1].strAnswer, forState: UIControlState.Normal)
        btnAnswer3.setTitle(questions[questionid].answers[2].strAnswer, forState: UIControlState.Normal)
        btnAnswer4.setTitle(questions[questionid].answers[3].strAnswer, forState: UIControlState.Normal)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func chooseAnswer1(sender: AnyObject) {
        selectAnswer(0)
    }
    
    @IBAction func chooseAnswer2(sender: AnyObject) {
        selectAnswer(1)
    }
    
    @IBAction func chooseAnswer3(sender: AnyObject) {
        selectAnswer(2)
    }
    
    @IBAction func chooseAnswer4(sender: AnyObject) {
        selectAnswer(3)
    }
    
    func selectAnswer(answerid: Int){
        btnAnswer1.enabled = false
        btnAnswer2.enabled = false
        btnAnswer3.enabled = false
        btnAnswer4.enabled = false
        
        viewFeedback.hidden = false
        
        let answer: Answer = questions[currentQuestion].answers[answerid]
        
        if(answer.isCorrect == true){
            grade = grade + 1.0
            lbFeedback.text = answer.strAnswer + "\n Respuesta Correcta!"
        }else{
            lbFeedback.text = answer.strAnswer + "\n Respuesta Incorrecta..."
        }
        
        if (currentQuestion < questions.count - 1){
            btnFeedback.setTitle("Próxima", forState: UIControlState.Normal)
        }else{
            btnFeedback.setTitle("Ver Nota", forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func btnFeedbackAction(sender: AnyObject) {
        viewFeedback.hidden = true
        
        if quizEnded{
            startQuiz()
        }else{
            nextQuestion()
        }
    }
    
    func nextQuestion(){
        currentQuestion += 1
        if(currentQuestion < questions.count){
            showQuestion(currentQuestion)
        }else{
            endQuiz()
        }
    }
    
    func endQuiz(){
        grade = grade/Double(questions.count)*100.0
        quizEnded = true
        viewFeedback.hidden = false
        lbFeedback.text = "Su nota: \(grade)"
        btnFeedback.setTitle("Reintentar", forState: UIControlState.Normal)
    }
    
}

