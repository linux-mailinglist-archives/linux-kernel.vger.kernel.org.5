Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62E760996
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjGYFnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjGYFmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:42:53 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DF301FC1;
        Mon, 24 Jul 2023 22:42:45 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 841038176;
        Tue, 25 Jul 2023 05:42:42 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 3/3] serial: core: Fix serial core controller port name to show controller id
Date:   Tue, 25 Jul 2023 08:42:12 +0300
Message-ID: <20230725054216.45696-4-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725054216.45696-1-tony@atomide.com>
References: <20230725054216.45696-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are missing the serial core controller id for the serial core port
name. Let's fix the issue for sane sysfs output, and to avoid issues
addressing serial ports later on.

And as we're now showing the controller id, the "ctrl" and "port" prefix
for the DEVNAME become useless, we can just drop them. Let's standardize on
DEVNAME:0 for controller name, where 0 is the controller id. And
DEVNAME:0.0 for port name, where 0.0 are the controller id and port id.

This makes the sysfs output nicer, on qemu for example:

$ ls /sys/bus/serial-base/devices
00:04:0         serial8250:0    serial8250:0.2
00:04:0.0       serial8250:0.1  serial8250:0.3

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Andy, I kept your Reviewed-by although I updated the device naming and
description, does the patch still look OK to you?

---
 drivers/tty/serial/serial_base_bus.c | 32 +++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -19,6 +19,14 @@
 
 static bool serial_base_initialized;
 
+static const struct device_type serial_ctrl_type = {
+	.name = "ctrl",
+};
+
+static const struct device_type serial_port_type = {
+	.name = "port",
+};
+
 static int serial_base_match(struct device *dev, struct device_driver *drv)
 {
 	int len = strlen(drv->name);
@@ -48,7 +56,8 @@ static int serial_base_device_init(struct uart_port *port,
 				   struct device *parent_dev,
 				   const struct device_type *type,
 				   void (*release)(struct device *dev),
-				   int id)
+				   unsigned int ctrl_id,
+				   unsigned int port_id)
 {
 	device_initialize(dev);
 	dev->type = type;
@@ -61,13 +70,16 @@ static int serial_base_device_init(struct uart_port *port,
 		return -EPROBE_DEFER;
 	}
 
-	return dev_set_name(dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
+	if (type == &serial_ctrl_type)
+		return dev_set_name(dev, "%s:%d", dev_name(port->dev), ctrl_id);
+
+	if (type == &serial_port_type)
+		return dev_set_name(dev, "%s:%d.%d", dev_name(port->dev),
+				    ctrl_id, port_id);
+
+	return -EINVAL;
 }
 
-static const struct device_type serial_ctrl_type = {
-	.name = "ctrl",
-};
-
 static void serial_base_ctrl_release(struct device *dev)
 {
 	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
@@ -96,7 +108,7 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
 	err = serial_base_device_init(port, &ctrl_dev->dev,
 				      parent, &serial_ctrl_type,
 				      serial_base_ctrl_release,
-				      port->ctrl_id);
+				      port->ctrl_id, 0);
 	if (err)
 		goto err_put_device;
 
@@ -112,10 +124,6 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
 	return ERR_PTR(err);
 }
 
-static const struct device_type serial_port_type = {
-	.name = "port",
-};
-
 static void serial_base_port_release(struct device *dev)
 {
 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
@@ -136,7 +144,7 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->port_id);
+				      port->ctrl_id, port->port_id);
 	if (err)
 		goto err_put_device;
 
-- 
2.41.0
