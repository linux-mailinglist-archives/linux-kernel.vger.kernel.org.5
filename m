Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A5076CC02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjHBLs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjHBLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:48:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED6F8213D;
        Wed,  2 Aug 2023 04:48:54 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2673E80AE;
        Wed,  2 Aug 2023 11:48:51 +0000 (UTC)
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
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] serial: core: Fix serial_base_match() after fixing controller port name
Date:   Wed,  2 Aug 2023 14:48:43 +0300
Message-ID: <20230802114846.21899-1-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
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

While fixing DEVNAME to be more usable, I broke serial_base_match() as
the ctrl and port prefix for device seemed unnecessary.

Let's fix the issue by checking against dev->type and drv->name.

Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base.h     |  3 +++
 drivers/tty/serial/serial_base_bus.c | 10 ++++++++--
 drivers/tty/serial/serial_ctrl.c     |  2 +-
 drivers/tty/serial/serial_port.c     |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -6,6 +6,9 @@
  * Author: Tony Lindgren <tony@atomide.com>
  */
 
+#define SERIAL_BASE_CTRL_NAME	"ctrl"
+#define SERIAL_BASE_PORT_NAME	"port"
+
 #define to_serial_base_ctrl_device(d) container_of((d), struct serial_ctrl_device, dev)
 #define to_serial_base_port_device(d) container_of((d), struct serial_port_device, dev)
 
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -29,9 +29,15 @@ static const struct device_type serial_port_type = {
 
 static int serial_base_match(struct device *dev, struct device_driver *drv)
 {
-	int len = strlen(drv->name);
+	if (dev->type == &serial_ctrl_type &&
+	    !strncmp(SERIAL_BASE_CTRL_NAME, drv->name, 4))
+		return 1;
 
-	return !strncmp(dev_name(dev), drv->name, len);
+	if (dev->type == &serial_port_type &&
+	    !strncmp(SERIAL_BASE_PORT_NAME, drv->name, 4))
+		return 1;
+
+	return 0;
 }
 
 static struct bus_type serial_base_bus_type = {
diff --git a/drivers/tty/serial/serial_ctrl.c b/drivers/tty/serial/serial_ctrl.c
--- a/drivers/tty/serial/serial_ctrl.c
+++ b/drivers/tty/serial/serial_ctrl.c
@@ -47,7 +47,7 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
 }
 
 static struct device_driver serial_ctrl_driver = {
-	.name = "ctrl",
+	.name = SERIAL_BASE_CTRL_NAME,
 	.suppress_bind_attrs = true,
 	.probe = serial_ctrl_probe,
 	.remove = serial_ctrl_remove,
diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -83,7 +83,7 @@ void uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
 EXPORT_SYMBOL(uart_remove_one_port);
 
 static struct device_driver serial_port_driver = {
-	.name = "port",
+	.name = SERIAL_BASE_PORT_NAME,
 	.suppress_bind_attrs = true,
 	.probe = serial_port_probe,
 	.remove = serial_port_remove,
-- 
2.41.0
