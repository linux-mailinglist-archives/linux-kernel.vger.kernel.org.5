Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D87F26F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjKUIIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUIIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:08:13 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D70BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:08:08 -0800 (PST)
Received: from dggpemd200004.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SZH3B6frYz1P8cb;
        Tue, 21 Nov 2023 16:04:38 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemd200004.china.huawei.com
 (7.185.36.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Tue, 21 Nov
 2023 16:08:05 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
Date:   Tue, 21 Nov 2023 17:06:24 +0800
Message-ID: <20231121090624.1814733-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
v9->v10: Use per-node swapcache suggested by Yu Zhao.
v8->v9: Move the swapcache check after can_demote() and refector 
	can_reclaim_anon_pages() a bit.
v7->v8: Reset swapcache_only at the beginning of can_reclaim_anon_pages().
v6->v7: Reset swapcache_only to zero after there are swap spaces.
v5->v6: Fix NULL pointing derefence and hung task problem reported by Sachin.

 mm/vmscan.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 506f8220c5fe..1fcc94717370 100644
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
 
@@ -308,10 +311,36 @@ static bool can_demote(int nid, struct scan_control *sc)
 	return true;
 }
 
+#ifdef CONFIG_SWAP
+static bool can_reclaim_swapcache(struct mem_cgroup *memcg, int nid)
+{
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	unsigned long nr_swapcache;
+
+	if (!memcg) {
+		nr_swapcache = node_page_state(pgdat, NR_SWAPCACHE);
+	} else {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+
+		nr_swapcache = lruvec_page_state_local(lruvec, NR_SWAPCACHE);
+	}
+
+	return nr_swapcache > 0;
+}
+#else
+static bool can_reclaim_swapcache(struct mem_cgroup *memcg, int nid)
+{
+	return false;
+}
+#endif
+
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 					  int nid,
 					  struct scan_control *sc)
 {
+	if (sc)
+		sc->swapcache_only = 0;
+
 	if (memcg == NULL) {
 		/*
 		 * For non-memcg reclaim, is there
@@ -330,7 +359,17 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 	 *
 	 * Can it be reclaimed from this node via demotion?
 	 */
-	return can_demote(nid, sc);
+	if (can_demote(nid, sc))
+		return true;
+
+	/* Is there any swapcache pages to reclaim in this node? */
+	if (can_reclaim_swapcache(memcg, nid)) {
+		if (sc)
+			sc->swapcache_only = 1;
+		return true;
+	}
+
+	return false;
 }
 
 /*
@@ -1642,6 +1681,15 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
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

