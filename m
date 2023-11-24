Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269C97F8502
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbjKXUDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjKXUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:02:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A3310F0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700856186; x=1732392186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3tmtC5KUuDw5A1U1orOmx8i0hwlt4bNoEEqmp3Gufpw=;
  b=A8gd5ORybv2hYsuQyLWV1m9ptuvMFfZ2Od+qvDvGpFhuwHO9jPyksSMh
   nDjBqCXo+vZdK0Pekiz/R12Ykxqg4W4Th0MiEmJNQeoHA3jeRXP0t9bv4
   1krOTnRkDl/7YrvUivF9+UL60kGMm7UOlzFR6K+9TkEUffDC6tnUNrO57
   N5eUCf4u7K1aBvVCRyyafzQ3swl2LKpXOjAvQxZ3UR01n/X2EuKoApIyv
   58v3HdLH40gXBBPgDoJ9SF+emGADVIsOYNO1KKqv3Bk6yEJRLAzaORzhK
   jDBxhVDqLFKfhXMYZVwhqrbt6sNVjss7RDIGawaQq138oa3ixcuu8q24H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="391338130"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391338130"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="1014983738"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="1014983738"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2023 12:03:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A271E26D; Fri, 24 Nov 2023 22:03:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v1 2/5] mfd: intel-lpss: Use device_get_match_data()
Date:   Fri, 24 Nov 2023 21:31:25 +0200
Message-ID: <20231124200258.3682979-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
References: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of acpi_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Introduce a temporary variable in PCI glue driver to be consistent with
ACPI one on the same matter.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c | 11 +++++------
 drivers/mfd/intel-lpss-pci.c  |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 52ffc0d9c23f..bba208235754 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -8,9 +8,9 @@
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
-#include <linux/acpi.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
@@ -169,16 +169,15 @@ MODULE_DEVICE_TABLE(acpi, intel_lpss_acpi_ids);
 
 static int intel_lpss_acpi_probe(struct platform_device *pdev)
 {
+	const struct intel_lpss_platform_info *data;
 	struct intel_lpss_platform_info *info;
-	const struct acpi_device_id *id;
 	int ret;
 
-	id = acpi_match_device(intel_lpss_acpi_ids, &pdev->dev);
-	if (!id)
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENODEV;
 
-	info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
-			    GFP_KERNEL);
+	info = devm_kmemdup(&pdev->dev, data, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 709b0fb4419d..94042bfe7dbf 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -30,6 +30,7 @@ static const struct pci_device_id ignore_resource_conflicts_ids[] = {
 static int intel_lpss_pci_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
+	const struct intel_lpss_platform_info *data = (void *)id->driver_data;
 	struct intel_lpss_platform_info *info;
 	int ret;
 
@@ -41,8 +42,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
-			    GFP_KERNEL);
+	info = devm_kmemdup(&pdev->dev, data, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-- 
2.43.0.rc1.1.gbec44491f096

