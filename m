Return-Path: <linux-kernel+bounces-82595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E58686D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F6E2864B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDE54FB5;
	Tue, 27 Feb 2024 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtYOogLP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B6A53E38
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000453; cv=none; b=o+PFHZ0BQiAxgtYsutxI/odZ+frpvxCkt/v9XDmQp1lFU6DjaGRvrQRq2oT9IptGn5GrJ68dru6JDHA6uY5ksGWHMbd1HgmwFEXNGAwD0ZEUA0CvFeaT5yvY1cAjEFd1BXvQxzFBfm02P5U6/d+UZUZM0s375bBtTkOdgqv+EdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000453; c=relaxed/simple;
	bh=1+dCDOoM/22cmmjbSNHsijPzXOxGUUzKzZQk17Ikwy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmLfkMuUwk4vCJMFaHnrFC5eiamEkKdjGQ8O5kZGzLlpXOhHyzYAWYokuPAp0NHlrDebph34MR3Q12PpnPOtkv6oPogLAQlWA4KLDDOxHv0QQ4Mlp1nakTULr0ltKFiu6FZcLsK7t1er3brMxzlkOISYDEKVwvkl282vVpJw4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtYOogLP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000452; x=1740536452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+dCDOoM/22cmmjbSNHsijPzXOxGUUzKzZQk17Ikwy0=;
  b=PtYOogLP64bUTsx817BNrnynNVitlyy7gR2frNMvKD5ApItJWnybnOBP
   l+uePBqapF6unz7OBMLznaZi8wACWEQdy22zVtNppBfRreO/ttPyzHXeC
   a2Z7IUCA61ZGXOSws5qT2NW5PNZnSseomSiRBBVuanpZ345C3qIrh2eUs
   xW9IPe7NT0iL4qL/gGJi2EVqUInfyeXVyhlE9H94u4eMIOk/7SYgNRZv8
   lk7RX9QolkNmzeM0bn6u7BEqOM/xv0wBaL+NoD6kHhbdQvq4QsVsU01c8
   ad8zGFsP+DAiq/E5HYy8G7HJQugetKvSZ+8YHf2ORn1IlSz+bBNt/Hmlq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273127"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273127"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418306"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:50 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] iommu/vt-d: Use rbtree to track iommu probed devices
Date: Tue, 27 Feb 2024 10:14:40 +0800
Message-Id: <20240227021441.50434-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227021441.50434-1-baolu.lu@linux.intel.com>
References: <20240227021441.50434-1-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20240220065939.121116-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  8 ++++
 drivers/iommu/intel/dmar.c  |  3 +-
 drivers/iommu/intel/iommu.c | 88 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4145c04cb1c6..df00240ebe90 100644
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
index cfbe7c8e74fb..5568f17d867f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -97,6 +97,81 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
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
@@ -4326,25 +4401,34 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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


