Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADAA7C62EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376888AbjJLCjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376738AbjJLCiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:38:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EDCA9;
        Wed, 11 Oct 2023 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078325; x=1728614325;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UD0nNSwyIv4IWeehjiEni1fHYTZyMVgwi/kofK50zJE=;
  b=ZuIHGRmJ/U1q22Dnl9T/S3vOzZp9jZCoTTuVjD1VBRBN5WhKjDCBueuk
   im3+QGQGrmWQiR4/0UjDyLJkYTokfanPscqzQerUC2otT6gMCFfk/T4uj
   IZc3vlesVON+xFfngqxAVnq5D19NJyRLZk9TNjEeyOrhdfjkcyi9iachl
   KuAsJqNupnRRngMrH7jTlIsOgiR/CEsSPCB56dS5gGfxTmTr6hb7AShYR
   /1edjFIA9JU2fPVe85kGGLbRNNeSiKEC/ZZdUEv2pbWluyKo/vhts+AIu
   suKnqL2gb1wxRA+/KVkAcmDzBAa78a/UfMY+/99h0RytxphZNe3X5wzaZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3402628"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3402628"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783507864"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783507864"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:38:42 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.105.238])
        by linux.intel.com (Postfix) with ESMTP id F3DA3580E33;
        Wed, 11 Oct 2023 19:38:41 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V3 09/16] platform/x86/intel/pmc: Allow pmc_core_ssram_init to fail
Date:   Wed, 11 Oct 2023 19:38:33 -0700
Message-Id: <20231012023840.3845703-10-david.e.box@linux.intel.com>
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

Currently, if the PMC SSRAM initialization fails, no error is returned and
the only indication is that a PMC device has not been created.  Instead,
allow an error to be returned and handled directly by the caller.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - New patch split from V2 PATCH 9
   - Add dev_warn on pmc_core_ssram_init fail

 drivers/platform/x86/intel/pmc/core.h       |  2 +-
 drivers/platform/x86/intel/pmc/core.h       |  2 +-
 drivers/platform/x86/intel/pmc/core_ssram.c | 21 +++++++++++++--------
 drivers/platform/x86/intel/pmc/mtl.c        | 12 ++++++++----
 3 files changed, 22 insertions(+), 13 deletions(-)

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
index 13fa16f0d52e..815950713e25 100644
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
@@ -57,10 +57,12 @@ pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
 
 	if (!pmc->regbase) {
 		devm_kfree(&pmcdev->pdev->dev, pmc);
-		return;
+		return -ENOMEM;
 	}
 
 	pmcdev->pmcs[pmc_index] = pmc;
+
+	return 0;
 }
 
 static void
@@ -96,7 +98,7 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, void __iomem *ssram, u32 offset,
 		iounmap(ssram);
 }
 
-void pmc_core_ssram_init(struct pmc_dev *pmcdev)
+int pmc_core_ssram_init(struct pmc_dev *pmcdev)
 {
 	void __iomem *ssram;
 	struct pci_dev *pcidev;
@@ -105,7 +107,7 @@ void pmc_core_ssram_init(struct pmc_dev *pmcdev)
 
 	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
 	if (!pcidev)
-		goto out;
+		return -ENODEV;
 
 	ret = pcim_enable_device(pcidev);
 	if (ret)
@@ -123,11 +125,14 @@ void pmc_core_ssram_init(struct pmc_dev *pmcdev)
 	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_PCH_OFFSET, PMC_IDX_PCH);
 
 	iounmap(ssram);
-out:
-	return;
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

