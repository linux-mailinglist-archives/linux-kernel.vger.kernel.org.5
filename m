Return-Path: <linux-kernel+bounces-128618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16084895D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D8A1C23818
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FCC15E81D;
	Tue,  2 Apr 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibvTmlQs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0115E21E;
	Tue,  2 Apr 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087602; cv=none; b=kQO7DMZJT5PgdErRKZOwjtR8D0gUqmnxLE1bwm+sZoXcVq1IVyLH7LqttNm6a1qLr9jP7zO1P++4AYfLLB5yqRNsz3Pyv1FkW4IfrAdQIr0L6wZF5u2PCVRtuv3GX+2Bq9RbSnzKLd/wNxUQcJVvIrIGrDK5uW1IGGwtv8GvxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087602; c=relaxed/simple;
	bh=lkYByveoDNXTS+TGzqxE2FjXqVLC6IlZzHAyfGxhKyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFN78n6nAWxp4XTxI2gTAGOW0xDOgwcBeNocLdwdPLKuN6hlKifDALJ3b4Gl8OGBzGiRf2vD2ZdoN6Dp4nPV6Jwjod64+p1k8f0tQGPOoy6hPQbes8464ItWjglS4aDpW0efUvd4vRAVjlBUJJGLmYAe43egn2EE1FBXfLFKM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibvTmlQs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087601; x=1743623601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lkYByveoDNXTS+TGzqxE2FjXqVLC6IlZzHAyfGxhKyg=;
  b=ibvTmlQstoQuvbNuVOXuSa1+7+7P4nTYwcWG7BiG30EIVbllsVplWT4u
   u3c2kmIvk3Sl4G/r1aqFoxXH2kd58UJdGncgD8SQb9/A3+j9rLsHLgkuT
   m6sbXiutPWCGJPmxvInrbRkJFIUgmmfuxqhe+/KhjoSeprfSTU7S78NzT
   uza+2Sf+hn8BLNSBq0baDCaqQcWBh3/ME63E00LFPkpJs3gRx5O8sHUYo
   Mgm967Q8p7LJ+e1hT6qaErHwwX4Z1SxRZVJeG3MsrtHJcqrtwJ5Ie4f04
   MCw3LL424ia7ljxWMrbp190rdH3X2NJoWL5IToVkegvQF54L+ak6H/oxE
   A==;
X-CSE-ConnectionGUID: AdyT2GhKSCKot8WOkNkd/A==
X-CSE-MsgGUID: FifmvPHiRwaKX9rEp6OyfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151021"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151021"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083788"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083788"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 022FA812; Tue,  2 Apr 2024 22:53:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 07/16] serial: max3100: Enable TIOCM_LOOP
Date: Tue,  2 Apr 2024 22:50:34 +0300
Message-ID: <20240402195306.269276-8-andriy.shevchenko@linux.intel.com>
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

Enable or disable loopback at run-time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 6dc20e4ec078..cd6a80e97868 100644
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
@@ -257,7 +256,7 @@ static void max3100_work(struct work_struct *w)
 	struct max3100_port *s = container_of(w, struct max3100_port, work);
 	int rxchars;
 	u16 tx, rx;
-	int conf, cconf, crts;
+	int conf, cconf, cloopback, crts;
 	struct circ_buf *xmit = &s->port.state->xmit;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -268,11 +267,15 @@ static void max3100_work(struct work_struct *w)
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
@@ -397,18 +400,24 @@ static void max3100_set_mctrl(struct uart_port *port, unsigned int mctrl)
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
 
@@ -595,12 +604,6 @@ static int max3100_startup(struct uart_port *port)
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
@@ -756,7 +759,6 @@ static int max3100_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, max3100s[i]);
 	pdata = dev_get_platdata(&spi->dev);
 	max3100s[i]->crystal = pdata->crystal;
-	max3100s[i]->loopback = pdata->loopback;
 	max3100s[i]->minor = i;
 	timer_setup(&max3100s[i]->timer, max3100_timeout, 0);
 
-- 
2.43.0.rc1.1.gbec44491f096


