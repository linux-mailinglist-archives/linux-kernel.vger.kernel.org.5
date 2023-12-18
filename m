Return-Path: <linux-kernel+bounces-3086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6381672D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6A28473E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A5079EB;
	Mon, 18 Dec 2023 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="IeO0O+dn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89E101C6;
	Mon, 18 Dec 2023 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 71184603E6;
	Mon, 18 Dec 2023 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1702883624;
	bh=bSmbXIJ73bHNYUg5aFssz2mBLov16AXD7w083cyelF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeO0O+dnZdE8whIwAdpQZzbZ2n64X6V27A73sQvf+fQXEZPZMUegEKlHcPIDlxJs6
	 cb1d8XRPf2Hnj55YoLrMW/K0Fxs8KPTF49lZNzb7DV2g13sUzh8Bvz5Sk1SR2AqevS
	 IhQ9fBlAUW2B/IMVs/MeskbWc37ybdQ5m/d2A7yQ0af1KyZ4B+Xl768GlXlxA0XQfD
	 JLp5sjwylgg9zBYMVFR0BCBdPYYDusxKhKhorgfWtMhl/8MJjB/rzSmevJQCdVG2oB
	 1H0b0cDEd+YpKk50DTfnKY4SJogjDNKSfJsOsUoVE29PCZoj3GaPR3SJOQpAbRiVzu
	 IJOqTEZLqCvTQ==
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
Subject: [RFC PATCH v5 4/6] serial: core: Add support for DEVNAME:0.0 style naming for kernel console
Date: Mon, 18 Dec 2023 09:09:51 +0200
Message-ID: <20231218071020.21805-5-tony@atomide.com>
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
+	const char *port_match __free(kfree);
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
@@ -3358,6 +3358,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
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
2.43.0

