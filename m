Return-Path: <linux-kernel+bounces-72450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280F85B39C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C857B22A60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7010B5A4E9;
	Tue, 20 Feb 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WX8AXyZM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C75A10E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412742; cv=none; b=FHf1MUvD9sj1qv/WXG89Rt12mLvBspzV3sMmwmkBkNcqiCW8q1AH2k79h85riIWxKpSLEKg9Vq37PSgaT6nszTT+dt8k59AHybUAC1IAZqsCRe/Ni8OUNeYmuB3COWk3CVKAh5mByzq2vuS5Io6R7kuAJIK/8J3ifTFInHwVqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412742; c=relaxed/simple;
	bh=zPMYb8T01iUrJHQctk16vFfd7/Rkjuot0PPcWuhjqHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3BBpjV/ty7lqmRnSB743YOYCTrMX467WQ25ZeWHMFsHdPmj2miMnO7XH12h3EP9KsbUZ9vy34BwBy6YOeTDj2H3vDMh2slJJx+J6ILl3D/Tm6rjSoZjh+NUPKsNbbjTIdFpZ3h7UinxaOfQsKFl+7QQOzvYSEIN09beX94MEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WX8AXyZM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708412741; x=1739948741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPMYb8T01iUrJHQctk16vFfd7/Rkjuot0PPcWuhjqHQ=;
  b=WX8AXyZMyi11JQp2My2UDfjB4bS0vLuG/0lmwkhywOTL5aqv4E1I6tah
   z04xnvDnsskA/C3u3icao0yELXIZ/tu+lSuZUQetcSstTHN6EJaVIsvvT
   3yyUl8VlCpTcYNz1sgOJV/uyjHcCIMwRZB8Sjn30F7YLm6KAURmjaiRKf
   8yGIKzi8/DOSmDnTYsgvtiEpGraNMXgv3/aYB83TEbGepeyhfztQCJwXY
   GLW4gDOozy5rJkPdHh/KTb1cN6aHCJKG8SbSXZ1Sb3BdqyIUCk9PWeRkm
   HGHu+9E/A6S7QFa66oEBG9SiYNiZAMlL8lV0F6zgPnhX5be+1MohqgpOT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2366570"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2366570"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4683775"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2024 23:05:37 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
Date: Tue, 20 Feb 2024 14:59:38 +0800
Message-Id: <20240220065939.121116-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220065939.121116-1-baolu.lu@linux.intel.com>
References: <20240220065939.121116-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a red-black tree(rbtree) to track devices probed by the driver's
probe_device callback. These devices need to be looked up quickly by
a source ID when the hardware reports a fault, either recoverable or
unrecoverable.

Fault reporting paths are critical. Searching a list in this scenario
is inefficient, with an algorithm complexity of O(n). An rbtree is a
self-balancing binary search tree, offering an average search time
complexity of O(log(n)). This significant performance improvement
makes rbtrees a better choice.

Furthermore, rbtrees are implemented on a per-iommu basis, eliminating
the need for global searches and further enhancing efficiency in
critical fault paths. The rbtree is protected by a spin lock with
interrupts disabled to ensure thread-safe access even within interrupt
contexts.

Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.h |  8 ++++
 drivers/iommu/intel/dmar.c  |  3 +-
 drivers/iommu/intel/iommu.c | 88 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index eaef932ad7c9..2b67ad0d6fe9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -722,6 +722,11 @@ struct intel_iommu {
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
 
+	/* rb tree for all probed devices */
+	struct rb_root device_rbtree;
+	/* protect the device_rbtree */
+	spinlock_t device_rbtree_lock;
+
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
 	struct irq_domain *ir_domain;
@@ -755,6 +760,8 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	/* device tracking node(lookup by PCI RID) */
+	struct rb_node node;
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
 	struct dentry *debugfs_dentry; /* pointer to device directory dentry */
 #endif
@@ -1081,6 +1088,7 @@ void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data);
+struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..f9b63c2875f7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1095,7 +1095,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	iommu->agaw = agaw;
 	iommu->msagaw = msagaw;
 	iommu->segment = drhd->segment;
-
+	iommu->device_rbtree = RB_ROOT;
+	spin_lock_init(&iommu->device_rbtree_lock);
 	iommu->node = NUMA_NO_NODE;
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 61bb35046ea4..acfe27bd3448 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -96,6 +96,81 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 	return re->hi & VTD_PAGE_MASK;
 }
 
+static int device_rid_cmp_key(const void *key, const struct rb_node *node)
+{
+	struct device_domain_info *info =
+		rb_entry(node, struct device_domain_info, node);
+	const u16 *rid_lhs = key;
+
+	if (*rid_lhs < PCI_DEVID(info->bus, info->devfn))
+		return -1;
+
+	if (*rid_lhs > PCI_DEVID(info->bus, info->devfn))
+		return 1;
+
+	return 0;
+}
+
+static int device_rid_cmp(struct rb_node *lhs, const struct rb_node *rhs)
+{
+	struct device_domain_info *info =
+		rb_entry(lhs, struct device_domain_info, node);
+	u16 key = PCI_DEVID(info->bus, info->devfn);
+
+	return device_rid_cmp_key(&key, rhs);
+}
+
+/*
+ * Looks up an IOMMU-probed device using its source ID.
+ *
+ * Returns the pointer to the device if there is a match. Otherwise,
+ * returns NULL.
+ *
+ * Note that this helper doesn't guarantee that the device won't be
+ * released by the iommu subsystem after being returned. The caller
+ * should use its own synchronization mechanism to avoid the device
+ * being released during its use if its possibly the case.
+ */
+struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
+{
+	struct device_domain_info *info = NULL;
+	struct rb_node *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
+	node = rb_find(&rid, &iommu->device_rbtree, device_rid_cmp_key);
+	if (node)
+		info = rb_entry(node, struct device_domain_info, node);
+	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
+
+	return info ? info->dev : NULL;
+}
+
+static int device_rbtree_insert(struct intel_iommu *iommu,
+				struct device_domain_info *info)
+{
+	struct rb_node *curr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
+	curr = rb_find_add(&info->node, &iommu->device_rbtree, device_rid_cmp);
+	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
+	if (WARN_ON(curr))
+		return -EEXIST;
+
+	return 0;
+}
+
+static void device_rbtree_remove(struct device_domain_info *info)
+{
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
+	rb_erase(&info->node, &iommu->device_rbtree);
+	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
+}
+
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
@@ -4329,25 +4404,34 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	}
 
 	dev_iommu_priv_set(dev, info);
+	ret = device_rbtree_insert(iommu, info);
+	if (ret)
+		goto free;
 
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
-			kfree(info);
-			return ERR_PTR(ret);
+			goto clear_rbtree;
 		}
 	}
 
 	intel_iommu_debugfs_create_dev(info);
 
 	return &iommu->iommu;
+clear_rbtree:
+	device_rbtree_remove(info);
+free:
+	kfree(info);
+
+	return ERR_PTR(ret);
 }
 
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
+	device_rbtree_remove(info);
 	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
-- 
2.34.1


