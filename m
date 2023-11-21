Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF57F2BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjKULdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjKULdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:33:12 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5187511A;
        Tue, 21 Nov 2023 03:33:04 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 6933880CC;
        Tue, 21 Nov 2023 11:33:01 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v3 3/3] serial: core: Move console character device handling from printk
Date:   Tue, 21 Nov 2023 13:31:57 +0200
Message-ID: <20231121113203.61341-4-tony@atomide.com>
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

There's no need for console_setup() to try to figure out the console
character device name for serial ports early on before uart_add_one_port()
has been called. And for early debug console we have earlycon.

Let's handle the serial port specific commandline options in the serial
core subsystem and drop the handling from printk. The serial core
subsystem can just call add_preferred_console() when the serial port is
getting initialized.

Note that eventually we may want to set up driver specific console quirk
handling for the serial port device drivers to use. But we need to figure
out which driver(s) need to call the quirk. So for now, we just move the
sparc quirk and handle it directly.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base_bus.c | 66 ++++++++++++++++++++++++++++
 kernel/printk/printk.c               | 30 +------------
 2 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -206,6 +206,43 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 
+#ifdef __sparc__
+
+/* Handle Sparc ttya and ttyb options as done in console_setup() */
+static int serial_base_add_sparc_console(struct uart_driver *drv,
+					 struct uart_port *port)
+{
+	const char *name = NULL;
+	int ret;
+
+	switch (port->line) {
+	case 0:
+		name = "ttya";
+		break;
+	case 1:
+		name = "ttyb";
+		break;
+	default:
+		return 0;
+	}
+
+	ret = add_preferred_console_match(name, drv->dev_name, port->line);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	return 0;
+}
+
+#else
+
+static inline int serial_base_add_sparc_console(struct uart_driver *drv,
+						struct uart_port *port)
+{
+	return 0;
+}
+
+#endif
+
 /*
  * serial_base_add_preferred_console - Adds a preferred console
  * @drv: Serial port device driver
@@ -225,6 +262,8 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 				      struct uart_port *port)
 {
 	const char *port_match __free(kfree);
+	const char *char_match __free(kfree);
+	const char *nmbr_match __free(kfree);
 	int ret;
 
 	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
@@ -232,6 +271,33 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 	if (!port_match)
 		return -ENOMEM;
 
+	char_match = kasprintf(GFP_KERNEL, "%s%i", drv->dev_name, port->line);
+	if (!char_match)
+		return -ENOMEM;
+
+	/* Handle ttyS specific options */
+	if (!strncmp(drv->dev_name, "ttyS", 4)) {
+		/* No name, just a number */
+		nmbr_match = kasprintf(GFP_KERNEL, "%i", port->line);
+		if (!nmbr_match)
+			return -ENODEV;
+
+		ret = add_preferred_console_match(nmbr_match, drv->dev_name,
+						  port->line);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		/* Sparc ttya and ttyb */
+		ret = serial_base_add_sparc_console(drv, port);
+		if (ret)
+			return ret;
+	}
+
+	/* Handle the traditional character device name style console=ttyS0 */
+	ret = add_preferred_console_match(char_match, drv->dev_name, port->line);
+	if (ret && ret != -ENOENT)
+		return ret;
+
 	/* Translate a hardware addressing style console=DEVNAME:0.0 */
 	ret = add_preferred_console_match(port_match, drv->dev_name, port->line);
 	if (ret && ret != -ENOENT)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2438,9 +2438,7 @@ __setup("console_msg_format=", console_msg_format_setup);
  */
 static int __init console_setup(char *str)
 {
-	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
-	char *s, *options, *brl_options = NULL;
-	int idx;
+	char *brl_options = NULL;
 
 	/*
 	 * Save the console for possible driver subsystem use. Bail out early
@@ -2463,32 +2461,6 @@ static int __init console_setup(char *str)
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
-	/*
-	 * Decode str into name, index, options.
-	 */
-	if (str[0] >= '0' && str[0] <= '9') {
-		strcpy(buf, "ttyS");
-		strncpy(buf + 4, str, sizeof(buf) - 5);
-	} else {
-		strncpy(buf, str, sizeof(buf) - 1);
-	}
-	buf[sizeof(buf) - 1] = 0;
-	options = strchr(str, ',');
-	if (options)
-		*(options++) = 0;
-#ifdef __sparc__
-	if (!strcmp(str, "ttya"))
-		strcpy(buf, "ttyS0");
-	if (!strcmp(str, "ttyb"))
-		strcpy(buf, "ttyS1");
-#endif
-	for (s = buf; *s; s++)
-		if (isdigit(*s) || *s == ',')
-			break;
-	idx = simple_strtoul(s, NULL, 10);
-	*s = 0;
-
-	__add_preferred_console(buf, idx, options, brl_options, true);
 	return 1;
 }
 __setup("console=", console_setup);
-- 
2.42.1
