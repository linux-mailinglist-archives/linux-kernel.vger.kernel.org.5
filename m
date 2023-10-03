Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760407B681C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240528AbjJCLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbjJCLje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:39:34 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEEE9B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:39:29 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231003113926epoutp03994d6b82e54288a7f19d973ed6f476e9~KlgcAN1C91684416844epoutp03a
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:39:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231003113926epoutp03994d6b82e54288a7f19d973ed6f476e9~KlgcAN1C91684416844epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696333166;
        bh=k2j351NRIVQaw5o8Q4hyTB1ENQEJHk6+YmVaoaUY9X0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ffSYYHcnB8VYLlKV9BHjppxv6d/Af9y5Eendw3maQUSlphr3UbSvEP0WD1pn6mV3x
         9LxT63a8R61CEMBaiWN0cocs22Fn1myuYxUv2QF8b51gLVoaipQWDXB63akwFBRI+c
         LoEhC1lKRl9BBPVzt0t2z46TDJMYAtOsMZ15BDDo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20231003113925epcas1p3319abbc47fe7591c8f78aa336aacb2c6~KlgbZ0szS1150311503epcas1p3t;
        Tue,  3 Oct 2023 11:39:25 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.222]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S0G7d3858z4x9Pq; Tue,  3 Oct
        2023 11:39:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.71.08657.D6DFB156; Tue,  3 Oct 2023 20:39:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231003113924epcas1p25751edd2f3bcbab701edd7ea9db5e4c5~KlgaQj7ct3062830628epcas1p2b;
        Tue,  3 Oct 2023 11:39:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231003113924epsmtrp1006c24c108414543543dde76802e8cff~KlgaPv7wH2168921689epsmtrp1R;
        Tue,  3 Oct 2023 11:39:24 +0000 (GMT)
X-AuditID: b6c32a33-4e9ff700000021d1-f8-651bfd6dd185
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.88.08742.C6DFB156; Tue,  3 Oct 2023 20:39:24 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.99]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231003113924epsmtip273eb99b74ecf8aa5978d95756d3070fb~KlgZ9Qh8W3008230082epsmtip2W;
        Tue,  3 Oct 2023 11:39:24 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rostedt@goodmis.org, tjmercier@google.com, yuzhao@google.com,
        kaleshsingh@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        hannes@cmpxchg.org, sj@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v5] mm: multi-gen LRU: reuse some legacy trace events
