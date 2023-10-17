Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD7A7CC87C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjJQQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbjJQQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:13:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5942C95
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:13:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF8E212FC;
        Tue, 17 Oct 2023 09:13:58 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E3C13F762;
        Tue, 17 Oct 2023 09:13:16 -0700 (PDT)
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
Subject: [PATCH v2 2/2] mm: swap: Swap-out small-sized THP without splitting
Date:   Tue, 17 Oct 2023 17:13:02 +0100
Message-Id: <20231017161302.2518826-3-ryan.roberts@arm.com>
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
can allocate any power-of-2 number of contiguous entries between [4, (1
<< PMD_ORDER)] (THP cannot support order-1 folios). This is done by
allocating a cluster for each distinct order and allocating sequentially
from it until the cluster is full. This ensures that we don't need to
search the map and we get no fragmentation due to alignment padding for
different orders in the cluster. If there is no current cluster for a
given order, we attempt to allocate a free cluster from the list. If
there are no free clusters, we fail the allocation and the caller falls
back to splitting the folio and allocates individual entries (as per
existing PMD-sized THP fallback).

The per-order current clusters are maintained per-cpu using the existing
percpu_cluster infrastructure. This is done to avoid interleving pages
from different tasks, which would prevent IO being batched. This is
already done for the order-0 allocations so we follow the same pattern.

As far as I can tell, this should not cause any extra fragmentation
concerns, given how similar it is to the existing PMD-sized THP
allocation mechanism. There could be up to (PMD_ORDER-2) * nr_cpus
clusters in concurrent use though, which in a pathalogical case (cluster
set aside for every order for every cpu and only one huge entry
allocated from it) would tie up ~12MiB of unused swap entries for these
high orders (assuming PMD_ORDER=9). In practice, the number of orders in
use will be small and the amount of swap space reserved is very small
compared to a typical swap file.

Note that PMD_ORDER is not compile-time constant on powerpc, so we have
to allocate the large_next[] array at runtime.

I've run the tests on Ampere Altra (arm64), set up with a 35G block ram
device as the swap device and from inside a memcg limited to 40G memory.
I've then run `usemem` from vm-scalability with 70 processes (each has
its own core), each allocating and writing 1G of memory. I've repeated
everything 5 times and taken the mean and stdev:

Mean Performance Improvement vs 4K/baseline

| alloc size |            baseline |       + this series |
|            |  v6.6-rc4+anonfolio |                     |
|:-----------|--------------------:|--------------------:|
| 4K Page    |                0.0% |                1.1% |
| 64K THP    |              -44.1% |                0.9% |
| 2M THP     |               56.0% |               56.4% |

