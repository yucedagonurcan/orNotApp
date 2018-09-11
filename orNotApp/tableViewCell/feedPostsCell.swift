//
//  feedPostsCell.swift
//  orNotApp
//
//  Created by Halil İbrahim Şimşek on 28.02.2018.
//  Copyright © 2018 dotOrNotAppTeam. All rights reserved.
//

import UIKit
import Firebase

class feedPostsCell: UITableViewCell {
    var secenek1 : Double = 0;
    var secenek2 : Double = 0;
    var yüzdeSecenek1 : Int = 0;
    var yüzdeSecenek2 : Int = 0;
    var toplam : Double = 0;
    var isRated: Bool = false;
   
    @IBOutlet weak var senderId: UILabel!
    @IBOutlet weak var optionOneBtn: UIButton!
    @IBOutlet weak var optionTwoBtn: UIButton!
    
    
    
  //secenel1 is for liked and secenek2 is for disliked
   /* @IBOutlet weak var colone2: UIImageView!
    @IBOutlet weak var colone1: UIImageView!*/
    @IBOutlet weak var post: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastName: UILabel!
    let uid = Auth.auth().currentUser?.uid
    @IBAction func optionOneBtnPressed(_ sender: UIButton) {
  
        DataService.instance.setCellOptionOneCount(forContent: post.text!, foruid: senderId.text!) { (returned) in
            
        }
        DataService.instance.getCellKey(forContent: post.text!, foruid: senderId.text!) { (returnedCellKey) in
            DataService.instance.addUserToRatedUsers(withpost: self.post.text!, forCellUid: returnedCellKey, forUserUid: self.uid!) { (retuenUser) in
                
            }
        }
        
        DataService.instance.getCellOptionOneCount(forContent: post.text!, foruid: senderId.text!) { (returnedOptionOneCount) in
            DataService.instance.getCellOptionTwoCount(forContent: self.post.text!, foruid: self.senderId.text!, handler: { (returnedOptionTwoCount) in
                
                
                var optionOneRate = (Double)(100*(returnedOptionOneCount+1))/(Double)(returnedOptionOneCount+1+returnedOptionTwoCount)
                var optionTwoRate = 0.0
                if(returnedOptionTwoCount != 0){
                    optionTwoRate = (Double)(100*returnedOptionTwoCount)/(Double)(returnedOptionOneCount+1+returnedOptionTwoCount)
                    self.optionTwoBtn.setTitle("%\(Int(optionTwoRate))", for: UIControlState.normal)
                }else{
                    self.optionTwoBtn.setTitle("%\(0)", for: UIControlState.normal)
                }
                
                
                self.optionOneBtn.setTitle("%\(Int(optionOneRate))", for: UIControlState.normal)
                
            })
        }
       
        
    }
    
    
    @IBAction func optionTwoBtnPressed(_ sender: UIButton) {
        print(uid!)
        DataService.instance.setCellOptionTwoCount(forContent: post.text!, foruid: senderId.text!) { (returned) in
            print("updatedCount")
        }
        DataService.instance.getCellKey(forContent: post.text!, foruid: senderId.text!) { (returnedCellKey) in
            DataService.instance.addUserToRatedUsers(withpost: self.post.text!, forCellUid: returnedCellKey, forUserUid: self.uid!) { (retuenUser) in
                print("get cell key "+returnedCellKey)
                print(retuenUser)
            }
        }
        DataService.instance.getCellOptionOneCount(forContent: post.text!, foruid: senderId.text!) { (returnedOptionOneCount) in
            print("get optionvOnevCount")
            DataService.instance.getCellOptionTwoCount(forContent: self.post.text!, foruid: self.senderId.text!, handler: { (returnedOptionTwoCount) in
                
                print("here")
                var optionTwoRate = (Double)(100*(returnedOptionTwoCount+1))/(Double)(returnedOptionOneCount+1+returnedOptionTwoCount)
                
                var optionOneRate = 0.0
                
                if(returnedOptionOneCount != 0){
                    optionOneRate = (Double)(100*returnedOptionOneCount)/(Double)(returnedOptionOneCount+1+returnedOptionTwoCount)
                    self.optionOneBtn.setTitle("%\(Int(optionOneRate))", for: UIControlState.normal)
                }else{
                    self.optionOneBtn.setTitle("%\(0)", for: UIControlState.normal)
                }
                
                self.optionTwoBtn.setTitle("%\(Int(optionTwoRate))", for: UIControlState.normal)
                
                
            })
        }
        
    }
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255,blue: 160/255, alpha: 0.5)
                                               selectedBackgroundView = selectedView
    }

}
