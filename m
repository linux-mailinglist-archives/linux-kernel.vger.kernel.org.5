Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFAB7AF3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjIZTJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjIZTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:08:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8EE19F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695755331; x=1727291331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gmHI4o4F+gSi5McYazYM8jMweybUuJkKE+gP9i0WdPI=;
  b=W8WMHZE78oZo8PzAqy6pwp9aXGf2W8318zkEA6TnLTJsZuABLLyRuRpW
   OToc+s3nSmdN1+Uq4QtO/S/eB9iW79Acx7OrmfVs0HH2WI/C3a94lv/s5
   qTpGnKRqgHWnr+hKH8JvGF74zX5hND5w/fgA4leWlOtZjrPa9o+C3UztO
   wafSp3ZKY+LRE1Usolmhs7SMTMWtXGtl363S6GIc3FxgoKbot8nY0l6RF
   Q56iKGr07CUAEkmQi4WhtTLLdyHYruzsgusikYS2CTk5xyEI61GFXoajt
   rKpkFhGB1r4V4M5nyDWKIKGluB7MfmUaeEOzkQgo6yZPV5l6huYng800J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412562225"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="412562225"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784056115"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="784056115"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2023 12:08:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2369817D; Tue, 26 Sep 2023 22:08:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 3/4] mfd: lpc_ich: Move APL GPIO resources to a custom structure
Date:   Tue, 26 Sep 2023 22:08:33 +0300
Message-Id: <20230926190834.932233-3-andriy.shevchenko@linux.intel.com>
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

We are expecting more platforms that want to instantiate
the GPIO device via P2SB. For them prepare the custom structure
and move Apollo Lake data there. Refactor the code accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/lpc_ich.c       | 52 +++++++++++++++++++++++++++++--------
 include/linux/mfd/lpc_ich.h |  3 +++
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 58da6c95c462..8b21d0f629c8 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -131,22 +131,33 @@ static struct mfd_cell lpc_ich_gpio_cell = {
 	.ignore_resource_conflicts = true,
 };
 
+#define INTEL_GPIO_RESOURCE_SIZE	0x1000
+
+struct lpc_ich_gpio_info {
+	const char *hid;
+	const struct mfd_cell *devices;
+	size_t nr_devices;
+	struct resource **resources;
+	size_t nr_resources;
+	resource_size_t *offsets;
+};
+
 #define APL_GPIO_NORTH		0
 #define APL_GPIO_NORTHWEST	1
 #define APL_GPIO_WEST		2
 #define APL_GPIO_SOUTHWEST	3
+
 #define APL_GPIO_NR_DEVICES	4
+#define APL_GPIO_NR_RESOURCES	4
 
 /* Offset data for Apollo Lake GPIO controllers */
