Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A087C7F75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjJMIGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJMIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:06:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9872D6;
        Fri, 13 Oct 2023 01:06:14 -0700 (PDT)
Date:   Fri, 13 Oct 2023 08:06:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697184372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=656BvBw44w6T3gJEP1Z++Mh0yEockSdVnsSkEJHEiRQ=;
        b=C38ihFgqZAIKycWd5hwDZSJMuECgdFEDrJo4CJKqdXS9saBt9gGiz4nzD7kV0RWqnLW+dl
        g7pL6OYMXyLwAGR4sEXGEIH+m/Srn3CUFrI4orrX3KHsc4MotmZyYiqsXtKbOvVty7Vyyi
        iSdc/WW4x4BUZroCSf72nBbHmE9tKOdO5FfNskCG9XhBvXuos1QG+eg9jZpRs6gwJOfIfD
        Co0uwh1pVFG+qwQETMnI7U1HQDuUEVjk4h1M58nE7YpiyD8+sE81abDDfjXB127bRKD3pl
        WKrGhNZgORVI6WKH4Sfe0fp80j5DmqmgmQ9oeq4hhTUwMYID9pWkxbUDMzOeNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697184372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=656BvBw44w6T3gJEP1Z++Mh0yEockSdVnsSkEJHEiRQ=;
        b=VSZPaPYZp+jEzc2ZsqXMQ1NPafz8FyR8PIokJzu/xNKPfyTVE649ccmEVoxDG13snXk2Is
        /lRVb+9UwmjTPaAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix stop_one_cpu_nowait() vs hotplug
Cc:     Kuyo.Chang@mediatek.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010200442.GA16515@noisy.programming.kicks-ass.net>
References: <20231010200442.GA16515@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169718437206.3135.7707775956357413477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f0498d2a54e7966ce23cd7c7ff42c64fa0059b07
Gitweb:        https://git.kernel.org/tip/f0498d2a54e7966ce23cd7c7ff42c64fa00=
59b07
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Oct 2023 20:57:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 13 Oct 2023 09:56:29 +02:00

sched: Fix stop_one_cpu_nowait() vs hotplug

Kuyo reported sporadic failures on a sched_setaffinity() vs CPU
hotplug stress-test -- notably affine_move_task() remains stuck in
wait_for_completion(), leading to a hung-task detector warning.

Specifically, it was reported that stop_one_cpu_nowait(.fn =3D
migration_cpu_stop) returns false -- this stopper is responsible for
the matching complete().

The race scenario is:

	CPU0					CPU1

					// doing _cpu_down()

  __set_cpus_allowed_ptr()
    task_rq_lock();
					takedown_cpu()
					  stop_machine_cpuslocked(take_cpu_down..)

					<PREEMPT: cpu_stopper_thread()
					  MULTI_STOP_PREPARE
					  ...
    __set_cpus_allowed_ptr_locked()
      affine_move_task()
        task_rq_unlock();

  <PREEMPT: cpu_stopper_thread()\>
    ack_state()
					  MULTI_STOP_RUN
					    take_cpu_down()
					      __cpu_disable();
					      stop_machine_park();
						stopper->enabled =3D false;
					 />
   />
	stop_one_cpu_nowait(.fn =3D migration_cpu_stop);
          if (stopper->enabled) // false!!!

That is, by doing stop_one_cpu_nowait() after dropping rq-lock, the
stopper thread gets a chance to preempt and allows the cpu-down for
the target CPU to complete.

OTOH, since stop_one_cpu_nowait() / cpu_stop_queue_work() needs to
issue a wakeup, it must not be ran under the scheduler locks.

Solve this apparent contradiction by keeping preemption disabled over
the unlock + queue_stopper combination:

	preempt_disable();
	task_rq_unlock(...);
	if (!stop_pending)
	  stop_one_cpu_nowait(...)
	preempt_enable();

This respects the lock ordering contraints while still avoiding the
above race. That is, if we find the CPU is online under rq-lock, the
targeted stop_one_cpu_nowait() must succeed.

Apply this pattern to all similar stop_one_cpu_nowait() invocations.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Reported-by: "Kuyo Chang (=E5=BC=B5=E5=BB=BA=E6=96=87)" <Kuyo.Chang@mediatek.=
com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Kuyo Chang (=E5=BC=B5=E5=BB=BA=E6=96=87)" <Kuyo.Chang@mediatek.co=
m>
Link: https://lkml.kernel.org/r/20231010200442.GA16515@noisy.programming.kick=
s-ass.net
---
 kernel/sched/core.c     | 10 ++++++++--
 kernel/sched/deadline.c |  2 ++
 kernel/sched/fair.c     |  4 +++-
 kernel/sched/rt.c       |  4 ++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a3f9cd5..264c2eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2645,9 +2645,11 @@ static int migration_cpu_stop(void *data)
 		 * it.
 		 */
 		WARN_ON_ONCE(!pending->stop_pending);
+		preempt_disable();
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
+		preempt_enable();
 		return 0;
 	}
 out:
@@ -2967,12 +2969,13 @@ static int affine_move_task(struct rq *rq, struct tas=
k_struct *p, struct rq_flag
 			complete =3D true;
 		}
=20
+		preempt_disable();
 		task_rq_unlock(rq, p, rf);
-
 		if (push_task) {
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    p, &rq->push_work);
 		}
+		preempt_enable();
=20
 		if (complete)
 			complete_all(&pending->done);
@@ -3038,12 +3041,13 @@ static int affine_move_task(struct rq *rq, struct tas=
k_struct *p, struct rq_flag
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &=3D ~MDF_PUSH;
=20
+		preempt_disable();
 		task_rq_unlock(rq, p, rf);
-
 		if (!stop_pending) {
 			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 					    &pending->arg, &pending->stop_work);
 		}
+		preempt_enable();
=20
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
@@ -9421,9 +9425,11 @@ static void balance_push(struct rq *rq)
 	 * Temporarily drop rq->lock such that we can wake-up the stop task.
 	 * Both preemption and IRQs are still disabled.
 	 */
+	preempt_disable();
 	raw_spin_rq_unlock(rq);
 	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
 			    this_cpu_ptr(&push_work));
+	preempt_enable();
 	/*
 	 * At this point need_resched() is true and we'll take the loop in
 	 * schedule(). The next pick is obviously going to be the stop task
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7039a8d..b281144 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2420,9 +2420,11 @@ skip:
 		double_unlock_balance(this_rq, src_rq);
=20
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(this_rq);
 		}
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a751e55..38d757c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11254,13 +11254,15 @@ more_balance:
 				busiest->push_cpu =3D this_cpu;
 				active_balance =3D 1;
 			}
-			raw_spin_rq_unlock_irqrestore(busiest, flags);
=20
+			preempt_disable();
+			raw_spin_rq_unlock_irqrestore(busiest, flags);
 			if (active_balance) {
 				stop_one_cpu_nowait(cpu_of(busiest),
 					active_load_balance_cpu_stop, busiest,
 					&busiest->active_balance_work);
 			}
+			preempt_enable();
 		}
 	} else {
 		sd->nr_balance_failed =3D 0;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e93b69e..6aaf0a3 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2063,9 +2063,11 @@ retry:
 		 */
 		push_task =3D get_push_task(rq);
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(rq);
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    push_task, &rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(rq);
 		}
=20
@@ -2402,9 +2404,11 @@ skip:
 		double_unlock_balance(this_rq, src_rq);
=20
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(this_rq);
 		}
 	}
