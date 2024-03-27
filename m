Return-Path: <linux-kernel+bounces-120716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CF688DBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D929B1F2CA74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212B535AD;
	Wed, 27 Mar 2024 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="or3UZQaQ"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B93A1DF;
	Wed, 27 Mar 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537448; cv=none; b=NbquMz/i6e8bxbqXuoA/JlfQvBNeARi0NZT1ki6jnroasFTEpBh3M3X+iOiMn3gWIPOId/HeKjn0A8MWlPX80II/MtFSjU6sG9ltFY3ASdABwsoTNkgNAfcS5JVh+hq4i2DXKhdZtSjetS33s6NlH214YMjC4YlhWxnCYGjcfPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537448; c=relaxed/simple;
	bh=Nq4W15qk5Qscu+9QrbTPKtZJVzvCRtdBGJRUbYT6ECg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYNrSdUEfs2LHrTi4HO0BluDT64W4vpjsb3zkgw2e0U3LiHyJV8vgTYUbhTSBFkV3m+GemKO9aDkBqgF3DJ+zwWAb67pqOYrKY0mQgvZ1rieztRahiwlLgLjzF+Cj+lwQed75HT4Vo0wQfL5NMbEftLLaIgpIqwmt6w3nr3CKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=or3UZQaQ; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 2EF22604C8;
	Wed, 27 Mar 2024 11:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711537446;
	bh=Nq4W15qk5Qscu+9QrbTPKtZJVzvCRtdBGJRUbYT6ECg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=or3UZQaQXCTSAg6itVzTcpMshcMzB8BNvzp+ZmgWm79XL4ofyGmqIYS6bJN54lro+
	 McWe4f+Up+SXk5sPlHcHFyMgCEzGe8G7XJjsofCAz9eptD7YFoBIpevTAiuu5hP40F
	 O+hO7NLcuCR+gMXxRGes+CLpy/0yOiemXB7LR90xDhxma9MCM9r6wb7yh2miK6pgbo
	 claRmahXaoZ637jWpPHEdTaKU0fhQKc8QAB9K4c6lJwHBJqYskPCGfSgh+QPEwdeO/
	 YzINE8UylyoTRZRuTvwzQFN11aKO/YPgYz/vOFbP1gtTm6k4KI4rC42vubrBIB8N8n
	 TXbYrhaHZS1HA==
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
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
	linux-serial@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v7 4/7] serial: core: Add support for DEVNAME:0.0 style naming for kernel console
Date: Wed, 27 Mar 2024 12:59:38 +0200
Message-ID: <20240327110021.59793-5-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327110021.59793-1-tony@atomide.com>
References: <20240327110021.59793-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
character device name.

Note that when using console=DEVNAME:0.0 style kernel command line, the
8250 serial console gets enabled later compared to using console=ttyS
naming for ISA ports. This is because the serial port DEVNAME to character
device mapping is not known until the serial driver probe time. If used
together with earlycon, this issue is avoided.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_base.h     | 16 +++++++
 drivers/tty/serial/serial_base_bus.c | 66 ++++++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |  4 ++
 3 files changed, 86 insertions(+)

diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -45,3 +45,19 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
 
 int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
+
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+
+int serial_base_add_preferred_console(struct uart_driver *drv,
+				      struct uart_port *port);
+
+#else
+
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
@@ -8,6 +8,7 @@
  * The serial core bus manages the serial core controller instances.
  */
 
+#include <linux/cleanup.h>
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/idr.h>
@@ -204,6 +205,71 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
 	put_device(&port_dev->dev);
 }
 
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+
+static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
+				       int port_id)
+{
+	int ret;
+
+	ret = add_preferred_console_match(match, dev_name, port_id);
+	if (ret == -ENOENT)
+		return 0;
+
+	return ret;
+}
+
+static int serial_base_add_prefcon(const char *name, int idx)
+{
+	const char *char_match __free(kfree) = NULL;
+
+	/* Handle the traditional character device name style console=ttyS0 */
+	char_match = kasprintf(GFP_KERNEL, "%s%i", name, idx);
+	if (!char_match)
+		return -ENOMEM;
+
+	return serial_base_add_one_prefcon(char_match, name, idx);
+}
+
+/**
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
+ * Cannot be called early for ISA ports, depends on struct device.
+ *
+ * Note that duplicates are ignored by add_preferred_console().
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int serial_base_add_preferred_console(struct uart_driver *drv,
+				      struct uart_port *port)
+{
+	const char *port_match __free(kfree) = NULL;
+	int ret;
+
+	ret = serial_base_add_prefcon(drv->dev_name, port->line);
+	if (ret)
+		return ret;
+
+	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
+			       port->ctrl_id, port->port_id);
+	if (!port_match)
+		return -ENOMEM;
+
+	/* Translate a hardware addressing style console=DEVNAME:0.0 */
+	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
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
@@ -3407,6 +3407,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
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
2.44.0

