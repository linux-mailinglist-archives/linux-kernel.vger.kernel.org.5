Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA39175A563
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGTFLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGTFK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:10:56 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83EFB269E;
        Wed, 19 Jul 2023 22:10:50 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3CF7D80F7;
        Thu, 20 Jul 2023 05:10:47 +0000 (UTC)
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
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] serial: core: Fix serial core controller port name to show controller id
Date:   Thu, 20 Jul 2023 08:10:16 +0300
Message-ID: <20230720051021.14961-4-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720051021.14961-1-tony@atomide.com>
References: <20230720051021.14961-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are missing the serial core controller id for the serial core port
name. Let's fix the issue for sane /sys/bus/serial-core/devices, and to
avoid issues addressing serial ports later on.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/linux-serial/20230719051613.46569-1-tony@atomide.com/T/#m0f358e91262f7f56198ba9d0a7100809e9e35cc5
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 33 ++++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

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
@@ -61,13 +70,17 @@ static int serial_base_device_init(struct uart_port *port,
 		return -EPROBE_DEFER;
 	}
 
-	return dev_set_name(dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
+	if (type == &serial_ctrl_type)
+		return dev_set_name(dev, "%s.%s.%d", type->name,
+				    dev_name(port->dev), ctrl_id);
+	else if (type == &serial_port_type)
+		return dev_set_name(dev, "%s.%s.%d.%d", type->name,
+				    dev_name(port->dev), ctrl_id,
+				    port_id);
+	else
+		return -EINVAL;
 }
 
-static const struct device_type serial_ctrl_type = {
-	.name = "ctrl",
-};
-
 static void serial_base_ctrl_release(struct device *dev)
 {
 	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
@@ -96,7 +109,7 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
 	err = serial_base_device_init(port, &ctrl_dev->dev,
 				      parent, &serial_ctrl_type,
 				      serial_base_ctrl_release,
-				      port->ctrl_id);
+				      port->ctrl_id, 0);
 	if (err)
 		goto err_put_device;
 
@@ -112,10 +125,6 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
 	return ERR_PTR(err);
 }
 
-static const struct device_type serial_port_type = {
-	.name = "port",
-};
-
 static void serial_base_port_release(struct device *dev)
 {
 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
@@ -136,7 +145,7 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->port_id);
+				      port->ctrl_id, port->port_id);
 	if (err)
 		goto err_put_device;
 
-- 
2.41.0
