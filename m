Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D684C79D182
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjILNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbjILNAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:00:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD321708
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694523600; x=1726059600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AEtCz5QpNJCBOMV7ymtz3/MrKBmhEezCWjutjk26iYk=;
  b=baxNtPxotf1vm9fI4s0Mxr73l8u3dRKAUEO8wI5dacxOV+GuNiOUey/2
   hBabKVZdLW0WsjMdv5KJkvsO8bJ4Q/OdZPK09qtJhUH+qXZUiOsaHJl5K
   l2+DmlEAOUcQLK01h68YHQI31r/TK71wJeAxInx5RlsOyVs2/W4jyJNdm
   aSfVqkXhUTX/SfHPBI9SE8PtaqkIADm/je9NYY//9kuE6LLzCdqkZnqbc
   7/RCSaf2jiasv//75kwv0ujBKfQXFuMTZKjB/0ZkR49QH+hjueTqzbZub
   u+dRh+4O50ugptbB4J7Oq88ws80RhBilGP5tq7CA5KICA1HXu4kt0GYOC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378277337"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378277337"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858799351"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858799351"
Received: from tongshi-mobl.ccr.corp.intel.com (HELO tinazhan-desk1.intel.com) ([10.255.28.214])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:59:58 -0700
From:   Tina Zhang <tina.zhang@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v4 5/6] iommu: Support mm PASID 1:n with sva domains
Date:   Tue, 12 Sep 2023 20:59:35 +0800
Message-Id: <20230912125936.722348-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912125936.722348-1-tina.zhang@intel.com>
References: <20230912125936.722348-1-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Changes in v4:
- Rebase to v6.6-rc1.

 drivers/iommu/iommu-sva.c | 35 +++++++++++++++++++++++------------
 include/linux/iommu.h     | 14 +++++++-------
 kernel/fork.c             |  1 -
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 0f956ecd0c9b..79779bbef653 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -15,6 +15,7 @@ static DEFINE_MUTEX(iommu_sva_lock);
 static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
 {
 	ioasid_t pasid;
+	struct iommu_mm_data *iommu_mm;
 	int ret = 0;
 
 	if (!arch_pgtable_dma_compat(mm))
@@ -28,12 +29,22 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device *dev)
 		goto out;
 	}
 
+	iommu_mm = kzalloc(sizeof(struct iommu_mm_data), GFP_KERNEL);
+	if (!iommu_mm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	pasid = iommu_alloc_global_pasid(dev);
 	if (pasid == IOMMU_PASID_INVALID) {
+		kfree(iommu_mm);
 		ret = -ENOSPC;
 		goto out;
 	}
-	mm->pasid = pasid;
+	iommu_mm->pasid = pasid;
+	INIT_LIST_HEAD(&iommu_mm->sva_domains);
+	mm->iommu_mm = iommu_mm;
+
 	ret = 0;
 out:
 	mutex_unlock(&iommu_sva_lock);
@@ -73,16 +84,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
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
@@ -96,6 +103,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
+	list_add(&domain->next, &mm->iommu_mm->sva_domains);
+
 out:
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
@@ -128,8 +137,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
+	iommu_detach_device_pasid(domain, dev, pasid);
 	if (--domain->users == 0) {
-		iommu_detach_device_pasid(domain, dev, pasid);
+		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
 	mutex_unlock(&iommu_sva_lock);
@@ -209,4 +219,5 @@ void mm_pasid_drop(struct mm_struct *mm)
 		return;
 
 	iommu_free_global_pasid(mm_get_pasid(mm));
+	kfree(mm->iommu_mm);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b9c9f14a95cc..c61bc45d5a82 100644
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
@@ -1186,17 +1191,13 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
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
 static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 {
@@ -1222,7 +1223,6 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
-static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
 static inline u32 mm_get_pasid(struct mm_struct *mm)
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
2.34.1

