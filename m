Return-Path: <linux-kernel+bounces-128266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9F7895879
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E967288ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF9313A271;
	Tue,  2 Apr 2024 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yss7eEDS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6C135406;
	Tue,  2 Apr 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072554; cv=none; b=T210B8ki3nklntNG6ZL9CvNaWDiUVj20W9Ck8Zkis1wOa7i0/OHxOX75CvoG4hpE3/hj9FLvhoM/lQXPWCKAqdiQ14n6kPTDeIg21muxUNf3sULQLYHRG1QjpF2HHGxcX2YxYtMVgEzgpeb6kh7hvPbb63o6jRkX3I6C4Nn2Fww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072554; c=relaxed/simple;
	bh=jSxcGvPq4d8XaI19VUL8FP1V3nzthfNF3EeNJoxxUqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx+dcFgUfKInK9W+PbQ70T9lsCExgWp3tmOlhAbZemV7EgYOyAuUOnWack1+6QdVZSnfeU0tTwnenxlk/rDVvTiSnC1dNb0HJPPjLa963WVMkGdKVhrvy/s/Xssun83/JDL9g4meiDo5bnL0b9wxZPOq9hQYk98aJtHBNFcYeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yss7eEDS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072551; x=1743608551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jSxcGvPq4d8XaI19VUL8FP1V3nzthfNF3EeNJoxxUqQ=;
  b=Yss7eEDSuGXxnJ51C2l3YI3SbJa91XaF6U8Cxd+YX8K9MP4cscXLOGUt
   uM8/0aj+lYOAhNxaZSkMAOU0X71v23fYDYb1zQxaXSYNsaRnzl8ikTHZo
   zG24uu9KlJAkqleRWQf+eFTGNJ/S9chxOZB6BCXddLhTFvjRotLa/w0ym
   tecscNvPC1u4fgIs/MEjNuttBeY/u5zmVNbJntRNZ2SCGMZQYF4Dj1IPT
   IOsji24iS3RYstxdaqLiQ/etzwF7b7oc0VklMYXfp7/SIhkC5vGxFu9ZL
   6BIdweqeCe7AVY5LsGbeu9AK4b9wt5EQS2/SIKnKU2+rKxandvc35dVZr
   g==;
X-CSE-ConnectionGUID: lRzAHgKRQmuo3t2CecB39w==
X-CSE-MsgGUID: n85bZMTzRTiqgDesNhIKJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870079"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083642"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083642"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8B9D39B0; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 08/16] serial: max3100: Get crystal frequency via device property
Date: Tue,  2 Apr 2024 18:38:14 +0300
Message-ID: <20240402154219.3583679-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
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
index dd98f8037b60..e5a1a9171047 100644
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
 
@@ -428,7 +417,8 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct max3100_port *s = container_of(port,
 					      struct max3100_port,
 					      port);
-	int baud = 0;
+	unsigned int baud = port->uartclk / 16;
+	unsigned int baud230400 = (baud == 230400) ? 1 : 0;
 	unsigned cflag;
 	u32 param_new, param_mask, parity = 0;
 
@@ -441,40 +431,40 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -577,7 +567,7 @@ static int max3100_startup(struct uart_port *port)
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
 	s->conf = MAX3100_RM;
-	s->baud = s->crystal ? 230400 : 115200;
+	s->baud = port->uartclk / 16;
 	s->rx_enabled = 1;
 
 	if (s->suspending)
@@ -720,8 +710,8 @@ static int uart_driver_registered;
 
 static int max3100_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	int i, retval;
-	struct plat_max3100 *pdata;
 	u16 rx;
 
 	mutex_lock(&max3100s_lock);
@@ -756,20 +746,21 @@ static int max3100_probe(struct spi_device *spi)
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


