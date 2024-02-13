Return-Path: <linux-kernel+bounces-63156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD924852BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347AFB22D92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF771B59C;
	Tue, 13 Feb 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="mcaoHpsk"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5C225AC;
	Tue, 13 Feb 2024 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814212; cv=none; b=fjaS85tU3o5kDc6lZQx5zV/cBO1UMKocS7I9mSOSxCzzfu5j+xsA6IczKPA67q9sGYnbg63U/e9zU5R2ZLi2mCcWPUvF8iGRMnXgXn8ybx3AcBPExmq0b+l7+pEQpStYW10WbhdPVvWAwjJzeH7cQ9lGBRnIe7x9kxfV8CpvZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814212; c=relaxed/simple;
	bh=9k7N7FYP2C1sLmo1nycrn7Te4UNF5x2lWFrdUPXOets=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h965mUfwugZM5sRzg7h/Ugh73D5tbwc+HpGtbMrsaDDKYik2SxRx+qa+cVB7DNk06INzo3C244Srn/mZObpgiq9rRTveUrPTEHXsjZbnkDsMflvseRd8cRCw/Aq/x9T/EUDHBUcsgrr9WVOu0gHpuk43pQY2NFDIvuJlM8GjIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=mcaoHpsk; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id D94BD60505;
	Tue, 13 Feb 2024 08:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707814209;
	bh=9k7N7FYP2C1sLmo1nycrn7Te4UNF5x2lWFrdUPXOets=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcaoHpskNQrJBnYqyHQp8P8XujBiM88xEhIADWFiHFzeZrE+6N7cphUuuVw3esTOz
	 X3S6Gtp2HxcZBWbqxisBRpqwCpgrLYQUPGhz0px7zAGXlOD1tNmvuD3jZX3V3T+Rsc
	 7jdpCcHIt8jvwO2nvXF6sWWrjyHA89jqUMjhZ+7AAXePpnXUt+99ycixjGLrHc0QlQ
	 bJQ0otdmPAEXoCVwbsTZgG+Ov4OtOT6WlhaIVLIL47B6emO1xjFRX9h85+Pha9OO8p
	 /wxvB1gzoZE1/bljAfT61k15a0nO1Dg3ceCFI89ZgP0BNxpLMwJoDrA6WBGEFwJaik
	 N3pHkFfCuGMVw==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 6/6] serial: 8250: Add preferred console in serial8250_isa_init_ports()
Date: Tue, 13 Feb 2024 10:45:13 +0200
Message-ID: <20240213084545.40617-7-tony@atomide.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213084545.40617-1-tony@atomide.com>
References: <20240213084545.40617-1-tony@atomide.com>
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
2.43.1

