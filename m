Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27767F8507
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbjKXUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjKXUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:03:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833C10F6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700856188; x=1732392188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JOd7EwyxD3DRBP7ebSXKK+WZgK+reW2wbBEUTcLsQC8=;
  b=Ctz+HQQM1eLOo62sJg29LBuDRYkoyNRxrv/7EJoBIU8ns1+RjH2g4Qrw
   7lL347lYiUMT7CcHywNAb08Vl2zj/qKQmr1OdIU5R+6hmBR03ds9NoIc2
   4oAy0+fSxOXv3KvvHZ+kvJxt8B8OBrPkVg0lzPsEguhs9AiScheqMnZa7
   4MDHUlLVEwKD+KvN6V0TvyjCzVO3dUApKgmXN0P6zHhQ8I12vQwAr7ojJ
   JdnKztrw8yl9NiqOg4efj97YEHJe9vazVZY61q2qfNKsvUfgLzoQKn3Fn
   bAFgc3GHn1UjWi8NqYuw5/pKwiVWjWKAHHGL/ANUcRy9a+/xvbwrWNqhZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="396366609"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="396366609"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="833763318"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="833763318"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2023 12:03:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CD4B641A; Fri, 24 Nov 2023 22:03:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v1 5/5] mfd: intel-lpss: Provide Intel LPSS PM ops structure
Date:   Fri, 24 Nov 2023 21:31:28 +0200
Message-ID: <20231124200258.3682979-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
References: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of EXPORT_NS_GPL_DEV_PM_OPS() and other *_PM_OPS() macros
we may convert PM ops functions to become static. This also takes into
account the PM configuration options such as CONFIG_PM and CONFIG_PM_SLEEP.
This all removes a lot of ugly macros and ifdeffery in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c |  5 ++---
 drivers/mfd/intel-lpss-pci.c  |  5 ++---
 drivers/mfd/intel-lpss.c      | 18 ++++++++++--------
 drivers/mfd/intel-lpss.h      | 28 +---------------------------
 4 files changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index a9e2d9308a01..2a83f8678f1d 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -13,6 +13,7 @@
 #include <linux/ioport.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -205,15 +206,13 @@ static void intel_lpss_acpi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static INTEL_LPSS_PM_OPS(intel_lpss_acpi_pm_ops);
-
 static struct platform_driver intel_lpss_acpi_driver = {
 	.probe = intel_lpss_acpi_probe,
 	.remove_new = intel_lpss_acpi_remove,
 	.driver = {
 		.name = "intel-lpss",
 		.acpi_match_table = intel_lpss_acpi_ids,
-		.pm = &intel_lpss_acpi_pm_ops,
+		.pm = pm_ptr(&intel_lpss_pm_ops),
 	},
 };
 
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index e1d89423daa6..8f5e10817a9c 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -13,6 +13,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 
@@ -81,8 +82,6 @@ static void intel_lpss_pci_remove(struct pci_dev *pdev)
 	intel_lpss_remove(&pdev->dev);
 }
 
-static INTEL_LPSS_PM_OPS(intel_lpss_pci_pm_ops);
-
 static const struct property_entry spt_spi_properties[] = {
 	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_SPT_SSP),
 	{ }
@@ -593,7 +592,7 @@ static struct pci_driver intel_lpss_pci_driver = {
 	.probe = intel_lpss_pci_probe,
 	.remove = intel_lpss_pci_remove,
 	.driver = {
-		.pm = &intel_lpss_pci_pm_ops,
+		.pm = pm_ptr(&intel_lpss_pm_ops),
 	},
 };
 
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 4a63703b6da5..177915845ba2 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -24,6 +24,7 @@
 #include <linux/ioport.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/sprintf.h>
@@ -470,7 +471,6 @@ void intel_lpss_remove(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(intel_lpss_remove, INTEL_LPSS);
 
-#ifdef CONFIG_PM
 static int resume_lpss_device(struct device *dev, void *data)
 {
 	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
@@ -479,7 +479,7 @@ static int resume_lpss_device(struct device *dev, void *data)
 	return 0;
 }
 
-int intel_lpss_prepare(struct device *dev)
+static int intel_lpss_prepare(struct device *dev)
 {
 	/*
 	 * Resume both child devices before entering system sleep. This
@@ -488,9 +488,8 @@ int intel_lpss_prepare(struct device *dev)
 	device_for_each_child_reverse(dev, NULL, resume_lpss_device);
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(intel_lpss_prepare, INTEL_LPSS);
 
-int intel_lpss_suspend(struct device *dev)
+static int intel_lpss_suspend(struct device *dev)
 {
 	struct intel_lpss *lpss = dev_get_drvdata(dev);
 	unsigned int i;
@@ -509,9 +508,8 @@ int intel_lpss_suspend(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(intel_lpss_suspend, INTEL_LPSS);
 
-int intel_lpss_resume(struct device *dev)
+static int intel_lpss_resume(struct device *dev)
 {
 	struct intel_lpss *lpss = dev_get_drvdata(dev);
 	unsigned int i;
@@ -524,8 +522,12 @@ int intel_lpss_resume(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(intel_lpss_resume, INTEL_LPSS);
-#endif
+
+EXPORT_NS_GPL_DEV_PM_OPS(intel_lpss_pm_ops, INTEL_LPSS) = {
+	.prepare = pm_sleep_ptr(&intel_lpss_prepare),
+	LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)
+	RUNTIME_PM_OPS(intel_lpss_suspend, intel_lpss_resume, NULL)
+};
 
 static int __init intel_lpss_init(void)
 {
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 062ce95b68b9..c1d72b117ed5 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -30,32 +30,6 @@ int intel_lpss_probe(struct device *dev,
 		     const struct intel_lpss_platform_info *info);
 void intel_lpss_remove(struct device *dev);
 
-#ifdef CONFIG_PM
-int intel_lpss_prepare(struct device *dev);
-int intel_lpss_suspend(struct device *dev);
-int intel_lpss_resume(struct device *dev);
-
-#ifdef CONFIG_PM_SLEEP
-#define INTEL_LPSS_SLEEP_PM_OPS			\
-	.prepare = intel_lpss_prepare,		\
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)
-#else
-#define INTEL_LPSS_SLEEP_PM_OPS
-#endif
-
-#define INTEL_LPSS_RUNTIME_PM_OPS		\
-	.runtime_suspend = intel_lpss_suspend,	\
-	.runtime_resume = intel_lpss_resume,
-
-#else /* !CONFIG_PM */
-#define INTEL_LPSS_SLEEP_PM_OPS
-#define INTEL_LPSS_RUNTIME_PM_OPS
-#endif /* CONFIG_PM */
-
-#define INTEL_LPSS_PM_OPS(name)			\
-const struct dev_pm_ops name = {		\
-	INTEL_LPSS_SLEEP_PM_OPS			\
-	INTEL_LPSS_RUNTIME_PM_OPS		\
-}
+extern const struct dev_pm_ops intel_lpss_pm_ops;
 
 #endif /* __MFD_INTEL_LPSS_H */
-- 
2.43.0.rc1.1.gbec44491f096

