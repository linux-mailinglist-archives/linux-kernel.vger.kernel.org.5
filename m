Return-Path: <linux-kernel+bounces-36659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CD483A499
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2213C1C22157
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55417BA0;
	Wed, 24 Jan 2024 08:54:10 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC017988;
	Wed, 24 Jan 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086449; cv=none; b=CrpGF40HE1JxGw3/WRsoO/E95JkntUsKkNRAqNBPxESAmJskkp3xTxmaXgM4vNBZE2XPlOMBz5rBNE8ob1aCVcJneW1Hj/5PsCtfzIX8ywC0ESD4YPdihzhRhMMK4zuHHu8WGb4YCSrwXioARRxpIdJTgH6hdcuTNokXCPFII4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086449; c=relaxed/simple;
	bh=ySIlbHNgPgmFNXuPufK1d6T2joCFnbD/Rz6ABm+LREA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YXZ10oR+vSA5TDkTIocaID5Yte62klCYfnFanQa4JNIc/YiskOH6cSmrU5YJ0hOW1MCxTbqfYrPWH+3RAoRDuZ7yHZvjT+UFXxL1Qutu+h69kSDgEO4Z3vgEJzyCTHVgFoUzNuVikxgqbkgC29e9u4TXK+o87zqd37KnyUb14y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40O8ri7H079908;
	Wed, 24 Jan 2024 16:53:44 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TKcxm5Mm5z2Rm6Zh;
	Wed, 24 Jan 2024 16:46:20 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 24 Jan 2024 16:53:42 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCHv2 1/1] block: introduce content activity based ioprio
Date: Wed, 24 Jan 2024 16:53:34 +0800
Message-ID: <20240124085334.3060748-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 40O8ri7H079908

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Currently, request's ioprio are set via task's schedule priority(when no
blkcg configured), which has high priority tasks possess the privilege on
both of CPU and IO scheduling.
This commit try to introduce a feature which adjust the request ioprio
based on the folio's activity. The original idea comes from LRU_GEN
which provides more precised folio activity than before. This commit try
to adjust the request's ioprio when certain part of its folios are hot,
which indicate that this request carry important contents and need be
scheduled ealier.

This commit is verified on a v6.6 6GB RAM android14 system via 3 test cases.
Case 1:
script[a] which get significant improved fault time as expected[b]
where dd's cost also shrink from 55s to 40s.
(1). fault_latency.bin is an ebpf based test tool which measure all task's
   iowait latency during page fault when scheduled out/in.
(2). costmem generate page fault by mmaping a file and access the VA.
(3). dd generate concurrent vfs io.

[a]
/fault_latency.bin 1 5 > /data/dd_costmem &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
costmem -c0 -a2048000 -b128000 -o0 1>/dev/null &
dd if=/dev/block/sda of=/data/ddtest bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest1 bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest2 bs=1024 count=2048000 &
dd if=/dev/block/sda of=/data/ddtest3 bs=1024 count=2048000
[b]
                       mainline		commit
io wait                836us            156us

Case 2:
fio -filename=/dev/block/by-name/userdata -rw=randread -direct=0 -bs=4k -size=2000M -numjobs=8 -group_reporting -name=mytest
mainline: 513MiB/s
READ: bw=531MiB/s (557MB/s), 531MiB/s-531MiB/s (557MB/s-557MB/s), io=15.6GiB (16.8GB), run=30137-30137msec
READ: bw=543MiB/s (569MB/s), 543MiB/s-543MiB/s (569MB/s-569MB/s), io=15.6GiB (16.8GB), run=29469-29469msec
READ: bw=474MiB/s (497MB/s), 474MiB/s-474MiB/s (497MB/s-497MB/s), io=15.6GiB (16.8GB), run=33724-33724msec
READ: bw=535MiB/s (561MB/s), 535MiB/s-535MiB/s (561MB/s-561MB/s), io=15.6GiB (16.8GB), run=29928-29928msec
READ: bw=523MiB/s (548MB/s), 523MiB/s-523MiB/s (548MB/s-548MB/s), io=15.6GiB (16.8GB), run=30617-30617msec
READ: bw=492MiB/s (516MB/s), 492MiB/s-492MiB/s (516MB/s-516MB/s), io=15.6GiB (16.8GB), run=32518-32518msec
READ: bw=533MiB/s (559MB/s), 533MiB/s-533MiB/s (559MB/s-559MB/s), io=15.6GiB (16.8GB), run=29993-29993msec
READ: bw=524MiB/s (550MB/s), 524MiB/s-524MiB/s (550MB/s-550MB/s), io=15.6GiB (16.8GB), run=30526-30526msec
READ: bw=529MiB/s (554MB/s), 529MiB/s-529MiB/s (554MB/s-554MB/s), io=15.6GiB (16.8GB), run=30269-30269msec
READ: bw=449MiB/s (471MB/s), 449MiB/s-449MiB/s (471MB/s-471MB/s), io=15.6GiB (16.8GB), run=35629-35629msec

