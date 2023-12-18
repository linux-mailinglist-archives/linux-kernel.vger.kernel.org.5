Return-Path: <linux-kernel+bounces-3088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C11816732
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42892280D21
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3879EB;
	Mon, 18 Dec 2023 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="ndXogUuI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3CF9C1;
	Mon, 18 Dec 2023 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id D2F55603E6;
	Mon, 18 Dec 2023 07:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1702883696;
	bh=uFBmtVSwmPLt0wPwCU7cDBhUtKLWh7AsC+S0n1T9l/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndXogUuI9gQ7MSv6nnSm1nCRDOfn6//M3fDHZ9Es31/TLhdgyzB+yBP6CQCIZkIu+
	 XBth8x4UXUpkjKSP7L8cIqrasBtGg4Lq4j4sPBBeHkCb3v9QDJNQQcH4+0cUxAla0T
	 roX1oaGQTsKMmAj684PhtrcVk6PyqNC0W7j0HEnvQVRS5axIPycRcev3wMw1W8CGVw
	 q7/zLsBaAq8+fJ6o9vKHvVJDZxhnpO+HJoN/Bz+xpgRwmJOAnb9fnhUGk/avqMzrjb
	 bCZtBNopPhwfWTqLwHvKOgtS6nomMifunZQLFHgT5Z6dJPPnMLGflp3Pu6NP2J7V24
	 3x8UttRCCFxFQ==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH v5 6/6] serial: 8250: Add preferred console in serial8250_isa_init_ports()
Date: Mon, 18 Dec 2023 09:09:53 +0200
Message-ID: <20231218071020.21805-7-tony@atomide.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218071020.21805-1-tony@atomide.com>
References: <20231218071020.21805-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare 8250 ISA ports to drop kernel command line serial console
handling from console_setup().

We need to set the preferred console in serial8250_isa_init_ports()
to drop a dependency to setup_console() handling the ttyS related
quirks. Otherwise when console_setup() handles the ttyS related
options, console gets enabled only at driver probe time.

Note that this mostly affects x86 as this happens based on define
SERIAL_PORT_DFNS.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/8250/8250_core.c  |  5 +++++
 drivers/tty/serial/serial_base.h     |  8 ++++++++
 drivers/tty/serial/serial_base_bus.c | 21 +++++++++++++++++++++
 3 files changed, 34 insertions(+)

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
@@ -41,6 +42,8 @@
 
 #include <asm/irq.h>
 
+#include "../serial_base.h"	/* For serial_base_add_isa_preferred_console() */
+
 #include "8250.h"
 
 /*
@@ -563,6 +566,8 @@ static void __init serial8250_isa_init_ports(void)
 		port->irqflags |= irqflag;
 		if (serial8250_isa_config != NULL)
 			serial8250_isa_config(i, &up->port, &up->capabilities);
+
+		serial_base_add_isa_preferred_console(serial8250_reg.dev_name, i);
 	}
 }
 
diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -51,6 +51,8 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
 int serial_base_add_preferred_console(struct uart_driver *drv,
 				      struct uart_port *port);
 
+int serial_base_add_isa_preferred_console(const char *name, int idx);
+
 #else
 
 static inline
@@ -60,4 +62,10 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 	return 0;
 }
 
+static inline
+int serial_base_add_isa_preferred_console(const char *name, int idx)
+{
+	return 0;
+}
+
 #endif
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -317,6 +317,27 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
 	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
 }
 
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+
+/*
+ * Early ISA ports initialize the console before there is no struct device.
+ * This should be only called from serial8250_isa_init_preferred_console(),
+ * other callers are likely wrong and should rely on earlycon instead.
+ */
+int serial_base_add_isa_preferred_console(const char *name, int idx)
+{
+	return serial_base_add_prefcon(name, idx);
+}
+
+#else
+
+int serial_base_add_isa_preferred_console(const char *name, int idx)
+{
+	return 0;
+}
+
+#endif
+
 #endif
 
 static int serial_base_init(void)
-- 
2.43.0

