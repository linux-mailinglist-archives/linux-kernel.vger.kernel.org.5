Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB17ABB22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjIVVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIVVal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:30:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB7EFB;
        Fri, 22 Sep 2023 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695418235; x=1726954235;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LTJvjLbkvuQx4wE/Sd6xPXoCn0gNEKM0z+EbfC949UM=;
  b=Nxuyt8IUn4OrG1JZrz74MVL2Wjj4CZ9c7MgbfD3D0rqyJZgHq5iEX+od
   2yEmbO/XUZX1WTmAiTPX07RkuZD2qQ5iDJc4KavZXufnHQHTW2ySMiVMg
   ggoGUjd1v0HIuxs/SkfXETcnBp/OhipYosAEiN5H8BMGU5ePOPt3F/VjU
   5LudrkK/klDIEQ01YBeDBgHoc4atCJ1Sr9BaA5IcnkmKwmla8YLyA9V6i
   VZrZLGJPCm0KjhqCPMHcwFlIW1YKowjlAQeCETZVi7/uU3sqQPciHJgPn
   RCy1Tn2EpzAU0VkOoo8W5EYduUnNAbZqGeDIK4B+OG9xNFem7mdD/DoLT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="371264694"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="371264694"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="747685324"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="747685324"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 14:30:33 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.188.234])
        by linux.intel.com (Postfix) with ESMTP id 684BA580DB2;
        Fri, 22 Sep 2023 14:30:33 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, david.e.box@linux.intel.com,
        platform-driver-x86@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH 06/11] platform/x86/intel/pmc: Split pmc_core_ssram_get_pmc()
Date:   Fri, 22 Sep 2023 14:30:27 -0700
Message-Id: <20230922213032.1770590-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922213032.1770590-1-david.e.box@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each PMC has an associated SSRAM device for accessing additional counters.
However, only the first is discoverable as a PCI device to the OS. The
remaining devices are hidden but their BARs are still accessible and their
addresses are stored in the BAR of the exposed device. Clean up the code
handling the SSRAM discovery. Create two separate functions for finding the
primary and secondary PMCs.  Also changes the return type from void to
allow returning an error when failing to find the primary PMC.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h       |   2 +-
 drivers/platform/x86/intel/pmc/core_ssram.c | 127 ++++++++++++++------
 drivers/platform/x86/intel/pmc/mtl.c        |  10 +-
 3 files changed, 96 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ccf24e0f5e50..edaa70067e41 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -492,7 +492,7 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
 extern void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev);
 
-extern void pmc_core_ssram_init(struct pmc_dev *pmcdev);
+extern int pmc_core_ssram_init(struct pmc_dev *pmcdev);
 
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 13fa16f0d52e..ab5cc07fb177 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -35,20 +35,20 @@ static inline u64 get_base(void __iomem *addr, u32 offset)
 	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
 }
 
-static void
+static int
 pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
 		 const struct pmc_reg_map *reg_map, int pmc_index)
 {
 	struct pmc *pmc = pmcdev->pmcs[pmc_index];
 
 	if (!pwrm_base)
-		return;
+		return -ENODEV;
 
 	/* Memory for primary PMC has been allocated in core.c */
 	if (!pmc) {
 		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
 		if (!pmc)
-			return;
+			return -ENOMEM;
 	}
 
 	pmc->map = reg_map;
@@ -57,77 +57,128 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
 
 	if (!pmc->regbase) {
 		devm_kfree(&pmcdev->pdev->dev, pmc);
-		return;
+		return -ENOMEM;
 	}
 
 	pmcdev->pmcs[pmc_index] = pmc;
+
+	return 0;
 }
 
-static void
-pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, void __iomem *ssram, u32 offset,
-		       int pmc_idx)
+static int
+pmc_core_get_secondary_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
 {
-	u64 pwrm_base;
+	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
+	const struct pmc_reg_map *map;
+	void __iomem *main_ssram, *secondary_ssram;
+	u64 ssram_base, pwrm_base;
 	u16 devid;
+	int ret;
+
+	if (!pmcdev->regmap_list)
+		return -ENOENT;
 
-	if (pmc_idx != PMC_IDX_SOC) {
-		u64 ssram_base = get_base(ssram, offset);
+	/*
+	 * The secondary PMC BARS (which are behind hidden PCI devices) are read
+	 * from fixed offsets in MMIO of the primary PMC BAR.
+	 */
+	ssram_base = ssram_pcidev->resource[0].start;
+	main_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!main_ssram)
+		return -ENOMEM;
+
+	ssram_base = get_base(main_ssram, offset);
+	secondary_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!secondary_ssram) {
+		ret = -ENOMEM;
+		goto secondary_remap_fail;
+	}
 
-		if (!ssram_base)
-			return;
+	pwrm_base = get_base(secondary_ssram, SSRAM_PWRM_OFFSET);
+	devid = readw(secondary_ssram + SSRAM_DEVID_OFFSET);
 
-		ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-		if (!ssram)
-			return;
+	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
+	if (!map) {
+		ret = -ENODEV;
+		goto find_regmap_fail;
 	}
 
+	ret = pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
+
+find_regmap_fail:
+	iounmap(secondary_ssram);
+secondary_remap_fail:
+	iounmap(main_ssram);
+
+	return ret;
+
+}
+
+static int
+pmc_core_get_primary_pmc(struct pmc_dev *pmcdev)
+{
+	struct pci_dev *ssram_pcidev = pmcdev->ssram_pcidev;
+	const struct pmc_reg_map *map;
+	void __iomem *ssram;
+	u64 ssram_base, pwrm_base;
+	u16 devid;
+	int ret;
+
+	if (!pmcdev->regmap_list)
+		return -ENOENT;
+
+	/* The primary PMC (SOC die) BAR is BAR 0 in config space. */
+	ssram_base = ssram_pcidev->resource[0].start;
+	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!ssram)
+		return -ENOMEM;
+
 	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
 	devid = readw(ssram + SSRAM_DEVID_OFFSET);
 
-	if (pmcdev->regmap_list) {
-		const struct pmc_reg_map *map;
-
-		map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
-		if (map)
-			pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
+	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
+	if (!map) {
+		ret = -ENODEV;
+		goto find_regmap_fail;
 	}
 
-	if (pmc_idx != PMC_IDX_SOC)
-		iounmap(ssram);
+	ret = pmc_core_pmc_add(pmcdev, pwrm_base, map, PMC_IDX_MAIN);
+
+find_regmap_fail:
+	iounmap(ssram);
+
+	return ret;
 }
 
-void pmc_core_ssram_init(struct pmc_dev *pmcdev)
+int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 {
-	void __iomem *ssram;
 	struct pci_dev *pcidev;
-	u64 ssram_base;
 	int ret;
 
 	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
 	if (!pcidev)
-		goto out;
+		return -ENODEV;
 
 	ret = pcim_enable_device(pcidev);
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
-out:
-	return;
+	pmc_core_get_secondary_pmc(pmcdev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
+	pmc_core_get_secondary_pmc(pmcdev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
+
+	return 0;
 
 disable_dev:
+	pmcdev->ssram_pcidev = NULL;
 	pci_disable_device(pcidev);
 release_dev:
 	pci_dev_put(pcidev);
+
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index c3b5f4fe01d1..780874142a90 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -990,12 +990,14 @@ int mtl_core_init(struct pmc_dev *pmcdev)
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
 		pmc->map = &mtl_socm_reg_map;
 		ret = get_primary_reg_base(pmc);
 		if (ret)
-- 
2.34.1

