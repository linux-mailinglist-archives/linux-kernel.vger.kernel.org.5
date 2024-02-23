Return-Path: <linux-kernel+bounces-79061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70789861CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11593B254FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C841493BB;
	Fri, 23 Feb 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0wh6rG4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AD149393
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717881; cv=none; b=axnxPaQPsceBfhJAccecNWUg0aOgc3T5l7PwkzrLUDnza3zifMER16DEKHP7tSFY9mjThFXjh0cqpISvVAe/zEH86cx7PPvv0U+Hhtop7YZXL6abXlrncuOa95/oefCxc7p73r26OrmXQhlxfzMRDm96UmmRy2Bpc65jAtL7X5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717881; c=relaxed/simple;
	bh=Wj2D0oBH1J9oTB67/0tbEOo9q7DzAHlzlDkwpbhKu14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZzirf40fbOu8kM4u0oK52RLZQxbDa4Tjpe2V2kI/s9FVwYPPkHqS0ux6/1xVxexS7y1DJZdB0j5XzXXRCu4TE+wLef9JBsW1kmAWyMtjaawGcmd0jF2aQgcrHgs6ybpuEvq5TxPFjSdb4qlL/ImZt2r2j324smwdU+X1ulvm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0wh6rG4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717880; x=1740253880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wj2D0oBH1J9oTB67/0tbEOo9q7DzAHlzlDkwpbhKu14=;
  b=h0wh6rG4xI7UdJN6Yq86nPJN+fhEvIoJ7IpAY531V97qvdwdYmccJER5
   +2h313nLl3jR1DN8E85cYS9fdeRvOaVWCliArOQObZicEF5J9jL7KQyZl
   3mbouiNhjMAM7yPDl/nRND2BBtmHHrUAwAhxssnJuuUMnKdjyiJd9ByeA
   lLhM1GXjlPji3n33ENctX7RJJ+nx8Uw+ke84CyUVMSuYuuwLmx/Gyfe3i
   rC7oSHX6mJv3S9d7swQlb1zlS0qij7nzKvA2reJ5LmTZzUYj2AeYOpQPs
   PYwCjBnDcL3h0m+UNsa8YvDDTn4b4MyMtKv3PIq61QAeJMZIThUGjUDKD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837326"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837326"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025652"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025652"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 11:51:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 96B134A5; Fri, 23 Feb 2024 21:51:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/6] mfd: kempld: Replace ACPI code with agnostic one
Date: Fri, 23 Feb 2024 21:49:50 +0200
Message-ID: <20240223195113.880121-2-andriy.shevchenko@linux.intel.com>
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

There is no need to include and use entire ACPI stack in the driver.
Replace respective pieces by agnostic code. No functional change
indented.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/kempld-core.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 5557f023a173..99c8656e723c 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -9,11 +9,12 @@
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/kempld.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/delay.h>
-#include <linux/acpi.h>
 
 #define MAX_ID_LEN 4
 static char force_device_id[MAX_ID_LEN + 1] = "";
@@ -425,26 +426,6 @@ static int kempld_detect_device(struct kempld_device_data *pld)
 	return ret;
 }
 
-#ifdef CONFIG_ACPI
-static int kempld_get_acpi_data(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	const struct kempld_platform_data *pdata;
-	int ret;
-
-	pdata = acpi_device_get_match_data(dev);
-	ret = platform_device_add_data(pdev, pdata,
-				       sizeof(struct kempld_platform_data));
-
-	return ret;
-}
-#else
-static int kempld_get_acpi_data(struct platform_device *pdev)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_ACPI */
-
 static int kempld_probe(struct platform_device *pdev)
 {
 	const struct kempld_platform_data *pdata;
@@ -458,10 +439,16 @@ static int kempld_probe(struct platform_device *pdev)
 		 * No kempld_pdev device has been registered in kempld_init,
 		 * so we seem to be probing an ACPI platform device.
 		 */
-		ret = kempld_get_acpi_data(pdev);
+		pdata = device_get_match_data(dev);
+		if (!pdata)
+			return -ENODEV;
+
+		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
 		if (ret)
 			return ret;
-	} else if (kempld_pdev != pdev) {
+	} else if (kempld_pdev == pdev) {
+		pdata = dev_get_platdata(dev);
+	} else {
 		/*
 		 * The platform device we are probing is not the one we
 		 * registered in kempld_init using the DMI table, so this one
@@ -472,7 +459,6 @@ static int kempld_probe(struct platform_device *pdev)
 		dev_notice(dev, "platform device exists - not using ACPI\n");
 		return -ENODEV;
 	}
-	pdata = dev_get_platdata(dev);
 
 	pld = devm_kzalloc(dev, sizeof(*pld), GFP_KERNEL);
 	if (!pld)
@@ -509,19 +495,17 @@ static void kempld_remove(struct platform_device *pdev)
 	pdata->release_hardware_mutex(pld);
 }
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id kempld_acpi_table[] = {
 	{ "KEM0000", (kernel_ulong_t)&kempld_platform_data_generic },
 	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, kempld_acpi_table);
-#endif
 
 static struct platform_driver kempld_driver = {
 	.driver		= {
 		.name	= "kempld",
-		.acpi_match_table = ACPI_PTR(kempld_acpi_table),
+		.acpi_match_table = kempld_acpi_table,
 	},
 	.probe		= kempld_probe,
 	.remove_new	= kempld_remove,
-- 
2.43.0.rc1.1.gbec44491f096


