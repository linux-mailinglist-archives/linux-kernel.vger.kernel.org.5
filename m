Return-Path: <linux-kernel+bounces-28725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4DA830244
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33E2284CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1175E14003;
	Wed, 17 Jan 2024 09:25:39 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C208821;
	Wed, 17 Jan 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483538; cv=none; b=rj5q5tijtwWXAFOaErSsseDr+Z6+Gio7UFgidueYXWNuNIn4S9/hdmT2YMG5pTrTl+UcKdoIz9f8ZFCemdtVb7PN/snmzYeBH2yDfkB7UEO0QyEuagdGzsq+6GnVJR1d8qtyMQWp+6YiGBvEZUdr7/azTFcJRBGbut8S9jZBeh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483538; c=relaxed/simple;
	bh=5kgnAlvlBsiiZ9hTQj2WHgZnMlxZblSiJVehmmU3CLY=;
	h=Received:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-MAIL; b=qjhWvArd9hLWLfU2uZVQG7UTO75i2u+8oROACPURH6BBtscZsYxJ4hjV36gRF9wobkbxTw/ZqngRrXirztki8w4W3G0BQILS+8MNrUuA+XPFZ/teWUcenM1Ib0XQqgfo0g/zFW20K13dGiGt/qAHsbLmzx719IpO5Hd8HKUmauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40H9Nr92093466;
	Wed, 17 Jan 2024 17:23:53 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TFKy31gghz2RN2qm;
	Wed, 17 Jan 2024 17:16:43 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 17 Jan 2024 17:23:51 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [RFC PATCH 1/1] block: introduce activity based ioprio
Date: Wed, 17 Jan 2024 17:23:48 +0800
Message-ID: <20240117092348.2873928-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40H9Nr92093466

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

This commit try to introduce a feature which adjust the request ioprio
based on the folio's activity. The original idea comes from LRU_GEN
which provides more precised folio activity than before. This commit try
to adjust the request's ioprio when certain part of its folios are hot,
which indicate that this request carry important contents and need be
scheduled ealier.

This commit is tested via bellowing script[1] on a v6.6 android system and
get better iowait result[2] when mglru enabled, where
1. fault_latency.bin is an ebpf based test result which measure all task's
   iowait latency when scheduled in/out.
2. costmem generate page fault by mmaping a file and access the VA.
3. dd generate concurrent vfs io.

[1]
/fault_latency.bin 1 5 > /data/dd_costmem &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
dd if=/dev/block/sda of=/data/ddtest bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest1 bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest2 bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest3 bs=1024 count=2048000

[2]
mainline:
Summary for 5932.00(ms)
    All Faults:       1398   235.67 counts/sec
        Iowait:        553    93.22 counts/sec
   All latency:    7432948  1253.03 us/ms
        Iowait:    1321971   222.85 us/ms
Summary for 6706.00(ms)
    All Faults:       1921   286.46 counts/sec
        Iowait:       1273   189.83 counts/sec
   All latency:   25890252  3860.76 us/ms
        Iowait:    4468861   666.40 us/ms
Summary for 5838.00(ms)
    All Faults:       1580   270.64 counts/sec
        Iowait:        619   106.03 counts/sec
   All latency:    6862215  1175.44 us/ms
        Iowait:    1077616   184.59 us/ms
Summary for 5916.00(ms)
    All Faults:       1195   201.99 counts/sec
        Iowait:        494    83.50 counts/sec
   All latency:    4555134   769.97 us/ms
        Iowait:     902513   152.55 us/ms
Summary for 6229.00(ms)
    All Faults:       1395   223.95 counts/sec
        Iowait:        359    57.63 counts/sec
   All latency:    6091882   977.99 us/ms
        Iowait:    1251183   200.86 us/ms
Summary for 6059.00(ms)
    All Faults:       1201   198.22 counts/sec
        Iowait:        299    49.35 counts/sec
   All latency:    5612143   926.25 us/ms
        Iowait:    1155555   190.72 us/ms
Summary for 6005.00(ms)
    All Faults:        847   141.05 counts/sec
        Iowait:        320    53.29 counts/sec
   All latency:    5852541   974.61 us/ms
        Iowait:     433719    72.23 us/ms
Summary for 5895.00(ms)
    All Faults:       1039   176.25 counts/sec
        Iowait:        288    48.85 counts/sec
   All latency:    4184680   709.87 us/ms
        Iowait:     686266   116.41 us/ms
Summary for 6371.00(ms)
    All Faults:       1176   184.59 counts/sec
        Iowait:        269    42.22 counts/sec
   All latency:    6282918   986.17 us/ms
        Iowait:    1160952   182.22 us/ms
Summary for 6113.00(ms)
    All Faults:       1322   216.26 counts/sec
        Iowait:        281    45.97 counts/sec
   All latency:    7208880  1179.27 us/ms
        Iowait:    1336650   218.66 us/ms

commit:
Summary for 7225.00(ms)
    All Faults:       1384   191.56 counts/sec
        Iowait:        285    39.45 counts/sec
   All latency:    6593081   912.54 us/ms
        Iowait:     934041   129.28 us/ms
Summary for 6567.00(ms)
    All Faults:       1378   209.84 counts/sec
        Iowait:        167    25.43 counts/sec
   All latency:    3761554   572.80 us/ms
        Iowait:     220621    33.60 us/ms
Summary for 6118.00(ms)
    All Faults:       1304   213.14 counts/sec
        Iowait:        268    43.81 counts/sec
   All latency:    3835332   626.89 us/ms
        Iowait:     413900    67.65 us/ms
Summary for 6155.00(ms)
    All Faults:       1177   191.23 counts/sec
        Iowait:        185    30.06 counts/sec
   All latency:    4839084   786.20 us/ms
        Iowait:     660002   107.23 us/ms
