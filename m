Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB827BBDCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjJFRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjJFRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:31:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85919AD;
        Fri,  6 Oct 2023 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696613484; x=1728149484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/dzgm7DN8BUE9+1jsM6TP8FvAIgjlWLoklntkWjDi8Q=;
  b=fnjbi/RdawZe1dXew7UgIooKp3qzNHOr6+T8rkuoHLRlKs7FCIPGFXM0
   CHbwgiezoIUmn1Eh7dtIAZDdZD8RvxpgJEVMO4EKa0kxTA49oGfIf09MS
   cLKw/rlvm9nEkG24oUVMqTNXo6fwMH+r4/hLAsyhPA6976jO+B/9oQdKU
   HKDIE7g437QMGmK1WK+hDYgWaMCzC+ORcphXfpGEw1JYNcEoRDoD7xgaR
   vMt92tvkNgRcpOJkANeUMUpqGLL/KnYxduBTtu9mHrP3/wmpCBsN2YvD+
   4OXVYAGT7zE916zt8tQM7wB3SovED4a6BirbCvGvOrgCK2ck5By4FsEFq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387676829"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387676829"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745937455"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745937455"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:18 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 4/6] ACPI: AC: Rename ACPI device from device to adev
Date:   Fri,  6 Oct 2023 20:30:53 +0300
Message-ID: <20231006173055.2938160-5-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006173055.2938160-1-michal.wilczynski@intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
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

Since transformation from ACPI driver to platform driver there are two
devices on which the driver operates - ACPI device and platform device.
For the sake of reader this calls for the distinction in their naming,
to avoid confusion. Rename device to adev, as corresponding
platform device is called pdev.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/ac.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 298defeb5301..bb02e7f5d65a 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -120,7 +120,7 @@ static enum power_supply_property ac_props[] = {
 static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_ac *ac = data;
-	struct acpi_device *device = ACPI_COMPANION(ac->dev);
+	struct acpi_device *adev = ACPI_COMPANION(ac->dev);
 
 	switch (event) {
 	default:
@@ -141,11 +141,11 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 			msleep(ac_sleep_before_get_state_ms);
 
 		acpi_ac_get_state(ac);
-		acpi_bus_generate_netlink_event(device->pnp.device_class,
+		acpi_bus_generate_netlink_event(adev->pnp.device_class,
 						dev_name(ac->dev),
 						event,
 						ac->state);
-		acpi_notifier_call_chain(device, event, ac->state);
+		acpi_notifier_call_chain(adev, event, ac->state);
 		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
 	}
 }
@@ -204,7 +204,7 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 
 static int acpi_ac_probe(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct power_supply_config psy_cfg = {};
 	struct acpi_ac *ac;
 	int result;
@@ -214,8 +214,8 @@ static int acpi_ac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ac->dev = &pdev->dev;
-	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
+	strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
+	strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
 
 	platform_set_drvdata(pdev, ac);
 
@@ -225,7 +225,7 @@ static int acpi_ac_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = ac;
 
-	ac->charger_desc.name = acpi_device_bid(device);
+	ac->charger_desc.name = acpi_device_bid(adev);
 	ac->charger_desc.type = POWER_SUPPLY_TYPE_MAINS;
 	ac->charger_desc.properties = ac_props;
 	ac->charger_desc.num_properties = ARRAY_SIZE(ac_props);
@@ -237,13 +237,13 @@ static int acpi_ac_probe(struct platform_device *pdev)
 		goto err_release_ac;
 	}
 
-	pr_info("%s [%s] (%s-line)\n", acpi_device_name(device),
-		acpi_device_bid(device), str_on_off(ac->state));
+	pr_info("%s [%s] (%s-line)\n", acpi_device_name(adev),
+		acpi_device_bid(adev), str_on_off(ac->state));
 
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
 
-	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
+	result = acpi_dev_install_notify_handler(adev, ACPI_ALL_NOTIFY,
 						 acpi_ac_notify, ac);
 	if (result)
 		goto err_unregister;
-- 
2.41.0

