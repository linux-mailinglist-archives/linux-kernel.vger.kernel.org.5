Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA57D1B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjJUHwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjJUHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E87D68;
        Sat, 21 Oct 2023 00:52:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCDFJ43yFz4f3kpG;
        Sat, 21 Oct 2023 15:52:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S7;
        Sat, 21 Oct 2023 15:52:22 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 3/8] blk-mq: add a helper to initialize shared_tag_info
Date:   Sat, 21 Oct 2023 23:48:01 +0800
Message-Id: <20231021154806.4019417-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWF45Kw1kGFyDJFyxWr4DArb_yoW5CFW5pF
        W5ta15C3ySqrnruFW8ta13Xw15Kw4kKr17GwsIgrWYv342kr1xuF48XryUZrW0yrs3AFZ3
        uF4ktry8JF1kG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
        WIevJa73UjIFyTuYvjTRNzVbUUUUU
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

shared_tag_info is used for both request_queue and hctx, and follow up
patches will add more fields into the structure, add a helper to avoid
redundant code.

Also move initialization for request_queue from blk_alloc_queue() to
blk_mq_init_allocated_queue(), because shared_tag_info won't be used for
bio-based device. And move initialization for hctx from
blk_mq_alloc_hctx() to blk_mq_init_hctx(), because hctx can be reused.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c   | 2 --
 block/blk-mq-tag.c | 5 +++++
 block/blk-mq.c     | 3 ++-
 block/blk-mq.h     | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c028b047f5d5..756ca1109f6c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -414,8 +414,6 @@ struct request_queue *blk_alloc_queue(int node_id)
 
 	q->node = node_id;
 
-	atomic_set(&q->shared_tag_info.active_tags, 0);
-
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index fe41a0d34fc0..2f91a7605d7a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -29,6 +29,11 @@ static void blk_mq_update_wake_batch(struct blk_mq_tags *tags,
 			users);
 }
 
+void blk_mq_init_shared_tag_info(struct shared_tag_info *info)
+{
+	atomic_set(&info->active_tags, 0);
+}
+
 /*
  * If a previously inactive queue goes active, bump the active user count.
  * We need to do this before try to allocate driver tag, then even if fail
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d85b9ad816d0..de5859dd9f52 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3652,6 +3652,7 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (xa_insert(&q->hctx_table, hctx_idx, hctx, GFP_KERNEL))
 		goto exit_flush_rq;
 
+	blk_mq_init_shared_tag_info(&hctx->shared_tag_info);
 	return 0;
 
  exit_flush_rq:
@@ -3679,7 +3680,6 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!zalloc_cpumask_var_node(&hctx->cpumask, gfp, node))
 		goto free_hctx;
 
-	atomic_set(&hctx->shared_tag_info.active_tags, 0);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 	hctx->numa_node = node;
@@ -4227,6 +4227,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (blk_mq_alloc_ctxs(q))
 		goto err_exit;
 
+	blk_mq_init_shared_tag_info(&q->shared_tag_info);
 	/* init q->mq_kobj and sw queues' kobjects */
 	blk_mq_sysfs_init(q);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 6f332dc122ff..ac58f2e22f20 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -63,6 +63,7 @@ struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 			     struct blk_mq_tags *tags,
 			     unsigned int hctx_idx);
+void blk_mq_init_shared_tag_info(struct shared_tag_info *info);
 
 /*
  * CPU -> queue mappings
-- 
2.39.2

