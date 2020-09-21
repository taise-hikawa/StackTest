//
//  ViewController.swift
//  StackTest
//
//  Created by Sakurako Shimbori on 2020/09/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    
    // 1行あたりのアイテム数
    private let space:CGFloat = 1
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "postCell")
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imgCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    let posts = ["今日は楽しかった","ゲームで負けた"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! ImageCollectionViewCell
        cell.backgroundColor = UIColor.red
       
        let cellSize:CGFloat = (self.view.bounds.width - (space * 2))/3
        cell.imageCell.image = UIImage(named: "a")?.resized(toWidth: cellSize)
//        cell.imageCell.image?.resized(toWidth: cellSize)
//        cell.imageCell.image?.size = CGRect(x: 0,y: 0,width: cellSize,height: cellSize)
        print(cell.frame)
        print(cell.imageCell.frame)
//        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
//
//        imageView.contentMode = .scaleAspectFit
//        let cellSize:CGFloat = (self.view.bounds.width - (space * 2))/3
//        imageView.frame = CGRect(x: 0, y: 0, width: cellSize, height: cellSize)
//        imageView.image = UIImage(named: "a")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横方向のスペース調整
        let cellSize:CGFloat = (self.view.bounds.width - (space * 2))/3
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
                print(indexPath.row)
    }
}
extension UIImage{
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
