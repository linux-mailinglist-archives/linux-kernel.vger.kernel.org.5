Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216337A965C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjIURC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjIURCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:02:06 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536381718
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:59:35 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230921061946epoutp032662f0eb0f4f74624200f5879a8193f6~G1Z5zFATZ0935509355epoutp03S
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 06:19:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230921061946epoutp032662f0eb0f4f74624200f5879a8193f6~G1Z5zFATZ0935509355epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695277186;
        bh=0Zxt+m+/iw1yKBopL/xFUFW5MptDCFQTFwP3AhppyOY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Vnuxlz+jmYOwJQSN7rTpgDst0u+eLD8N+8a0tqHQIGSvLIk4U2XT1HBbnJ7iq6lDM
         t309spe8/kFC/XM8PHHWX6HVZCSYWoyU49z7WNbqEzeRZ9DU5mZMvQEEC0WmUZJKPb
         DSZz85gOLNk+zmlCN8si0gXqJu/IIEWHQuPrjM6E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230921061945epcas1p1186d256be4b9d290dda3b1408ac14a35~G1Z5TSyG60965009650epcas1p1t;
        Thu, 21 Sep 2023 06:19:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.223]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RrlcK2gdjz4x9Q3; Thu, 21 Sep
        2023 06:19:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.E9.10012.180EB056; Thu, 21 Sep 2023 15:19:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f~G1Z4kfhwH0410304103epcas1p2E;
        Thu, 21 Sep 2023 06:19:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230921061944epsmtrp2ac12d2c49dd394b444e84e6ee537632f~G1Z4jmSC-0762207622epsmtrp29;
        Thu, 21 Sep 2023 06:19:44 +0000 (GMT)
X-AuditID: b6c32a35-50fff7000000271c-91-650be081c968
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.02.08742.080EB056; Thu, 21 Sep 2023 15:19:44 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230921061944epsmtip185f493ca9c43ba7d268ba45508fee6ef~G1Z4YHAxs2652326523epsmtip1W;
        Thu, 21 Sep 2023 06:19:44 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rostedt@goodmis.org, yuzhao@google.com, tjmercier@google.com,
        kaleshsingh@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2] vmscan: add trace events for lru_gen
Date:   Thu, 21 Sep 2023 15:22:06 +0900
Message-Id: <20230921062206.14429-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmnm7jA+5Ug/+NQhZz1q9hs1i9ydei
        e/NMRove96+YLJr2zWS3uLxrDpvFvTX/WS2OrD/LYrGv4wGTxbv1X9gsZjf2MVq8m/CF1YHH
        4/Cb98weO2fdZfdo2XeL3WPBplKPTZ8msXucmPGbxaNvyypGjzMLjrB7fN4kF8AZlW2TkZqY
        klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SxkkJZYk4pUCgg
        sbhYSd/Opii/tCRVISO/uMRWKbUgJafArECvODG3uDQvXS8vtcTK0MDAyBSoMCE749udNywF
        fx0rjvZ+Y29gXGbexcjJISFgIjFrxm32LkYuDiGBHYwSB69fgnI+MUqsuL+BGcL5xiixedYc
        NpiWG69eQlXtZZT48v41I4TznVHi8ebVjCBVbALaEu8XTGIFSYgIzGaUOHvqOwuIwwzivN9w
        CWyWsICFRPf6/+wgNouAqsTj+dPA4rwCthJvL7xhhtgnL7F6wwEo+yu7xNkmGwjbReLutyWM
        ELawxKvjW9ghbCmJz+/2Qt2aL3Hh4iumLkYOILtGYuFEQ4iwvcSurzNYQcLMApoS63fpQ4QV
        JXb+ngs2kVmAT+Ld1x5WiE5eiY42IYgSNYmWZ19ZIWwZib//nkHZHhKzX91mArGFBGIlJr5+
        yDiBUXYWwoIFjIyrGMVSC4pz01OLDQsM4bGUnJ+7iRGcCrVMdzBOfPtB7xAjEwfjIUYJDmYl
        Ed7kT1ypQrwpiZVVqUX58UWlOanFhxhNgaE1kVlKNDkfmIzzSuINTSwNTMyMTCyMLY3NlMR5
        mR/1pggJpCeWpGanphakFsH0MXFwSjUwGYfZ1bzlXOJ9Zt+Tfq/LK7kmaF8wNfScvoX9nZtn
        9tamaJ+TuxPnN5bf38e5wteufu93l6CpE6T8NENVxDc2v5Y94P58z3WGLi/73ELvnfsf/jFq
        3xJc8OSXB2vAA6ldx2VOCRSeOWRxTvr0V0/mox7Fl6YrRbm+miC+SPy5wh1VbT7F8uoNRgtl
        ddjXvcuW3yos+kFdUHTbyvLFz/maWdNPBB/1YV61ujtvWVtz5HrnV2uSPkbNn+jXGqvfuv5j
        t4Cr4r5F09WypnTJVDKatf1ZEqg/5+O5TUlbS847ZpyunypexSwbkXPy06FnkVvmz9v2ZPoR
        j8TDmgHBjzIzf0rckJp/zvnULeZ/d699VGIpzkg01GIuKk4EALWaihYOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnG7DA+5Ug+MnjS3mrF/DZrF6k69F
        9+aZjBa9718xWTTtm8lucXnXHDaLe2v+s1ocWX+WxWJfxwMmi3frv7BZzG7sY7R4N+ELqwOP
        x+E375k9ds66y+7Rsu8Wu8eCTaUemz5NYvc4MeM3i0ffllWMHmcWHGH3+LxJLoAzissmJTUn
        syy1SN8ugSvj2503LAV/HSuO9n5jb2BcZt7FyMkhIWAicePVS3YQW0hgN6PEubcGEHEZiTfn
        n7J0MXIA2cIShw8XdzFyAZV8ZZQ4//MmI0gNm4C2xPsFk1hBEiICixklHl9rYwVJMAvMZ5R4
        MCUAxBYWsJDoXv8fbAGLgKrE4/nT2EBsXgFbibcX3jBDLJOXWL3hAPMERp4FjAyrGCVTC4pz
        03OLDQsM81LL9YoTc4tL89L1kvNzNzGCQ1NLcwfj9lUf9A4xMnEwHmKU4GBWEuFN/sSVKsSb
        klhZlVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTqoFJcqHLrsKXZz79
        /tq4oSr2Fc+S1nK9O84F4XouHkb/f2Vt5nnd4hNiYbjpT8kUldvTr0zV4NoYV/GcefKfTI7W
        eddcykx8jVbfXqD3/V7i3h3x7T394u11RVw33T5O7Aje/oH7aam18B+vTwU8r9pnW4UeCz9e
        Mlc/3nhDktn1Ezfy5OQDym6v21z/MyFEY6aNtZp2kka3Oh/nXtv6Ze+Ez+gYb7hU8m1upTD7
        1ymOl87I8fYdnqk+z6D1YuKWmQcFRRcfY3v5Wm4LN992l8vfZKq3/b1ecNU7ZGWztOn2h/P5
        DA6xT50/58Vf48BLJ+1yQ3hs/rzf07Zw0nQeGY9/az8wlh82mVtx4evjgFldSizFGYmGWsxF
        xYkA6MA8NrwCAAA=
