Return-Path: <linux-kernel+bounces-99031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C987829F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BFE1C22BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00BC42079;
	Mon, 11 Mar 2024 15:01:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083C3F8C3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169275; cv=none; b=G5DWN0BKuKOj4rNaKS38rd48cwIofFrbCO/NA3B2I7iV98kEGTdsiWZG5+FOcutV5bW47p2hOPXZHkqdOtWcrBb22r62um4UmuOmPqlozp1Rvt/0F5GODVaGppQt6QyOrqNdbmMc9JTspeyVh/6G+mk/tV3Ik7PI9Mfp32X1GhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169275; c=relaxed/simple;
	bh=W4HTRtFPqGSJ216rvR08ho2Ee31NW0Ds9D9dPsn8EEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghaLDoaLmL1HqQ5rZhuynuulnNJzBzDkbJ04Qr40g9SqPMkC0N6O2D+iVGQkbbkLHnSF+TTFYW7g8VhcgR5QpgGOMwMbo1Qk/Ae/9cnyrTq1evSLZOfLQuKHkUdC50w2kcDtoCHHwLPBEOATyQhWxg26lKF/aybsba6iFJD3LwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 528DC1007;
	Mon, 11 Mar 2024 08:01:49 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A7423F64C;
	Mon, 11 Mar 2024 08:01:10 -0700 (PDT)
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
Subject: [PATCH v4 1/6] mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
Date: Mon, 11 Mar 2024 15:00:53 +0000
Message-Id: <20240311150058.1122862-2-ryan.roberts@arm.com>
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
shortcut a call __try_to_reclaim_swap() in some cases.
__try_to_reclaim_swap() gets the folio and (via some other functions)
calls swap_page_trans_huge_swapped(). So I've removed the problematic
call site and believe the new logic should be functionally equivalent.

That said, removing the fast path means that we will take a reference
and trylock a large folio much more often, which we would like to avoid.
The next patch will solve this.

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
index 2955f7a78d8d..4a8b6c60793a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -259,7 +259,6 @@ struct swap_cluster_info {
 };
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
 #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
-#define CLUSTER_FLAG_HUGE 4 /* This cluster is backing a transparent huge page */
 
 /*
  * We assign a cluster to each CPU, so each CPU can allocate swap entry from
@@ -600,15 +599,6 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
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
index 04fb994a7b0b..5298ba882d49 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2965,9 +2965,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		shmem_uncharge(folio->mapping->host, nr_dropped);
 	remap_page(folio, nr);
 
-	if (folio_test_swapcache(folio))
-		split_swap_cluster(folio->swap);
-
 	/*
 	 * set page to its compound_head when split to non order-0 pages, so
 	 * we can skip unlocking it below, since PG_locked is transferred to
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1155a6304119..df1de034f6d8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -343,18 +343,6 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
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
@@ -1027,7 +1015,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
 	offset = idx * SWAPFILE_CLUSTER;
 	ci = lock_cluster(si, offset);
 	alloc_cluster(si, idx);
-	cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE);
+	cluster_set_count(ci, SWAPFILE_CLUSTER);
 
 	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
 	unlock_cluster(ci);
@@ -1365,7 +1353,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 
 	ci = lock_cluster_or_swap_info(si, offset);
 	if (size == SWAPFILE_CLUSTER) {
-		VM_BUG_ON(!cluster_is_huge(ci));
 		map = si->swap_map + offset;
 		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
 			val = map[i];
@@ -1373,7 +1360,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 			if (val == SWAP_HAS_CACHE)
 				free_entries++;
 		}
-		cluster_clear_huge(ci);
 		if (free_entries == SWAPFILE_CLUSTER) {
 			unlock_cluster_or_swap_info(si, ci);
 			spin_lock(&si->lock);
@@ -1395,23 +1381,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
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
@@ -1519,22 +1488,23 @@ int swp_swapcount(swp_entry_t entry)
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
@@ -1556,7 +1526,7 @@ static bool folio_swapped(struct folio *folio)
 	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(folio)))
 		return swap_swapcount(si, entry) != 0;
 
-	return swap_page_trans_huge_swapped(si, entry);
+	return swap_page_trans_huge_swapped(si, entry, folio_nr_pages(folio));
 }
 
 /**
@@ -1622,8 +1592,7 @@ int free_swap_and_cache(swp_entry_t entry)
 		}
 
 		count = __swap_entry_free(p, entry);
-		if (count == SWAP_HAS_CACHE &&
-		    !swap_page_trans_huge_swapped(p, entry))
+		if (count == SWAP_HAS_CACHE)
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
 		put_swap_device(p);
-- 
2.25.1


