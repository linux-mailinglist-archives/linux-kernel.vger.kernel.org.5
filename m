Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE7377B856
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjHNMLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjHNMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:11:06 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8111732
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:10:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jijie.ji@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Vpmucqn_1692015031;
Received: from localhost.localdomain(mailfrom:jijie.ji@linux.alibaba.com fp:SMTPD_---0Vpmucqn_1692015031)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 20:10:35 +0800
From:   Jie Ji <jijie.ji@linux.alibaba.com>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        xianting.tian@linux.alibaba.com, kaijieguo@linux.alibaba.com,
        daishengdong@yeah.net, Jie Ji <jijie.ji@linux.alibaba.com>
Subject: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer granularity
Date:   Mon, 14 Aug 2023 20:10:16 +0800
Message-Id: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of IOMMU support for IO page fault, it's now possible
to unpin the memory which DMA remapping. However, the lack of support
for unmapping a subrange of the I/O page table (IOPT) in IOMMU can lead
to some issues.

For instance, a virtual machine can establish IOPT of 2M/1G for better
performance, while the host system enable swap and attempts to swap out
some 4K pages. Unfortunately, unmap subrange of the large-page mapping
will make IOMMU page walk to error level, and finally cause kernel crash.

This patch support splitting the page table to a finer granularity and
atomic switch to it when unmap subrange of the large-page mapping. It
is much better than the unmap then map method to change IOPT, because
during interval time, all unmapped address space could trigger IO page
fault, which is unacceptable.

Signed-off-by: Jie Ji <jijie.ji@linux.alibaba.com>
Reviewed-by: Kaijie Guo <kaijieguo@linux.alibaba.com>
---
 drivers/iommu/intel/iommu.c | 97 +++++++++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h |  1 +
 2 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5c8c5cdc36cf..b1fe9d07c47b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1114,12 +1114,59 @@ static void dma_pte_list_pagetables(struct dmar_domain *domain,
 	} while (!first_pte_in_page(pte));
 }
 
-static void dma_pte_clear_level(struct dmar_domain *domain, int level,
-				struct dma_pte *pte, unsigned long pfn,
-				unsigned long start_pfn, unsigned long last_pfn,
-				struct list_head *freelist)
+static int switch_to_small_page(struct dmar_domain *domain, int level,
+				struct dma_pte *pte)
+{
+	u64 pteval, old_pteval, pfn;
+	void *new_pte = NULL;
+	u64 *ptep = NULL;
+	u64 attr;
+	int idx = 0;
+
+	/* Inherit attr from old pte */
+	attr = pte->val & VTD_ATTR_MASK;
+	if (level == 1)
+		attr &= ~DMA_PTE_LARGE_PAGE;
+
+	/* Get old pte entry in case pte change during switch */
+	old_pteval = pte->val;
+	pfn = dma_pte_addr(pte) >> VTD_PAGE_SHIFT;
+
+	new_pte = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
+	if (unlikely(!new_pte))
+		return -ENOMEM;
+
+	ptep = (u64 *)new_pte;
+	for (idx = 0; idx < (1 << LEVEL_STRIDE); idx++) {
+		pteval = (pfn & level_mask(level)) << VTD_PAGE_SHIFT | attr;
+		ptep[idx] = pteval;
+		pfn += level_size(level);
+	}
+
+	pteval = ((unsigned long)virt_to_dma_pfn(new_pte) << VTD_PAGE_SHIFT);
+	/* Snoop bit in page directory entry should be zero (reserve field) */
+	pteval |= DMA_PTE_WRITE | DMA_PTE_READ;
+
+	if (cmpxchg64(&pte->val, old_pteval, pteval) != old_pteval) {
+		pr_err("%s: original pte changed by others, switch fail\n", __func__);
+		free_pgtable_page(new_pte);
+		return -EBUSY;
+	}
+
+	domain_flush_cache(domain, pte, sizeof(*pte));
+
+	pr_debug("%s: pte: %#llx->%#llx\n", __func__, old_pteval, pte->val);
+
+	return 0;
+}
+
+static int dma_pte_clear_level(struct dmar_domain *domain, int level,
+			       struct dma_pte *pte, unsigned long pfn,
+			       unsigned long start_pfn, unsigned long last_pfn,
+			       struct list_head *freelist)
 {
 	struct dma_pte *first_pte = NULL, *last_pte = NULL;
+	int ret;
 
 	pfn = max(start_pfn, pfn);
 	pte = &pte[pfn_level_offset(pfn, level)];
@@ -1143,6 +1190,17 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 				first_pte = pte;
 			last_pte = pte;
 		} else if (level > 1) {
+			/* Switch to small page when unmap subrange */
+			if (dma_pte_superpage(pte) &&
+			    ((last_pfn - start_pfn + 1) < level_size(level))) {
+				ret = switch_to_small_page(domain, level - 1, pte);
+				if (ret) {
+					pr_err("%s: switch to smaller page fail, ret = %d",
+						__func__, ret);
+					return ret;
+				}
+			}
+
 			/* Recurse down into a level that isn't *entirely* obsolete */
 			dma_pte_clear_level(domain, level - 1,
 					    phys_to_virt(dma_pte_addr(pte)),
@@ -1156,21 +1214,27 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
 	if (first_pte)
 		domain_flush_cache(domain, first_pte,
 				   (void *)++last_pte - (void *)first_pte);
+
+	return 0;
 }
 
 /* We can't just free the pages because the IOMMU may still be walking
    the page tables, and may have cached the intermediate levels. The
    pages can only be freed after the IOTLB flush has been done. */
-static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
-			 unsigned long last_pfn, struct list_head *freelist)
+static int domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
+			unsigned long last_pfn, struct list_head *freelist)
 {
+	int ret;
+
 	if (WARN_ON(!domain_pfn_supported(domain, last_pfn)) ||
 	    WARN_ON(start_pfn > last_pfn))
-		return;
+		return -EINVAL;
 
 	/* we don't need lock here; nobody else touches the iova range */
-	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
-			    domain->pgd, 0, start_pfn, last_pfn, freelist);
+	ret = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
+				  domain->pgd, 0, start_pfn, last_pfn, freelist);
+	if (ret)
+		return ret;
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
@@ -1178,6 +1242,8 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 		list_add_tail(&pgd_page->lru, freelist);
 		domain->pgd = NULL;
 	}
+
+	return 0;
 }
 
 /* iommu handling */
@@ -4219,21 +4285,12 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long start_pfn, last_pfn;
-	int level = 0;
-
-	/* Cope with horrid API which requires us to unmap more than the
-	   size argument if it happens to be a large-page mapping. */
-	if (unlikely(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT,
-				     &level, GFP_ATOMIC)))
-		return 0;
-
-	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
-		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
 
 	start_pfn = iova >> VTD_PAGE_SHIFT;
 	last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
 
-	domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist);
+	if (domain_unmap(dmar_domain, start_pfn, last_pfn, &gather->freelist))
+		return 0;
 
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1c5e1d88862b..b4ccf134735f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -33,6 +33,7 @@
 #define VTD_PAGE_SIZE		(1UL << VTD_PAGE_SHIFT)
 #define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
 #define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
+#define VTD_ATTR_MASK		(~VTD_PAGE_MASK)
 
 #define VTD_STRIDE_SHIFT        (9)
 #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
-- 
2.32.0.3.g01195cf9f

