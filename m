Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2C7C4B01
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbjJKGwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbjJKGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:51:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95138B9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697007107; x=1728543107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0gdYVVw2Oz6gBYf/B822DQyIKOOjP+ypYh8dXrRo49c=;
  b=SIdGPSmj2rfaM8BgFpEeADgtb5QjNj5sv5ADREwr7QhoO6Bi8a0ikUyN
   XrW70lhtK9RLGWXr1c1lynK0m+BOwszXl6H7H8QX4VLCfm5aGZUz/RECG
   2yLEMi137Z5vOd5URMr1ZHuSLdLCoDQT2S1x23OEZC/zurC3rcKE65ejT
   bR1P4C/xAxMmdj6qo31BPU5pLjsCMqb/wVHgltf5T86cwqAfGLSxD6FP2
   dSjZHywMok87l1e9/bBMWZkSdm2OdzaFJDqAFpiJ2JqE1DhrxC/YlvdO2
   CjsKxy4sspvA+HTct/7DWERZM1TdgaJcGBqt8LSlpoL3B2Tc5HXibMP/i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387436971"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387436971"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 23:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824050276"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824050276"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2023 23:51:45 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [v6 PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Date:   Wed, 11 Oct 2023 14:51:31 +0800
Message-Id: <20231011065132.102676-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231011065132.102676-1-tina.zhang@intel.com>
References: <20231011065132.102676-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each mm bound to devices gets a PASID and corresponding sva domains
allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
field of the mm. The PASID is released in __mmdrop(), while a sva domain
is released when no one is using it (the reference count is decremented
in iommu_sva_unbind_device()). However, although sva domains and their
PASID are separate objects such that their own life cycles could be
handled independently, an enqcmd use case may require releasing the
PASID in releasing the mm (i.e., once a PASID is allocated for a mm, it
will be permanently used by the mm and won't be released until the end
of mm) and only allows to drop the PASID after the sva domains are
released. To this end, mmgrab() is called in iommu_sva_domain_alloc() to
increment the mm reference count and mmdrop() is invoked in
iommu_domain_free() to decrement the mm reference count.

Since the required info of PASID and sva domains is kept in struct
iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
field in mm struct. The sva domain list is protected by iommu_sva_lock.

Besides, this patch removes mm_pasid_init(), as with the introduced
iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Change in v6:
- Rename iommu_sva_alloc_pasid() to iommu_alloc_mm_data().
- Hold the iommu_sva_lock before invoking iommu_alloc_mm_data().

Change in v5:
- Use smp_store_release() & READ_ONCE() in storing and loading mm's
  pasid value.

Change in v4:
- Rebase to v6.6-rc1.

 drivers/iommu/iommu-sva.c | 92 +++++++++++++++++++++++----------------
 include/linux/iommu.h     | 18 +++++---
 kernel/fork.c             |  1 -
 3 files changed, 65 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 4a2f5699747f..5175e8d85247 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -12,32 +12,42 @@
 static DEFINE_MUTEX(iommu_sva_lock);
 
 /* Allocate a PASID for the mm within range (inclusive) */
-static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
+static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct device *dev)
 {
+	struct iommu_mm_data *iommu_mm;
 	ioasid_t pasid;
-	int ret = 0;
+
+	lockdep_assert_held(&iommu_sva_lock);
 
 	if (!arch_pgtable_dma_compat(mm))
-		return -EBUSY;
+		return ERR_PTR(-EBUSY);
 
-	mutex_lock(&iommu_sva_lock);
+	iommu_mm = mm->iommu_mm;
 	/* Is a PASID already associated with this mm? */
-	if (mm_valid_pasid(mm)) {
-		if (mm->pasid >= dev->iommu->max_pasids)
-			ret = -EOVERFLOW;
-		goto out;
+	if (iommu_mm) {
+		if (iommu_mm->pasid >= dev->iommu->max_pasids)
+			return ERR_PTR(-EOVERFLOW);
+		return iommu_mm;
 	}
 
+	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
+	if (!iommu_mm)
+		return ERR_PTR(-ENOMEM);
+
 	pasid = iommu_alloc_global_pasid(dev);
 	if (pasid == IOMMU_PASID_INVALID) {
-		ret = -ENOSPC;
-		goto out;
+		kfree(iommu_mm);
+		return ERR_PTR(-ENOSPC);
 	}
-	mm->pasid = pasid;
-	ret = 0;
-out:
-	mutex_unlock(&iommu_sva_lock);
-	return ret;
+	iommu_mm->pasid = pasid;
+	INIT_LIST_HEAD(&iommu_mm->sva_domains);
+	/*
+	 * Make sure the write to mm->iommu_mm is not reordered in front of
+	 * initialization to iommu_mm fields. If it does, readers may see a
+	 * valid iommu_mm with uninitialized values.
+	 */
+	smp_store_release(&mm->iommu_mm, iommu_mm);
+	return iommu_mm;
 }
 
 /**
@@ -58,31 +68,33 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
  */
 struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
+	struct iommu_mm_data *iommu_mm;
 	struct iommu_domain *domain;
 	struct iommu_sva *handle;
 	int ret;
 
+	mutex_lock(&iommu_sva_lock);
+
 	/* Allocate mm->pasid if necessary. */
-	ret = iommu_sva_alloc_pasid(mm, dev);
-	if (ret)
-		return ERR_PTR(ret);
+	iommu_mm = iommu_alloc_mm_data(mm, dev);
+	if (IS_ERR(iommu_mm)) {
+		ret = PTR_ERR(iommu_mm);
+		goto out_unlock;
+	}
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return ERR_PTR(-ENOMEM);
-
-	mutex_lock(&iommu_sva_lock);
-	/* Search for an existing domain. */
-	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
-						IOMMU_DOMAIN_SVA);
-	if (IS_ERR(domain)) {
-		ret = PTR_ERR(domain);
+	if (!handle) {
+		ret = -ENOMEM;
 		goto out_unlock;
 	}
 
-	if (domain) {
-		domain->users++;
-		goto out;
+	/* Search for an existing domain. */
+	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
+		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
+		if (!ret) {
+			domain->users++;
+			goto out;
+		}
 	}
 
 	/* Allocate a new domain and set it on device pasid. */
@@ -92,23 +104,23 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
+	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
+	list_add(&domain->next, &mm->iommu_mm->sva_domains);
+
 out:
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
 	handle->domain = domain;
-
 	return handle;
 
 out_free_domain:
 	iommu_domain_free(domain);
+	kfree(handle);
 out_unlock:
 	mutex_unlock(&iommu_sva_lock);
-	kfree(handle);
-
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
@@ -124,12 +136,13 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
 void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 	struct iommu_domain *domain = handle->domain;
-	ioasid_t pasid = domain->mm->pasid;
+	struct iommu_mm_data *iommu_mm = domain->mm->iommu_mm;
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
+	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
-		iommu_detach_device_pasid(domain, dev, pasid);
+		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
 	mutex_unlock(&iommu_sva_lock);
@@ -205,8 +218,11 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 
 void mm_pasid_drop(struct mm_struct *mm)
 {
-	if (likely(!mm_valid_pasid(mm)))
+	struct iommu_mm_data *iommu_mm = mm->iommu_mm;
+
+	if (!iommu_mm)
 		return;
 
-	iommu_free_global_pasid(mm->pasid);
+	iommu_free_global_pasid(iommu_mm->pasid);
+	kfree(iommu_mm);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index dc1f98e12f4b..bd79d4e4af89 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -109,6 +109,11 @@ struct iommu_domain {
 		struct {	/* IOMMU_DOMAIN_SVA */
 			struct mm_struct *mm;
 			int users;
+			/*
+			 * Next iommu_domain in mm->iommu_mm->sva-domains list
+			 * protected by iommu_sva_lock.
+			 */
+			struct list_head next;
 		};
 	};
 };
@@ -1186,17 +1191,17 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 }
 
 #ifdef CONFIG_IOMMU_SVA
-static inline void mm_pasid_init(struct mm_struct *mm)
-{
-	mm->pasid = IOMMU_PASID_INVALID;
-}
 static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
-	return mm->pasid != IOMMU_PASID_INVALID;
+	return READ_ONCE(mm->iommu_mm);
 }
 static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 {
-	return mm->pasid;
+	struct iommu_mm_data *iommu_mm = READ_ONCE(mm->iommu_mm);
+
+	if (!iommu_mm)
+		return IOMMU_PASID_INVALID;
+	return iommu_mm->pasid;
 }
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
@@ -1218,7 +1223,6 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
-static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 3b6d20dfb9a8..985403a7a747 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1277,7 +1277,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
-	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-- 
2.39.3

