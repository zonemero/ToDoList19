//
//  ViewController.swift
//  ToDoList
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listaDeTarefas: [String] = []
    let key = "listaDeTarefas"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        if let lista = UserDefaults.standard.value(forKey: self.key) as? [String]{
            listaDeTarefas.append(contentsOf: lista)
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "Nova Tarefa", message: "adiciona uma nova tarefa", preferredStyle: .alert)
        
        let acaoSalvar = UIAlertAction(title: "salvar", style: .default) { (action) in
            if let textField = alert.textFields?.first, let texto = textField.text{
                self.listaDeTarefas.append(texto)
                self.tableView.reloadData()
                UserDefaults.standard.set(self.listaDeTarefas, forKey: self.key)
            }
        }
        
        let acaoCancelar = UIAlertAction(title: "cancelar", style: .cancel) { (action) in
            print("cancelou")
            
        }
        
        alert.addAction(acaoSalvar)
        alert.addAction(acaoCancelar)
        
        alert.addTextField()
        
        present(alert, animated: true)
    }
    
    
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeTarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaDeTarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            listaDeTarefas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.listaDeTarefas, forKey: self.key)
        }
    }
}
