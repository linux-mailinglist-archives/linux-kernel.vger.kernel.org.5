Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FC7EBC81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjKOEDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKOEDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:03:05 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43504CD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:03:00 -0800 (PST)
Received: from dggpemd200004.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SVTsp3CCwzMmn5;
        Wed, 15 Nov 2023 11:58:22 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Wed, 15 Nov
 2023 12:02:57 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v9] mm: vmscan: try to reclaim swapcache pages if no swap space
Date:   Wed, 15 Nov 2023 13:01:23 +0800
Message-ID: <20231115050123.982876-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200004.china.huawei.com (7.185.36.141)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When spaces of swap devices are exhausted, only file pages can be
reclaimed.  But there are still some swapcache pages in anon lru list.
This can lead to a premature out-of-memory.

The problem is found with such step:

 Firstly, set a 9MB disk swap space, then create a cgroup with 10MB
 memory limit, then runs an program to allocates about 15MB memory.

The problem occurs occasionally, which may need about 100 times [1].

Fix it by checking number of swapcache pages in can_reclaim_anon_pages().
If the number is not zero, return true and set swapcache_only to 1.
When scan anon lru list in swapcache_only mode, non-swapcache pages will
be skipped to isolate in order to accelerate reclaim efficiency.

However, in swapcache_only mode, the scan count still increased when scan
non-swapcache pages because there are large number of non-swapcache pages
and rare swapcache pages in swapcache_only mode, and if the non-swapcache
is skipped and do not count, the scan of pages in isolate_lru_folios() can
eventually lead to hung task, just as Sachin reported [2].

By the way, since there are enough times of memory reclaim before OOM, it
is not need to isolate too much swapcache pages in one times.

[1]. https://lore.kernel.org/lkml/CAJD7tkZAfgncV+KbKr36=eDzMnT=9dZOT0dpMWcurHLr6Do+GA@mail.gmail.com/
[2]. https://lore.kernel.org/linux-mm/CAJD7tkafz_2XAuqE8tGLPEcpLngewhUo=5US14PAtSM9tLBUQg@mail.gmail.com/

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Tested-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
---
v8->v9: Move the swapcache check after can_demote() and refector 
	can_reclaim_anon_pages() a bit.
v7->v8: Reset swapcache_only at the beginning of can_reclaim_anon_pages().
v6->v7: Reset swapcache_only to zero after there are swap spaces.
v5->v6: Fix NULL pointing derefence and hung task problem reported by Sachin.

 include/linux/swap.h |  6 ++++++
 mm/memcontrol.c      |  8 ++++++++
 mm/vmscan.c          | 47 ++++++++++++++++++++++++++++++++------------
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f6dd6575b905..3ba146ae7cf5 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -659,6 +659,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
 }
 
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
+extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct folio *folio);
 #else
 static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
@@ -681,6 +682,11 @@ static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 	return get_nr_swap_pages();
 }
 
+static inline long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
+{
+	return total_swapcache_pages();
+}
+
 static inline bool mem_cgroup_swap_full(struct folio *folio)
 {
 	return vm_swap_full();
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 774bd6e21e27..a76ec540d4a3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7865,6 +7865,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 	return nr_swap_pages;
 }
 
+long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return total_swapcache_pages();
+
+	return memcg_page_state(memcg, NR_SWAPCACHE);
+}
+
 bool mem_cgroup_swap_full(struct folio *folio)
 {
 	struct mem_cgroup *memcg;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 506f8220c5fe..62a1c75f74ad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -136,6 +136,9 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
 
+	/* Swap space is exhausted, only reclaim swapcache for anon LRU */
+	unsigned int swapcache_only:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -312,25 +315,34 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 					  int nid,
 					  struct scan_control *sc)
 {
-	if (memcg == NULL) {
-		/*
-		 * For non-memcg reclaim, is there
-		 * space in any swap device?
-		 */
-		if (get_nr_swap_pages() > 0)
-			return true;
-	} else {
-		/* Is the memcg below its swap limit? */
-		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
-			return true;
-	}
+	if (sc)
+		sc->swapcache_only = 0;
+
+	/*
+	 * For non-memcg reclaim, is there space in any swap device?
+	 * Or is the memcg below its swap limit?
+	 */
+	if ((!memcg && get_nr_swap_pages() > 0) ||
+	    (memcg && mem_cgroup_get_nr_swap_pages(memcg) > 0))
+		return true;
 
 	/*
 	 * The page can not be swapped.
 	 *
 	 * Can it be reclaimed from this node via demotion?
 	 */
-	return can_demote(nid, sc);
+	if (can_demote(nid, sc))
+		return true;
+
+	/* Is there any swapcache pages to reclaim? */
+	if ((!memcg && total_swapcache_pages() > 0) ||
+	    (memcg && mem_cgroup_get_nr_swapcache_pages(memcg) > 0)) {
+		if (sc)
+			sc->swapcache_only = 1;
+		return true;
+	}
+
+	return false;
 }
 
 /*
@@ -1642,6 +1654,15 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		 */
 		scan += nr_pages;
 
+		/*
+		 * Count non-swapcache too because the swapcache pages may
+		 * be rare and it takes too much times here if not count
+		 * the non-swapcache pages.
+		 */
+		if (unlikely(sc->swapcache_only && !is_file_lru(lru) &&
+		    !folio_test_swapcache(folio)))
+			goto move;
+
 		if (!folio_test_lru(folio))
 			goto move;
 		if (!sc->may_unmap && folio_mapped(folio))
-- 
2.25.1

