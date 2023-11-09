Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CE17E6331
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKIFcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKIFcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:32:05 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3931D25BB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:32:03 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1e9c42fc0c9so225518fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 21:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699507922; x=1700112722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZXvyvdhKUCUJs8L2nDGZPBHyNmLeJWbGLP29a0VNiQ=;
        b=dGlUTiv7ih0srkb4lO6tzpi3MBOr99TvY2C6I5154wgYjIqZ7Rwr++/YDTgUsVmYgd
         zra58CHkYJX3WiUs/g9QSwwuO4h9taLbmPaXvtsuCa7U/yQwUncQOFeh+gHwZhojNJeA
         5rHyE5YwIbhzLO5eeKrtGHA+kPLYGjDXhnoFL1h9H+6cRb7SD187g99Yg3Cib3CwsOrv
         spe6p23gk4gYJgy7kNX/SMK/xs1EJoJmvyNwdNB0de3aWSv/NxyDCMe+HXx28aPbCYI2
         w5WHLYXEFWdBr8wCG3zWmcJ+fPLqXOf9mprxWEOnuL0w0A02O43qZ2LuygiB1haZuRTQ
         6qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699507922; x=1700112722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZXvyvdhKUCUJs8L2nDGZPBHyNmLeJWbGLP29a0VNiQ=;
        b=Mp6nNxIepkjWV8p6iJGk6cOuHG9tRgHLzKmMJ+E8g2yZ6iTdsLnfrYhrIiuMtJcot1
         Ds5PpmCsEddQ2XLiKE+07iFQtZz1+XDAozB394OGv9GSIvDW4kVcn+XKPS/EIVIXBD7P
         NAZbBxp2mAalbLwzBfLNmsrjEX5e5WFcAA3+/iyjWIOaSGIX+Sb4UXnNMXQkZxmScA8L
         KebFZpFLzUqknqEZLC4KLbYMmj1kXfMgf6CbfPWh/4loiyDlo9i0TJKkxyo66Bq1Gcc6
         KSRxI1Zs98UV40M5AztXm4m6sF+O2vys0yoFgoVbNzngxfZcAex+5mVFM/NFZl2pa6fP
         tzTQ==
X-Gm-Message-State: AOJu0YzZ1iNYdtw7tqfQ3q5w4IAyzIfdR6rPtjPrbdQIIT9q6vOShiw6
        s8CgB2aK6g/Ja9u2v7KMREdMofYqW/dDPoJ4BBM=
X-Google-Smtp-Source: AGHT+IEmJjKM47Bl1K016OY/D+eW+K34md6cS3eaoOVs9/lRg1wX/HrCh8rCRxrQ1KTR3nGCZLVvLVFPxZ33S8fraVc=
X-Received: by 2002:a05:6871:3312:b0:1ef:b356:c387 with SMTP id
 nf18-20020a056871331200b001efb356c387mr4311980oac.38.1699507922377; Wed, 08
 Nov 2023 21:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <20231106193524.866104-19-jstultz@google.com>
