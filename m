Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844097D1B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjJUHwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJUHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:29 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AD4D6E;
        Sat, 21 Oct 2023 00:52:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCDFL0Fstz4f3kph;
        Sat, 21 Oct 2023 15:52:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S10;
        Sat, 21 Oct 2023 15:52:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 6/8] blk-mq: add new helpers blk_mq_driver_tag_busy/idle()
Date:   Sat, 21 Oct 2023 23:48:04 +0800
Message-Id: <20231021154806.4019417-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S10
X-Coremail-Antispam: 1UD129KBjvJXoWxuw1xWr1fJw1UGr17ZrW5Wrg_yoWfJr4UpF
        W3Ga1Yk3yFqrsruFZrta17Z3WSkrs7Kr17Jrnaqw1FvF1j9r4xW3W8GryUZrW8ArWkAr47
        ZrW5try5Cr1DWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Refer to the implementation of blk_mq_tag_busy/idle():

 - blk_mq_driver_tag_busy() will be used the first time when get driver
 tag failed;
 - blk_mq_driver_tag_idle() will be used when driver tag is no longer
 exhausted.
 - A new counter 'busy_queues' is added to indicate how many shared
 queues/hctxs are busy(drivers tags is exhausted);

Tag sharing will be delayed until fail to get driver tag based on these
new helpers.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  2 ++
 block/blk-mq-tag.c     | 53 +++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq.c         |  9 +++++--
 block/blk-mq.h         | 25 ++++++++++++++++----
 include/linux/blk-mq.h |  7 ++++--
 include/linux/blkdev.h |  1 +
 6 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1d460119f5b3..170bc2236e81 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -417,6 +417,8 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
 	seq_printf(m, "active_queues=%d\n",
 		   READ_ONCE(tags->ctl.active_queues));
+	seq_printf(m, "busy_queues=%d\n",
+		   READ_ONCE(tags->ctl.busy_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 261769251282..cd13d8e512f7 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -165,6 +165,51 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	blk_mq_tag_wakeup_all(tags, false);
 }
 
+void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
+{
+	unsigned int users;
+	struct blk_mq_tags *tags = hctx->tags;
+
+	if (blk_mq_is_shared_tags(hctx->flags)) {
+		struct request_queue *q = hctx->queue;
+
+		if (test_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags) ||
+		    test_and_set_bit(QUEUE_FLAG_HCTX_BUSY, &q->queue_flags))
+			return;
+	} else {
+		if (test_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state) ||
+		    test_and_set_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
+			return;
+	}
+
+	spin_lock_irq(&tags->lock);
+	users = tags->ctl.busy_queues + 1;
+	WRITE_ONCE(tags->ctl.busy_queues, users);
+	spin_unlock_irq(&tags->lock);
+}
+
+void __blk_mq_driver_tag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	unsigned int users;
+	struct blk_mq_tags *tags = hctx->tags;
+
+	if (blk_mq_is_shared_tags(hctx->flags)) {
+		struct request_queue *q = hctx->queue;
+
+		if (!test_and_clear_bit(QUEUE_FLAG_HCTX_BUSY,
+					&q->queue_flags))
+			return;
+	} else {
+		if (!test_and_clear_bit(BLK_MQ_S_DTAG_BUSY, &hctx->state))
+			return;
+	}
+
+	spin_lock_irq(&tags->lock);
+	users = tags->ctl.busy_queues - 1;
+	WRITE_ONCE(tags->ctl.busy_queues, users);
+	spin_unlock_irq(&tags->lock);
+}
+
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
@@ -218,8 +263,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (tag != BLK_MQ_NO_TAG)
 		goto found_tag;
 
-	if (data->flags & BLK_MQ_REQ_NOWAIT)
+	if (data->flags & BLK_MQ_REQ_NOWAIT) {
+		if (!(data->rq_flags & RQF_SCHED_TAGS))
+			blk_mq_driver_tag_busy(data->hctx);
 		return BLK_MQ_NO_TAG;
+	}
 
 	ws = bt_wait_ptr(bt, data->hctx);
 	do {
@@ -246,6 +294,9 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != BLK_MQ_NO_TAG)
 			break;
 
