Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71C7770D4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjHJG5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHJG5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:57:49 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EB1810C0;
        Wed,  9 Aug 2023 23:57:49 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 39DB180A9;
        Thu, 10 Aug 2023 06:57:47 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] serial: core: Fix serial core port id, including multiport devices
Date:   Thu, 10 Aug 2023 09:57:34 +0300
Message-ID: <20230810065737.47294-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to fix the serial core port DEVNAME to use a port id of the
hardware specific controller port instance instead of the port->line.

For example, the 8250 driver sets up a number of serial8250 ports
initially that can be inherited by the hardware specific driver. At that
the port->line no longer decribes the port's relation to the serial core
controller instance.

Let's fix the issue by assigning port->port_id for each serial core
controller port instance.

Fixes: 7d695d83767c ("serial: core: Fix serial_base_match() after fixing controller port name")
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base.h     |  1 +
 drivers/tty/serial/serial_base_bus.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -16,6 +16,7 @@ struct device;
 
 struct serial_ctrl_device {
 	struct device dev;
+	struct ida port_ida;
 };
 
 struct serial_port_device {
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -10,6 +10,7 @@
 
 #include <linux/container_of.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
@@ -112,6 +113,8 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
 	if (!ctrl_dev)
 		return ERR_PTR(-ENOMEM);
 
+	ida_init(&ctrl_dev->port_ida);
+
 	err = serial_base_device_init(port, &ctrl_dev->dev,
 				      parent, &serial_ctrl_type,
 				      serial_base_ctrl_release,
@@ -142,16 +145,31 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 						struct serial_ctrl_device *ctrl_dev)
 {
 	struct serial_port_device *port_dev;
+	unsigned int min = 0, max = ~0U;
 	int err;
 
 	port_dev = kzalloc(sizeof(*port_dev), GFP_KERNEL);
 	if (!port_dev)
 		return ERR_PTR(-ENOMEM);
 
+	/* Device driver specified port_id vs automatic assignment? */
+	if (port->port_id) {
+		min = port->port_id;
+		max = port->port_id;
+	}
+
+	err = ida_alloc_range(&ctrl_dev->port_ida, min, max, GFP_KERNEL);
+	if (err < 0) {
+		kfree(port_dev);
+		return ERR_PTR(err);
+	}
+
+	port->port_id = err;
+
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->ctrl_id, port->line);
+				      port->ctrl_id, port->port_id);
 	if (err)
 		goto err_put_device;
 
@@ -165,16 +183,24 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 
 err_put_device:
 	put_device(&port_dev->dev);
+	ida_free(&ctrl_dev->port_ida, port->port_id);
 
 	return ERR_PTR(err);
 }
 
 void serial_base_port_device_remove(struct serial_port_device *port_dev)
 {
+	struct serial_ctrl_device *ctrl_dev;
+	struct device *parent;
+
 	if (!port_dev)
 		return;
 
+	parent = port_dev->dev.parent;
+	ctrl_dev = to_serial_base_ctrl_device(parent);
+
 	device_del(&port_dev->dev);
+	ida_free(&ctrl_dev->port_ida, port_dev->port->port_id);
 	put_device(&port_dev->dev);
 }
 
-- 
2.41.0
