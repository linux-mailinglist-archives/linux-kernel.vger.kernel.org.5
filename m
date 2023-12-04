Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232B98030F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343977AbjLDKzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjLDKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:54:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B0A6CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:55:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DD87169C;
        Mon,  4 Dec 2023 02:55:51 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A2433F6C4;
        Mon,  4 Dec 2023 02:55:00 -0800 (PST)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] mm: Batch-clear PTE ranges during zap_pte_range()
Date:   Mon,  4 Dec 2023 10:54:27 +0000
Message-Id: <20231204105440.61448-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204105440.61448-1-ryan.roberts@arm.com>
References: <20231204105440.61448-1-ryan.roberts@arm.com>
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

Convert zap_pte_range() to clear a set of ptes in a batch. A given batch
maps a physically contiguous block of memory, all belonging to the same
folio. This will likely improve performance by a tiny amount due to
removing duplicate calls to mark the folio dirty and accessed. And also
provides us with a future opportunity to batch the rmap removal.

However, the primary motivation for this change is to reduce the number
of tlb maintenance operations that the arm64 backend has to perform
during exit and other syscalls that cause zap_pte_range() (e.g. munmap,
madvise(DONTNEED), etc.), as it is about to add transparent support for
the "contiguous bit" in its ptes. By clearing ptes using the new
clear_ptes() API, the backend doesn't have to perform an expensive
unfold operation when a PTE being cleared is part of a contpte block.
Instead it can just clear the whole block immediately.

This change addresses the core-mm refactoring only, and introduces
clear_ptes() with a default implementation that calls
ptep_get_and_clear_full() for each pte in the range. Note that this API
returns the pte at the beginning of the batch, but with the dirty and
young bits set if ANY of the ptes in the cleared batch had those bits
set; this information is applied to the folio by the core-mm. Given the
batch is garranteed to cover only a single folio, collapsing this state
does not lose any useful information.

A separate change will implement clear_ptes() in the arm64 backend to
realize the performance improvement as part of the work to enable
contpte mappings.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/asm-generic/tlb.h |  9 ++++++
 include/linux/pgtable.h   | 26 ++++++++++++++++
 mm/memory.c               | 63 ++++++++++++++++++++++++++-------------
 mm/mmu_gather.c           | 14 +++++++++
 4 files changed, 92 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 129a3a759976..b84ba3aa1f6e 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -75,6 +75,9 @@
  *    boolean indicating if the queue is (now) full and a call to
  *    tlb_flush_mmu() is required.
  *
+ *    tlb_get_guaranteed_space() returns the minimum garanteed number of pages
+ *    that can be queued without overflow.
+ *
  *    tlb_remove_page() and tlb_remove_page_size() imply the call to
  *    tlb_flush_mmu() when required and has no return value.
  *
@@ -263,6 +266,7 @@ struct mmu_gather_batch {
 extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
 				   struct encoded_page *page,
 				   int page_size);
