Return-Path: <linux-kernel+bounces-137127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B79E89DD45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8801C212F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5F13540C;
	Tue,  9 Apr 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeC2MF+1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E546131BA1;
	Tue,  9 Apr 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674057; cv=none; b=U/MG+b9+oXNNPatJkUrJbADKpo4DFsWx8czy59ev+mUrM4PTHlZD543bQN61OpWtveRwci6+CBIDbYaDaO1BdD/H4saUMty6ctuFK/rdjqebip8XEd8dBFBUALJFzDY/VN5n5HDQJeXowyILSoHxAj87vGqTGDpGpGw1QZ99+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674057; c=relaxed/simple;
	bh=xF8oRrOuA8we7IwhVd+8C+jZeZJzI3rGBO1o6MB+O0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj8rXdqJftKK+CeHoAS0/geKoYnHRKf95UNLDxPOp1Cugs/GcgWjn/GfiGKfwZ1ZhZe66KiH2ZpjrT33Xj+PpuAyGVS8QzVm1OFM8v1eUj13dil/xnVrvzu1sC0GKNYTux1g5EstFaeVJ54Wj+pyt5aP69sasKC/9d0EJWf9A4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeC2MF+1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674056; x=1744210056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xF8oRrOuA8we7IwhVd+8C+jZeZJzI3rGBO1o6MB+O0M=;
  b=YeC2MF+1N6O/AUabLz0WJCqkOmcYIOGI2aJH8KgL1FUVcBcDbPzDTz4K
   db6hCXp4ZcaFecWDwW1IDFKppxnXACviB7lPrkclP+AwMyNh934xGGIxI
   AL83rUkbv5FUCpxduaeO2a8l3BQ1uePqoUO02Fd1AphIhkXlQaEy5w4mF
   0AocxRCHxt80Bd+Oiu09nRJ4lUZxIsPFUFWzom5l9vuwmumed/hvjyr4F
   oc5UbnYBWSI6zs5FIhW6F/1tG9Wwr0RSWJGUhJJnGiOeDz7EF1cPWc8h5
   baVNL7zU0CYoWyN53Z3f9lCx/ooDgPgfK8DqCezdifJhBf6TiZg3RzjTq
   w==;
X-CSE-ConnectionGUID: IdekcKAiTtGUcmq1BvwH/A==
X-CSE-MsgGUID: aOdwVwQ0SemhDj0P2NPT7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905543"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905543"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093488"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093488"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 587F58D1; Tue,  9 Apr 2024 17:47:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 5/8] serial: max3100: Replace MODULE_ALIAS() with respective ID tables
Date: Tue,  9 Apr 2024 17:45:52 +0300
Message-ID: <20240409144721.638326-6-andriy.shevchenko@linux.intel.com>
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

MODULE_ALIAS() in most cases is a pure hack to avoid placing ID tables.
Replace it with the respective ID tables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 09ec2ca06989..3004a95e573f 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
@@ -840,13 +841,27 @@ static SIMPLE_DEV_PM_OPS(max3100_pm_ops, max3100_suspend, max3100_resume);
 #define MAX3100_PM_OPS NULL
 #endif
 
+static const struct spi_device_id max3100_spi_id[] = {
+	{ "max3100" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max3100_spi_id);
+
+static const struct of_device_id max3100_of_match[] = {
+	{ .compatible = "maxim,max3100" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max3100_of_match);
+
 static struct spi_driver max3100_driver = {
 	.driver = {
 		.name		= "max3100",
+		.of_match_table	= max3100_of_match,
 		.pm		= MAX3100_PM_OPS,
 	},
 	.probe		= max3100_probe,
 	.remove		= max3100_remove,
+	.id_table	= max3100_spi_id,
 };
 
 module_spi_driver(max3100_driver);
@@ -854,4 +869,3 @@ module_spi_driver(max3100_driver);
 MODULE_DESCRIPTION("MAX3100 driver");
 MODULE_AUTHOR("Christian Pellegrin <chripell@evolware.org>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:max3100");
-- 
2.43.0.rc1.1.gbec44491f096


