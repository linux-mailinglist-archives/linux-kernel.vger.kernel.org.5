Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66917CEBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjJRXRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJRXQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:16:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C487123;
        Wed, 18 Oct 2023 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697670989; x=1729206989;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=q1Y1U/47kZM9h2ESP1lpqm0HnFB6ay06aMAyMzOh2eE=;
  b=k+dtvqEot1tKWEMs5mEHEaugE7veKJT02Ys5YG07QZd7zTh5PO2bzii3
   i39kuYtx/7xbh1UCHFwGz8GYRR/Y5kIcqk0CbQEDbKZpFU+ujmVQkM1X3
   90j3dUNMwWsOi4M5KW9iUkV64XEw+L+VM2IEVJ9qXdieHR2OPjapOZrLV
   MnGOoJ0lAEo+Z9I0fa16mT39QnNWkDVcDMVlZIviiAM2nn1+U3CBQA/1I
   hj3w1Hk88DXASGyL/3GhRd4iwIdWL6eBA6+AsgYg3C+EYXuOdfnnsK2EO
   y5SOmQVUOJtF/k0NlIUM/6R2a9Oz/vZ/8v/NzfQC95P3JdYL9x4GD2BKP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="452605960"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="452605960"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756782177"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756782177"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:16:25 -0700
Received: from debox1-desk4.lan (unknown [10.209.71.91])
        by linux.intel.com (Postfix) with ESMTP id A7BE8580DD4;
        Wed, 18 Oct 2023 16:16:25 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V4 09/17] platform/x86/intel/pmc: Allow pmc_core_ssram_init to fail
Date:   Wed, 18 Oct 2023 16:16:16 -0700
Message-Id: <20231018231624.1044633-10-david.e.box@linux.intel.com>
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

Currently, if the PMC SSRAM initialization fails, no error is returned and
the only indication is that a PMC device has not been created.  Instead,
allow an error to be returned and handled directly by the caller. Don't use
the return value yet. This is in preparation for a future rework of
pmc_core_sram_init().

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V4 - Remove return value check in mtl.c. Proper use of the value would
     require returning an error status from pmc_core_add_pmc(). But
     the function that calls it will be removed in the next patch so wait
     to use it then.

V3 - New patch split from V2 PATCH 9
   - Add dev_warn on pmc_core_ssram_init fail

 drivers/platform/x86/intel/pmc/core.h       |  2 +-
 drivers/platform/x86/intel/pmc/core_ssram.c | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

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
-- 
2.34.1

