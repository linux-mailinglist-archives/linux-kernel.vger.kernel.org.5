Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7941F807F40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjLGDrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLGDrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:47:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D7D5C;
        Wed,  6 Dec 2023 19:47:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so6276585e9.0;
        Wed, 06 Dec 2023 19:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701920829; x=1702525629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3IkORsGsNJWFyuH3JxwzLsXwTl46eloyKjfI9ce56c=;
        b=VlH/HaSYUwL2CLpyXsSOTsdmpFEkzKnRBf7uWLH1OXVHX6baRu3EMRL29/seeBfqcF
         8HQMiaaPxT2eY19TisBB5yLfe1wnwTIRDh+hD80f7q8yuuRsbXrrWtSvaUHeEqVOxBgn
         nyeAGX5eimE8WdrN31TYkXnEBMkK/5IqIFXA5HksmqYVQsx+PGn0jqHZehMFUOyZFy/D
         PVAR5KIG9wz+ZFI12xftDWG0+WYyCHwordoW9PAfa/bsA5GyV6W1HtabipdcQKZQfrtT
         pM9DV90DpRdK6jCKB06Lf6Hv8WQt+myfHAxgeLv9qqKo2TtuhJjT5ACwQq48A3NhEf00
         L3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701920829; x=1702525629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3IkORsGsNJWFyuH3JxwzLsXwTl46eloyKjfI9ce56c=;
        b=qXx+ClK/2y1mnVDeXkwVmlAyBRyxLJovJ2X980voavV6/TJcAUx+93ey8EHKz/7/p7
         1IhyRcyhDVDp3H4tB6WFdGpCluCI6zhRzwj5ff2NydmjIxhk+Ciu9eD+nrCxDumxDuK4
         aFWKKoliMe0tnD5AQA1BYVJrqi0VE4q6vwXlQiGf7cnBnajgxGFy0n4bvFwPTprh7gpt
         v5/EcDUyhHzoyuWH5zzzlsWD/qsNwab9xachvDkPLmOFMXOa+iR+KUsbE3dIuBNazCeu
         aCiii4yBzVGGXurwMOU1QLWypd2bfNBcl1RrlCxY+arp5+GDHx+rLYCO9x1RyO0URN3m
         XdAg==
X-Gm-Message-State: AOJu0YzyH7+6MmZgDv+VWtQtvqAw1aV+9UDYpMGvvbUz9n+WevMxGscN
        S8o67r0QPmMPmeuwmZ2Nonq/w8idkJVx6V9VRR0=
X-Google-Smtp-Source: AGHT+IGzJ7V9ob+jd+WlyHTlUOXGcJk3JyOU49MSMafqwFkzdGIfr4XULnI7n8pi8eFvy5Qg6IEj4rbdx/PtabPQAPE=
X-Received: by 2002:a05:600c:4ecf:b0:40c:ddd:575b with SMTP id
 g15-20020a05600c4ecf00b0040c0ddd575bmr774463wmq.76.1701920829193; Wed, 06 Dec
 2023 19:47:09 -0800 (PST)
MIME-Version: 1.0
References: <20231201161652.1241695-1-vincent.guittot@linaro.org> <20231201161652.1241695-3-vincent.guittot@linaro.org>
In-Reply-To: <20231201161652.1241695-3-vincent.guittot@linaro.org>
From:   Alex Shi <seakeel@gmail.com>
Date:   Thu, 7 Dec 2023 11:46:33 +0800
Message-ID: <CAJy-AmkxYkcSwNGu3b8UudmurLFAC=pvaRc_t1DC89GPPPJh9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Simplify util_est
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, lukasz.luba@arm.com,
        hongyan.xia2@arm.com, yizhou.tang@shopee.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: Alex Shi <alexs@kernel.org>

