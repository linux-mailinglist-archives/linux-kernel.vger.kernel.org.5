Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6C7C4D44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjJKIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjJKIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:34:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34098A4;
        Wed, 11 Oct 2023 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697013247; x=1728549247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r721DVipL9bpqgYhSjxYjGmtAilZNRSPBbALGRuuO1M=;
  b=SazJ95DmJRzLb18tLk8vhYNnA2K7X80EX1QEfw2myssfiNH2SsGEWc0P
   FhOZEz+7M1M0bKcFuY+iZrNV3lfPRGH7oZoM336FTZLpmLFkscRI/AbRU
   TQH0SnYuhYjZj6+Lmd55vHHsjsSQ1nzzIZ/Su5E2i6qTGezzbV0TxtgLr
   E9MdqaGz0gYLyQ7bt9NTCJ2RI3XWz/fmOfrLXTkWTmzJ7SCJLkHeBwBoA
   uc+lyNvadJZbDXu2VoMT6dleUmI4fno3O1DHrSe7dc22exHqzbHug4GGx
   /0GWiAzwBoVxPMC4UrfCevs3vVtuY/vM/JzVhDSSzEVfMT32uI9Jwl978
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388480189"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388480189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897548208"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897548208"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:32:19 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 3/6] ACPI: AC: Replace acpi_driver with platform_driver
Date:   Wed, 11 Oct 2023 11:33:31 +0300
Message-ID: <20231011083334.3987477-4-michal.wilczynski@intel.com>
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
 drivers/acpi/ac.c | 61 +++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index f809f6889b4a..1dd4919be7ac 100644
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
@@ -51,17 +52,6 @@ static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
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
@@ -129,8 +119,9 @@ static enum power_supply_property ac_props[] = {
 /* Driver Model */
 static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_ac *ac = acpi_driver_data(device);
+	struct device *dev = data;
+	struct acpi_ac *ac = dev_get_drvdata(dev);
+	struct acpi_device *device = ACPI_COMPANION(dev);
 
 	switch (event) {
 	default:
@@ -152,9 +143,10 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 
 		acpi_ac_get_state(ac);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
-						  dev_name(&device->dev), event,
-						  (u32) ac->state);
-		acpi_notifier_call_chain(device, event, (u32) ac->state);
+						dev_name(dev),
+						event,
+						ac->state);
+		acpi_notifier_call_chain(device, event, ac->state);
 		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
 	}
 }
@@ -211,8 +203,9 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 	{},
 };
 
-static int acpi_ac_add(struct acpi_device *device)
+static int acpi_ac_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct power_supply_config psy_cfg = {};
 	struct acpi_ac *ac;
 	int result;
@@ -224,7 +217,8 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->device = device;
 	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
-	device->driver_data = ac;
+
+	platform_set_drvdata(pdev, ac);
 
 	result = acpi_ac_get_state(ac);
 	if (result)
@@ -237,7 +231,7 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->charger_desc.properties = ac_props;
 	ac->charger_desc.num_properties = ARRAY_SIZE(ac_props);
 	ac->charger_desc.get_property = get_ac_property;
-	ac->charger = power_supply_register(&ac->device->dev,
+	ac->charger = power_supply_register(&pdev->dev,
 					    &ac->charger_desc, &psy_cfg);
 	if (IS_ERR(ac->charger)) {
 		result = PTR_ERR(ac->charger);
@@ -251,7 +245,7 @@ static int acpi_ac_add(struct acpi_device *device)
 	register_acpi_notifier(&ac->battery_nb);
 
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
-						 acpi_ac_notify, device);
+						 acpi_ac_notify, &pdev->dev);
 	if (result)
 		goto err_unregister;
 
@@ -269,7 +263,7 @@ static int acpi_ac_add(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_ac_resume(struct device *dev)
 {
-	struct acpi_ac *ac = acpi_driver_data(to_acpi_device(dev));
+	struct acpi_ac *ac = dev_get_drvdata(dev);
 	unsigned int old_state;
 
 	old_state = ac->state;
@@ -284,11 +278,12 @@ static int acpi_ac_resume(struct device *dev)
 #define acpi_ac_resume NULL
 #endif
 
-static void acpi_ac_remove(struct acpi_device *device)
+static void acpi_ac_remove(struct platform_device *pdev)
 {
-	struct acpi_ac *ac = acpi_driver_data(device);
+	struct acpi_ac *ac = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_ALL_NOTIFY,
 				       acpi_ac_notify);
 	power_supply_unregister(ac->charger);
 	unregister_acpi_notifier(&ac->battery_nb);
@@ -296,6 +291,16 @@ static void acpi_ac_remove(struct acpi_device *device)
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
@@ -308,7 +313,7 @@ static int __init acpi_ac_init(void)
 
 	dmi_check_system(ac_dmi_table);
 
-	result = acpi_bus_register_driver(&acpi_ac_driver);
+	result = platform_driver_register(&acpi_ac_driver);
 	if (result < 0)
 		return -ENODEV;
 
@@ -317,7 +322,7 @@ static int __init acpi_ac_init(void)
 
 static void __exit acpi_ac_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_ac_driver);
+	platform_driver_unregister(&acpi_ac_driver);
 }
 module_init(acpi_ac_init);
 module_exit(acpi_ac_exit);
-- 
2.41.0

