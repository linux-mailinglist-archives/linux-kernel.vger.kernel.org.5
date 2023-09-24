Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1235F7AC9F5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjIXOVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIXOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:21:42 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119EFA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:21:35 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230924142132epoutp024e8494fa14b6c019da7bdf49b4f2b31e~H26ZRw-Vg3021330213epoutp02f
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:21:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230924142132epoutp024e8494fa14b6c019da7bdf49b4f2b31e~H26ZRw-Vg3021330213epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695565292;
        bh=QEicMqNuN7bn1MHkfHwxbR0eP3CwvKShNFQ9U6xbf7M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QCxcniaqvnVxWXNfLdYewz/oYi3XIjmrHr/xqIrmYO1YvVe+0jeNmwKGC0EY8e7Vo
         7mWQVL1iAM503YRsuCH0UUNa9PJu/MCgxY9eUVZWNOxUqVyFTbd9wEAIJ23YyG/JE0
         ///IUsuzOjiujOut+GSoman/LH1/eiGll0tLrDmU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230924142130epcas1p1967142e4e4ae215dabdd76ed3162d9de~H26XxHsQ72010920109epcas1p1a;
        Sun, 24 Sep 2023 14:21:30 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Rtp8p0nNvz4x9Pp; Sun, 24 Sep
        2023 14:21:30 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.C4.10012.9E540156; Sun, 24 Sep 2023 23:21:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230924142129epcas1p4ae9161f7c20ea16408ccc8296f81104a~H26W29b351672216722epcas1p4H;
        Sun, 24 Sep 2023 14:21:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230924142129epsmtrp2a4efbcf4dc5dc390a40927e0fbfd1da2~H26WzgAkn3064130641epsmtrp2U;
        Sun, 24 Sep 2023 14:21:29 +0000 (GMT)
X-AuditID: b6c32a35-50fff7000000271c-35-651045e9209c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.F1.08742.9E540156; Sun, 24 Sep 2023 23:21:29 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230924142129epsmtip1adf6efda46856bb91c6d469237aaa95a~H26WgvZca0839008390epsmtip1R;
        Sun, 24 Sep 2023 14:21:29 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rostedt@goodmis.org, tjmercier@google.com, yuzhao@google.com,
        kaleshsingh@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v3] vmscan: add trace events for lru_gen