On Sat, Dec 2, 2023 at 12:17=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> With UTIL_EST_FASTUP now being permanent, we can take advantage of the
> fact that the ewma jumps directly to a higher utilization at dequeue to
> simplify util_est and remove the enqueued field.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> ---
>  include/linux/sched.h | 49 +++++++-------------------
>  kernel/sched/debug.c  |  7 ++--
>  kernel/sched/fair.c   | 82 ++++++++++++++++---------------------------
>  kernel/sched/pelt.h   |  4 +--
>  4 files changed, 48 insertions(+), 94 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8d258162deb0..03bfe9ab2951 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -415,42 +415,6 @@ struct load_weight {
>         u32                             inv_weight;
>  };
>
> -/**
> - * struct util_est - Estimation utilization of FAIR tasks
> - * @enqueued: instantaneous estimated utilization of a task/cpu
> - * @ewma:     the Exponential Weighted Moving Average (EWMA)
> - *            utilization of a task
> - *
> - * Support data structure to track an Exponential Weighted Moving Averag=
e
> - * (EWMA) of a FAIR task's utilization. New samples are added to the mov=
ing
> - * average each time a task completes an activation. Sample's weight is =
chosen
> - * so that the EWMA will be relatively insensitive to transient changes =
to the
> - * task's workload.
> - *
> - * The enqueued attribute has a slightly different meaning for tasks and=
 cpus:
> - * - task:   the task's util_avg at last task dequeue time
> - * - cfs_rq: the sum of util_est.enqueued for each RUNNABLE task on that=
 CPU
> - * Thus, the util_est.enqueued of a task represents the contribution on =
the
> - * estimated utilization of the CPU where that task is currently enqueue=
d.
> - *
> - * Only for tasks we track a moving average of the past instantaneous
> - * estimated utilization. This allows to absorb sporadic drops in utiliz=
ation
> - * of an otherwise almost periodic task.
> - *
> - * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util=
_avg
> - * updates. When a task is dequeued, its util_est should not be updated =
if its
> - * util_avg has not been updated in the meantime.
> - * This information is mapped into the MSB bit of util_est.enqueued at d=
equeue
> - * time. Since max value of util_est.enqueued for a task is 1024 (PELT u=
til_avg
> - * for a task) it is safe to use MSB.
> - */
> -struct util_est {
> -       unsigned int                    enqueued;
> -       unsigned int                    ewma;
> -#define UTIL_EST_WEIGHT_SHIFT          2
> -#define UTIL_AVG_UNCHANGED             0x80000000
> -} __attribute__((__aligned__(sizeof(u64))));
> -
>  /*
>   * The load/runnable/util_avg accumulates an infinite geometric series
>   * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
> @@ -505,9 +469,20 @@ struct sched_avg {
>         unsigned long                   load_avg;
>         unsigned long                   runnable_avg;
>         unsigned long                   util_avg;
> -       struct util_est                 util_est;
> +       unsigned int                    util_est;
>  } ____cacheline_aligned;
>
> +/*
> + * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util=
_avg
> + * updates. When a task is dequeued, its util_est should not be updated =
if its
> + * util_avg has not been updated in the meantime.
> + * This information is mapped into the MSB bit of util_est at dequeue ti=
me.
> + * Since max value of util_est for a task is 1024 (PELT util_avg for a t=
ask)
> + * it is safe to use MSB.
> + */
> +#define UTIL_EST_WEIGHT_SHIFT          2
> +#define UTIL_AVG_UNCHANGED             0x80000000
> +
>  struct sched_statistics {
>  #ifdef CONFIG_SCHEDSTATS
>         u64                             wait_start;
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 168eecc209b4..8d5d98a5834d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -684,8 +684,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct=
 cfs_rq *cfs_rq)
