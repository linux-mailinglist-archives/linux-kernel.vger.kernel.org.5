Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133887AF3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjIZTI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjIZTI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:08:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528F136
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695755329; x=1727291329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HF8fW2BHFZycCe0f87W5b2No3tv0gOkh+Gdls/09tpU=;
  b=jQ/iAM6onzhitxn8f+6o4Eh4WOwRWtljBZGhxPH9tvcezSAe5Sqgp8/a
   c9VnmoQ/JrABSAqD+GC45cnXvGjtTcs4oZtqmCfLFIkXK3cEkXIyg208s
   BEEGkpxb7hjzEQ0+xs2/KmWO3Dy1qkBHzwhRviIcRESuFXNUKX83gkTs/
   HEmQv5FeGyjRqjypoqD+LSDya6IB2yHQ/8tY26Lv34dHHD0rIIvZ3ogBe
   th1YI1BgCcpJkqDgvvvGsFz53/EArjxhT0TORDCKgK4k38INUFkZaJUTM
   G8YMXdif7Q/y1aKPc7oEaWBi7BTghvEotOUQh32k2qRKgV3VoauAnZgtP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412562220"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="412562220"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784056118"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="784056118"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2023 12:08:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2D7EF1C7; Tue, 26 Sep 2023 22:08:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 4/4] mfd: lpc_ich: Add a platform device for pinctrl Denverton
Date:   Tue, 26 Sep 2023 22:08:34 +0300
Message-Id: <20230926190834.932233-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230926190834.932233-1-andriy.shevchenko@linux.intel.com>
References: <20230926190834.932233-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to cater the need in non-ACPI system whereby a platform device
has to be created in order to bind with the Denverton pinctrl driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/lpc_ich.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 8b21d0f629c8..ea5f01e07daf 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -226,6 +226,49 @@ static const struct lpc_ich_gpio_info apl_gpio_info = {
 	.offsets = apl_gpio_offsets,
 };
 
+#define DNV_GPIO_NORTH		0
+#define DNV_GPIO_SOUTH		1
+
+#define DNV_GPIO_NR_DEVICES	1
+#define DNV_GPIO_NR_RESOURCES	2
+
+/* Offset data for Denverton GPIO controllers */
+static resource_size_t dnv_gpio_offsets[DNV_GPIO_NR_RESOURCES] = {
+	[DNV_GPIO_NORTH]	= 0xc20000,
+	[DNV_GPIO_SOUTH]	= 0xc50000,
+};
+
+#define DNV_GPIO_IRQ			14
+
+static struct resource dnv_gpio_resources[DNV_GPIO_NR_RESOURCES + 1] = {
+	[DNV_GPIO_NORTH] = DEFINE_RES_MEM(0, 0),
+	[DNV_GPIO_SOUTH] = DEFINE_RES_MEM(0, 0),
+	DEFINE_RES_IRQ(DNV_GPIO_IRQ),
+};
+
+static struct resource *dnv_gpio_mem_resources[DNV_GPIO_NR_RESOURCES] = {
+	[DNV_GPIO_NORTH] = &dnv_gpio_resources[DNV_GPIO_NORTH],
+	[DNV_GPIO_SOUTH] = &dnv_gpio_resources[DNV_GPIO_SOUTH],
+};
+
+static const struct mfd_cell dnv_gpio_devices[DNV_GPIO_NR_DEVICES] = {
+	{
+		.name = "denverton-pinctrl",
+		.num_resources = ARRAY_SIZE(dnv_gpio_resources),
+		.resources = dnv_gpio_resources,
+		.ignore_resource_conflicts = true,
+	},
+};
+
+static const struct lpc_ich_gpio_info dnv_gpio_info = {
+	.hid = "INTC3000",
+	.devices = dnv_gpio_devices,
+	.nr_devices = ARRAY_SIZE(dnv_gpio_devices),
+	.resources = dnv_gpio_mem_resources,
+	.nr_resources = ARRAY_SIZE(dnv_gpio_mem_resources),
+	.offsets = dnv_gpio_offsets,
+};
+
 static struct mfd_cell lpc_ich_spi_cell = {
 	.name = "intel-spi",
 	.num_resources = ARRAY_SIZE(intel_spi_res),
@@ -303,6 +346,7 @@ enum lpc_chipsets {
 	LPC_LEWISBURG,	/* Lewisburg */
 	LPC_9S,		/* 9 Series */
 	LPC_APL,	/* Apollo Lake SoC */
+	LPC_DNV,	/* Denverton SoC */
 	LPC_GLK,	/* Gemini Lake SoC */
 	LPC_COUGARMOUNTAIN,/* Cougar Mountain SoC*/
 };
@@ -648,6 +692,10 @@ static struct lpc_ich_info lpc_chipset_info[] = {
 		.gpio_info = &apl_gpio_info,
 		.spi_type = INTEL_SPI_BXT,
 	},
+	[LPC_DNV] = {
+		.name = "Denverton SoC",
+		.gpio_info = &dnv_gpio_info,
+	},
 	[LPC_GLK] = {
 		.name = "Gemini Lake SoC",
 		.spi_type = INTEL_SPI_BXT,
@@ -666,6 +714,7 @@ static struct lpc_ich_info lpc_chipset_info[] = {
  */
 static const struct pci_device_id lpc_ich_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x0f1c), LPC_BAYTRAIL},
+	{ PCI_VDEVICE(INTEL, 0x19dc), LPC_DNV},
 	{ PCI_VDEVICE(INTEL, 0x1c41), LPC_CPT},
 	{ PCI_VDEVICE(INTEL, 0x1c42), LPC_CPTD},
 	{ PCI_VDEVICE(INTEL, 0x1c43), LPC_CPTM},
-- 
2.40.0.1.gaa8946217a0b

