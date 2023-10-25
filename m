Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D557D7009
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJYOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbjJYOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:46:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EFF6138
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:46:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7E2F1476;
        Wed, 25 Oct 2023 07:46:44 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90E5C3F64C;
        Wed, 25 Oct 2023 07:46:01 -0700 (PDT)
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
Subject: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
Date:   Wed, 25 Oct 2023 15:45:46 +0100
Message-Id: <20231025144546.577640-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025144546.577640-1-ryan.roberts@arm.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
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

The upcoming anonymous small-sized THP feature enables performance
improvements by allocating large folios for anonymous memory. However
I've observed that on an arm64 system running a parallel workload (e.g.
kernel compilation) across many cores, under high memory pressure, the
speed regresses. This is due to bottlenecking on the increased number of
TLBIs added due to all the extra folio splitting.

Therefore, solve this regression by adding support for swapping out
small-sized THP without needing to split the folio, just like is already
done for PMD-sized THP. This change only applies when CONFIG_THP_SWAP is
enabled, and when the swap backing store is a non-rotating block device.
These are the same constraints as for the existing PMD-sized THP
swap-out support.

Note that no attempt is made to swap-in THP here - this is still done
page-by-page, like for PMD-sized THP.

The main change here is to improve the swap entry allocator so that it
can allocate any power-of-2 number of contiguous entries between [1, (1
<< PMD_ORDER)]. This is done by allocating a cluster for each distinct
order and allocating sequentially from it until the cluster is full.
This ensures that we don't need to search the map and we get no
fragmentation due to alignment padding for different orders in the
cluster. If there is no current cluster for a given order, we attempt to
allocate a free cluster from the list. If there are no free clusters, we
fail the allocation and the caller falls back to splitting the folio and
allocates individual entries (as per existing PMD-sized THP fallback).

The per-order current clusters are maintained per-cpu using the existing
infrastructure. This is done to avoid interleving pages from different
tasks, which would prevent IO being batched. This is already done for
the order-0 allocations so we follow the same pattern.
__scan_swap_map_try_ssd_cluster() is introduced to deal with arbitrary
orders and scan_swap_map_try_ssd_cluster() is refactored as a wrapper
for order-0.

As is done for order-0 per-cpu clusters, the scanner now can steal
order-0 entries from any per-cpu-per-order reserved cluster. This
ensures that when the swap file is getting full, space doesn't get tied
up in the per-cpu reserves.

I've run the tests on Ampere Altra (arm64), set up with a 35G block ram
device as the swap device and from inside a memcg limited to 40G memory.
I've then run `usemem` from vm-scalability with 70 processes (each has
its own core), each allocating and writing 1G of memory. I've repeated
everything 5 times and taken the mean:

Mean Performance Improvement vs 4K/baseline

| alloc size |            baseline |       + this series |
|            |  v6.6-rc4+anonfolio |                     |
|:-----------|--------------------:|--------------------:|
| 4K Page    |                0.0% |                4.9% |
| 64K THP    |              -44.1% |               10.7% |
| 2M THP     |               56.0% |               65.9% |

So with this change, the regression for 64K swap performance goes away
and 4K and 2M swap improves slightly too.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h |  10 +--
 mm/swapfile.c        | 149 +++++++++++++++++++++++++++++++------------
 mm/vmscan.c          |  10 +--
 3 files changed, 119 insertions(+), 50 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0ca8aaa098ba..ccbca5db851b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -295,11 +295,11 @@ struct swap_info_struct {
 	unsigned int __percpu *cluster_next_cpu; /*percpu index for next allocation */
 	unsigned int __percpu *cpu_next;/*
 					 * Likely next allocation offset. We
-					 * assign a cluster to each CPU, so each
-					 * CPU can allocate swap entry from its
-					 * own cluster and swapout sequentially.
-					 * The purpose is to optimize swapout
-					 * throughput.
+					 * assign a cluster per-order to each
+					 * CPU, so each CPU can allocate swap
+					 * entry from its own cluster and
+					 * swapout sequentially. The purpose is
+					 * to optimize swapout throughput.
 					 */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 94f7cc225eb9..b50bce50bed9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -545,10 +545,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
 
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
 
@@ -557,9 +559,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
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
+ * removed from free cluster list and its usage counter will be increased.
+ */
+static void inc_cluster_info_page(struct swap_info_struct *p,
+	struct swap_cluster_info *cluster_info, unsigned long page_nr)
+{
+	add_cluster_info_page(p, cluster_info, page_nr, 1);
 }
 
 /*
@@ -588,8 +600,8 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
  * cluster list. Avoiding such abuse to avoid list corruption.
  */
 static bool
-scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
-	unsigned long offset)
+__scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
+	unsigned long offset, int order)
 {
 	bool conflict;
 
@@ -601,23 +613,36 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
 	if (!conflict)
 		return false;
 
-	*this_cpu_ptr(si->cpu_next) = SWAP_NEXT_NULL;
+	this_cpu_ptr(si->cpu_next)[order] = SWAP_NEXT_NULL;
 	return true;
 }
 
 /*
- * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
- * might involve allocating a new cluster for current CPU too.
+ * It's possible scan_swap_map_slots() uses a free cluster in the middle of free
+ * cluster list. Avoiding such abuse to avoid list corruption.
  */
