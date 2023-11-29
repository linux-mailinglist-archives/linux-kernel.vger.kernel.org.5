Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB77FE303
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbjK2WWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjK2WVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:21:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C58DB6;
        Wed, 29 Nov 2023 14:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701296502; x=1732832502;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=O5UBa7jU0JUDTCsfFNwlMZwtV0vDNoS2o3XqsF3gJ6A=;
  b=PybWZ381m5LLu6R2opu6ez21tIPR9EpTUoeTZ/ln1DHas6cqYtBybASX
   AgBmqgSMg44meJ5ttNIcv1lSm1mHCFKGBnGyB061fzRF175s9CG0tDAvl
   hSaVP5u5xMFQMub56JoU+tuDAa5aZBeFZiYG8vkFYOXNNh5qwfn+4yR3N
   ZnQyjbTG6PvFxK0Oxjl8N1KkrrvT9uQydVHLltA0tJz2GO130ouyiU2M/
   Ry+CxiFA7ki8a9k9/6X6SM7Q5xrT8brgXILv8+zGPL129HXKVl+9acoIz
   c2LUGDHN7M6g7S3WM8UrN9tIok7SJjWUTJxcVA5LkXZE5L6IeDTjqrPiA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11937006"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="11937006"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798070434"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798070434"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 14:21:34 -0800
Received: from debox1-desk4.lan (unknown [10.209.108.167])
        by linux.intel.com (Postfix) with ESMTP id 1E7495807E2;
        Wed, 29 Nov 2023 14:21:34 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: [PATCH V6 12/20] platform/x86/intel/pmc: Allow pmc_core_ssram_init to fail
Date:   Wed, 29 Nov 2023 14:21:24 -0800
Message-Id: <20231129222132.2331261-13-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129222132.2331261-1-david.e.box@linux.intel.com>
References: <20231129222132.2331261-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if the PMC SSRAM initialization fails, no error is returned and
the only indication is that a PMC device has not been created.  Instead,
allow an error to be returned and handled directly by the caller.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V6 - No change

V5 - No change

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

