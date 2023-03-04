import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    mines = new ArrayList<MSButton>();
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++) {
      for(int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r,c);
      }
    }
    for(int i = 0; i < 200; i++)
    setMines();
}
public void setMines()
{
  int randomRow = (int)(Math.random()*NUM_ROWS);
    int randomCol = (int)(Math.random()*NUM_COLS);
    if(mines.contains(buttons[randomRow][randomCol]) == false)
        mines.add(buttons[randomRow][randomCol]);
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for(int i = 0; i < mines.size(); i++){
      if(mines.get(i).isFlagged() == false){
        return false;
      }
     }
    return true;
}
public void displayLosingMessage()
{
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c].setLabel(":(");
    }
  }
}
public void displayWinningMessage()
{
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c].setLabel(":)");
      }
    }
}
public boolean isValid(int r, int c)
{
    if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
    else
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
        if(isValid(row-1, col))
        {
            if(mines.contains(buttons[row-1][col]))
                numMines++;
        }
        if(isValid(row-1, col-1))
        {
            if(mines.contains(buttons[row-1][col-1]))
                numMines++;
        }
        if(isValid(row-1, col+1))
        {
            if(mines.contains(buttons[row-1][col+1]))
                numMines++;
        }
        if(isValid(row, col+1))
        {
            if(mines.contains(buttons[row][col+1]))
                numMines++;
        }
        if(isValid(row, col-1))
        {
            if(mines.contains(buttons[row][col-1]))
                numMines++;
        }
        if(isValid(row+1, col-1))
        {
            if(mines.contains(buttons[row+1][col-1]))
                numMines++;
        }
        if(isValid(row+1, col+1))
        {
            if(mines.contains(buttons[row+1][col+1]))
                numMines++;
        }
        if(isValid(row+1, col))
        {
            if(mines.contains(buttons[row+1][col]))
                numMines++;
        }
        
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton ==RIGHT){
          flagged = !flagged;
          if(flagged == false){
            clicked = false;
          }
        }
          else if(mines.contains(this)){
            displayLosingMessage();
          }
          else if(countMines(myRow,myCol) > 0){
            setLabel(countMines(myRow,myCol));
          }
          else{
            for(int r = myRow-1; r < myRow+2; r++){
              for(int c = myCol-1; c < myCol+2; c++){
                if(isValid(r,c) && buttons[r][c].clicked == false){
                  buttons[r][c].mousePressed();
            }
          }
        }
      } 
    }
    public void draw () 
    {    
        if (flagged)
            fill(0,255,0);
         else if( clicked && mines.contains(this) ) 
              fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
