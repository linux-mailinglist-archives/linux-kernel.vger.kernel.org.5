Return-Path: <linux-kernel+bounces-128613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C7895D12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9E1C236E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B7715E1FC;
	Tue,  2 Apr 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNJr2Bbh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002A15D5B8;
	Tue,  2 Apr 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087599; cv=none; b=mQBHouv6b1U6jjMgnL0RaAxt1YjrJEl+GmLivVYoKWYW3PjPWOrg/PAyLOiRNAZOw4fAz/QmYUcenQc6sTDiTaeKFKZFF9jBG4UD4VtkcXcru+TdFHAcVnJ7+49BGUMRwUZ/BCdU00gs2gsP14vOPYAwxLMEtyT2mZCECZv4Bkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087599; c=relaxed/simple;
	bh=hwX0VzHlci8kWHYHJbr2yCODKUvNYIYEx+UfyWdrKX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq7kxxNm+EIFJQ9Hlg7MV9P752adNqo0EdUqBxCnL2O/zaccMGwQRfRyNsf7WSbFR7QR52cpQJrIXKRiHgJrBnxszmiIizsCMkaYBTefJho2b0CbemiUiQ4m4fajPs/m+rDGQmmwTFd6rlkr02G2KeRukfFtWD42i9wEtqi0wuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNJr2Bbh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087598; x=1743623598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hwX0VzHlci8kWHYHJbr2yCODKUvNYIYEx+UfyWdrKX8=;
  b=BNJr2Bbh18ucT38TSxHMn+eIeqiNZ2BuVAhTTujb6lizETRqkCoCEzF9
   JWz+EAxVq6VoEkbvOLADYEHt5KWwcpEWxoUqb8cHD6ilolBzBKbRG/qQE
   XJOfsKYrESeMCqMyMtHPDnmn2YES7fdyrCc3VsCspKi+prKnQntYJ2h1T
   EjJ6gqTaYkg9LHhcrY+6uniiShifZYKxEqPCsJ8Oiz8SMBEFzh3lcNfza
   SPwwQlu1zNgwcfnq1QHoSccS8LM9rp0IWIYI2gRGCA0fDLvgsoS5UXulu
   A6gKvnIsA/qEEbs3T/Ipe471M/AnNnAYmQP4MTqJFmKWAKS8yBa9J8LZU
   g==;
X-CSE-ConnectionGUID: 0RX3wz2/TDy8VJ/4Oca2Yg==
X-CSE-MsgGUID: RfqLUULlTWC6Tia9unzrXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151003"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151003"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083787"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083787"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DD04128A; Tue,  2 Apr 2024 22:53:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 05/16] serial: max3100: Remove custom HW shutdown support
Date: Tue,  2 Apr 2024 22:50:32 +0300
Message-ID: <20240402195306.269276-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While there is no user of this callback in the kernel, it also breaks
the relationship in the driver model. The correct implementation should
be done via GPIO or regulator framework.

Remove custom HW shutdown support for good and, if needed, we will
implement it correctly later on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 42 ++++++------------------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 031803a5da58..c31e4a96cc72 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -34,8 +34,6 @@
  * struct plat_max3100 - MAX3100 SPI UART platform data
  * @loopback:            force MAX3100 in loopback
  * @crystal:             1 for 3.6864 Mhz, 0 for 1.8432
- * @max3100_hw_suspend:  MAX3100 has a shutdown pin. This is a hook
- *                       called on suspend and resume to activate it.
  * @poll_time:           poll time for CTS signal in ms, 0 disables (so no hw
  *                       flow ctrl is possible but you have less CPU usage)
  *
@@ -45,7 +43,6 @@
 struct plat_max3100 {
 	int loopback;
 	int crystal;
-	void (*max3100_hw_suspend) (int suspend);
 	int poll_time;
 };
 