X-CMS-MailID: 20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f
References: <CGME20230921061944epcas1p2f8a022282709da12840b33c0f5898b5f@epcas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the legacy lru provides, the lru_gen needs some trace events for
debugging.

This commit introduces 2 trace events.
  trace_mm_vmscan_lru_gen_scan
  trace_mm_vmscan_lru_gen_evict

Each event is similar to the following legacy events.
  trace_mm_vmscan_lru_isolate,
  trace_mm_vmscan_lru_shrink_[in]active

Here's an example
  mm_vmscan_lru_gen_scan: isolate_mode=0 classzone=1 order=9 nr_requested=4096 nr_scanned=431 nr_skipped=0 nr_taken=55 lru=anon
  mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=42 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=13 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
  mm_vmscan_lru_gen_scan: isolate_mode=0 classzone=1 order=9 nr_requested=4096 nr_scanned=66 nr_skipped=0 nr_taken=64 lru=file
  mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=62 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=2 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
v2: use condition and make it aligned
v1: introduce trace events
---
 include/trace/events/mmflags.h |  5 ++
 include/trace/events/vmscan.h  | 98 ++++++++++++++++++++++++++++++++++
 mm/vmscan.c                    | 17 ++++--
 3 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 1478b9dd05fa..44e9b38f83e7 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -274,6 +274,10 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 		EM (LRU_ACTIVE_FILE, "active_file") \
 		EMe(LRU_UNEVICTABLE, "unevictable")
 
+#define LRU_GEN_NAMES		\
+		EM (LRU_GEN_ANON, "anon") \
+		EMe(LRU_GEN_FILE, "file")
+
 /*
  * First define the enums in the above macros to be exported to userspace
  * via TRACE_DEFINE_ENUM().
@@ -288,6 +292,7 @@ COMPACTION_PRIORITY
 /* COMPACTION_FEEDBACK are defines not enums. Not needed here. */
 ZONE_TYPE
 LRU_NAMES
