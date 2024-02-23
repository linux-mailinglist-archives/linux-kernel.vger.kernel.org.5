Return-Path: <linux-kernel+bounces-79060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D5861CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5615287E50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEB1493B1;
	Fri, 23 Feb 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlMsneYa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70034149390
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717881; cv=none; b=cpoqsg3ItDSkr0ESHiiz51IZnMVevGWiXT6g/CjX5Gn69rEj6AaXZUjw5Mv+pFH+PXvP/f3ZU5bEBMFQ6j0yBUALbnAekx6owhv1kHCVBeYVN9lF3vfTTj3cJlH510QXA7x9gYCBzpySN/lntqftdbz+a+Z2gEUVGBrbqvkCdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717881; c=relaxed/simple;
	bh=dXoPLDQhxVnWDcsR1gAg8K6LjURfRWuoMXcIAZ0xYSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ila4LGUklJM6DEazNFs5mnb2c8uPecC2Nx5Ghi3phDBA9PT77pcoffapfgQlYs9M5wJ6dG5ZeGPQ5uhygYr2RvEaawepnXttAVXTcCAAm0hfxsNNJWGmb1i5YY9wt7upc3IWs2TtpR+1rRBN/5wK2jmSpFF+/hYHAthKV8u/LSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlMsneYa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717879; x=1740253879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dXoPLDQhxVnWDcsR1gAg8K6LjURfRWuoMXcIAZ0xYSk=;
  b=HlMsneYaxN1uF0SVb85m9QJ3eyD6xBP0ZEksgzhWd1ir409VXWPWAJto
   OIIlagwd2KDbLLpTOKA8mgOP31Fi8utyRtIvTuktKOJf9rcR8j+yAgQ8y
   D0V0E1MVidqaXtnirFL4PFyfmE3UMhx0xlAJta6tcx/NiKyhImTLdatjr
   gjhW/Vhqq/iEulBQYtJ2lmL0usX9arMz4XYk3QgqjCntL+V+O/eK+5+7z
   6/43IRLGjbyN+Ity5NAGBj0xkfj15b4qpdG/3RHAt4YSTjwTmKcKC+BZe
   HQ+LJ2HvdPD8+DkHpdzmQV5tSeBRys0rszR0T1LkJhJG7xHBswB8rHdOJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837324"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025651"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025651"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 11:51:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A2BFE4F1; Fri, 23 Feb 2024 21:51:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: [PATCH v1 2/6] mfd: kempld: Use device core to create driver-specific device attributes
Date: Fri, 23 Feb 2024 21:49:51 +0200
Message-ID: <20240223195113.880121-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of creating driver-specific device attributes with
sysfs_create_group() have device core do this by setting up dev_groups
pointer in the driver structure.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/kempld-core.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 99c8656e723c..e8ac30528085 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -15,6 +15,7 @@
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/sysfs.h>
 
 #define MAX_ID_LEN 4
 static char force_device_id[MAX_ID_LEN + 1] = "";
@@ -373,16 +374,13 @@ static DEVICE_ATTR_RO(pld_version);
 static DEVICE_ATTR_RO(pld_specification);
 static DEVICE_ATTR_RO(pld_type);
 
-static struct attribute *pld_attributes[] = {
+static struct attribute *pld_attrs[] = {
 	&dev_attr_pld_version.attr,
 	&dev_attr_pld_specification.attr,
 	&dev_attr_pld_type.attr,
 	NULL
 };
-
-static const struct attribute_group pld_attr_group = {
-	.attrs = pld_attributes,
-};
+ATTRIBUTE_GROUPS(pld);
 
 static int kempld_detect_device(struct kempld_device_data *pld)
 {
@@ -415,15 +413,7 @@ static int kempld_detect_device(struct kempld_device_data *pld)
 		 pld->info.version, kempld_get_type_string(pld),
 		 pld->info.spec_major, pld->info.spec_minor);
 
-	ret = sysfs_create_group(&pld->dev->kobj, &pld_attr_group);
-	if (ret)
-		return ret;
-
-	ret = kempld_register_cells(pld);
-	if (ret)
-		sysfs_remove_group(&pld->dev->kobj, &pld_attr_group);
-
-	return ret;
+	return kempld_register_cells(pld);
 }
 
 static int kempld_probe(struct platform_device *pdev)
@@ -489,8 +479,6 @@ static void kempld_remove(struct platform_device *pdev)
 	struct kempld_device_data *pld = platform_get_drvdata(pdev);
 	const struct kempld_platform_data *pdata = dev_get_platdata(pld->dev);
 
-	sysfs_remove_group(&pld->dev->kobj, &pld_attr_group);
-
 	mfd_remove_devices(&pdev->dev);
 	pdata->release_hardware_mutex(pld);
 }
@@ -506,6 +494,7 @@ static struct platform_driver kempld_driver = {
 	.driver		= {
 		.name	= "kempld",
 		.acpi_match_table = kempld_acpi_table,
+		.dev_groups	  = pld_groups,
 	},
 	.probe		= kempld_probe,
 	.remove_new	= kempld_remove,
-- 
2.43.0.rc1.1.gbec44491f096


