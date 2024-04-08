Return-Path: <linux-kernel+bounces-135826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924B89CBD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E51B230C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD467128392;
	Mon,  8 Apr 2024 18:40:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACA146590
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601614; cv=none; b=DM8vWtf5i3V6BaCz3GVQhz4RWqixKIZMRkdufwvRv7ETrySx3VISKK5m8zZj9NBMjMrZbK+XK2NVyFBH8b0AUDpLlKzhcaKSX1eButpG2WSm3Ccgjd5tjSvCwCcGcUlMNVLH6/2ymgCMKfXSOS+tg4IAewODNB4MmzjcphPhf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601614; c=relaxed/simple;
	bh=0lPXbuqVWxtugmDcMBgwGc2XIQBeGiXQLKviqN14BJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZZnNi9CjNGMd3mu1om/mnZ0bDkk/joUQm/Dp9EPS9xMmBMWtzuBAyHxbWt46cXcZZt32zpU/GhFG5sBNpfJe+ALwTvevGwYpL+JeYrfFS8i3867tj/dqdi6+wyu7hAib5sgH1pIZjaTX8Ey6T1Jbko1Lq8R2lVVrvOFPA+3/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3DD01007;
	Mon,  8 Apr 2024 11:40:42 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 639383F766;
	Mon,  8 Apr 2024 11:40:10 -0700 (PDT)
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
	Chris Li <chrisl@kernel.org>,
	Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/7] mm: swap: Allow storage of all mTHP orders
Date: Mon,  8 Apr 2024 19:39:44 +0100
Message-Id: <20240408183946.2991168-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408183946.2991168-1-ryan.roberts@arm.com>
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi-size THP enables performance improvements by allocating large,
pte-mapped folios for anonymous memory. However I've observed that on an
arm64 system running a parallel workload (e.g. kernel compilation)
across many cores, under high memory pressure, the speed regresses. This
is due to bottlenecking on the increased number of TLBIs added due to
all the extra folio splitting when the large folios are swapped out.

Therefore, solve this regression by adding support for swapping out mTHP
without needing to split the folio, just like is already done for
PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
and when the swap backing store is a non-rotating block device. These
are the same constraints as for the existing PMD-sized THP swap-out
support.

Note that no attempt is made to swap-in (m)THP here - this is still done
page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
prerequisite for swapping-in mTHP.

The main change here is to improve the swap entry allocator so that it
can allocate any power-of-2 number of contiguous entries between [1, (1
<< PMD_ORDER)]. This is done by allocating a cluster for each distinct
order and allocating sequentially from it until the cluster is full.
This ensures that we don't need to search the map and we get no
fragmentation due to alignment padding for different orders in the
cluster. If there is no current cluster for a given order, we attempt to
allocate a free cluster from the list. If there are no free clusters, we
fail the allocation and the caller can fall back to splitting the folio
and allocates individual entries (as per existing PMD-sized THP
fallback).

The per-order current clusters are maintained per-cpu using the existing
infrastructure. This is done to avoid interleving pages from different
tasks, which would prevent IO being batched. This is already done for
the order-0 allocations so we follow the same pattern.

As is done for order-0 per-cpu clusters, the scanner now can steal
order-0 entries from any per-cpu-per-order reserved cluster. This
ensures that when the swap file is getting full, space doesn't get tied
up in the per-cpu reserves.

This change only modifies swap to be able to accept any order mTHP. It
doesn't change the callers to elide doing the actual split. That will be
done in separate changes.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h |   8 ++-
 mm/swapfile.c        | 162 ++++++++++++++++++++++++-------------------
 2 files changed, 98 insertions(+), 72 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b888e1080a94..11c53692f65f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -268,13 +268,19 @@ struct swap_cluster_info {
  */
 #define SWAP_NEXT_INVALID	0
 
+#ifdef CONFIG_THP_SWAP
+#define SWAP_NR_ORDERS		(PMD_ORDER + 1)
+#else
+#define SWAP_NR_ORDERS		1
+#endif
+
 /*
  * We assign a cluster to each CPU, so each CPU can allocate swap entry from
  * its own cluster and swapout sequentially. The purpose is to optimize swapout
  * throughput.
  */
 struct percpu_cluster {
-	unsigned int next; /* Likely next allocation offset */
+	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
 };
 
 struct swap_cluster_list {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index d2e3d3cd439f..148ef08f19dd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -551,10 +551,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
 
 /*
  * The cluster corresponding to page_nr will be used. The cluster will be
- * removed from free cluster list and its usage counter will be increased.
+ * removed from free cluster list and its usage counter will be increased by
+ * count.
  */
-static void inc_cluster_info_page(struct swap_info_struct *p,
-	struct swap_cluster_info *cluster_info, unsigned long page_nr)
+static void add_cluster_info_page(struct swap_info_struct *p,
+	struct swap_cluster_info *cluster_info, unsigned long page_nr,
+	unsigned long count)
 {
 	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
 
@@ -563,9 +565,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
 	if (cluster_is_free(&cluster_info[idx]))
 		alloc_cluster(p, idx);
 
-	VM_BUG_ON(cluster_count(&cluster_info[idx]) >= SWAPFILE_CLUSTER);
+	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
 	cluster_set_count(&cluster_info[idx],
-		cluster_count(&cluster_info[idx]) + 1);
+		cluster_count(&cluster_info[idx]) + count);
+}
+
+/*
+ * The cluster corresponding to page_nr will be used. The cluster will be
+ * removed from free cluster list and its usage counter will be increased by 1.
+ */
+static void inc_cluster_info_page(struct swap_info_struct *p,
+	struct swap_cluster_info *cluster_info, unsigned long page_nr)
+{
+	add_cluster_info_page(p, cluster_info, page_nr, 1);
 }
 
 /*
@@ -595,7 +607,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
  */
 static bool
 scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
-	unsigned long offset)
+	unsigned long offset, int order)
 {
 	struct percpu_cluster *percpu_cluster;
 	bool conflict;
@@ -609,24 +621,39 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
 		return false;
 
 	percpu_cluster = this_cpu_ptr(si->percpu_cluster);
-	percpu_cluster->next = SWAP_NEXT_INVALID;
+	percpu_cluster->next[order] = SWAP_NEXT_INVALID;
+	return true;
+}
+
+static inline bool swap_range_empty(char *swap_map, unsigned int start,
+				    unsigned int nr_pages)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (swap_map[start + i])
+			return false;
+	}
+
 	return true;
 }
 
 /*
- * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
- * might involve allocating a new cluster for current CPU too.
+ * Try to get swap entries with specified order from current cpu's swap entry
+ * pool (a cluster). This might involve allocating a new cluster for current CPU
+ * too.
  */
 static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