Summary for 6448.00(ms)
    All Faults:       1283   198.98 counts/sec
        Iowait:        353    54.75 counts/sec
   All latency:    4798334   744.16 us/ms
        Iowait:    1258045   195.11 us/ms
Summary for 6179.00(ms)
    All Faults:       1285   207.96 counts/sec
        Iowait:        137    22.17 counts/sec
   All latency:    3668456   593.70 us/ms
        Iowait:     419731    67.93 us/ms
Summary for 6165.00(ms)
    All Faults:       1500   243.31 counts/sec
        Iowait:        182    29.52 counts/sec
   All latency:    3357435   544.60 us/ms
        Iowait:     279828    45.39 us/ms
Summary for 6270.00(ms)
    All Faults:       1507   240.35 counts/sec
        Iowait:        361    57.58 counts/sec
   All latency:    4428320   706.27 us/ms
        Iowait:     741304   118.23 us/ms
Summary for 6597.00(ms)
    All Faults:       1263   191.45 counts/sec
        Iowait:        238    36.08 counts/sec
   All latency:    5115168   775.38 us/ms
        Iowait:     950482   144.08 us/ms
Summary for 6503.00(ms)
    All Faults:       1456   223.90 counts/sec
        Iowait:        402    61.82 counts/sec
   All latency:    6782757  1043.02 us/ms
        Iowait:    1483803   228.17 us/ms

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 block/Kconfig.iosched |  7 +++++
 block/mq-deadline.c   | 70 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 27f11320b8d1..cd6fcfca7782 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -44,4 +44,11 @@ config BFQ_CGROUP_DEBUG
 	Enable some debugging help. Currently it exports additional stat
 	files in a cgroup which can be useful for debugging.
 
+config ACTIVITY_BASED_IOPRIO
+	bool "Enable folio activity based ioprio on deadline"
+	depends on LRU_GEN && MQ_IOSCHED_DEADLINE
+	default n
+	help
+	This item enable the feature of adjust request's priority by
+	calculating its folio's activity.
 endmenu
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..dfb43fff2ffe 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
 #include <linux/sbitmap.h>
+#include <linux/mm_inline.h>
 
 #include <trace/events/block.h>
 
@@ -224,14 +225,42 @@ static void deadline_remove_request(struct request_queue *q,
 		q->last_merge = NULL;
 }
 
+static enum dd_prio dd_req_ioprio(struct request *rq)
+{
+	enum dd_prio prio;
+	const u8 ioprio_class = dd_rq_ioclass(rq);
+#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
+	struct bio *bio;
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	struct page *page;
+	int gen = 0;
+	int cnt = 0;
+
+	if (req_op(rq) == REQ_OP_READ) {
+		__rq_for_each_bio(bio, rq) {
+			bio_for_each_bvec(bv, bio, iter) {
+				page = bv.bv_page;
+				gen += PageWorkingset(page) ? 1 : 0;
+				cnt++;
+			}
+		}
+		prio = (gen >= cnt / 2) ? ioprio_class_to_prio[IOPRIO_CLASS_RT] :
+			ioprio_class_to_prio[ioprio_class];
+	} else
+		prio = ioprio_class_to_prio[ioprio_class];
+#else
+	prio = ioprio_class_to_prio[ioprio_class];
+#endif
+	return prio;
+}
+
 static void dd_request_merged(struct request_queue *q, struct request *req,
 			      enum elv_merge type)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(req);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = dd_req_ioprio(req);
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
-
 	/*
 	 * if the merge was a front merge, we need to reposition request
 	 */
@@ -248,8 +277,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
 			       struct request *next)
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(next);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = dd_req_ioprio(next);
 
 	lockdep_assert_held(&dd->lock);
 
@@ -745,10 +773,30 @@ static int dd_request_merge(struct request_queue *q, struct request **rq,
 {
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const u8 ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
-	struct dd_per_prio *per_prio = &dd->per_prio[prio];
+	struct dd_per_prio *per_prio;
 	sector_t sector = bio_end_sector(bio);
 	struct request *__rq;
+#ifdef CONFIG_ACTIVITY_BASED_IOPRIO
+	enum dd_prio prio;
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	struct page *page;
+	int gen = 0;
+	int cnt = 0;
+
+	if (bio_op(bio) == REQ_OP_READ) {
+		bio_for_each_bvec(bv, bio, iter) {
+			page = bv.bv_page;
+			gen += PageWorkingset(page) ? 1 : 0;
+			cnt++;
+		}
+	}
+	prio = (gen >= cnt / 2) ? ioprio_class_to_prio[IOPRIO_CLASS_RT] :
+			ioprio_class_to_prio[ioprio_class];
+#else
+	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+#endif
+	per_prio = &dd->per_prio[prio];
 
 	if (!dd->front_merges)
 		return ELEVATOR_NO_MERGE;
@@ -798,10 +846,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
-	u16 ioprio = req_get_ioprio(rq);
-	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
 	struct dd_per_prio *per_prio;
-	enum dd_prio prio;
+	enum dd_prio prio = dd_req_ioprio(rq);
 
 	lockdep_assert_held(&dd->lock);
 
@@ -811,7 +857,6 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	 */
 	blk_req_zone_write_unlock(rq);
 
-	prio = ioprio_class_to_prio[ioprio_class];
 	per_prio = &dd->per_prio[prio];
 	if (!rq->elv.priv[0]) {
 		per_prio->stats.inserted++;
@@ -920,8 +965,7 @@ static void dd_finish_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 	struct deadline_data *dd = q->elevator->elevator_data;
-	const u8 ioprio_class = dd_rq_ioclass(rq);
-	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
+	const enum dd_prio prio = dd_req_ioprio(rq);
 	struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 	/*
-- 
2.25.1


