Return-Path: <linux-kernel+bounces-156461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7D68B02FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E4D1C232EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36400157E82;
	Wed, 24 Apr 2024 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N89PL4OH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B67157E6E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943103; cv=none; b=j8TjaVN72QjTTHRP8YxxLpHE61V0qVm+3N6e+dKyPsmy2u9Nok3WJJj2I5GGSODCzmVL9xwOCRz1n+fUVrKAJtAxReVHz8TdwzraJk84GFOPwETuPX10FrQM0JDLVUI8l1d5gbP9q+qKGFH77/NycVBTH58M5ug8tOW5KFR62tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943103; c=relaxed/simple;
	bh=Lgv1S0D9TkAps3PaQ4VGBajKrEr13yIhuHR2MyCo7wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlIQ6RCYp+YqBhJbcEbNc3m56G4sF78ScKcXAIwUZgaWFMRFjS9gT8DgxBmA9Zys4IwEzNYrSGVOj7/8MpPhlh1yi4rL9puPgT7fkyFOLwTeg7QlsgPHdbuxrqYox1qIMt4uv+kWHVWzd0Eyx2lP5eEcrUZNPedOxD6KNQAW03c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N89PL4OH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943102; x=1745479102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lgv1S0D9TkAps3PaQ4VGBajKrEr13yIhuHR2MyCo7wg=;
  b=N89PL4OH1OTARc7ZlnJgANAwBjZcLoXpOomWB2AHuY8CcXL5XoSdRNcN
   /p+Dq7FjAJJrpVzAum10LDO+LdGFxPiir+UvDaPvG+hYa+d5x7J55P6lW
   Q6WoNRqm4xSmQ0Y4OSF8SKyKU7MCovMnVsmMRB0lwOti2TSIxkNmW0P9C
   WIy0A1FaE3TXnj3zsK9u1t050c3B6SLsDRfZD/LurdpzZTwIyKaCx52+I
   pXMs2Tr7E++faC5IXmuF2DaztkBvt8I2U2jjy+RUb2wWh8IlxyAvNdPNT
   JHqvSj0mXLsdYn9vSsovbjQKyPME2aZEFM7OK9FWWjclUL1QuuEPX/h+O
   Q==;
X-CSE-ConnectionGUID: vwA6q7VhSqqbT9jjLj7EHQ==
X-CSE-MsgGUID: HjSqNGMASGG/2wvgNObT/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073132"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073132"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:21 -0700
X-CSE-ConnectionGUID: gruX9Di4QYKewv00ZvmMEA==
X-CSE-MsgGUID: srO8zIJgQAqqUISBumukPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24664947"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/18] iommu/vt-d: Remove private data use in fault message
Date: Wed, 24 Apr 2024 15:16:31 +0800
Message-Id: <20240424071644.178250-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jingqi Liu <Jingqi.liu@intel.com>

According to Intel VT-d specification revision 4.0, "Private Data"
field has been removed from Page Request/Response.

Since the private data field is not used in fault message, remove the
related definitions in page request descriptor and remove the related
code in page request/response handler, as Intel hasn't shipped any
products which support private data in the page request message.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
Link: https://lore.kernel.org/r/20240308103811.76744-3-Jingqi.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h       |  3 +-
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/svm.c   | 75 ++++++++-----------------------------
 3 files changed, 16 insertions(+), 63 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2e925b5eba53..e6549bdfaed9 100644
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
index e014350db354..e05c6c4cb8c3 100644
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
+	desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
+			QI_PGRP_PASID_P(pasid_present) |
+			QI_PGRP_RESP_CODE(msg->code) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
 
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
-
-		qi_submit_sync(iommu, &desc, 1, 0);
-	}
+	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
-- 
2.34.1


