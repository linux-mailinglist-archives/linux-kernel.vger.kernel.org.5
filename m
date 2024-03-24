Return-Path: <linux-kernel+bounces-113185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4D888222
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F149828AFB6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C3178305;
	Sun, 24 Mar 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6fZe28W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFC1782EE;
	Sun, 24 Mar 2024 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319988; cv=none; b=PmUSsJFUX6paGYLpkAB00dPDIrzgmBrT7reCozorGd/ApaZi/UGupNUsTfBywuvU2CHHdmZnIhAC5NqKEYB3Wxg6B0IsHvqqrpIzLwBrDJueJpKR+tsK2ZAm0t2ygNJf7hZSM83qoBZV/ZKOEpCK17HdZG/Kjsq5TQ25ZsV3DSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319988; c=relaxed/simple;
	bh=vnNixpthKYaUbRxBV7EcjomeXWvZ98h49aXkBAsosKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1ZOvIbTBnirlSYooXRC6t1fLy8wXoSUN15r3pnhii165grijph3cIrF3acGOECNkMeoFIu9+LGYP+gqlMUqtt1eCIq6Ua+LLrqgMjBjiagg5h4KXmHi8vmApoUdi8qSF/f34++dujJa0wlf5pwJOlrdoWY/cCePH254VEnXoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6fZe28W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF2DC433A6;
	Sun, 24 Mar 2024 22:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319988;
	bh=vnNixpthKYaUbRxBV7EcjomeXWvZ98h49aXkBAsosKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6fZe28WUplYOGI4ocSg3aVbpGGGPiQZNoLcvwlJcmVDtODr3tG33hNzgV8SaO9H5
	 nNyBz8fg+ZN589WtdJQ977yctW/46+zjGZ8q+YUR60l52QN/YoBxh3izZfUeatg6u1
	 oXv2wlr6PjHUILiSQ7vD/oKtyFm8BrAonn7ZTBYyTL76QNUkbIAwc5hxpcXIL+VUHG
	 BkR+d0lAvVbEWeQnTFU3dmpZYvqJjSFpHhIE5XnOLBY4WrZZ26TwK+whnXqskFnu1y
	 rTDqTheQ3DFcJbBVFJdgef0jysxN6CEB0staiFLF2viF/O62/J5/lrYMi6j4SRC5h4
	 vXTQkEdg0mipA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Huang Jiaqing <jiaqing.huang@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 294/715] iommu/vt-d: Use rbtree to track iommu probed devices
Date: Sun, 24 Mar 2024 18:27:53 -0400
Message-ID: <20240324223455.1342824-295-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 1a75cc710b956010137b4fe1d1fa3282bfd8f86c ]

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
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 80a9b50c0b9e ("iommu/vt-d: Improve ITE fault handling if target device isn't present")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/dmar.c  |  3 +-
 drivers/iommu/intel/iommu.c | 88 ++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel/iommu.h |  8 ++++
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9ab..f9b63c2875f71 100644
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
index 11652e0bcab3a..9e07e4425ff65 100644
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
@@ -4330,25 +4405,34 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4145c04cb1c68..df00240ebe90b 100644
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
-- 
2.43.0


