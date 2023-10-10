Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95497BF20A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJJE5i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 00:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJE5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:57:36 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF2A3;
        Mon,  9 Oct 2023 21:57:33 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6c6504c9ac5so3643470a34.0;
        Mon, 09 Oct 2023 21:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696913853; x=1697518653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6Hkmwwj1BN1f8YdlOXAYNFmQHPhTv26KM+lR+59Rx4=;
        b=ZL9i9xWuQFulMVUqmp4d2+xJfhhOgeb5XsgzuqGL9Gh2aVVStLQE4E6rwbBJVIPeUm
         cuZmcvU0Snc7WCP0AbNORgQ2XOwcqP2hgfRxcxgyPG47vSpn+Gr2c8cPxHvs6zyIJpqK
         FfZ4FZA1T0O9GzVeKrMYuT6gQ8OkSXoLC5C29xXQJo20vDFzKb+q/4kGQTcPZQdRYnWE
         qNtlGjMjoqcuh+1WAiQw+/v3Ea2OaFLpQelM510G2ajmtI21iD9E3d7ZouFDmh0+nMwF
         qIhYM1xCo/l8yI+Y6Q8xLp+3wOOF+oSZRD/LtuuR1Jtdl8FDxVnyh33FBIW+k0tqm5XG
         z7MQ==
X-Gm-Message-State: AOJu0YzU1Ia6BX6BMTR9ggUPoBKgJ2FUvNxiG8N08Qf+ClulJVSLgGGl
        RIDOoSdmTn9GA+oJ2HpNi7lqghqu1qy9ztZK8dk=
X-Google-Smtp-Source: AGHT+IH6QU9+RN0KpyFxRzjmch+AS+IL8ZWMrbamHSmj8Z/fcz7Ldv4xKXEFvdcwLsTRj12df6VIeYCLY8rKRr/oFBc=
X-Received: by 2002:a05:6358:4298:b0:143:8af4:229e with SMTP id
 s24-20020a056358429800b001438af4229emr20375717rwc.9.1696913852851; Mon, 09
 Oct 2023 21:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231004040844.797044-1-namhyung@kernel.org> <20231004160224.GB6307@noisy.programming.kicks-ass.net>
 <CAM9d7cizC0J85ByuF5fBmc_Bqi=wpNJpiVsw+3F1Avusn2aQog@mail.gmail.com> <20231009210425.GC6307@noisy.programming.kicks-ass.net>
In-Reply-To: <20231009210425.GC6307@noisy.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 9 Oct 2023 21:57:20 -0700
Message-ID: <CAM9d7cigs9mWuYiE=MYNg-xVhXzDu5FF6GdMGJi=D_zP1zJoCQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Oct 9, 2023 at 2:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 04, 2023 at 09:32:24AM -0700, Namhyung Kim wrote:
>
> > Yeah, I know.. but I couldn't come up with a better solution.
>
> Not been near a compiler, and haven't fully thought it through, but
> could something like the work work?

Thanks for the patch, I think it'd work.  Let me test it
and get back to you.

Thanks,
Namhyung

