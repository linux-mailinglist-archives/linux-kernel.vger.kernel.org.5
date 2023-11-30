Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757DE7FF473
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjK3QNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3QNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6D3E0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701360795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5v5HF9JM8HvOIjXsHVTbSVoKzguZO3nxGABkNDWM40=;
        b=E3eN80Yd5Nqyf2WeCGr7M3jQGMg36Hg0zz7Xq5K/bID7CwTXHT6aFQnggbr1RMS/ogAhKI
        kx4fIQN+Fp+GXLkAvrlJNajg2jkmeArB188g2wYSyPRzl3bHuyoDH/bmESPIPTFwmvDQk6
        wUQEWHGnn80oc/RTMXvelKSg6UCEdDg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-AP2U17PkP3mX6PHHWNr1uQ-1; Thu,
 30 Nov 2023 11:13:13 -0500
X-MC-Unique: AP2U17PkP3mX6PHHWNr1uQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2057B1C0634D;
        Thu, 30 Nov 2023 16:13:11 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.195.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB0AC15881;
        Thu, 30 Nov 2023 16:13:08 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH 2/2] sched/fair: Repurpose cfs_rq_throttled()
Date:   Thu, 30 Nov 2023 17:12:44 +0100
Message-ID: <20231130161245.3894682-3-vschneid@redhat.com>
In-Reply-To: <20231130161245.3894682-1-vschneid@redhat.com>
References: <20231130161245.3894682-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs_rq->throttled is now never set, as cfs_rq's are never fully throttled
but rather stay in limbo as tasks are slowly plucked out of them.

Get rid of cfs_rq->throttled, and repurpose cfs_rq_throttled() to use the
limbo meaning.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c  | 57 ++++++--------------------------------------
 kernel/sched/sched.h |  3 +--
 2 files changed, 8 insertions(+), 52 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 27aee13e7ccd9..fd3a0c388fabd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5497,7 +5497,7 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 	if (likely(cfs_rq->runtime_remaining > 0))
 		return;
 
-	if (cfs_rq->throttled || cfs_rq->in_throttle_limbo)
+	if (cfs_rq->in_throttle_limbo)
 		return;
 	/*
 	 * if we're unable to extend our runtime we resched so that the active
@@ -5518,7 +5518,7 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
-	return cfs_bandwidth_used() && cfs_rq->throttled;
+	return cfs_bandwidth_used() && cfs_rq->in_throttle_limbo;
 }
 
 /* check whether cfs_rq, or any parent, is throttled */
@@ -5848,10 +5848,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
 	}
 
 	for_each_sched_entity(se) {
@@ -5862,10 +5858,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -5909,7 +5901,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 				 throttled_csd_list) {
 		list_del_init(&cursor->throttled_csd_list);
 
-		if (cfs_rq_throttled(cursor) || cursor->in_throttle_limbo)
+		if (cfs_rq_throttled(cursor))
 			unthrottle_cfs_rq(cursor);
 	}
 
@@ -5949,7 +5941,7 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
 	lockdep_assert_rq_held(rq_of(cfs_rq));
 
-	if (SCHED_WARN_ON(!(cfs_rq_throttled(cfs_rq) || cfs_rq->in_throttle_limbo) ||
+	if (SCHED_WARN_ON(!cfs_rq_throttled(cfs_rq) ||
 	    cfs_rq->runtime_remaining <= 0))
 		return;
 
@@ -5982,7 +5974,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		 * waiting for tasks to exit the kernel. In this case we still
 		 * want to replenish.
 		 */
-		if (!cfs_rq_throttled(cfs_rq) && !cfs_rq->in_throttle_limbo)
+		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
 		/* Already queued for async unthrottle */
@@ -6031,7 +6023,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		list_del_init(&cfs_rq->throttled_csd_list);
 
-		if (cfs_rq_throttled(cfs_rq) || cfs_rq->in_throttle_limbo)
+		if (cfs_rq_throttled(cfs_rq))
 			unthrottle_cfs_rq(cfs_rq);
 
 		rq_unlock_irqrestore(rq, &rf);
@@ -6230,10 +6222,6 @@ static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
 	if (!cfs_rq->runtime_enabled || cfs_rq->curr)
 		return;
 
-	/* ensure the group is not already throttled */
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
 	/* update runtime allocation */
 	account_cfs_rq_runtime(cfs_rq, 0);
 	if (cfs_rq->runtime_remaining <= 0)
@@ -6266,13 +6254,6 @@ static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	if (likely(!cfs_rq->runtime_enabled || cfs_rq->runtime_remaining > 0))
 		return false;
 
-	/*
-	 * it's possible for a throttled entity to be forced into a running
-	 * state (e.g. set_curr_task), in this case we're finished.
-	 */
-	if (cfs_rq_throttled(cfs_rq))
-		return true;
-
 	return throttle_cfs_rq(cfs_rq);
 }
 
@@ -6705,10 +6686,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
 		flags = ENQUEUE_WAKEUP;
 	}
 
@@ -6724,10 +6701,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6750,7 +6723,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
-enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
@@ -6783,10 +6755,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6815,10 +6783,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6828,7 +6792,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
-dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -9582,7 +9545,7 @@ static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
  * Something like:
  *
  *	{ 0 1 2 3 } { 4 5 6 7 }
- *	        *     * * *
+ *		*     * * *
  *
  * If we were to balance group-wise we'd place two tasks in the first group and
  * two tasks in the second group. Clearly this is undesired as it will overload
@@ -12642,9 +12605,6 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
 	if (!throttled_hierarchy(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
 
@@ -12656,9 +12616,6 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
 		if (!throttled_hierarchy(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be29154d93898..7f1afee52a776 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -631,9 +631,8 @@ struct cfs_rq {
 	u64			throttled_clock_pelt_time;
 	u64			throttled_clock_self;
 	u64			throttled_clock_self_time;
-	int			throttled;
-	int			throttle_count;
 	int                     in_throttle_limbo;
+	int			throttle_count;
 	/* Temp storage for updating the counts during unthrottling */
 	unsigned int            unthrottled_h_nr_running;
 	unsigned int            unthrottled_idle_h_nr_running;
-- 
2.41.0

