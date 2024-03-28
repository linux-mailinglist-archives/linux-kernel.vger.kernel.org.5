Return-Path: <linux-kernel+bounces-99033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EFB8782A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CE51F23287
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5695446B6;
	Mon, 11 Mar 2024 15:01:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A924207A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169277; cv=none; b=XiWCIQg0vx9ddDtd2lx/AuIV28xZwjJAq5kzzwc2PVHM/zhR0V4JfINDBxYdUZHrLLQV87ec/7DRUrur+Uf0t6BslM1nDAK4xWi5kDBvkpuySFR7/9s7YZdF4+h6NRsvOr1Q6jQXycvW9+gmNx6xWtB5rUTRcFq6+5RjgYIWpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169277; c=relaxed/simple;
	bh=j2HnaCqMLVLCfioDy+uLP9z4rZAolIuaD1lgnBTyb+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VrgGWIlyOXe/H6x11rEFvFhbCIkqkY7Up4eANzsx06uXzyDABBajTwi188q2WwuFLInnqitWGOjZs59vn7bJwDafDJEos1aXIdVg/yhFMkIEHvfeikKWTnrZHAtO6D9ESs5mQBt0usoZ75jCaP7td+nUZfPvp+nNZLM29e+v7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF8AF153B;
	Mon, 11 Mar 2024 08:01:51 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B87953F64C;
	Mon, 11 Mar 2024 08:01:12 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
Date: Mon, 11 Mar 2024 15:00:54 +0000
Message-Id: <20240311150058.1122862-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311150058.1122862-1-ryan.roberts@arm.com>
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we no longer have a convenient flag in the cluster to determine
if a folio is large, free_swap_and_cache() will take a reference and
lock a large folio much more often, which could lead to contention and
(e.g.) failure to split large folios, etc.

Let's solve that problem by batch freeing swap and cache with a new
function, free_swap_and_cache_nr(), to free a contiguous range of swap
entries together. This allows us to first drop a reference to each swap
slot before we try to release the cache folio. This means we only try to
release the folio once, only taking the reference and lock once - much
better than the previous 512 times for the 2M THP case.

Contiguous swap entries are gathered in zap_pte_range() and
madvise_free_pte_range() in a similar way to how present ptes are
already gathered in zap_pte_range().

While we are at it, let's simplify by converting the return type of both
functions to void. The return value was used only by zap_pte_range() to
print a bad pte, and was ignored by everyone else, so the extra
reporting wasn't exactly guaranteed. We will still get the warning with
most of the information from get_swap_device(). With the batch version,
we wouldn't know which pte was bad anyway so could print the wrong one.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 28 +++++++++++++++
 include/linux/swap.h    | 12 +++++--
 mm/internal.h           | 48 +++++++++++++++++++++++++
 mm/madvise.c            | 12 ++++---
 mm/memory.c             | 13 +++----
 mm/swapfile.c           | 78 ++++++++++++++++++++++++++++++-----------
 6 files changed, 157 insertions(+), 34 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 85fc7554cd52..8cf1f2fe2c25 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -708,6 +708,34 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
 }
 #endif
 
