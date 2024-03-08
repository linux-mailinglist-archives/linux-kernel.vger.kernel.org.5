Return-Path: <linux-kernel+bounces-96859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC3E876248
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7DCB21C15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50A555E5A;
	Fri,  8 Mar 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+tw7vlN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7F55788
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894439; cv=none; b=hUo62OS+aQwKXerdtpm99ThKlrHG4DN8sul0t1HYUJqFohAaXUc2JCFGNJPm5veQVTU0KYUJbVsoq6P7eoIFYns9zUDw032kDupingdKn9/Yb/vEHTJ/Kv7aiAblu7clbthwTOD7zPQi+2aToS1JmOiDzpvaRDHYqS2O9mME/GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894439; c=relaxed/simple;
	bh=sqjtnk2kpZ6tqaZilKg9rp27qpp1KunwI56n7T7xKbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evkImrpMMjKNMVVD1CRiYkl1cFsRdbmVfpO5bQ+uUZNZBJQKL/gLWNf0+5iLezCnUsnKHeWCq2IyupqcUGAkDZyZPa9eVlTm8ZjQIIARof9HCWV2etHY4QkxbcvNR9CnKY343X2TPn8G/UtAisF+BufEaadjDaO0rUJrUx0XqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+tw7vlN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709894438; x=1741430438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqjtnk2kpZ6tqaZilKg9rp27qpp1KunwI56n7T7xKbU=;
  b=G+tw7vlNThg6THRSAhn9BofMhhoO820mpBHePTqKbBf9QPWjtO3+PIFH
   cYZia3X+iiPJsYTrQ9FpcQhvsqy5NoXmlGexQygtfZmv6YXsRBB3lDKXq
   JaMAfuPO4zJtWB23ze2i0L6q62rrEUom/IOiXSrcI0ndC0uSLO9Ic/PW1
   NQYPEho4amNy4Bk9OLK0M7RmP/eY+ZI50rLpQt9gTcnR20GR3eFvi92R1
   hW2uIrhknDP63sOAL0urABE1GJ20649J0KM4lmDUwyc1xABYC+O4EKoCh
   WwSQnmpRurvT5G/PU2/QFRfqjxKI3zHAZpLqQMs8Un7Zt+iE5YEMCtbHF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4468252"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4468252"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10327733"
Received: from cascade.sh.intel.com ([10.239.48.141])
  by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 02:40:35 -0800
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 2/2] iommu/vt-d: Remove private data use in fault message
Date: Fri,  8 Mar 2024 18:38:11 +0800
Message-Id: <20240308103811.76744-3-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240308103811.76744-1-Jingqi.liu@intel.com>
References: <20240308103811.76744-1-Jingqi.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Intel VT-d specification revision 4.0, "Private Data"
field has been removed from Page Request/Response.

Since the private data field is not used in fault message, remove the
related definitions in page request descriptor and remove the related
code in page request/response handler, as Intel hasn't shipped any
products which support private data in the page request message.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/svm.c   | 75 ++++++++-----------------------------
 include/linux/iommu.h       |  3 +-
 3 files changed, 16 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 404d2476a877..9ee326f7bf62 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -455,7 +455,6 @@ enum {
 
 /* Page group response descriptor QW0 */
 #define QI_PGRP_PASID_P(p)	(((u64)(p)) << 4)
-#define QI_PGRP_PDP(p)		(((u64)(p)) << 5)
 #define QI_PGRP_RESP_CODE(res)	(((u64)(res)) << 12)
 #define QI_PGRP_DID(rid)	(((u64)(rid)) << 16)
 #define QI_PGRP_PASID(pasid)	(((u64)(pasid)) << 32)
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4b2eeb55489d..699bef9b9197 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -418,8 +418,7 @@ struct page_req_dsc {
 		struct {
 			u64 type:8;
 			u64 pasid_present:1;
-			u64 priv_data_present:1;
-			u64 rsvd:6;
+			u64 rsvd:7;
 			u64 rid:16;
 			u64 pasid:20;
 			u64 exe_req:1;
@@ -438,7 +437,8 @@ struct page_req_dsc {
 		};
 		u64 qw_1;
 	};
-	u64 priv_data[2];
+	u64 qw_2;
+	u64 qw_3;
 };
 
 static bool is_canonical_address(u64 addr)
@@ -572,18 +572,6 @@ static void intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
 	}
