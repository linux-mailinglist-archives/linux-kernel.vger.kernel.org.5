Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9C7775E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjHJKeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjHJKd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:33:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6194211C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:33:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBA19139F;
        Thu, 10 Aug 2023 03:34:36 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0251A3F6C4;
        Thu, 10 Aug 2023 03:33:51 -0700 (PDT)
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
Subject: [PATCH v1 3/4] mm/mmu_gather: Remove encoded_page infrastructure
Date:   Thu, 10 Aug 2023 11:33:31 +0100
Message-Id: <20230810103332.3062143-4-ryan.roberts@arm.com>
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

commit 70fb4fdff582 ("mm: introduce 'encoded' page pointers with
embedded extra bits") and commit 7cc8f9c7146a ("mm: mmu_gather: prepare
to gather encoded page pointers with flags") converted mmu_gather for
dealing with encoded_page, where the bottom 2 bits could encode extra
flags. Only 1 bit was ever used; to flag whether the page should
participate in a delayed rmap removal.

Now that the mmu_gather batched rmap removal mechanism has been
generalized, all pages participate and therefore the flag is unused. So
let's remove encoded_page to simplify the code. It also gets in the way
of further optimization which will be done in a follow up patch.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/s390/include/asm/tlb.h |  9 +++------
 include/asm-generic/tlb.h   | 10 +++++-----
 include/linux/mm.h          |  4 +---
 include/linux/mm_types.h    | 34 +---------------------------------
 include/linux/swap.h        |  2 +-
 mm/memory.c                 |  2 +-
 mm/mmu_gather.c             | 11 +++++------
 mm/swap.c                   |  8 +++-----
 mm/swap_state.c             |  4 ++--
 9 files changed, 22 insertions(+), 62 deletions(-)

diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 383b1f91442c..c40b44f6a31b 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -25,7 +25,7 @@
 void __tlb_remove_table(void *_table);
 static inline void tlb_flush(struct mmu_gather *tlb);
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct encoded_page *page,
+					  struct page *page,
 					  int page_size);
 
 #define tlb_flush tlb_flush
@@ -41,15 +41,12 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
  * Release the page cache reference for a pte removed by
  * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
  * has already been freed, so just do free_page_and_swap_cache.
- *
- * s390 doesn't delay rmap removal, so there is nothing encoded in
- * the page pointer.
  */
 static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct encoded_page *page,
+					  struct page *page,
 					  int page_size)
 {
-	free_page_and_swap_cache(encoded_page_ptr(page));
+	free_page_and_swap_cache(page);
 	return false;
 }
 
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index f339d68cf44f..d874415aaa33 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -246,7 +246,7 @@ struct mmu_gather_batch {
 	struct mmu_gather_batch	*next;
 	unsigned int		nr;
 	unsigned int		max;
-	struct encoded_page	*encoded_pages[];
+	struct page		*pages[];
 };
 
 #define MAX_GATHER_BATCH	\
@@ -261,7 +261,7 @@ struct mmu_gather_batch {
 #define MAX_GATHER_BATCH_COUNT	(10000UL/MAX_GATHER_BATCH)
 
 extern bool __tlb_remove_page_size(struct mmu_gather *tlb,
-				   struct encoded_page *page,
+				   struct page *page,
 				   int page_size);
 
 #ifdef CONFIG_SMP
@@ -464,13 +464,13 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
 					struct page *page, int page_size)
 {
-	if (__tlb_remove_page_size(tlb, encode_page(page, 0), page_size))
+	if (__tlb_remove_page_size(tlb, page, page_size))
 		tlb_flush_mmu(tlb);
 }
 
