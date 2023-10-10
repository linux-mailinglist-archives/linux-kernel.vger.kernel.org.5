Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2367BFF10
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjJJOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjJJOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:21:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEED2A9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:21:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EE63106F;
        Tue, 10 Oct 2023 07:22:07 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E5043F762;
        Tue, 10 Oct 2023 07:21:25 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH v1 2/2] mm: swap: Swap-out small-sized THP without splitting
Date:   Tue, 10 Oct 2023 15:21:11 +0100
Message-Id: <20231010142111.3997780-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010142111.3997780-1-ryan.roberts@arm.com>
References: <20231010142111.3997780-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
enabled, and when the swap backing store is a non-rotating block device
- these are the same constraints as for the existing PMD-sized THP
swap-out support.

Note that no attempt is made to swap-in THP here - this is still done
page-by-page, like for PMD-sized THP.

The main change here is to improve the swap entry allocator so that it
can allocate any power-of-2 number of contiguous entries between [4, (1
<< PMD_ORDER)]. This is done by allocating a cluster for each distinct
order and allocating sequentially from it until the cluster is full.
This ensures that we don't need to search the map and we get no
fragmentation due to alignment padding for different orders in the
cluster. If there is no current cluster for a given order, we attempt to
allocate a free cluster from the list. If there are no free clusters, we
fail the allocation and the caller falls back to splitting the folio and
allocates individual entries (as per existing PMD-sized THP fallback).

As far as I can tell, this should not cause any extra fragmentation
concerns, given how similar it is to the existing PMD-sized THP
allocation mechanism. There will be up to (PMD_ORDER-1) clusters in
concurrent use though. In practice, the number of orders in use will be
small though.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h |  7 ++++++
 mm/swapfile.c        | 60 +++++++++++++++++++++++++++++++++-----------
 mm/vmscan.c          | 10 +++++---
 3 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a073366a227c..fc55b760aeff 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -320,6 +320,13 @@ struct swap_info_struct {
 					 */
 	struct work_struct discard_work; /* discard worker */
 	struct swap_cluster_list discard_clusters; /* discard clusters list */
+	unsigned int large_next[PMD_ORDER]; /*
+					     * next free offset within current
+					     * allocation cluster for large
+					     * folios, or UINT_MAX if no current
+					     * cluster. Index is (order - 1).
+					     * Only when cluster_info is used.
+					     */
 	struct plist_node avail_lists[]; /*
 					   * entries in swap_avail_heads, one
 					   * entry per node.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c668838fa660..f8093dedc866 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -987,8 +987,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	return n_ret;
 }

-static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
+static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
+			    unsigned int nr_pages)
 {
+	int order;
 	unsigned long idx;
 	struct swap_cluster_info *ci;
 	unsigned long offset;
@@ -1002,20 +1004,47 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
 		return 0;
 	}

-	if (cluster_list_empty(&si->free_clusters))
-		return 0;
+	VM_WARN_ON(nr_pages < 2);
+	VM_WARN_ON(nr_pages > SWAPFILE_CLUSTER);
+	VM_WARN_ON(!is_power_of_2(nr_pages));

-	idx = cluster_list_first(&si->free_clusters);
-	offset = idx * SWAPFILE_CLUSTER;
-	ci = lock_cluster(si, offset);
-	alloc_cluster(si, idx);
-	cluster_set_count_flag(ci, SWAPFILE_CLUSTER, 0);
+	order = ilog2(nr_pages);
+	offset = si->large_next[order - 1];
+
+	if (offset == UINT_MAX) {
+		if (cluster_list_empty(&si->free_clusters))
+			return 0;

-	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
+		idx = cluster_list_first(&si->free_clusters);
+		offset = idx * SWAPFILE_CLUSTER;
+
+		ci = lock_cluster(si, offset);
+		alloc_cluster(si, idx);
+		cluster_set_count_flag(ci, SWAPFILE_CLUSTER, 0);
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
+	si->large_next[order - 1] = offset;
+
 	return 1;
 }

@@ -1041,7 +1070,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	int node;

 	/* Only single cluster request supported */
-	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
+	WARN_ON_ONCE(n_goal > 1 && size > 1);

 	spin_lock(&swap_avail_lock);

@@ -1078,14 +1107,14 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
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

@@ -2725,6 +2754,9 @@ static struct swap_info_struct *alloc_swap_info(void)
 	spin_lock_init(&p->cont_lock);
 	init_completion(&p->comp);

+	for (i = 0; i < ARRAY_SIZE(p->large_next); i++)
+		p->large_next[i] = UINT_MAX;
+
 	return p;
 }

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

