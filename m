Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AEE7D1B9D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjJUHwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjJUHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD4CD6B;
        Sat, 21 Oct 2023 00:52:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCDFH5SDWz4f3mJQ;
        Sat, 21 Oct 2023 15:52:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S8;
        Sat, 21 Oct 2023 15:52:22 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 4/8] blk-mq: support to track active queues from blk_mq_tags
Date:   Sat, 21 Oct 2023 23:48:02 +0800
Message-Id: <20231021154806.4019417-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4UtF45JFW3ZFy8tr43Wrg_yoWruFyfpF
        W5Ka13K3yrGrnrWFWDK39rZ3Zagr4kKr17JFnagry5Ar1Fkr4rWr1kGr9Yvr48ArWkAw4f
        CrWUKrZYkF1DJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
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

In order to refactor how tags is shared, it's necessary to acquire some
information for each shared q/hctx, so that more tags can be assigned to
the one with higher pressure.

Prepare to refactor tag sharing.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c     | 38 ++++++++++++++++++++++++++++++++------
 include/linux/blk-mq.h |  5 +++++
 include/linux/blkdev.h |  3 ++-
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2f91a7605d7a..07d9b513990b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -32,6 +32,7 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 void blk_mq_init_shared_tag_info(struct shared_tag_info *info)
 {
 	atomic_set(&info->active_tags, 0);
+	INIT_LIST_HEAD(&info->node);
 }
 
 /*
@@ -44,6 +45,7 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
 	struct blk_mq_tags *tags = hctx->tags;
+	struct shared_tag_info *info;
 
 	/*
 	 * calling test_bit() prior to test_and_set_bit() is intentional,
@@ -55,13 +57,18 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
 		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return;
+
+		info = &q->shared_tag_info;
 	} else {
 		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
 		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
+
+		info = &hctx->shared_tag_info;
 	}
 
 	spin_lock_irq(&tags->lock);
+	list_add(&info->node, &tags->ctl.head);
 	users = tags->ctl.active_queues + 1;
 	WRITE_ONCE(tags->ctl.active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
@@ -84,26 +91,44 @@ void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
  */
 void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
-	struct blk_mq_tags *tags = hctx->tags;
 	unsigned int users;
+	struct blk_mq_tags *tags = hctx->tags;
+	struct shared_tag_info *info;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-		if (!test_and_clear_bit(QUEUE_FLAG_HCTX_ACTIVE,
-					&q->queue_flags))
+		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return;
+		spin_lock_irq(&tags->lock);
+		if (!test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
+			spin_unlock_irq(&tags->lock);
+			return;
+		}
+
+		info = &q->shared_tag_info;
 	} else {
-		if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
+		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
+		spin_lock_irq(&tags->lock);
+		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
+			spin_unlock_irq(&tags->lock);
+			return;
+		}
+
+		info = &hctx->shared_tag_info;
 	}
 
-	spin_lock_irq(&tags->lock);
+	list_del_init(&info->node);
 	users = tags->ctl.active_queues - 1;
 	WRITE_ONCE(tags->ctl.active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
-	spin_unlock_irq(&tags->lock);
 
+	if (blk_mq_is_shared_tags(hctx->flags))
+		clear_bit(QUEUE_FLAG_HCTX_ACTIVE, &hctx->queue->queue_flags);
+	else
+		clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
+	spin_unlock_irq(&tags->lock);
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
@@ -586,6 +611,7 @@ struct blk_mq_tags *blk_mq_init_tags(unsigned int total_tags,
 	tags->nr_tags = total_tags;
 	tags->nr_reserved_tags = reserved_tags;
 	spin_lock_init(&tags->lock);
+	INIT_LIST_HEAD(&tags->ctl.head);
 
 	if (blk_mq_init_bitmaps(&tags->bitmap_tags, &tags->breserved_tags,
 				total_tags, reserved_tags, node,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4301226f311b..c93955f5f28f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -728,6 +728,11 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 
 struct tag_sharing_ctl {
 	unsigned int active_queues;
+	/*
+	 * If driver tags is shared for multiple queue/hctx, this is the head of
+	 * a list with request_queue/hctx->shared_tag_info.node entries.
+	 */
+	struct list_head head;
 };
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 645a8e245add..f97bc2c7acc9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -376,7 +376,8 @@ struct blk_independent_access_ranges {
 };
 
 struct shared_tag_info {
-	atomic_t active_tags;
+	atomic_t		active_tags;
+	struct list_head	node;
 };
 
 struct request_queue {
-- 
2.39.2

