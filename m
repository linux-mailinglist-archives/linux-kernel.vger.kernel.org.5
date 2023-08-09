Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82FC775FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHIMvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjHIMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:51:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EDB2681
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691585449; x=1723121449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoot58iZi4D+nuF4+mBQY+JTYodvcOohwejKW6VG6nI=;
  b=KvrDqgpdIfR1HYx6cuX1Dj0rk/olBiTQwYOr8czDBVpHu68P/HGWxgy4
   oqL5IgstnWX847W1qabjEezp+yOgJdW4kkBIDxoiOItFBOWiPESzY6SdT
   xwEbt+v0h8MV4WVMsplBWnmpYkB9K7GZIJGoNaoCqLn93VHyEFJmC8YPx
   6AUNDjLFEwBlbtkhYjv9iah3ZupFGo/iePHc4Bw3ROP4mMUeHNWpFh5Y7
   b31diWg8WOPkbhyQPP8iWQElu1WA+lJJf/2NHQI4cL7sjt6VzTaqgbFTJ
   Vb2dpX7O4h221Rmr0dLhm9CXEFCkuydTja4S0DaY32wfJtGGXvmgMOTK/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374821770"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="374821770"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 05:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855521878"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="855521878"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2023 05:50:45 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Yanfei Xu <yanfei.xu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] iommu/vt-d: Fix to convert mm pfn to dma pfn
Date:   Wed,  9 Aug 2023 20:48:05 +0800
Message-Id: <20230809124806.45516-13-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@intel.com>

For the case that VT-d page is smaller than mm page, converting dma pfn
should be handled in two cases which are for start pfn and for end pfn.
Currently the calculation of end dma pfn is incorrect and the result is
less than real page frame number which is causing the mapping of iova
always misses some page frames.

Rename the mm_to_dma_pfn() to mm_to_dma_pfn_start() and add a new helper
for converting end dma pfn named mm_to_dma_pfn_end().

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
Link: https://lore.kernel.org/r/20230625082046.979742-1-yanfei.xu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1f89714ca462..dd8ff358867d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -113,13 +113,17 @@ static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
 
 /* VT-d pages must always be _smaller_ than MM pages. Otherwise things
    are never going to work. */
-static inline unsigned long mm_to_dma_pfn(unsigned long mm_pfn)
+static inline unsigned long mm_to_dma_pfn_start(unsigned long mm_pfn)
 {
 	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
 }
+static inline unsigned long mm_to_dma_pfn_end(unsigned long mm_pfn)
+{
+	return ((mm_pfn + 1) << (PAGE_SHIFT - VTD_PAGE_SHIFT)) - 1;
+}
 static inline unsigned long page_to_dma_pfn(struct page *pg)
 {
-	return mm_to_dma_pfn(page_to_pfn(pg));
+	return mm_to_dma_pfn_start(page_to_pfn(pg));
 }
 static inline unsigned long virt_to_dma_pfn(void *p)
 {
@@ -2403,8 +2407,8 @@ static int __init si_domain_init(int hw)
 
 		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn(start_pfn),
-					mm_to_dma_pfn(end_pfn));
+					mm_to_dma_pfn_start(start_pfn),
+					mm_to_dma_pfn_end(end_pfn));
 			if (ret)
 				return ret;
 		}
@@ -2425,8 +2429,8 @@ static int __init si_domain_init(int hw)
 				continue;
 
 			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn(start >> PAGE_SHIFT),
-					mm_to_dma_pfn(end >> PAGE_SHIFT));
+					mm_to_dma_pfn_start(start >> PAGE_SHIFT),
+					mm_to_dma_pfn_end(end >> PAGE_SHIFT));
 			if (ret)
 				return ret;
 		}
@@ -3549,8 +3553,8 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 				       unsigned long val, void *v)
 {
 	struct memory_notify *mhp = v;
-	unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
-	unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
+	unsigned long start_vpfn = mm_to_dma_pfn_start(mhp->start_pfn);
+	unsigned long last_vpfn = mm_to_dma_pfn_end(mhp->start_pfn +
 			mhp->nr_pages - 1);
 
 	switch (val) {
@@ -4247,7 +4251,7 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 	unsigned long i;
 
 	nrpages = aligned_nrpages(gather->start, size);
-	start_pfn = mm_to_dma_pfn(iova_pfn);
+	start_pfn = mm_to_dma_pfn_start(iova_pfn);
 
 	xa_for_each(&dmar_domain->iommu_array, i, info)
 		iommu_flush_iotlb_psi(info->iommu, dmar_domain,
-- 
2.34.1

