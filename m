Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D2804B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbjLEHgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:36:04 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53094C9;
        Mon,  4 Dec 2023 23:36:11 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id C124C60354;
        Tue,  5 Dec 2023 07:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701761770;
        bh=fXSH3oMsVEjAG6Eqr9C167WFqrDgpOZtF9UGQTqSwU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfOVSwKV+A03I7NcIu++5eksbifygpC+AGE8AH7L/hcrmxSYUyUxqCRGQzrZuG+D9
         yMWaHvnJDLDgzb+9gZbeorWy2I7T1+gHnUPr4oPy6AwZ2mJFK3U6fOFkTdhv+useMZ
         TIk4XA+NoO80oiaqyj59Qs6WnpiuB31TWWC+vRM+UXzgzHrfbsOisucKxIrHfQZ1T7
         crXax9KkFI5IiZ/EfRYbp046VCSnvRjO+ptPcjgypTSynnohWD2AfFSyrCysJZd7b9
         zpqMDOffXNue7nlh907Tedjh4LYVNPEyi6ifksOhUC0qGyUHBF8Da3Bpp4xqF3q8uk
         hxCt+oSeruevg==
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
Subject: [PATCH v4 4/4] serial: 8250: Add preferred console in serial8250_isa_init_ports()
Date:   Tue,  5 Dec 2023 09:32:36 +0200
Message-ID: <20231205073255.20562-5-tony@atomide.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205073255.20562-1-tony@atomide.com>
References: <20231205073255.20562-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare 8250 isa ports to drop kernel command line serial console
handling from console_setup().

We need to set the preferred console in serial8250_isa_init_ports().
Otherwise the console gets initialized only later on when the hardware
specific driver takes over, and console_setup() is no longer handling
the ttyS related quirks.

Note that this mostly affects x86 as this happens based on define
SERIAL_PORT_DFNS.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_core.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
@@ -517,6 +518,35 @@ static struct uart_8250_port *serial8250_setup_port(int index)
 	return up;
 }
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+
+/*
+ * There is no struct device at this point, so let's not try to use
+ * serial_base_add_preferred_console().
+ */
+static void __init serial8250_isa_init_preferred_console(int idx)
+{
+	const char *name __free(kfree);
+	int ret;
+
+	name = kasprintf(GFP_KERNEL, "%s%i", serial8250_reg.dev_name, idx);
+	ret = add_preferred_console_match(name, serial8250_reg.dev_name, idx);
+	if (!ret || ret == -ENOENT)
+		return;
+
+	pr_err("Could not add preferred console for %s idx %i\n",
+	       serial8250_reg.dev_name, idx);
+}
+
+#else
+
+static inline void serial8250_isa_init_preferred_console(struct uart_port *port,
+							 int idx)
+{
+}
+
+#endif
+
 static void __init serial8250_isa_init_ports(void)
 {
 	struct uart_8250_port *up;
@@ -563,6 +593,8 @@ static void __init serial8250_isa_init_ports(void)
 		port->irqflags |= irqflag;
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(i, &up->port, &up->capabilities);
+
+		serial8250_isa_init_preferred_console(i);
 	}
 }
 
-- 
2.43.0
