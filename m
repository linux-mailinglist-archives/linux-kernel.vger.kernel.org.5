Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07977775E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjHJKd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjHJKdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:33:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF87110DE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:33:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1237C11FB;
        Thu, 10 Aug 2023 03:34:34 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EA363F6C4;
        Thu, 10 Aug 2023 03:33:48 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] mm/mmu_gather: generalize mmu_gather rmap removal mechanism
Date:   Thu, 10 Aug 2023 11:33:30 +0100
Message-Id: <20230810103332.3062143-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810103332.3062143-1-ryan.roberts@arm.com>
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5df397dec7c4 ("mm: delay page_remove_rmap() until after the TLB
has been flushed") added a mechanism whereby pages added to the
mmu_gather buffer could indicate whether they should also be removed
from the rmap. Then a call to the new tlb_flush_rmaps() API would
iterate though the buffer and remove each flagged page from the rmap.
This mechanism was intended for use with !PageAnon(page) pages only.

Let's generalize this rmap removal mechanism so that any type of page
can be removed from the rmap. This is done as preparation for batching
rmap removals with folio_remove_rmap_range(), whereby we will pass a
contiguous range of pages belonging to the same folio to be removed in
one shot for a performance improvement.

The mmu_gather now maintains a "pointer" that points to batch and index
within that batch of the next page in the queue that is yet to be
removed from the rmap. tlb_discard_rmaps() resets this "pointer" to the
first empty location in the queue. Whenever tlb_flush_rmaps() is called,
every page from "pointer" to the end of the queue is removed from the
rmap. Once the mmu is flushed (tlb_flush_mmu()/tlb_finish_mmu()) any
pending rmap removals are discarded. This pointer mechanism ensures that
tlb_flush_rmaps() only has to walk the part of the queue for which rmap
removal is pending, avoids the (potentially large) early portion of the
queue for which rmap removal has already been performed but for which
tlb invalidation/page freeing is still pending.

tlb_flush_rmaps() must always be called under the same PTL as was used
to clear the corresponding PTEs. So in practice rmap removal will be
done in a batch for each PTE table, while the tlbi/freeing can continue
to be done in much bigger batches outside the PTL. See this example
flow:

tlb_gather_mmu()
	for each pte table {
		with ptl held {
			for each pte {
				tlb_remove_tlb_entry()
				__tlb_remove_page()
			}

			if (any removed pages require rmap after tlbi)
				tlb_flush_mmu_tlbonly()

			tlb_flush_rmaps()
		}

		if (full)
			tlb_flush_mmu()
	}
tlb_finish_mmu()

So this more general mechanism is no longer just for delaying rmap
removal until after tlbi, but can be used that way when required.

Note that s390 does not gather pages, but does immediate tlbi and page
freeing. In this case we continue to do the rmap removal page-by-page
without gathering them in the mmu_gather.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/asm-generic/tlb.h | 34 ++++++++++++------------
 mm/memory.c               | 24 ++++++++++-------
 mm/mmu_gather.c           | 55 +++++++++++++++++++++++----------------
 3 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 129a3a759976..f339d68cf44f 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -266,25 +266,30 @@ extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
 
 #ifdef CONFIG_SMP
 /*
- * This both sets 'delayed_rmap', and returns true. It would be an inline
- * function, except we define it before the 'struct mmu_gather'.
+ * For configurations that support batching the rmap removal, the removal is
+ * triggered by calling tlb_flush_rmaps(), which must be called after the pte(s)
+ * are cleared and the page has been added to the mmu_gather, and before the ptl
+ * lock that was held for clearing the pte is released.
  */
-#define tlb_delay_rmap(tlb) (((tlb)->delayed_rmap = 1), true)
+#define tlb_batch_rmap(tlb) (true)
 extern void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma);
+extern void tlb_discard_rmaps(struct mmu_gather *tlb);
 #endif
 
 #endif
 
 /*
- * We have a no-op version of the rmap removal that doesn't
- * delay anything. That is used on S390, which flushes remote
- * TLBs synchronously, and on UP, which doesn't have any
- * remote TLBs to flush and is not preemptible due to this
- * all happening under the page table lock.
+ * We have a no-op version of the rmap removal that doesn't do anything. That is
+ * used on S390, which flushes remote TLBs synchronously, and on UP, which
+ * doesn't have any remote TLBs to flush and is not preemptible due to this all
+ * happening under the page table lock. Here, the caller must manage each rmap
+ * removal separately.
  */
-#ifndef tlb_delay_rmap
-#define tlb_delay_rmap(tlb) (false)
-static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+#ifndef tlb_batch_rmap
+#define tlb_batch_rmap(tlb) (false)
+static inline void tlb_flush_rmaps(struct mmu_gather *tlb,
+				   struct vm_area_struct *vma) { }
+static inline void tlb_discard_rmaps(struct mmu_gather *tlb) { }
 #endif
 
 /*
@@ -317,11 +322,6 @@ struct mmu_gather {
 	 */
 	unsigned int		freed_tables : 1;
 
-	/*
-	 * Do we have pending delayed rmap removals?
-	 */
-	unsigned int		delayed_rmap : 1;
-
 	/*
 	 * at which levels have we cleared entries?
 	 */
