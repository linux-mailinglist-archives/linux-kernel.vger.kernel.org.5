Return-Path: <linux-kernel+bounces-35006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27488838A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD481C2397A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC059B6C;
	Tue, 23 Jan 2024 09:35:50 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081A59B57;
	Tue, 23 Jan 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002550; cv=none; b=kf+N2F9uk0oNNIogTo8hw+cshVUUbgczY/i/dJaxSejbedA4CLKOOJ/AY+V928diX0jd2iepHTxlC8kWtbJU0hSSAtsqqr7KnmWwu6+3Caw5Qp1yjUCTd52JmsRaff1s+tAFi9h3Z6/69iEha+kkRXgroK8rUnN8kv1dQRga6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002550; c=relaxed/simple;
	bh=Tu+BwNek8vAM+4J1UIC0Oeg0jEZrrdKM/AvlAiSBnP4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jKqb7Vh5/2z+mPSCCSaqBm2WLgqHashqxUzmdcGnCOrcEgFxovhi3kmdP/vngUtTGszh1/rFPeGBTQ085vHtxTNdUbrSian5FzR1RlSRWN/wVMwqqS86wDiJOfy6QmXuayfYtOTrJclOB6oAt7artz166zzAW8QHwDA6pq+Y6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40N9Xxha075020;
	Tue, 23 Jan 2024 17:33:59 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TK1tk3GRKz2SCT4w;
	Tue, 23 Jan 2024 17:26:38 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 23 Jan 2024 17:33:58 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] block: introduce content activity based ioprio
Date: Tue, 23 Jan 2024 17:33:52 +0800
Message-ID: <20240123093352.3007660-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 40N9Xxha075020

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

This commit is verified via bellowing script[1] on a v6.6 android system
and get significant improved fault time as expected[2] while dd's cost
also shrink from 55s to 40s.

1. fault_latency.bin is an ebpf based test tool which measure all task's
   iowait latency during page fault when scheduled out/in.
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
                       mainline		commit
io wait                836us            156us

This commit is also verified by the case of launching camera APP which is
usually considered as heavy working load on both of memory and IO, which
shows 12%-24% improvement.

		ttl = 0		ttl = 50	ttl = 100
mainline        2267ms		2420ms		2316ms
commit          1992ms          1806ms          1998ms

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 block/Kconfig               |  8 ++++++++
 block/bio.c                 | 10 ++++++++++
 block/blk-mq.c              | 21 +++++++++++++++++++++
 include/uapi/linux/ioprio.h | 20 +++++++++++++++-----
 4 files changed, 54 insertions(+), 5 deletions(-)

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
index 816d412c06e9..7fb65745d838 100644
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
+	activity += (bio->bi_vcnt <= IOPRIO_NR_ACTIVITY && PageWorkingset(page)) ? 1 : 0;
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


