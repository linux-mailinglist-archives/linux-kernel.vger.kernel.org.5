Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970DC7A1798
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjIOHku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjIOHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:40:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CB98
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:40:43 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rn5bh47ktztSrF;
        Fri, 15 Sep 2023 15:36:32 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 15 Sep
 2023 15:40:40 +0800
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
Subject: [PATCH v6] mm: vmscan: try to reclaim swapcache pages if no swap space
Date:   Fri, 15 Sep 2023 16:34:17 +0800
Message-ID: <20230915083417.3190512-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v5->v6: Fix NULL pointing derefence and hung task problem reported by Sachin.

 include/linux/swap.h |  6 ++++++
 mm/memcontrol.c      |  8 ++++++++
 mm/vmscan.c          | 24 ++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 493487ed7c38..19f30a29e1f1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -658,6 +658,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
 }
 
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
+extern long mem_cgroup_get_nr_swapcache_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct folio *folio);
 #else
 static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
@@ -680,6 +681,11 @@ static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
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
index 34bae9e63ff2..26ae2e08fd9a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7573,6 +7573,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
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
index 3df0e2a59052..48c092cc6088 100644
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
 
@@ -319,10 +322,22 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 		 */
 		if (get_nr_swap_pages() > 0)
 			return true;
+		/* Is there any swapcache pages to reclaim? */
+		if (total_swapcache_pages() > 0) {
+			if (sc)
+				sc->swapcache_only = 1;
+			return true;
+		}
 	} else {
 		/* Is the memcg below its swap limit? */
 		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
 			return true;
+		/* Is there any swapcache pages in memcg to reclaim? */
+		if (mem_cgroup_get_nr_swapcache_pages(memcg) > 0) {
+			if (sc)
+				sc->swapcache_only = 1;
+			return true;
+		}
 	}
 
 	/*
@@ -1642,6 +1657,15 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
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