@@ -343,6 +343,8 @@ struct mmu_gather {
 	struct mmu_gather_batch *active;
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
+	struct mmu_gather_batch *rmap_pend;
+	unsigned int		rmap_pend_first;
 
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
diff --git a/mm/memory.c b/mm/memory.c
index d003076b218d..94a6ebd409a6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1405,6 +1405,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	swp_entry_t entry;
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
+	tlb_discard_rmaps(tlb);
 	init_rss_vec(rss);
 	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	if (!pte)
@@ -1423,7 +1424,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			unsigned int delay_rmap;
+			unsigned int batch_rmap;
 
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
@@ -1438,12 +1439,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			}
 
-			delay_rmap = 0;
+			batch_rmap = tlb_batch_rmap(tlb);
 			if (!PageAnon(page)) {
 				if (pte_dirty(ptent)) {
 					set_page_dirty(page);
-					if (tlb_delay_rmap(tlb)) {
-						delay_rmap = 1;
+					if (batch_rmap) {
+						/*
+						 * Ensure tlb flush happens
+						 * before rmap remove.
+						 */
 						force_flush = 1;
 					}
 				}
@@ -1451,12 +1455,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
-			if (!delay_rmap) {
+			if (!batch_rmap) {
 				page_remove_rmap(page, vma, false);
 				if (unlikely(page_mapcount(page) < 0))
 					print_bad_pte(vma, addr, ptent, page);
 			}
-			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
+			if (unlikely(__tlb_remove_page(tlb, page, 0))) {
 				force_flush = 1;
 				addr += PAGE_SIZE;
 				break;
@@ -1517,10 +1521,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	arch_leave_lazy_mmu_mode();
 
 	/* Do the actual TLB flush before dropping ptl */
-	if (force_flush) {
+	if (force_flush)
 		tlb_flush_mmu_tlbonly(tlb);
-		tlb_flush_rmaps(tlb, vma);
-	}
+
+	/* Rmap removal must always happen before dropping ptl */
+	tlb_flush_rmaps(tlb, vma);
+
 	pte_unmap_unlock(start_pte, ptl);
 
 	/*
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index ea9683e12936..ca328ecef5c2 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -19,10 +19,6 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
 
-	/* Limit batching if we have delayed rmaps pending */
-	if (tlb->delayed_rmap && tlb->active != &tlb->local)
-		return false;
-
 	batch = tlb->active;
 	if (batch->next) {
 		tlb->active = batch->next;
@@ -48,36 +44,49 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 }
 
 #ifdef CONFIG_SMP
-static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
+static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch,
+				 unsigned int first,
+				 struct vm_area_struct *vma)
 {
-	for (int i = 0; i < batch->nr; i++) {
+	for (int i = first; i < batch->nr; i++) {
 		struct encoded_page *enc = batch->encoded_pages[i];
+		struct page *page = encoded_page_ptr(enc);
 
-		if (encoded_page_flags(enc)) {
-			struct page *page = encoded_page_ptr(enc);
-			page_remove_rmap(page, vma, false);
-		}
+		page_remove_rmap(page, vma, false);
 	}
 }
 
 /**
- * tlb_flush_rmaps - do pending rmap removals after we have flushed the TLB
+ * tlb_flush_rmaps - do pending rmap removals
  * @tlb: the current mmu_gather
+ * @vma: vm area from which all pages are removed
  *
- * Note that because of how tlb_next_batch() above works, we will
- * never start multiple new batches with pending delayed rmaps, so
- * we only need to walk through the current active batch and the
- * original local one.
+ * Removes rmap from all pages added via (e.g.) __tlb_remove_page_size() since
+ * the last call to tlb_discard_rmaps() or tlb_flush_rmaps(). All of those pages
+ * must have been mapped by vma. Must be called after the pte(s) are cleared,
+ * and before the ptl lock that was held for clearing the pte is released. Pages
+ * are accounted using the order-0 folio (or base page) scheme.
  */
 void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
 {
-	if (!tlb->delayed_rmap)
-		return;
+	struct mmu_gather_batch *batch = tlb->rmap_pend;
 
-	tlb_flush_rmap_batch(&tlb->local, vma);
-	if (tlb->active != &tlb->local)
-		tlb_flush_rmap_batch(tlb->active, vma);
-	tlb->delayed_rmap = 0;
+	tlb_flush_rmap_batch(batch, tlb->rmap_pend_first, vma);
+
+	for (batch = batch->next; batch && batch->nr; batch = batch->next)
+		tlb_flush_rmap_batch(batch, 0, vma);
+
+	tlb_discard_rmaps(tlb);
+}
+
+/**
+ * tlb_discard_rmaps - discard any pending rmap removals
+ * @tlb: the current mmu_gather
+ */
+void tlb_discard_rmaps(struct mmu_gather *tlb)
+{
+	tlb->rmap_pend = tlb->active;
+	tlb->rmap_pend_first = tlb->active->nr;
 }
 #endif
 
@@ -102,6 +111,7 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 		} while (batch->nr);
 	}
 	tlb->active = &tlb->local;
+	tlb_discard_rmaps(tlb);
 }
 
 static void tlb_batch_list_free(struct mmu_gather *tlb)
@@ -312,8 +322,9 @@ static void __tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 	tlb->local.max  = ARRAY_SIZE(tlb->__pages);
 	tlb->active     = &tlb->local;
 	tlb->batch_count = 0;
+	tlb->rmap_pend	= &tlb->local;
+	tlb->rmap_pend_first = 0;
 #endif
-	tlb->delayed_rmap = 0;
 
 	tlb_table_init(tlb);
 #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
-- 
2.25.1

