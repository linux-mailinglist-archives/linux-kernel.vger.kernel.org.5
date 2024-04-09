Return-Path: <linux-kernel+bounces-137120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8562689DD39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F561C236B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC9D130E4A;
	Tue,  9 Apr 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsCxTUuw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267647C6D4;
	Tue,  9 Apr 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674053; cv=none; b=nEJwueU9hvmYOxi7S3J8zjWtyqx1C6YssL9owoQ1/CzhqE0Kf1fVl22PJpDaSAIvMxdkV0inLRbnaiwJZfIy67RBa4A6CgwNFx5WTILnFth+7pgAA9iHFT1z3sjJn3HnHAaQffaQ65NAM/jzNq14pw0M+8WpIuLdWgKBIROnk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674053; c=relaxed/simple;
	bh=1gZpJYWGAf2cNtFpFnKr3hMZPoI1cEmqbZW998DA/PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amBYEcRmMgbD5FriB/safp3HA5eb20afyV1pcVDm3z99SYUMOqpgAFeAus95U2JYehyHcHtDs533gfyPAOsKlbgmpnIOLBJJ59m7iDrk11aRxOPVUPArhBYiFkcDlj7oZ3iB6vtK1fb5c4o8VFW6Q+mH1LnogyZfxdIVtFm005c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsCxTUuw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674052; x=1744210052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1gZpJYWGAf2cNtFpFnKr3hMZPoI1cEmqbZW998DA/PU=;
  b=OsCxTUuw98RjfIrNAHkj43NnXl3s1CMAgiPW7wtEtyrTV7hkCZYU1vCT
   DqZ3uapI8RU59IY4Yv9BTRdBtzgrvvFocgu3NHZgsjC33ze5joNwxtonu
   MWt+wLXgDbmsvgTvfbObTkrpC0+gEG0otK4SR1udSIBLhnrs7o2Es8UYo
   z90a0Mi3tpvX8C5SFMqBzgHUbF8zFEUYnoEZVdvwAWMtd4ZeC6PIAw2eK
   gqwlZd0xav2N/BtgGhMf9B0Z/1Y5yfC3WtyY4WoMp2hXPiJX1O36nP4HF
   ajTojOhvrZPTOUYAahWdz2CW6S+I+d1XF+yIFOaunxZDtEhjfvkUjIyIQ
   A==;
X-CSE-ConnectionGUID: 2swGCIxXSjS7dbI7ECpf2A==
X-CSE-MsgGUID: 29XtUxI3RpaO4OfDJN2yug==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905520"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905520"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093484"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093484"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2FC93357; Tue,  9 Apr 2024 17:47:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 2/8] serial: max3100: Get crystal frequency via device property
Date: Tue,  9 Apr 2024 17:45:49 +0300
Message-ID: <20240409144721.638326-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240409144721.638326-1-andriy.shevchenko@linux.intel.com>
References: <20240409144721.638326-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get crystal frequency via device property instead of using
a platform data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 49 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 4a4343e7b1fa..446bc78061e3 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/spi/spi.h>
@@ -30,17 +31,6 @@
 
 #include <asm/unaligned.h>
 
-/**
- * struct plat_max3100 - MAX3100 SPI UART platform data
- * @crystal:             1 for 3.6864 Mhz, 0 for 1.8432
- *
- * You should use this structure in your machine description to specify
- * how the MAX3100 is connected.
- */
-struct plat_max3100 {
-	int crystal;
-};
-
 #define MAX3100_C    (1<<14)
 #define MAX3100_D    (0<<14)
 #define MAX3100_W    (1<<15)
