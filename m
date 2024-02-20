Return-Path: <linux-kernel+bounces-72451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D70885B39D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00241F23D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F73D5A783;
	Tue, 20 Feb 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTelXNx0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61BA5A4FF
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412745; cv=none; b=VEbTTQOcNHo+t2+jOdpr7scIpAfRkPP25WLkTU6lWhaxMoAis7Q3orJUSStTkkVrT16FFxivpbG6d0HxAvwKlVxYmze9GcBFcHxe1hRCX/GkbiznBFislG+/ikIZHE3fCvnYtnVekOOC4KsNTfYuMhBrPHdw7dBmtFaKgM61RYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412745; c=relaxed/simple;
	bh=ZbpO3w8GfTzpY3DoVWRz5vgwWK+8/2qXMylcU+ZyyLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tbx++h9YifgpE4EJ0ShIh5ojJQS3hQrBJNNICKxuULnPVDIo74iZ66QRFsLylVfKtw2VIFezrAMq5tgSMrvnwqAEEESm+yTdH5f2BQ0/3oGQajEmigQGWNI/ah+Y4pCFiIjAHEMtMM6W++2FTHyDxWTn6k5lOqY8uIW+UtSv9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTelXNx0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708412744; x=1739948744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZbpO3w8GfTzpY3DoVWRz5vgwWK+8/2qXMylcU+ZyyLY=;
  b=cTelXNx0pU6V7a6X/ZLhg2wAq8U9kfkQcqODPPpLLOk9rjp9/RGKme1B
   IF+KFbBsGhfpwq4Y5ZBh9S+xvw5fIpeO0CNxR8G+uqxskHlQQqfxvy697
   pI1QLxibfR1Ly3g0aTZbxpX95q0kxwJeadU60loJ5McIj86Cto3lM52z3
   6W9RvtclccF5IIFpazgnzJMw+b0nkQBxjaHKEaTwG2M9RpZioBj8CeuVB
   4EFHlsiGo4k8aePPjF5Be7Gk8jXDqDx2qWEq3OnUOdUCrxso1TETGbHw9
   Fjn3WfBZPstmH6WLj1NEtppggq+oCS1CgmNx8LrbwSuQgjg6glYID2nSM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2366578"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2366578"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 23:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4683784"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2024 23:05:40 -0800
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
Subject: [PATCH v2 2/2] iommu/vt-d: Use device rbtree in iopf reporting path
Date: Tue, 20 Feb 2024 14:59:39 +0800
Message-Id: <20240220065939.121116-3-baolu.lu@linux.intel.com>
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

The existing I/O page fault handler currently locates the PCI device by
calling pci_get_domain_bus_and_slot(). This function searches the list
of all PCI devices until the desired device is found. To improve lookup
efficiency, replace it with device_rbtree_find() to search the device
within the probed device rbtree.

The I/O page fault is initiated by the device, which does not have any
synchronization mechanism with the software to ensure that the device
stays in the probed device tree. Theoretically, a device could be released
by the IOMMU subsystem after device_rbtree_find() and before
iopf_get_dev_fault_param(), which would cause a use-after-free problem.

Add a mutex to synchronize the I/O page fault reporting path and the IOMMU
release device path. This lock doesn't introduce any performance overhead,
as the conflict between I/O page fault reporting and device releasing is
very rare.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c |  3 +++
 drivers/iommu/intel/svm.c   | 17 +++++++++--------
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2b67ad0d6fe9..404d2476a877 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -719,6 +719,8 @@ struct intel_iommu {
 #endif
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
+	/* Synchronization between fault report and iommu device release. */
+	struct mutex iopf_lock;
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 iommu_state[MAX_SR_DMAR_REGS]; /* Store iommu states between suspend and resume.*/
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f9b63c2875f7..d14797aabb7a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1097,6 +1097,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	iommu->segment = drhd->segment;
 	iommu->device_rbtree = RB_ROOT;
 	spin_lock_init(&iommu->device_rbtree_lock);
+	mutex_init(&iommu->iopf_lock);
 	iommu->node = NUMA_NO_NODE;
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index acfe27bd3448..6743fe6c7a36 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4430,8 +4430,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
 
+	mutex_lock(&iommu->iopf_lock);
 	device_rbtree_remove(info);
+	mutex_unlock(&iommu->iopf_lock);
 	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b644d57da841..dda276e28325 100644
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
@@ -691,21 +691,22 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
+		mutex_lock(&iommu->iopf_lock);
+		dev = device_rbtree_find(iommu, req->rid);
+		if (!dev) {
+			mutex_unlock(&iommu->iopf_lock);
 			goto bad_req;
+		}
 
-		intel_svm_prq_report(iommu, &pdev->dev, req);
-		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
+		intel_svm_prq_report(iommu, dev, req);
+		trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
 				 req->priv_data[0], req->priv_data[1],
 				 iommu->prq_seq_number++);
-		pci_dev_put(pdev);
+		mutex_unlock(&iommu->iopf_lock);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.34.1