Date:   Sun, 24 Sep 2023 23:23:43 +0900
Message-Id: <20230924142343.23924-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmvu5LV4FUgy+HLSzmrF/DZrF6k69F
        9+aZjBa9718xWTTtm8lucXnXHDaLe2v+s1ocWX+WxWJfxwMmi3frv7BZzG7sY7R4N+ELqwOP
        x+E375k9ds66y+7Rsu8Wu8eCTaUemz5NYvc4MeM3i0ffllWMHmcWHGH3+LxJLoAzKtsmIzUx
        JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
        YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BWYFecWJucWleul5eaomVoYGBkSlQYUJ2RveVSawF
        rc4V3y80MDUwzrPoYuTkkBAwkdi3chlTFyMXh5DADkaJg5v3MEM4nxglJt79xAbhfGOUWL2x
        nwWm5d7501AtexklWroaoaq+M0oseHOJGaSKTUBb4v2CSawgCRGB2YwSr3Z8YQRxmEGc9xsu
        sYFUCQtYSKxfc5cRxGYRUJXYvngXUAcHB6+ArcStF5UQ6+QlVm84AHaUhMBHdonJ9zdA3eEi
        8f3/OWYIW1ji1fEt7BC2lMTnd3vZIOx8iQsXXzGBzJQQqJFYONEQImwvsevrDLBVzAKaEut3
        6UOEFSV2/p4Ldg2zAJ/Eu689rBCdvBIdbUIQJWoSLc++skLYMhJ//z2Dsj0kLnYuBVsqJBAr
        cfX/Q+YJjLKzEBYsYGRcxSiWWlCcm55abFhgCI+l5PzcTYzgVKhluoNx4tsPeocYmTgYDzFK
        cDArifD+esaXKsSbklhZlVqUH19UmpNafIjRFBhaE5mlRJPzgck4ryTe0MTSwMTMyMTC2NLY
        TEmcl/lRb4qQQHpiSWp2ampBahFMHxMHp1QD0wX3l8ZOzPsFX/G43rTep5OwhXeKjv8yo1+7
        W+KnMDKHJJ7TLV5S0F/GKqF+/sQOtTLr+wksNc1u76YFpq9IkZqdsPszdx3fmgfc6rkK8iv/
        LalyzwkIKlngPUlv/t7VG65lm33eZRO6OKBBvz1FryXj8d0n0od4zI7oTEmby/F33+0Hn1Im
        RH9dvY5r6QyDuQv4Di/xjpximxo8sUXohY+7ov9m1+aFPbzh/ySOxM7m0/y1wluru7Yj5MA8
        K3uT6VMSBabIbijI2nLO/n+y1OnuVVIMNbJrj0xu4C2YnmmQrHqmz3e588mod4wvDC8ZrokN
        yCkNNKubzvj5Wy1HaErByo1pRb7fXaWmf1mixFKckWioxVxUnAgAvmV7/A4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO5LV4FUgw2r+S3mrF/DZrF6k69F
        9+aZjBa9718xWTTtm8lucXnXHDaLe2v+s1ocWX+WxWJfxwMmi3frv7BZzG7sY7R4N+ELqwOP
        x+E375k9ds66y+7Rsu8Wu8eCTaUemz5NYvc4MeM3i0ffllWMHmcWHGH3+LxJLoAzissmJTUn
        syy1SN8ugSuj+8ok1oJW54rvFxqYGhjnWXQxcnJICJhI3Dt/mqmLkYtDSGA3o8Tb3a2MEAkZ
        iTfnn7J0MXIA2cIShw8XQ9R8ZZQ49uEwWA2bgLbE+wWTWEESIgKLGSUuvZkDlmAWmM8o8WBK
        AIgtLGAhsX7NXbA4i4CqxPbFu1hBhvIK2ErcelEJsUteYvWGA8wTGHkWMDKsYpRMLSjOTc8t
        NiwwzEst1ytOzC0uzUvXS87P3cQIDk0tzR2M21d90DvEyMTBeIhRgoNZSYT31zO+VCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2CyTBycUg1MB7/t/ri1+rzXszfq
        l4zud2fdqrAIyHCOUqwTWiOaEVIWWvDOY32n8udibj5nr54v1zftF89nuhV20e90XJcWR+Sh
        rc1P7S0mv9pU6fXl4yXl9MRwJ50n7H/WvlI51bi24hNrV94phm6R/J3by/cEaKoczXF3sd34
        Zo2/bEKRo9la57I11xatZQ1W2Wf++W+xSLqFTcfG9i4P5fIVywrT+dkrPbyfRc9+9LQ+O/36
        I9YtJdFHinXX+K4+XG6WL1++QUOKb5dpuIRIRMWPle9KXswSecl3/6wbl2hX8MYLlwo4mxL8
        Go8eTxKSvl1/3UcjVnLRlfm75l5+vM7k6NT61wrJzj7xyWlacl1PfyuxFGckGmoxFxUnAgAi
        0LymvAIAAA==
X-CMS-MailID: 20230924142129epcas1p4ae9161f7c20ea16408ccc8296f81104a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230924142129epcas1p4ae9161f7c20ea16408ccc8296f81104a
References: <CGME20230924142129epcas1p4ae9161f7c20ea16408ccc8296f81104a@epcas1p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
v3: change printk format
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
index d2123dd960d5..12eee5558016 100644
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
+	TP_printk("isolate_mode=%u classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
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
+	TP_printk("nid=%d nr_reclaimed=%lu nr_dirty=%lu nr_writeback=%lu nr_congested=%lu nr_immediate=%lu nr_activate_anon=%u nr_activate_file=%u nr_ref_keep=%lu nr_unmap_fail=%lu priority=%d flags=%s",
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

