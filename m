Return-Path: <linux-kernel+bounces-137121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46E89DD3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE518287DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82A130E5E;
	Tue,  9 Apr 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjfjMqe9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9C12FF63;
	Tue,  9 Apr 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674054; cv=none; b=ZT9nVURcl9sYY2NEsFIqSuhMWDusetVsUREpW+/INZGHjts6KFyHXg5oxXS3axlr3UtkhJevPDvcYGH3WtxvHlEIKc7gkypSaqkfWD/mzyOh6KpCiWLUSpYze33VLLW87ZlBcsdkE+MOYswT3FeYTyvFhAVd1TwMDlU9lmH05B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674054; c=relaxed/simple;
	bh=AzV7ojVPO5a7N5jBs+1WvcuO+35uQD5o8KQy7ckJN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyTg8Ts2DgTAYObIpwrG661ZfWZwBvX9FrA/FCaPVzsm3VVejLicrRcz6TTdGBnTO3SERbE2X4uMNvY3HXa050wSCdpYUNC+1ZFCC2ghDTDVCZHKUA8dS0nxEUVHfJfDQEbdrtqAfGk7D4G5ITa6fdqPKPXK/mV2IvhqpuH/FJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjfjMqe9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674053; x=1744210053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AzV7ojVPO5a7N5jBs+1WvcuO+35uQD5o8KQy7ckJN8Q=;
  b=EjfjMqe9ZHUpfSjXdAuHcHGv+res3ucLj6BWF5wLFMA7Skm2zWG/ayOS
   99oN4PVLDLboa+0iBVfOkXH+h0Sd3yc+HhroPJgaYyB1yrCMwWzJ2YQKW
   Z8mdnQXPyEK+S7DefVY/DnJKPDfsRkaEiX9nBHZeySlYXv8NWwPoVRGS9
   q5GDrUbVetpUS37+ffelOwq1/2ro8COutJp05rBO6ewqgtrihNPk4oJ3E
   2CN/8gC9OS0VDhbWXGA0T2LuhzJOoMu/QkiNO89Kw2dYbPh03BLu3JZUH
   LmIjoa0BHoEY81WhPgaRmqHnTGUpCqsgl1u94Kq8jHJZssBWuoffdBgI8
   A==;
X-CSE-ConnectionGUID: GYXIRWJ7TA+OHU/J24+uUw==
X-CSE-MsgGUID: 7x8F93giTtWq3qElGoNzHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905524"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093483"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093483"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3E14A8C9; Tue,  9 Apr 2024 17:47:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 3/8] serial: max3100: Remove duplicating irq field
Date: Tue,  9 Apr 2024 17:45:50 +0300
Message-ID: <20240409144721.638326-4-andriy.shevchenko@linux.intel.com>
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

The struct uart_port has a copy of the IRQ that is also stored
in the private data structure. Remove the duplication in the latter
one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 446bc78061e3..e3104ea7a3ca 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -93,8 +93,6 @@ struct max3100_port {
 #define MAX3100_7BIT 4
 	int rx_enabled;	        /* if we should rx chars */
 
-	int irq;		/* irq assigned to the max3100 */
-
 	int minor;		/* minor number */
 	int loopback_commit;	/* need to change loopback */
 	int loopback;		/* 1 if we are in loopback mode */
@@ -548,8 +546,8 @@ static void max3100_shutdown(struct uart_port *port)
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 	}
-	if (s->irq)
-		free_irq(s->irq, s);
+	if (port->irq)
+		free_irq(port->irq, s);
 
 	/* set shutdown mode to save power */
 	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
@@ -561,6 +559,7 @@ static int max3100_startup(struct uart_port *port)
 					      struct max3100_port,
 					      port);
 	char b[12];
+	int ret;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -583,10 +582,10 @@ static int max3100_startup(struct uart_port *port)
 	}
 	INIT_WORK(&s->work, max3100_work);
 
-	if (request_irq(s->irq, max3100_irq,
-			IRQF_TRIGGER_FALLING, "max3100", s) < 0) {
-		dev_warn(&s->spi->dev, "cannot allocate irq %d\n", s->irq);
-		s->irq = 0;
+	ret = request_irq(port->irq, max3100_irq, IRQF_TRIGGER_FALLING, "max3100", s);
+	if (ret < 0) {
+		dev_warn(&s->spi->dev, "cannot allocate irq %d\n", port->irq);
+		port->irq = 0;
 		destroy_workqueue(s->workqueue);
 		s->workqueue = NULL;
 		return -EBUSY;
@@ -742,14 +741,13 @@ static int max3100_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 	max3100s[i]->spi = spi;
-	max3100s[i]->irq = spi->irq;
 	spin_lock_init(&max3100s[i]->conf_lock);
 	spi_set_drvdata(spi, max3100s[i]);
 	max3100s[i]->minor = i;
 	timer_setup(&max3100s[i]->timer, max3100_timeout, 0);
 
 	dev_dbg(&spi->dev, "%s: adding port %d\n", __func__, i);
-	max3100s[i]->port.irq = max3100s[i]->irq;
+	max3100s[i]->port.irq = spi->irq;
 	max3100s[i]->port.fifosize = 16;
 	max3100s[i]->port.ops = &max3100_ops;
 	max3100s[i]->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
@@ -813,7 +811,7 @@ static int max3100_suspend(struct device *dev)
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
-	disable_irq(s->irq);
+	disable_irq(s->port.irq);
 
 	s->suspending = 1;
 	uart_suspend_port(&max3100_uart_driver, &s->port);
@@ -832,7 +830,7 @@ static int max3100_resume(struct device *dev)
 	uart_resume_port(&max3100_uart_driver, &s->port);
 	s->suspending = 0;
 
-	enable_irq(s->irq);
+	enable_irq(s->port.irq);
 
 	s->conf_commit = 1;
 	if (s->workqueue)
-- 
2.43.0.rc1.1.gbec44491f096


