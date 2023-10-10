Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA147C40C9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjJJUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:07:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32263135
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3oQwwKYwoiZ0SHY/ewVGJIxzoCy1EpL15euKfoG+Nm4=; b=nxi6ki9eV37suWsQbArzTWN5mq
        glkierP26zkTuu3TneEwh+vLLif+J+JUOQjIwvfjvmbZ2t3lHsUI1QvpsZ/Q8Wc9DffoUYmTO0CFl
        7jV6RY8nuwENh5D7inZnNa1rROwNs9rImi4QgioqXpF4EzzKbR1nd5gzfrFomqA6A7yZSgCcDwOhc
        H3ETW0vty5I53RP0RYb36cggPiwx33fDh8P47Tzu0cIYvd0CStWflEDH+RlYO0arSoQ5fSea1uPDj
        mXHSeNHcByNcXmMM8PItN11/P4DDcFXfD0do1T9oENp1qh44BVxUT2X+fJpIMBLcYrcADqFBhbZJE
        DhdWwCpw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqIyA-006Y9B-U1; Tue, 10 Oct 2023 20:04:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A292300392; Tue, 10 Oct 2023 22:04:42 +0200 (CEST)
Date:   Tue, 10 Oct 2023 22:04:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kuyo Chang =?utf-8?B?KOW8teW7uuaWhyk=?= <Kuyo.Chang@mediatek.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] sched: Fix stop_one_cpu_nowait() vs hotplug
Message-ID: <20231010200442.GA16515@noisy.programming.kicks-ass.net>
References: <20230927033431.12406-1-kuyo.chang@mediatek.com>
 <20230927080850.GB21824@noisy.programming.kicks-ass.net>
 <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
 <20230929102135.GD6282@noisy.programming.kicks-ass.net>
 <8ad1b617a1040ce4cc56a5d04e8219b5313a9a6e.camel@mediatek.com>
 <20231010145747.GQ377@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010145747.GQ377@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 04:57:47PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 10, 2023 at 02:40:22PM +0000, Kuyo Chang (張建文) wrote:

> > It is running good so far(more than a week)on hotplug/set affinity
> > stress test. I will keep it testing and report back if it happens
> > again.
> 
> OK, I suppose I should look at writing a coherent Changelog for this
> then...

Something like the below... ?

---
Subject: sched: Fix stop_one_cpu_nowait() vs hotplug
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Oct 10 20:57:39 CEST 2023

Kuyo reported sporadic failures on a sched_setaffinity() vs CPU
hotplug stress-test -- notably affine_move_task() remains stuck in
wait_for_completion(), leading to a hung-task detector warning.

Specifically, it was reported that stop_one_cpu_nowait(.fn =
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
						stopper->enabled = false;
					 />
   />
	stop_one_cpu_nowait(.fn = migration_cpu_stop);
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
Reported-by: "Kuyo Chang (張建文)" <Kuyo.Chang@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Kuyo Chang (張建文)" <Kuyo.Chang@mediatek.com>
---
 kernel/sched/core.c     |   10 ++++++++--
 kernel/sched/deadline.c |    2 ++
 kernel/sched/fair.c     |    4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2645,9 +2645,11 @@ static int migration_cpu_stop(void *data
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
@@ -2967,12 +2969,13 @@ static int affine_move_task(struct rq *r
 			complete = true;
 		}
 
+		preempt_disable();
 		task_rq_unlock(rq, p, rf);
-
 		if (push_task) {
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    p, &rq->push_work);
 		}
+		preempt_enable();
 
 		if (complete)
 			complete_all(&pending->done);
@@ -3038,12 +3041,13 @@ static int affine_move_task(struct rq *r
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
 
+		preempt_disable();
 		task_rq_unlock(rq, p, rf);
-
 		if (!stop_pending) {
 			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 					    &pending->arg, &pending->stop_work);
 		}
+		preempt_enable();
 
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
@@ -9459,9 +9463,11 @@ static void balance_push(struct rq *rq)
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
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2420,9 +2420,11 @@ static void pull_dl_task(struct rq *this
 		double_unlock_balance(this_rq, src_rq);
 
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(this_rq);
 		}
 	}
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11299,13 +11299,15 @@ static int load_balance(int this_cpu, st
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			raw_spin_rq_unlock_irqrestore(busiest, flags);
 
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
 		sd->nr_balance_failed = 0;
