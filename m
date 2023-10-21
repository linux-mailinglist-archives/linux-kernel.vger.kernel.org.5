Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AFD7D1B98
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 09:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJUHwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUHw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 03:52:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2912D63;
        Sat, 21 Oct 2023 00:52:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SCDFG5pgtz4f3mHr;
        Sat, 21 Oct 2023 15:52:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAXrt0ygzNl84cpDg--.7754S6;
        Sat, 21 Oct 2023 15:52:21 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     bvanassche@acm.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH RFC v2 2/8] blk-mq: factor out a structure to store information for tag sharing
Date:   Sat, 21 Oct 2023 23:48:00 +0800
Message-Id: <20231021154806.4019417-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
References: <20231021154806.4019417-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXrt0ygzNl84cpDg--.7754S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1DWr4rWFyxZw1xKr1DAwb_yoW3XrWDpF
        W5ta13CayFqF1DuFWkKanrZr1fKr4vkry7GrnagwnIyw1I9r4xGa18XFy5ZrW8ArWkJrWS
        yr4qgrWUGF1DWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x0pR9NVDUUUUU=
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

Tags can be shared by multiple request_queue or hctx, and they both have
a counter to record how many tags is used, 'nr_active_requests_shared_tags'
for request_queue and 'nr_active' for hctx. Factor out a new structure
shared_tag_info to store such information.

Also add new entry debugfs entry 'shared_tag_info' for both queue and
hctx.

This patch prepares for refactoring tag sharing.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c       |  2 +-
 block/blk-mq-debugfs.c | 24 ++++++++++++++++++++++++
 block/blk-mq.c         |  2 +-
 block/blk-mq.h         | 23 ++++++++++++-----------
 include/linux/blk-mq.h | 11 +++++------
 include/linux/blkdev.h |  7 +++++--
 6 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9d51e9894ece..c028b047f5d5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -414,7 +414,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 
 	q->node = node_id;
 
-	atomic_set(&q->nr_active_requests_shared_tags, 0);
+	atomic_set(&q->shared_tag_info.active_tags, 0);
 
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f6b77289bc1f..d6ebd8d9d3bb 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -155,12 +155,27 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 	return count;
 }
 
+static void shared_tag_info_show(struct shared_tag_info *info,
+				 struct seq_file *m)
+{
+	seq_printf(m, "%d\n", atomic_read(&info->active_tags));
+}
+
+static int queue_shared_tag_info_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+
+	shared_tag_info_show(&q->shared_tag_info, m);
+	return 0;
+}
+
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{ "poll_stat", 0400, queue_poll_stat_show },
 	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
 	{ "pm_only", 0600, queue_pm_only_show, NULL },
 	{ "state", 0600, queue_state_show, queue_state_write },
 	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
+	{ "shared_tag_info", 0400, queue_shared_tag_info_show, NULL },
 	{ },
 };
 
@@ -512,6 +527,14 @@ static int hctx_dispatch_busy_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+static int hctx_shared_tag_info_show(void *data, struct seq_file *m)
+{
+	struct blk_mq_hw_ctx *hctx = data;
+
+	shared_tag_info_show(&hctx->shared_tag_info, m);
+	return 0;
+}
+
 #define CTX_RQ_SEQ_OPS(name, type)					\
 static void *ctx_##name##_rq_list_start(struct seq_file *m, loff_t *pos) \
 	__acquires(&ctx->lock)						\
@@ -628,6 +651,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"active", 0400, hctx_active_show},
 	{"dispatch_busy", 0400, hctx_dispatch_busy_show},
 	{"type", 0400, hctx_type_show},
