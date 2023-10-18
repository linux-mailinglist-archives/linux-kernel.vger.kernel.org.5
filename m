Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026387CEBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjJRXRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjJRXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F4A125;
        Wed, 18 Oct 2023 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670990; x=1729206990;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=k2unr+Zhd7HB5BfTiO3OMT+8wUJc2+D+QJzT3o3xlyA=;
  b=PSMpJ9TK2sa6mycMgpGfXamzKyngBRr+XyfZQZ2wDzwr6gFMLXDqFZNZ
   tp8BmRaGVFTNYrUxMTQM1XcftDR/o/qrTqxUqYOdg2iPLgEvNXJbAVGSw
   yeo2e09eFMLKQJAo+UiEyXmm3SjUUnCArWgi+oYbwds1Se1ipj78mrjRV
   PUXyfbaWBrPDCtajblMuooRWTLFxG9jsCmzbTKZdnEtO7K5yyEas9XW+O
   Y0GQqXo5bWB69V5bU04i4SxmczXG93IlMRJ9xwAmx7IwAiNxPZ573++NA
   9bd9txleRl98/qCo5U1yXVjM4IrWHkCctdQCO6NjMioesL1+xw5In0p/r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605964"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605964"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782184"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782184"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:26 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id 08331580DAE;
        Wed, 18 Oct 2023 16:16:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 11/17] platform/x86/intel/pmc: Split pmc_core_ssram_get_pmc()
Date:   Wed, 18 Oct 2023 16:16:18 -0700
Message-Id: <20231018231624.1044633-12-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018231624.1044633-1-david.e.box@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com>
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
V4 - Add checking the return value from pmc_core_sram_init() to mtl.c
   - Use iounmap cleanup from io.h

V3 - New patch split from previous PATCH 2
   - Update changelog
   - Use cleanup.h to cleanup ioremap

V2 - no change

 drivers/platform/x86/intel/pmc/core_ssram.c | 91 +++++++++++++--------
 drivers/platform/x86/intel/pmc/mtl.c        | 12 ++-
 2 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 815950713e25..ccb3748dbed9 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/cleanup.h>
 #include <linux/pci.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
@@ -65,44 +66,74 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
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
+	void __iomem __free(iounmap) *main_ssram = NULL;
+	void __iomem __free(iounmap) *secondary_ssram = NULL;
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
+	void __iomem __free(iounmap) *ssram;
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
@@ -113,18 +144,14 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
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
 
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index c3b5f4fe01d1..d1d3d33fb4b8 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -990,12 +990,16 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	mtl_d3_fixup();
 
 	pmcdev->resume = mtl_resume;
-
 	pmcdev->regmap_list = mtl_pmc_info_list;
-	pmc_core_ssram_init(pmcdev);
 
-	/* If regbase not assigned, set map and discover using legacy method */
-	if (!pmc->regbase) {
+	/*
+	 * If ssram init fails use legacy method to at least get the
+	 * primary PMC
+	 */
+	ret = pmc_core_ssram_init(pmcdev);
+	if (ret) {
+		dev_warn(&pmcdev->pdev->dev,
+			 "ssram init failed, %d, using legacy init\n", ret);
 		pmc->map = &mtl_socm_reg_map;
 		ret = get_primary_reg_base(pmc);
 		if (ret)
-- 
2.34.1

