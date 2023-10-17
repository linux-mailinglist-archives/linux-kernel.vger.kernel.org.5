Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6C7CC2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343592AbjJQMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjJQMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:19:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262C3C0B;
        Tue, 17 Oct 2023 05:19:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC6BC433CA;
        Tue, 17 Oct 2023 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697545157;
        bh=h9+pFFk6S6/pR3kzOkCCUyr4lY/4hLmqaxjAdWypwXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTiYxOGUpdxl6LnEq0oYQHVVWNtIIFS0BNm10v346xnZCDzUSzpWjskcFRF5HpDUq
         g4xKUIiR3l0nyHMboEFtRZ+B20T+xF9aWoculjjsXgoRAqq1eC8gYcWqRsFcNqhUxt
         50INoQ5wOe/MgwIFM7Eo7xDC4/fvVuLlth7fpn5ba9cyxyj81Jn0VP5HyNGAriH09O
         3tc5q+YuSqUcduYHj2CkebBIkkXy5VKVyKP78mwK0XG4oWtN3GBLiye8mtWt5Hfrj8
         ENxImfz+yapBpyjn9qAyUyAwCcYER8UnzkcGd4ay8H9fa35EGO+SoABpltdsL15QSQ
         onIIgMpDKFTpg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/3] rcu-tasks: Pull sampling of ->percpu_dequeue_lim out of loop
Date:   Tue, 17 Oct 2023 14:19:04 +0200
Message-Id: <20231017121905.1156166-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017121905.1156166-1-frederic@kernel.org>
References: <20231017121905.1156166-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_tasks_need_gpcb() samples ->percpu_dequeue_lim as part of the
condition clause of a "for" loop, which is a bit confusing.  This commit
therefore hoists this sampling out of the loop, using the result loaded
in the condition clause.

So why does this work in the face of a concurrent switch from single-CPU
queueing to per-CPU queueing?

o	The call_rcu_tasks_generic() that makes the change has already
	enqueued its callback, which means that all of the other CPU's
	callback queues are empty.

o	For the call_rcu_tasks_generic() that first notices
	the switch to per-CPU queues, the smp_store_release()
	used to update ->percpu_enqueue_lim pairs with the
	raw_spin_trylock_rcu_node()'s full barrier that is
	between the READ_ONCE(rtp->percpu_enqueue_shift) and the
	rcu_segcblist_enqueue() that enqueues the callback.

o	Because this CPU's queue is empty (unless it happens to
	be the original single queue, in which case there is no
	need for synchronization), this call_rcu_tasks_generic()
	will do an irq_work_queue() to schedule a handler for the
	needed rcuwait_wake_up() call.	This call will be ordered
	after the first call_rcu_tasks_generic() function's change to
	->percpu_dequeue_lim.

o	This rcuwait_wake_up() will either happen before or after the
	set_current_state() in rcuwait_wait_event().  If it happens
	before, the "condition" argument's call to rcu_tasks_need_gpcb()
	will be ordered after the original change, and all callbacks on
	all CPUs will be visible.  Otherwise, if it happens after, then
	the grace-period kthread's state will be set back to running,
	which will result in a later call to rcuwait_wait_event() and
	thus to rcu_tasks_need_gpcb(), which will again see the change.

So it all works out.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 83049a893de5..94bb5abdbb37 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -432,6 +432,7 @@ static void rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 {
 	int cpu;
+	int dequeue_limit;
 	unsigned long flags;
 	bool gpdone = poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq);
 	long n;
@@ -439,7 +440,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	long ncbsnz = 0;
 	int needgpcb = 0;
 
-	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {
+	dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
+	for (cpu = 0; cpu < dequeue_limit; cpu++) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
-- 
2.34.1