+LRU_GEN_NAMES
 
 /*
  * Now redefine the EM() and EMe() macros to map the enums to the strings
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index d2123dd960d5..f0c3a4bd72db 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -327,6 +327,57 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__print_symbolic(__entry->lru, LRU_NAMES))
 );
 
+TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
+	TP_PROTO(int highest_zoneidx,
+		int order,
+		unsigned long nr_requested,
+		unsigned long nr_scanned,
+		unsigned long nr_skipped,
+		unsigned long nr_taken,
+		isolate_mode_t isolate_mode,
+		int lru),
+
+	TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
+
+	TP_CONDITION(nr_scanned),
+
+	TP_STRUCT__entry(
+		__field(int, highest_zoneidx)
+		__field(int, order)
+		__field(unsigned long, nr_requested)
+		__field(unsigned long, nr_scanned)
+		__field(unsigned long, nr_skipped)
+		__field(unsigned long, nr_taken)
+		__field(unsigned int, isolate_mode)
+		__field(int, lru)
+	),
+
+	TP_fast_assign(
+		__entry->highest_zoneidx = highest_zoneidx;
+		__entry->order = order;
+		__entry->nr_requested = nr_requested;
+		__entry->nr_scanned = nr_scanned;
+		__entry->nr_skipped = nr_skipped;
+		__entry->nr_taken = nr_taken;
+		__entry->isolate_mode = (__force unsigned int)isolate_mode;
+		__entry->lru = lru;
+	),
+
+	/*
+	 * classzone is previous name of the highest_zoneidx.
+	 * Reason not to change it is the ABI requirement of the tracepoint.
+	 */
+	TP_printk("isolate_mode=%d classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
+		__entry->isolate_mode,
+		__entry->highest_zoneidx,
+		__entry->order,
+		__entry->nr_requested,
+		__entry->nr_scanned,
+		__entry->nr_skipped,
+		__entry->nr_taken,
+		__print_symbolic(__entry->lru, LRU_GEN_NAMES))
+);
+
 TRACE_EVENT(mm_vmscan_write_folio,
 
 	TP_PROTO(struct folio *folio),
@@ -437,6 +488,53 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
 
+TRACE_EVENT(mm_vmscan_lru_gen_evict,
+
+	TP_PROTO(int nid, unsigned long nr_reclaimed,
+		struct reclaim_stat *stat, int priority, int file),
+
+	TP_ARGS(nid, nr_reclaimed, stat, priority, file),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, nr_reclaimed)
+		__field(unsigned long, nr_dirty)
+		__field(unsigned long, nr_writeback)
+		__field(unsigned long, nr_congested)
+		__field(unsigned long, nr_immediate)
+		__field(unsigned int, nr_activate0)
+		__field(unsigned int, nr_activate1)
+		__field(unsigned long, nr_ref_keep)
+		__field(unsigned long, nr_unmap_fail)
+		__field(int, nid)
+		__field(int, priority)
+		__field(int, reclaim_flags)
+	),
+
+	TP_fast_assign(
+		__entry->nid = nid;
+		__entry->nr_reclaimed = nr_reclaimed;
+		__entry->nr_dirty = stat->nr_dirty;
+		__entry->nr_writeback = stat->nr_writeback;
+		__entry->nr_congested = stat->nr_congested;
+		__entry->nr_immediate = stat->nr_immediate;
+		__entry->nr_activate0 = stat->nr_activate[0];
+		__entry->nr_activate1 = stat->nr_activate[1];
+		__entry->nr_ref_keep = stat->nr_ref_keep;
+		__entry->nr_unmap_fail = stat->nr_unmap_fail;
+		__entry->priority = priority;
+		__entry->reclaim_flags = trace_reclaim_flags(file);
+	),
+
+	TP_printk("nid=%d nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
+		__entry->nid, __entry->nr_reclaimed,
+		__entry->nr_dirty, __entry->nr_writeback,
+		__entry->nr_congested, __entry->nr_immediate,
+		__entry->nr_activate0, __entry->nr_activate1,
+		__entry->nr_ref_keep, __entry->nr_unmap_fail,
+		__entry->priority,
+		show_reclaim_flags(__entry->reclaim_flags))
+);
+
 TRACE_EVENT(mm_vmscan_node_reclaim_begin,
 
 	TP_PROTO(int nid, int order, gfp_t gfp_flags),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..f453a0f8ceef 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5005,6 +5005,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	int sorted = 0;
 	int scanned = 0;
 	int isolated = 0;
+	int skipped = 0;
 	int remaining = MAX_LRU_BATCH;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
@@ -5018,7 +5019,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 	for (i = MAX_NR_ZONES; i > 0; i--) {
 		LIST_HEAD(moved);
-		int skipped = 0;
+		int skipped_zone = 0;
 		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
 
@@ -5040,16 +5041,17 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 				isolated += delta;
 			} else {
 				list_move(&folio->lru, &moved);
-				skipped += delta;
+				skipped_zone += delta;
 			}
 
-			if (!--remaining || max(isolated, skipped) >= MIN_LRU_BATCH)
+			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
 				break;
 		}
 
-		if (skipped) {
+		if (skipped_zone) {
 			list_splice(&moved, head);
-			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
+			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
+			skipped += skipped_zone;
 		}
 
 		if (!remaining || isolated >= MIN_LRU_BATCH)
@@ -5065,6 +5067,9 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	__count_memcg_events(memcg, PGREFILL, sorted);
 	__count_vm_events(PGSCAN_ANON + type, isolated);
 
+	trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
+			scanned, skipped, isolated,
+			sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -5194,6 +5199,8 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
 	sc->nr_reclaimed += reclaimed;
+	trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
+				      sc->priority, type);
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
 		if (!folio_evictable(folio)) {
-- 
2.17.1