+extern unsigned int tlb_get_guaranteed_space(struct mmu_gather *tlb);
 
 #ifdef CONFIG_SMP
 /*
@@ -273,6 +277,11 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
 #endif
 
+#else
+static inline unsigned int tlb_get_guaranteed_space(struct mmu_gather *tlb)
+{
+	return 1;
+}
 #endif
 
 /*
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 1c50f8a0fdde..e998080eb7ae 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -635,6 +635,32 @@ static inline void ptep_set_wrprotects(struct mm_struct *mm,
 }
 #endif
 
+#ifndef clear_ptes
+struct mm_struct;
+static inline pte_t clear_ptes(struct mm_struct *mm,
+				unsigned long address, pte_t *ptep,
+				int full, unsigned int nr)
+{
+	unsigned int i;
+	pte_t pte;
+	pte_t orig_pte = ptep_get_and_clear_full(mm, address, ptep, full);
+
+	for (i = 1; i < nr; i++) {
+		address += PAGE_SIZE;
+		ptep++;
+		pte = ptep_get_and_clear_full(mm, address, ptep, full);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+#endif
+
 /*
  * On some architectures hardware does not set page access bit when accessing
  * memory page, it is responsibility of software setting this bit. It brings
diff --git a/mm/memory.c b/mm/memory.c
index 8a87a488950c..60f030700a3f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1515,6 +1515,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	pte_t *start_pte;
 	pte_t *pte;
 	swp_entry_t entry;
+	int nr;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	init_rss_vec(rss);
@@ -1527,6 +1528,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	do {
 		pte_t ptent = ptep_get(pte);
 		struct page *page;
+		int i;
+
+		nr = 1;
 
 		if (pte_none(ptent))
 			continue;
@@ -1535,45 +1539,64 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			unsigned int delay_rmap;
+			unsigned int delay_rmap = 0;
+			bool tlb_full = false;
+			struct folio *folio = NULL;
 
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
+
+			if (likely(page)) {
+				folio = page_folio(page);
+				nr = folio_nr_pages_cont_mapped(folio, page,
+							pte, addr, end,
+							ptent, true, &i, &i);
+				nr = min_t(int, nr, tlb_get_guaranteed_space(tlb));
+			}
+
+			ptent = clear_ptes(mm, addr, pte, tlb->fullmm, nr);
 			arch_check_zapped_pte(vma, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
-			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
-						      ptent);
+
+			for (i = 0; i < nr; i++) {
+				unsigned long subaddr = addr + PAGE_SIZE * i;
+
+				tlb_remove_tlb_entry(tlb, &pte[i], subaddr);
+				zap_install_uffd_wp_if_needed(vma, subaddr,
+						&pte[i], details, ptent);
+			}
 			if (unlikely(!page)) {
 				ksm_might_unmap_zero_page(mm, ptent);
 				continue;
 			}
 
-			delay_rmap = 0;
-			if (!PageAnon(page)) {
+			if (!folio_test_anon(folio)) {
 				if (pte_dirty(ptent)) {
-					set_page_dirty(page);
+					folio_mark_dirty(folio);
 					if (tlb_delay_rmap(tlb)) {
 						delay_rmap = 1;
 						force_flush = 1;
 					}
 				}
 				if (pte_young(ptent) && likely(vma_has_recency(vma)))
-					mark_page_accessed(page);
+					folio_mark_accessed(folio);
 			}
-			rss[mm_counter(page)]--;
-			if (!delay_rmap) {
-				page_remove_rmap(page, vma, false);
-				if (unlikely(page_mapcount(page) < 0))
-					print_bad_pte(vma, addr, ptent, page);
+			for (i = 0; i < nr; i++, page++) {
+				rss[mm_counter(page)]--;
+				if (!delay_rmap) {
+					page_remove_rmap(page, vma, false);
+					if (unlikely(page_mapcount(page) < 0))
+						print_bad_pte(vma, addr, ptent, page);
+				}
+				if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
+					tlb_full = true;
+					force_flush = 1;
+					addr += PAGE_SIZE * (i + 1);
+					break;
+				}
 			}
-			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
-				force_flush = 1;
-				addr += PAGE_SIZE;
+			if (unlikely(tlb_full))
 				break;
-			}
 			continue;
 		}
 
@@ -1624,7 +1647,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		}
 		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
 	add_mm_rss_vec(mm, rss);
 	arch_leave_lazy_mmu_mode();
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 4f559f4ddd21..57b4d5f0dfa4 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -47,6 +47,20 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	return true;
 }
 
+unsigned int tlb_get_guaranteed_space(struct mmu_gather *tlb)
+{
+	struct mmu_gather_batch *batch = tlb->active;
+	unsigned int nr_next = 0;
+
+	/* Allocate next batch so we can guarrantee at least one batch. */
+	if (tlb_next_batch(tlb)) {
+		tlb->active = batch;
+		nr_next = batch->next->max;
+	}
+
+	return batch->max - batch->nr + nr_next;
+}
+
 #ifdef CONFIG_SMP
 static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
 {
-- 
2.25.1

