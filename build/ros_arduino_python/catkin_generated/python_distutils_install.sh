#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/turtlebot/mybot_ws/src/ros_arduino_bridge-indigo-devel/ros_arduino_python"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/turtlebot/mybot_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/turtlebot/mybot_ws/install/lib/python2.7/dist-packages:/home/turtlebot/mybot_ws/build/ros_arduino_python/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/turtlebot/mybot_ws/build/ros_arduino_python" \
    "/usr/bin/python" \
    "/home/turtlebot/mybot_ws/src/ros_arduino_bridge-indigo-devel/ros_arduino_python/setup.py" \
    build --build-base "/home/turtlebot/mybot_ws/build/ros_arduino_python" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/turtlebot/mybot_ws/install" --install-scripts="/home/turtlebot/mybot_ws/install/bin"
