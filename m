Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84F97D1BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjJUHwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjJUHwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:32 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD1AD66;
        Sat, 21 Oct 2023 00:52:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCDFK55lKz4f3n5w;
        Sat, 21 Oct 2023 15:52:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S12;
        Sat, 21 Oct 2023 15:52:24 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 8/8] blk-mq-tag: allow shared queue/hctx to get more driver tags
Date:   Sat, 21 Oct 2023 23:48:06 +0800
Message-Id: <20231021154806.4019417-9-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S12
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4rWw4rXrWfKryUJryDGFg_yoW3WF13pF
        W5Ga13K3yrJrnrWrWkt3yqvF1Fk3ykCw4rGr1fX3yrA3ZrKr4fW3W0kryYvFW8Ar4kCF4a
        qr4YgryYkF1UJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUv
        cSsGvfC2KfnxnUUI43ZEXa7sRiVbyDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently tags are fail shared to each node, and if some node only
issue litter IO, the shared tags will be wasted and can't be used for
other nodes that is under high IO pressure.

This patch implement a new way to allow one node to borrow tags from
other node:

1) multiple nodes start issue io, and all tags is exhausted, start
   sharing tags by fair share;
2) while sharing tag, detect if there are any node need more tags, if so
   start a timer;
3) in the timer function
   - If there are node with borrowed tags and doesn't busy anymore,
     return borrowed tags;
   - Find the busy node with highest pressure, and calculate available
     free tags from node that is not busy, then borrow tags;

A simple test, 32 tags with two shared node:
[global]
ioengine=libaio
iodepth=2
bs=4k
direct=1
rw=randrw
group_reporting

[sda]
numjobs=32
filename=/dev/sda

[sdb]
numjobs=1
filename=/dev/sdb

Test result(monitor new debugfs entry):

time	active		available
	sda 	sdb	sda	sdb
0	0	0	32	32
1	16	2	16	16	-> start fair sharing
2	19	2	20	16
3	24	2	24	16
4	26	2	28	16 	-> borrow 32/8=4 tags each round
5	28	2	28	16	-> save at lease 4 tags for sdb

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq-tag.c     | 92 +++++++++++++++++++++++++++++++++++++++---
 include/linux/blk-mq.h |  3 ++
 include/linux/blkdev.h |  1 +
 4 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 170bc2236e81..a987f4228b67 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -160,6 +160,7 @@ static void shared_tag_info_show(struct shared_tag_info *info,
 {
 	seq_printf(m, "active tags %d\n", atomic_read(&info->active_tags));
 	seq_printf(m, "available tags %u\n", READ_ONCE(info->available_tags));
+	seq_printf(m, "busy count %u\n", atomic_read(&info->busy_count));
 }
 
 static int queue_shared_tag_info_show(void *data, struct seq_file *m)
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a98b25c8d594..798b90d3f11a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -35,6 +35,7 @@ void blk_mq_init_shared_tag_info(struct shared_tag_info *info,
 				 unsigned int nr_tags)
 {
 	atomic_set(&info->active_tags, 0);
+	atomic_set(&info->busy_count, 0);
 	INIT_LIST_HEAD(&info->node);
 	info->available_tags = nr_tags;
 }
@@ -143,26 +144,93 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	spin_unlock_irq(&tags->lock);
 }
 