+		if (!(data->rq_flags & RQF_SCHED_TAGS))
+			blk_mq_driver_tag_busy(data->hctx);
+
 		bt_prev = bt;
 		io_schedule();
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8775616bc85c..a106533f063f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1668,8 +1668,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			/* the hctx may be unmapped, so check it here */
-			if (blk_mq_hw_queue_mapped(hctx))
+			if (blk_mq_hw_queue_mapped(hctx)) {
 				blk_mq_tag_idle(hctx);
+				blk_mq_driver_tag_idle(hctx);
+			}
 		}
 	}
 	blk_queue_exit(q);
@@ -3594,8 +3596,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 {
 	struct request *flush_rq = hctx->fq->flush_rq;
 
-	if (blk_mq_hw_queue_mapped(hctx))
+	if (blk_mq_hw_queue_mapped(hctx)) {
 		blk_mq_tag_idle(hctx);
+		blk_mq_driver_tag_idle(hctx);
+	}
 
 	if (blk_queue_init_done(q))
 		blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
@@ -3931,6 +3935,7 @@ static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 			hctx->flags |= BLK_MQ_F_TAG_QUEUE_SHARED;
 		} else {
 			blk_mq_tag_idle(hctx);
+			blk_mq_driver_tag_idle(hctx);
 			hctx->flags &= ~BLK_MQ_F_TAG_QUEUE_SHARED;
 		}
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 5c0d19562848..3e555af1de49 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -195,8 +195,10 @@ static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
 	return sbq_wait_ptr(bt, &hctx->wait_index);
 }
 
-void __blk_mq_tag_busy(struct blk_mq_hw_ctx *);
-void __blk_mq_tag_idle(struct blk_mq_hw_ctx *);
+void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx);
+void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx);
+void __blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx);
+void __blk_mq_driver_tag_idle(struct blk_mq_hw_ctx *hctx);
 
 static inline void blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
@@ -210,6 +212,18 @@ static inline void blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 		__blk_mq_tag_idle(hctx);
 }
 
+static inline void blk_mq_driver_tag_busy(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_driver_tag_busy(hctx);
+}
+
+static inline void blk_mq_driver_tag_idle(struct blk_mq_hw_ctx *hctx)
+{
+	if (hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
+		__blk_mq_driver_tag_idle(hctx);
+}
+
 static inline bool blk_mq_tag_is_reserved(struct blk_mq_tags *tags,
 					  unsigned int tag)
 {
@@ -293,7 +307,8 @@ static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
 	struct shared_tag_info *info = blk_mq_is_shared_tags(hctx->flags) ?
 		&hctx->queue->shared_tag_info : &hctx->shared_tag_info;
 
-	atomic_sub(val, &info->active_tags);
+	if (!atomic_sub_return(val, &info->active_tags))
+		blk_mq_driver_tag_idle(hctx);
 }
 
 static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
@@ -354,8 +369,10 @@ bool __blk_mq_alloc_driver_tag(struct request *rq);
 
 static inline bool blk_mq_get_driver_tag(struct request *rq)
 {
-	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_alloc_driver_tag(rq))
+	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_alloc_driver_tag(rq)) {
+		blk_mq_driver_tag_busy(rq->mq_hctx);
 		return false;
+	}
 
 	return true;
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c93955f5f28f..9182ceca8c7a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -666,10 +666,11 @@ enum {
 
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
-	BLK_MQ_S_SCHED_RESTART	= 2,
+	BLK_MQ_S_DTAG_BUSY      = 2,
+	BLK_MQ_S_SCHED_RESTART	= 3,
 
 	/* hw queue is inactive after all its CPUs become offline */
-	BLK_MQ_S_INACTIVE	= 3,
+	BLK_MQ_S_INACTIVE	= 4,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
@@ -728,6 +729,8 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 
 struct tag_sharing_ctl {
 	unsigned int active_queues;
+	/* The number of shared queues/hctxs with exhausted driver tags. */
+	unsigned int busy_queues;
 	/*
 	 * If driver tags is shared for multiple queue/hctx, this is the head of
 	 * a list with request_queue/hctx->shared_tag_info.node entries.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b364d65fe4e5..8fd6a0a92233 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -552,6 +552,7 @@ struct request_queue {
 #define QUEUE_FLAG_DAX		19	/* device supports DAX */
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
+#define QUEUE_FLAG_HCTX_BUSY	23      /* driver tag is exhausted for at least one blk-mq hctx */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
-- 
2.39.2

