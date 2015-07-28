//
//  ViewController.swift
//  Back to Bach
//
//  Created by Yohannes Wijaya on 7/28/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Stored properties
    
    var songPlayer: AVAudioPlayer!
    let songFilePath: String! = NSBundle.mainBundle().pathForResource("Porno Graffitti - Lack", ofType: "mp3")
    var playOrPause: (String, String) = ("Play", "Pause")
    enum SongPotentialError: ErrorType {
        case SongFileNotFound
    }

    // MARK: - IBOutlet properties
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songVolumeSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    // MARK: - IBAction properties
    
    @IBAction func playPauseButtonPressed(sender: UIButton) {
        do {
            try self.songPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: self.songFilePath))
            print(self.songFilePath)
            self.songPlayer.prepareToPlay()
            self.songPlayer.play()
            self.playPauseButton.setTitle(self.isPlaying(), forState: UIControlState.Normal)
            self.stopButton.enabled = true
        }
        catch SongPotentialError.SongFileNotFound {
            print("Song file is not found...")
        }
        catch {
            print("Unregistered error has occured...")
        }
    }
    @IBAction func stopButtonPressed(sender: UIButton) {
        self.songPlayer.stop()
        self.playPauseButton.setTitle("Play", forState: UIControlState.Normal)
        self.stopButton.enabled = false
    }
    
    @IBAction func songVolumeSliderChanged(sender: UISlider) {
        self.songPlayer.volume = sender.value
    }
    
    // MARK: - Local methods
    
    func isPlaying() -> String {
        return self.playPauseButton.titleForState(UIControlState.Normal) == "Play" ? "Pause" : "Play"
    }
}

