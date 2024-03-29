Return-Path: <linux-kernel+bounces-125271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E2892325
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF7282FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFB6137742;
	Fri, 29 Mar 2024 18:07:23 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFD1C0DC2;
	Fri, 29 Mar 2024 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735642; cv=none; b=lyK1mNE+QELei9n2nLrKHbsyO4InAkDRt+eODRPGNkLO1rksSqL3ZAaYDjUA9yT7G+vP9Sx6TP2g75yctN5QhOEp2jqIwAA560qqBTBi7WpSBm3gzJ/JzxXp4oytGnC2EFqruqGWOmploLKvEN7RkfE1dt4DCG1k6hjg5bz9jsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735642; c=relaxed/simple;
	bh=hSBJ9UIGseVTgL10Ws4lmaYZism0F9VDtcJjqtKXHCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fewv/dJor8o1zKEmNjXdeH9RJ/mhf0R5fyhF4qB0dQTu1tZKa01lAA4paJLP+eQnlKv4igEhn09JmqYklhJ8TWWwC2LrA62NpHL+rqbmhNZCz5lbOBJXlhByOC7e49YRwfCVvH+XVhpOORZENgALET8G19ZyYhLzK7b9Ikh8p8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.19] (port=62484 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rqGdE-00028Q-4m;
	Fri, 29 Mar 2024 21:07:12 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1106.mail.hosting.nic.ru (Exim 5.55)
	with id 1rqGdE-0056fM-1C;
	Fri, 29 Mar 2024 21:07:12 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] serial: core: use sysfs_emit() in sysfs show handlers
Date: Fri, 29 Mar 2024 21:06:34 +0300
Message-Id: <20240329180634.1037706-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

Change sprintf() in sysfs show() handlers to sysfs_emit(),
as recommended by sysfs documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 drivers/tty/serial/serial_core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ff85ebd3a007..a80b6aab2d98 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2903,7 +2903,7 @@ static ssize_t uartclk_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.baud_base * 16);
+	return sysfs_emit(buf, "%d\n", tmp.baud_base * 16);
 }
 
 static ssize_t type_show(struct device *dev,
@@ -2913,7 +2913,7 @@ static ssize_t type_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.type);
+	return sysfs_emit(buf, "%d\n", tmp.type);
 }
 
 static ssize_t line_show(struct device *dev,
@@ -2923,7 +2923,7 @@ static ssize_t line_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.line);
+	return sysfs_emit(buf, "%d\n", tmp.line);
 }
 
 static ssize_t port_show(struct device *dev,
@@ -2937,7 +2937,7 @@ static ssize_t port_show(struct device *dev,
 	ioaddr = tmp.port;
 	if (HIGH_BITS_OFFSET)
 		ioaddr |= (unsigned long)tmp.port_high << HIGH_BITS_OFFSET;
-	return sprintf(buf, "0x%lX\n", ioaddr);
+	return sysfs_emit(buf, "0x%lX\n", ioaddr);
 }
 
 static ssize_t irq_show(struct device *dev,
@@ -2947,7 +2947,7 @@ static ssize_t irq_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.irq);
+	return sysfs_emit(buf, "%d\n", tmp.irq);
 }
 
 static ssize_t flags_show(struct device *dev,
@@ -2957,7 +2957,7 @@ static ssize_t flags_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "0x%X\n", tmp.flags);
+	return sysfs_emit(buf, "0x%X\n", tmp.flags);
 }
 
 static ssize_t xmit_fifo_size_show(struct device *dev,
@@ -2967,7 +2967,7 @@ static ssize_t xmit_fifo_size_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.xmit_fifo_size);
+	return sysfs_emit(buf, "%d\n", tmp.xmit_fifo_size);
 }
 
 static ssize_t close_delay_show(struct device *dev,
@@ -2977,7 +2977,7 @@ static ssize_t close_delay_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.close_delay);
+	return sysfs_emit(buf, "%d\n", tmp.close_delay);
 }
 
 static ssize_t closing_wait_show(struct device *dev,
@@ -2987,7 +2987,7 @@ static ssize_t closing_wait_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.closing_wait);
+	return sysfs_emit(buf, "%d\n", tmp.closing_wait);
 }
 
 static ssize_t custom_divisor_show(struct device *dev,
@@ -2997,7 +2997,7 @@ static ssize_t custom_divisor_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.custom_divisor);
+	return sysfs_emit(buf, "%d\n", tmp.custom_divisor);
 }
 
 static ssize_t io_type_show(struct device *dev,
@@ -3007,7 +3007,7 @@ static ssize_t io_type_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.io_type);
+	return sysfs_emit(buf, "%d\n", tmp.io_type);
 }
 
 static ssize_t iomem_base_show(struct device *dev,
@@ -3017,7 +3017,7 @@ static ssize_t iomem_base_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "0x%lX\n", (unsigned long)tmp.iomem_base);
+	return sysfs_emit(buf, "0x%lX\n", (unsigned long)tmp.iomem_base);
 }
 
 static ssize_t iomem_reg_shift_show(struct device *dev,
@@ -3027,7 +3027,7 @@ static ssize_t iomem_reg_shift_show(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
+	return sysfs_emit(buf, "%d\n", tmp.iomem_reg_shift);
 }
 
 static ssize_t console_show(struct device *dev,
@@ -3044,7 +3044,7 @@ static ssize_t console_show(struct device *dev,
 		console = uart_console_registered(uport);
 	mutex_unlock(&port->mutex);
 
-	return sprintf(buf, "%c\n", console ? 'Y' : 'N');
+	return sysfs_emit(buf, "%c\n", console ? 'Y' : 'N');
 }
 
 static ssize_t console_store(struct device *dev,
-- 
2.34.1