-	unsigned long *offset, unsigned long *scan_base)
+	unsigned long *offset, unsigned long *scan_base, int order)
 {
+	unsigned int nr_pages = 1 << order;
 	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci;
 	unsigned int tmp, max;
 
 new_cluster:
 	cluster = this_cpu_ptr(si->percpu_cluster);
-	tmp = cluster->next;
+	tmp = cluster->next[order];
 	if (tmp == SWAP_NEXT_INVALID) {
 		if (!cluster_list_empty(&si->free_clusters)) {
 			tmp = cluster_next(&si->free_clusters.head) *
@@ -647,26 +674,27 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 
 	/*
 	 * Other CPUs can use our cluster if they can't find a free cluster,
-	 * check if there is still free entry in the cluster
+	 * check if there is still free entry in the cluster, maintaining
+	 * natural alignment.
 	 */
 	max = min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLUSTER));
 	if (tmp < max) {
 		ci = lock_cluster(si, tmp);
 		while (tmp < max) {
-			if (!si->swap_map[tmp])
+			if (swap_range_empty(si->swap_map, tmp, nr_pages))
 				break;
-			tmp++;
+			tmp += nr_pages;
 		}
 		unlock_cluster(ci);
 	}
 	if (tmp >= max) {
-		cluster->next = SWAP_NEXT_INVALID;
+		cluster->next[order] = SWAP_NEXT_INVALID;
 		goto new_cluster;
 	}
 	*offset = tmp;
 	*scan_base = tmp;
-	tmp += 1;
-	cluster->next = tmp < max ? tmp : SWAP_NEXT_INVALID;
+	tmp += nr_pages;
+	cluster->next[order] = tmp < max ? tmp : SWAP_NEXT_INVALID;
 	return true;
 }
 
@@ -796,13 +824,14 @@ static bool swap_offset_available_and_locked(struct swap_info_struct *si,
 
 static int scan_swap_map_slots(struct swap_info_struct *si,
 			       unsigned char usage, int nr,
-			       swp_entry_t slots[])
+			       swp_entry_t slots[], int order)
 {
 	struct swap_cluster_info *ci;
 	unsigned long offset;
 	unsigned long scan_base;
 	unsigned long last_in_cluster = 0;
 	int latency_ration = LATENCY_LIMIT;
+	unsigned int nr_pages = 1 << order;
 	int n_ret = 0;
 	bool scanned_many = false;
 
@@ -817,6 +846,25 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	 * And we let swap pages go all over an SSD partition.  Hugh
 	 */
 
+	if (order > 0) {
+		/*
+		 * Should not even be attempting large allocations when huge
+		 * page swap is disabled.  Warn and fail the allocation.
+		 */
+		if (!IS_ENABLED(CONFIG_THP_SWAP) ||
+		    nr_pages > SWAPFILE_CLUSTER) {
+			VM_WARN_ON_ONCE(1);
+			return 0;
+		}
+
+		/*
+		 * Swapfile is not block device or not using clusters so unable
+		 * to allocate large entries.
+		 */
+		if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
+			return 0;
+	}
+
 	si->flags += SWP_SCANNING;
 	/*
 	 * Use percpu scan base for SSD to reduce lock contention on
@@ -831,8 +879,11 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 
 	/* SSD algorithm */
 	if (si->cluster_info) {
-		if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
+		if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order)) {
+			if (order > 0)
+				goto no_page;
 			goto scan;
+		}
 	} else if (unlikely(!si->cluster_nr--)) {
 		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
 			si->cluster_nr = SWAPFILE_CLUSTER - 1;
@@ -874,13 +925,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 
 checks:
 	if (si->cluster_info) {
-		while (scan_swap_map_ssd_cluster_conflict(si, offset)) {
+		while (scan_swap_map_ssd_cluster_conflict(si, offset, order)) {
 		/* take a break if we already got some slots */
 			if (n_ret)
 				goto done;
 			if (!scan_swap_map_try_ssd_cluster(si, &offset,
-							&scan_base))
+							&scan_base, order)) {
+				if (order > 0)
+					goto no_page;
 				goto scan;
+			}
 		}
 	}
 	if (!(si->flags & SWP_WRITEOK))