-static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
-	unsigned long *offset, unsigned long *scan_base)
+static bool
+scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
+	unsigned long offset)
+{
+	return __scan_swap_map_ssd_cluster_conflict(si, offset, 0);
+}
+
+/*
+ * Try to get a swap entry (or size indicated by order) from current cpu's swap
+ * entry pool (a cluster). This might involve allocating a new cluster for
+ * current CPU too.
+ */
+static bool __scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
+	unsigned long *offset, unsigned long *scan_base, int order)
 {
 	struct swap_cluster_info *ci;
-	unsigned int tmp, max;
+	unsigned int tmp, max, i;
 	unsigned int *cpu_next;
+	unsigned int nr_pages = 1 << order;
 
 new_cluster:
-	cpu_next = this_cpu_ptr(si->cpu_next);
+	cpu_next = &this_cpu_ptr(si->cpu_next)[order];
 	tmp = *cpu_next;
 	if (tmp == SWAP_NEXT_NULL) {
 		if (!cluster_list_empty(&si->free_clusters)) {
@@ -643,10 +668,12 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	 * reserve a new cluster.
 	 */
 	ci = lock_cluster(si, tmp);
-	if (si->swap_map[tmp]) {
-		unlock_cluster(ci);
-		*cpu_next = SWAP_NEXT_NULL;
-		goto new_cluster;
+	for (i = 0; i < nr_pages; i++) {
+		if (si->swap_map[tmp + i]) {
+			unlock_cluster(ci);
+			*cpu_next = SWAP_NEXT_NULL;
+			goto new_cluster;
+		}
 	}
 	unlock_cluster(ci);
 
@@ -654,12 +681,22 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	*scan_base = tmp;
 
 	max = ALIGN_DOWN(tmp, SWAPFILE_CLUSTER) + SWAPFILE_CLUSTER;
-	tmp += 1;
+	tmp += nr_pages;
 	*cpu_next = tmp < max ? tmp : SWAP_NEXT_NULL;
 
 	return true;
 }
 
+/*
+ * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
+ * might involve allocating a new cluster for current CPU too.
+ */
+static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
+	unsigned long *offset, unsigned long *scan_base)
+{
+	return __scan_swap_map_try_ssd_cluster(si, offset, scan_base, 0);
+}
+
 static void __del_from_avail_list(struct swap_info_struct *p)
 {
 	int nid;
@@ -982,35 +1019,58 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	return n_ret;
 }
 
-static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
+static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
+			    unsigned int nr_pages)
 {
-	unsigned long idx;
 	struct swap_cluster_info *ci;
-	unsigned long offset;
+	unsigned long offset, scan_base;
+	int order = ilog2(nr_pages);
+	bool ret;
 
 	/*
-	 * Should not even be attempting cluster allocations when huge
+	 * Should not even be attempting large allocations when huge
 	 * page swap is disabled.  Warn and fail the allocation.
 	 */
-	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
+	if (!IS_ENABLED(CONFIG_THP_SWAP) ||
+	    nr_pages < 2 || nr_pages > SWAPFILE_CLUSTER ||
+	    !is_power_of_2(nr_pages)) {
 		VM_WARN_ON_ONCE(1);
 		return 0;
 	}
 
-	if (cluster_list_empty(&si->free_clusters))
+	/*
+	 * Swapfile is not block device or not using clusters so unable to
+	 * allocate large entries.
+	 */
+	if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
 		return 0;
 
-	idx = cluster_list_first(&si->free_clusters);
-	offset = idx * SWAPFILE_CLUSTER;
-	ci = lock_cluster(si, offset);
-	alloc_cluster(si, idx);
-	cluster_set_count(ci, SWAPFILE_CLUSTER);
+again:
+	/*
+	 * __scan_swap_map_try_ssd_cluster() may drop si->lock during discard,
+	 * so indicate that we are scanning to synchronise with swapoff.
+	 */
+	si->flags += SWP_SCANNING;
+	ret = __scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order);
+	si->flags -= SWP_SCANNING;
+
+	/*
+	 * If we failed to allocate or if swapoff is waiting for us (due to lock
+	 * being dropped for discard above), return immediately.
+	 */
+	if (!ret || !(si->flags & SWP_WRITEOK))
+		return 0;
 
-	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
+	if (__scan_swap_map_ssd_cluster_conflict(si, offset, order))
+		goto again;
+
+	ci = lock_cluster(si, offset);
+	memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
+	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
 	unlock_cluster(ci);
-	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
-	*slot = swp_entry(si->type, offset);
 
+	swap_range_alloc(si, offset, nr_pages);
+	*slot = swp_entry(si->type, offset);
 	return 1;
 }
 
