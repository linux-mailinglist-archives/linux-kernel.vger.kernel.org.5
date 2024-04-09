Return-Path: <linux-kernel+bounces-137119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D6389DD36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9B51F25001
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6A12FB3E;
	Tue,  9 Apr 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5QbEyWC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372B50275;
	Tue,  9 Apr 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674052; cv=none; b=nvthsNzTdBcnMSBA511/Z55VeF4uZYVWeoOt0xf8ZR405iy+sRhLBQWDHrkhR0I5E++rfSWj78VfvNNtOfFZ+tYlt/zWnaJEI4M43CAxDyZoN318MYu1w0qtvmBNMOZlA0zcSRrZeIr7SqSsOeQx/yMQtF5FskXVcVDCB5ZLjfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674052; c=relaxed/simple;
	bh=kg9KDXJNIRys96XzkRzlSzAvAHPk0RvpRk5pjnWlqpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLTSfSm6pE3PpUDPxMW8uJOx7dI33MHxXaUhuttQgTDNpv4VuPG7HyLvCFdHPNs5Nx7/RKzMvWEPSV8zuvFuTwkvNQCPJFZM1xr4xBuqeyVEY/0zWezTFSEac11clwvusgi2vRBgDP7OFzQ5VahJpEFmw+ounpo8K59jd39Xido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5QbEyWC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674050; x=1744210050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kg9KDXJNIRys96XzkRzlSzAvAHPk0RvpRk5pjnWlqpo=;
  b=S5QbEyWCSV1p4Ba62giqlUCbktU64I/l2Ab+2uHG8DLxDiewMYM/vz2c
   DzKs2neRmBU4trtsKRSQYCPYuM/Bl5wEuc9hCGjlnIhVvg+r+S5b4s3xm
   HMaYff5ol1jdjq0Z5AawGjyocVHhxK6AskRfUQx77992NVFUg19+fNb97
   R30jgXQ098qjjCgWK+5ElNVgr+pLgMPu5PjR79x59FRX9fqF+3MnhZiJR
   HyU2rQ39F44WujShIFJfTU45mEGoi7kpfXg8FFLfYdD+TvyPzbTrl0KUJ
   Uc0EtVUIOBdCggAnpakR/aWsvJXYbzETgxI/+Cg1077DhZq7o1k5hiR2G
   A==;
X-CSE-ConnectionGUID: 1yXCl1FtQW2IoVrEPp4kNA==
X-CSE-MsgGUID: 5J9w3LhBTl2kH3k+CIbXKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905517"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905517"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093482"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093482"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2848D193; Tue,  9 Apr 2024 17:47:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 1/8] serial: max3100: Enable TIOCM_LOOP
Date: Tue,  9 Apr 2024 17:45:48 +0300
Message-ID: <20240409144721.638326-2-andriy.shevchenko@linux.intel.com>
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

Enable or disable loopback at run-time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 75e96ff74571..4a4343e7b1fa 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -32,14 +32,12 @@
 
 /**
  * struct plat_max3100 - MAX3100 SPI UART platform data
- * @loopback:            force MAX3100 in loopback
  * @crystal:             1 for 3.6864 Mhz, 0 for 1.8432
  *
  * You should use this structure in your machine description to specify
  * how the MAX3100 is connected.
  */
 struct plat_max3100 {
-	int loopback;
 	int crystal;
 };
 
@@ -109,6 +107,7 @@ struct max3100_port {
 
 	int minor;		/* minor number */
 	int crystal;		/* 1 if 3.6864Mhz crystal 0 for 1.8432 */
+	int loopback_commit;	/* need to change loopback */
 	int loopback;		/* 1 if we are in loopback mode */
 
 	/* for handling irqs: need workqueue since we do spi_sync */
@@ -241,9 +240,9 @@ static void max3100_work(struct work_struct *w)
 	struct max3100_port *s = container_of(w, struct max3100_port, work);
 	struct tty_port *tport = &s->port.state->port;
 	unsigned char ch;
+	int conf, cconf, cloopback, crts;
 	int rxchars;
 	u16 tx, rx;
-	int conf, cconf, crts;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -253,11 +252,15 @@ static void max3100_work(struct work_struct *w)
 		conf = s->conf;
 		cconf = s->conf_commit;
 		s->conf_commit = 0;
+		cloopback = s->loopback_commit;
+		s->loopback_commit = 0;
 		crts = s->rts_commit;
 		s->rts_commit = 0;
 		spin_unlock(&s->conf_lock);
 		if (cconf)
 			max3100_sr(s, MAX3100_WC | conf, &rx);
+		if (cloopback)
+			max3100_sr(s, 0x4001, &rx);
 		if (crts) {
 			max3100_sr(s, MAX3100_WD | MAX3100_TE |
 				   (s->rts ? MAX3100_RTS : 0), &rx);
@@ -395,18 +398,24 @@ static void max3100_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct max3100_port *s = container_of(port,
 					      struct max3100_port,
 					      port);
-	int rts;
+	int loopback, rts;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
+	loopback = (mctrl & TIOCM_LOOP) > 0;
 	rts = (mctrl & TIOCM_RTS) > 0;
 
 	spin_lock(&s->conf_lock);
+	if (s->loopback != loopback) {
+		s->loopback = loopback;
+		s->loopback_commit = 1;
+	}
 	if (s->rts != rts) {
 		s->rts = rts;
 		s->rts_commit = 1;
-		max3100_dowork(s);
 	}
+	if (s->loopback_commit || s->rts_commit)
+		max3100_dowork(s);
 	spin_unlock(&s->conf_lock);
 }
 
@@ -593,12 +602,6 @@ static int max3100_startup(struct uart_port *port)
 		return -EBUSY;
 	}
 
-	if (s->loopback) {
-		u16 tx, rx;
-		tx = 0x4001;
-		max3100_sr(s, tx, &rx);
-	}
-
 	s->conf_commit = 1;
 	max3100_dowork(s);
 	/* wait for clock to settle */
@@ -754,7 +757,6 @@ static int max3100_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, max3100s[i]);
 	pdata = dev_get_platdata(&spi->dev);
 	max3100s[i]->crystal = pdata->crystal;
-	max3100s[i]->loopback = pdata->loopback;
 	max3100s[i]->minor = i;
 	timer_setup(&max3100s[i]->timer, max3100_timeout, 0);
 
-- 
2.43.0.rc1.1.gbec44491f096


