Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F377DE035
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjKALPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjKALPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:15:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEE8115;
        Wed,  1 Nov 2023 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698837312; x=1730373312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G6WdYG3gDLTq0pXzeGg/xPh03r/L+UzR/Z4eJLHIsI0=;
  b=D1w/2/2rAliqc6iTVpBCJDOnI6sY714cFjaF/F6zyoqf1idOidugMF7O
   nGui5o2apmEzLYbHWpCKyj7NYJ4Bg9VApiouLU4Hndd/hA+83KcxYEvNp
   FLcdPU4Zuej/1YZRno6OF1SJoj4rl+1tF3c7gqPsVdLtJGni9tKAsjQV/
   GvJvKW5Heba8FXzvSDf/v6S3n7Q6kLoqKLSrcHgGljA82nEzXb3Jhk0wf
   hAzGRAx3P7/mCUXMMkn+e0nf2gl61aUZI9NKiCf3M6OS3zyfFFwUt7Kkk
   LaLBIrzqazoLniQUZwPisFQ4X9TyiMQQhnpvi1wGcdwB5XR5d1Q80nHDb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="452761566"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="452761566"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 04:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="795872652"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="795872652"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 04:15:10 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 970EB1207A3;
        Wed,  1 Nov 2023 13:15:07 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] ACPI: property: Replicate DT-aligned u32 properties from DisCo for Imaging
Date:   Wed,  1 Nov 2023 13:15:07 +0200
Message-Id: <20231101111507.1156910-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPI DisCo for Imaging defines properties for camera sensors that
functionally align with DT equivalents. Replicate the values of these
properties so no-one else needs to know about these property names.

Properties replicated are:

	"mipi-img-clock-frequency" -> "clock-frequency"
	"mipi-img-led-max-current" -> "led-max-microamp"
	"mipi-img-flash-max-current" -> "flash-max-microamp"
	"mipi-img-flash-max-timeout" -> "flash-max-timeout-us"

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hi Rafael,

Could you include this patch in the set? Then I think it's fairly
complete on ACPI framework side.

 drivers/acpi/mipi-di.c  | 21 +++++++++++++++++++++
 include/acpi/acpi_bus.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/acpi/mipi-di.c b/drivers/acpi/mipi-di.c
index 13ed09216c37..de8988657e96 100644
--- a/drivers/acpi/mipi-di.c
+++ b/drivers/acpi/mipi-di.c
@@ -591,6 +591,7 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
 	struct acpi_device *adev;
 	acpi_status status;
 	unsigned int i;
+	u32 val;
 	int ret;
 
 	/*
@@ -622,6 +623,26 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
 		}
 	}
 
+	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-clock-frequency", &val)) {
+		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_CLOCK_FREQUENCY)] =
+			PROPERTY_ENTRY_U32("clock-frequency", val);
+	}
+
+	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-led-max-current", &val)) {
+		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_LED_MAX_MICROAMP)] =
+			PROPERTY_ENTRY_U32("led-max-microamp", val);
+	}
+
+	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-flash-max-current", &val)) {
+		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_FLASH_MAX_MICROAMP)] =
+			PROPERTY_ENTRY_U32("flash-max-microamp", val);
+	}
+
+	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-flash-max-timeout-us", &val)) {
+		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_FLASH_MAX_TIMEOUT_US)] =
+			PROPERTY_ENTRY_U32("flash-max-timeout-us", val);
+	}
+
 	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(handle, "Unable to get the path name\n");
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d92799889512..85a27081cced 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -371,6 +371,10 @@ struct acpi_gpio_mapping;
 
 enum acpi_device_swnode_dev_props {
 	ACPI_DEVICE_SWNODE_DEV_ROTATION,
+	ACPI_DEVICE_SWNODE_DEV_CLOCK_FREQUENCY,
+	ACPI_DEVICE_SWNODE_DEV_LED_MAX_MICROAMP,
+	ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_MICROAMP,
+	ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_TIMEOUT_US,
 	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
 	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
 };
-- 
2.39.2

