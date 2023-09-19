Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141FD7A5786
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjISCur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjISCuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:50:44 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A8CF1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:50:17 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230919025014epoutp04fc9e49488857be2c12651cb6f0ac8c1e~GLQYiA_Ya2029720297epoutp04u
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:50:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230919025014epoutp04fc9e49488857be2c12651cb6f0ac8c1e~GLQYiA_Ya2029720297epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695091814;
        bh=9jcgVQ9/Vy4rgPcHA2K4bULFNUVZ7k5qvpDxYSsonyk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Fnw+LU7Z0P7fr7WH90cXd7xSeXICaS52WeUPoN/Pws8stWQVdUOFPXBzeFcguSCKy
         VF7CVIeB/GQn5yuOJ3NEA+uzfKorEshcOHjbrODS7KvFxgVyhPIu9XnBLoOtMq3llm
         FvRpSMBJML6/UW8vqI1rUnB1TQMuOQroMZF8UL54=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230919025013epcas1p3873684b9a01d3e69a6c0a530e4a5077b~GLQYCdLVu0992609926epcas1p3D;
        Tue, 19 Sep 2023 02:50:13 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.249]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RqR3T1F8Xz4x9QH; Tue, 19 Sep
        2023 02:50:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.58.09646.56C09056; Tue, 19 Sep 2023 11:50:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b~GLQXTVIVa0873908739epcas1p2w;
        Tue, 19 Sep 2023 02:50:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230919025012epsmtrp13419a69236794c20e47eb5c1241d9c97~GLQXSqjTd1905219052epsmtrp1K;
        Tue, 19 Sep 2023 02:50:12 +0000 (GMT)
X-AuditID: b6c32a37-d85fa700000025ae-52-65090c653e3e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.C3.08788.46C09056; Tue, 19 Sep 2023 11:50:12 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230919025012epsmtip2fcdba120b5ee91ab61c5cfa1b8ec3dca~GLQXEjnj42186121861epsmtip2X;
        Tue, 19 Sep 2023 02:50:12 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     yuzhao@google.com, tjmercier@google.com, kaleshsingh@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] vmscan: add trace events for lru_gen