In-Reply-To: <20231106193524.866104-19-jstultz@google.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 9 Nov 2023 13:31:51 +0800
Message-ID: <CAB8ipk8faF30V8_maGiB62adBg6PLfynGg3p6PBoGJO_rzS7_Q@mail.gmail.com>
Subject: Re: [PATCH v6 18/20] sched: Handle blocked-waiter migration (and
 return migration)
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 3:37=E2=80=AFAM John Stultz <jstultz@google.com> wro=
te:
>
> Add logic to handle migrating a blocked waiter to a remote
> cpu where the lock owner is runnable.
>
> Additionally, as the blocked task may not be able to run
> on the remote cpu, add logic to handle return migration once
> the waiting task is given the mutex.
>
> Because tasks may get migrated to where they cannot run,
> this patch also modifies the scheduling classes to avoid
> sched class migrations on mutex blocked tasks, leaving
> proxy() to do the migrations and return migrations.
>
> This was split out from the larger proxy patch, and
> significantly reworked to avoid changes to the try_to_wakeup()
> call path.
>
> Credits for the original patch go to:
>   Peter Zijlstra (Intel) <peterz@infradead.org>
>   Juri Lelli <juri.lelli@redhat.com>
>   Valentin Schneider <valentin.schneider@arm.com>
>   Connor O'Brien <connoro@google.com>
>
> NOTE: The return migration is further complicated in that we
> need to take the pi_lock in order to decide which cpu we should
> migrate back to. This requires dropping the current rq lock,
> grabbing the pi_lock re-taking the current rq lock, picking a
> cpu, deactivating the task, switching its cpu, dropping the
> current rq lock, grabbing the target rq, activating the task
> and then dropping the target rq and reaquiring the current
> rq. This seems overly complex, so suggestions for a better
> approach would be welcome!
>
> TODO: Seeing stalls/hangs after running for awhile with this
> patch, which suggests we're losing track of a task somewhere
> in the migrations.
> [  880.032744] BUG: workqueue lockup - pool cpus=3D11 node=3D0 flags=3D0x=
0 nice=3D0 stuck for 58s!
> ...
> [ 1443.185762] watchdog: BUG: soft lockup - CPU#11 stuck for 23s! [irqbal=
ance:1880]
> ...
>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v6:
> * Integrated sched_proxy_exec() check in proxy_return_migration()
> * Minor cleanups to diff
> * Unpin the rq before calling __balance_callbacks()
> * Tweak proxy migrate to migrate deeper task in chain, to avoid
>   tasks pingponging between rqs
> ---
>  kernel/sched/core.c     | 183 ++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/deadline.c |   2 +-
>  kernel/sched/fair.c     |   4 +-
>  kernel/sched/rt.c       |   9 +-
>  4 files changed, 187 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c7b5cb5d8dc3..760e2753a24c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3000,8 +3000,15 @@ static int affine_move_task(struct rq *rq, struct =
task_struct *p, struct rq_flag
>         struct set_affinity_pending my_pending =3D { }, *pending =3D NULL=
;
>         bool stop_pending, complete =3D false;
>
> -       /* Can the task run on the task's current CPU? If so, we're done =
*/
> -       if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
> +       /*
> +        * Can the task run on the task's current CPU? If so, we're done
> +        *
> +        * We are also done if the task is selected, boosting a lock-
> +        * holding proxy, (and potentially has been migrated outside its
> +        * current or previous affinity mask)
> +        */
> +       if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
> +           (task_current_selected(rq, p) && !task_current(rq, p))) {
>                 struct task_struct *push_task =3D NULL;
>
>                 if ((flags & SCA_MIGRATE_ENABLE) &&
> @@ -6636,6 +6643,141 @@ bool proxy_deactivate(struct rq *rq, struct task_=
struct *next)
>         return true;
>  }
>
> +static struct task_struct *
> +proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> +                  struct task_struct *p, int that_cpu)
> +{
> +       struct rq *that_rq;
> +       int wake_cpu;
> +
> +       /*
> +        * If the blocked-on relationship crosses CPUs, migrate @p to the
> +        * @owner's CPU.
> +        *
> +        * This is because we must respect the CPU affinity of execution
> +        * contexts (@owner) but we can ignore affinity for scheduling
> +        * contexts (@p). So we have to move scheduling contexts towards
> +        * potential execution contexts.
> +        */

Hi John,

I understand what you mean here. But I have some other worries:
considering the scenario of Big-Little cpu topology, when EAS is in
effect.
If the owner is a "small task", and the owner is on a small core, and
the blocked task is a "big task", the block task will be directly
migrated to the small core,
and because the task is on rq, when wake up, it would skip the
=E2=80=9Cselect_task_rq=E2=80=9D and put it directly on the small core.
As a result, the big task's performance may decrease.
The same reason, a small task may be placed on the big core, and there
may be a regression in power consumption.

> +       that_rq =3D cpu_rq(that_cpu);
> +
> +       /*
> +        * @owner can disappear, but simply migrate to @that_cpu and leav=
e
> +        * that CPU to sort things out.
> +        */
> +
> +       /*
> +        * Since we're going to drop @rq, we have to put(@rq_selected) fi=
rst,
> +        * otherwise we have a reference that no longer belongs to us. Us=
e
> +        * @rq->idle to fill the void and make the next pick_next_task()
> +        * invocation happy.
> +        *
> +        * CPU0                         CPU1
> +        *
> +        *                              B mutex_lock(X)
> +        *
> +        * A mutex_lock(X) <- B
> +        * A __schedule()
> +        * A pick->A
> +        * A proxy->B
> +        * A migrate A to CPU1
> +        *                              B mutex_unlock(X) -> A
> +        *                              B __schedule()
> +        *                              B pick->A
> +        *                              B switch_to (A)
> +        *                              A ... does stuff
> +        * A ... is still running here
> +        *
> +        *              * BOOM *
> +        */
> +       put_prev_task(rq, rq_selected(rq));
> +       rq_set_selected(rq, rq->idle);
> +       set_next_task(rq, rq_selected(rq));
> +       WARN_ON(p =3D=3D rq->curr);
> +
> +       wake_cpu =3D p->wake_cpu;
> +       deactivate_task(rq, p, 0);
> +       set_task_cpu(p, that_cpu);
> +       /*
> +        * Preserve p->wake_cpu, such that we can tell where it
> +        * used to run later.
> +        */
> +       p->wake_cpu =3D wake_cpu;
> +
> +       rq_unpin_lock(rq, rf);
> +       __balance_callbacks(rq);
> +
> +       raw_spin_rq_unlock(rq);
> +       raw_spin_rq_lock(that_rq);
> +
> +       activate_task(that_rq, p, 0);
> +       check_preempt_curr(that_rq, p, 0);
> +
> +       raw_spin_rq_unlock(that_rq);
> +       raw_spin_rq_lock(rq);
> +       rq_repin_lock(rq, rf);
> +
> +       return NULL; /* Retry task selection on _this_ CPU. */
> +}
> +
> +static inline bool proxy_return_migration(struct rq *rq, struct rq_flags=
 *rf,
> +                                         struct task_struct *next)
> +{
> +       if (!sched_proxy_exec())
> +               return false;
> +
> +       if (next->blocked_on && next->blocked_on_waking) {
> +               if (!is_cpu_allowed(next, cpu_of(rq))) {


Based on the above reasons, could this be changed to the following?
                /* When EAS enabled, we hope the task selects the cpu again=
 */
                 if (sched_energy_enabled() || !is_cpu_allowed(next,
cpu_of(rq)) )

> +                       struct rq *that_rq;
> +                       int cpu;
> +
> +                       if (next =3D=3D rq->curr) {
> +                               /* can't migrate curr, so return and let =
caller sort it */
> +                               return true;
> +                       }
> +
> +                       put_prev_task(rq, rq_selected(rq));
> +                       rq_set_selected(rq, rq->idle);
> +
> +                       /* First unpin & run balance callbacks */
> +                       rq_unpin_lock(rq, rf);
> +                       __balance_callbacks(rq);
> +                       /*
> +                        * Drop the rq lock so we can get pi_lock,
> +                        * then reaquire it again to figure out
> +                        * where to send it.
> +                        */
> +                       raw_spin_rq_unlock(rq);
> +                       raw_spin_lock(&next->pi_lock);
> +                       rq_lock(rq, rf);
> +
> +                       cpu =3D select_task_rq(next, next->wake_cpu, WF_T=
TWU);
> +
> +                       deactivate_task(rq, next, 0);
> +                       set_task_cpu(next, cpu);
> +                       that_rq =3D cpu_rq(cpu);
> +
> +                       /* drop this rq lock and grab that_rq's */
> +                       rq_unpin_lock(rq, rf);
> +                       raw_spin_rq_unlock(rq);
> +                       raw_spin_rq_lock(that_rq);
> +
> +                       activate_task(that_rq, next, 0);
> +                       check_preempt_curr(that_rq, next, 0);
> +
> +                       /* drop that_rq's lock and re-grab this' */
> +                       raw_spin_rq_unlock(that_rq);
> +                       raw_spin_rq_lock(rq);
> +                       rq_repin_lock(rq, rf);
> +
> +                       raw_spin_unlock(&next->pi_lock);
> +
> +                       return true;
> +               }
> +       }
> +       return false;
> +}
> +
>  /*
>   * Find who @next (currently blocked on a mutex) can proxy for.
>   *
> @@ -6658,7 +6800,8 @@ proxy(struct rq *rq, struct task_struct *next, stru=
ct rq_flags *rf)
>         struct task_struct *ret =3D NULL;
>         struct task_struct *p =3D next;
>         struct task_struct *owner =3D NULL;
> -       int this_cpu;
> +       bool curr_in_chain =3D false;
> +       int this_cpu, that_cpu;
>         struct mutex *mutex;
>
>         this_cpu =3D cpu_of(rq);
> @@ -6694,6 +6837,9 @@ proxy(struct rq *rq, struct task_struct *next, stru=
ct rq_flags *rf)
>                         return NULL;
>                 }
>
> +               if (task_current(rq, p))
> +                       curr_in_chain =3D true;
> +
>                 owner =3D __mutex_owner(mutex);
>                 if (!owner) {
>                         raw_spin_unlock(&p->blocked_lock);
> @@ -6702,12 +6848,17 @@ proxy(struct rq *rq, struct task_struct *next, st=
ruct rq_flags *rf)
>                 }
>
>                 if (task_cpu(owner) !=3D this_cpu) {
> -                       /* XXX Don't handle migrations yet */
> -                       if (!proxy_deactivate(rq, next))
> -                               ret =3D next;
> +                       that_cpu =3D task_cpu(owner);
> +                       /*
> +                        * @owner can disappear, simply migrate to @that_=
cpu and leave that CPU
> +                        * to sort things out.
> +                        */
>                         raw_spin_unlock(&p->blocked_lock);
>                         raw_spin_unlock(&mutex->wait_lock);
> -                       return ret;
> +                       if (curr_in_chain)
> +                               return proxy_resched_idle(rq, next);
> +
> +                       return proxy_migrate_task(rq, rf, p, that_cpu);
>                 }
>
>                 if (task_on_rq_migrating(owner)) {
> @@ -6788,7 +6939,14 @@ static inline void proxy_tag_curr(struct rq *rq, s=
truct task_struct *next)
>         dequeue_task(rq, next, DEQUEUE_NOCLOCK | DEQUEUE_SAVE);
>         enqueue_task(rq, next, ENQUEUE_NOCLOCK | ENQUEUE_RESTORE);
>  }
> +
>  #else /* PROXY_EXEC */
> +static inline bool proxy_return_migration(struct rq *rq, struct rq_flags=
 *rf,
> +                                         struct task_struct *next)
> +{
> +       return false;
> +}
> +
>  static struct task_struct *
>  proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>  {
> @@ -6909,6 +7067,14 @@ static void __sched notrace __schedule(unsigned in=
t sched_mode)
>                 if (next =3D=3D rq->idle && prev =3D=3D rq->idle)
>                         preserve_need_resched =3D true;
>         }
> +       if (unlikely(proxy_return_migration(rq, &rf, next))) {
> +               if (next !=3D rq->curr)
> +                       goto pick_again;
> +
> +               rq_set_selected(rq, rq->idle);
> +               set_tsk_need_resched(rq->idle);
> +               next =3D rq->idle;
> +       }
>
>         if (!preserve_need_resched)
>                 clear_tsk_need_resched(prev);
> @@ -7006,6 +7172,9 @@ static inline void sched_submit_work(struct task_st=
ruct *tsk)
>          */
>         SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
>
> +       if (task_is_blocked(tsk))
> +               return;
> +
>         /*
>          * If we are going to sleep and we have plugged IO queued,
>          * make sure to submit it to avoid deadlocks.
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e8bca6b8da6f..99788cfd8835 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1731,7 +1731,7 @@ static void enqueue_task_dl(struct rq *rq, struct t=
ask_struct *p, int flags)
>
>         enqueue_dl_entity(&p->dl, flags);
>
> -       if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> +       if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_bl=
ocked(p))
>                 enqueue_pushable_dl_task(rq, p);
>  }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f334b129b269..f2dee89f475b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8220,7 +8220,9 @@ pick_next_task_fair(struct rq *rq, struct task_stru=
ct *prev, struct rq_flags *rf
>                 goto idle;
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -       if (!prev || prev->sched_class !=3D &fair_sched_class)
> +       if (!prev ||
> +           prev->sched_class !=3D &fair_sched_class ||
> +           rq->curr !=3D rq_selected(rq))
>                 goto simple;
>
>         /*
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 0125a3ae5a7a..d4f5625e4433 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1549,6 +1549,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *=
p, int flags)
>         if (p->nr_cpus_allowed =3D=3D 1)
>                 return;
>
> +       if (task_is_blocked(p))
> +               return;
> +
>         enqueue_pushable_task(rq, p);
>  }
>
> @@ -1836,10 +1839,12 @@ static void put_prev_task_rt(struct rq *rq, struc=
t task_struct *p)
>
>         update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);
>
> -       /* Avoid marking selected as pushable */
> -       if (task_current_selected(rq, p))
> +       /* Avoid marking current or selected as pushable */
> +       if (task_current(rq, p) || task_current_selected(rq, p))
>                 return;
>
> +       if (task_is_blocked(p))
> +               return;
>         /*
>          * The previous task needs to be made eligible for pushing
>          * if it is still active
> --
> 2.42.0.869.gea05f2083d-goog
>

In addition, I also thought that since the block task is no longer
dequeued, this will definitely cause the load on the CPU to increase.
Perhaps we need to evaluate the impact of this on power consumption.

BR
---
xuewen
