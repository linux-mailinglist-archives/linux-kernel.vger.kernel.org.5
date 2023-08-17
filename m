Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EF77FA81
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353031AbjHQPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353077AbjHQPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:15:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD915106;
        Thu, 17 Aug 2023 08:15:06 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:10:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692285005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bl4tuELdnwhWhw9COM1jykQ/2VZSxuG3aWQeB4RDFjQ=;
        b=oZHrC27+2xYK6dfNhzv1puq3+JqY1jAlmGNXfrPSr6mUSFHIQWUxwrtz/Y/HIsMi8O2uGv
        UAYa1fSkWWV6wrjuN5iX4LnN7PItZYz3fcY4+oPyzp1l9z3AH6Rzq/4KP//woxrEmbqdvh
        ygfzK/vuOr/0qM/EWhEf9mKlsiZn4h3stzVW2FGCTDJDu181CrbZzsRwfg9FwCQaq9SqZq
        0/XFwdNdzTpx8EuwtLQ+qKlejAsZPqaa5VHi90AwnNn/reJ6parM7W8+S27jWgpcVosCqC
        DIHGS5Rg/ZQ9C5icRbDb+OcAgkUIbXSLLCxDvfnJs5zmM6EDqOMraG/qozYgYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692285005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bl4tuELdnwhWhw9COM1jykQ/2VZSxuG3aWQeB4RDFjQ=;
        b=6GibWP7Aiz1K9pvRlKMOOpjiR+/KCghKAz/U/jFmTLdIjtAsr1WFYAtf2A26Grisl4drgI
        pCt+dqeoLaUPprDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Curb wakeup-preemption
Cc:     Mike Galbraith <umgwanakikbuti@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
References: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     63304558ba5dcaaff9e052ee43cfdcc7f9c29e85
Gitweb:        https://git.kernel.org/tip/63304558ba5dcaaff9e052ee43cfdcc7f9c29e85
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Aug 2023 15:40:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Aug 2023 17:07:07 +02:00

sched/eevdf: Curb wakeup-preemption

Mike and others noticed that EEVDF does like to over-schedule quite a
bit -- which does hurt performance of a number of benchmarks /
workloads.

In particular, what seems to cause over-scheduling is that when lag is
of the same order (or larger) than the request / slice then placement
will not only cause the task to be placed left of current, but also
with a smaller deadline than current, which causes immediate
preemption.

[ notably, lag bounds are relative to HZ ]

Mike suggested we stick to picking 'current' for as long as it's
eligible to run, giving it uninterrupted runtime until it reaches
parity with the pack.

Augment Mike's suggestion by only allowing it to exhaust it's initial
request.

One random data point:

echo NO_RUN_TO_PARITY > /debug/sched/features
perf stat -a -e context-switches --repeat 10 -- perf bench sched messaging -g 20 -t -l 5000

	3,723,554        context-switches      ( +-  0.56% )
	9.5136 +- 0.0394 seconds time elapsed  ( +-  0.41% )

echo RUN_TO_PARITY > /debug/sched/features
perf stat -a -e context-switches --repeat 10 -- perf bench sched messaging -g 20 -t -l 5000

	2,556,535        context-switches      ( +-  0.51% )
	9.2427 +- 0.0302 seconds time elapsed  ( +-  0.33% )

Suggested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230816134059.GC982867@hirez.programming.kicks-ass.net
---
 kernel/sched/fair.c     | 12 ++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f496cef..0b7445c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -873,6 +873,13 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
+	/*
+	 * Once selected, run a task until it either becomes non-eligible or
+	 * until it gets a new slice. See the HACK in set_next_entity().
+	 */
+	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+		return curr;
+
 	while (node) {
 		struct sched_entity *se = __node_2_se(node);
 
@@ -5167,6 +5174,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
+		/*
+		 * HACK, stash a copy of deadline at the point of pick in vlag,
+		 * which isn't used until dequeue.
+		 */
+		se->vlag = se->deadline;
 	}
 
 	update_stats_curr_start(cfs_rq, se);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 61bcbf5..f770168 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -6,6 +6,7 @@
  */
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
+SCHED_FEAT(RUN_TO_PARITY, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
