Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365CC7CC87B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjJQQNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbjJQQNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:13:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8826E9E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:13:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E32661007;
        Tue, 17 Oct 2023 09:13:56 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBAEF3F762;
        Tue, 17 Oct 2023 09:13:14 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 1/2] mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
Date:   Tue, 17 Oct 2023 17:13:01 +0100
Message-Id: <20231017161302.2518826-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017161302.2518826-1-ryan.roberts@arm.com>
References: <20231017161302.2518826-1-ryan.roberts@arm.com>
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

As preparation for supporting small-sized THP in the swap-out path,
without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
which, when present, always implies PMD-sized THP, which is the same as
the cluster size.

The only use of the flag was to determine whether a swap entry refers to
a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
Instead of relying on the flag, we now pass in nr_pages, which
originates from the folio's number of pages. This allows the logic to
work for folios of any order.

The one snag is that one of the swap_page_trans_huge_swapped() call
sites does not have the folio. But it was only being called there to
avoid bothering to call __try_to_reclaim_swap() in some cases.
__try_to_reclaim_swap() gets the folio and (via some other functions)
calls swap_page_trans_huge_swapped(). So I've removed the problematic
call site and believe the new logic should be equivalent.

Removing CLUSTER_FLAG_HUGE also means we can remove split_swap_cluster()
which used to be called during folio splitting, since
split_swap_cluster()'s only job was to remove the flag.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h | 10 ----------
 mm/huge_memory.c     |  3 ---
 mm/swapfile.c        | 47 ++++++++------------------------------------
 3 files changed, 8 insertions(+), 52 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 19f30a29e1f1..a073366a227c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -259,7 +259,6 @@ struct swap_cluster_info {
 };
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
 #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
-#define CLUSTER_FLAG_HUGE 4 /* This cluster is backing a transparent huge page */
 
 /*
  * We assign a cluster to each CPU, so each CPU can allocate swap entry from
@@ -595,15 +594,6 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 }
 #endif /* CONFIG_SWAP */
 
-#ifdef CONFIG_THP_SWAP
-extern int split_swap_cluster(swp_entry_t entry);
-#else
-static inline int split_swap_cluster(swp_entry_t entry)
-{
-	return 0;
-}
-#endif
-
 #ifdef CONFIG_MEMCG
 static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c9cbcbf6697e..46b3fb943207 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2597,9 +2597,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		shmem_uncharge(head->mapping->host, nr_dropped);
 	remap_page(folio, nr);
 
-	if (folio_test_swapcache(folio))
-		split_swap_cluster(folio->swap);
-
 	for (i = 0; i < nr; i++) {
 		struct page *subpage = head + i;
 		if (subpage == page)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e52f486834eb..b83ad77e04c0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -342,18 +342,6 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
 	info->data = 0;
 }
 
-static inline bool cluster_is_huge(struct swap_cluster_info *info)
-{
-	if (IS_ENABLED(CONFIG_THP_SWAP))
-		return info->flags & CLUSTER_FLAG_HUGE;
-	return false;
-}
-
-static inline void cluster_clear_huge(struct swap_cluster_info *info)
-{
-	info->flags &= ~CLUSTER_FLAG_HUGE;
-}
-
 static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
 						     unsigned long offset)
 {
@@ -1021,7 +1009,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
 	offset = idx * SWAPFILE_CLUSTER;
 	ci = lock_cluster(si, offset);
 	alloc_cluster(si, idx);
-	cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE);
+	cluster_set_count(ci, SWAPFILE_CLUSTER);
 
 	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
 	unlock_cluster(ci);
@@ -1354,7 +1342,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 
 	ci = lock_cluster_or_swap_info(si, offset);
 	if (size == SWAPFILE_CLUSTER) {
-		VM_BUG_ON(!cluster_is_huge(ci));
 		map = si->swap_map + offset;
 		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
 			val = map[i];
@@ -1362,7 +1349,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 			if (val == SWAP_HAS_CACHE)
 				free_entries++;
 		}
-		cluster_clear_huge(ci);
 		if (free_entries == SWAPFILE_CLUSTER) {
 			unlock_cluster_or_swap_info(si, ci);
 			spin_lock(&si->lock);
@@ -1384,23 +1370,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	unlock_cluster_or_swap_info(si, ci);
 }
 
-#ifdef CONFIG_THP_SWAP
-int split_swap_cluster(swp_entry_t entry)
-{
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	unsigned long offset = swp_offset(entry);
-
-	si = _swap_info_get(entry);
-	if (!si)
-		return -EBUSY;
-	ci = lock_cluster(si, offset);
-	cluster_clear_huge(ci);
-	unlock_cluster(ci);
-	return 0;
-}
-#endif
-
 static int swp_entry_cmp(const void *ent1, const void *ent2)
 {
 	const swp_entry_t *e1 = ent1, *e2 = ent2;
@@ -1508,22 +1477,23 @@ int swp_swapcount(swp_entry_t entry)
 }
 
 static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
-					 swp_entry_t entry)
+					 swp_entry_t entry,
+					 unsigned int nr_pages)
 {
 	struct swap_cluster_info *ci;
 	unsigned char *map = si->swap_map;
 	unsigned long roffset = swp_offset(entry);
-	unsigned long offset = round_down(roffset, SWAPFILE_CLUSTER);
+	unsigned long offset = round_down(roffset, nr_pages);
 	int i;
 	bool ret = false;
 
 	ci = lock_cluster_or_swap_info(si, offset);
-	if (!ci || !cluster_is_huge(ci)) {
+	if (!ci || nr_pages == 1) {
 		if (swap_count(map[roffset]))
 			ret = true;
 		goto unlock_out;
 	}
-	for (i = 0; i < SWAPFILE_CLUSTER; i++) {
+	for (i = 0; i < nr_pages; i++) {
 		if (swap_count(map[offset + i])) {
 			ret = true;
 			break;
@@ -1545,7 +1515,7 @@ static bool folio_swapped(struct folio *folio)
 	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(folio)))
 		return swap_swapcount(si, entry) != 0;
 
-	return swap_page_trans_huge_swapped(si, entry);
+	return swap_page_trans_huge_swapped(si, entry, folio_nr_pages(folio));
 }
 
 /**
@@ -1606,8 +1576,7 @@ int free_swap_and_cache(swp_entry_t entry)
 	p = _swap_info_get(entry);
 	if (p) {
 		count = __swap_entry_free(p, entry);
-		if (count == SWAP_HAS_CACHE &&
-		    !swap_page_trans_huge_swapped(p, entry))
+		if (count == SWAP_HAS_CACHE)
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
 	}
-- 
2.25.1