-static resource_size_t apl_gpio_offsets[APL_GPIO_NR_DEVICES] = {
+static resource_size_t apl_gpio_offsets[APL_GPIO_NR_RESOURCES] = {
 	[APL_GPIO_NORTH]	= 0xc50000,
 	[APL_GPIO_NORTHWEST]	= 0xc40000,
 	[APL_GPIO_WEST]		= 0xc70000,
 	[APL_GPIO_SOUTHWEST]	= 0xc00000,
 };
 
-#define APL_GPIO_RESOURCE_SIZE		0x1000
-
 #define APL_GPIO_IRQ			14
 
 static struct resource apl_gpio_resources[APL_GPIO_NR_DEVICES][2] = {
@@ -168,6 +179,13 @@ static struct resource apl_gpio_resources[APL_GPIO_NR_DEVICES][2] = {
 	},
 };
 
+static struct resource *apl_gpio_mem_resources[APL_GPIO_NR_RESOURCES] = {
+	[APL_GPIO_NORTH] = &apl_gpio_resources[APL_GPIO_NORTH][0],
+	[APL_GPIO_NORTHWEST] = &apl_gpio_resources[APL_GPIO_NORTHWEST][0],
+	[APL_GPIO_WEST] = &apl_gpio_resources[APL_GPIO_WEST][0],
+	[APL_GPIO_SOUTHWEST] = &apl_gpio_resources[APL_GPIO_SOUTHWEST][0],
+};
+
 static const struct mfd_cell apl_gpio_devices[APL_GPIO_NR_DEVICES] = {
 	[APL_GPIO_NORTH] = {
 		.name = "apollolake-pinctrl",
@@ -199,6 +217,15 @@ static const struct mfd_cell apl_gpio_devices[APL_GPIO_NR_DEVICES] = {
 	},
 };
 
+static const struct lpc_ich_gpio_info apl_gpio_info = {
+	.hid = "INT3452",
+	.devices = apl_gpio_devices,
+	.nr_devices = ARRAY_SIZE(apl_gpio_devices),
+	.resources = apl_gpio_mem_resources,
+	.nr_resources = ARRAY_SIZE(apl_gpio_mem_resources),
+	.offsets = apl_gpio_offsets,
+};
+
 static struct mfd_cell lpc_ich_spi_cell = {
 	.name = "intel-spi",
 	.num_resources = ARRAY_SIZE(intel_spi_res),
@@ -618,6 +645,7 @@ static struct lpc_ich_info lpc_chipset_info[] = {
 	[LPC_APL] = {
 		.name = "Apollo Lake SoC",
 		.iTCO_version = 5,
+		.gpio_info = &apl_gpio_info,
 		.spi_type = INTEL_SPI_BXT,
 	},
 	[LPC_GLK] = {
@@ -1156,30 +1184,32 @@ static int lpc_ich_init_wdt(struct pci_dev *dev)
 
 static int lpc_ich_init_pinctrl(struct pci_dev *dev)
 {
+	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
+	const struct lpc_ich_gpio_info *info = lpc_chipset_info[priv->chipset].gpio_info;
 	struct resource base;
 	unsigned int i;
 	int ret;
 
 	/* Check, if GPIO has been exported as an ACPI device */
-	if (acpi_dev_present("INT3452", NULL, -1))
+	if (acpi_dev_present(info->hid, NULL, -1))
 		return -EEXIST;
 
 	ret = p2sb_bar(dev->bus, 0, &base);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < ARRAY_SIZE(apl_gpio_devices); i++) {
-		struct resource *mem = &apl_gpio_resources[i][0];
-		resource_size_t offset = apl_gpio_offsets[i];
+	for (i = 0; i < info->nr_resources; i++) {
+		struct resource *mem = info->resources[i];
+		resource_size_t offset = info->offsets[i];
 
 		/* Fill MEM resource */
 		mem->start = base.start + offset;
-		mem->end = base.start + offset + APL_GPIO_RESOURCE_SIZE - 1;
+		mem->end = base.start + offset + INTEL_GPIO_RESOURCE_SIZE - 1;
 		mem->flags = base.flags;
 	}
 
-	return mfd_add_devices(&dev->dev, 0, apl_gpio_devices,
-			       ARRAY_SIZE(apl_gpio_devices), NULL, 0, NULL);
+	return mfd_add_devices(&dev->dev, 0, info->devices, info->nr_devices,
+			       NULL, 0, NULL);
 }
 
 static bool lpc_ich_byt_set_writeable(void __iomem *base, void *data)
@@ -1332,7 +1362,7 @@ static int lpc_ich_probe(struct pci_dev *dev,
 			cell_added = true;
 	}
 
-	if (priv->chipset == LPC_APL) {
+	if (lpc_chipset_info[priv->chipset].gpio_info) {
 		ret = lpc_ich_init_pinctrl(dev);
 		if (!ret)
 			cell_added = true;
diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
index 83621e0ccf33..1fbda1f8967d 100644
--- a/include/linux/mfd/lpc_ich.h
+++ b/include/linux/mfd/lpc_ich.h
@@ -26,11 +26,14 @@ enum lpc_gpio_versions {
 	AVOTON_GPIO,
 };
 
+struct lpc_ich_gpio_info;
+
 struct lpc_ich_info {
 	char name[32];
 	unsigned int iTCO_version;
 	enum lpc_gpio_versions gpio_version;
 	enum intel_spi_type spi_type;
+	const struct lpc_ich_gpio_info *gpio_info;
 	u8 use_gpio;
 };
 
-- 
2.40.0.1.gaa8946217a0b

