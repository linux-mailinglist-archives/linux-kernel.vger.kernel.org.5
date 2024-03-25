Return-Path: <linux-kernel+bounces-116410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587DA889AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4FF1C2DED7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E30148FF7;
	Mon, 25 Mar 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQWtVOZQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325E15538A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333111; cv=none; b=lSqtT4lHx0yceMsNYB+YNZPlzOJ7ZHkRFSGF/Uybr/9niZuLwHTwTvOAZ1DrG+9siuN7XbuA7syjMALZW3NEOX+dAa2oXfOpE9T9mH96QuOrz0784CHR7XVz1Yl1T6ieiebdi8GvxSFUbage84s4WWNOiH2J6Ez6Hte8hXuVfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333111; c=relaxed/simple;
	bh=8/WQV9+3WuymPpz+pu9Xu/DO05uKb4YwYS5DTDp8Ce8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NU/8Yky5Ss4drGSqhVu9FedQ+jSwzfwwmMFeQzPKUzPfGKagLOkdLSsFSSmiJZKOvOxxtsZ8OEOSDVVZ6VoWWuwDthMPboBjHlNVdWyKC+qNAy33tHKxkActS5xYR/ALmJS0XAUdPqn0qBCHn+y/cwmtKBRC3CatMe/iqLjxoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQWtVOZQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711333109; x=1742869109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/WQV9+3WuymPpz+pu9Xu/DO05uKb4YwYS5DTDp8Ce8=;
  b=YQWtVOZQMon+oC3MJ6kvd+n7uePdRkVK5WQVhQn9SdGhOvXMkzknGLy8
   0UH4dUfhZ2dgSrz0MkaahJPfuXsdeZP+uKvnW/IhZGOVAOkXh7oJ4l0cq
   dBqljPEy+CaAOiLHWN097OO/Jksk/C9xrOOgGov3dLeMo1P76Gaqzo7vO
   fmYimt6esgaYsJ/CCPnGtZUKfjWB1lJkh0svyiGb6zEABoquV+4qEYOv0
   zl8fydmpK6EKR5TEllakpV4d0elXRn5lpuAFmijmgg7WBykhHQB2ayj6b
   IiMIEm2F2pS/pM1RPGzOo4wLcqverRBpsXLp+9Qztw+e2NoPuArx0mXOt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="9271445"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="9271445"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 19:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15354007"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Mar 2024 19:18:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 10/12] iommu/vt-d: Retire intel_svm_dev
Date: Mon, 25 Mar 2024 10:17:03 +0800
Message-Id: <20240325021705.249769-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325021705.249769-1-baolu.lu@linux.intel.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_svm_dev data structure used in the sva implementation for the
Intel IOMMU driver stores information about a device attached to an SVA
domain. It is a duplicate of dev_pasid_info that serves the same purpose.

Replace intel_svm_dev with dev_pasid_info and clean up the use of
intel_svm_dev.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  15 +----
 drivers/iommu/intel/iommu.c |  30 ++++-----
 drivers/iommu/intel/svm.c   | 131 +++++++++++-------------------------
 3 files changed, 55 insertions(+), 121 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2575ded9f354..5dcced6f3634 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -650,6 +650,7 @@ struct dmar_domain {
 			struct list_head s2_link;
 		};
 	};
+	struct intel_svm *svm;
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
@@ -1131,23 +1132,13 @@ int intel_svm_finish_prq(struct intel_iommu *iommu);
 void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
-void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+void intel_svm_remove_dev_pasid(struct iommu_domain *domain);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 
-struct intel_svm_dev {
-	struct list_head list;
-	struct rcu_head rcu;
-	struct device *dev;
-	struct intel_iommu *iommu;
-	u16 did;
-	u16 sid, qdep;
-};
-
 struct intel_svm {
 	struct mmu_notifier notifier;
 	struct mm_struct *mm;
 	u32 pasid;
-	struct list_head devs;
 	struct dmar_domain *domain;
 };
 #else
@@ -1158,7 +1149,7 @@ static inline struct iommu_domain *intel_svm_domain_alloc(void)
 	return NULL;
 }
 
-static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static inline void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
 {
 }
 #endif
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6e019297843b..2ac1fc041333 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4384,18 +4384,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		goto out_tear_down;
 	dmar_domain = to_dmar_domain(domain);
 
-	/*
-	 * The SVA implementation needs to handle its own stuffs like the mm
-	 * notification. Before consolidating that code into iommu core, let
-	 * the intel sva code handle it.
-	 */
-	if (domain->type == IOMMU_DOMAIN_SVA) {
-		intel_svm_remove_dev_pasid(dev, pasid);
-		cache_tag_unassign_domain(dmar_domain,
-					  FLPT_DEFAULT_DID, dev, pasid);
-		goto out_tear_down;
-	}
-
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
@@ -4407,10 +4395,20 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
-	did = domain_id_iommu(dmar_domain, iommu);
-	cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
-	domain_detach_iommu(dmar_domain, iommu);
-	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+	/*
+	 * The SVA implementation needs to handle its own stuffs like the mm
+	 * notification. Before consolidating that code into iommu core, let
+	 * the intel sva code handle it.
+	 */
+	if (domain->type == IOMMU_DOMAIN_SVA) {
+		cache_tag_unassign_domain(dmar_domain, FLPT_DEFAULT_DID, dev, pasid);
+		intel_svm_remove_dev_pasid(domain);
+	} else {
+		did = domain_id_iommu(dmar_domain, iommu);
+		cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
+		domain_detach_iommu(dmar_domain, iommu);
+		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+	}
 	kfree(dev_pasid);
 out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 751fab476fa2..0b767d16fb71 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -43,23 +43,6 @@ static void *pasid_private_find(ioasid_t pasid)
 	return xa_load(&pasid_private_array, pasid);
 }
 
