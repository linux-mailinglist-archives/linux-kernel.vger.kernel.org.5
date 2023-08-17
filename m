Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A46577F1DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348773AbjHQIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbjHQIJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:09:06 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B672E48
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:09:04 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-d1-64ddd5982d36
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: [RFC v2 4/6] mm, migrc: Ajust __zone_watermark_ok() with the amount of pending folios
Date:   Thu, 17 Aug 2023 17:05:57 +0900
Message-Id: <20230817080559.43200-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817080559.43200-1-byungchul@sk.com>
References: <20230817080559.43200-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsXC9ZZnke6Mq3dTDG4dM7CYs34Nm8WLDe2M
        Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsru96yGhxvPcAk8XvH0DZOVOsLE7O
        msziwOuxYFOpx+YVWh6L97xk8ti0qpPNY9OnSeweJ2b8ZvHY+dDSY97JQI/3+66yeWz9Zefx
        eZOcx7v5b9kCeKK4bFJSczLLUov07RK4Ms4d38NesF2tYtO6o8wNjPfluxg5OCQETCTW3YyH
        Mf8vz+9i5ORgE1CXuHHjJzOILSJgJnGw9Q97FyMXB7PAMiaJuwfOsYIkhAXiJFau3sECYrMI
        qEpcfLOZHcTmFTCV+Hx1GliNhIC8xOoNB5hB5nMCDdr8VxUkLARU8mHvOqiSy2wS819zQdiS
        EgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZg+C6r/RO9g/HTheBDjAIcjEo8
        vA677qQIsSaWFVfmHmKU4GBWEuHt4b2VIsSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBA
        emJJanZqakFqEUyWiYNTqoHRa/KMqjNFu48+3V7bev8KI+vzGTdr/J5s8PHXUOR6Oaf38F1R
        xgtlCVulbZdfEpgq+3vPjYRWs8DH8/1kRPWddCbUZsXtOFJlWz3hh0D8grvXdmp7e3PY/0lb
        4uPQa3Vx1nfdQ1z/k/gXrniy5M8xDoHn51Z0Pssy2FFlcdrZpfBd0m/pk5N/KrEUZyQaajEX
        FScCAEvBO9lbAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsXC5WfdrDvj6t0Ug+db1SzmrF/DZvFiQzuj
        xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlc3/WQ0eJ47wEmi98/gLJz
        plhZnJw1mcWBz2PBplKPzSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHvJOBHu/3XWXz
        WPziA5PH1l92Hp83yXm8m/+WLYA3issmJTUnsyy1SN8ugSvj3PE97AXb1So2rTvK3MB4X76L
        kYNDQsBE4v/y/C5GTg42AXWJGzd+MoPYIgJmEgdb/7B3MXJxMAssY5K4e+AcK0hCWCBOYuXq
        HSwgNouAqsTFN5vZQWxeAVOJz1engdVICMhLrN5wgBlkPifQoM1/VUHCQkAlH/auY53AyLWA
        kWEVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYEAuq/0zcQfjl8vuhxgFOBiVeHgddt1JEWJN
        LCuuzD3EKMHBrCTC28N7K0WINyWxsiq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampB
        ahFMlomDU6qBccPd0sIrDBUHxb7I739uoXMje73U4/+m3pJes62ZHz1bt0puV/9HV9dcjm0b
        FFdHOv/Zt1r4C8/VrusTU2T0jLQ2Wis0iOekZzSevhOzy6VqgeJNsfy/D8TeT4xqqA7Rjy5/
        d+fgFctzL2q2HGXc2bKDWXzN7zcRS+MZT9ddS/8pv/sNh+0fHiWW4oxEQy3mouJEAEEGEXdE
        AgAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_MIGRC duplicates folios participated in migration to avoid TLB
flushes and provide a consistent view to CPUs that are still caching its
old mapping in TLB. However, the duplicated folios can be freed and
available right away through appropreate TLB flushes if needed.