commit: 633MiB/s
READ: bw=668MiB/s (700MB/s), 668MiB/s-668MiB/s (700MB/s-700MB/s), io=15.6GiB (16.8GB), run=23952-23952msec
READ: bw=589MiB/s (618MB/s), 589MiB/s-589MiB/s (618MB/s-618MB/s), io=15.6GiB (16.8GB), run=27164-27164msec
READ: bw=638MiB/s (669MB/s), 638MiB/s-638MiB/s (669MB/s-669MB/s), io=15.6GiB (16.8GB), run=25071-25071msec
READ: bw=714MiB/s (749MB/s), 714MiB/s-714MiB/s (749MB/s-749MB/s), io=15.6GiB (16.8GB), run=22409-22409msec
READ: bw=600MiB/s (629MB/s), 600MiB/s-600MiB/s (629MB/s-629MB/s), io=15.6GiB (16.8GB), run=26669-26669msec
READ: bw=592MiB/s (621MB/s), 592MiB/s-592MiB/s (621MB/s-621MB/s), io=15.6GiB (16.8GB), run=27036-27036msec
READ: bw=691MiB/s (725MB/s), 691MiB/s-691MiB/s (725MB/s-725MB/s), io=15.6GiB (16.8GB), run=23150-23150msec
READ: bw=569MiB/s (596MB/s), 569MiB/s-569MiB/s (596MB/s-596MB/s), io=15.6GiB (16.8GB), run=28142-28142msec
READ: bw=563MiB/s (590MB/s), 563MiB/s-563MiB/s (590MB/s-590MB/s), io=15.6GiB (16.8GB), run=28429-28429msec
READ: bw=712MiB/s (746MB/s), 712MiB/s-712MiB/s (746MB/s-746MB/s), io=15.6GiB (16.8GB), run=22478-22478msec

Case 3:
This commit is also verified by the case of launching camera APP which is
usually considered as heavy working load on both of memory and IO, which
shows 12%-24% improvement.

		ttl = 0		ttl = 50	ttl = 100
mainline        2267ms		2420ms		2316ms
commit          1992ms          1806ms          1998ms

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
change of v2: calculate page's activity via helper function
---
---
 block/Kconfig               |  8 ++++++++
 block/bio.c                 | 10 ++++++++++
 block/blk-mq.c              | 21 +++++++++++++++++++++
 fs/buffer.c                 |  6 ++++++
 include/linux/buffer_head.h |  1 +
 include/uapi/linux/ioprio.h | 20 +++++++++++++++-----
 6 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index f1364d1c0d93..8d6075575eae 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -228,6 +228,14 @@ config BLOCK_HOLDER_DEPRECATED
 config BLK_MQ_STACKING
 	bool
 
+config CONTENT_ACT_BASED_IOPRIO
+	bool "Enable content activity based ioprio"
+	depends on LRU_GEN
+	default y
+	help
+	This item enable the feature of adjust bio's priority by
+	calculating its content's activity.
+
 source "block/Kconfig.iosched"
 
 endif # BLOCK
diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..1228e2a4940f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -24,6 +24,7 @@
 #include "blk.h"
 #include "blk-rq-qos.h"
 #include "blk-cgroup.h"
+#include "blk-ioprio.h"
 
 #define ALLOC_CACHE_THRESHOLD	16
 #define ALLOC_CACHE_MAX		256
@@ -1069,12 +1070,21 @@ EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off)
 {
+	int class, level, hint, activity;
+
+	class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+	hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
+	activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
+
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio, len));
 
 	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
+	activity += bio_page_if_active(bio, page, IOPRIO_NR_ACTIVITY);
+	bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1fafd54dce3c..05cdd3adde94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2939,6 +2939,26 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	return rq;
 }
 
