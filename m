Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482017ACE50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjIYCjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjIYCix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877CF1A8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609517; x=1727145517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ldnmU9PmpyGsgjUWNtqkNdEBfhFq4iO9fqdPCxVO+A=;
  b=DIVEzy9PK0/jGRfXqlbUIJxwiSBzfpWgczOu1XwX+VDm5sNgdnekouR9
   CZ89FCtL+h5NU4EznKvQsHZouuhfZwN3mzlzrCspSQxUs0vPw6FvbRn5s
   w6Zjafia4XzX1Vhf71k8Ufl6FM6kXQZ1vpN0CglR0GtK5AOCNnpgXiGga
   P1/B85xm5a5IRPQkArv/8AO2zVBjx9HiKds+4fkOp09jm1IwUbLaH7FYW
   N+nW4huDXcQJSKcA7J+E0PvNQqzYY0Cw1MyDjuG2sC/vd2OdpaTRwUpEV
   0C/3akOprC70QkV9fV3tHj7W7/aYs0XT+badDHOLLGIt1ObcMpQXLc0Jp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360534601"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="360534601"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:38:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777505075"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="777505075"
Received: from jingxues-mobl1.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.254.214.78])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:38:34 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v5 3/6] iommu: Introduce mm_get_pasid() helper function
Date:   Mon, 25 Sep 2023 10:38:10 +0800
Message-Id: <20230925023813.575016-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925023813.575016-1-tina.zhang@intel.com>
References: <20230925023813.575016-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper function mm_get_pasid() to get a mm assigned pasid
value. The motivation is to replace mm->pasid with an iommu private
data structure that is introduced in a later patch.

The mm_get_pasid() is intended for generic usage of mm's pasid.
Using mm_get_pasid() for shared virtual addressing (SVA) with enqcmd
usage is discouraged. Instead, one should consider using
mm_get_enqcmd_pasid().

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Change in v5:
- Update commit message.

Change in v4:
- Rebase to v6.6-rc1.

Changes in v2:
- Update commit message.
- Let mm_get_enqcmd_pasid() call mm_get_pasid() to get pasid.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++------
 drivers/iommu/iommu-sva.c                       | 12 ++++++------
 include/linux/iommu.h                           | 10 +++++++++-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 4d83edc2be99..dbb3af323ede 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -215,7 +215,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 						    smmu_domain);
 	}
 
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain(smmu_domain, mm_get_pasid(mm), start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -233,10 +233,10 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
@@ -290,7 +290,7 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
+	ret = arm_smmu_write_ctx_desc(smmu_domain, mm_get_pasid(mm), cd);
 	if (ret)
 		goto err_put_notifier;
 
@@ -315,7 +315,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 		return;
 
 	list_del(&smmu_mn->list);
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
+	arm_smmu_write_ctx_desc(smmu_domain, mm_get_pasid(mm), NULL);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
@@ -323,7 +323,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain(smmu_domain, mm_get_pasid(mm), 0, 0);
 	}
 
 	/* Frees smmu_mn */
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b78671a8a914..0f956ecd0c9b 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -23,7 +23,7 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
 	if (mm_valid_pasid(mm)) {
-		if (mm->pasid >= dev->iommu->max_pasids)
+		if (mm_get_pasid(mm) >= dev->iommu->max_pasids)
 			ret = -EOVERFLOW;
 		goto out;
 	}
@@ -73,7 +73,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	mutex_lock(&iommu_sva_lock);
 	/* Search for an existing domain. */
-	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
+	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
 						IOMMU_DOMAIN_SVA);
 	if (IS_ERR(domain)) {
 		ret = PTR_ERR(domain);
@@ -92,7 +92,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
+	ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
@@ -124,7 +124,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
 void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 	struct iommu_domain *domain = handle->domain;
-	ioasid_t pasid = domain->mm->pasid;
+	ioasid_t pasid = mm_get_pasid(domain->mm);
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
@@ -141,7 +141,7 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	struct iommu_domain *domain = handle->domain;
 
-	return domain->mm->pasid;
+	return mm_get_pasid(domain->mm);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
@@ -208,5 +208,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 	if (likely(!mm_valid_pasid(mm)))
 		return;
 
-	iommu_free_global_pasid(mm->pasid);
+	iommu_free_global_pasid(mm_get_pasid(mm));
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a4eab6697fe1..db2510da28c1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1189,10 +1189,14 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
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
@@ -1215,6 +1219,10 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
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
2.34.1

