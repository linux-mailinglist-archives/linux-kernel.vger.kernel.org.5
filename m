Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14567D1B9B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjJUHwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJUHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B649D67;
        Sat, 21 Oct 2023 00:52:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCDFG2Fjvz4f3mHf;
        Sat, 21 Oct 2023 15:52:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S5;
        Sat, 21 Oct 2023 15:52:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 1/8] blk-mq: factor out a structure from blk_mq_tags
Date:   Sat, 21 Oct 2023 23:47:59 +0800
Message-Id: <20231021154806.4019417-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4xGF4DJr43uw1ktr43Wrg_yoW5uF4Dpa
        yDGa17Cw1fJr1UXFWvq3yUZF1Sganxtr17Jwn3W34YyF1UCw1fZr1v9rW0vr48ZrsayFsr
        Grs8trW8tF1UW37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
        0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtAUUUUUU==
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

Currently tags are fairly shared. The new structure contains only one
field active_queues for now.

There are no functional changes and this patch prepares for refactoring
tag sharing.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-mq-debugfs.c |  2 +-
 block/blk-mq-tag.c     |  8 ++++----
 block/blk-mq.h         |  2 +-
 include/linux/blk-mq.h | 10 ++++++++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5cbeb9344f2f..f6b77289bc1f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -400,7 +400,7 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
 	seq_printf(m, "active_queues=%d\n",
-		   READ_ONCE(tags->active_queues));
+		   READ_ONCE(tags->ctl.active_queues));
 
 	seq_puts(m, "\nbitmap_tags:\n");
 	sbitmap_queue_show(&tags->bitmap_tags, m);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..fe41a0d34fc0 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -57,8 +57,8 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 	}
 
 	spin_lock_irq(&tags->lock);
-	users = tags->active_queues + 1;
-	WRITE_ONCE(tags->active_queues, users);
+	users = tags->ctl.active_queues + 1;
+	WRITE_ONCE(tags->ctl.active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
 	spin_unlock_irq(&tags->lock);
 }
@@ -94,8 +94,8 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 	}
 
 	spin_lock_irq(&tags->lock);
-	users = tags->active_queues - 1;
-	WRITE_ONCE(tags->active_queues, users);
+	users = tags->ctl.active_queues - 1;
+	WRITE_ONCE(tags->ctl.active_queues, users);
 	blk_mq_update_wake_batch(tags, users);
 	spin_unlock_irq(&tags->lock);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..363c8f6e13dd 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -435,7 +435,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
 			return true;
 	}
 
-	users = READ_ONCE(hctx->tags->active_queues);
+	users = READ_ONCE(hctx->tags->ctl.active_queues);
 	if (!users)
 		return true;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..5a08527c53b9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -727,13 +727,16 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 		blk_opf_t opf, blk_mq_req_flags_t flags,
 		unsigned int hctx_idx);
 
+struct tag_sharing_ctl {
+	unsigned int active_queues;
+};
+
 /*
  * Tag address space map.
  */
 struct blk_mq_tags {
 	unsigned int nr_tags;
 	unsigned int nr_reserved_tags;
-	unsigned int active_queues;
 
 	struct sbitmap_queue bitmap_tags;
 	struct sbitmap_queue breserved_tags;
@@ -744,9 +747,12 @@ struct blk_mq_tags {
 
 	/*
 	 * used to clear request reference in rqs[] before freeing one
-	 * request pool
+	 * request pool, and to protect tag_sharing_ctl.
 	 */
 	spinlock_t lock;
+
+	/* used when tags is shared for multiple request_queue or hctx. */
+	struct tag_sharing_ctl ctl;
 };
 
 static inline struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags,
-- 
2.39.2

