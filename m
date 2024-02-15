Return-Path: <linux-kernel+bounces-66363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F264855BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B14B2B7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEA111BD;
	Thu, 15 Feb 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DI97xG42"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99203DDCF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982133; cv=none; b=JO3tHxZawsyAbGjp67uuHVCHCB32YvSoHNbYM2ZuAirWxcyuSJnWLuAogeMLv6Rf5rGcwUCxuMHrpbano/GfuuvTcpEtto03L9isT9Y0Ou96+pE3JUratmGVv2SbsIIA7KNrrWSqQDfTmjyqGugHz9jeOPg5EVJHnlCZQu+OYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982133; c=relaxed/simple;
	bh=TMjeJSIkcMJLmOlEVy9pSoQQPSex5IwLFXnsMQdCurc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aR/XjWQu1TEKyRByzp7lHGEKVQZcoY1sJOWuuFNko5wzK7mJw1xBJF69BgeFNwaBIDJXfXgP33ak7gEi+B+Pn1GFVjYPMt1sIRnZ+Ewo8ygVXN0tTZLyTxgQl3X0GolKeEiwjVvuYaAgQEKUuYpCtGp1TxytVbobNBk05qVaqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DI97xG42; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707982132; x=1739518132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TMjeJSIkcMJLmOlEVy9pSoQQPSex5IwLFXnsMQdCurc=;
  b=DI97xG42qnrIccXxgVqKj78Iyo08Q+aGvZPQeabwDi9W/Dy062Gi6g89
   JNUL53ER+q7kKsHtpkA25HZe8vGyqWo97e3C/HELTthN0wAKGc111V8tI
   iJltre19qa2oCyk6vmPN+/XulN6Szoy8iHeZcBO3X+YYMRUD0SXhknffh
   sAT3irQucjlg+Z5WbyJVy1pdGYvQAPzGu/cjZikZrC9GY6IzXU90FQY0l
   gbM1rXjjwks/L13f0LioFNV6NL+F9sYLyYvdh8O8wiHmJjU7yOPdYjFDp
   pOEydGAD/Ho3lQcGfwNdIUQvrGBu0d+5QXVHevPZ/AAxvoiK+M6kjteQ6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2182713"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2182713"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 23:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912113139"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912113139"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2024 23:28:48 -0800
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
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
Date: Thu, 15 Feb 2024 15:22:48 +0800
Message-Id: <20240215072249.4465-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215072249.4465-1-baolu.lu@linux.intel.com>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.h |  7 +++++
 drivers/iommu/intel/dmar.c  |  3 +-
 drivers/iommu/intel/iommu.c | 62 +++++++++++++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index cf9a28c7fab8..54eeaa8e35a9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -716,6 +716,11 @@ struct intel_iommu {
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
@@ -749,6 +754,8 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	/* device tracking node(lookup by PCI RID) */
+	struct rb_node node;
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
 	struct dentry *debugfs_dentry; /* pointer to device directory dentry */
 #endif
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
index a81a2be9b870..09009d96e553 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -96,6 +96,55 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
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
+static int device_rbtree_insert(struct intel_iommu *iommu,
+				struct device_domain_info *info)
+{
+	struct rb_node *curr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
+	curr = rb_find_add(&info->node, &iommu->device_rbtree, device_rid_cmp);
+	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
+	if (curr)
+		dev_warn(info->dev, "device already in rbtree\n");
+
+	return curr ? -EEXIST : 0;
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
@@ -4264,25 +4313,34 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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


