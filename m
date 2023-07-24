Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E31675EAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGXFIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGXFHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:07:39 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC85CE59;
        Sun, 23 Jul 2023 22:07:34 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 3BE3982CF;
        Mon, 24 Jul 2023 05:07:32 +0000 (UTC)
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
Subject: [PATCH v4 3/3] serial: core: Fix serial core controller port name to show controller id
Date:   Mon, 24 Jul 2023 08:07:05 +0300
Message-ID: <20230724050709.17544-4-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724050709.17544-1-tony@atomide.com>
References: <20230724050709.17544-1-tony@atomide.com>
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
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 34 ++++++++++++++++++----------
 1 file changed, 22 insertions(+), 12 deletions(-)

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
@@ -61,12 +70,17 @@ static int serial_base_device_init(struct uart_port *port,
 		return -EPROBE_DEFER;
 	}
 
-	return dev_set_name(dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
-}
+	if (type == &serial_ctrl_type)
+		return dev_set_name(dev, "%s.%s.%d", type->name,
+				    dev_name(port->dev), ctrl_id);
 
-static const struct device_type serial_ctrl_type = {
-	.name = "ctrl",
-};
+	if (type == &serial_port_type)
+		return dev_set_name(dev, "%s.%s.%d.%d", type->name,
+				    dev_name(port->dev), ctrl_id,
+				    port_id);
+
+	return -EINVAL;
+}
 
 static void serial_base_ctrl_release(struct device *dev)
 {
@@ -96,7 +110,7 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
 	err = serial_base_device_init(port, &ctrl_dev->dev,
 				      parent, &serial_ctrl_type,
 				      serial_base_ctrl_release,
-				      port->ctrl_id);
+				      port->ctrl_id, 0);
 	if (err)
 		goto err_put_device;
 
@@ -112,10 +126,6 @@ struct serial_ctrl_device *serial_base_ctrl_add(struct uart_port *port,
 	return ERR_PTR(err);
 }
 
-static const struct device_type serial_port_type = {
-	.name = "port",
-};
-
 static void serial_base_port_release(struct device *dev)
 {
 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
@@ -136,7 +146,7 @@ struct serial_port_device *serial_base_port_add(struct uart_port *port,
 	err = serial_base_device_init(port, &port_dev->dev,
 				      &ctrl_dev->dev, &serial_port_type,
 				      serial_base_port_release,
-				      port->port_id);
+				      port->ctrl_id, port->port_id);
 	if (err)
 		goto err_put_device;
 
-- 
2.41.0