@@ -911,11 +965,11 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		else
 			goto done;
 	}
-	WRITE_ONCE(si->swap_map[offset], usage);
-	inc_cluster_info_page(si, si->cluster_info, offset);
+	memset(si->swap_map + offset, usage, nr_pages);
+	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
 	unlock_cluster(ci);
 
-	swap_range_alloc(si, offset, 1);
+	swap_range_alloc(si, offset, nr_pages);
 	slots[n_ret++] = swp_entry(si->type, offset);
 
 	/* got enough slots or reach max slots? */
@@ -936,8 +990,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 
 	/* try to get more slots in cluster */
 	if (si->cluster_info) {
-		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
+		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order))
 			goto checks;
+		if (order > 0)
+			goto done;
 	} else if (si->cluster_nr && !si->swap_map[++offset]) {
 		/* non-ssd case, still more slots in cluster? */
 		--si->cluster_nr;
@@ -964,11 +1020,13 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	}
 
 done:
-	set_cluster_next(si, offset + 1);
+	if (order == 0)
+		set_cluster_next(si, offset + 1);
 	si->flags -= SWP_SCANNING;
 	return n_ret;
 
 scan:
+	VM_WARN_ON(order > 0);
 	spin_unlock(&si->lock);
 	while (++offset <= READ_ONCE(si->highest_bit)) {
 		if (unlikely(--latency_ration < 0)) {
@@ -997,38 +1055,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	return n_ret;
 }
 
-static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
-{
-	unsigned long idx;
-	struct swap_cluster_info *ci;
-	unsigned long offset;
-
-	/*
-	 * Should not even be attempting cluster allocations when huge
-	 * page swap is disabled.  Warn and fail the allocation.
-	 */
-	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
-		VM_WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	if (cluster_list_empty(&si->free_clusters))
-		return 0;
-
-	idx = cluster_list_first(&si->free_clusters);
-	offset = idx * SWAPFILE_CLUSTER;
-	ci = lock_cluster(si, offset);
-	alloc_cluster(si, idx);
-	cluster_set_count(ci, SWAPFILE_CLUSTER);
-
-	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
-	unlock_cluster(ci);
-	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
-	*slot = swp_entry(si->type, offset);
-
-	return 1;
-}
-
 static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 {
 	unsigned long offset = idx * SWAPFILE_CLUSTER;
@@ -1051,9 +1077,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 	int n_ret = 0;
 	int node;
 
-	/* Only single cluster request supported */
-	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
-
 	spin_lock(&swap_avail_lock);
 
 	avail_pgs = atomic_long_read(&nr_swap_pages) / size;
@@ -1089,14 +1112,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 			spin_unlock(&si->lock);
 			goto nextsi;
 		}
-		if (size == SWAPFILE_CLUSTER) {
-			if (si->flags & SWP_BLKDEV)
-				n_ret = swap_alloc_cluster(si, swp_entries);
-		} else
-			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
-						    n_goal, swp_entries);
+		n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
+					    n_goal, swp_entries, order);
 		spin_unlock(&si->lock);
-		if (n_ret || size == SWAPFILE_CLUSTER)
+		if (n_ret || size > 1)
 			goto check_out;
 		cond_resched();
 
@@ -1673,7 +1692,7 @@ swp_entry_t get_swap_page_of_type(int type)
 
 	/* This is called for allocating swap entry, not cache */
 	spin_lock(&si->lock);
-	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
+	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
 		atomic_long_dec(&nr_swap_pages);
 	spin_unlock(&si->lock);
 fail:
@@ -3127,7 +3146,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		p->flags |= SWP_SYNCHRONOUS_IO;
 
 	if (p->bdev && bdev_nonrot(p->bdev)) {
-		int cpu;
+		int cpu, i;
 		unsigned long ci, nr_cluster;
 
 		p->flags |= SWP_SOLIDSTATE;
@@ -3165,7 +3184,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 			struct percpu_cluster *cluster;
 
 			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
-			cluster->next = SWAP_NEXT_INVALID;
+			for (i = 0; i < SWAP_NR_ORDERS; i++)
+				cluster->next[i] = SWAP_NEXT_INVALID;
 		}
 	} else {
 		atomic_inc(&nr_rotate_swap);
-- 
2.25.1


