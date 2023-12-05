Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26584804E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbjLEJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjLEJip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:38:45 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1CF9A;
        Tue,  5 Dec 2023 01:38:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SkwTJ5mRvz4f3kGC;
        Tue,  5 Dec 2023 17:38:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
        by mail.maildlp.com (Postfix) with ESMTP id 01C221A035F;
        Tue,  5 Dec 2023 17:38:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP1 (Coremail) with SMTP id cCh0CgBXWhCk725lWSIxCw--.15203S4;
        Tue, 05 Dec 2023 17:38:46 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, ming.lei@redhat.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next RFC] block: support to account io_ticks precisely
Date:   Tue,  5 Dec 2023 17:37:43 +0800
Message-Id: <20231205093743.1823351-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBXWhCk725lWSIxCw--.15203S4
X-Coremail-Antispam: 1UD129KBjvJXoWfJr43tw4kWr1kZF1xCrW5GFg_yoWkZry8p3
        yDCay3tayvgr4ruFyktF4UA3WSgw1vkr47Zr43GryYk3WDKr1fXw1IvFWYqF48ZrZ7AayU
        Za1kAayDu398W3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 Documentation/ABI/stable/sysfs-block |  8 ++++--
 block/blk-core.c                     | 17 ++++++++----
 block/blk-mq.c                       | 18 ++++++++++---
 block/blk-sysfs.c                    | 40 ++++++++++++++++++++++++++--
 block/blk.h                          |  4 ++-
 block/genhd.c                        |  6 ++---
 include/linux/blk-mq.h               |  1 +
 include/linux/blkdev.h               |  3 +++
 8 files changed, 80 insertions(+), 17 deletions(-)

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
index fdf25b8d6e78..405883d606cd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -935,14 +935,20 @@ int iocb_bio_iopoll(struct kiocb *kiocb, struct io_comp_batch *iob,
 }
 EXPORT_SYMBOL_GPL(iocb_bio_iopoll);
 
