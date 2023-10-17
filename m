Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9407CB79C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjJQAs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjJQAsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:48:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A226FF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697503726; x=1729039726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qwhtfzvsMcijGtPZ/mvSqJFHLXrk93hlOJKVq+skKk=;
  b=l7tG1vK5ajcsn0hax0FTLVTKXn7ojtxNfJndSekfYd/ee1mC+oG3rf6B
   sMdtAHuKV/y1QymN1Jp5M/ULiC6Jk6wwjlQsQlyWo8md9h9Auo31vGo1V
   NDa9K9j5W+z3cx1KqJeDnoxdUllraSHIbtVda91zctfQugLgz511lFi/i
   +krJshQjbpEEswot8BexNknvIspYm4sxl8k4V98SnbjqC+ggTR35rRVhh
   0qz5HMmn7ChFV9aNJDdH1gw/lvCKQe3BsKVZ2765YpzkmB2oULs+Fi/E1
   AUmRXnSgE9TJdmWQJWY9JAJL9tzOU0Fo8euaQo6FETMFZZ0xo6Ymxj15f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="382893351"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="382893351"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 17:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705793783"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="705793783"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by orsmga003.jf.intel.com with ESMTP; 16 Oct 2023 17:48:41 -0700
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
Subject: [PATCH v8 4/5] iommu: Support mm PASID 1:n with sva domains
Date:   Tue, 17 Oct 2023 08:48:01 +0800
Message-Id: <20231017004802.109618-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231017004802.109618-1-tina.zhang@intel.com>
References: <20231017004802.109618-1-tina.zhang@intel.com>
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Change in v7:
- Add mm_pasid_init() back and do zeroing mm->iommu_mm pointer in
  mm_pasid_init() to avoid the use-after-free/double-free problem.

Changes in v6:
- Rename iommu_sva_alloc_pasid() to iommu_alloc_mm_data().
- Hold the iommu_sva_lock before invoking iommu_alloc_mm_data().

Change in v5:
- Use smp_store_release() & READ_ONCE() in storing and loading mm's
  pasid value.

Change in v4:
- Rebase to v6.6-rc1.

 drivers/iommu/iommu-sva.c | 92 +++++++++++++++++++++++----------------
 include/linux/iommu.h     | 23 ++++++++--
 2 files changed, 74 insertions(+), 41 deletions(-)

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
index e350520e3a35..19b5ae2303ff 100644
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
@@ -1188,16 +1193,28 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 #ifdef CONFIG_IOMMU_SVA
 static inline void mm_pasid_init(struct mm_struct *mm)
 {
-	mm->pasid = IOMMU_PASID_INVALID;
+	/*
+	 * During dup_mm(), a new mm will be memcpy'd from an old one and that makes
+	 * the new mm and the old one point to a same iommu_mm instance. When either
+	 * one of the two mms gets released, the iommu_mm instance is freed, leaving
+	 * the other mm running into a use-after-free/double-free problem. To avoid
+	 * the problem, zeroing the iommu_mm pointer of a new mm is needed here.
+	 */
+	mm->iommu_mm = NULL;
 }
+
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
-- 
2.39.3

