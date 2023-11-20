Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D57C7F1220
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjKTLef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjKTLeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:34:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E38EE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700480060; x=1732016060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2nGnhJsGWMGRpp0Vox7JpzqGcC9rTc12DoKGBk9V+/8=;
  b=WUTeIb4qzflTymiRObQ2bOBFCp6ZwW7EHLUel2fjFtF6XS6TorgQf5fF
   iV/cawayJZlvck0PUAkYpO5FUgs/MyjE9yx29ohWp2QJ5S8st5C+g6Loc
   r16QDcTDDT63hs6jzjAOuIU++P+RTCM4N3iV+eqvRZnrgEMDKAvsHXqvL
   fJMp5kMaqzREvEKFQJ4R1t9A4lvfsZn5bpJQjulWeKAYx70r9xwnAMsL3
   mBIwM7O211DhDMfgOXPNdWmXc4EU90epZ6rHuxhdKQqrPz0//ejMvA7t3
   qg93soyYkXe4aABcFW9/46u47to0j5cATm5v9kBxEo8JwLo2ehX2N5fFd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="376635000"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="376635000"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856963632"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="856963632"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Nov 2023 03:34:12 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/5] iommu/vt-d: Refactor domain_context_mapping_one() to be reusable
Date:   Mon, 20 Nov 2023 19:29:42 +0800
Message-Id: <20231120112944.142741-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120112944.142741-1-baolu.lu@linux.intel.com>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract common code from domain_context_mapping_one() into new functions,
making it reusable by other functions such as the upcoming identity domain
implementation. No intentional functional changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 99 ++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 77769ad4706e..86339dc30243 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1727,6 +1727,61 @@ static void domain_exit(struct dmar_domain *domain)
 	kfree(domain);
 }
 
+/*
+ * For kdump cases, old valid entries may be cached due to the
+ * in-flight DMA and copied pgtable, but there is no unmapping
+ * behaviour for them, thus we need an explicit cache flush for
+ * the newly-mapped device. For kdump, at this point, the device
+ * is supposed to finish reset at its driver probe stage, so no
+ * in-flight DMA will exist, and we don't need to worry anymore
+ * hereafter.
+ */
+static void copied_context_tear_down(struct intel_iommu *iommu,
+				     struct context_entry *context,
+				     u8 bus, u8 devfn)
+{
+	u16 did_old;
+
+	if (!context_copied(iommu, bus, devfn))
+		return;
+
+	assert_spin_locked(&iommu->lock);
+
+	did_old = context_domain_id(context);
+	context_clear_entry(context);
+
+	if (did_old < cap_ndoms(iommu->cap)) {
+		iommu->flush.flush_context(iommu, did_old,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
+					 DMA_TLB_DSI_FLUSH);
+	}
+
+	clear_context_copied(iommu, bus, devfn);
+}
+
+/*
+ * It's a non-present to present mapping. If hardware doesn't cache
+ * non-present entry we only need to flush the write-buffer. If the
+ * _does_ cache non-present entries, then it does so in the special
+ * domain #0, which we have to flush:
+ */
+static void context_present_cache_flush(struct intel_iommu *iommu, u16 did,
+					u8 bus, u8 devfn)
+{
+	if (cap_caching_mode(iommu->cap)) {
+		iommu->flush.flush_context(iommu, 0,
+					   (((u16)bus) << 8) | devfn,
+					   DMA_CCMD_MASK_NOBIT,
+					   DMA_CCMD_DEVICE_INVL);
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
+	} else {
+		iommu_flush_write_buffer(iommu);
+	}
+}
+
 static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
 				      u8 bus, u8 devfn)
@@ -1755,31 +1810,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	if (context_present(context) && !context_copied(iommu, bus, devfn))
 		goto out_unlock;
 
-	/*
-	 * For kdump cases, old valid entries may be cached due to the
-	 * in-flight DMA and copied pgtable, but there is no unmapping
-	 * behaviour for them, thus we need an explicit cache flush for
-	 * the newly-mapped device. For kdump, at this point, the device
-	 * is supposed to finish reset at its driver probe stage, so no
-	 * in-flight DMA will exist, and we don't need to worry anymore
-	 * hereafter.
-	 */
-	if (context_copied(iommu, bus, devfn)) {
-		u16 did_old = context_domain_id(context);
-
-		if (did_old < cap_ndoms(iommu->cap)) {
-			iommu->flush.flush_context(iommu, did_old,
-						   (((u16)bus) << 8) | devfn,
-						   DMA_CCMD_MASK_NOBIT,
-						   DMA_CCMD_DEVICE_INVL);
-			iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-		}
-
-		clear_context_copied(iommu, bus, devfn);
-	}
-
+	copied_context_tear_down(iommu, context, bus, devfn);
 	context_clear_entry(context);
+
 	context_set_domain_id(context, did);
 
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
@@ -1815,23 +1848,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	context_set_present(context);
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(context, sizeof(*context));
-
-	/*
-	 * It's a non-present to present mapping. If hardware doesn't cache
-	 * non-present entry we only need to flush the write-buffer. If the
-	 * _does_ cache non-present entries, then it does so in the special
-	 * domain #0, which we have to flush:
-	 */
-	if (cap_caching_mode(iommu->cap)) {
-		iommu->flush.flush_context(iommu, 0,
-					   (((u16)bus) << 8) | devfn,
-					   DMA_CCMD_MASK_NOBIT,
-					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
-	} else {
-		iommu_flush_write_buffer(iommu);
-	}
-
+	context_present_cache_flush(iommu, did, bus, devfn);
 	ret = 0;
 
 out_unlock:
-- 
2.34.1

