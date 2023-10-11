Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3B07C4D45
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjJKIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjJKIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:34:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2798;
        Wed, 11 Oct 2023 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697013254; x=1728549254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KeBW7OgXXmtrM6WG1jnUdssaNB2R2i0a8/3uS3pL1AU=;
  b=lCm9qn91slC+pG+Eky1gY96nvO+zXMUVfVoCVOFv+mUhUi6AKE4wIg4x
   yTId+s+x1MMYp9GGI7QrUBsMP9nbBwyg6b6dk1SAm2TMeLvjQDwfIikkw
   ytRi7pc0tzJTPXVccS9p9WIPvXNNE4BTkNBpPk3w8DlL2sgN/AV54ja2U
   PkmL+Mtc3MxW1DNC9IAZQHSF9m6fF5OCrLQMIf0JppZCw+Pc89ckxzGEz
   BqnJbuRCG1REryEqfgC71MkB6+iszx4VksNh/+t7Hi76706uJyeO4lhuL
   jSpH1PlUsbL+B5itaJE+kBleqnkyUO48HWDMMKjbcOUh3G08ZTuJsRXrO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388480263"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388480263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897548222"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897548222"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:32:26 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 5/6] ACPI: NFIT: Replace acpi_driver with platform_driver
Date:   Wed, 11 Oct 2023 11:33:33 +0300
Message-ID: <20231011083334.3987477-6-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011083334.3987477-1-michal.wilczynski@intel.com>
References: <20231011083334.3987477-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 3826f49d481b..6b9d10cae92c 100644
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
 
 	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
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

