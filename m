Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA37BBDCA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjJFRbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjJFRbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:31:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD77F7;
        Fri,  6 Oct 2023 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696613479; x=1728149479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EYm8izb9ido8H28uYLUgQKICd/XjP2wPae/pGsG01BM=;
  b=NphEC83avYgQySplUFf/kD8YbIuAEZoTOLpj8VOXMiMJn6XcSFSFLGl4
   S7+ccCmITgat8vJl3VxKSWRJRQ5kWg3K3MxtqvC8teoQtnunN5UXPwm/+
   YKONzq138kqet5NNFqZU/TH+6Tdz9RyM6dBUKqFxZm0FKFvR8o+L9lFwW
   6LN6/m9x+aVYs89EBLi3DjjYidc2lK3T6V22h8Xq8j4Bd1iZRZ97Nb1EC
   dMIS33wnRous3MzU+BiGV9rLWO2NEQSA+/vHFV/KOkcrjzfZlGab4cV7I
   YVHiAQfWNjYghKg/jNTDR++r4DS3QXTNe77HJvBVcTU8pF8o48GM99ODX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387676810"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387676810"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745937417"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745937417"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:14 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
Date:   Fri,  6 Oct 2023 20:30:52 +0300
Message-ID: <20231006173055.2938160-4-michal.wilczynski@intel.com>
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

AC driver uses struct acpi_driver incorrectly to register itself. This
is wrong as the instances of the ACPI devices are not meant to
be literal devices, they're supposed to describe ACPI entry of a
particular device.

Use platform_driver instead of acpi_driver. In relevant places call
platform devices instances pdev to make a distinction with ACPI
devices instances.

Drop unnecessary casts from acpi_bus_generate_netlink_event() and
acpi_notifier_call_chain().

Add a blank line to distinguish pdev API vs local ACPI notify function.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/ac.c | 70 +++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index f809f6889b4a..298defeb5301 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -33,8 +33,9 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
-static int acpi_ac_add(struct acpi_device *device);
-static void acpi_ac_remove(struct acpi_device *device);
+static int acpi_ac_probe(struct platform_device *pdev);
+static void acpi_ac_remove(struct platform_device *pdev);
+
 static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id ac_device_ids[] = {
@@ -51,21 +52,10 @@ static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
 static int ac_sleep_before_get_state_ms;
 static int ac_only;
 
-static struct acpi_driver acpi_ac_driver = {
-	.name = "ac",
-	.class = ACPI_AC_CLASS,
-	.ids = ac_device_ids,
-	.ops = {
-		.add = acpi_ac_add,
-		.remove = acpi_ac_remove,
-		},
-	.drv.pm = &acpi_ac_pm,
-};
-
 struct acpi_ac {
 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
-	struct acpi_device *device;
+	struct device *dev;
 	unsigned long long state;
 	struct notifier_block battery_nb;
 };
@@ -85,10 +75,10 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
 		return 0;
 	}
 
-	status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
+	status = acpi_evaluate_integer(ACPI_HANDLE(ac->dev), "_PSR", NULL,
 				       &ac->state);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_info(ac->device->handle,
+		acpi_handle_info(ACPI_HANDLE(ac->dev),
 				"Error reading AC Adapter state: %s\n",
 				acpi_format_exception(status));
 		ac->state = ACPI_AC_STATUS_UNKNOWN;
@@ -129,12 +119,12 @@ static enum power_supply_property ac_props[] = {
 /* Driver Model */
 static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_ac *ac = acpi_driver_data(device);
+	struct acpi_ac *ac = data;
+	struct acpi_device *device = ACPI_COMPANION(ac->dev);
 
 	switch (event) {
 	default:
-		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
+		acpi_handle_debug(ACPI_HANDLE(ac->dev), "Unsupported event [0x%x]\n",
 				  event);
 		fallthrough;
 	case ACPI_AC_NOTIFY_STATUS:
@@ -152,9 +142,10 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 
 		acpi_ac_get_state(ac);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event,
-						  (u32) ac->state);
-		acpi_notifier_call_chain(device, event, (u32) ac->state);
+						dev_name(ac->dev),
+						event,
+						ac->state);
+		acpi_notifier_call_chain(device, event, ac->state);
 		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
 	}
 }
@@ -211,8 +202,9 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 	{},
 };
 
-static int acpi_ac_add(struct acpi_device *device)
+static int acpi_ac_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct power_supply_config psy_cfg = {};
 	struct acpi_ac *ac;
 	int result;
@@ -221,10 +213,11 @@ static int acpi_ac_add(struct acpi_device *device)
 	if (!ac)
 		return -ENOMEM;
 
-	ac->device = device;
+	ac->dev = &pdev->dev;
 	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
-	device->driver_data = ac;
+
+	platform_set_drvdata(pdev, ac);
 
 	result = acpi_ac_get_state(ac);
 	if (result)
@@ -237,7 +230,7 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->charger_desc.properties = ac_props;
 	ac->charger_desc.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger_desc.get_property = get_ac_property;
-	ac->charger = power_supply_register(&ac->device->dev,
+	ac->charger = power_supply_register(&pdev->dev,
 					    &ac->charger_desc, &psy_cfg);
 	if (IS_ERR(ac->charger)) {
 		result = PTR_ERR(ac->charger);
@@ -251,7 +244,7 @@ static int acpi_ac_add(struct acpi_device *device)
 	register_acpi_notifier(&ac->battery_nb);
 
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_ac_notify, device);
+						 acpi_ac_notify, ac);
 	if (result)
 		goto err_unregister;
 
@@ -269,7 +262,7 @@ static int acpi_ac_add(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_ac_resume(struct device *dev)
 {
-	struct acpi_ac *ac = acpi_driver_data(to_acpi_device(dev));
+	struct acpi_ac *ac = dev_get_drvdata(dev);
 	unsigned int old_state;
 
 	old_state = ac->state;
@@ -284,11 +277,12 @@ static int acpi_ac_resume(struct device *dev)
 #define acpi_ac_resume NULL
 #endif
 
-static void acpi_ac_remove(struct acpi_device *device)
+static void acpi_ac_remove(struct platform_device *pdev)
 {
-	struct acpi_ac *ac = acpi_driver_data(device);
+	struct acpi_ac *ac = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(ac->dev),
+				       ACPI_ALL_NOTIFY,
 				       acpi_ac_notify);
 	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
@@ -296,6 +290,16 @@ static void acpi_ac_remove(struct acpi_device *device)
 	kfree(ac);
 }
 
+static struct platform_driver acpi_ac_driver = {
+	.probe = acpi_ac_probe,
+	.remove_new = acpi_ac_remove,
+	.driver = {
+		.name = "ac",
+		.acpi_match_table = ac_device_ids,
+		.pm = &acpi_ac_pm,
+	},
+};
+
 static int __init acpi_ac_init(void)
 {
 	int result;
@@ -308,7 +312,7 @@ static int __init acpi_ac_init(void)
 
 	dmi_check_system(ac_dmi_table);
 
-	result = acpi_bus_register_driver(&acpi_ac_driver);
+	result = platform_driver_register(&acpi_ac_driver);
 	if (result < 0)
 		return -ENODEV;
 
@@ -317,7 +321,7 @@ static int __init acpi_ac_init(void)
 
 static void __exit acpi_ac_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_ac_driver);
+	platform_driver_unregister(&acpi_ac_driver);
 }
 module_init(acpi_ac_init);
 module_exit(acpi_ac_exit);
-- 
2.41.0