-	if (desc->priv_data_present) {
-		/*
-		 * Set last page in group bit if private data is present,
-		 * page response is required as it does for LPIG.
-		 * iommu_report_device_fault() doesn't understand this vendor
-		 * specific requirement thus we set last_page as a workaround.
-		 */
-		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
-		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
-		event.fault.prm.private_data[0] = desc->priv_data[0];
-		event.fault.prm.private_data[1] = desc->priv_data[1];
-	}
 
 	iommu_report_device_fault(dev, &event);
 }
@@ -591,39 +579,23 @@ static void intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
 static void handle_bad_prq_event(struct intel_iommu *iommu,
 				 struct page_req_dsc *req, int result)
 {
-	struct qi_desc desc;
+	struct qi_desc desc = { };
 
 	pr_err("%s: Invalid page request: %08llx %08llx\n",
 	       iommu->name, ((unsigned long long *)req)[0],
 	       ((unsigned long long *)req)[1]);
 
-	/*
-	 * Per VT-d spec. v3.0 ch7.7, system software must
-	 * respond with page group response if private data
-	 * is present (PDP) or last page in group (LPIG) bit
-	 * is set. This is an additional VT-d feature beyond
-	 * PCI ATS spec.
-	 */
-	if (!req->lpig && !req->priv_data_present)
+	if (!req->lpig)
 		return;
 
 	desc.qw0 = QI_PGRP_PASID(req->pasid) |
 			QI_PGRP_DID(req->rid) |
 			QI_PGRP_PASID_P(req->pasid_present) |
-			QI_PGRP_PDP(req->priv_data_present) |
 			QI_PGRP_RESP_CODE(result) |
 			QI_PGRP_RESP_TYPE;
 	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
 			QI_PGRP_LPIG(req->lpig);
 
-	if (req->priv_data_present) {
-		desc.qw2 = req->priv_data[0];
-		desc.qw3 = req->priv_data[1];
-	} else {
-		desc.qw2 = 0;
-		desc.qw3 = 0;
-	}
-
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
@@ -691,7 +663,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		intel_svm_prq_report(iommu, dev, req);
 		trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
-				 req->priv_data[0], req->priv_data[1],
+				 req->qw_2, req->qw_3,
 				 iommu->prq_seq_number++);
 		mutex_unlock(&iommu->iopf_lock);
 prq_advance:
@@ -730,7 +702,7 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 	struct intel_iommu *iommu = info->iommu;
 	u8 bus = info->bus, devfn = info->devfn;
 	struct iommu_fault_page_request *prm;
-	bool private_present;
+	struct qi_desc desc;
 	bool pasid_present;
 	bool last_page;
 	u16 sid;
@@ -738,34 +710,17 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 	prm = &evt->fault.prm;
 	sid = PCI_DEVID(bus, devfn);
 	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-	private_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
 	last_page = prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 
-	/*
-	 * Per VT-d spec. v3.0 ch7.7, system software must respond
-	 * with page group response if private data is present (PDP)
-	 * or last page in group (LPIG) bit is set. This is an
-	 * additional VT-d requirement beyond PCI ATS spec.
-	 */
-	if (last_page || private_present) {
-		struct qi_desc desc;
-
-		desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
-				QI_PGRP_PASID_P(pasid_present) |
-				QI_PGRP_PDP(private_present) |
-				QI_PGRP_RESP_CODE(msg->code) |
-				QI_PGRP_RESP_TYPE;
-		desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
-		desc.qw2 = 0;
-		desc.qw3 = 0;
-
-		if (private_present) {
-			desc.qw2 = prm->private_data[0];
-			desc.qw3 = prm->private_data[1];
-		}
+	desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
+			QI_PGRP_PASID_P(pasid_present) |
+			QI_PGRP_RESP_CODE(msg->code) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 
-		qi_submit_sync(iommu, &desc, 1, 0);
-	}
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index af6c367ed673..523bcb672efe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -69,8 +69,7 @@ enum iommu_fault_type {
 struct iommu_fault_page_request {
 #define IOMMU_FAULT_PAGE_REQUEST_PASID_VALID	(1 << 0)
 #define IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE	(1 << 1)
-#define IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA	(1 << 2)
-#define IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID	(1 << 3)
+#define IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID	(1 << 2)
 	u32	flags;
 	u32	pasid;
 	u32	grpid;
-- 
2.21.3