+#ifndef clear_not_present_full_ptes
+/**
+ * clear_not_present_full_ptes - Clear consecutive not present PTEs.
+ * @mm: Address space the ptes represent.
+ * @addr: Address of the first pte.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to clear.
+ * @full: Whether we are clearing a full mm.
+ *
+ * May be overridden by the architecture; otherwise, implemented as a simple
+ * loop over pte_clear_not_present_full().
+ *
+ * Context: The caller holds the page table lock.  The PTEs are all not present.
+ * The PTEs are all in the same PMD.
+ */
+static inline void clear_not_present_full_ptes(struct mm_struct *mm,
+		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
+{
+	for (;;) {
+		pte_clear_not_present_full(mm, addr, ptep, full);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
 			      unsigned long address,
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4a8b6c60793a..f2b7f204b968 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -481,7 +481,7 @@ extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
 extern void swap_free(swp_entry_t);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
-extern int free_swap_and_cache(swp_entry_t);
+extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
@@ -530,8 +530,9 @@ static inline void put_swap_device(struct swap_info_struct *si)
 #define free_pages_and_swap_cache(pages, nr) \
 	release_pages((pages), (nr));
 
-/* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
-#define free_swap_and_cache(e) is_pfn_swap_entry(e)
+static inline void free_swap_and_cache_nr(swp_entry_t entry, int nr)
+{
+}
 
 static inline void free_swap_cache(struct folio *folio)
 {
@@ -599,6 +600,11 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 }
 #endif /* CONFIG_SWAP */
 
+static inline void free_swap_and_cache(swp_entry_t entry)
+{
+	free_swap_and_cache_nr(entry, 1);
+}
+
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 {
diff --git a/mm/internal.h b/mm/internal.h
index a3e19194079f..8dbb1335df88 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -11,6 +11,8 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/rmap.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 #include <linux/tracepoint-defs.h>
 
 struct folio_batch;
@@ -174,6 +176,52 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 
 	return min(ptep - start_ptep, max_nr);
 }
+
+/**
+ * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
+ * @start_ptep: Page table pointer for the first entry.
+ * @max_nr: The maximum number of table entries to consider.
+ * @entry: Swap entry recovered from the first table entry.
+ *
+ * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
+ * containing swap entries all with consecutive offsets and targeting the same
+ * swap type.
+ *
+ * max_nr must be at least one and must be limited by the caller so scanning
+ * cannot exceed a single page table.
+ *
+ * Return: the number of table entries in the batch.
+ */
+static inline int swap_pte_batch(pte_t *start_ptep, int max_nr,
+				 swp_entry_t entry)
+{
+	const pte_t *end_ptep = start_ptep + max_nr;
+	unsigned long expected_offset = swp_offset(entry) + 1;
+	unsigned int expected_type = swp_type(entry);
+	pte_t *ptep = start_ptep + 1;
+
+	VM_WARN_ON(max_nr < 1);
+	VM_WARN_ON(non_swap_entry(entry));
+
+	while (ptep < end_ptep) {
+		pte_t pte = ptep_get(ptep);
+
+		if (pte_none(pte) || pte_present(pte))
+			break;
+
+		entry = pte_to_swp_entry(pte);
+
+		if (non_swap_entry(entry) ||
+		    swp_type(entry) != expected_type ||
+		    swp_offset(entry) != expected_offset)
+			break;
+
+		expected_offset++;
+		ptep++;
+	}
+
+	return ptep - start_ptep;
+}
 #endif /* CONFIG_MMU */
 
 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
diff --git a/mm/madvise.c b/mm/madvise.c
index 44a498c94158..547dcd1f7a39 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -628,6 +628,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	struct folio *folio;
 	int nr_swap = 0;
 	unsigned long next;
+	int nr, max_nr;
 
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
@@ -640,7 +641,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
-	for (; addr != end; pte++, addr += PAGE_SIZE) {
+	for (; addr != end; pte += nr, addr += PAGE_SIZE * nr) {
+		nr = 1;
 		ptent = ptep_get(pte);
 
 		if (pte_none(ptent))
@@ -655,9 +657,11 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 
 			entry = pte_to_swp_entry(ptent);
 			if (!non_swap_entry(entry)) {
-				nr_swap--;
-				free_swap_and_cache(entry);
-				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+				max_nr = (end - addr) / PAGE_SIZE;
+				nr = swap_pte_batch(pte, max_nr, entry);
+				nr_swap -= nr;
+				free_swap_and_cache_nr(entry, nr);
+				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
 			} else if (is_hwpoison_entry(entry) ||
 				   is_poisoned_swp_entry(entry)) {
 				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
diff --git a/mm/memory.c b/mm/memory.c
index f2bc6dd15eb8..25c0ef1c7ff3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1629,12 +1629,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				folio_remove_rmap_pte(folio, page, vma);
 			folio_put(folio);
 		} else if (!non_swap_entry(entry)) {
-			/* Genuine swap entry, hence a private anon page */
+			max_nr = (end - addr) / PAGE_SIZE;
+			nr = swap_pte_batch(pte, max_nr, entry);
+			/* Genuine swap entries, hence a private anon pages */
 			if (!should_zap_cows(details))
 				continue;
-			rss[MM_SWAPENTS]--;
-			if (unlikely(!free_swap_and_cache(entry)))
-				print_bad_pte(vma, addr, ptent, NULL);
+			rss[MM_SWAPENTS] -= nr;
+			free_swap_and_cache_nr(entry, nr);
 		} else if (is_migration_entry(entry)) {
 			folio = pfn_swap_entry_folio(entry);
 			if (!should_zap_folio(details, folio))
@@ -1657,8 +1658,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
 			WARN_ON_ONCE(1);
 		}
-		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
-		zap_install_uffd_wp_if_needed(vma, addr, pte, 1, details, ptent);
+		clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
 	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
 
 	add_mm_rss_vec(mm, rss);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index df1de034f6d8..ee7e44cb40c5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -130,7 +130,11 @@ static inline unsigned char swap_count(unsigned char ent)
 /* Reclaim the swap entry if swap is getting full*/
 #define TTRS_FULL		0x4
 
-/* returns 1 if swap entry is freed */
+/*
+ * returns number of pages in the folio that backs the swap entry. If positive,
+ * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
+ * folio was associated with the swap entry.
+ */
 static int __try_to_reclaim_swap(struct swap_info_struct *si,
 				 unsigned long offset, unsigned long flags)
 {
@@ -155,6 +159,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 			ret = folio_free_swap(folio);
 		folio_unlock(folio);
 	}
+	ret = ret ? folio_nr_pages(folio) : -folio_nr_pages(folio);
 	folio_put(folio);
 	return ret;
 }
@@ -895,7 +900,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
 		spin_lock(&si->lock);
 		/* entry was freed successfully, try to use this again */
-		if (swap_was_freed)
+		if (swap_was_freed > 0)
 			goto checks;
 		goto scan; /* check next one */
 	}
@@ -1572,32 +1577,63 @@ bool folio_free_swap(struct folio *folio)
 	return true;
 }
 
-/*
- * Free the swap entry like above, but also try to
- * free the page cache entry if it is the last user.
- */
-int free_swap_and_cache(swp_entry_t entry)
+void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 {
-	struct swap_info_struct *p;
-	unsigned char count;
+	unsigned long end = swp_offset(entry) + nr;
+	unsigned int type = swp_type(entry);
+	struct swap_info_struct *si;
+	unsigned long offset;
 
 	if (non_swap_entry(entry))
-		return 1;
+		return;
 
-	p = get_swap_device(entry);
-	if (p) {
-		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
-			put_swap_device(p);
-			return 0;
-		}
+	si = get_swap_device(entry);
+	if (!si)
+		return;
 
-		count = __swap_entry_free(p, entry);
-		if (count == SWAP_HAS_CACHE)
-			__try_to_reclaim_swap(p, swp_offset(entry),
+	if (WARN_ON(end > si->max))
+		goto out;
+
+	/*
+	 * First free all entries in the range.
+	 */
+	for (offset = swp_offset(entry); offset < end; offset++) {
+		if (!WARN_ON(data_race(!si->swap_map[offset])))
+			__swap_entry_free(si, swp_entry(type, offset));
+	}
+
+	/*
+	 * Now go back over the range trying to reclaim the swap cache. This is
+	 * more efficient for large folios because we will only try to reclaim
+	 * the swap once per folio in the common case. If we do
+	 * __swap_entry_free() and __try_to_reclaim_swap() in the same loop, the
+	 * latter will get a reference and lock the folio for every individual
+	 * page but will only succeed once the swap slot for every subpage is
+	 * zero.
+	 */
+	for (offset = swp_offset(entry); offset < end; offset += nr) {
+		nr = 1;
+		if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
+			/*
+			 * Folios are always naturally aligned in swap so
+			 * advance forward to the next boundary. Zero means no
+			 * folio was found for the swap entry, so advance by 1
+			 * in this case. Negative value means folio was found
+			 * but could not be reclaimed. Here we can still advance
+			 * to the next boundary.
+			 */
+			nr = __try_to_reclaim_swap(si, offset,
 					      TTRS_UNMAPPED | TTRS_FULL);
-		put_swap_device(p);
+			if (nr == 0)
+				nr = 1;
+			else if (nr < 0)
+				nr = -nr;
+			nr = ALIGN(offset + 1, nr) - offset;
+		}
 	}
-	return p != NULL;
+
+out:
+	put_swap_device(si);
 }
 
 #ifdef CONFIG_HIBERNATION
-- 
2.25.1