-void update_io_ticks(struct block_device *part, unsigned long now, bool end)
+void update_io_ticks(struct block_device *part, unsigned long now, bool end,
+		     bool precise)
 {
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(time_after(now, stamp))) {
-		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
+	if (unlikely(time_after(now, stamp)) &&
+	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now))) {
+		if (precise) {
+			if (end || part_in_flight(part))
+				__part_stat_add(part, io_ticks, now - stamp);
+		} else {
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
+		}
 	}
 	if (part->bd_partno) {
 		part = bdev_whole(part);
@@ -954,7 +960,8 @@ unsigned long bdev_start_io_acct(struct block_device *bdev, enum req_op op,
 				 unsigned long start_time)
 {
 	part_stat_lock();
-	update_io_ticks(bdev, start_time, false);
+	update_io_ticks(bdev, start_time, false,
+			blk_queue_precise_io_stat(bdev->bd_queue));
 	part_stat_local_inc(bdev, in_flight[op_is_write(op)]);
 	part_stat_unlock();
 
@@ -982,7 +989,7 @@ void bdev_end_io_acct(struct block_device *bdev, enum req_op op,
 	unsigned long duration = now - start_time;
 
 	part_stat_lock();
-	update_io_ticks(bdev, now, true);
+	update_io_ticks(bdev, now, true, true);
 	part_stat_inc(bdev, ios[sgrp]);
 	part_stat_add(bdev, sectors[sgrp], sectors);
 	part_stat_add(bdev, nsecs[sgrp], jiffies_to_nsecs(duration));
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 900c1be1fee1..84fffbdc9dc1 100644
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
@@ -996,17 +999,21 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		const int sgrp = op_stat_group(req_op(req));
 
 		part_stat_lock();
-		update_io_ticks(req->part, jiffies, true);
+		update_io_ticks(req->part, jiffies, true, true);
 		part_stat_inc(req->part, ios[sgrp]);
 		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		if (req->rq_flags & RQF_PRECISE_IO_STAT)
+			part_stat_local_dec(req->part,
+					in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
 
 static inline void blk_account_io_start(struct request *req)
 {
-	trace_block_io_start(req);
+	bool precise = req->rq_flags & RQF_PRECISE_IO_STAT;
 
+	trace_block_io_start(req);
 	if (blk_do_io_stat(req)) {
 		/*
 		 * All non-passthrough requests are created from a bio with one
@@ -1020,7 +1027,10 @@ static inline void blk_account_io_start(struct request *req)
 			req->part = req->q->disk->part0;
 
 		part_stat_lock();
-		update_io_ticks(req->part, jiffies, false);
+		update_io_ticks(req->part, jiffies, false, precise);
+		if (precise)
+			part_stat_local_inc(req->part,
+					in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 63e481262336..75ddbbd1edb4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -303,7 +303,6 @@ queue_##name##_store(struct request_queue *q, const char *page, size_t count) \
 
 QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
-QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
 #undef QUEUE_SYSFS_BIT_FNS
 
@@ -473,6 +472,43 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
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
+	int ret, err;
+
+	ret = queue_var_store(&nr, page, count);
+	if (ret < 0)
+		return ret;
+
+	if (nr > 2)
+		return -EINVAL;
+
+	if (nr == 0) {
+		blk_queue_flag_clear(QUEUE_FLAG_IO_STAT, q);
+		blk_queue_flag_clear(QUEUE_FLAG_PRECISE_IO_STAT, q);
+	} else if (nr == 1) {
+		blk_queue_flag_set(QUEUE_FLAG_IO_STAT, q);
+		blk_queue_flag_clear(QUEUE_FLAG_PRECISE_IO_STAT, q);
+	} else {
+		blk_queue_flag_set(QUEUE_FLAG_IO_STAT, q);
+		blk_queue_flag_set(QUEUE_FLAG_PRECISE_IO_STAT, q);
+	}
+
+	return count;
+}
+
 #define QUEUE_RO_ENTRY(_prefix, _name)			\
 static struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr	= { .name = _name, .mode = 0444 },	\
@@ -494,6 +530,7 @@ QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
 QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
 QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_ENTRY(elv_iosched, "scheduler");
+QUEUE_RW_ENTRY(queue_iostats, "iostats");
 
 QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
 QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
@@ -539,7 +576,6 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
 };
 
 QUEUE_RW_ENTRY(queue_nonrot, "rotational");
-QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
 
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..d2321709a9ce 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -343,7 +343,9 @@ static inline bool blk_do_io_stat(struct request *rq)
 	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
 }
 
-void update_io_ticks(struct block_device *part, unsigned long now, bool end);
+void update_io_ticks(struct block_device *part, unsigned long now, bool end,
+		     bool precise);
+unsigned int part_in_flight(struct block_device *part);
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 {
diff --git a/block/genhd.c b/block/genhd.c
index c9d06f72c587..aec651976c83 100644
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
@@ -962,7 +962,7 @@ ssize_t part_stat_show(struct device *dev,
 
 	if (inflight) {
 		part_stat_lock();
-		update_io_ticks(bdev, jiffies, true);
+		update_io_ticks(bdev, jiffies, true, true);
 		part_stat_unlock();
 	}
 	part_stat_read_all(bdev, &stat);
@@ -1255,7 +1255,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 		if (inflight) {
 			part_stat_lock();
-			update_io_ticks(hd, jiffies, true);
+			update_io_ticks(hd, jiffies, true, true);
 			part_stat_unlock();
 		}
 		part_stat_read_all(hd, &stat);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..e6c7adea1b4e 100644
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
index 51fa7ffdee83..fbc7ac419288 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -534,6 +534,7 @@ struct request_queue {
 #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
+#define QUEUE_FLAG_PRECISE_IO_STAT 8	/* do disk/partitions IO accounting precisely */
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
@@ -574,6 +575,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
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