>
>
> ---
>  include/linux/perf_event.h |   1 +
>  kernel/events/core.c       | 115 +++++++++++++++++++++++----------------------
>  2 files changed, 61 insertions(+), 55 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f31f962a6445..0367d748fae0 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -878,6 +878,7 @@ struct perf_event_pmu_context {
>         unsigned int                    embedded : 1;
>
>         unsigned int                    nr_events;
> +       unsigned int                    nr_cgroups;
>
>         atomic_t                        refcount; /* event <-> epc */
>         struct rcu_head                 rcu_head;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 708d474c2ede..f3d5d47ecdfc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -375,6 +375,7 @@ enum event_type_t {
>         EVENT_TIME = 0x4,
>         /* see ctx_resched() for details */
>         EVENT_CPU = 0x8,
> +       EVENT_CGROUP = 0x10,
>         EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
>  };
>
> @@ -684,20 +685,26 @@ do {                                                                      \
>         ___p;                                                           \
>  })
>
> -static void perf_ctx_disable(struct perf_event_context *ctx)
> +static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
>  {
>         struct perf_event_pmu_context *pmu_ctx;
>
> -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
> +       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +               if (cgroup && !pmu_ctx->nr_cgroups)
> +                       continue;
>                 perf_pmu_disable(pmu_ctx->pmu);
> +       }
>  }
>
> -static void perf_ctx_enable(struct perf_event_context *ctx)
> +static void perf_ctx_enable(struct perf_event_context *ctx. bool cgroup)
>  {
>         struct perf_event_pmu_context *pmu_ctx;
>
> -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
> +       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +               if (cgroup && !pmu_ctx->nr_cgroups)
> +                       continue;
>                 perf_pmu_enable(pmu_ctx->pmu);
> +       }
>  }
>
>  static void ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type);
> @@ -856,9 +863,9 @@ static void perf_cgroup_switch(struct task_struct *task)
>                 return;
>
>         perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> -       perf_ctx_disable(&cpuctx->ctx);
> +       perf_ctx_disable(&cpuctx->ctx, true);
>
> -       ctx_sched_out(&cpuctx->ctx, EVENT_ALL);
> +       ctx_sched_out(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
>         /*
>          * must not be done before ctxswout due
>          * to update_cgrp_time_from_cpuctx() in
> @@ -870,9 +877,9 @@ static void perf_cgroup_switch(struct task_struct *task)
>          * perf_cgroup_set_timestamp() in ctx_sched_in()
>          * to not have to pass task around
>          */
> -       ctx_sched_in(&cpuctx->ctx, EVENT_ALL);
> +       ctx_sched_in(&cpuctx->ctx, EVENT_ALL|EVENT_CGROUP);
>
> -       perf_ctx_enable(&cpuctx->ctx);
> +       perf_ctx_enable(&cpuctx->ctx, true);
>         perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>  }
>
> @@ -965,6 +972,8 @@ perf_cgroup_event_enable(struct perf_event *event, struct perf_event_context *ct
>         if (!is_cgroup_event(event))
>                 return;
>
> +       event->pmu_ctx->nr_cgroups++;
> +
>         /*
>          * Because cgroup events are always per-cpu events,
>          * @ctx == &cpuctx->ctx.
> @@ -985,6 +994,8 @@ perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *c
>         if (!is_cgroup_event(event))
>                 return;
>
> +       event->pmu_ctx->nr_cgroups--;
> +
>         /*
>          * Because cgroup events are always per-cpu events,
>          * @ctx == &cpuctx->ctx.
> @@ -2677,9 +2688,9 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>
>         event_type &= EVENT_ALL;
>
> -       perf_ctx_disable(&cpuctx->ctx);
> +       perf_ctx_disable(&cpuctx->ctx, false);
>         if (task_ctx) {
> -               perf_ctx_disable(task_ctx);
> +               perf_ctx_disable(task_ctx, false);
>                 task_ctx_sched_out(task_ctx, event_type);
>         }
>
> @@ -2697,9 +2708,9 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>
>         perf_event_sched_in(cpuctx, task_ctx);
>
> -       perf_ctx_enable(&cpuctx->ctx);
> +       perf_ctx_enable(&cpuctx->ctx, false);
>         if (task_ctx)
> -               perf_ctx_enable(task_ctx);
> +               perf_ctx_enable(task_ctx, false);
>  }
>
>  void perf_pmu_resched(struct pmu *pmu)
> @@ -3244,6 +3255,9 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
>         struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>         struct perf_event_pmu_context *pmu_ctx;
>         int is_active = ctx->is_active;
> +       bool cgroup = event_type & EVENT_CGROUP;
> +
> +       event_type &= ~EVENT_CGROUP;
>
>         lockdep_assert_held(&ctx->lock);
>
> @@ -3290,8 +3304,11 @@ ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
>
>         is_active ^= ctx->is_active; /* changed bits */
>
> -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
> +       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +               if (cgroup && !pmu_ctx->nr_cgroups)
> +                       continue;
>                 __pmu_ctx_sched_out(pmu_ctx, is_active);
> +       }
>  }
>
>  /*
> @@ -3482,7 +3499,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>                 raw_spin_lock_nested(&next_ctx->lock, SINGLE_DEPTH_NESTING);
>                 if (context_equiv(ctx, next_ctx)) {
>
> -                       perf_ctx_disable(ctx);
> +                       perf_ctx_disable(ctx, false);
>
>                         /* PMIs are disabled; ctx->nr_pending is stable. */
>                         if (local_read(&ctx->nr_pending) ||
> @@ -3502,7 +3519,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>                         perf_ctx_sched_task_cb(ctx, false);
>                         perf_event_swap_task_ctx_data(ctx, next_ctx);
>
> -                       perf_ctx_enable(ctx);
> +                       perf_ctx_enable(ctx, false);
>
>                         /*
>                          * RCU_INIT_POINTER here is safe because we've not
> @@ -3526,13 +3543,13 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>
>         if (do_switch) {
>                 raw_spin_lock(&ctx->lock);
> -               perf_ctx_disable(ctx);
> +               perf_ctx_disable(ctx, false);
>
>  inside_switch:
>                 perf_ctx_sched_task_cb(ctx, false);
>                 task_ctx_sched_out(ctx, EVENT_ALL);
>
> -               perf_ctx_enable(ctx);
> +               perf_ctx_enable(ctx, false);
>                 raw_spin_unlock(&ctx->lock);
>         }
>  }
> @@ -3818,47 +3835,32 @@ static int merge_sched_in(struct perf_event *event, void *data)
>         return 0;
>  }
>
> -static void ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
> +static void pmu_groups_sched_in(struct perf_event_context *ctx,
> +                               struct perf_event_groups *groups,
> +                               struct pmu *pmu)
>  {
> -       struct perf_event_pmu_context *pmu_ctx;
>         int can_add_hw = 1;
> -
> -       if (pmu) {
> -               visit_groups_merge(ctx, &ctx->pinned_groups,
> -                                  smp_processor_id(), pmu,
> -                                  merge_sched_in, &can_add_hw);
> -       } else {
> -               list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -                       can_add_hw = 1;
> -                       visit_groups_merge(ctx, &ctx->pinned_groups,
> -                                          smp_processor_id(), pmu_ctx->pmu,
> -                                          merge_sched_in, &can_add_hw);
> -               }
> -       }
> +       visit_groups_merge(ctx, groups, smp_processor_id(), pmu,
> +                          merge_sched_in, &can_add_hw);
>  }
>
> -static void ctx_flexible_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
> +static void ctx_groups_sched_in(struct perf_event_context *ctx,
> +                               struct perf_event_groups *groups,
> +                               bool cgroup)
>  {
>         struct perf_event_pmu_context *pmu_ctx;
> -       int can_add_hw = 1;
>
> -       if (pmu) {
> -               visit_groups_merge(ctx, &ctx->flexible_groups,
> -                                  smp_processor_id(), pmu,
> -                                  merge_sched_in, &can_add_hw);
> -       } else {
> -               list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> -                       can_add_hw = 1;
> -                       visit_groups_merge(ctx, &ctx->flexible_groups,
> -                                          smp_processor_id(), pmu_ctx->pmu,
> -                                          merge_sched_in, &can_add_hw);
> -               }
> +       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +               if (cgroup && !pmu_ctx->nr_cgroups)
> +                       continue;
> +               pmu_groups_sched_in(ctx, groups, pmu_ctx->pmu);
>         }
>  }
>
> -static void __pmu_ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
> +static void __pmu_ctx_sched_in(struct perf_event_context *ctx,
> +                              struct pmu *pmu)
>  {
> -       ctx_flexible_sched_in(ctx, pmu);
> +       pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu);
>  }
>
>  static void
> @@ -3866,6 +3868,9 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
>  {
>         struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>         int is_active = ctx->is_active;
> +       bool cgroup = event_type & EVENT_CGROUP;
> +
> +       event_type &= ~EVENT_CGROUP;
>
>         lockdep_assert_held(&ctx->lock);
>
> @@ -3898,11 +3903,11 @@ ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type)
>          * in order to give them the best chance of going on.
>          */
>         if (is_active & EVENT_PINNED)
> -               ctx_pinned_sched_in(ctx, NULL);
> +               ctx_groups_sched_in(ctx, &ctx->pinned_groups, cgroup);
>
>         /* Then walk through the lower prio flexible groups */
>         if (is_active & EVENT_FLEXIBLE)
> -               ctx_flexible_sched_in(ctx, NULL);
> +               ctx_groups_sched_in(ctx, &ctx->flexible_groups, cgroup);
>  }
>
>  static void perf_event_context_sched_in(struct task_struct *task)
> @@ -3917,11 +3922,11 @@ static void perf_event_context_sched_in(struct task_struct *task)
>
>         if (cpuctx->task_ctx == ctx) {
>                 perf_ctx_lock(cpuctx, ctx);
> -               perf_ctx_disable(ctx);
> +               perf_ctx_disable(ctx, false);
>
>                 perf_ctx_sched_task_cb(ctx, true);
>
> -               perf_ctx_enable(ctx);
> +               perf_ctx_enable(ctx, false);
>                 perf_ctx_unlock(cpuctx, ctx);
>                 goto rcu_unlock;
>         }
> @@ -3934,7 +3939,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
>         if (!ctx->nr_events)
>                 goto unlock;
>
> -       perf_ctx_disable(ctx);
> +       perf_ctx_disable(ctx, false);
>         /*
>          * We want to keep the following priority order:
>          * cpu pinned (that don't need to move), task pinned,
> @@ -3944,7 +3949,7 @@ static void perf_event_context_sched_in(struct task_struct *task)
>          * events, no need to flip the cpuctx's events around.
>          */
>         if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
> -               perf_ctx_disable(&cpuctx->ctx);
> +               perf_ctx_disable(&cpuctx->ctx, false);
>                 ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
>         }
>
> @@ -3953,9 +3958,9 @@ static void perf_event_context_sched_in(struct task_struct *task)
>         perf_ctx_sched_task_cb(cpuctx->task_ctx, true);
>
>         if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
> -               perf_ctx_enable(&cpuctx->ctx);
> +               perf_ctx_enable(&cpuctx->ctx, false);
>
> -       perf_ctx_enable(ctx);
> +       perf_ctx_enable(ctx, false);
>
>  unlock:
>         perf_ctx_unlock(cpuctx, ctx);
