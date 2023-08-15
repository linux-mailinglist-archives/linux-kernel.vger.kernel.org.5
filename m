Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5EE77CDFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbjHOOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbjHOOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC719A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:21:26 -0700 (PDT)
Date:   Tue, 15 Aug 2023 16:21:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692109284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjBimM/Q3f/ABJHy15farAKcBiKrOd1U7yKRUJCexo4=;
        b=yhwxYUYS89B+CmyvG+nvxdsW1U2rVNMR98i8gD9KPFRWDIhrbJl1mQnPNRf6X6FMNqpma0
        j1JRfhItcCgxUup4CKKbs/NtSJFwN+eoF1vzNPdgtBweBjDbf3Bx2f3f7L1/2fYFcsNVnC
        47ASyDwmh22n1EfDrAR74443y1C59DQmq0NcGEix5YsGWT7nqDHG+kZdzAyGynjuz3w5M/
        yl+4Ot9h/kNCVJhF/zY7pQJl4NRw3qk7ykvm8wHt3RhCLutmdkJCiRKpYcfThMDUyVTYoo
        mJWT09atdkNqC3MB9TVpCLahE/HWHaTyZ6oBYG/VheMgg4cZO4EqHm0wATrRkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692109284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjBimM/Q3f/ABJHy15farAKcBiKrOd1U7yKRUJCexo4=;
        b=H8peSrMauEJmlZKF862dNsl+t61JK6aXUcbvzN+XYROl7BrDCYmr80PepMFotxHbr8fKNF
        wC/AhaY/TPZkjaDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/rt: Make rt_rq->pushable_tasks updates drive
 rto_mask
Message-ID: <20230815142121.MoZplZUr@linutronix.de>
References: <20230811112044.3302588-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230811112044.3302588-1-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-11 12:20:44 [+0100], Valentin Schneider wrote:
> Sebastian noted that the rto_push_work IRQ work can be queued for a CPU
> that has an empty pushable_tasks list, which means nothing useful will be
> done in the IPI other than queue the work for the next CPU on the rto_mas=
k.
>=20
> rto_push_irq_work_func() only operates on tasks in the pushable_tasks lis=
t,
> but the conditions for that irq_work to be queued (and for a CPU to be
> added to the rto_mask) rely on rq_rt->nr_migratory instead.
>=20
> nr_migratory is increased whenever an RT task entity is enqueued and it h=
as
> nr_cpus_allowed > 1. Unlike the pushable_tasks list, nr_migratory include=
s a
> rt_rq's current task. This means a rt_rq can have a migratible current, N
> non-migratible queued tasks, and be flagged as overloaded / have its CPU
> set in the rto_mask, despite having an empty pushable_tasks list.
>=20
> Make an rt_rq's overload logic be driven by {enqueue,dequeue}_pushable_ta=
sk().
> Since rt_rq->{rt_nr_migratory,rt_nr_total} become unused, remove them.
>=20
> Note that the case where the current task is pushed away to make way for a
> migration-disabled task remains unchanged: the migration-disabled task has
> to be in the pushable_tasks list in the first place, which means it has
> nr_cpus_allowed > 1.
>=20
> Link: http://lore.kernel.org/r/20230801152648._y603AS_@linutronix.de
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
> This is lightly tested, this looks to be working OK but I don't have nor =
am
> I aware of a test case for RT balancing, I suppose we want something that
> asserts we always run the N highest prio tasks for N CPUs, with a small
> margin for migrations?

I don't see the storm of IPIs I saw before. So as far that goes:
   Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

What I still observe is:
- CPU0 is idle. CPU0 gets a task assigned from CPU1. That task receives
  a wakeup. CPU0 returns from idle and schedules the task.
  pull_rt_task() on CPU1 and sometimes on other CPU observe this, too.
  CPU1 sends irq_work to CPU0 while at the time rto_next_cpu() sees that
  has_pushable_tasks() return 0. That bit was cleared earlier (as per
  tracing).

- CPU0 is idle. CPU0 gets a task assigned from CPU1. The task on CPU0 is
  woken up without an IPI (yay). But then pull_rt_task() decides that
  send irq_work and has_pushable_tasks() said that is has tasks left
  so=E2=80=A6.
  Now: rto_push_irq_work_func() run once once on CPU0, does nothing,
  rto_next_cpu() return CPU0 again and enqueues itself again on CPU0.
  Usually after the second or third round the scheduler on CPU0 makes
  enough progress to remove the task/ clear the CPU from mask.

I understand that there is a race and the CPU is cleared from rto_mask
shortly after checking. Therefore I would suggest to look at
has_pushable_tasks() before returning a CPU in rto_next_cpu() as I did
just to avoid the interruption which does nothing.

For the second case the irq_work seems to make no progress. I don't see
any trace_events in hardirq, the mask is cleared outside hardirq (idle
code). The NEED_RESCHED bit is set for current therefore it doesn't make
sense to send irq_work to reschedule if the current already has this on
its agenda.

So what about something like:

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 00e0e50741153..d963408855e25 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2247,8 +2247,23 @@ static int rto_next_cpu(struct root_domain *rd)
=20
 		rd->rto_cpu =3D cpu;
=20
-		if (cpu < nr_cpu_ids)
+		if (cpu < nr_cpu_ids) {
+			struct task_struct *t;
+
+			if (!has_pushable_tasks(cpu_rq(cpu)))
+				continue;
+
+			rcu_read_lock();
+			t =3D rcu_dereference(rq->curr);
+			/* if (test_preempt_need_resched_cpu(cpu_rq(cpu))) */
+			if (test_tsk_need_resched(t)) {
+				rcu_read_unlock();
+				continue;
+			}
+			rcu_read_unlock();
+
 			return cpu;
+		}
=20
 		rd->rto_cpu =3D -1;
=20
Sebastian
