Return-Path: <linux-kernel+bounces-15237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E58228E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41001B22FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF31804D;
	Wed,  3 Jan 2024 07:18:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294418028;
	Wed,  3 Jan 2024 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4gzS3z9mz4f3jQb;
	Wed,  3 Jan 2024 15:17:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4D65B1A0914;
	Wed,  3 Jan 2024 15:17:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6hAkCpVliUCTFQ--.54310S4;
	Wed, 03 Jan 2024 15:17:58 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	hch@lst.de,
	bvanassche@acm.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH for-6.8/block RFC v2] block: support to account io_ticks precisely
Date: Wed,  3 Jan 2024 15:15:15 +0800
Message-Id: <20240103071515.2477311-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6hAkCpVliUCTFQ--.54310S4
X-Coremail-Antispam: 1UD129KBjvJXoWfJr43tw4kXFWxArW3Kw4fGrg_yoWDuF1xp3
	yDAay7tay0gF48uFykt3W7A3WSgw4qkrW7Ar43CryYyFnrKr1fX3WvvFWFqF4xZrZ7AayU
	Zr4kAayDu398W3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	UdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently, io_ticks is accounted based on sampling, specifically
update_io_ticks() will always account io_ticks by 1 jiffies from
bdev_start_io_acct()/blk_account_io_start(), and the result can be
inaccurate, for example(HZ is 250):

Test script:
fio -filename=/dev/sda -bs=4k -rw=write -direct=1 -name=test -thinktime=4ms

Test result: util is about 90%, while the disk is really idle.

In order to account io_ticks precisely, update_io_ticks() must know if
there are IO inflight already, and this requires overhead slightly,
hence precise io accounting is disabled by default, and user can enable
it through sysfs entry.

Noted that for rq-based devcie, part_stat_local_inc/dec() and
part_in_flight() is used to track inflight instead of iterating tags,
which is not supposed to be used in fast path because 'tags->lock' is
grabbed in blk_mq_find_and_get_req().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes in v2:
 - remove the new parameter for update_io_ticks();
 - simplify update_io_ticks();
 - use swith in queue_iostats_store();
 - add missing part_stat_local_dec() in blk_account_io_merge_request()

 Documentation/ABI/stable/sysfs-block |  8 ++++--
 block/blk-core.c                     | 10 +++++--
 block/blk-merge.c                    |  3 ++
 block/blk-mq.c                       | 12 ++++++--
 block/blk-sysfs.c                    | 42 ++++++++++++++++++++++++++--
 block/blk.h                          |  1 +
 block/genhd.c                        |  2 +-
 include/linux/blk-mq.h               |  1 +
 include/linux/blkdev.h               |  3 ++
 9 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..e5fedecf7bdf 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -358,8 +358,12 @@ What:		/sys/block/<disk>/queue/iostats
 Date:		January 2009
 Contact:	linux-block@vger.kernel.org
 Description:
-		[RW] This file is used to control (on/off) the iostats
-		accounting of the disk.
+		[RW] This file is used to control the iostats accounting of the
+		disk. If this value is 0, iostats accounting is disabled; If
+		this value is 1, iostats accounting is enabled, but io_ticks is
+		accounted by sampling and the result is not accurate; If this
+		value is 2, iostats accounting is enabled and io_ticks is
+		accounted precisely, but there will be slightly overhead.
 
 
 What:		/sys/block/<disk>/queue/logical_block_size
