Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBD97ADA58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjIYOtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjIYOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:49:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C3510F;
        Mon, 25 Sep 2023 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695653378; x=1727189378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8mnjbIMRHs3Br7O5LAy7rYDYZ+KkPj/05DV8Q4PK/as=;
  b=Ngxp6iN4bf6PUispXDUCiaHVWJQZHi9XTfdLu0z5q5FUs3NQmSM9PZls
   o+8eHiayszqWXS22HSvXCaUA8h1C6PdBsynWfmtLQ4BC8epEhQ0B3V2nh
   Bm219VCyYPEUZQg118Zri6Uirmvg49im/VL/uHqLO+qghKKUyRZI6O9Cr
   U8uXEhwGQXx8WDNnDw0+Usx5p+kpdGMr4jePh46UKgZUPbLfLQmxcGUY5
   yUtgsurfiLPJW9KspZPSuohPmo0y8571/29MZoPWcnrQ3e6lujdeJ8K/O
   wTsXlcAAXlknkqsDQHVJ/P5j2GHRSnvr/KE7Qt/2sniS6ardTkokuCnGQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378548090"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378548090"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995409527"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995409527"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:34 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, rui.zhang@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 7/9] ACPI: NFIT: Replace acpi_driver with platform_driver
Date:   Mon, 25 Sep 2023 17:48:40 +0300
Message-ID: <20230925144842.586829-8-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925144842.586829-1-michal.wilczynski@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NFIT driver uses struct acpi_driver incorrectly to register itself.
This is wrong as the instances of the ACPI devices are not meant
to be literal devices, they're supposed to describe ACPI entry of a
particular device.

Use platform_driver instead of acpi_driver. In relevant places call
platform devices instances pdev to make a distinction with ACPI
devices instances.

NFIT driver uses devm_*() family of functions extensively. This change
has no impact on correct functioning of the whole devm_*() family of
functions, since the lifecycle of the device stays the same. It is still
being created during the enumeration, and destroyed on platform device
removal.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 821870f57862..2e50b1334a69 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -15,6 +15,7 @@
 #include <linux/sort.h>
 #include <linux/io.h>
 #include <linux/nd.h>
+#include <linux/platform_device.h>
 #include <asm/cacheflush.h>
 #include <acpi/nfit.h>
 #include "intel.h"
@@ -98,7 +99,7 @@ static struct acpi_device *to_acpi_dev(struct acpi_nfit_desc *acpi_desc)
 			|| strcmp(nd_desc->provider_name, "ACPI.NFIT") != 0)
 		return NULL;
 
-	return to_acpi_device(acpi_desc->dev);
+	return ACPI_COMPANION(acpi_desc->dev);
 }
 
 static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
@@ -3284,11 +3285,11 @@ static void acpi_nfit_put_table(void *table)
 
 static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *adev = data;
+	struct device *dev = data;
 
-	device_lock(&adev->dev);
-	__acpi_nfit_notify(&adev->dev, handle, event);
-	device_unlock(&adev->dev);
+	device_lock(dev);
+	__acpi_nfit_notify(dev, handle, event);
+	device_unlock(dev);
 }
 
 static void acpi_nfit_remove_notify_handler(void *data)
@@ -3329,11 +3330,12 @@ void acpi_nfit_shutdown(void *data)
 }
 EXPORT_SYMBOL_GPL(acpi_nfit_shutdown);
 
-static int acpi_nfit_add(struct acpi_device *adev)
+static int acpi_nfit_probe(struct platform_device *pdev)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_nfit_desc *acpi_desc;
-	struct device *dev = &adev->dev;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_table_header *tbl;
 	acpi_status status = AE_OK;
 	acpi_size sz;
@@ -3360,7 +3362,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
 	if (!acpi_desc)
 		return -ENOMEM;
-	acpi_nfit_desc_init(acpi_desc, &adev->dev);
+	acpi_nfit_desc_init(acpi_desc, dev);
 
 	/* Save the acpi header for exporting the revision via sysfs */
 	acpi_desc->acpi_header = *tbl;
@@ -3391,7 +3393,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
 		return rc;
 
 	rc = acpi_dev_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
-					     acpi_nfit_notify, adev);
+					     acpi_nfit_notify, dev);
 	if (rc)
 		return rc;
 
@@ -3475,11 +3477,11 @@ static const struct acpi_device_id acpi_nfit_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 
-static struct acpi_driver acpi_nfit_driver = {
-	.name = KBUILD_MODNAME,
-	.ids = acpi_nfit_ids,
-	.ops = {
-		.add = acpi_nfit_add,
+static struct platform_driver acpi_nfit_driver = {
+	.probe = acpi_nfit_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.acpi_match_table = acpi_nfit_ids,
 	},
 };
 
@@ -3517,7 +3519,7 @@ static __init int nfit_init(void)
 		return -ENOMEM;
 
 	nfit_mce_register();
-	ret = acpi_bus_register_driver(&acpi_nfit_driver);
+	ret = platform_driver_register(&acpi_nfit_driver);
 	if (ret) {
 		nfit_mce_unregister();
 		destroy_workqueue(nfit_wq);
@@ -3530,7 +3532,7 @@ static __init int nfit_init(void)
 static __exit void nfit_exit(void)
 {
 	nfit_mce_unregister();
-	acpi_bus_unregister_driver(&acpi_nfit_driver);
+	platform_driver_unregister(&acpi_nfit_driver);
 	destroy_workqueue(nfit_wq);
 	WARN_ON(!list_empty(&acpi_descs));
 }
-- 
2.41.0