+#ifdef CONFIG_CONTENT_ACT_BASED_IOPRIO
+static void bio_set_ioprio(struct bio *bio)
+{
+	int class, level, hint, activity;
+
+	class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	level = IOPRIO_PRIO_LEVEL(bio->bi_ioprio);
+	hint = IOPRIO_PRIO_HINT(bio->bi_ioprio);
+	activity = IOPRIO_PRIO_ACTIVITY(bio->bi_ioprio);
+
+	if (activity >= bio->bi_vcnt / 2)
+		class = IOPRIO_CLASS_RT;
+	else if (activity >= bio->bi_vcnt / 4)
+		class = max(IOPRIO_PRIO_CLASS(get_current_ioprio()), IOPRIO_CLASS_BE);
+
+	bio->bi_ioprio = IOPRIO_PRIO_VALUE_ACTIVITY(class, level, hint, activity);
+
+	blkcg_set_ioprio(bio);
+}
+#else
 static void bio_set_ioprio(struct bio *bio)
 {
 	/* Nobody set ioprio so far? Initialize it based on task's nice value */
@@ -2946,6 +2966,7 @@ static void bio_set_ioprio(struct bio *bio)
 		bio->bi_ioprio = get_current_ioprio();
 	blkcg_set_ioprio(bio);
 }
+#endif
 
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
diff --git a/fs/buffer.c b/fs/buffer.c
index 12e9a71c693d..b15bff481706 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2832,6 +2832,12 @@ void submit_bh(blk_opf_t opf, struct buffer_head *bh)
 }
 EXPORT_SYMBOL(submit_bh);
 
+int bio_page_if_active(struct bio *bio, struct page *page, unsigned short limit)
+{
+	return (bio->bi_vcnt <= limit && PageWorkingset(page)) ? 1 : 0;
+}
+EXPORT_SYMBOL(bio_page_if_active);
+
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 {
 	lock_buffer(bh);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 44e9de51eedf..9a374f5965ec 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -248,6 +248,7 @@ int bh_uptodate_or_lock(struct buffer_head *bh);
 int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 void __bh_read_batch(int nr, struct buffer_head *bhs[],
 		     blk_opf_t op_flags, bool force_lock);
+int bio_page_if_active(struct bio *bio, struct page *page, unsigned short limit);
 
 /*
  * Generic address_space_operations implementations for buffer_head-backed
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index bee2bdb0eedb..d1c6081e796b 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -71,12 +71,18 @@ enum {
  * class and level.
  */
 #define IOPRIO_HINT_SHIFT		IOPRIO_LEVEL_NR_BITS
-#define IOPRIO_HINT_NR_BITS		10
+#define IOPRIO_HINT_NR_BITS		3
 #define IOPRIO_NR_HINTS			(1 << IOPRIO_HINT_NR_BITS)
 #define IOPRIO_HINT_MASK		(IOPRIO_NR_HINTS - 1)
 #define IOPRIO_PRIO_HINT(ioprio)	\
 	(((ioprio) >> IOPRIO_HINT_SHIFT) & IOPRIO_HINT_MASK)
 
+#define IOPRIO_ACTIVITY_SHIFT		(IOPRIO_HINT_NR_BITS + IOPRIO_LEVEL_NR_BITS)
+#define IOPRIO_ACTIVITY_NR_BITS		7
+#define IOPRIO_NR_ACTIVITY		(1 << IOPRIO_ACTIVITY_NR_BITS)
+#define IOPRIO_ACTIVITY_MASK		(IOPRIO_NR_ACTIVITY - 1)
+#define IOPRIO_PRIO_ACTIVITY(ioprio)	\
+	(((ioprio) >> IOPRIO_ACTIVITY_SHIFT) & IOPRIO_ACTIVITY_MASK)
 /*
  * I/O hints.
  */
@@ -108,20 +114,24 @@ enum {
  * Return an I/O priority value based on a class, a level and a hint.
  */
 static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
-					  int priohint)
+					  int priohint, int activity)
 {
 	if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
 	    IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
-	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
+	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS) ||
+	    IOPRIO_BAD_VALUE(activity, IOPRIO_NR_ACTIVITY))
 		return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
 
 	return (prioclass << IOPRIO_CLASS_SHIFT) |
+		(activity << IOPRIO_ACTIVITY_SHIFT) |
 		(priohint << IOPRIO_HINT_SHIFT) | priolevel;
 }
 
 #define IOPRIO_PRIO_VALUE(prioclass, priolevel)			\
-	ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
+	ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE, 0)
 #define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)	\
-	ioprio_value(prioclass, priolevel, priohint)
+	ioprio_value(prioclass, priolevel, priohint, 0)
+#define IOPRIO_PRIO_VALUE_ACTIVITY(prioclass, priolevel, priohint, activity)	\
+	ioprio_value(prioclass, priolevel, priohint, activity)
 
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.25.1


