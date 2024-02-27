Return-Path: <linux-kernel+bounces-82596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972178686D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB0D1C284D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4A25578E;
	Tue, 27 Feb 2024 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNWt2Zwd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF81B28D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000455; cv=none; b=f41NkDsHQic/Rk17Bdcq6gwxbARyRXnB51NtWch8XM0dv8dNr2srXbhKwxfIU7fENxxwiz4Yuz3NVp2K9uL05LWMQtDPjelXerx6Pjn27hsVahdof0i8EANog3suKCKVTvogfuDZ/IFOUQmb1uulvLbg48i8HjsaG512IjOmyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000455; c=relaxed/simple;
	bh=SurMc55kkassQxYbbRkJIwr+dzuElbnFozRuUzPEssU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWXL/Kjj2Mi8LyIX/57wDUoShByszctvD2w5jsUBa1A7XEFAVMkCJU7LEsaqNTESvZSnuygQX7U8pgts/8EYUcYZcpKiYOdrniqBVL/8KBE/14Xdbev7khxf1ZT3G+QJS7/6TU9L4P7lso7X7ZB7ibDmZkGAsvadsNR+FMTHCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNWt2Zwd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000454; x=1740536454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SurMc55kkassQxYbbRkJIwr+dzuElbnFozRuUzPEssU=;
  b=NNWt2ZwdDAPScJ0Y0kozc/R+5CHBNJqpvQdwzRyMY5Sv6rH9+EETtweG
   b4xLBEwhFjxCsAs+pJtzac9onxUwhHTplNCFBRLZqbI0eI/Pla/X5kCXW
   BnSKukUzp0MeCb3li26jcgqFwYYHXtd7E+mGM60NTXqV32E3oh3ssJcaH
   +7gL93xtETFV/ZpaTcEq5iEYIvgpNdUbBTq0hQjb5t+vVCe2Watw32kjP
   5NQ/90zGcUmrGid23Qjtbb0jdC6K+dVev3XczkY5nir2UpGQaNZk+WzTI
   VMdOD2JinBzUYs2X+MMVSRfNJ3ZaacIlDt3eKQ5QaxktHJcXv2QfofBBM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6273134"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6273134"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:20:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7418310"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2024 18:20:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] iommu/vt-d: Use device rbtree in iopf reporting path
Date: Tue, 27 Feb 2024 10:14:41 +0800
Message-Id: <20240227021441.50434-9-baolu.lu@linux.intel.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240220065939.121116-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c |  3 +++
 drivers/iommu/intel/svm.c   | 17 +++++++++--------
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index df00240ebe90..cd267ba64eda 100644
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
index 5568f17d867f..eaa648c6c389 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4427,8 +4427,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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
index 1dd56d4eb88c..bdf3584ca0af 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -643,7 +643,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	struct intel_iommu *iommu = d;
 	struct page_req_dsc *req;
 	int head, tail, handled;
-	struct pci_dev *pdev;
+	struct device *dev;
 	u64 address;
 
 	/*
@@ -689,23 +689,24 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
 
-		if (intel_svm_prq_report(iommu, &pdev->dev, req))
+		if (intel_svm_prq_report(iommu, dev, req))
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 		else
-			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
+			trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
 					 req->priv_data[0], req->priv_data[1],
 					 iommu->prq_seq_number++);
-		pci_dev_put(pdev);
+		mutex_unlock(&iommu->iopf_lock);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.34.1


