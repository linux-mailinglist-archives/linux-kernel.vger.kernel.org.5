Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115467CD358
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjJRFHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjJRFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:07:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F7A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697605628; x=1729141628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TwlWdc8jKkVm/Zmn4ZCqgN7Ast0uvZUB8ihq7Bkxoqg=;
  b=httwKBConFcSCBGE9Z6XcJbXdfZnqQ6TJSnY9CxDpACKCMFxbFf/F+pi
   0E9hL13jsboR7POAfZmFmDIcqkF3BJ+a6k+wiSb6wz43o9W1F/Wm2Ep+9
   aQr55x/dGyoBq64690dzxvSnBp3gk4Y0l6r5opylyTSrECHhVdnxPzYwa
   nAXhHt02TrRKw9FiEfECYi21ApqWb8JkORJvzInV/aOlgkV5hCtf7rviL
   vPjrqR9y9eHRlu756tBfxEZ+FUSZRVBeL+TkuHYlSZyzk5qvhQ28SVR+7
   0CGGz0lDgPdd0fh562e844rE8pLwOozIB1Yn1ZRJViEm15hdAhO3gPfLq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388802419"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="388802419"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 22:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822288648"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="822288648"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2023 22:07:04 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tina Zhang <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v9 2/5] iommu: Add mm_get_enqcmd_pasid() helper function
Date:   Wed, 18 Oct 2023 13:06:37 +0800
Message-Id: <20231018050640.24936-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231018050640.24936-1-tina.zhang@intel.com>
References: <20231018050640.24936-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_get_enqcmd_pasid() should be used by architecture code and closely
related to learn the PASID value that the x86 ENQCMD operation should
use for the mm.

For the moment SMMUv3 uses this without any connection to ENQCMD, it
will be cleaned up similar to how the prior patch made VT-d use the
PASID argument of set_dev_pasid().

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Change in v7:
- Update the commit message.

Changes in v6:
- Let SMMUv3 call mm_get_enqcmd_pasid().
- Let iommu_sva_get_pasid() call mm_get_enqcmd_pasid().

Change in v2:
- Change mm_get_pasid() to mm_get_enqcmd_pasid()

 arch/x86/kernel/traps.c                         |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 14 +++++++-------
 drivers/iommu/iommu-sva.c                       |  2 +-
 include/linux/iommu.h                           | 12 ++++++++++++
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c876f1d36a81..832f4413d96a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -591,7 +591,7 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!mm_valid_pasid(current->mm))
 		return false;
 
-	pasid = current->mm->pasid;
+	pasid = mm_get_enqcmd_pasid(current->mm);
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 353248ab18e7..6d9949ce5b32 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -246,7 +246,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						    smmu_domain);
 	}
 
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain(smmu_domain, mm_get_enqcmd_pasid(mm), start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -264,10 +264,10 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	arm_smmu_update_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
+	arm_smmu_update_ctx_desc_devices(smmu_domain, mm_get_enqcmd_pasid(mm), &quiet_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, mm_get_enqcmd_pasid(mm), 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -325,10 +325,10 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		ret = arm_smmu_write_ctx_desc(master, mm->pasid, cd);
+		ret = arm_smmu_write_ctx_desc(master, mm_get_enqcmd_pasid(mm), cd);
 		if (ret) {
 			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
-				arm_smmu_write_ctx_desc(master, mm->pasid, NULL);
+				arm_smmu_write_ctx_desc(master, mm_get_enqcmd_pasid(mm), NULL);
 			break;
 		}
 	}
@@ -358,7 +358,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 
 	list_del(&smmu_mn->list);
 
-	arm_smmu_update_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
+	arm_smmu_update_ctx_desc_devices(smmu_domain, mm_get_enqcmd_pasid(mm), NULL);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
@@ -366,7 +366,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain(smmu_domain, mm_get_enqcmd_pasid(mm), 0, 0);
 	}
 
 	/* Frees smmu_mn */
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b78671a8a914..4a2f5699747f 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -141,7 +141,7 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	struct iommu_domain *domain = handle->domain;
 
-	return domain->mm->pasid;
+	return mm_get_enqcmd_pasid(domain->mm);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b5b254e205c6..8aa5910190d1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1198,6 +1198,12 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
 	return mm->pasid != IOMMU_PASID_INVALID;
 }
+
+static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
+{
+	return mm->pasid;
+}
+
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
@@ -1220,6 +1226,12 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
+
+static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
+{
+	return IOMMU_PASID_INVALID;
+}
+
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
 
-- 
2.39.3