Date:   Tue,  3 Oct 2023 20:41:55 +0900
Message-Id: <20231003114155.21869-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTXzf3r3SqQd8WYYs569ewWaze5GvR
        vXkmo0Xv+1dMFk37ZrJbXN41h83i3pr/rBZH1p9lsdjX8YDJ4vDXN0wW79Z/YbOY3djHaPFu
        whdWB16Pw2/eM3vsnHWX3aNl3y12jwWbSj02repk89j0aRK7x4kZv1k8+rasYvQ4s+AIu8fn
        TXIBXFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        tysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswK9IoTc4tL89L18lJLrAwNDIxM
        gQoTsjPe3t3IXjBJqqLn1X32Bsb9ol2MnBwSAiYSJy4tYOti5OIQEtjBKLFo8QwWCOcTo8TW
        0xOZQKqEBL4xStx7bwTTcfb0VkaIor2MEv2zOpghnO+MEn8eLGIDqWIT0JZ4v2ASK0hCRGAV
        o8TFHU1gc5kFZjNKvN9wCaiKg0NYwFXi1XtFkAYWAVWJjU/vMILYvAK2Enu3/mCDWCcvsXrD
        AbANEgKNHBJXL96BSrhI3D++lh3CFpZ4dXwLlC0l8bK/DcrOl7hw8RUTyC4JgRqJhRMNIcL2
        Eru+zmAFCTMLaEqs36UPEVaU2Pl7LtgJzAJ8Eu++9rBCdPJKdLQJQZSoSbQ8+8oKYctI/P33
        DMr2kOhoucECCaxYiV3bpjBNYJSdhbBgASPjKkax1ILi3PTUZMMCQ3gkJefnbmIEJ0ct4x2M
        l+f/0zvEyMTBeIhRgoNZSYQ37KhUqhBvSmJlVWpRfnxRaU5q8SFGU2BwTWSWEk3OB6bnvJJ4
        QxNLAxMzIxMLY0tjMyVxXsUJs1OEBNITS1KzU1MLUotg+pg4OKUamOZkVXzYU7L+k6e1hqWt
        Y+4MsY3eDa/PGWqeb7OLPb3k4maloqv+aXaro349FnhrZbM4emKnZaZ9i+7rz53+PGa61zWX
        6FnPufKtybrw3g5xtrdS3zPNOHZe9LDnfKnZtG6J94MILjMb82WOOtrlx0uX/InrrJkrVGn9
        712qTcGdV9u+yBc9mHm/Q2T+RNEHO5PFU9+/Nrkwq3qhnpzr1aL3jE27rh/4uWvJiy2TDmm3
        vE1oP3ZLRGLRkYvLT92a93iv8+Wnn//diUu7tVDk6VL3cy89d7Sd9FWt3nn1n/+F/Topj2zF
        tq9as83jodbllKN7dzuXXDpkvUpsIt+VbRz5Zy1ycyVnJ97cOi0mPfKTEktxRqKhFnNRcSIA
        OGhEJxcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvG7OX+lUgyObJS3mrF/DZrF6k69F
        9+aZjBa9718xWTTtm8lucXnXHDaLe2v+s1ocWX+WxWJfxwMmi8Nf3zBZvFv/hc1idmMfo8W7
        CV9YHXg9Dr95z+yxc9Zddo+WfbfYPRZsKvXYtKqTzWPTp0nsHidm/Gbx6NuyitHjzIIj7B6f
        N8kFcEVx2aSk5mSWpRbp2yVwZby9u5G9YJJURc+r++wNjPtFuxg5OSQETCTOnt7K2MXIxSEk
        sJtRYte1l0wQCRmJN+efsnQxcgDZwhKHDxdD1HxllOjd3M0KUsMmoC3xfsEkVpCEiMAWRokn
        B5exgySYBeYzSjyYEgDSLCzgKvHqvSJImEVAVWLj0zuMIDavgK3E3q0/2CB2yUus3nCAeQIj
        zwJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMHhqqW5g3H7qg96hxiZOBgPMUpw
        MCuJ8IYdlUoV4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnV
        wKSXcby4eIrgAja+Hw9kQ1ZOrqi7u0eMv8cq78ixqxn2fkHMpbeY7Pe72hTF31A2ce9S3e97
        TM7Nk/meruqFjr0/YhS+7Sp/9XvFj+Azi6P+5Xm8Wa4W81/yp90sp6hlV/+9kp6QOK/ZJ7ej
        e83tI8Jcn9+LHf1ncObsnmWyybrh/edWyV0WMDLTdU1MNlgnyZVupmDYuC/xucJfGb4Ef7sr
        OR5v30Y9f+vfbsr1rL72vM/tGMHuuarxmSyOxdEPI5+2uPHuaTEqP+V4yqBqk27QUX7p55Mi
        tzd6rj95hfvCmamvtE0ZhM6ei1Sfoyrj3Gw8M11Cp0dVb/WJ/PuRf1ntJteetT7r9tjoCwuH
        EktxRqKhFnNRcSIAyJN4bsYCAAA=
X-CMS-MailID: 20231003113924epcas1p25751edd2f3bcbab701edd7ea9db5e4c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231003113924epcas1p25751edd2f3bcbab701edd7ea9db5e4c5
References: <CGME20231003113924epcas1p25751edd2f3bcbab701edd7ea9db5e4c5@epcas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the legacy lru provides, the mglru needs some trace events for
debugging. Let's reuse following legacy events for the mglru.

  trace_mm_vmscan_lru_isolate
  trace_mm_vmscan_lru_shrink_inactive

Here's an example
  mm_vmscan_lru_isolate: classzone=2 order=0 nr_requested=4096 nr_scanned=64 nr_skipped=0 nr_taken=64 lru=inactive_file
  mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=64 nr_reclaimed=63 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=1 nr_ref_keep=0 nr_unmap_fail=0 priority=2 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
Acked-by: Yu Zhao <yuzhao@google.com>
---
v5: reuse the legacy trace events
v4: wrap with #ifdef CONFIG_LRU_GEN
v3: change printk format
v2: use condition and make it aligned
v1: introduce trace events
---
 mm/vmscan.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..3f963f3616ea 100644
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
@@ -5064,6 +5066,9 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	__count_memcg_events(memcg, item, isolated);
 	__count_memcg_events(memcg, PGREFILL, sorted);
 	__count_vm_events(PGSCAN_ANON + type, isolated);
+	trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, MAX_LRU_BATCH,
+				scanned, skipped, isolated,
+				type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
 	/*
 	 * There might not be eligible folios due to reclaim_idx. Check the
@@ -5194,6 +5199,9 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 retry:
 	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
 	sc->nr_reclaimed += reclaimed;
+	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
+			scanned, reclaimed, &stat, sc->priority,
+			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
 
 	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
 		if (!folio_evictable(folio)) {
-- 
2.17.1