diff --git a/block/blk-core.c b/block/blk-core.c
index 9520ccab3050..f0d347ab0f34 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -956,9 +956,13 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(time_after(now, stamp))) {
-		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
+	if (unlikely(time_after(now, stamp)) &&
+	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
+		if (end || (blk_queue_precise_io_stat(part->bd_queue) &&
+			    part_in_flight(part)))
+			__part_stat_add(part, io_ticks, now - stamp);
+		else
+			__part_stat_add(part, io_ticks, 1);
 	}
 	if (part->bd_partno) {
 		part = bdev_whole(part);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2d470cf2173e..ea5553766f90 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -779,6 +779,9 @@ static void blk_account_io_merge_request(struct request *req)
 	if (blk_do_io_stat(req)) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+		if (req->rq_flags & RQF_PRECISE_IO_STAT)
+			part_stat_local_dec(req->part,
+					in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fb29ff5cc281..0cb0e8db9dfd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -360,8 +360,11 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 	if (data->flags & BLK_MQ_REQ_PM)
 		data->rq_flags |= RQF_PM;
-	if (blk_queue_io_stat(q))
+	if (blk_queue_io_stat(q)) {
 		data->rq_flags |= RQF_IO_STAT;
+		if (blk_queue_precise_io_stat(q))
+			data->rq_flags |= RQF_PRECISE_IO_STAT;
+	}
 	rq->rq_flags = data->rq_flags;
 
 	if (data->rq_flags & RQF_SCHED_TAGS) {
@@ -999,6 +1002,9 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		update_io_ticks(req->part, jiffies, true);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		if (req->rq_flags & RQF_PRECISE_IO_STAT)
+			part_stat_local_dec(req->part,
+					in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
@@ -1006,7 +1012,6 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 static inline void blk_account_io_start(struct request *req)
 {
 	trace_block_io_start(req);
-
 	if (blk_do_io_stat(req)) {
 		/*
 		 * All non-passthrough requests are created from a bio with one
@@ -1021,6 +1026,9 @@ static inline void blk_account_io_start(struct request *req)
 
 		part_stat_lock();
 		update_io_ticks(req->part, jiffies, false);
+		if (req->rq_flags & RQF_PRECISE_IO_STAT)
+			part_stat_local_inc(req->part,
+					in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 40bab5975c56..ce22dc29b5f1 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -303,7 +303,6 @@ queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
 
 QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
-QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
@@ -468,6 +467,45 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t queue_iostats_show(struct request_queue *q, char *page)
+{
+	int val = 0;
+
+	if (blk_queue_io_stat(q))
+		val = blk_queue_precise_io_stat(q) ? 2 : 1;
+
+	return sprintf(page, "%u\n", val);
+}
+
+static ssize_t
+queue_iostats_store(struct request_queue *q, const char *page, size_t count)
+{
+	unsigned long nr;
+	int ret = queue_var_store(&nr, page, count);
+
+	if (ret < 0)
+		return ret;
+
+	switch (nr) {
+	case 0:
+		blk_queue_flag_clear(QUEUE_FLAG_IO_STAT, q);
+		blk_queue_flag_clear(QUEUE_FLAG_PRECISE_IO_STAT, q);
+		break;
+	case 1:
+		blk_queue_flag_set(QUEUE_FLAG_IO_STAT, q);
+		blk_queue_flag_clear(QUEUE_FLAG_PRECISE_IO_STAT, q);
+		break;
+	case 2:
+		blk_queue_flag_set(QUEUE_FLAG_IO_STAT, q);
+		blk_queue_flag_set(QUEUE_FLAG_PRECISE_IO_STAT, q);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
 #define QUEUE_RO_ENTRY(_prefix, _name)			\
 static struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr	= { .name = _name, .mode = 0444 },	\
@@ -489,6 +527,7 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+QUEUE_RW_ENTRY(queue_iostats, "iostats");
 
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -534,7 +573,6 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 };
 
 QUEUE_RW_ENTRY(queue_nonrot, "rotational");
-QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
 
diff --git a/block/blk.h b/block/blk.h
index 1ef920f72e0f..1154e87a4022 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -344,6 +344,7 @@ static inline bool blk_do_io_stat(struct request *rq)
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
+unsigned int part_in_flight(struct block_device *part);
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 {
diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae68..92d03cd24c79 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -118,7 +118,7 @@ static void part_stat_read_all(struct block_device *part,
 	}
 }
 
-static unsigned int part_in_flight(struct block_device *part)
+unsigned int part_in_flight(struct block_device *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a676e116085f..bd925421bc4a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -44,6 +44,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_QUIET		((__force req_flags_t)(1 << 11))
 /* account into disk and partition IO statistics */
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
+#define RQF_PRECISE_IO_STAT	((__force req_flags_t)(1 << 14))
 /* runtime pm request */
 #define RQF_PM			((__force req_flags_t)(1 << 15))
 /* on IO scheduler merge hash */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 94701a63ad8a..575099f28a8e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -517,6 +517,7 @@ struct request_queue {
 #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
+#define QUEUE_FLAG_PRECISE_IO_STAT 8	/* do disk/partitions IO accounting precisely */
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
@@ -557,6 +558,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_stable_writes(q) \
 	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
+#define blk_queue_precise_io_stat(q) \
+	test_bit(QUEUE_FLAG_PRECISE_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
-- 
2.39.2


