Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB117D1BA0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJUHwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjJUHwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:31 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F95D63;
        Sat, 21 Oct 2023 00:52:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SCDFG4cKkz4f3kpQ;
        Sat, 21 Oct 2023 15:52:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S11;
        Sat, 21 Oct 2023 15:52:24 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 7/8] blk-mq-tag: delay tag sharing until fail to get driver tag
Date:   Sat, 21 Oct 2023 23:48:05 +0800
Message-Id: <20231021154806.4019417-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S11
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWrJrWfZw1kXFWrWF17Jrb_yoWxJFW5pF
        W3Ka1ak3yrXrsrWFWUKrZF93WI9rs7Kr4UGFnaqa45Zw1Y9r4rur40kr9Yvr48JFWkAw4a
        yrW5trW0yF4DJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Before this patch, tags will be shared when shared node start to handle
IO, however, this will waste tags if some node doen't need all the fair
shared tags and such tags can't be used for other node, even if other
node might want more than fair shared tags.

Prevent such problem by delaying tag sharing from issue io until fail
to get driver tag. Note that such problem still exist if all the tags
are exhausted, and the next patch will implement a algorithm to allow
busy node to borrow tags from idle node.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-tag.c | 67 ++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cd13d8e512f7..a98b25c8d594 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -43,7 +43,7 @@ static void blk_mq_update_available_driver_tags(struct blk_mq_tags *tags,
 						struct shared_tag_info *info,
 						unsigned int users)
 {
-	unsigned int old = tags->ctl.active_queues;
+	unsigned int old = tags->ctl.busy_queues;
 	int nr_tags;
 	struct shared_tag_info *iter;
 
@@ -74,9 +74,7 @@ static void blk_mq_update_available_driver_tags(struct blk_mq_tags *tags,
  */
 void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
-	unsigned int users;
 	struct blk_mq_tags *tags = hctx->tags;
-	struct shared_tag_info *info;
 
 	/*
 	 * calling test_bit() prior to test_and_set_bit() is intentional,
@@ -88,22 +86,14 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
 		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
 			return;
-
-		info = &q->shared_tag_info;
 	} else {
 		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
 		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
-
-		info = &hctx->shared_tag_info;
 	}
 
 	spin_lock_irq(&tags->lock);
-	list_add(&info->node, &tags->ctl.head);
-	users = tags->ctl.active_queues + 1;
-	blk_mq_update_available_driver_tags(tags, info, users);
-	WRITE_ONCE(tags->ctl.active_queues, users);
-	blk_mq_update_wake_batch(tags, users);
+	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues + 1);
 	spin_unlock_irq(&tags->lock);
 }
 
@@ -123,9 +113,7 @@ void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool include_reserve)
  */
 void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
-	unsigned int users;
 	struct blk_mq_tags *tags = hctx->tags;
-	struct shared_tag_info *info;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
@@ -137,8 +125,6 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 			spin_unlock_irq(&tags->lock);
 			return;
 		}
-
-		info = &q->shared_tag_info;
 	} else {
 		if (!test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
 			return;
@@ -147,28 +133,21 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 			spin_unlock_irq(&tags->lock);
 			return;
 		}
-
-		info = &hctx->shared_tag_info;
 	}
 
-	list_del_init(&info->node);
-	users = tags->ctl.active_queues - 1;
-	blk_mq_update_available_driver_tags(tags, info, users);
-	WRITE_ONCE(tags->ctl.active_queues, users);
-	blk_mq_update_wake_batch(tags, users);
-
+	WRITE_ONCE(tags->ctl.active_queues, tags->ctl.active_queues - 1);
 	if (blk_mq_is_shared_tags(hctx->flags))
 		clear_bit(QUEUE_FLAG_HCTX_ACTIVE, &hctx->queue->queue_flags);
 	else
 		clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
 	spin_unlock_irq(&tags->lock);
-	blk_mq_tag_wakeup_all(tags, false);
 }
 
 void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
 	struct blk_mq_tags *tags = hctx->tags;
+	struct shared_tag_info *info;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
@@ -176,14 +155,21 @@ void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
 		if (test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags) ||
 		    test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags))
 			return;
+
+		info = &q->shared_tag_info;
 	} else {
 		if (test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state) ||
 		    test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
 			return;
+
+		info = &hctx->shared_tag_info;
 	}
 
 	spin_lock_irq(&tags->lock);
+	list_add(&info->node, &tags->ctl.head);
 	users = tags->ctl.busy_queues + 1;
+	blk_mq_update_available_driver_tags(tags, info, users);
+	blk_mq_update_wake_batch(tags, users);
 	WRITE_ONCE(tags->ctl.busy_queues, users);
 	spin_unlock_irq(&tags->lock);
 }
@@ -192,22 +178,45 @@ void __blk_mq_driver_tag_idle(struct blk_mq_hw_ctx *hctx)
 {
 	unsigned int users;
 	struct blk_mq_tags *tags = hctx->tags;
+	struct shared_tag_info *info;
 
 	if (blk_mq_is_shared_tags(hctx->flags)) {
 		struct request_queue *q = hctx->queue;
 
-		if (!test_and_clear_bit(QUEUE_FLAG_HCTX_BUSY,
-					&q->queue_flags))
+		if (!test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags))
 			return;
+
+		spin_lock_irq(&tags->lock);
+		if (!test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags)) {
+			spin_unlock_irq(&tags->lock);
+			return;
+		}
+		info = &q->shared_tag_info;
 	} else {
-		if (!test_and_clear_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
+		if (!test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
 			return;
+
+		spin_lock_irq(&tags->lock);
+		if (!test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state)) {
+			spin_unlock_irq(&tags->lock);
+			return;
+		}
+		info = &hctx->shared_tag_info;
 	}
 
-	spin_lock_irq(&tags->lock);
+	list_del_init(&info->node);
 	users = tags->ctl.busy_queues - 1;
+	blk_mq_update_available_driver_tags(tags, info, users);
+	blk_mq_update_wake_batch(tags, users);
 	WRITE_ONCE(tags->ctl.busy_queues, users);
+
+	if (blk_mq_is_shared_tags(hctx->flags))
+		clear_bit(QUEUE_FLAG_HCTX_BUSY, &hctx->queue->queue_flags);
+	else
+		clear_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state);
+
 	spin_unlock_irq(&tags->lock);
+	blk_mq_tag_wakeup_all(tags, false);
 }
 
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
-- 
2.39.2

