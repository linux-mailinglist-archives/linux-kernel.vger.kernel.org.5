Return-Path: <linux-kernel+bounces-66364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330D9855BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85474B22878
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C00B134DB;
	Thu, 15 Feb 2024 07:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDhpXhxb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627A11702
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982135; cv=none; b=cB70b07KousotFR0k9lA1Vrnh4rxLE0G2R1crs4/pWl+vNd5kT7oCtDw/uXcj07KNOJQOVlxJSgrQuIQ0fUF6Fywmsf5vd+vBssFyNC2faZUa/iRA+bUqQguE7LVk6Ilf57MADKLxy2it8G2Hbg2cJVkud54PyCS3v+/VpQJR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982135; c=relaxed/simple;
	bh=/UfRxLziZyXq/0+b3VTkvvpW66vL2yoqTnghp3Iq0KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8ILt0VGc5rW3paw7RIiScNBg1aZVn23PvVwGNhWOq/zHT13Oo6R277/DSAO/AkoLv9tXT6WQPvbh2c3c51AtG+g1ljrDUk7tNgzFYuhv55kWxU7tu9uqY7aCBWxosA1yVKMXPR7aEirDCsaTWVLMbZOUV8rWTQ7s5nXjuJeLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDhpXhxb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707982134; x=1739518134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UfRxLziZyXq/0+b3VTkvvpW66vL2yoqTnghp3Iq0KI=;
  b=RDhpXhxbLh+e6dGyVhDMDuEW7+jh03xBp9TEbCK7hNlq0wWn/Sh3eYSW
   l2h13emvpi62P78KjLJKv7MLMgevsz2/uFhEc2yMJT+oQDTPgZY51+FTO
   GRoKlfgQ1GD3dCgIGY/d5cTFO5fuaKveKSC4VKiK3dKJgiykg/qPOX4lr
   rKxQ5U/clE6HOj4yI7oGC8ZSJeMTER3uVBeP2wSUYgkDX96P5IQScO7mv
   G2NDa9A2eRpeCqbbK/dEjSXDo5ZAtxLRmnDmxRNpcVAPD5uMv3jqxTHch
   3xocJNyLc0QhQY9f5qPMbg+rUCfsGcOzdP4b60MSBRQjTLKOR7wpKwggr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2182719"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2182719"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 23:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912113145"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912113145"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2024 23:28:51 -0800
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
Subject: [PATCH 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Date: Thu, 15 Feb 2024 15:22:49 +0800
Message-Id: <20240215072249.4465-3-baolu.lu@linux.intel.com>
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

The existing IO page fault handler currently locates the PCI device by
calling pci_get_domain_bus_and_slot(). This function searches the list
of all PCI devices until the desired device is found. To improve lookup
efficiency, a helper function named device_rbtree_find() is introduced
to search for the device within the rbtree. Replace
pci_get_domain_bus_and_slot() in the IO page fault handling path.

Co-developed-by: Huang Jiaqing <jiaqing.huang@intel.com>
Signed-off-by: Huang Jiaqing <jiaqing.huang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/iommu.c | 29 +++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c   | 14 ++++++--------
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 54eeaa8e35a9..f13c228924f8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1081,6 +1081,7 @@ void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data);
+struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 09009d96e553..d92c680bcc96 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -120,6 +120,35 @@ static int device_rid_cmp(struct rb_node *lhs, const struct rb_node *rhs)
 	return device_rid_cmp_key(&key, rhs);
 }
 
+/*
+ * Looks up an IOMMU-probed device using its source ID.
+ *
+ * If the device is found:
+ *  - Increments its reference count.
+ *  - Returns a pointer to the device.
+ *  - The caller must call put_device() after using the pointer.
+ *
+ * If the device is not found, returns NULL.
+ */
+struct device *device_rbtree_find(struct intel_iommu *iommu, u16 rid)
+{
+	struct device_domain_info *info;
+	struct device *dev = NULL;
+	struct rb_node *node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
+	node = rb_find(&rid, &iommu->device_rbtree, device_rid_cmp_key);
+	if (node) {
+		info = rb_entry(node, struct device_domain_info, node);
+		dev = info->dev;
+		get_device(dev);
+	}
+	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
+
+	return dev;
+}
+
 static int device_rbtree_insert(struct intel_iommu *iommu,
 				struct device_domain_info *info)
 {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b644d57da841..717b7041973c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -645,7 +645,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	struct intel_iommu *iommu = d;
 	struct page_req_dsc *req;
 	int head, tail, handled;
-	struct pci_dev *pdev;
+	struct device *dev;
 	u64 address;
 
 	/*
@@ -691,21 +691,19 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
 			goto prq_advance;
 
-		pdev = pci_get_domain_bus_and_slot(iommu->segment,
-						   PCI_BUS_NUM(req->rid),
-						   req->rid & 0xff);
 		/*
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (!pdev)
+		dev = device_rbtree_find(iommu, req->rid);
+		if (!dev)
 			goto bad_req;
 
-		intel_svm_prq_report(iommu, &pdev->dev, req);
-		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
+		intel_svm_prq_report(iommu, dev, req);
+		trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
 				 req->priv_data[0], req->priv_data[1],
 				 iommu->prq_seq_number++);
-		pci_dev_put(pdev);
+		put_device(dev);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.34.1


