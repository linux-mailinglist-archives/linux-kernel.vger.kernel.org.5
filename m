Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8227ADA57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjIYOts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjIYOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:49:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEDD11F;
        Mon, 25 Sep 2023 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695653374; x=1727189374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mYPynKrPz0jMpTI6VpPGiWDqPkes4HHVCp3jJnlrK8c=;
  b=DaxDdZaaxX+RQlUY+pmUI5BpufhTY9g4g0f7n6/lR2cPdPI4uptG74zv
   9OMpo+u5y9na+O4zyq+oRFTeMgG2psfmZS1UvNK1bNIOtKtDYvqEZey0x
   YN6AGJbn4uQDzob8xJ7IxX9I40Ri8IL2+QTk6n37V1VNBQrwXcCXq5mJV
   NnPVj437WplTKdt/QlANxPMMAUcNrm7IUkOzBNbfoFRSiOOvVemQjp0k0
   P8gOooFUQ0xxYnT1CGB16BkPTzniehEJPv8+Kg3ed0rYsLyABHdtWvjNS
   EWbqd5lEDK04Yg5+4HtBR1wBBFsfArrK5pvHSbqVkaLJGUP+nu113bnWA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378548078"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="378548078"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995409503"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995409503"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 07:49:31 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, rui.zhang@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 6/9] ACPI: AC: Rename ACPI device from device to adev
Date:   Mon, 25 Sep 2023 17:48:39 +0300
Message-ID: <20230925144842.586829-7-michal.wilczynski@intel.com>
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
index 78e53d0fdece..270a6919ec12 100644
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
 
-	result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
+	result = acpi_dev_install_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 						 acpi_ac_notify, ac);
 	if (result)
 		goto err_unregister;
-- 
2.41.0

