Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D15A801BEF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjLBJzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLBJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:55:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2881A4;
        Sat,  2 Dec 2023 01:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701510958; x=1733046958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ezFO7DlF7HjinwT5gG8xfHRYCaAw4XvRxjdlb8ZqGls=;
  b=eNuKTgKc87Scq9Rm16NVSPj59OTv1bDkEDSclTBM0pWKJF0EBJNsszKQ
   aU94kgzVru+dKRPxJ/bJQdxtaMTXrMCmvdQQpMUcRtWybJtB/WIDd2xUm
   StTHuOaIABnHz8zGU5WclBVLKZ1FYQJjpCS02pVc/Lr0wQhrbW14QpVt7
   Fs6z1IOZydy8SKJUKyx5WcCR5UehRLBVq8z1h+UvYHGImqnqBwyWefc5i
   BguP12WGb6IpQoyPGgMmmWgqlDJHQfrKbM4WtgKTBZm//EwnlxVxy/GF9
   KGAaRyxlunqkWYFMndMD2LOsdjwi03w1J50MSzHhd5yikfinIRU+fOx6X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="625623"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="625623"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:55:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="719780952"
X-IronPort-AV: E=Sophos;i="6.04,245,1695711600"; 
   d="scan'208";a="719780952"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 01:55:53 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alex.williamson@redhat.com, jgg@nvidia.com, pbonzini@redhat.com,
        seanjc@google.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [RFC PATCH 23/42] iommu/vt-d: Allow pasid 0 in IOPF
Date:   Sat,  2 Dec 2023 17:26:57 +0800
Message-Id: <20231202092657.14822-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231202091211.13376-1-yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pasid 0 is allowed when IOPFs are triggered in second level page tables.
Page requests/response with pasid 0 or without pasid are also permitted by
vt-d hardware spec.

FIXME:
Current .page_response and intel_svm_enable_prq() are bound to SVM and
is compiled only with CONFIG_INTEL_IOMMU_SVM.
e.g.
        .page_response          = intel_svm_page_response,

Need to move prq enableing and page response code outside of svm.c and
SVM independent.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/iommu/intel/svm.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 659de9c160241..a2a63a85baa9f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -628,6 +628,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	int head, tail, handled;
 	struct pci_dev *pdev;
 	u64 address;
+	bool bad_req = false;
 
 	/*
 	 * Clear PPR bit before reading head/tail registers, to ensure that
@@ -642,30 +643,29 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		req = &iommu->prq[head / sizeof(*req)];
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 
-		if (unlikely(!req->pasid_present)) {
-			pr_err("IOMMU: %s: Page request without PASID\n",
+		if (unlikely(!req->pasid_present))
+			pr_info("IOMMU: %s: Page request without PASID\n",
 			       iommu->name);
-bad_req:
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
-			goto prq_advance;
-		}
 
 		if (unlikely(!is_canonical_address(address))) {
 			pr_err("IOMMU: %s: Address is not canonical\n",
 			       iommu->name);
-			goto bad_req;
+			bad_req = true;
+			goto prq_advance;
 		}
 
 		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
 			pr_err("IOMMU: %s: Page request in Privilege Mode\n",
 			       iommu->name);
-			goto bad_req;
+			bad_req = true;
+			goto prq_advance;
 		}
 
 		if (unlikely(req->exe_req && req->rd_req)) {
 			pr_err("IOMMU: %s: Execution request not supported\n",
 			       iommu->name);
-			goto bad_req;
+			bad_req = true;
+			goto prq_advance;
 		}
 
 		/* Drop Stop Marker message. No need for a response. */
@@ -679,8 +679,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
-		if (!pdev)
-			goto bad_req;
+		if (!pdev) {
+			bad_req = true;
+			goto prq_advance;
+		}
 
 		if (intel_svm_prq_report(iommu, &pdev->dev, req))
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
@@ -688,8 +690,14 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
 					 req->priv_data[0], req->priv_data[1],
 					 iommu->prq_seq_number++);
+
 		pci_dev_put(pdev);
+
 prq_advance:
+		if (bad_req) {
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			bad_req = false;
+		}
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
 
@@ -747,12 +755,7 @@ int intel_svm_page_response(struct device *dev,
 	private_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
 	last_page = prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 
-	if (!pasid_present) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (prm->pasid == 0 || prm->pasid >= PASID_MAX) {
+	if (prm->pasid >= PASID_MAX) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.17.1