@@ -106,7 +96,6 @@ struct max3100_port {
 	int irq;		/* irq assigned to the max3100 */
 
 	int minor;		/* minor number */
-	int crystal;		/* 1 if 3.6864Mhz crystal 0 for 1.8432 */
 	int loopback_commit;	/* need to change loopback */
 	int loopback;		/* 1 if we are in loopback mode */
 
@@ -426,7 +415,8 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct max3100_port *s = container_of(port,
 					      struct max3100_port,
 					      port);
-	int baud = 0;
+	unsigned int baud = port->uartclk / 16;
+	unsigned int baud230400 = (baud == 230400) ? 1 : 0;
 	unsigned cflag;
 	u32 param_new, param_mask, parity = 0;
 
@@ -439,40 +429,40 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 	param_new = s->conf & MAX3100_BAUD;
 	switch (baud) {
 	case 300:
-		if (s->crystal)
+		if (baud230400)
 			baud = s->baud;
 		else
 			param_new = 15;
 		break;
 	case 600:
-		param_new = 14 + s->crystal;
+		param_new = 14 + baud230400;
 		break;
 	case 1200:
-		param_new = 13 + s->crystal;
+		param_new = 13 + baud230400;
 		break;
 	case 2400:
-		param_new = 12 + s->crystal;
+		param_new = 12 + baud230400;
 		break;
 	case 4800:
-		param_new = 11 + s->crystal;
+		param_new = 11 + baud230400;
 		break;
 	case 9600:
-		param_new = 10 + s->crystal;
+		param_new = 10 + baud230400;
 		break;
 	case 19200:
-		param_new = 9 + s->crystal;
+		param_new = 9 + baud230400;
 		break;
 	case 38400:
-		param_new = 8 + s->crystal;
+		param_new = 8 + baud230400;
 		break;
 	case 57600:
-		param_new = 1 + s->crystal;
+		param_new = 1 + baud230400;
 		break;
 	case 115200:
-		param_new = 0 + s->crystal;
+		param_new = 0 + baud230400;
 		break;
 	case 230400:
-		if (s->crystal)
+		if (baud230400)
 			param_new = 0;
 		else
 			baud = s->baud;
@@ -575,7 +565,7 @@ static int max3100_startup(struct uart_port *port)
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
 	s->conf = MAX3100_RM;
-	s->baud = s->crystal ? 230400 : 115200;
+	s->baud = port->uartclk / 16;
 	s->rx_enabled = 1;
 
 	if (s->suspending)
@@ -718,8 +708,8 @@ static int uart_driver_registered;
 
 static int max3100_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	int i, retval;
-	struct plat_max3100 *pdata;
 	u16 rx;
 
 	mutex_lock(&max3100s_lock);
@@ -755,20 +745,21 @@ static int max3100_probe(struct spi_device *spi)
 	max3100s[i]->irq = spi->irq;
 	spin_lock_init(&max3100s[i]->conf_lock);
 	spi_set_drvdata(spi, max3100s[i]);
-	pdata = dev_get_platdata(&spi->dev);
-	max3100s[i]->crystal = pdata->crystal;
 	max3100s[i]->minor = i;
 	timer_setup(&max3100s[i]->timer, max3100_timeout, 0);
 
 	dev_dbg(&spi->dev, "%s: adding port %d\n", __func__, i);
 	max3100s[i]->port.irq = max3100s[i]->irq;
-	max3100s[i]->port.uartclk = max3100s[i]->crystal ? 3686400 : 1843200;
 	max3100s[i]->port.fifosize = 16;
 	max3100s[i]->port.ops = &max3100_ops;
 	max3100s[i]->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 	max3100s[i]->port.line = i;
 	max3100s[i]->port.type = PORT_MAX3100;
 	max3100s[i]->port.dev = &spi->dev;
+
+	/* Read clock frequency from a property, uart_add_one_port() will fail if it's not set */
+	device_property_read_u32(dev, "clock-frequency", &max3100s[i]->port.uartclk);
+
 	retval = uart_add_one_port(&max3100_uart_driver, &max3100s[i]->port);
 	if (retval < 0)
 		dev_warn(&spi->dev,
-- 
2.43.0.rc1.1.gbec44491f096


