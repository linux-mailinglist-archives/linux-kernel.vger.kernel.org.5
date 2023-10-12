Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE567C62F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjJLCjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376743AbjJLCir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA9A4;
        Wed, 11 Oct 2023 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078326; x=1728614326;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tjwv376/Em55sOxjhruTUpiSwRHY1GDeDxUXzacac6o=;
  b=BEawEjhNr3a0ETmoU3yLZV9aAPTVxMIpP7nR1PdTjyKyN9baGC6epP/b
   f8Ny0yw/n87feiVhCT2zOQr+41T22aXQ/vJxFEJ2+8ZugKCVj1jDK1ry7
   p6XiHRtAorUyPkoZpsSKFMU9hHoLWlYtaGc0n+IkDFvqIlYj3H27mSO11
   OmSkZvzwZPnHFaetlAPhXLHeLW2KHJy6BeHYrI2KM4oXO/VXMNG3kTyzU
   wDSw1KzIUa/TevBEqzS1XRpPG2IkfKteiYNHPTP8eCAFNBtKizhktiiRw
   yI3KHo/EEPxFE1GBy+GL4iFEuJl7mPEp15rWmN2lcuhAHO7aN6jvfwbxy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402630"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402630"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507866"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507866"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:42 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id 1E907580E38;
        Wed, 11 Oct 2023 19:38:42 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 10/16] platform/x86/intel/pmc: Split pmc_core_ssram_get_pmc()
Date:   Wed, 11 Oct 2023 19:38:34 -0700
Message-Id: <20231012023840.3845703-11-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012023840.3845703-1-david.e.box@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On supported hardware, each PMC may have an associated SSRAM device for
accessing additional counters.  However, only the SSRAM of the first
(primary) PMC is discoverable as a PCI device to the OS. The remaining
(secondary) devices are hidden but their BARs are still accessible and
their addresses are stored in the BAR of the exposed device. Clean up the
code handling the SSRAM discovery. Create two separate functions for
accessing the primary and secondary SSRAM devices.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - New patch split from previous PATCH 2
   - Update changelog
   - Use cleanup.h to cleanup ioremap

V2 - no change

 drivers/platform/x86/intel/pmc/core_ssram.c | 93 ++++++++++++++-------
 1 file changed, 61 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 815950713e25..af405d11919f 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/cleanup.h>
 #include <linux/pci.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
@@ -21,6 +22,8 @@
 #define SSRAM_IOE_OFFSET	0x68
 #define SSRAM_DEVID_OFFSET	0x70
 
+DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
+
 static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
 {
 	for (; list->map; ++list)
@@ -65,44 +68,74 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
 	return 0;
 }
 
-static void
-pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, void __iomem *ssram, u32 offset,
-		       int pmc_idx)
+static int
+pmc_core_get_secondary_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 {
-	u64 pwrm_base;
+	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
+	void __iomem __free(pmc_core_iounmap) *main_ssram = NULL;
+	void __iomem __free(pmc_core_iounmap) *secondary_ssram = NULL;
+	const struct pmc_reg_map *map;
+	u64 ssram_base, pwrm_base;
 	u16 devid;
 
-	if (pmc_idx != PMC_IDX_SOC) {
-		u64 ssram_base = get_base(ssram, offset);
+	if (!pmcdev->regmap_list)
+		return -ENOENT;
 
-		if (!ssram_base)
-			return;
+	/*
+	 * The secondary PMC BARS (which are behind hidden PCI devices) are read
+	 * from fixed offsets in MMIO of the primary PMC BAR.
+	 */
+	ssram_base = ssram_pcidev->resource[0].start;
+	main_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!main_ssram)
+		return -ENOMEM;
 
-		ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-		if (!ssram)
-			return;
-	}
+	ssram_base = get_base(main_ssram, offset);
+	secondary_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!secondary_ssram)
+		return -ENOMEM;
+
+	pwrm_base = get_base(secondary_ssram, SSRAM_PWRM_OFFSET);
+	devid = readw(secondary_ssram + SSRAM_DEVID_OFFSET);
+
+	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
+	if (!map)
+		return -ENODEV;
+
+	return pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
+}
+
+static int
+pmc_core_get_primary_pmc(struct pmc_dev *pmcdev)
+{
+	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
+	void __iomem __free(pmc_core_iounmap) *ssram;
+	const struct pmc_reg_map *map;
+	u64 ssram_base, pwrm_base;
+	u16 devid;
+
+	if (!pmcdev->regmap_list)
+		return -ENOENT;
+
+	/* The primary PMC (SOC die) BAR is BAR 0 in config space. */
+	ssram_base = ssram_pcidev->resource[0].start;
+	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!ssram)
+		return -ENOMEM;
 
 	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
 	devid = readw(ssram + SSRAM_DEVID_OFFSET);
 
-	if (pmcdev->regmap_list) {
-		const struct pmc_reg_map *map;
+	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
+	if (!map)
+		return -ENODEV;
 
-		map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
-		if (map)
-			pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
-	}
-
-	if (pmc_idx != PMC_IDX_SOC)
-		iounmap(ssram);
+	return pmc_core_pmc_add(pmcdev, pwrm_base, map, PMC_IDX_MAIN);
 }
 
 int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 {
-	void __iomem *ssram;
 	struct pci_dev *pcidev;
-	u64 ssram_base;
 	int ret;
 
 	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
@@ -113,18 +146,14 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 	if (ret)
 		goto release_dev;
 
-	ssram_base = pcidev->resource[0].start;
-	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-	if (!ssram)
-		goto disable_dev;
-
 	pmcdev->ssram_pcidev = pcidev;
 
-	pmc_core_ssram_get_pmc(pmcdev, ssram, 0, PMC_IDX_SOC);
-	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_IOE_OFFSET, PMC_IDX_IOE);
-	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_PCH_OFFSET, PMC_IDX_PCH);
+	ret = pmc_core_get_primary_pmc(pmcdev);
+	if (ret)
+		goto disable_dev;
 
-	iounmap(ssram);
+	pmc_core_get_secondary_pmc(pmcdev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
+	pmc_core_get_secondary_pmc(pmcdev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
 
 	return 0;
 
-- 
2.34.1

