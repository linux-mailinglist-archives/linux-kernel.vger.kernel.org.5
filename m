Return-Path: <linux-kernel+bounces-128621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04617895D22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2181F262F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9815EFC8;
	Tue,  2 Apr 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9NnickI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2F15E816;
	Tue,  2 Apr 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087605; cv=none; b=fx/K5f9vEzlt610bAILOQ4IpUPrlPCWaTR7RBIVgpKKZQZMI/ToEoax9BJz2BuNkie7efw7zU0skfToMSx0oT/kJnA3N6lVP/D7BruY/EOphgPuiT3UL2oH+5UK2GYF6BnxZl5VkEBAIylfCt/mdD3BckSQB3QTVCgA9IJkoifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087605; c=relaxed/simple;
	bh=b14aVJkpvb1M/whvnXz3j759fvoxBOvYl/RFmgCkmkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdtPHABalyuDSe6UGzyPlHARJcZUAaVXPYy9tNZSbjHKe6/7FnGqX6tIw+bv6Eu9zy4AhpsnAh6XYsjH5cEo/KEayqx0WIAQiBvj5B2ClviXRPNn3RBwLs0Wmu7BR7PgZ/bUw3CVaDkxjLmE0vjunRhl2ZfAFjo9n1vlQzWlJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9NnickI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087603; x=1743623603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b14aVJkpvb1M/whvnXz3j759fvoxBOvYl/RFmgCkmkU=;
  b=d9NnickIoRvIRDe4QeT0OdW1U3JsnaM53TO4cPdIpVxyN9E0cOw4qAOK
   Ms0J/R2r/aEA+772q7i8noEPcGpL+vWwizh2AaTqUl5NAXAMShE+fGWdN
   Ulvs8Mna/3sOPf9vSh0evNor8VP773ir8SlCL68ciNsTXvVeZIS2jKuod
   AWXqEycpstoCXC/gCECAlTyGpcyDZFd62m0O4oj8v108kEhJdfPxHb681
   /mp237YavzJlyTk+KwSIqBNpncrvvfZ4wn7qDmN0n/uF6KyzEtcn3/flg
   +UUIGRm10u3VEdOj+ScAnF+6vP7sIWPA/pZfl1qltixZVmQSX/70Z5Lro
   A==;
X-CSE-ConnectionGUID: qODqmkJoT4KJi1QkUXU4Bw==
X-CSE-MsgGUID: Jf7H67+2QHeMXMfYQ6u1kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151018"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083793"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083793"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 378531506; Tue,  2 Apr 2024 22:53:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 12/16] serial: max3100: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue,  2 Apr 2024 22:50:39 +0300
Message-ID: <20240402195306.269276-13-andriy.shevchenko@linux.intel.com>
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

The SIMPLE_DEV_PM_OPS() is deprecated, replace it with the
DEFINE_SIMPLE_DEV_PM_OPS() and use pm_sleep_ptr() for setting
the driver's PM routines.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 7cbb8c096b47..55f0421515a8 100644
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
@@ -799,8 +800,6 @@ static void max3100_remove(struct spi_device *spi)
 	mutex_unlock(&max3100s_lock);
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int max3100_suspend(struct device *dev)
 {
 	struct max3100_port *s = dev_get_drvdata(dev);
@@ -836,12 +835,7 @@ static int max3100_resume(struct device *dev)
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
@@ -859,7 +853,7 @@ static struct spi_driver max3100_driver = {
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


