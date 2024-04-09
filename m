Return-Path: <linux-kernel+bounces-137122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954BE89DD3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F866289848
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B70A131BB7;
	Tue,  9 Apr 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diKYhpeC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1412FF99;
	Tue,  9 Apr 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674055; cv=none; b=sXbX28byw7Uc9alCfZmgYA6pzzIVlBn6TGpHxDfVTjWWi+o6uCm9w5AdM7FQbv6Lqab8pg9U6/1BF8gkcfG/aVVuZFCBKI1LZY9J4sYc/8U7FjlByfN2TXfrwvcU69fQBMC8/f48mOBEnqXvJFV46pLIiKoZpEyiGVmvCig+q40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674055; c=relaxed/simple;
	bh=vDMhltrK3RzG/4Ns3P4TzOAT9HMZ4adbMF+JSVYXVvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTHl5WZQLVur+piHIYZPaknE8pjCO5TNyKhaQZP2J9kGg/46YPldwMRDRmFppyc4MOP2hfFyFY/FMsmmPw4rO6dbXDSO0TZ86Iwo1SBYfi3W5WZfLlI1+ohg3qKVms8wN/MOv210Ski5/KAFfD+HoYqhJ8xl4zhW0uTsaDQG6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diKYhpeC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674054; x=1744210054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vDMhltrK3RzG/4Ns3P4TzOAT9HMZ4adbMF+JSVYXVvY=;
  b=diKYhpeCBIiSqcboK74DIISz1L8OiqaD/yGke0Dba9zxtQsbQTYP+KqO
   RXJc1EmtUzxmcUDwbUBpVy6HD/zOrv9FbmAOhcpp6NBhxj6b+5aH4CbeH
   b1hvV09RtuphYjON1o9C2PoKx2teqoEGyBXvY62N8KHIHseZfYm08ftyC
   n6wp05xt5gfCzJGIBoJzL/XdJFkuEGWQ89FEy1Rp33crpzhaWkftInVig
   AVPzmJ6y/xSadmL+4eCnVXuDD7K5Su5D8SNkX4VSV1a8E+Db6m1pPsK9J
   lPYrDlGZ9e8mm6wXt1DHtfCIWMmnrmB/sdQrjlBX89sIl7qNxWtDUgje/
   g==;
X-CSE-ConnectionGUID: z7v0a5tiQ+aRqcv3R8Xh5Q==
X-CSE-MsgGUID: ljw+jizdQL6wRrL75wNMHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905528"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905528"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093485"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093485"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 43EED2E9; Tue,  9 Apr 2024 17:47:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 4/8] serial: max3100: Switch to use dev_err_probe()
Date: Tue,  9 Apr 2024 17:45:51 +0300
Message-ID: <20240409144721.638326-5-andriy.shevchenko@linux.intel.com>
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

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index e3104ea7a3ca..09ec2ca06989 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -716,9 +716,8 @@ static int max3100_probe(struct spi_device *spi)
 	if (!uart_driver_registered) {
 		retval = uart_register_driver(&max3100_uart_driver);
 		if (retval) {
-			printk(KERN_ERR "Couldn't register max3100 uart driver\n");
 			mutex_unlock(&max3100s_lock);
-			return retval;
+			return dev_err_probe(dev, retval, "Couldn't register max3100 uart driver\n");
 		}
 
 		uart_driver_registered = 1;
@@ -728,15 +727,12 @@ static int max3100_probe(struct spi_device *spi)
 		if (!max3100s[i])
 			break;
 	if (i == MAX_MAX3100) {
-		dev_warn(&spi->dev, "too many MAX3100 chips\n");
 		mutex_unlock(&max3100s_lock);
-		return -ENOMEM;
+		return dev_err_probe(dev, -ENOMEM, "too many MAX3100 chips\n");
 	}
 
 	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
 	if (!max3100s[i]) {
-		dev_warn(&spi->dev,
-			 "kmalloc for max3100 structure %d failed!\n", i);
 		mutex_unlock(&max3100s_lock);
 		return -ENOMEM;
 	}
@@ -760,9 +756,7 @@ static int max3100_probe(struct spi_device *spi)
 
 	retval = uart_add_one_port(&max3100_uart_driver, &max3100s[i]->port);
 	if (retval < 0)
-		dev_warn(&spi->dev,
-			 "uart_add_one_port failed for line %d with error %d\n",
-			 i, retval);
+		dev_err_probe(dev, retval, "uart_add_one_port failed for line %d\n", i);
 
 	/* set shutdown mode to save power. Will be woken-up on open */
 	max3100_sr(max3100s[i], MAX3100_WC | MAX3100_SHDN, &rx);
-- 
2.43.0.rc1.1.gbec44491f096


