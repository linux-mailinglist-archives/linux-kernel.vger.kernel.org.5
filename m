Return-Path: <linux-kernel+bounces-128265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08385895878
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893EA1F25102
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FC51386C6;
	Tue,  2 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2oiYWTR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5EE136652;
	Tue,  2 Apr 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072554; cv=none; b=UeBtu8RRiHkAVehuj4WCdOWe6XfkchBfN9lsHSE0FGq9HMCYj3B3DYktsNuobX9p8oqW/9ROcXacGAbcYPdEgcu8X/0qTzYw0vzwhDPXZu42NCnsfsKvaQoA4tACVn9MI0Al1cyow+xpgdp0LEOXrt2pVeWopxI+QvlNxCa4Yj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072554; c=relaxed/simple;
	bh=AIh3l1Gbu1W+nR8Zu3dJLegwaJOkwuUiD3LVeSrwOEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQDsWy1D2mtjaC1w2vMBgtpnHATr0RyVlwO2RzsjX1lYdkh7+AbHubxal3kmWYDX19Cn7wY7uO9uPHi0/SIt4knnsiqHm7x4AtqM65mnSI2gN6NWxNZsWC6KRYjwVpayiztd+0Iq9gZ1vDWdLqnJE5gXhicmNZWXHNdhRfOQ52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2oiYWTR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072552; x=1743608552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AIh3l1Gbu1W+nR8Zu3dJLegwaJOkwuUiD3LVeSrwOEc=;
  b=Y2oiYWTRSHkl809masdF/vazRHN1YArCs5JzD7gm1+C7O4jRQzEGwrKU
   tC2/dL246al1FM00w1kOTI+SbzZ2rtQ19quXrmWF50jA6jTzytqL6WGE4
   YjJAG6h+nIkM/CxBi95o/qui0bQ8bLdo+WjqqceAbm9ZznSqKSAYp4p2d
   hYiwyPk4jXEVlnmsJjnfdFtXAWO2J+gV6RHHCHswH43VilLVD3zXq86HX
   row9FaTOgx3mVu1EOf6bOckzottxew7MF1twzyuh8JwEiutANhUEzUv40
   6Diq2G79SMm7qeYVhbGEBrxQBBoCLDWb2Qw4Yyx00O6MfaRccu2pkQPk7
   Q==;
X-CSE-ConnectionGUID: BUWewOyrQxW7/QL2/w5RUg==
X-CSE-MsgGUID: LH6XPWdUTSWOJRwvSwZYsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870092"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870092"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083649"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083649"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B297F15BC; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 12/16] serial: max3100: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue,  2 Apr 2024 18:38:18 +0300
Message-ID: <20240402154219.3583679-13-andriy.shevchenko@linux.intel.com>
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

The SIMPLE_DEV_PM_OPS() is deprecated, replace it with the
DEFINE_SIMPLE_DEV_PM_OPS() and use pm_sleep_ptr() for setting
the driver's PM routines.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 599665770b6e..585bf6c898b2 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -21,6 +21,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
@@ -798,8 +799,6 @@ static void max3100_remove(struct spi_device *spi)
 	mutex_unlock(&max3100s_lock);
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int max3100_suspend(struct device *dev)
 {
 	struct max3100_port *s = dev_get_drvdata(dev);
@@ -835,12 +834,7 @@ static int max3100_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(max3100_pm_ops, max3100_suspend, max3100_resume);
-#define MAX3100_PM_OPS (&max3100_pm_ops)
-
-#else
-#define MAX3100_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(max3100_pm_ops, max3100_suspend, max3100_resume);
 
 static const struct spi_device_id max3100_spi_id[] = {
 	{ "max3100" },
@@ -858,7 +852,7 @@ static struct spi_driver max3100_driver = {
 	.driver = {
 		.name		= "max3100",
 		.of_match_table	= max3100_of_match,
-		.pm		= MAX3100_PM_OPS,
+		.pm		= pm_sleep_ptr(&max3100_pm_ops),
 	},
 	.probe		= max3100_probe,
 	.remove		= max3100_remove,
-- 
2.43.0.rc1.1.gbec44491f096


