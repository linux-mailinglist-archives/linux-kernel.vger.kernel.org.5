Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB297AE481
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjIZEUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjIZEUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:20:32 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CC97
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:20:24 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230926042020epoutp0103308d7c7b15788b80411a62c3e9517c~IWADhIc220572105721epoutp01g
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:20:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230926042020epoutp0103308d7c7b15788b80411a62c3e9517c~IWADhIc220572105721epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695702020;
        bh=/WmFXGg7pZUx8NFLP+AOrNmGh0qCRe9meJqBVWK1FUc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jlFIDYo2JzapBZXQlFxYHzCLS46wTWlnGfMx6Q9OtFRzA1jYDyWEQxCQFWR/unkq/
         Q6dRwcU4yHP4zvEWtveA+GtO0cTfeL850pQbJr0QbSj4oDI8a2z0Ii2jUQzrh3Z186
         nRGh/+SsanaBY6CZjL1OzZE0NQHx1lKF2lKQGWQk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230926042020epcas1p3134b9adea96fa2ada4912876dafde4d6~IWADEsMFa2349223492epcas1p3y;
        Tue, 26 Sep 2023 04:20:20 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RvmkC4Fptz4x9Q8; Tue, 26 Sep
        2023 04:20:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.2C.09567.30C52156; Tue, 26 Sep 2023 13:20:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c~IWACPlDnn2177721777epcas1p1-;
        Tue, 26 Sep 2023 04:20:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230926042019epsmtrp22e82d97492553bdf036f20248fac3c6c~IWACOxIKg2767227672epsmtrp2h;
        Tue, 26 Sep 2023 04:20:19 +0000 (GMT)
X-AuditID: b6c32a39-955f97000000255f-df-65125c031697
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.86.18916.20C52156; Tue, 26 Sep 2023 13:20:18 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230926042018epsmtip1a90d6a9fb5d350675c8749d98ccdbb68~IWAB-3M772801928019epsmtip1L;
        Tue, 26 Sep 2023 04:20:18 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rostedt@goodmis.org, tjmercier@google.com, yuzhao@google.com,
        kaleshsingh@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        hannes@cmpxchg.org, sj@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v4] vmscan: add trace events for lru_gen
Date:   Tue, 26 Sep 2023 13:22:50 +0900
Message-Id: <20230926042250.6028-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTV5c5RijVYGKrvMWc9WvYLFZv8rXo
        3jyT0aL3/Ssmi6Z9M9ktLu+aw2Zxb81/Vosj68+yWOzreMBkcfjrGyaLd+u/sFnMbuxjtHg3
        4QurA6/H4TfvmT12zrrL7tGy7xa7x4JNpR6bVnWyeWz6NInd48SM3ywefVtWMXqcWXCE3ePz
        JrkArqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg
        25UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BWYFesWJucWleel6eaklVoYGBkam
        QIUJ2RnHFhxgL2h2qJj9fhdbA+MZ0y5GTg4JAROJIwffs4PYQgI7GCXePgjvYuQCsj8xSlyZ
        9ZMVznk2ZxsrTMf5Q+cYIRI7GSXePGxlhnC+M0pcv94MNotNQFvi/YJJYO0iAqsYJS7uaGIB
        cZgFZjNKvN9wiQ2kSljAQqLv7Vwwm0VAVWL64slg3bwCNhLLdmxjh9gnL7F6wwFmCPsvu8Tp
        4zYQtovErcaTLBC2sMSr41ug6qUkPr/bywZh50tcuPiKqYuRA8iukVg40RAibC+x6+sMVpAw
        s4CmxPpd+hBhRYmdv+cygtjMAnwS7772sEJ08kp0tAlBlKhJtDz7Cg0IGYm//55B2R4SN55O
        YYYEY6zEhlsbWCYwys5CWLCAkXEVo1hqQXFuemqxYYEpPJKS83M3MYKTo5blDsbpbz/oHWJk
        4mA8xCjBwawkwvvrGV+qEG9KYmVValF+fFFpTmrxIUZTYGhNZJYSTc4Hpue8knhDE0sDEzMj
        EwtjS2MzJXHec297U4QE0hNLUrNTUwtSi2D6mDg4pRqYFLvqtE/HhKhlJd9Uz+JY8+oLq0fe
        vSrh5yzPdZ9lSb3hfHmhTHbyqrma0/dPYWQI/mJox5V38s7z6JP/YyLfuKu9C0xxZlU0vy02
        x15Wevf1WnsR/6dxwUXmS3s6532oaVeZOHd54Fzr4wEHHdRZn61LPKxl2HYk7sOKOdwX1ae3
        ZM+pa1/8a5rf68yfQgelL629fLUyb5/uW5WaDCdp11Y9uZiklvdBcyMZL747lWjgwd38NcRO
        Nkt5nuPuwAg2xaCoJpYqz7rUX3utBXQsfidnihyS69Y7Gb3aYZ276LF9+z4csPJgKj244MSr
        dWJtq6+8D1w0ZVmlf+2TOa7Jy3h7LuRM3rNPwfmeZpsSS3FGoqEWc1FxIgCJJJvbFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnC5TjFCqwb1WG4s569ewWaze5GvR
        vXkmo0Xv+1dMFk37ZrJbXN41h83i3pr/rBZH1p9lsdjX8YDJ4vDXN0wW79Z/YbOY3djHaPFu
        whdWB16Pw2/eM3vsnHWX3aNl3y12jwWbSj02repk89j0aRK7x4kZv1k8+rasYvQ4s+AIu8fn
        TXIBXFFcNimpOZllqUX6dglcGccWHGAvaHaomP1+F1sD4xnTLkZODgkBE4nzh84xdjFycQgJ
        bGeUmPx6OStEQkbizfmnLF2MHEC2sMThw8UQNV8ZJfY+vM0EUsMmoC3xfsEkVpCEiMAWRokn
        B5exgySYBeYzSjyYEgBiCwtYSPS9ncsGYrMIqEpMXzwZrIZXwEZi2Y5t7BDL5CVWbzjAPIGR
        ZwEjwypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4EDVCtrBuGz9X71DjEwcjIcYJTiYlUR4
        fz3jSxXiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgmv/s
        8V/2lf/D8tuV/E5HMu/6wmBpsNXz3XLjJIP9f7d6BmixMoTOy0hS1z9f/zZU2K1XzfyU2TnR
        e4dZz5pYtZ+TK7eIci8peWSTvjh/k+aaHWs5Fv5YY7FE4YvlhdjernJGjT83rvLc717kuU1y
        8l1PiZSfa9vc/t02il/pP/3AcWeX5gdXj3tfvJF0/rP/l45iz+4XzguNrZq7l53stf/XMJf/
        3d6nUlfkL/5+11KjpW2t82Hf+rn/mgu+yJ9Q2e+4z+C98Bf7HYev9bSWFVrt50vY/WR6xMJc
        uRderTaqyRlXbx5clzat5q+yhPzracUXWp+Z1+01uLn1ddPW8HdtnP+PZu1t7v+xc0GmnBJL
        cUaioRZzUXEiAOex+A3DAgAA
