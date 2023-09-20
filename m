Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74E7A838E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjITNiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjITNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:38:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9BDA9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:38:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 15:38:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695217090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQfGVmEsOOjiPYezvnOK3n9E3yRIMKH1t46B5zY+nJY=;
        b=sTFsj301dhd9ng7OvdLh0/1ksd5y7L8FiIwj7+6vwwytT6Fm+fpt0MAHWLKtLcjHMl5FFK
        ADf/7zT6QMVSWjUxlQP/eSSlSrxYmmoR4n+OZ3Ei7zoMr8WDrErJhoowG6CmjV5jRbDQ9W
        7f9tAUROIQBEjA2cT6fM0hfzgbvGGJgEdkCfqe4KkVOD7BvmU+WV1ws6oFV+XQveZmcoTZ
        qKQoy8wwJ1MiIw2Yhn6jPCxBiaWdbw+A77PWeNl5a7mEy2G3UjLJvd+kinOQ1mLNcZLQvv
        ESlN1/W5ypioUasG23NKezM8J2123anHsDgLSzZvk1aaJsDiu5oUoQsJFFitdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695217090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQfGVmEsOOjiPYezvnOK3n9E3yRIMKH1t46B5zY+nJY=;
        b=56pKgu923DqG+9sgAd0pdNa6b0woJq3XRZfc72N7n3+oOAUno24EeS7wP/6R3LKA8QbLgm
        C6R1J3zadCZES7Ag==
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
Message-ID: <20230920133806.HyAqFKOa@linutronix.de>
References: <20230811112044.3302588-1-vschneid@redhat.com>
 <20230815142121.MoZplZUr@linutronix.de>
 <xhsmhpm2prnd1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xhsmhpm2prnd1.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-11 12:54:50 [+0200], Valentin Schneider wrote:
> Ok, back to this :)
>=20
> On 15/08/23 16:21, Sebastian Andrzej Siewior wrote:
> > What I still observe is:
> > - CPU0 is idle. CPU0 gets a task assigned from CPU1. That task receives
> >   a wakeup. CPU0 returns from idle and schedules the task.
> >   pull_rt_task() on CPU1 and sometimes on other CPU observe this, too.
> >   CPU1 sends irq_work to CPU0 while at the time rto_next_cpu() sees that
> >   has_pushable_tasks() return 0. That bit was cleared earlier (as per
> >   tracing).
> >
> > - CPU0 is idle. CPU0 gets a task assigned from CPU1. The task on CPU0 is
> >   woken up without an IPI (yay). But then pull_rt_task() decides that
> >   send irq_work and has_pushable_tasks() said that is has tasks left
> >   so=E2=80=A6.
> >   Now: rto_push_irq_work_func() run once once on CPU0, does nothing,
> >   rto_next_cpu() return CPU0 again and enqueues itself again on CPU0.
> >   Usually after the second or third round the scheduler on CPU0 makes
> >   enough progress to remove the task/ clear the CPU from mask.
> >
>=20
> If CPU0 is selected for the push IPI, then we should have
>=20
>   rd->rto_cpu =3D=3D CPU0
>=20
> So per the
>=20
>   cpumask_next(rd->rto_cpu, rd->rto_mask);
>=20
> in rto_next_cpu(), it shouldn't be able to re-select itself.
>=20
> Do you have a simple enough reproducer I could use to poke at this?

Not really a reproducer. What I had earlier was a high priority RT task
(ntpsec at prio 99) and cyclictest below it (prio 90). And PREEMPT_RT
which adds a few tasks (due to threaded interrupts).=20
Then I added trace-printks to observe. Initially I had latency spikes
due to ntpsec but also a bunch IRQ-work-IPIs which I decided to look at.

> > I understand that there is a race and the CPU is cleared from rto_mask
> > shortly after checking. Therefore I would suggest to look at
> > has_pushable_tasks() before returning a CPU in rto_next_cpu() as I did
> > just to avoid the interruption which does nothing.
> >
> > For the second case the irq_work seems to make no progress. I don't see
> > any trace_events in hardirq, the mask is cleared outside hardirq (idle
> > code). The NEED_RESCHED bit is set for current therefore it doesn't make
> > sense to send irq_work to reschedule if the current already has this on
> > its agenda.
> >
> > So what about something like:
> >
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index 00e0e50741153..d963408855e25 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -2247,8 +2247,23 @@ static int rto_next_cpu(struct root_domain *rd)
> >
> >               rd->rto_cpu =3D cpu;
> >
> > -		if (cpu < nr_cpu_ids)
> > +		if (cpu < nr_cpu_ids) {
> > +			struct task_struct *t;
> > +
> > +			if (!has_pushable_tasks(cpu_rq(cpu)))
> > +				continue;
> > +
>=20
> IIUC that's just to plug the race between the CPU emptying its
> pushable_tasks list and it removing itself from the rto_mask - that looks
> fine to me.
>=20
> > +			rcu_read_lock();
> > +			t =3D rcu_dereference(rq->curr);
> > +			/* if (test_preempt_need_resched_cpu(cpu_rq(cpu))) */
> > +			if (test_tsk_need_resched(t)) {
>=20
> We need to make sure this doesn't cause us to loose IPIs we actually need.
>=20
> We do have a call to put_prev_task_balance() through entering __schedule()
> if the previous task is RT/DL, and balance_rt() can issue a push
> IPI, but AFAICT only if the previous task was the last DL task. So I don't
> think we can do this.

I observed that the CPU/ task on that CPU already had the need-resched
bit set so a task-switch is in progress. Therefore it looks like any
further IPIs are needless because the IRQ-work IPI just "leave early"
via resched_curr() and don't do anything useful. So they don't
contribute anything but stall the CPU from making progress and
performing the actual context switch.

> > +				rcu_read_unlock();
> > +				continue;
> > +			}
> > +			rcu_read_unlock();
> > +
> >                       return cpu;
> > +		}
> >
> >               rd->rto_cpu =3D -1;

Sebastian
