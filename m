Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE88A759777
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGSNzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjGSNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:55:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13A551998
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:55:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A0532F4;
        Wed, 19 Jul 2023 06:55:58 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DE203F6C4;
        Wed, 19 Jul 2023 06:55:08 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 3/3] mm: Batch-zap large anonymous folio PTE mappings
Date:   Wed, 19 Jul 2023 14:54:50 +0100
Message-Id: <20230719135450.545227-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230719135450.545227-1-ryan.roberts@arm.com>
References: <20230719135450.545227-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows batching the rmap removal with folio_remove_rmap_range(),
which means we avoid spuriously adding a partially unmapped folio to the
deferred split queue in the common case, which reduces split queue lock
contention.

Previously each page was removed from the rmap individually with
page_remove_rmap(). If the first page belonged to a large folio, this
would cause page_remove_rmap() to conclude that the folio was now
partially mapped and add the folio to the deferred split queue. But
subsequent calls would cause the folio to become fully unmapped, meaning
there is no value to adding it to the split queue.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/memory.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 01f39e8144ef..189b1cfd823d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1391,6 +1391,94 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
 }
 
+static inline unsigned long page_cont_mapped_vaddr(struct page *page,
+				struct page *anchor, unsigned long anchor_vaddr)
+{
+	unsigned long offset;
+	unsigned long vaddr;
+
+	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
+	vaddr = anchor_vaddr + offset;
+
+	if (anchor > page) {
+		if (vaddr > anchor_vaddr)
+			return 0;
+	} else {
+		if (vaddr < anchor_vaddr)
+			return ULONG_MAX;
+	}
+
+	return vaddr;
+}
+
+static int folio_nr_pages_cont_mapped(struct folio *folio,
+				      struct page *page, pte_t *pte,
+				      unsigned long addr, unsigned long end)
+{
+	pte_t ptent;
+	int floops;
+	int i;
+	unsigned long pfn;
+	struct page *folio_end;
+
+	if (!folio_test_large(folio))
+		return 1;
+
+	folio_end = &folio->page + folio_nr_pages(folio);
+	end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
+	floops = (end - addr) >> PAGE_SHIFT;
+	pfn = page_to_pfn(page);
+	pfn++;
+	pte++;
+
+	for (i = 1; i < floops; i++) {
+		ptent = ptep_get(pte);
+
+		if (!pte_present(ptent) || pte_pfn(ptent) != pfn)
+			break;
+
+		pfn++;
+		pte++;
+	}
+
+	return i;
+}
+
+static unsigned long try_zap_anon_pte_range(struct mmu_gather *tlb,
+					    struct vm_area_struct *vma,
+					    struct folio *folio,
+					    struct page *page, pte_t *pte,
+					    unsigned long addr, int nr_pages,
+					    struct zap_details *details)
+{
+	struct mm_struct *mm = tlb->mm;
+	pte_t ptent;
+	bool full;
+	int i;
+
+	for (i = 0; i < nr_pages;) {
+		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+		tlb_remove_tlb_entry(tlb, pte, addr);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+		full = __tlb_remove_page(tlb, page, 0);
+
+		if (unlikely(page_mapcount(page) < 1))
+			print_bad_pte(vma, addr, ptent, page);
+
+		i++;
+		page++;
+		pte++;
+		addr += PAGE_SIZE;
+
+		if (unlikely(full))
+			break;
+	}
+
+	folio_remove_rmap_range(folio, page - i, i, vma);
+
+	return i;
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
@@ -1428,6 +1516,38 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
+
+			/*
+			 * Batch zap large anonymous folio mappings. This allows
+			 * batching the rmap removal, which means we avoid
+			 * spuriously adding a partially unmapped folio to the
+			 * deferrred split queue in the common case, which
+			 * reduces split queue lock contention.
+			 */
+			if (page && PageAnon(page)) {
+				struct folio *folio = page_folio(page);
+				int nr_pages_req, nr_pages;
+
+				nr_pages_req = folio_nr_pages_cont_mapped(
+						folio, page, pte, addr, end);
+
+				nr_pages = try_zap_anon_pte_range(tlb, vma,
+						folio, page, pte, addr,
+						nr_pages_req, details);
+
+				rss[mm_counter(page)] -= nr_pages;
+				nr_pages--;
+				pte += nr_pages;
+				addr += nr_pages << PAGE_SHIFT;
+
+				if (unlikely(nr_pages < nr_pages_req)) {
+					force_flush = 1;
+					addr += PAGE_SIZE;
+					break;
+				}
+				continue;
+			}
+
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
-- 
2.25.1