+static void tag_sharing_ctl_timer_fn(struct timer_list *t)
+{
+	struct tag_sharing_ctl *ctl = from_timer(ctl, t, timer);
+	struct blk_mq_tags *tags = container_of(ctl, struct blk_mq_tags, ctl);
+	struct shared_tag_info *busy = NULL;
+	struct shared_tag_info *info;
+	unsigned int nr_tags;
+	unsigned int step;
+	unsigned int free_tags = 0;
+	unsigned int borrowed_tags = 0;
+	unsigned int max_busy_count = 0;
+
+	spin_lock_irq(&tags->lock);
+
+	if (tags->ctl.busy_queues <= 1)
+		goto out;
+
+	/* First round, decrease busy_count by half. */
+	list_for_each_entry(info, &tags->ctl.head, node) {
+		int count = atomic_read(&info->busy_count);
+
+		if (count > tags->nr_tags)
+			count = count >> 1;
+		atomic_sub(count, &info->busy_count);
+	}
+
+	/* Second round, find borrowed tags that can be returned. */
+	nr_tags = shared_tags(tags, tags->ctl.busy_queues);
+	step = clamp_t(unsigned int, tags->nr_tags / SBQ_WAIT_QUEUES, 1,
+		       SBQ_WAKE_BATCH);
+	list_for_each_entry(info, &tags->ctl.head, node) {
+		if (info->available_tags > nr_tags &&
+		    atomic_read(&info->active_tags) <= nr_tags &&
+		    atomic_read(&info->busy_count) <= tags->nr_tags)
+			info->available_tags = nr_tags;
+	}
+
+	/* Last round, find available free tags, and which node need more tags. */
+	list_for_each_entry(info, &tags->ctl.head, node) {
+		unsigned int busy_count;
+
+		if (info->available_tags > nr_tags)
+			borrowed_tags += info->available_tags - nr_tags;
+		else
+			free_tags += info->available_tags - max(step,
+				(unsigned int)atomic_read(&info->active_tags));
+
+		busy_count = atomic_read(&info->busy_count);
+		if (busy_count > tags->nr_tags && busy_count > max_busy_count) {
+			busy = info;
+			max_busy_count = busy_count;
+		}
+	}
+
+	/* Borrow tags. */
+	if (busy && borrowed_tags < free_tags)
+		busy->available_tags += min(free_tags - borrowed_tags, step);
+
+out:
+	if (!busy) {
+		ctl->timer_running = false;
+	} else {
+		ctl->timer.expires = jiffies + HZ;
+		add_timer(&ctl->timer);
+	}
+	spin_unlock_irq(&tags->lock);
+}
+
 void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
 	struct blk_mq_tags *tags = hctx->tags;
 	struct shared_tag_info *info;
+	bool timer_running = false;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
+		info = &q->shared_tag_info;
 		if (test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags) ||
 		    test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags))
-			return;
-
-		info = &q->shared_tag_info;
+			goto inc_busy;
 	} else {
+		info = &hctx->shared_tag_info;
 		if (test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state) ||
 		    test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
-			return;
-
-		info = &hctx->shared_tag_info;
+			goto inc_busy;
 	}
 
 	spin_lock_irq(&tags->lock);
@@ -172,6 +240,15 @@ void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 	blk_mq_update_wake_batch(tags, users);
 	WRITE_ONCE(tags->ctl.busy_queues, users);
 	spin_unlock_irq(&tags->lock);
+	return;
+
+inc_busy:
+	atomic_inc(&info->busy_count);
+	if (!tags->ctl.timer_running &&
+	    try_cmpxchg_relaxed(&tags->ctl.timer_running, &timer_running, true)) {
+		tags->ctl.timer.expires = jiffies + HZ;
+		add_timer(&tags->ctl.timer);
+	}
 }
 
 void __blk_mq_driver_tag_idle(struct blk_mq_hw_ctx *hctx)
@@ -204,6 +281,7 @@ void __blk_mq_driver_tag_idle(struct blk_mq_hw_ctx *hctx)
 		info = &hctx->shared_tag_info;
 	}
 
+	atomic_set(&info->busy_count, 0);
 	list_del_init(&info->node);
 	users = tags->ctl.busy_queues - 1;
 	blk_mq_update_available_driver_tags(tags, info, users);
@@ -705,6 +783,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
 	INIT_LIST_HEAD(&tags->ctl.head);
+	timer_setup(&tags->ctl.timer, tag_sharing_ctl_timer_fn, 0);
 
 	if (blk_mq_init_bitmaps(&tags->bitmap_tags, &tags->breserved_tags,
 				total_tags, reserved_tags, node,
@@ -717,6 +796,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 
 void blk_mq_free_tags(struct blk_mq_tags *tags)
 {
+	del_timer_sync(&tags->ctl.timer);
 	sbitmap_queue_free(&tags->bitmap_tags);
 	sbitmap_queue_free(&tags->breserved_tags);
 	kfree(tags);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9182ceca8c7a..1e4aa733e1ab 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -736,6 +736,9 @@ struct tag_sharing_ctl {
 	 * a list with request_queue/hctx->shared_tag_info.node entries.
 	 */
 	struct list_head head;
+	bool timer_running;
+	/* Start when any queue/hctx failed to get driver tag. */
+	struct timer_list timer;
 };
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd6a0a92233..8bfae877dd27 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -378,6 +378,7 @@ struct blk_independent_access_ranges {
 struct shared_tag_info {
 	atomic_t		active_tags;
 	unsigned int		available_tags;
+	atomic_t		busy_count;
 	struct list_head	node;
 };
 
-- 
2.39.2

