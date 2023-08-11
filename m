Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2292C779625
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbjHKRcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjHKRcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:32:05 -0400
X-Greylist: delayed 1856 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 10:32:03 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C531330D6;
        Fri, 11 Aug 2023 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=1bgcB
        p8fzhjWEwXxvKLtPq7qoOm/h5wEpd/xc8E5JuE=; b=e2lflk/0WOnjkM5XQRc9y
        bjMQmO296tuEnR78h1k7jOJiqkZTM3aRA+bzirLaJmFYZgMKu2eKT+iG8x7fX0sd
        UY4gyBr+TivVsBeXxm2ETeregOr58VHFEfkSNWq4ZO3YlwdJc28nwPLjbq8VT4Bc
        ew6A9kFxshGWG6RIUnVWbo=
Received: from fedora.. (unknown [111.19.34.224])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wC3vIhNZdZku1OCBw--.13087S2;
        Sat, 12 Aug 2023 00:44:09 +0800 (CST)
From:   Zhang Bo <zbsdta@126.com>
To:     paolo.valente@unimore.it
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Bo <zbsdta@126.com>
Subject: [PATCH] block: BFQ: dispatch expired sync and async request first
Date:   Sat, 12 Aug 2023 00:43:53 +0800
Message-ID: <20230811164353.82652-1-zbsdta@126.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3vIhNZdZku1OCBw--.13087S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1UJrWUXF18WF4DWFy8Zrb_yoWrWrWfpF
        sxWws0qr1rGr4SqF1rGa1DXwnxJr4fur9rKw1Iq3yYyr4fArsrZFnIyF1rXF1SvrZ5Zr4f
        Xr1vgwsrZr1xta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ub6pPUUUUU=
X-Originating-IP: [111.19.34.224]
X-CM-SenderInfo: h2evv3bd6rjloofrz/1tbifBrISVpD9rSXEQAAs6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bfq_bfqq_fifo_expire is checked in bfq_check_fifo,
it causes expired request is not dispatched because
bfq_mark_bfqq_fifo_expire is called.

set async and sync request in different fifo list,
and request can be dispatched by different fifo_expire_async
and fifo_expire_sync value.

Signed-off-by: Zhang Bo <zbsdta@126.com>
---
 block/bfq-iosched.c | 44 ++++++++++++++++++++++++++++++++------------
 block/bfq-iosched.h |  2 +-
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3cce6de464a7..a007ba93ab1d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -151,7 +151,6 @@ BFQ_BFQQ_FNS(just_created);
 BFQ_BFQQ_FNS(busy);
 BFQ_BFQQ_FNS(wait_request);
 BFQ_BFQQ_FNS(non_blocking_wait_rq);
-BFQ_BFQQ_FNS(fifo_expire);
 BFQ_BFQQ_FNS(has_short_ttime);
 BFQ_BFQQ_FNS(sync);
 BFQ_BFQQ_FNS(IO_bound);
@@ -996,16 +995,38 @@ void bfq_weights_tree_remove(struct bfq_queue *bfqq)
 static struct request *bfq_check_fifo(struct bfq_queue *bfqq,
 				      struct request *last)
 {
-	struct request *rq;
+	struct request *rq = NULL;
+	u64 ktime_ns = ktime_get_ns();
+	s64 time_diff = (~((u64)0))>>1;
+	int i;
 
-	if (bfq_bfqq_fifo_expire(bfqq))
-		return NULL;
+	for (i = 0; i < 2; i++) {
+		struct list_head *list_next;
+		struct request *next_rq = NULL;
+
+		//get async and sync request other than last
+		if (!list_empty(&bfqq->fifo[i])) {
+			list_next = bfqq->fifo[i].next;
+			next_rq = rq_entry_fifo(list_next);
+
+			if (next_rq == last) {
+				next_rq = NULL;
+				if (list_next->next != &(bfqq->fifo[i]))
+					next_rq = rq_entry_fifo(list_next->next);
+			}
+		}
 
-	bfq_mark_bfqq_fifo_expire(bfqq);
+		if (next_rq) {
+			s64 diff = next_rq->fifo_time - ktime_ns;
 
-	rq = rq_entry_fifo(bfqq->fifo.next);
+			if (diff <= time_diff) {
+				rq = next_rq;
+				time_diff = diff;
+			}
+		}
+	}
 
-	if (rq == last || ktime_get_ns() < rq->fifo_time)
+	if (!rq)
 		return NULL;
 
 	bfq_log_bfqq(bfqq->bfqd, bfqq, "check_fifo: returned %p", rq);
@@ -3304,8 +3325,6 @@ static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
 				       struct bfq_queue *bfqq)
 {
 	if (bfqq) {
-		bfq_clear_bfqq_fifo_expire(bfqq);
-
 		bfqd->budgets_assigned = (bfqd->budgets_assigned * 7 + 256) / 8;
 
 		if (time_is_before_jiffies(bfqq->last_wr_start_finish) &&
@@ -5403,7 +5422,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 	if (bfqq->bfqd->last_completed_rq_bfqq == bfqq)
 		bfqq->bfqd->last_completed_rq_bfqq = NULL;
 
-	WARN_ON_ONCE(!list_empty(&bfqq->fifo));
+	WARN_ON_ONCE(!list_empty(&bfqq->fifo[0]) && !list_empty(&bfqq->fifo[1]));
 	WARN_ON_ONCE(!RB_EMPTY_ROOT(&bfqq->sort_list));
 	WARN_ON_ONCE(bfqq->dispatched);
 
@@ -5595,7 +5614,8 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqq->actuator_idx = act_idx;
 	RB_CLEAR_NODE(&bfqq->entity.rb_node);
-	INIT_LIST_HEAD(&bfqq->fifo);
+	INIT_LIST_HEAD(&bfqq->fifo[0]);
+	INIT_LIST_HEAD(&bfqq->fifo[1]);
 	INIT_HLIST_NODE(&bfqq->burst_list_node);
 	INIT_HLIST_NODE(&bfqq->woken_list_node);
 	INIT_HLIST_HEAD(&bfqq->woken_list);
@@ -6195,7 +6215,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	idle_timer_disabled = waiting && !bfq_bfqq_wait_request(bfqq);
 
 	rq->fifo_time = ktime_get_ns() + bfqd->bfq_fifo_expire[rq_is_sync(rq)];
-	list_add_tail(&rq->queuelist, &bfqq->fifo);
+	list_add_tail(&rq->queuelist, &bfqq->fifo[rq_is_sync(rq)]);
 
 	bfq_rq_enqueued(bfqd, bfqq, rq);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 467e8cfc41a2..13de66684cf2 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -282,7 +282,7 @@ struct bfq_queue {
 	/* number of pending metadata requests */
 	int meta_pending;
 	/* fifo list of requests in sort_list */
-	struct list_head fifo;
+	struct list_head fifo[2];
 
 	/* entity representing this queue in the scheduler */
 	struct bfq_entity entity;
-- 
2.41.0