@@ -125,9 +122,6 @@ struct max3100_port {
 	/* need to know we are suspending to avoid deadlock on workqueue */
 	int suspending;
 
-	/* hook for suspending MAX3100 via dedicated pin */
-	void (*max3100_hw_suspend) (int suspend);
-
 	/* poll time (in ms) for ctrl lines */
 	int poll_time;
 	/* and its timer */
@@ -553,6 +547,7 @@ static void max3100_shutdown(struct uart_port *port)
 	struct max3100_port *s = container_of(port,
 					      struct max3100_port,
 					      port);
+	u16 rx;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -572,14 +567,7 @@ static void max3100_shutdown(struct uart_port *port)
 		free_irq(s->irq, s);
 
 	/* set shutdown mode to save power */
-	if (s->max3100_hw_suspend)
-		s->max3100_hw_suspend(1);
-	else  {
-		u16 tx, rx;
-
-		tx = MAX3100_WC | MAX3100_SHDN;
-		max3100_sr(s, tx, &rx);
-	}
+	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
 }
 
 static int max3100_startup(struct uart_port *port)
@@ -625,8 +613,6 @@ static int max3100_startup(struct uart_port *port)
 		max3100_sr(s, tx, &rx);
 	}
 
-	if (s->max3100_hw_suspend)
-		s->max3100_hw_suspend(0);
 	s->conf_commit = 1;
 	max3100_dowork(s);
 	/* wait for clock to settle */
@@ -745,7 +731,7 @@ static int max3100_probe(struct spi_device *spi)
 {
 	int i, retval;
 	struct plat_max3100 *pdata;
-	u16 tx, rx;
+	u16 rx;
 
 	mutex_lock(&max3100s_lock);
 
@@ -786,7 +772,6 @@ static int max3100_probe(struct spi_device *spi)
 	max3100s[i]->poll_time = msecs_to_jiffies(pdata->poll_time);
 	if (pdata->poll_time > 0 && max3100s[i]->poll_time == 0)
 		max3100s[i]->poll_time = 1;
-	max3100s[i]->max3100_hw_suspend = pdata->max3100_hw_suspend;
 	max3100s[i]->minor = i;
 	timer_setup(&max3100s[i]->timer, max3100_timeout, 0);
 
@@ -806,12 +791,7 @@ static int max3100_probe(struct spi_device *spi)
 			 i, retval);
 
 	/* set shutdown mode to save power. Will be woken-up on open */
-	if (max3100s[i]->max3100_hw_suspend)
-		max3100s[i]->max3100_hw_suspend(1);
-	else {
-		tx = MAX3100_WC | MAX3100_SHDN;
-		max3100_sr(max3100s[i], tx, &rx);
-	}
+	max3100_sr(max3100s[i], MAX3100_WC | MAX3100_SHDN, &rx);
 	mutex_unlock(&max3100s_lock);
 	return 0;
 }
@@ -853,6 +833,7 @@ static void max3100_remove(struct spi_device *spi)
 static int max3100_suspend(struct device *dev)
 {
 	struct max3100_port *s = dev_get_drvdata(dev);
+	u16 rx;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -861,15 +842,8 @@ static int max3100_suspend(struct device *dev)
 	s->suspending = 1;
 	uart_suspend_port(&max3100_uart_driver, &s->port);
 
-	if (s->max3100_hw_suspend)
-		s->max3100_hw_suspend(1);
-	else {
-		/* no HW suspend, so do SW one */
-		u16 tx, rx;
-
-		tx = MAX3100_WC | MAX3100_SHDN;
-		max3100_sr(s, tx, &rx);
-	}
+	/* no HW suspend, so do SW one */
+	max3100_sr(s, MAX3100_WC | MAX3100_SHDN, &rx);
 	return 0;
 }
 
@@ -879,8 +853,6 @@ static int max3100_resume(struct device *dev)
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
-	if (s->max3100_hw_suspend)
-		s->max3100_hw_suspend(0);
 	uart_resume_port(&max3100_uart_driver, &s->port);
 	s->suspending = 0;
 
-- 
2.43.0.rc1.1.gbec44491f096


