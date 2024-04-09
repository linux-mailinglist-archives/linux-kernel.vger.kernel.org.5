Return-Path: <linux-kernel+bounces-137125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D9589DD47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F1BB26B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF431350D2;
	Tue,  9 Apr 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQz0GJQ0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEEB1311AC;
	Tue,  9 Apr 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674057; cv=none; b=kGrFkUc7NwJWKd2k47gbap4M5JGjqMUKmJvyYGJ5XHd8785O0lwhCyvOANtPhDYWhUtfOq2dAT6zE6bAgkIGIhxh5kYuKNN2fRGSibkP+2As+eDtDxrSKk6FR7LOcPB+a5lsUdzeBEYesvALA7GNE2YQS3566HE1yTZK+MYRWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674057; c=relaxed/simple;
	bh=8f9F0d1TbdbG/VHMAuiUiInQd9MAfWKByxYOamMxypM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKhyv4CdVOU0LGBgP/Rcn71WXQMGkhR099A8BSCUuSc5+cXlX0BJe3bHRagRsTV5VN+lcnlV518EaOjZDyGAhRIv2yhbggG7no5WZiDqil/ZlIBKBEUeVAZoDa9aOEviUFi3SP0hO5DkQ7qWazGKIio0nnsjasiXI59URHDMQlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQz0GJQ0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674056; x=1744210056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8f9F0d1TbdbG/VHMAuiUiInQd9MAfWKByxYOamMxypM=;
  b=hQz0GJQ0QukIjG73ZQSyvHQl5MX3oxX5NNG0AZx5PrhiM6N5o6biAZbw
   AibGRJn4nrxZLQHCE9zLy1Qa3ENHgD2utTLyQny3Rp4HzqBrj2c5Nygo4
   1d4qBA0Fsg8LzO0zZzzEXC3DowwO5U6TKcLQ7e8/+3x/oTpz3RGjcPDUV
   Z/r1yw6MK9qBQ4WxasCAYrTZTkFjWDtWHNqMmBtj/UV0q4ty3fBNMpVsM
   tN8740DHD/8UbI+BPKBcFDGvxY5WrS1KWslse7TPk+UQACP0zf92l1d8N
   kiIgAkiLdyUS17OM7TPoFus8WdPCNgDOn3bJ8zsiCnLfbju2brd5dV7Mn
   A==;
X-CSE-ConnectionGUID: efaG8WJ+QxK2/dgOYIFTbw==
X-CSE-MsgGUID: YL6PAa0/Tw+2PH9du4RaeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905539"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093487"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093487"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 624D18CA; Tue,  9 Apr 2024 17:47:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 6/8] serial: max3100: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue,  9 Apr 2024 17:45:53 +0300
Message-ID: <20240409144721.638326-7-andriy.shevchenko@linux.intel.com>
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

The SIMPLE_DEV_PM_OPS() is deprecated, replace it with the
DEFINE_SIMPLE_DEV_PM_OPS() and use pm_sleep_ptr() for setting
the driver's PM routines.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 3004a95e573f..db543eaa39c8 100644
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
@@ -797,8 +798,6 @@ static void max3100_remove(struct spi_device *spi)
 	mutex_unlock(&max3100s_lock);
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int max3100_suspend(struct device *dev)
 {
 	struct max3100_port *s = dev_get_drvdata(dev);
@@ -834,12 +833,7 @@ static int max3100_resume(struct device *dev)
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
@@ -857,7 +851,7 @@ static struct spi_driver max3100_driver = {
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


