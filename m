Return-Path: <linux-kernel+bounces-113187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F5888226
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED541F21BA4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D0178CCD;
	Sun, 24 Mar 2024 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW0P7HOH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEB17831C;
	Sun, 24 Mar 2024 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319990; cv=none; b=MswAodL0Jz2da9LtwdPT1pbJ/WsGauA2nh9Twc3LlQ5rFV85Hi8KLc3Bx/iICj71kqnh48aztRUSDTSlakdYMRDIN4IIhtpXaHTbhGhoxEVkeftryE+tN6xMmfVKj3IWtE1zlKefSirODXK00QmkEkKzKrIRyiVtpgh4jaoHnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319990; c=relaxed/simple;
	bh=IxEqqKIe9EzhCZoMkEFAE23hSEe6gRgkdmo8KMpCwJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6yFpglA07oineuw6XJmGx2wSD8mUPiG+qIjaIXKTCken0U3T38+2Si0849O3d+Pt0y2igGwJ/oI1mUwUA95yTh0zSr2Kyk3ehymsz0dH9RfXfGjWeMgi81EQNdColcqQuW7gCNIH7VhmfrJe+C9zRmhAqPgoCWNFnIcbmPC1+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW0P7HOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B4CC43399;
	Sun, 24 Mar 2024 22:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319990;
	bh=IxEqqKIe9EzhCZoMkEFAE23hSEe6gRgkdmo8KMpCwJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mW0P7HOHLMZyMFgUur5AVeIGy5k6spVZL3X1JJXhUpMxELngygBf/QtOMuN6OJs0M
	 s3ilSfuxsXMoQxlNFe6jsFX67a+oq/Fw25Y3N0/s25ufSBcPPd8/h2fmUaBWjoVXZG
	 sn65jI8YkoVroPRPwpBsji3+64ypvjkqO3YGMZw0SP9Pbz5dxYCjhXEAiByj9AwDZE
	 J5V3zx5Q6Cw99UBCERy+bguP8T6g+kB43GHCksgNhLYkrjykKKXzK0cCc9qMqnkM27
	 HaBFXO56ULGf2H9T6IZc6DaQoXhHngWePY3wIQLddftBsI21DdmSvK7ylNgIPF4SHI
	 tt9ASBnGrO3hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 296/715] iommu/vt-d: Use device rbtree in iopf reporting path
Date: Sun, 24 Mar 2024 18:27:55 -0400
Message-ID: <20240324223455.1342824-297-sashal@kernel.org>
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

[ Upstream commit def054b01a867822254e1dda13d587f5c7a99e2a ]

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
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 81e921fd3216 ("iommu/vt-d: Fix NULL domain on device release")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c |  3 +++
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/svm.c   | 17 +++++++++--------
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ad8a340fc7f1d..36d7427b12026 100644
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
index 9e07e4425ff65..31b5d852ba732 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4431,8 +4431,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
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
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index df00240ebe90b..cd267ba64eda1 100644
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
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 40edd282903fb..ec47ec81f0ecd 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -650,7 +650,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	struct intel_iommu *iommu = d;
 	struct page_req_dsc *req;
 	int head, tail, handled;
-	struct pci_dev *pdev;
+	struct device *dev;
 	u64 address;
 
 	/*
@@ -696,23 +696,24 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
2.43.0


