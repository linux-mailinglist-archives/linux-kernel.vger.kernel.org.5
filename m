Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880517F2BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjKULdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjKULdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:33:02 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2DA9CA;
        Tue, 21 Nov 2023 03:32:57 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B942D80CC;
        Tue, 21 Nov 2023 11:32:54 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 2/3] serial: core: Add support for DEVNAME:0.0 style naming for kernel console
Date:   Tue, 21 Nov 2023 13:31:56 +0200
Message-ID: <20231121113203.61341-3-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121113203.61341-1-tony@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now add hardware based addressing for serial ports. Starting with
commit 84a9582fd203 ("serial: core: Start managing serial controllers to
enable runtime PM"), and all the related fixes to this commit, the serial
core now knows to which serial port controller the ports are connected.

The serial ports can be addressed with DEVNAME:0.0 style naming. The names
are something like 00:04:0.0 for a serial port on qemu, and something like
2800000.serial:0.0 on platform device using systems like ARM64 for example.

The DEVNAME is the unique serial port hardware controller device name, AKA
the name for port->dev. The 0.0 are the serial core controller id and port
id.

Typically 0.0 are used for each controller and port instance unless the
serial port hardware controller has multiple controllers or ports.

Using DEVNAME:0.0 style naming actually solves two long term issues for
addressing the serial ports:

1. According to Andy Shevchenko, using DEVNAME:0.0 style naming fixes an
   issue where depending on the BIOS settings, the kernel serial port ttyS
   instance number may change if HSUART is enabled

2. Device tree using architectures no longer necessarily need to specify
   aliases to find a specific serial port, and we can just allocate the
   ttyS instance numbers dynamically in whatever probe order

To do this, let's match the hardware addressing style console name to
the character device name used, and add a preferred console using the
character device device name.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base.h     | 14 ++++++++++
 drivers/tty/serial/serial_base_bus.c | 38 ++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |  4 +++
 3 files changed, 56 insertions(+)

diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -45,3 +45,17 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
 
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
+
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+
+int serial_base_add_preferred_console(struct uart_driver *drv,
+				      struct uart_port *port);
+#else
+static inline
+int serial_base_add_preferred_console(struct uart_driver *drv,
+				      struct uart_port *port)
+{
+	return 0;
+}
+
+#endif
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -204,6 +204,44 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 	put_device(&port_dev->dev);
 }
 
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+
+/*
+ * serial_base_add_preferred_console - Adds a preferred console
+ * @drv: Serial port device driver
+ * @port: Serial port instance
+ *
+ * Tries to add a preferred console for a serial port if specified in the
+ * kernel command line. Supports both the traditional character device such
+ * as console=ttyS0, and a hardware addressing based console=DEVNAME:0.0
+ * style name.
+ *
+ * Translates the kernel command line option using a hardware based addressing
+ * console=DEVNAME:0.0 to the serial port character device such as ttyS0.
+ *
+ * Note that duplicates are ignored by add_preferred_console().
+ */
+int serial_base_add_preferred_console(struct uart_driver *drv,
+				      struct uart_port *port)
+{
+	const char *port_match __free(kfree);
+	int ret;
+
+	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
+			       port->ctrl_id, port->port_id);
+	if (!port_match)
+		return -ENOMEM;
+
+	/* Translate a hardware addressing style console=DEVNAME:0.0 */
+	ret = add_preferred_console_match(port_match, drv->dev_name, port->line);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	return 0;
+}
+
+#endif
+
 static int serial_base_init(void)
 {
 	int ret;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3359,6 +3359,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 	if (ret)
 		goto err_unregister_ctrl_dev;
 
+	ret = serial_base_add_preferred_console(drv, port);
+	if (ret)
+		goto err_unregister_port_dev;
+
 	ret = serial_core_add_one_port(drv, port);
 	if (ret)
 		goto err_unregister_port_dev;
-- 
2.42.1
