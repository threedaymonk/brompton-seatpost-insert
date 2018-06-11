// Brompton seatpost height insert

height = 45; // Desired reduction in seatpost height from maximum extent
slack = 0.1; // Increase this to let the seatpost slide more freely

inner_diameter = 31.8 + slack;
outer_diameter = 35.0 - slack;
wall = (outer_diameter - inner_diameter) / 2;
tab_width = 6 - slack;
tab_height = 24;
clip_height = 11;
clip_depth = 2;
tab_depth = (outer_diameter - inner_diameter) / 2;

$fa = 0.5;
$fs = 0.5;
$e = 0.001;

difference() {
  // Main cylinder
  cylinder(r=outer_diameter / 2, h=height + tab_height);
  translate([0, 0, -$e])
    cylinder(r=inner_diameter / 2, h=height + tab_height + 2*$e);

  // Cut out a quarter to facilitate movement
  rotate([0, 0, 225], v = [0, 0, 0]) {
    translate([0, 0, -$e])
      cube([outer_diameter, outer_diameter, height + tab_height + 2*$e]);
  }

  // Cut away shoulders to leave tab
  for (a = [0, 180]) {
    rotate([0, 0, a], v = [0, 0, 0]) {
      translate([tab_width / 2, -(outer_diameter / 2 + $e), height])
        cube([outer_diameter + 2*$e, outer_diameter + 2*$e, tab_height + $e]);
    }
  }
}

// Clip on top of tab
hull() {
  translate([-tab_width / 2, outer_diameter / 2 - wall / 2, height + tab_height - $e])
    cube([tab_width, wall, $e]);

  translate([0, outer_diameter / 2 - wall / 2, height + tab_height - clip_height + tab_width / 2])
    rotate([-90, 0, 0])
      cylinder(r = tab_width / 2, h = clip_depth + wall / 2);
}