+	{"shared_tag_info", 0400, hctx_shared_tag_info_show},
 	{},
 };
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..d85b9ad816d0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3679,7 +3679,7 @@ blk_mq_alloc_hctx(struct request_queue *q, struct blk_mq_tag_set *set,
 	if (!zalloc_cpumask_var_node(&hctx->cpumask, gfp, node))
 		goto free_hctx;
 
-	atomic_set(&hctx->nr_active, 0);
+	atomic_set(&hctx->shared_tag_info.active_tags, 0);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 	hctx->numa_node = node;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 363c8f6e13dd..6f332dc122ff 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -274,10 +274,10 @@ static inline int blk_mq_get_rq_budget_token(struct request *rq)
 static inline void __blk_mq_add_active_requests(struct blk_mq_hw_ctx *hctx,
 						int val)
 {
-	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_add(val, &hctx->queue->nr_active_requests_shared_tags);
-	else
-		atomic_add(val, &hctx->nr_active);
+	struct shared_tag_info *info = blk_mq_is_shared_tags(hctx->flags) ?
+		&hctx->queue->shared_tag_info : &hctx->shared_tag_info;
+
+	atomic_add(val, &info->active_tags);
 }
 
 static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
@@ -288,10 +288,10 @@ static inline void __blk_mq_inc_active_requests(struct blk_mq_hw_ctx *hctx)
 static inline void __blk_mq_sub_active_requests(struct blk_mq_hw_ctx *hctx,
 		int val)
 {
-	if (blk_mq_is_shared_tags(hctx->flags))
-		atomic_sub(val, &hctx->queue->nr_active_requests_shared_tags);
-	else
-		atomic_sub(val, &hctx->nr_active);
+	struct shared_tag_info *info = blk_mq_is_shared_tags(hctx->flags) ?
+		&hctx->queue->shared_tag_info : &hctx->shared_tag_info;
+
+	atomic_sub(val, &info->active_tags);
 }
 
 static inline void __blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
@@ -327,9 +327,10 @@ static inline void blk_mq_dec_active_requests(struct blk_mq_hw_ctx *hctx)
 
 static inline int __blk_mq_active_requests(struct blk_mq_hw_ctx *hctx)
 {
-	if (blk_mq_is_shared_tags(hctx->flags))
-		return atomic_read(&hctx->queue->nr_active_requests_shared_tags);
-	return atomic_read(&hctx->nr_active);
+	struct shared_tag_info *info = blk_mq_is_shared_tags(hctx->flags) ?
+		&hctx->queue->shared_tag_info : &hctx->shared_tag_info;
+
+	return atomic_read(&info->active_tags);
 }
 static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 					   struct request *rq)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5a08527c53b9..4301226f311b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -384,6 +384,11 @@ struct blk_mq_hw_ctx {
 	 * assigned when a request is dispatched from a hardware queue.
 	 */
 	struct blk_mq_tags	*tags;
+	/**
+	 * @shared_tag_info: Only used when a tag set is shared across request
+	 * queues.
+	 */
+	struct shared_tag_info	shared_tag_info;
 	/**
 	 * @sched_tags: Tags owned by I/O scheduler. If there is an I/O
 	 * scheduler associated with a request queue, a tag is assigned when
@@ -399,12 +404,6 @@ struct blk_mq_hw_ctx {
 	/** @queue_num: Index of this hardware queue. */
 	unsigned int		queue_num;
 
-	/**
-	 * @nr_active: Number of active requests. Only used when a tag set is
-	 * shared across request queues.
-	 */
-	atomic_t		nr_active;
-
 	/** @cpuhp_online: List to store request if CPU is going to die */
 	struct hlist_node	cpuhp_online;
 	/** @cpuhp_dead: List to store request if some CPU die. */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..645a8e245add 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -375,6 +375,10 @@ struct blk_independent_access_ranges {
 	struct blk_independent_access_range	ia_range[];
 };
 
+struct shared_tag_info {
+	atomic_t active_tags;
+};
+
 struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
@@ -455,8 +459,6 @@ struct request_queue {
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 
-	atomic_t		nr_active_requests_shared_tags;
-
 	struct blk_mq_tags	*sched_shared_tags;
 
 	struct list_head	icq_list;
@@ -513,6 +515,7 @@ struct request_queue {
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
+	struct shared_tag_info	shared_tag_info;
 
 	struct dentry		*debugfs_dir;
 	struct dentry		*sched_debugfs_dir;
-- 
2.39.2