X-CMS-MailID: 20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c
References: <CGME20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c@epcas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
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
  mm_vmscan_lru_gen_scan: classzone=2 order=0 nr_requested=4096 nr_scanned=64 nr_skipped=0 nr_taken=64 lru=anon
  mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=64 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_ANON|RECLAIM_WB_ASYNC
  mm_vmscan_lru_gen_scan: classzone=1 order=0 nr_requested=4096 nr_scanned=64 nr_skipped=0 nr_taken=64 lru=file
  mm_vmscan_lru_gen_evict: nid=0 nr_reclaimed=64 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=12 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
v4: wrap with #ifdef CONFIG_LRU_GEN
v3: change printk format
v2: use condition and make it aligned
v1: introduce trace events
---
 include/trace/events/mmflags.h |  9 ++++
 include/trace/events/vmscan.h  | 96 ++++++++++++++++++++++++++++++++++
 mm/vmscan.c                    | 20 +++++--
 3 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 1478b9dd05fa..6dfe85bd4e81 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -274,6 +274,12 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 		EM (LRU_ACTIVE_FILE, "active_file") \
 		EMe(LRU_UNEVICTABLE, "unevictable")
 
+#ifdef CONFIG_LRU_GEN
+#define LRU_GEN_NAMES		\
+		EM (LRU_GEN_ANON, "anon") \
+		EMe(LRU_GEN_FILE, "file")
+#endif
+
 /*
  * First define the enums in the above macros to be exported to userspace
  * via TRACE_DEFINE_ENUM().
@@ -288,6 +294,9 @@ COMPACTION_PRIORITY
 /* COMPACTION_FEEDBACK are defines not enums. Not needed here. */
 ZONE_TYPE
 LRU_NAMES
+#ifdef CONFIG_LRU_GEN
+LRU_GEN_NAMES
+#endif
 
 /*
  * Now redefine the EM() and EMe() macros to map the enums to the strings
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index d2123dd960d5..2080ef742f89 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -327,6 +327,102 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__print_symbolic(__entry->lru, LRU_NAMES))
 );
 
+#ifdef CONFIG_LRU_GEN
+TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,
+	TP_PROTO(int highest_zoneidx,
+		int order,
+		unsigned long nr_requested,
+		unsigned long nr_scanned,
+		unsigned long nr_skipped,
+		unsigned long nr_taken,
+		int lru),
+
+	TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, lru),
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
+		__entry->lru = lru;
+	),
+
+	/*
+	 * classzone is previous name of the highest_zoneidx.
+	 * Reason not to change it is the ABI requirement of the tracepoint.
+	 */
+	TP_printk("classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
+		__entry->highest_zoneidx,
+		__entry->order,
+		__entry->nr_requested,
+		__entry->nr_scanned,
+		__entry->nr_skipped,
+		__entry->nr_taken,
+		__print_symbolic(__entry->lru, LRU_GEN_NAMES))
+);
+
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
+	TP_printk("nid=%d nr_reclaimed=%lu nr_dirty=%lu nr_writeback=%lu nr_congested=%lu nr_immediate=%lu nr_activate_anon=%u nr_activate_file=%u nr_ref_keep=%lu nr_unmap_fail=%lu priority=%d flags=%s",
+		__entry->nid, __entry->nr_reclaimed,
+		__entry->nr_dirty, __entry->nr_writeback,
+		__entry->nr_congested, __entry->nr_immediate,
+		__entry->nr_activate0, __entry->nr_activate1,
+		__entry->nr_ref_keep, __entry->nr_unmap_fail,
+		__entry->priority,
+		show_reclaim_flags(__entry->reclaim_flags))
+);
+#endif
+
 TRACE_EVENT(mm_vmscan_write_folio,
 
 	TP_PROTO(struct folio *folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..0c8b48bcb461 100644
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
@@ -5065,6 +5067,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	__count_memcg_events(memcg, PGREFILL, sorted);
 	__count_vm_events(PGSCAN_ANON + type, isolated);
 
+#ifdef CONFIG_LRU_GEN
+	trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
+			scanned, skipped, isolated, type);
+#endif
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -5194,6 +5200,10 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
 	sc->nr_reclaimed += reclaimed;
+#ifdef CONFIG_LRU_GEN
+	trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
+				      sc->priority, type);
+#endif
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
 		if (!folio_evictable(folio)) {
-- 
2.17.1

