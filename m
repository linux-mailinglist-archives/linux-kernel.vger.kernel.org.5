Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF1791FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 02:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjIEAKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 20:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbjIEAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 20:10:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277ACDC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693872615; x=1725408615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Pvz3GjgnM5Ebh9fF4knA2p0WYHUQpi6IjVqQrxFdID8=;
  b=CVEbd0n3BGnuicpaILV2RWHVt942GztafSL8S4G4k1jq9H+soyUL/rZJ
   HLgYCO/OXajYaW7WJ+YQGnPfTwy26FCuhbVPEwoKg0kAy1w81ybZtcljb
   1bOCBD9T+Nv9Rif4d/S4CfbOsy1zb2mMhR44R6P9YKoyglD05mSRiu8Z/
   misHHWte2ZkEN5EccnFZxlYmxRUtA6x4JftNYgcls2MWt2paFKwS6jnML
   XNnglwf3VXPzyYKOd8Yfa1TuQ1+BunnEj5WfYI/j7hbXfdNnOPdPhCklo
   hbSXlgVgciVxA4+Kr+yJhmSX4udF1rd0yOVLRMgeIGPlO7ojH78xTmX9y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="463039970"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="463039970"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 17:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884125130"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="884125130"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2023 17:09:52 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 3/6] iommu: Introduce mm_get_pasid() helper function
Date:   Tue,  5 Sep 2023 08:09:27 +0800
Message-Id: <20230905000930.24515-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905000930.24515-1-tina.zhang@intel.com>
References: <20230905000930.24515-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper function mm_get_pasid() to get a mm assigned pasid
value. The motivation is to replace mm->pasid with an iommu private
data structure that is introduced in a later patch.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Changes in v2:
- Update commit message
- Let mm_get_enqcmd_pasid() call mm_get_pasid() to get pasid

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++------
 drivers/iommu/iommu-sva.c                       | 14 +++++++-------
 include/linux/iommu.h                           | 10 +++++++++-
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947e..0b455654d365 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -204,7 +204,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
 		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
 					    PAGE_SIZE, false, smmu_domain);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain(smmu_domain, mm_get_pasid(mm), start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -222,10 +222,10 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
+	arm_smmu_write_ctx_desc(smmu_domain, mm_get_pasid(mm), &quiet_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, mm_get_pasid(mm), 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -279,7 +279,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
+	ret = arm_smmu_write_ctx_desc(smmu_domain, mm_get_pasid(mm), cd);
 	if (ret)
 		goto err_put_notifier;
 
@@ -304,7 +304,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 		return;
 
 	list_del(&smmu_mn->list);
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
+	arm_smmu_write_ctx_desc(smmu_domain, mm_get_pasid(mm), NULL);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
@@ -312,7 +312,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain(smmu_domain, mm_get_pasid(mm), 0, 0);
 	}
 
 	/* Frees smmu_mn */
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 05c0fb2acbc4..0a4a1ed40814 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -28,7 +28,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
 	if (mm_valid_pasid(mm)) {
-		if (mm->pasid < min || mm->pasid > max)
+		if (mm_get_pasid(mm) < min || mm_get_pasid(mm) > max)
 			ret = -EOVERFLOW;
 		goto out;
 	}
@@ -71,7 +71,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (!max_pasids)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	/* Allocate mm->pasid if necessary. */
+	/* Allocate pasid if necessary. */
 	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
 	if (ret)
 		return ERR_PTR(ret);
@@ -82,7 +82,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	mutex_lock(&iommu_sva_lock);
 	/* Search for an existing domain. */
-	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
+	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
 						IOMMU_DOMAIN_SVA);
 	if (IS_ERR(domain)) {
 		ret = PTR_ERR(domain);
@@ -101,7 +101,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
+	ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
@@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
 void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 	struct iommu_domain *domain = handle->domain;
-	ioasid_t pasid = domain->mm->pasid;
+	ioasid_t pasid = mm_get_pasid(domain->mm);
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
@@ -150,7 +150,7 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	struct iommu_domain *domain = handle->domain;
 
-	return domain->mm->pasid;
+	return mm_get_pasid(domain->mm);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
@@ -217,5 +217,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 	if (likely(!mm_valid_pasid(mm)))
 		return;
 
-	ida_free(&iommu_global_pasid_ida, mm->pasid);
+	ida_free(&iommu_global_pasid_ida, mm_get_pasid(mm));
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ab9919746fd3..ab8784dfdbd9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1180,10 +1180,14 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
 	return mm->pasid != IOMMU_PASID_INVALID;
 }
-static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
+static inline u32 mm_get_pasid(struct mm_struct *mm)
 {
 	return mm->pasid;
 }
+static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
+{
+	return mm_get_pasid(mm);
+}
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
@@ -1206,6 +1210,10 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
+static inline u32 mm_get_pasid(struct mm_struct *mm)
+{
+	return IOMMU_PASID_INVALID;
+}
 static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 {
 	return IOMMU_PASID_INVALID;
-- 
2.17.1