@@ -1036,7 +1096,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	int node;
 
 	/* Only single cluster request supported */
-	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
+	WARN_ON_ONCE(n_goal > 1 && size > 1);
 
 	spin_lock(&swap_avail_lock);
 
@@ -1073,14 +1133,13 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 			spin_unlock(&si->lock);
 			goto nextsi;
 		}
-		if (size == SWAPFILE_CLUSTER) {
-			if (si->flags & SWP_BLKDEV)
-				n_ret = swap_alloc_cluster(si, swp_entries);
+		if (size > 1) {
+			n_ret = swap_alloc_large(si, swp_entries, size);
 		} else
 			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
 						    n_goal, swp_entries);
 		spin_unlock(&si->lock);
-		if (n_ret || size == SWAPFILE_CLUSTER)
+		if (n_ret || size > 1)
 			goto check_out;
 		cond_resched();
 
@@ -3041,6 +3100,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (p->bdev && bdev_nonrot(p->bdev)) {
 		int cpu;
 		unsigned long ci, nr_cluster;
+		int nr_order;
+		int i;
 
 		p->flags |= SWP_SOLIDSTATE;
 		p->cluster_next_cpu = alloc_percpu(unsigned int);
@@ -3068,13 +3129,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		for (ci = 0; ci < nr_cluster; ci++)
 			spin_lock_init(&((cluster_info + ci)->lock));
 
-		p->cpu_next = alloc_percpu(unsigned int);
+		nr_order = IS_ENABLED(CONFIG_THP_SWAP) ? PMD_ORDER + 1 : 1;
+		p->cpu_next = __alloc_percpu(sizeof(unsigned int) * nr_order,
+					     __alignof__(unsigned int));
 		if (!p->cpu_next) {
 			error = -ENOMEM;
 			goto bad_swap_unlock_inode;
 		}
-		for_each_possible_cpu(cpu)
-			per_cpu(*p->cpu_next, cpu) = SWAP_NEXT_NULL;
+		for_each_possible_cpu(cpu) {
+			unsigned int *cpu_next = per_cpu_ptr(p->cpu_next, cpu);
+
+			for (i = 0; i < nr_order; i++)
+				cpu_next[i] = SWAP_NEXT_NULL;
+		}
 	} else {
 		atomic_inc(&nr_rotate_swap);
 		inced_nr_rotate_swap = true;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2cc0cb41fb32..ea19710aa4cd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					if (!can_split_folio(folio, NULL))
 						goto activate_locked;
 					/*
-					 * Split folios without a PMD map right
-					 * away. Chances are some or all of the
-					 * tail pages can be freed without IO.
+					 * Split PMD-mappable folios without a
+					 * PMD map right away. Chances are some
+					 * or all of the tail pages can be freed
+					 * without IO.
 					 */
-					if (!folio_entire_mapcount(folio) &&
+					if (folio_test_pmd_mappable(folio) &&
+					    !folio_entire_mapcount(folio) &&
 					    split_folio_to_list(folio,
 								folio_list))
 						goto activate_locked;
-- 
2.25.1

