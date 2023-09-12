Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710E779CF29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjILLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjILLEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:04:31 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72DFF10E2;
        Tue, 12 Sep 2023 04:04:27 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 461AF80FC;
        Tue, 12 Sep 2023 11:04:25 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 3/3] serial: core: Add sysfs links for serial core port instances for ttys
Date:   Tue, 12 Sep 2023 14:03:45 +0300
Message-ID: <20230912110350.14482-4-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912110350.14482-1-tony@atomide.com>
References: <20230912110350.14482-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's allow the userspace to find out the ttyS style name for a serial
core port device if a tty exists. This can be done with:

$ grep DEVNAME /sys/bus/serial-base/devices/*/tty/uevent
/sys/bus/serial-base/devices/00:04:0.0/tty/uevent:DEVNAME=ttyS0
/sys/bus/serial-base/devices/serial8250:0.1/tty/uevent:DEVNAME=ttyS1
/sys/bus/serial-base/devices/serial8250:0.2/tty/uevent:DEVNAME=ttyS2
/sys/bus/serial-base/devices/serial8250:0.3/tty/uevent:DEVNAME=ttyS3

With this change, we can add /dev/serial/by-id symlinks for the serial
core port device instances. This allows using hardware based port
addressing in addition to the legacy ttyS style naming.

The serial core port naming is DEVNAME:0.0, such as the 00:04:0.0 above.
The 0.0 above are serial core controller id and port id. The port id and
controller id are typically both zero unless the serial port hardware
controller has multiple controllers or ports.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3328,6 +3328,8 @@ static int serial_core_port_device_add(struct serial_ctrl_device *ctrl_dev,
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct serial_ctrl_device *ctrl_dev, *new_ctrl_dev = NULL;
+	struct uart_match match = {port, drv};
+	struct device *tty_dev;
 	int ret;
 
 	mutex_lock(&port_mutex);
@@ -3368,10 +3370,22 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 
 	port->flags &= ~UPF_DEAD;
 
+	tty_dev = device_find_child(port->dev, &match, serial_match_port);
+	if (tty_dev) {
+		ret = sysfs_create_link(&port->port_dev->dev.kobj, &tty_dev->kobj,
+					"tty");
+		put_device(tty_dev);
+		if (ret)
+			goto err_remove_port;
+	}
+
 	mutex_unlock(&port_mutex);
 
 	return 0;
 
+err_remove_port:
+	serial_core_remove_one_port(drv, port);
+
 err_unregister_port_dev:
 	serial_base_port_device_remove(port->port_dev);
 
@@ -3393,12 +3407,20 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
 	struct device *phys_dev = port->dev;
 	struct serial_port_device *port_dev = port->port_dev;
 	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+	struct uart_match match = {port, drv};
 	int ctrl_id = port->ctrl_id;
+	struct device *tty_dev;
 
 	mutex_lock(&port_mutex);
 
 	port->flags |= UPF_DEAD;
 
+	tty_dev = device_find_child(port->dev, &match, serial_match_port);
+	if (tty_dev) {
+		sysfs_remove_link(&port->port_dev->dev.kobj, "tty");
+		put_device(tty_dev);
+	}
+
 	serial_core_remove_one_port(drv, port);
 
 	/* Note that struct uart_port *port is no longer valid at this point */
-- 
2.42.0
