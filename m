Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E85E7CB0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjJPRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjJPRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:05:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190AC3254;
        Mon, 16 Oct 2023 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475714; x=1729011714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3Z4WGrXG69PQDGxjpaL1h4E+zMeZMVLbMui312R5WQ=;
  b=KRnbaxOnN40z6z0rjnshn6txvvuUoOsvXmrBFc+TiWkKHuJhT34Issf3
   bYSW+6uD/O79Nn3swsKM3ARdl42IiaHxPim4UBoTaQxHeULBiJs6FGIGr
   6tkC5Omg2BQQqvrOUVMiPRRqRn8mo6qCB8IJs0XFcPcjssPxbxBjrCZgq
   eHVcpXmX2xNrAnH1yNCURX84OnBXRrJiuxblXm5soP+mQfqCdA3YFdWaN
   rd+ekVtdnnZ+fHhK7QKTbOQkEr2IQ13Vm6vnzGtTaCle5dhiYCT+4Mpsn
   mHXxbzjihOF+uaoqh+DDMg+wkfkTXKKCpeRcws0hILtD/HD+tQ+ccYP0J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385427260"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="385427260"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087133904"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087133904"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:01:38 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 2/3] ACPI: acpi_pad: Use dev groups for sysfs
Date:   Mon, 16 Oct 2023 20:01:24 +0300
Message-ID: <20231016170125.576159-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016170125.576159-1-michal.wilczynski@intel.com>
References: <20231016170125.576159-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the way sysfs files are created. Use dev_groups, as it's a
better approach - it allows to declare attributes, and the core code
would take care of the lifecycle of those objects.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/acpi_pad.c | 42 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 36e1049833a3..2513028a0299 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -337,33 +337,14 @@ static ssize_t idlecpus_show(struct device *dev,
 
 static DEVICE_ATTR_RW(idlecpus);
 
-static int acpi_pad_add_sysfs(struct acpi_device *device)
-{
-	int result;
-
-	result = device_create_file(&device->dev, &dev_attr_idlecpus);
-	if (result)
-		return -ENODEV;
-	result = device_create_file(&device->dev, &dev_attr_idlepct);
-	if (result) {
-		device_remove_file(&device->dev, &dev_attr_idlecpus);
-		return -ENODEV;
-	}
-	result = device_create_file(&device->dev, &dev_attr_rrtime);
-	if (result) {
-		device_remove_file(&device->dev, &dev_attr_idlecpus);
-		device_remove_file(&device->dev, &dev_attr_idlepct);
-		return -ENODEV;
-	}
-	return 0;
-}
+static struct attribute *acpi_pad_attrs[] = {
+	&dev_attr_idlecpus.attr,
+	&dev_attr_idlepct.attr,
+	&dev_attr_rrtime.attr,
+	NULL
+};
 
-static void acpi_pad_remove_sysfs(struct acpi_device *device)
-{
-	device_remove_file(&device->dev, &dev_attr_idlecpus);
-	device_remove_file(&device->dev, &dev_attr_idlepct);
-	device_remove_file(&device->dev, &dev_attr_rrtime);
-}
+ATTRIBUTE_GROUPS(acpi_pad);
 
 /*
  * Query firmware how many CPUs should be idle
@@ -440,17 +421,12 @@ static int acpi_pad_probe(struct platform_device *pdev)
 	strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
-	if (acpi_pad_add_sysfs(device))
-		return -ENODEV;
-
 	status = acpi_install_notify_handler(device->handle,
 					     ACPI_DEVICE_NOTIFY,
 					     acpi_pad_notify,
 					     dev);
-	if (ACPI_FAILURE(status)) {
-		acpi_pad_remove_sysfs(device);
+	if (ACPI_FAILURE(status))
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -466,7 +442,6 @@ static void acpi_pad_remove(struct platform_device *pdev)
 	acpi_remove_notify_handler(device->handle,
 				   ACPI_DEVICE_NOTIFY,
 				   acpi_pad_notify);
-	acpi_pad_remove_sysfs(device);
 }
 
 static const struct acpi_device_id pad_device_ids[] = {
@@ -479,6 +454,7 @@ static struct platform_driver acpi_pad_driver = {
 	.probe = acpi_pad_probe,
 	.remove_new = acpi_pad_remove,
 	.driver = {
+		.dev_groups = acpi_pad_groups,
 		.name = "processor_aggregator",
 		.acpi_match_table = pad_device_ids,
 	},
-- 
2.41.0

