Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8414C80440A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346245AbjLEB0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbjLEB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:26:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B5010F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701739611; x=1733275611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UMkeLFUpYAwPaBYnzxx/I6VFYpGlFn70X93po/+cGE0=;
  b=lqYLp0A4kNT760HrbdSo1KwKyMJ3G9KFKqYsAxfkMH5JUZ9XZ1slPe6w
   JTeAgHGnIGEyo0YZl1aaCB8gWxKiYyQFJ+La1l8rF3oy98kQChkehvaC5
   8j6ByK7c+2r7Ls8ysl+BzFohww1iZnHM5nNh0T+XqQ2iL4gZExvRIU1V+
   2Ho/49FnS8X21wrzKZ963UDxSPGUwZrPjO4q/wZINQ9gVgNJd+9GZBi9q
   AHzOzsfAq8jg/9RCvl8wO3mWDTlP8SOlpNG2z3Bnq3uxypVzLE0gPteRr
   q7AHOfBRoSI/1X4BcDN35fJlgzMHgAMRDnujxfaJ77U4yIpXv+FX7806l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="460313355"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="460313355"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:26:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1102276279"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1102276279"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2023 17:26:49 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity domain
Date:   Tue,  5 Dec 2023 09:22:01 +0800
Message-Id: <20231205012203.244584-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205012203.244584-1-baolu.lu@linux.intel.com>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older VT-d hardware implementations did not support pass-through
translation mode. The iommu driver relied on a DMA domain with all
physical memory addresses identically mapped to the same IOVA to
simulate pass-through translation.

This workaround is no longer necessary due to the evolution of iommu
core. The core has introduced def_domain_type op, allowing the iommu
driver to specify its capabilities. Additionally, the identity domain
has become a static system domain with "never fail" attach semantics.

Eliminate support for the 1:1 mapping domain on older hardware and
removes the unused code that created the 1:1 page table. This paves a
way for the implementation of a global static identity domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 118 +++---------------------------------
 1 file changed, 10 insertions(+), 108 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 605cd1c52e95..7022cc183120 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2146,29 +2146,10 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static int iommu_domain_identity_map(struct dmar_domain *domain,
-				     unsigned long first_vpfn,
-				     unsigned long last_vpfn)
-{
-	/*
-	 * RMRR range might have overlap with physical memory range,
-	 * clear it first
-	 */
-	dma_pte_clear_range(domain, first_vpfn, last_vpfn);
-
-	return __domain_mapping(domain, first_vpfn,
-				first_vpfn, last_vpfn - first_vpfn + 1,
-				DMA_PTE_READ|DMA_PTE_WRITE, GFP_KERNEL);
-}
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(int hw)
 {
-	struct dmar_rmrr_unit *rmrr;
-	struct device *dev;
-	int i, nid, ret;
-
 	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
 	if (!si_domain)
 		return -EFAULT;
@@ -2179,44 +2160,6 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 	}
 
-	if (hw)
-		return 0;
-
-	for_each_online_node(nid) {
-		unsigned long start_pfn, end_pfn;
-		int i;
-
-		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn_start(start_pfn),
-					mm_to_dma_pfn_end(end_pfn));
-			if (ret)
-				return ret;
-		}
-	}
-
-	/*
-	 * Identity map the RMRRs so that devices with RMRRs could also use
-	 * the si_domain.
-	 */
-	for_each_rmrr_units(rmrr) {
-		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
-					  i, dev) {
-			unsigned long long start = rmrr->base_address;
-			unsigned long long end = rmrr->end_address;
-
-			if (WARN_ON(end < start ||
-				    end >> agaw_to_width(si_domain->agaw)))
-				continue;
-
-			ret = iommu_domain_identity_map(si_domain,
-					mm_to_dma_pfn_start(start >> PAGE_SHIFT),
-					mm_to_dma_pfn_end(end >> PAGE_SHIFT));
-			if (ret)
-				return ret;
-		}
-	}
-
 	return 0;
 }
 
@@ -2301,6 +2244,9 @@ static bool device_rmrr_is_relaxable(struct device *dev)
  */
 static int device_def_domain_type(struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
@@ -2311,6 +2257,13 @@ static int device_def_domain_type(struct device *dev)
 			return IOMMU_DOMAIN_IDENTITY;
 	}
 
+	/*
+	 * Hardware does not support the passthrough translation mode.
+	 * Always use a dynamaic mapping domain.
+	 */
+	if (!ecap_pass_through(iommu->ecap))
+		return IOMMU_DOMAIN_DMA;
+
 	return 0;
 }
 
@@ -3301,52 +3254,6 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 	return 0;
 }
 
-static int intel_iommu_memory_notifier(struct notifier_block *nb,
-				       unsigned long val, void *v)
-{
-	struct memory_notify *mhp = v;
-	unsigned long start_vpfn = mm_to_dma_pfn_start(mhp->start_pfn);
-	unsigned long last_vpfn = mm_to_dma_pfn_end(mhp->start_pfn +
-			mhp->nr_pages - 1);
-
-	switch (val) {
-	case MEM_GOING_ONLINE:
-		if (iommu_domain_identity_map(si_domain,
-					      start_vpfn, last_vpfn)) {
-			pr_warn("Failed to build identity map for [%lx-%lx]\n",
-				start_vpfn, last_vpfn);
-			return NOTIFY_BAD;
-		}
-		break;
-
-	case MEM_OFFLINE:
-	case MEM_CANCEL_ONLINE:
-		{
-			struct dmar_drhd_unit *drhd;
-			struct intel_iommu *iommu;
-			LIST_HEAD(freelist);
-
-			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
-
-			rcu_read_lock();
-			for_each_active_iommu(iommu, drhd)
-				iommu_flush_iotlb_psi(iommu, si_domain,
-					start_vpfn, mhp->nr_pages,
-					list_empty(&freelist), 0);
-			rcu_read_unlock();
-			put_pages_list(&freelist);
-		}
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block intel_iommu_memory_nb = {
-	.notifier_call = intel_iommu_memory_notifier,
-	.priority = 0
-};
-
 static void intel_disable_iommus(void)
 {
 	struct intel_iommu *iommu = NULL;
@@ -3643,12 +3550,7 @@ int __init intel_iommu_init(void)
 
 		iommu_pmu_register(iommu);
 	}
-	up_read(&dmar_global_lock);
 
-	if (si_domain && !hw_pass_through)
-		register_memory_notifier(&intel_iommu_memory_nb);
-
-	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
 
-- 
2.34.1