-static struct intel_svm_dev *
-svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
-{
-	struct intel_svm_dev *sdev = NULL, *t;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(t, &svm->devs, list) {
-		if (t->dev == dev) {
-			sdev = t;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return sdev;
-}
-
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct iopf_queue *iopfq;
@@ -187,7 +170,10 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-	struct intel_svm_dev *sdev;
+	struct dmar_domain *domain = svm->domain;
+	struct dev_pasid_info *dev_pasid;
+	struct device_domain_info *info;
+	unsigned long flags;
 
 	/* This might end up being called from exit_mmap(), *before* the page
 	 * tables are cleared. And __mmu_notifier_release() will delete us from
@@ -201,11 +187,13 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * page) so that we end up taking a fault that the hardware really
 	 * *has* to handle gracefully without affecting other processes.
 	 */
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list)
-		intel_pasid_tear_down_entry(sdev->iommu, sdev->dev,
-					    svm->pasid, true);
-	rcu_read_unlock();
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		intel_pasid_tear_down_entry(info->iommu, dev_pasid->dev,
+					    dev_pasid->pasid, true);
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 }
 
@@ -214,47 +202,17 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.arch_invalidate_secondary_tlbs = intel_arch_invalidate_secondary_tlbs,
 };
 
-static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
-			     struct intel_svm **rsvm,
-			     struct intel_svm_dev **rsdev)
-{
-	struct intel_svm_dev *sdev = NULL;
-	struct intel_svm *svm;
-
-	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
-		return -EINVAL;
-
-	svm = pasid_private_find(pasid);
-	if (IS_ERR(svm))
-		return PTR_ERR(svm);
-
-	if (!svm)
-		goto out;
-
-	/*
-	 * If we found svm for the PASID, there must be at least one device
-	 * bond.
-	 */
-	if (WARN_ON(list_empty(&svm->devs)))
-		return -EINVAL;
-	sdev = svm_lookup_device_by_dev(svm, dev);
-
-out:
-	*rsvm = svm;
-	*rsdev = sdev;
-
-	return 0;
-}
-
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
-	struct intel_svm_dev *sdev;
+	struct dev_pasid_info *dev_pasid;
 	struct intel_svm *svm;
 	unsigned long sflags;
+	unsigned long flags;
 	int ret = 0;
 
 	svm = pasid_private_find(pasid);
@@ -265,7 +223,6 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 		svm->pasid = pasid;
 		svm->mm = mm;
-		INIT_LIST_HEAD_RCU(&svm->devs);
 
 		svm->notifier.ops = &intel_mmuops;
 		svm->domain = to_dmar_domain(domain);
@@ -283,26 +240,19 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
-	if (!sdev) {
-		ret = -ENOMEM;
+	dmar_domain->svm = svm;
+
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
 		goto free_svm;
-	}
 
-	sdev->dev = dev;
-	sdev->iommu = iommu;
-	sdev->did = FLPT_DEFAULT_DID;
-	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-	if (info->ats_enabled) {
-		sdev->qdep = info->ats_qdep;
-		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-			sdev->qdep = 0;
-	}
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
 
 	ret = cache_tag_assign_domain(to_dmar_domain(domain),
 				      FLPT_DEFAULT_DID, dev, pasid);
 	if (ret)
-		goto free_sdev;
+		goto free_dev_pasid;
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -311,17 +261,19 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto unassign_tag;
 
-	list_add_rcu(&sdev->list, &svm->devs);
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	return 0;
 
 unassign_tag:
 	cache_tag_unassign_domain(to_dmar_domain(domain),
 				  FLPT_DEFAULT_DID, dev, pasid);
-free_sdev:
-	kfree(sdev);
+free_dev_pasid:
+	kfree(dev_pasid);
 free_svm:
-	if (list_empty(&svm->devs)) {
+	if (list_empty(&dmar_domain->dev_pasids)) {
 		mmu_notifier_unregister(&svm->notifier, mm);
 		pasid_private_remove(pasid);
 		kfree(svm);
@@ -330,26 +282,17 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	return ret;
 }
 
-void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
+void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
 {
-	struct intel_svm_dev *sdev;
-	struct intel_svm *svm;
-	struct mm_struct *mm;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_svm *svm = dmar_domain->svm;
+	struct mm_struct *mm = domain->mm;
 
-	if (pasid_to_svm_sdev(dev, pasid, &svm, &sdev))
-		return;
-	mm = svm->mm;
-
-	if (sdev) {
-		list_del_rcu(&sdev->list);
-		kfree_rcu(sdev, rcu);
-
-		if (list_empty(&svm->devs)) {
-			if (svm->notifier.ops)
-				mmu_notifier_unregister(&svm->notifier, mm);
-			pasid_private_remove(svm->pasid);
-			kfree(svm);
-		}
+	if (list_empty(&dmar_domain->dev_pasids)) {
+		if (svm->notifier.ops)
+			mmu_notifier_unregister(&svm->notifier, mm);
+		pasid_private_remove(svm->pasid);
+		kfree(svm);
 	}
 }
 
@@ -737,8 +680,10 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 		return NULL;
 	domain->domain.ops = &intel_svm_domain_ops;
 	domain->use_first_level = true;
+	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->cache_lock);
+	spin_lock_init(&domain->lock);
 
 	return &domain->domain;
 }
-- 
2.34.1


