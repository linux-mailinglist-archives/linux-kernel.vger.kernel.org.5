Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE5773F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjHHQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjHHQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:43:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5C55BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510140; x=1723046140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=myuEuHSAILfOpPq4xlnak3sZ+xUPplX7XLY6m7PLmVQ=;
  b=CU+03GQQ9mSjVpBtIpL9nud1fkd9DAzhFGu+k+lh+m7G55i9d8ASR8Ik
   9/9ISSt5uLa+bI7umvw3dNJyNxVgS4pBXkN47IHc8IFJHkhG80pejRsr4
   zF0UB/sQyEt4o433g1kd97JTLAlwOktB+kBWRffWH/mlXXWVOalBD9mcH
   0AGEBI8aexYIbsDyKbSxZbzZ1k786UYasaxK90e6gAOj4XtzUxR32tMU6
   uIi9zP1jL0+sMhPVL+XsQwoM2ijI6iZa7Z7Byp3HAy/h/rhrSOkJO0FNK
   lls0OGeMDFsL51hrp3p/KnXNH0J3FNy67epOZrXYfClEJHp/2gVLUCy8J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437078693"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437078693"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681146403"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681146403"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.156.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 00:50:02 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Date:   Tue,  8 Aug 2023 15:49:43 +0800
Message-Id: <20230808074944.7825-5-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808074944.7825-1-tina.zhang@intel.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each mm bound to devices gets a PASID and corresponding sva domains
allocated in iommu_sva_bind_device(), which are referenced by iommu_mm
field of the mm. The PASID is released in __mmdrop(), while a sva domain
is released when on one is using it (the reference count is decremented
in iommu_sva_unbind_device()).

Since the required info of PASID and sva domains is kept in struct
iommu_mm_data of a mm, use mm->iommu_mm field instead of the old pasid
field in mm struct. The sva domain list is protected by iommu_sva_lock.

Besides, this patch removes mm_pasid_init(), as with the introduced
iommu_mm structure, initializing mm pasid in mm_init() is unnecessary.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/iommu-sva.c | 38 +++++++++++++++++++++++++-------------
 include/linux/iommu.h     | 10 +++-------
 kernel/fork.c             |  1 -
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 0a4a1ed40814..35366f51ad27 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -15,6 +15,7 @@ static DEFINE_IDA(iommu_global_pasid_ida);
 /* Allocate a PASID for the mm within range (inclusive) */
 static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 {
+	struct iommu_mm_data *iommu_mm = NULL;
 	int ret = 0;
 
 	if (min == IOMMU_PASID_INVALID ||
@@ -33,11 +34,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t ma
 		goto out;
 	}
 
+	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
+	if (!iommu_mm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_KERNEL);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(iommu_mm);
 		goto out;
+	}
+
+	iommu_mm->pasid = ret;
+	mm->iommu_mm = iommu_mm;
+	INIT_LIST_HEAD(&mm->iommu_mm->sva_domains);
 
-	mm->pasid = ret;
 	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
@@ -82,16 +94,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	mutex_lock(&iommu_sva_lock);
 	/* Search for an existing domain. */
-	domain = iommu_get_domain_for_dev_pasid(dev, mm_get_pasid(mm),
-						IOMMU_DOMAIN_SVA);
-	if (IS_ERR(domain)) {
-		ret = PTR_ERR(domain);
-		goto out_unlock;
-	}
-
-	if (domain) {
-		domain->users++;
-		goto out;
+	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
+		ret = iommu_attach_device_pasid(domain, dev, mm_get_pasid(mm));
+		if (!ret) {
+			domain->users++;
+			goto out;
+		}
 	}
 
 	/* Allocate a new domain and set it on device pasid. */
@@ -105,6 +113,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
+	list_add(&domain->next, &mm->iommu_mm->sva_domains);
+
 out:
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
@@ -137,8 +147,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
+	iommu_detach_device_pasid(domain, dev, pasid);
 	if (--domain->users == 0) {
-		iommu_detach_device_pasid(domain, dev, pasid);
+		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
 	mutex_unlock(&iommu_sva_lock);
@@ -218,4 +229,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 		return;
 
 	ida_free(&iommu_global_pasid_ida, mm_get_pasid(mm));
+	kfree(mm->iommu_mm);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 435d1c1afd23..6a87df6d8637 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -109,6 +109,7 @@ struct iommu_domain {
 		struct {	/* IOMMU_DOMAIN_SVA */
 			struct mm_struct *mm;
 			int users;
+			struct list_head next;
 		};
 	};
 };
@@ -1177,17 +1178,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 }
 
 #ifdef CONFIG_IOMMU_SVA
-static inline void mm_pasid_init(struct mm_struct *mm)
-{
-	mm->pasid = IOMMU_PASID_INVALID;
-}
 static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
-	return mm->pasid != IOMMU_PASID_INVALID;
+	return mm->iommu_mm ? true : false;
 }
 static inline u32 mm_get_pasid(struct mm_struct *mm)
 {
-	return mm->pasid;
+	return mm->iommu_mm ? mm->iommu_mm->pasid : IOMMU_PASID_INVALID;
 }
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
@@ -1209,7 +1206,6 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
-static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline u32 mm_get_pasid(struct mm_struct *mm)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index d2e12b6d2b18..f06392dd1ca8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1274,7 +1274,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
 	mm_init_owner(mm, p);
-	mm_pasid_init(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-- 
2.17.1

