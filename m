Return-Path: <linux-kernel+bounces-128267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E589587D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC088B25ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657B413BC00;
	Tue,  2 Apr 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkGJC1eU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E061369A8;
	Tue,  2 Apr 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072555; cv=none; b=mJXFmcjpMMXwwrILUIDYslrP/8txWW+GF6vcASXMQIjOLaa1pFYsu5CZQgwK8IpFgt+ITd++rr4sypGDQB8dRlCda/Y8yTb4rJryrwXORkv6JQyDGFVMjpukgOHvZtho8K9yj4dK3g6T1EtlO7kzv+YW9LVaGE8SXAhxYrampJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072555; c=relaxed/simple;
	bh=vGrq3AnF8SD13aIPLv3DIPaAzu1EFpaug7iIxyUVZEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXL6UlHXbQH8qLuDYRRuVP9iZ3jem7xvpdEZdVWW/hpTPG864t6CKLdMwKNuYnFzqlgpC/PBD3S4uHKzpbrzUTD7GcherTRWR3visQxFiMUZFCmbqV/h3Swh3gmHy1v/aU4yCZ4qH+HY5PnI2Pi1KQP0iYgRX5VOlRIU5jCJyho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkGJC1eU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072553; x=1743608553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vGrq3AnF8SD13aIPLv3DIPaAzu1EFpaug7iIxyUVZEI=;
  b=MkGJC1eUNif1IoA9+UHxEu8YOv97v0aY8yarQT9IyR7yxzZtFT1baXJR
   5XdBwCp1coJ6WOfRDxdz5Fxr7EmRh9TxmTgb1a7jPTQNN/bej9yvVQ1HY
   /unlPfH79ztY472r42Sqbp5uNqO279uJzGHxbgV4odUIf14Ul0Q6lstTW
   OP1p4q0kMsfnYUeWatQhEzVDf8c5SD7hEfbAfc6WAL2UteuvwjlWVIAy9
   Rw22Vc4h/hC7zUG5OUb+fHcyI007dUybTiuoTSPfdRWU57ut/EMJp1ZeQ
   PCm/LJdFv83w8N1xRBinSHMBYPIj3XBI/F9zOluAZSwJ4EVXbcWfz+GoL
   Q==;
X-CSE-ConnectionGUID: ecPjsbkoQSaoXi9THRjJnw==
X-CSE-MsgGUID: qarwQKVWQt+Fp8Dc1zchvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870094"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870094"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083645"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083645"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 64A6C6CB; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 05/16] serial: max3100: Remove custom HW shutdown support
Date: Tue,  2 Apr 2024 18:38:11 +0300
Message-ID: <20240402154219.3583679-6-andriy.shevchenko@linux.intel.com>
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
index f30050248130..0931d7be9c62 100644
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
 
@@ -785,7 +771,6 @@ static int max3100_probe(struct spi_device *spi)
 	max3100s[i]->poll_time = msecs_to_jiffies(pdata->poll_time);
 	if (pdata->poll_time > 0 && max3100s[i]->poll_time == 0)
 		max3100s[i]->poll_time = 1;
-	max3100s[i]->max3100_hw_suspend = pdata->max3100_hw_suspend;
 	max3100s[i]->minor = i;
 	timer_setup(&max3100s[i]->timer, max3100_timeout, 0);
 
@@ -805,12 +790,7 @@ static int max3100_probe(struct spi_device *spi)
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
@@ -852,6 +832,7 @@ static void max3100_remove(struct spi_device *spi)
 static int max3100_suspend(struct device *dev)
 {
 	struct max3100_port *s = dev_get_drvdata(dev);
+	u16 rx;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -860,15 +841,8 @@ static int max3100_suspend(struct device *dev)
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
 
@@ -878,8 +852,6 @@ static int max3100_resume(struct device *dev)
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
-	if (s->max3100_hw_suspend)
-		s->max3100_hw_suspend(0);
 	uart_resume_port(&max3100_uart_driver, &s->port);
 	s->suspending = 0;
 
-- 
2.43.0.rc1.1.gbec44491f096


