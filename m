Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47100790C87
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 16:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbjICOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjICOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 10:41:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C78BF9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 07:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693752064; x=1725288064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HU6sOoKc5qmhOHDhjYsfKFLFD9TSlbqFBq8Caa+jJM4=;
  b=OesJlBPmj4DP2dFRHdrpJYzCbEwGbyBWTNvwOE+DPlSJzfEnEOrgBD9s
   7rPCyFTDv7JwsXmvTAynAuQGHcT3BXaiZAlQtSKcE5P1SUFkW7Qby+Qy+
   vz6Ia/bca/F7v7Wh+5MZNxKIOIXtSsKpp6QlqZUds2JwlkqLPdoRWtZtL
   b3h+rpeUQAORWNvFlmKGTgBxni8jtHIVFlw3BO9SMbYZWDQgJ4aHA1UyU
   2s7ePpOrFpcPs9DdF1dBQANC40pIWRmZpKAaDnC3cgJRk2iyeUdM8Ldsg
   kyb43548FriDFJ+O29Z79Mpt2p6CDMdGViIwvaVG13uYHFcZSjAP+FGgH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="376389993"
X-IronPort-AV: E=Sophos;i="6.02,224,1688454000"; 
   d="scan'208";a="376389993"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 07:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769732037"
X-IronPort-AV: E=Sophos;i="6.02,224,1688454000"; 
   d="scan'208";a="769732037"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2023 07:41:01 -0700
From:   Jingqi Liu <Jingqi.liu@intel.com>
To:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH] iommu/vt-d: debugfs: Fix race with iommu unmap when traversing
Date:   Sun,  3 Sep 2023 22:40:50 +0800
Message-Id: <20230903144050.11277-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When traversing page table, it may race with iommu unmap.

For the page table page pointed to by a PDPE/PDE, there are three
scenarios in the iommu unmap path.

  1) The page has been freed.

     If the page has a refcount of zero, it has been freed. The
     debugfs should avoid to traverse it.

     In the debugfs, the refcount of a page table page is checked
     before traversing it. If its refcount is zero, the page will not
     be traversed. If the refcount is not zero, increment its refcount
     before traversal and decrement its refcount after traversal.

  2) The page is not freed and the PDPE/PDE is not cleared.

     When the page is unlinked from its parent, it's not freed
     immediately. It will be freed as soon as the IOTLB is flushed.

     Before the page is freed, the contents in the page and all the
     pages under its level are stale. The debugfs should avoid to
     traverse these pages.

     According the VT-d specification, bit 3 of the PDPE/PTE pointing
     to a page directory/table is ignored by the hardware. The driver
     sets it to 0 by default. In the unmap path, set bit 3 to 1 to
     indicate that the page pointed to by the PDPE/PDE is stale.

     Check bit 3 of the PDPE/PDE before traversing the page pointed to
     by the PDPE/PDE in the debugfs. Traversal stops if bit 3 is 1.

  3) The page is not freed and the PDPE/PDE has been cleared.

     Check the preseent bit of the PDPE/PDE in the debugfs. The
     traversal stops if the present bit is cleared.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 47 +++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/iommu.c   | 16 ++++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 1f925285104e..e12f1ed88e65 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -333,9 +333,52 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 		path[level] = pde->val;
 		if (dma_pte_superpage(pde) || level == 1)
 			dump_page_info(m, start, path);
-		else
-			pgtable_walk_level(m, phys_to_virt(dma_pte_addr(pde)),
+		else {
+			/*
+			 * The entry references a Page-Directory Table
+			 * or a Page Table.
+			 */
+			struct page *pg;
+			u64 pte_addr;
+
+retry:
+			pte_addr = dma_pte_addr(pde);
+			pg = pfn_to_page(PFN_DOWN(pte_addr));
+			if (!get_page_unless_zero(pg))
+				/*
+				 * If this page has a refcount of zero,
+				 * it has been freed, or will be freed.
+				 */
+				continue;
+
+			/*
+			 * Check if the page that pointed to by the PDE is
+			 * stale. Bit 3 of the PDE is ignored by hardware.
+			 * If the page is stale, bit 3 is already set to 1
+			 * in the unmap path.
+			 */
+			if (pde->val & BIT_ULL(3)) {
+				put_page(pg);
+				continue;
+			}
+
+			/* Check if the value of this entry is changed. */
+			if (pde->val != path[level]) {
+				put_page(pg);
+
+				if (!dma_pte_present(pde))
+					/* This entry is invalid. Skip it. */
+					continue;
+
+				/* The entry has been updated. */
+				path[level] = pde->val;
+				goto retry;
+			}
+
+			pgtable_walk_level(m, phys_to_virt(pte_addr),
 					   level - 1, start, path);
+			put_page(pg);
+		}
 		path[level] = 0;
 	}
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b871a6afd803..6775b6bdfa3d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1103,6 +1103,22 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
 	pg = pfn_to_page(dma_pte_addr(pte) >> PAGE_SHIFT);
 	list_add_tail(&pg->lru, freelist);
 
+	/*
+	 * When the page pointed to by a PDPE/PDE is unlinked from its parent,
+	 * it's not freed immediately. It will be freed as soon as the IOTLB
+	 * is flushed. Before the page is freed, another process context (e.g.
+	 * debugfs) may still traverse it. But the content of the page is no
+	 * longer valid.
+	 * According the VT-d specification, bit 3 of the PDPE/PTE pointing to
+	 * a page directory/table is ignored by the hardware. The driver sets
+	 * it to 0 by default. To avoid the unnecessary page walks, set bit 3
+	 * to 1 to indicate that the page pointed to by the PDPE/PDE is stale.
+	 * Then in another process context, bit 3 of the PDPE/PDE is checked
+	 * before traversing the page pointed to by the PDPE/PDE. Traversal
+	 * stops if bit 3 is 1.
+	 */
+	pte->val |= BIT_ULL(3);
+
 	if (level == 1)
 		return;
 
-- 
2.21.3