>                         cfs_rq->avg.runnable_avg);
>         SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
>                         cfs_rq->avg.util_avg);
> -       SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
> -                       cfs_rq->avg.util_est.enqueued);
> +       SEQ_printf(m, "  .%-30s: %u\n", "util_est",
> +                       cfs_rq->avg.util_est);
>         SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
>                         cfs_rq->removed.load_avg);
>         SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
> @@ -1075,8 +1075,7 @@ void proc_sched_show_task(struct task_struct *p, st=
ruct pid_namespace *ns,
>         P(se.avg.runnable_avg);
>         P(se.avg.util_avg);
>         P(se.avg.last_update_time);
> -       P(se.avg.util_est.ewma);
> -       PM(se.avg.util_est.enqueued, ~UTIL_AVG_UNCHANGED);
> +       PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
>  #endif
>  #ifdef CONFIG_UCLAMP_TASK
>         __PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e94d65da8d66..823dd76d0546 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4781,9 +4781,7 @@ static inline unsigned long task_runnable(struct ta=
sk_struct *p)
>
>  static inline unsigned long _task_util_est(struct task_struct *p)
>  {
> -       struct util_est ue =3D READ_ONCE(p->se.avg.util_est);
> -
> -       return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
> +       return READ_ONCE(p->se.avg.util_est) & ~UTIL_AVG_UNCHANGED;
>  }
>
>  static inline unsigned long task_util_est(struct task_struct *p)
> @@ -4800,9 +4798,9 @@ static inline void util_est_enqueue(struct cfs_rq *=
cfs_rq,
>                 return;
>
>         /* Update root cfs_rq's estimated utilization */
> -       enqueued  =3D cfs_rq->avg.util_est.enqueued;
> +       enqueued  =3D cfs_rq->avg.util_est;
>         enqueued +=3D _task_util_est(p);
> -       WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> +       WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
>
>         trace_sched_util_est_cfs_tp(cfs_rq);
>  }
> @@ -4816,34 +4814,20 @@ static inline void util_est_dequeue(struct cfs_rq=
 *cfs_rq,
>                 return;
>
>         /* Update root cfs_rq's estimated utilization */
> -       enqueued  =3D cfs_rq->avg.util_est.enqueued;
> +       enqueued  =3D cfs_rq->avg.util_est;
>         enqueued -=3D min_t(unsigned int, enqueued, _task_util_est(p));
> -       WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> +       WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
>
>         trace_sched_util_est_cfs_tp(cfs_rq);
>  }
>
>  #define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
>
> -/*
> - * Check if a (signed) value is within a specified (unsigned) margin,
> - * based on the observation that:
> - *
> - *     abs(x) < y :=3D (unsigned)(x + y - 1) < (2 * y - 1)
> - *
> - * NOTE: this only works when value + margin < INT_MAX.
> - */
> -static inline bool within_margin(int value, int margin)
> -{
> -       return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> -}
> -
>  static inline void util_est_update(struct cfs_rq *cfs_rq,
>                                    struct task_struct *p,
>                                    bool task_sleep)
>  {
> -       long last_ewma_diff, last_enqueued_diff;
> -       struct util_est ue;
> +       unsigned int ewma, dequeued, last_ewma_diff;
>
>         if (!sched_feat(UTIL_EST))
>                 return;
> @@ -4855,23 +4839,25 @@ static inline void util_est_update(struct cfs_rq =
*cfs_rq,
>         if (!task_sleep)
>                 return;
>
> +       /* Get current estimate of utilization */
> +       ewma =3D READ_ONCE(p->se.avg.util_est);
> +
>         /*
>          * If the PELT values haven't changed since enqueue time,
>          * skip the util_est update.
>          */
> -       ue =3D p->se.avg.util_est;
> -       if (ue.enqueued & UTIL_AVG_UNCHANGED)
> +       if (ewma & UTIL_AVG_UNCHANGED)
>                 return;
>
> -       last_enqueued_diff =3D ue.enqueued;
> +       /* Get utilization at dequeue */
> +       dequeued =3D task_util(p);
>
>         /*
>          * Reset EWMA on utilization increases, the moving average is use=
d only
>          * to smooth utilization decreases.
>          */
> -       ue.enqueued =3D task_util(p);
> -       if (ue.ewma < ue.enqueued) {
> -               ue.ewma =3D ue.enqueued;
> +       if (ewma <=3D dequeued) {
> +               ewma =3D dequeued;
>                 goto done;
>         }
>
> @@ -4879,27 +4865,22 @@ static inline void util_est_update(struct cfs_rq =
*cfs_rq,
>          * Skip update of task's estimated utilization when its members a=
re
>          * already ~1% close to its last activation value.
>          */
> -       last_ewma_diff =3D ue.enqueued - ue.ewma;
> -       last_enqueued_diff -=3D ue.enqueued;
> -       if (within_margin(last_ewma_diff, UTIL_EST_MARGIN)) {
> -               if (!within_margin(last_enqueued_diff, UTIL_EST_MARGIN))
> -                       goto done;
> -
> -               return;
> -       }
> +       last_ewma_diff =3D ewma - dequeued;
> +       if (last_ewma_diff < UTIL_EST_MARGIN)
> +               goto done;
>
>         /*
>          * To avoid overestimation of actual task utilization, skip updat=
es if
>          * we cannot grant there is idle time in this CPU.
>          */
> -       if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)))=
)
> +       if (dequeued > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
>                 return;
>
>         /*
>          * To avoid underestimate of task utilization, skip updates of EW=
MA if
>          * we cannot grant that thread got all CPU time it wanted.
>          */
> -       if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
> +       if ((dequeued + UTIL_EST_MARGIN) < task_runnable(p))
>                 goto done;
>
>
> @@ -4907,25 +4888,24 @@ static inline void util_est_update(struct cfs_rq =
*cfs_rq,
>          * Update Task's estimated utilization
>          *
>          * When *p completes an activation we can consolidate another sam=
ple
> -        * of the task size. This is done by storing the current PELT val=
ue
> -        * as ue.enqueued and by using this value to update the Exponenti=
al
> -        * Weighted Moving Average (EWMA):
> +        * of the task size. This is done by using this value to update t=
he
> +        * Exponential Weighted Moving Average (EWMA):
>          *
>          *  ewma(t) =3D w *  task_util(p) + (1-w) * ewma(t-1)
>          *          =3D w *  task_util(p) +         ewma(t-1)  - w * ewma=
(t-1)
>          *          =3D w * (task_util(p) -         ewma(t-1)) +     ewma=
(t-1)
> -        *          =3D w * (      last_ewma_diff            ) +     ewma=
(t-1)
> -        *          =3D w * (last_ewma_diff  +  ewma(t-1) / w)
> +        *          =3D w * (      -last_ewma_diff           ) +     ewma=
(t-1)
> +        *          =3D w * (-last_ewma_diff +  ewma(t-1) / w)
>          *
>          * Where 'w' is the weight of new samples, which is configured to=
 be
>          * 0.25, thus making w=3D1/4 ( >>=3D UTIL_EST_WEIGHT_SHIFT)
>          */
> -       ue.ewma <<=3D UTIL_EST_WEIGHT_SHIFT;
> -       ue.ewma  +=3D last_ewma_diff;
> -       ue.ewma >>=3D UTIL_EST_WEIGHT_SHIFT;
> +       ewma <<=3D UTIL_EST_WEIGHT_SHIFT;
> +       ewma  -=3D last_ewma_diff;
> +       ewma >>=3D UTIL_EST_WEIGHT_SHIFT;
>  done:
> -       ue.enqueued |=3D UTIL_AVG_UNCHANGED;
> -       WRITE_ONCE(p->se.avg.util_est, ue);
> +       ewma |=3D UTIL_AVG_UNCHANGED;
> +       WRITE_ONCE(p->se.avg.util_est, ewma);
>
>         trace_sched_util_est_se_tp(&p->se);
>  }
> @@ -7653,16 +7633,16 @@ cpu_util(int cpu, struct task_struct *p, int dst_=
cpu, int boost)
>         if (sched_feat(UTIL_EST)) {
>                 unsigned long util_est;
>
> -               util_est =3D READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +               util_est =3D READ_ONCE(cfs_rq->avg.util_est);
>
>                 /*
>                  * During wake-up @p isn't enqueued yet and doesn't contr=
ibute
> -                * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
> +                * to any cpu_rq(cpu)->cfs.avg.util_est.
>                  * If @dst_cpu =3D=3D @cpu add it to "simulate" cpu_util =
after @p
>                  * has been enqueued.
>                  *
>                  * During exec (@dst_cpu =3D -1) @p is enqueued and does
> -                * contribute to cpu_rq(cpu)->cfs.util_est.enqueued.
> +                * contribute to cpu_rq(cpu)->cfs.util_est.
>                  * Remove it to "simulate" cpu_util without @p's contribu=
tion.
>                  *
>                  * Despite the task_on_rq_queued(@p) check there is still=
 a
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 3a0e0dc28721..9e1083465fbc 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -52,13 +52,13 @@ static inline void cfs_se_util_change(struct sched_av=
g *avg)
>                 return;
>
>         /* Avoid store if the flag has been already reset */
> -       enqueued =3D avg->util_est.enqueued;
> +       enqueued =3D avg->util_est;
>         if (!(enqueued & UTIL_AVG_UNCHANGED))
>                 return;
>
>         /* Reset flag to report util_avg has been updated */
>         enqueued &=3D ~UTIL_AVG_UNCHANGED;
> -       WRITE_ONCE(avg->util_est.enqueued, enqueued);
> +       WRITE_ONCE(avg->util_est, enqueued);
>  }
>
>  static inline u64 rq_clock_pelt(struct rq *rq)
> --
> 2.34.1
>
