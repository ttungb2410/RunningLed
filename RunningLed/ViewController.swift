//
//  ViewController.swift
//  RunningLed
//
//  Created by TTung on 3/20/17.
//  Copyright © 2017 TTung. All rights reserved.
//

import UIKit

enum Direction {
    case LeftToRight
    case TopToBottom
    case RightToLeft
    case BottomToTop
    
    
}

class ViewController: UIViewController {
    
    var direction = Direction.LeftToRight
    var n:Int!
    var _marginRow: CGFloat = 40
    var _marginCol: CGFloat = 80
    var ball =  UIImageView(image: nil)
    var lastOnLed = 0
    var timer: Timer!
    var topLeft:Int!
    var topRight:Int!
    var bottomRight:Int!
    var bottomLeft:Int!
    
    
    @IBOutlet weak var tf_draw: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btn_draw(_ sender: Any) {
        resetDraw()
        drawBall()
        topLeft = -1
        topRight = n
        bottomRight = n*n-1
        bottomLeft = n*n-n

        print(topLeft)
        print(topRight)
        print(bottomRight)
        print(bottomLeft)

        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(runningLed), userInfo: nil, repeats: true)

    }
    func stopTimer(){
        timer.invalidate()
    }
    
    func end(){
        if abs(bottomLeft - topRight) == 1 {
            stopTimer()

        }
    }
    
    func runningLed(){
        
        end()
    
        switch direction {
        case .LeftToRight:
            
            if (lastOnLed != topLeft){
                turnOffLed()
            }
            if (lastOnLed != topRight){
                lastOnLed = lastOnLed + 1
            }
            else{
                topLeft = topLeft + n + 1
                direction = Direction.TopToBottom
                
            }
            
            turnOnLed()
            
        case .TopToBottom:
            
            if (lastOnLed == topRight ){
                turnOffLed()
            }
            if (lastOnLed != topRight  ){
                turnOffLed()
            }
            if (lastOnLed != bottomRight + 1 ){
                lastOnLed = lastOnLed + n
            }else{
                topRight = topRight + n - 1
                direction = Direction.RightToLeft
            }
            
            turnOnLed()
        case .RightToLeft:
            
            if (lastOnLed == bottomRight + 1  ){
                turnOffLed()
            }
            if (lastOnLed != bottomRight + 1  ){
                turnOffLed()
            }
            if (lastOnLed != bottomLeft + 1 ){
                lastOnLed = lastOnLed - 1
            }
            else{
                bottomRight = bottomRight - n - 1
                
                direction = Direction.BottomToTop
            }
            
            turnOnLed()
            
            
        case .BottomToTop:
            
            if (lastOnLed == bottomLeft + 1 ){
                turnOffLed()
            }
            if (lastOnLed != bottomLeft + 1 ){
                
                turnOffLed()
            }
            if (lastOnLed != topLeft + 1 ){
                lastOnLed = lastOnLed - n
            }
            else{
                bottomLeft = bottomLeft - n + 1
                
                direction = Direction.LeftToRight
            }
            
            turnOnLed()
            
        default:
            print("AAAAAAAA")
        }
    }
    
    
    
    func turnOnLed(){
        if let ball = self.view.viewWithTag(50 + lastOnLed)as? UIImageView{
            ball.image = UIImage(named: "green")
        }
    }
    func turnOffLed(){
        if let ball = self.view.viewWithTag(50 + lastOnLed)as? UIImageView{
            ball.image = UIImage(named: "grey")
        }
        
    }
    
    
    func drawBall(){
        n = Int(tf_draw.text!)!
        var count = 0
        
        
        for indexCot in 0..<n{
            for indexHang in 0..<n{
                count = count + 1
                let image = UIImage(named: "green")
                let ball = UIImageView(image: image)
                ball.tag = 50 + count
                ball.center = CGPoint(x: _marginRow + CGFloat(indexHang) * spaceBetweenBallRow() , y: CGFloat(indexCot) * spaceBetweenBallCol() + _marginCol)
                self.view.addSubview(ball)
            }
            
        }
        
    }
    func spaceBetweenBallRow() -> CGFloat{
        
        let space = (self.view.bounds.size.width - 2*_marginRow)/CGFloat(n-1)
        return space
    }
    func spaceBetweenBallCol() -> CGFloat{
        let space = (self.view.bounds.size.height - 2*_marginCol)/CGFloat(n-1)
        return space
    }
    func resetDraw(){
        
        let rsDraw = self.view.subviews
        for ball in rsDraw {
            
            if ball.tag >= 50  {
                ball.removeFromSuperview()
            }else{
                print("New")
            }
        }
        
        
    }
    
    
}

