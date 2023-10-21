Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAD17D1B9E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjJUHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjJUHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:29 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC79D70;
        Sat, 21 Oct 2023 00:52:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCDFJ1rXJz4f3mJR;
        Sat, 21 Oct 2023 15:52:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S9;
        Sat, 21 Oct 2023 15:52:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 5/8] blk-mq: precalculate available tags for hctx_may_queue()
Date:   Sat, 21 Oct 2023 23:48:03 +0800
Message-Id: <20231021154806.4019417-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S9
X-Coremail-Antispam: 1UD129KBjvJXoW3JryUGw1xtr4xAF1ruw48WFg_yoWxWrWrpF
        W5ta13K3yaqrnruFZrJ3y7uF1SgrWkKr1xGrn3J3yFywnFkr4xW3W8Gry8Zry8Ar4kAayS
        yr4DtryUGF1UGrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Currently, hctx_mq_queue() only need to get how many queues is sharing
tags, then calculate how many tags is available for each queue by fair
sharing.

Add a new field 'available_tags' for struct shared_tag_info to store
how many tags is available directly from slow path, so that
hctx_mq_queue() doesn't need to do calculation.

Currently tags are still fair shared, and now that calculation is in the
slow path, it's okay to refactor tag sharing with more complicated
algorithm, which is implemented in following patches.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  3 ++-
 block/blk-mq-tag.c     | 35 ++++++++++++++++++++++++++++++++++-
 block/blk-mq.c         |  4 ++--
 block/blk-mq.h         | 19 ++++++++-----------
 include/linux/blkdev.h |  1 +
 5 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d6ebd8d9d3bb..1d460119f5b3 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -158,7 +158,8 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 static void shared_tag_info_show(struct shared_tag_info *info,
 				 struct seq_file *m)
 {
-	seq_printf(m, "%d\n", atomic_read(&info->active_tags));
+	seq_printf(m, "active tags %d\n", atomic_read(&info->active_tags));
+	seq_printf(m, "available tags %u\n", READ_ONCE(info->available_tags));
 }
 
 static int queue_shared_tag_info_show(void *data, struct seq_file *m)
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 07d9b513990b..261769251282 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -14,6 +14,8 @@
 #include "blk-mq.h"
 #include "blk-mq-sched.h"
 
+#define shared_tags(tags, users) max((tags->nr_tags + users - 1) / users, 4U)
+
 /*
  * Recalculate wakeup batch when tag is shared by hctx.
  */
@@ -29,10 +31,39 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 			users);
 }
 
-void blk_mq_init_shared_tag_info(struct shared_tag_info *info)
+void blk_mq_init_shared_tag_info(struct shared_tag_info *info,
+				 unsigned int nr_tags)
 {
 	atomic_set(&info->active_tags, 0);
 	INIT_LIST_HEAD(&info->node);
+	info->available_tags = nr_tags;
+}
+
+static void blk_mq_update_available_driver_tags(struct blk_mq_tags *tags,
+						struct shared_tag_info *info,
+						unsigned int users)
+{
+	unsigned int old = tags->ctl.active_queues;
+	int nr_tags;
+	struct shared_tag_info *iter;
+
+	if (!old || !users)
+		return;
+
+	nr_tags = (int)shared_tags(tags, users);
+	if (old < users)
+		WRITE_ONCE(info->available_tags, nr_tags);
+	else
+		WRITE_ONCE(info->available_tags, tags->nr_tags);
+
+	nr_tags -= (int)shared_tags(tags, old);
+	list_for_each_entry(iter, &tags->ctl.head, node) {
+		if (iter == info)
+			continue;
+
+		WRITE_ONCE(iter->available_tags,
+			   (unsigned int)((int)iter->available_tags + nr_tags));
+	}
 }
 
 /*
@@ -70,6 +101,7 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 	spin_lock_irq(&tags->lock);
 	list_add(&info->node, &tags->ctl.head);
 	users = tags->ctl.active_queues + 1;
+	blk_mq_update_available_driver_tags(tags, info, users);
 	WRITE_ONCE(tags->ctl.active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
 	spin_unlock_irq(&tags->lock);
@@ -121,6 +153,7 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 
 	list_del_init(&info->node);
 	users = tags->ctl.active_queues - 1;
+	blk_mq_update_available_driver_tags(tags, info, users);
 	WRITE_ONCE(tags->ctl.active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index de5859dd9f52..8775616bc85c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3652,7 +3652,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
-	blk_mq_init_shared_tag_info(&hctx->shared_tag_info);
+	blk_mq_init_shared_tag_info(&hctx->shared_tag_info, set->queue_depth);
 	return 0;
 
  exit_flush_rq:
@@ -4227,7 +4227,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (blk_mq_alloc_ctxs(q))
 		goto err_exit;
 
-	blk_mq_init_shared_tag_info(&q->shared_tag_info);
+	blk_mq_init_shared_tag_info(&q->shared_tag_info, set->queue_depth);
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ac58f2e22f20..5c0d19562848 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -63,7 +63,8 @@ struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 			     struct blk_mq_tags *tags,
 			     unsigned int hctx_idx);
-void blk_mq_init_shared_tag_info(struct shared_tag_info *info);
+void blk_mq_init_shared_tag_info(struct shared_tag_info *info,
+				 unsigned int nr_tags);
 
 /*
  * CPU -> queue mappings
@@ -416,7 +417,7 @@ static inline void blk_mq_free_requests(struct list_head *list)
 static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 				  struct sbitmap_queue *bt)
 {
-	unsigned int depth, users;
+	struct shared_tag_info *info;
 
 	if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
 		return true;
@@ -432,20 +433,16 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 
 		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return true;
+
+		info = &q->shared_tag_info;
 	} else {
 		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return true;
-	}
 
-	users = READ_ONCE(hctx->tags->ctl.active_queues);
-	if (!users)
-		return true;
+		info = &hctx->shared_tag_info;
+	}
 
-	/*
-	 * Allow at least some tags
-	 */
-	depth = max((bt->sb.depth + users - 1) / users, 4U);
-	return __blk_mq_active_requests(hctx) < depth;
+	return atomic_read(&info->active_tags) < READ_ONCE(info->available_tags);
 }
 
 /* run the code block in @dispatch_ops with rcu/srcu read lock held */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f97bc2c7acc9..b364d65fe4e5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -377,6 +377,7 @@ struct blk_independent_access_ranges {
 
 struct shared_tag_info {
 	atomic_t		active_tags;
+	unsigned int		available_tags;
 	struct list_head	node;
 };
 
-- 
2.39.2