Date:   Tue, 19 Sep 2023 11:52:16 +0900
Message-Id: <20230919025216.1878-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmnm4qD2eqwZt/LBZz1q9hs1i9ydei
        e/NMRove96+YLJr2zWS3uLxrDpvFvTX/WS2OrD/LYvFu/Rc2i9mNfYwW7yZ8YXXg9jj85j2z
        x85Zd9k9Fmwq9dj0aRK7x4kZv1k8+rasYvQ4s+AIu8fnTXIBHFHZNhmpiSmpRQqpecn5KZl5
        6bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAdyoplCXmlAKFAhKLi5X07WyK8ktL
        UhUy8otLbJVSC1JyCswK9IoTc4tL89L18lJLrAwNDIxMgQoTsjMuLPzFVLDAsaJnnXYD4zWz
        LkZODgkBE4nFX66ydDFycQgJ7GCU2LenBcr5xChxsesclPONUaLxSzM7TMu/Z+dZQWwhgb2M
        End2GUAUfWeUaJiyByzBJqAt8X7BJFaQhIhAC6PEou1H2UEcZoHZjBLvN1xiA6kSFjCVWNq6
        EsxmEVCVOHr3BtgKXgEbiZPvL7JCrJOXWL3hADNIs4TAI3aJ/70r2CASLhIvbs+DKhKWeHV8
        C9R9UhIv+9ug7HyJCxdfMXUxcgDZNRILJxpChO0ldn2dwQoSZhbQlFi/Sx8irCix8/dcRhCb
        WYBP4t3XHlaITl6JjjYhiBI1iZZnX6GWykj8/fcMqsRDYtsGRkiYxErsf3CPfQKj7CyE+QsY
        GVcxiqUWFOempxYbFhjD4yg5P3cTIzjlaZnvYJz29oPeIUYmDsZDjBIczEoivDMN2VKFeFMS
        K6tSi/Lji0pzUosPMZoCQ2sis5Rocj4w6eaVxBuaWBqYmBmZWBhbGpspifPeetabIiSQnliS
        mp2aWpBaBNPHxMEp1cCUPS8ysjxxMZdV+/r5R3+fV+tOVNxeotYUki7WKWP9J1O3mjeMsfi0
        8YlmJwsN3lQ2i7yeZ+VOfqZ7H304K8OwVfiry4szR7jWsH1ceX1llNuMW+oz93JcVb9ipNm1
        49+mBp2Y5W0zwpynGKt1beWqtb4oKPOw/bu3zMLZPyriF631OhXbaW2zqPWETcubdbWGEX83
        lac9/Xb9Xck3rYD12zL2REh1/LQJ7FeKejRzs34cc8WVVi5Dkd/6TveE5+TWecbkyGSm8V38
        fkCCl3lh9owd3v97gkvu2Tg+Ut0pkDB3xQRTc8Yk2yObvs+Sutqi3K3Co2Mts36CaKAF6xSW
        mQzrmmK2iF63yntrosRSnJFoqMVcVJwIAKvltScCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSvG4KD2eqwfoD6hZz1q9hs1i9ydei
        e/NMRove96+YLJr2zWS3uLxrDpvFvTX/WS2OrD/LYvFu/Rc2i9mNfYwW7yZ8YXXg9jj85j2z
        x85Zd9k9Fmwq9dj0aRK7x4kZv1k8+rasYvQ4s+AIu8fnTXIBHFFcNimpOZllqUX6dglcGRcW
        /mIqWOBY0bNOu4HxmlkXIyeHhICJxL9n51m7GLk4hAR2M0q0HNrHBJGQkXhz/ilLFyMHkC0s
        cfhwMUTNV0aJmw82soLUsAloS7xfMAmsWUSgh1Fi1+UZjCAJZoH5jBIPpgSA2MICphJLW1ey
        gdgsAqoSR+/eYAexeQVsJE6+v8gKsUxeYvWGA8wTGHkWMDKsYpRMLSjOTc8tNiwwykst1ytO
        zC0uzUvXS87P3cQIDkMtrR2Me1Z90DvEyMTBeIhRgoNZSYR3piFbqhBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1MzvO4zDLv2fv4vP208SZju7BJqMRs
        oxlxHjtlryr85w6z3BSzhjmgMUN5IesTptwnPxmCE6dcjV3DukDo6uxJvz8sFwrjbhAtS18i
        UHdp8dzVzZ89Fuw9u7Yk/4bNS6PDZ151q/88atXkmnaGYQ9f5bOIA7N75/iv3JzmkuRqXyeY
        zyG5crXSotNRp5dzM+t6/O9u597Ayja7jL3tbAvzXCaxo7sCtkz/9ri4dcKElDq9VVvcphoa
        AMO15zX7vPtTdiXK/JZxTmvcsVB10rtXiwOS/j1ensWa9+Ll+qkrsx8Jd/xhP3VW+uXtXeVJ
        y1wOeHCI3Fo875BE5eu7X9w2d995+MI06tWb/08fPjV/rcRSnJFoqMVcVJwIAJ75EsCyAgAA
X-CMS-MailID: 20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b
References: <CGME20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/trace/events/mmflags.h |  5 ++
 include/trace/events/vmscan.h  | 96 ++++++++++++++++++++++++++++++++++
 mm/vmscan.c                    | 18 +++++--
 3 files changed, 114 insertions(+), 5 deletions(-)

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
index d2123dd960d5..e8f9d0452e89 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -327,6 +327,55 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
 		__print_symbolic(__entry->lru, LRU_NAMES))
 );
 
+TRACE_EVENT(mm_vmscan_lru_gen_scan,
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
@@ -437,6 +486,53 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
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
+		__field(int, nid)
+		__field(unsigned long, nr_reclaimed)
+		__field(unsigned long, nr_dirty)
+		__field(unsigned long, nr_writeback)
+		__field(unsigned long, nr_congested)
+		__field(unsigned long, nr_immediate)
+		__field(unsigned int, nr_activate0)
+		__field(unsigned int, nr_activate1)
+		__field(unsigned long, nr_ref_keep)
+		__field(unsigned long, nr_unmap_fail)
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
index 6f13394b112e..cc10e3fb8fa2 100644
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
 
+	if (scanned)
+		trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order,
+				MAX_LRU_BATCH, scanned, skipped, isolated,
+				sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
 	 * remaining to prevent livelock if it's not making progress.
@@ -5194,6 +5200,8 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
 	sc->nr_reclaimed += reclaimed;
+	trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
+				      sc->priority, type);
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
 		if (!folio_evictable(folio)) {
-- 
2.17.1