-static __always_inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page, unsigned int flags)
+static __always_inline bool __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 {
-	return __tlb_remove_page_size(tlb, encode_page(page, flags), PAGE_SIZE);
+	return __tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
 /* tlb_remove_page
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6a95dfed4957..914e08185272 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1518,8 +1518,7 @@ static inline void folio_put_refs(struct folio *folio, int refs)
  *
  * release_pages() releases a simple array of multiple pages, and
  * accepts various different forms of said page array: either
- * a regular old boring array of pages, an array of folios, or
- * an array of encoded page pointers.
+ * a regular old boring array of pages or an array of folios.
  *
  * The transparent union syntax for this kind of "any of these
  * argument types" is all kinds of ugly, so look away.
@@ -1527,7 +1526,6 @@ static inline void folio_put_refs(struct folio *folio, int refs)
 typedef union {
 	struct page **pages;
 	struct folio **folios;
-	struct encoded_page **encoded_pages;
 } release_pages_arg __attribute__ ((__transparent_union__));
 
 void release_pages(release_pages_arg, int nr);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 291c05cacd48..b2cf57f9134c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -68,7 +68,7 @@ struct mem_cgroup;
 #ifdef CONFIG_HAVE_ALIGNED_STRUCT_PAGE
 #define _struct_page_alignment	__aligned(2 * sizeof(unsigned long))
 #else
-#define _struct_page_alignment	__aligned(sizeof(unsigned long))
+#define _struct_page_alignment
 #endif
 
 struct page {
@@ -216,38 +216,6 @@ struct page {
 #endif
 } _struct_page_alignment;
 
-/*
- * struct encoded_page - a nonexistent type marking this pointer
- *
- * An 'encoded_page' pointer is a pointer to a regular 'struct page', but
- * with the low bits of the pointer indicating extra context-dependent
- * information. Not super-common, but happens in mmu_gather and mlock
- * handling, and this acts as a type system check on that use.
- *
- * We only really have two guaranteed bits in general, although you could
- * play with 'struct page' alignment (see CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
- * for more.
- *
- * Use the supplied helper functions to endcode/decode the pointer and bits.
- */
-struct encoded_page;
-#define ENCODE_PAGE_BITS 3ul
-static __always_inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
-{
-	BUILD_BUG_ON(flags > ENCODE_PAGE_BITS);
-	return (struct encoded_page *)(flags | (unsigned long)page);
-}
-
-static inline unsigned long encoded_page_flags(struct encoded_page *page)
-{
-	return ENCODE_PAGE_BITS & (unsigned long)page;
-}
-
-static inline struct page *encoded_page_ptr(struct encoded_page *page)
-{
-	return (struct page *)(~ENCODE_PAGE_BITS & (unsigned long)page);
-}
-
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index bb5adc604144..f199df803b33 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -453,7 +453,7 @@ static inline unsigned long total_swapcache_pages(void)
 
 extern void free_swap_cache(struct page *page);
 extern void free_page_and_swap_cache(struct page *);
-extern void free_pages_and_swap_cache(struct encoded_page **, int);
+extern void free_pages_and_swap_cache(struct page **, int);
 /* linux/mm/swapfile.c */
 extern atomic_long_t nr_swap_pages;
 extern long total_swap_pages;
diff --git a/mm/memory.c b/mm/memory.c
index 94a6ebd409a6..b4f757171cf9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1460,7 +1460,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				if (unlikely(page_mapcount(page) < 0))
 					print_bad_pte(vma, addr, ptent, page);
 			}
-			if (unlikely(__tlb_remove_page(tlb, page, 0))) {
+			if (unlikely(__tlb_remove_page(tlb, page))) {
 				force_flush = 1;
 				addr += PAGE_SIZE;
 				break;
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index ca328ecef5c2..5d100ac85e21 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -49,8 +49,7 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch,
 				 struct vm_area_struct *vma)
 {
 	for (int i = first; i < batch->nr; i++) {
-		struct encoded_page *enc = batch->encoded_pages[i];
-		struct page *page = encoded_page_ptr(enc);
+		struct page *page = batch->pages[i];
 
 		page_remove_rmap(page, vma, false);
 	}
@@ -95,7 +94,7 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	struct mmu_gather_batch *batch;
 
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		struct encoded_page **pages = batch->encoded_pages;
+		struct page **pages = batch->pages;
 
 		do {
 			/*
@@ -125,7 +124,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 	tlb->local.next = NULL;
 }
 
-bool __tlb_remove_page_size(struct mmu_gather *tlb, struct encoded_page *page, int page_size)
+bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_size)
 {
 	struct mmu_gather_batch *batch;
 
@@ -140,13 +139,13 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct encoded_page *page, i
 	 * Add the page and check if we are full. If so
 	 * force a flush.
 	 */
-	batch->encoded_pages[batch->nr++] = page;
+	batch->pages[batch->nr++] = page;
 	if (batch->nr == batch->max) {
 		if (!tlb_next_batch(tlb))
 			return true;
 		batch = tlb->active;
 	}
-	VM_BUG_ON_PAGE(batch->nr > batch->max, encoded_page_ptr(page));
+	VM_BUG_ON_PAGE(batch->nr > batch->max, page);
 
 	return false;
 }
diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..b05cce475202 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -953,14 +953,12 @@ void lru_cache_disable(void)
  * Decrement the reference count on all the pages in @arg.  If it
  * fell to zero, remove the page from the LRU and free it.
  *
- * Note that the argument can be an array of pages, encoded pages,
- * or folio pointers. We ignore any encoded bits, and turn any of
- * them into just a folio that gets free'd.
+ * Note that the argument can be an array of pages or folio pointers.
  */
 void release_pages(release_pages_arg arg, int nr)
 {
 	int i;
-	struct encoded_page **encoded = arg.encoded_pages;
+	struct page **pages = arg.pages;
 	LIST_HEAD(pages_to_free);
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
@@ -970,7 +968,7 @@ void release_pages(release_pages_arg arg, int nr)
 		struct folio *folio;
 
 		/* Turn any of the argument types into a folio */
-		folio = page_folio(encoded_page_ptr(encoded[i]));
+		folio = page_folio(pages[i]);
 
 		/*
 		 * Make sure the IRQ-safe lock-holding time does not get
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 01f15139b7d9..73b16795b0ff 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -307,11 +307,11 @@ void free_page_and_swap_cache(struct page *page)
  * Passed an array of pages, drop them all from swapcache and then release
  * them.  They are removed from the LRU and freed if this is their last use.
  */
-void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
+void free_pages_and_swap_cache(struct page **pages, int nr)
 {
 	lru_add_drain();
 	for (int i = 0; i < nr; i++)
-		free_swap_cache(encoded_page_ptr(pages[i]));
+		free_swap_cache(pages[i]);
 	release_pages(pages, nr);
 }
 
-- 
2.25.1