Adjusted watermark check routine, __zone_watermark_ok(), with the number
of duplicated folios and made it perform TLB flushes and free the
duplicated folios if page allocation routine is in trouble due to memory
pressure, even more aggresively for high order allocation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm.h     |  2 ++
 include/linux/mmzone.h |  3 +++
 mm/migrate.c           | 12 ++++++++++++
 mm/page_alloc.c        | 16 ++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ceec7f3591e..9df393074e6a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3827,6 +3827,7 @@ bool migrc_try_flush_free_folios(void);
 void migrc_try_flush_free_folios_dirty(void);
 struct migrc_req *fold_ubc_nowr_to_migrc(void);
 void free_migrc_req(struct migrc_req *req);
+int migrc_pending_nr_in_zone(struct zone *z);
 
 extern atomic_t migrc_gen;
 extern struct llist_head migrc_reqs;
@@ -3842,6 +3843,7 @@ static inline bool migrc_try_flush_free_folios(void) { return false; }
 static inline void migrc_try_flush_free_folios_dirty(void) {}
 static inline struct migrc_req *fold_ubc_nowr_to_migrc(void) { return NULL; }
 static inline void free_migrc_req(struct migrc_req *req) {}
+static inline int migrc_pending_nr_in_zone(struct zone *z) { return 0; }
 #endif
 
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6d645beaf7a6..1ec79bb63ba7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -958,6 +958,9 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
+#ifdef CONFIG_MIGRC
+	atomic_t		migrc_pending_nr;
+#endif
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
diff --git a/mm/migrate.c b/mm/migrate.c
index c7b72d275b2a..badef3d89c6c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -117,9 +117,12 @@ void migrc_shrink(struct llist_head *h)
 	llist_for_each_entry_safe(p, p2, n, migrc_node) {
 		if (p->migrc_state == MIGRC_SRC_PENDING) {
 			struct pglist_data *node;
+			struct zone *zone;
 
 			node = NODE_DATA(page_to_nid(p));
+			zone = page_zone(p);
 			atomic_dec(&node->migrc_pending_nr);
+			atomic_dec(&zone->migrc_pending_nr);
 		}
 
 		if (WARN_ON(!migrc_pending(page_folio(p))))
@@ -172,6 +175,7 @@ static void migrc_expand_req(struct folio *fsrc, struct folio *fdst)
 {
 	struct migrc_req *req;
 	struct pglist_data *node;
+	struct zone *zone;
 
 	req = fold_ubc_nowr_to_migrc();
 	if (!req)
@@ -190,7 +194,9 @@ static void migrc_expand_req(struct folio *fsrc, struct folio *fdst)
 		req->last = &fsrc->page.migrc_node;
 
 	node = NODE_DATA(folio_nid(fsrc));
+	zone = page_zone(&fsrc->page);
 	atomic_inc(&node->migrc_pending_nr);
+	atomic_inc(&zone->migrc_pending_nr);
 
 	if (migrc_is_full(folio_nid(fsrc)))
 		migrc_try_flush_free_folios();
@@ -275,6 +281,12 @@ bool migrc_req_processing(void)
 {
 	return current->mreq && current->mreq_dirty;
 }
+
+int migrc_pending_nr_in_zone(struct zone *z)
+{
+	return atomic_read(&z->migrc_pending_nr);
+
+}
 #else
 static inline bool migrc_src_pending(struct folio *f) { return false; }
 static inline bool migrc_dst_pending(struct folio *f) { return false; }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c51cbdb45d86..9f791c0fa15d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3179,6 +3179,11 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	long min = mark;
 	int o;
 
+	/*
+	 * There are pages that can be freed by migrc_try_flush_free_folios().
+	 */
+	free_pages += migrc_pending_nr_in_zone(z);
+
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
@@ -4257,6 +4262,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
 
+	migrc_try_flush_free_folios();
 restart:
 	compaction_retries = 0;
 	no_progress_loops = 0;
@@ -4772,6 +4778,16 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	if (likely(page))
 		goto out;
 
+	if (order && migrc_try_flush_free_folios()) {
+		/*
+		 * Try again after freeing migrc's pending pages in case
+		 * of high order allocation.
+		 */
+		page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+		if (likely(page))
+			goto out;
+	}
+
 	alloc_gfp = gfp;
 	ac.spread_dirty_pages = false;
 
-- 
2.17.1

