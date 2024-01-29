Return-Path: <linux-kernel+bounces-42144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553483FD00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E7D284A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4223C062;
	Mon, 29 Jan 2024 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V79es/nS"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C733CDF;
	Mon, 29 Jan 2024 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500191; cv=none; b=eJRIqgiR4VV2yep1BU/0kVIZ6h741pU7dPc9/NotHOaI07COFJc5mltFf6Ahrh/o1HjPsAKRFN+priYqWoEN6nuWIy2XSU7cYXo6JmK0+MDywtX44kNNH/NNjAfZ+LD9UabfXY5YVp0guARocGQPRFTwLwANnKuQEX3If0xmfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500191; c=relaxed/simple;
	bh=KwLnLW0GM4WrC4w7+eyMEInKGIRQc5jprpPEPne2asQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5W/KazK84YdEa+0ugeJ1NbWnHzaUjlR9oUCesMp5TCTCwAz6txADNItVbD021mhA3E/lLZHl9QNEoXBejTJtajdOu3NBUgxtcV5JhLn8JS6T8BcaokitYtWYlBLTjxbxrnqAJCimE250/5OMjK5QJZtXzMpj+2HilG08154FMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V79es/nS; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706500189; x=1738036189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KwLnLW0GM4WrC4w7+eyMEInKGIRQc5jprpPEPne2asQ=;
  b=V79es/nSU6lUJok6+c37CPB9ia7ApSBaO8VIV0LUJt3HFQoDatQXyEnn
   hoGscngxiPJdon0GVuBJhHUD0krms73VL4pp9LNDBxohN+yx4xKxvkIdz
   2z2gQqXCV0p115d/q1WqD+We+3IkKjDfVBdD68SujAyF7iX4G0hvuA95I
   yYxm8grmPtE19xMFFUrS5Jt45WJO5RtL+m6CEzhE3XWCAxlTiepfEVvcF
   pIa7fMwgNxQgj9m6NGMJLTMaGcSwSwc1xsxo2BITsZSjBeV2wx+2SkOD2
   nJgs9Fv3Vp7yQFR//IJ6qSeYWO2Njp1cyZaCcp58WYDnyDkWDA7jr9tnZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406566961"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406566961"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 19:49:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960775224"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="960775224"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2024 19:49:45 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v12 4/5] iommu/vt-d: pass pdev parameter for qi_check_fault() and refactor callers
Date: Sun, 28 Jan 2024 22:49:23 -0500
Message-Id: <20240129034924.817005-5-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

to check state of ATS capable pci device in qi_check_fault() for surprise
removal case, we need to pass the target pci device of ATS invalidation
request to qi_check_fault(). if pdev is valid, means current request is for
ATS invalidation, vice vesa.

no function change.

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c          | 31 ++++++++++++++++++-----------
 drivers/iommu/intel/iommu.h         |  3 ++-
 drivers/iommu/intel/irq_remapping.c |  2 +-
 drivers/iommu/intel/pasid.c         |  2 +-
 drivers/iommu/intel/svm.c           |  6 +++---
 5 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ab5e1760bd59..814134e9aa5a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1267,7 +1267,8 @@ static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
 	       (unsigned long long)desc->qw1);
 }
 
-static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
+static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index,
+			  struct pci_dev *pdev)
 {
 	u32 fault;
 	int head, tail;
@@ -1344,7 +1345,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
  * can be part of the submission but it will not be polled for completion.
  */
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
-		   unsigned int count, unsigned long options)
+		   unsigned int count, unsigned long options,
+		   struct pci_dev *pdev)
 {
 	struct q_inval *qi = iommu->qi;
 	s64 devtlb_start_ktime = 0;
@@ -1430,7 +1432,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		 * a deadlock where the interrupt context can wait indefinitely
 		 * for free slots in the queue.
 		 */
-		rc = qi_check_fault(iommu, index, wait_index);
+		rc = qi_check_fault(iommu, index, wait_index, pdev);
 		if (rc)
 			break;
 
@@ -1476,7 +1478,7 @@ void qi_global_iec(struct intel_iommu *iommu)
 	desc.qw3 = 0;
 
 	/* should never fail */
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
@@ -1490,7 +1492,7 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
@@ -1514,23 +1516,27 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_dev_iotlb(struct intel_iommu *iommu,
 			struct device_domain_info *info, u64 addr,
 			unsigned int mask)
 {
+	struct pci_dev *pdev = NULL;
 	u16 sid, qdep, pfsid;
 	struct qi_desc desc;
 
 	if (!info || !info->ats_enabled)
 		return;
 
+	if (info->dev || !dev_is_pci(info->dev))
+		return;
+
+	pdev = to_pci_dev(info->dev);
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
-
 	/*
 	 * VT-d spec, section 4.3:
 	 *
@@ -1554,7 +1560,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, pdev);
 }
 
 /* PASID-based IOTLB invalidation */
@@ -1595,7 +1601,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 				QI_EIOTLB_AM(mask);
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 /* PASID-based device IOTLB Invalidate */
@@ -1605,15 +1611,16 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
 {
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
+	struct pci_dev *pdev = NULL;
 	u16 sid, qdep, pfsid;
 
 	if (!info || !dev_is_pci(info->dev))
 		return;
 
+	pdev = to_pci_dev(info->dev);
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
-
 	/*
 	 * VT-d spec, section 4.3:
 	 *
@@ -1657,7 +1664,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
 		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, pdev);
 }
 
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
@@ -1667,7 +1674,7 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
 
 	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
 			QI_PC_GRAN(granu) | QI_PC_TYPE;
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 /*
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f68f17476d85..72e1d5fb2114 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1052,7 +1052,8 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  u32 pasid);
 
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
-		   unsigned int count, unsigned long options);
+		   unsigned int count, unsigned long options,
+		   struct pci_dev *pdev);
 /*
  * Options used in qi_submit_sync:
  * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 566297bc87dd..09276bfa127d 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -153,7 +153,7 @@ static int qi_flush_iec(struct intel_iommu *iommu, int index, int mask)
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	return qi_submit_sync(iommu, &desc, 1, 0);
+	return qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static int modify_irte(struct irq_2_iommu *irq_iommu,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5dacdea3cab7..8bba5721aeba 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -200,7 +200,7 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static void
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 89168b31bf31..c2f4f3822191 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -538,7 +538,7 @@ void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 			QI_DEV_IOTLB_PFSID(info->pfsid);
 qi_retry:
 	reinit_completion(&iommu->prq_complete);
-	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
+	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN, NULL);
 	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
 		wait_for_completion(&iommu->prq_complete);
 		goto qi_retry;
@@ -641,7 +641,7 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 		desc.qw3 = 0;
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static irqreturn_t prq_event_thread(int irq, void *d)
@@ -797,7 +797,7 @@ int intel_svm_page_response(struct device *dev,
 				ktime_to_ns(ktime_get()) - prm->private_data[0]);
 		}
 
-		qi_submit_sync(iommu, &desc, 1, 0);
+		qi_submit_sync(iommu, &desc, 1, 0, NULL);
 	}
 out:
 	return ret;
-- 
2.31.1