So with this change, the regression for 64K swap performance goes away.
Both 4K and 64K benhcmarks are now bottlenecked on TLBI performance from
try_to_unmap_flush_dirty(), on arm64 at least. When using fewer cpus in
the test, I see upto 2x performance of 64K THP swapping compared to 4K.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h |  6 ++++
 mm/swapfile.c        | 74 +++++++++++++++++++++++++++++++++++---------
 mm/vmscan.c          | 10 +++---
 3 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a073366a227c..35cbbe6509a9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -268,6 +268,12 @@ struct swap_cluster_info {
 struct percpu_cluster {
 	struct swap_cluster_info index; /* Current cluster index */
 	unsigned int next; /* Likely next allocation offset */
+	unsigned int large_next[];	/*
+					 * next free offset within current
+					 * allocation cluster for large folios,
+					 * or UINT_MAX if no current cluster.
+					 * Index is (order - 1).
+					 */
 };

 struct swap_cluster_list {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b83ad77e04c0..625964e53c22 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -987,35 +987,70 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	return n_ret;
 }

-static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
+static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
+			    unsigned int nr_pages)
 {
+	int order_idx;
 	unsigned long idx;
 	struct swap_cluster_info *ci;
+	struct percpu_cluster *cluster;
 	unsigned long offset;

 	/*
 	 * Should not even be attempting cluster allocations when huge
 	 * page swap is disabled.  Warn and fail the allocation.
 	 */
-	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
+	if (!IS_ENABLED(CONFIG_THP_SWAP) ||
+	    nr_pages < 4 || nr_pages > SWAPFILE_CLUSTER ||
+	    !is_power_of_2(nr_pages)) {
 		VM_WARN_ON_ONCE(1);
 		return 0;
 	}

-	if (cluster_list_empty(&si->free_clusters))
+	/*
+	 * Not using clusters so unable to allocate large entries.
+	 */
+	if (!si->cluster_info)
 		return 0;

-	idx = cluster_list_first(&si->free_clusters);
-	offset = idx * SWAPFILE_CLUSTER;
-	ci = lock_cluster(si, offset);
-	alloc_cluster(si, idx);
-	cluster_set_count(ci, SWAPFILE_CLUSTER);
+	order_idx = ilog2(nr_pages) - 2;
+	cluster = this_cpu_ptr(si->percpu_cluster);
+	offset = cluster->large_next[order_idx];
+
+	if (offset == UINT_MAX) {
+		if (cluster_list_empty(&si->free_clusters))
+			return 0;
+
+		idx = cluster_list_first(&si->free_clusters);
+		offset = idx * SWAPFILE_CLUSTER;

-	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
+		ci = lock_cluster(si, offset);
+		alloc_cluster(si, idx);
+		cluster_set_count(ci, SWAPFILE_CLUSTER);
+
+		/*
+		 * If scan_swap_map_slots() can't find a free cluster, it will
+		 * check si->swap_map directly. To make sure this standby
+		 * cluster isn't taken by scan_swap_map_slots(), mark the swap
+		 * entries bad (occupied). (same approach as discard).
+		 */
+		memset(si->swap_map + offset + nr_pages, SWAP_MAP_BAD,
+			SWAPFILE_CLUSTER - nr_pages);
+	} else {
+		idx = offset / SWAPFILE_CLUSTER;
+		ci = lock_cluster(si, offset);
+	}
+
+	memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
 	unlock_cluster(ci);
-	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
+	swap_range_alloc(si, offset, nr_pages);
 	*slot = swp_entry(si->type, offset);

+	offset += nr_pages;
+	if (idx != offset / SWAPFILE_CLUSTER)
+		offset = UINT_MAX;
+	cluster->large_next[order_idx] = offset;
+
 	return 1;
 }

@@ -1041,7 +1076,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	int node;

 	/* Only single cluster request supported */
-	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
+	WARN_ON_ONCE(n_goal > 1 && size > 1);

 	spin_lock(&swap_avail_lock);

@@ -1078,14 +1113,14 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 			spin_unlock(&si->lock);
 			goto nextsi;
 		}
-		if (size == SWAPFILE_CLUSTER) {
+		if (size > 1) {
 			if (si->flags & SWP_BLKDEV)
-				n_ret = swap_alloc_cluster(si, swp_entries);
+				n_ret = swap_alloc_large(si, swp_entries, size);
 		} else
 			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
 						    n_goal, swp_entries);
 		spin_unlock(&si->lock);
-		if (n_ret || size == SWAPFILE_CLUSTER)
+		if (n_ret || size > 1)
 			goto check_out;
 		cond_resched();

@@ -3046,6 +3081,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (p->bdev && bdev_nonrot(p->bdev)) {
 		int cpu;
 		unsigned long ci, nr_cluster;
+		int nr_order;
+		int i;

 		p->flags |= SWP_SOLIDSTATE;
 		p->cluster_next_cpu = alloc_percpu(unsigned int);
@@ -3073,7 +3110,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		for (ci = 0; ci < nr_cluster; ci++)
 			spin_lock_init(&((cluster_info + ci)->lock));

-		p->percpu_cluster = alloc_percpu(struct percpu_cluster);
+		nr_order = IS_ENABLED(CONFIG_THP_SWAP) ? PMD_ORDER - 1 : 0;
+		p->percpu_cluster = __alloc_percpu(
+					struct_size(p->percpu_cluster,
+						    large_next,
+						    nr_order),
+					__alignof__(struct percpu_cluster));
 		if (!p->percpu_cluster) {
 			error = -ENOMEM;
 			goto bad_swap_unlock_inode;
@@ -3082,6 +3124,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 			struct percpu_cluster *cluster;
 			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
 			cluster_set_null(&cluster->index);
+			for (i = 0; i < nr_order; i++)
+				cluster->large_next[i] = UINT_MAX;
 		}
 	} else {
 		atomic_inc(&nr_rotate_swap);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c16e2b1ea8ae..5984d2ae4547 100644
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

