Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B9178C6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbjH2OLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbjH2OLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:11:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B49EC0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:10:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26d50a832a9so2425296a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693318258; x=1693923058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tBqWv4e1Gjj7of3GyyxrGemSm1v+8ObJePi42aV+azg=;
        b=m6eOqWmnVnQajAfDUZ+2Byl13xc7/xv3T2/5bcmpcAu2qTkDjNxp589NCmMRsSfYoD
         HYPNtpgydI1hu3HO3Jj642hFm70LVEAvKaI+BcDoSEYtroclgC13qRQMjRO8OoLpQngy
         x2H51GIAS6G7F8EydCyRewyodEnjT3gj3gLoE7hgKzGrPFurMk3u67Pth8k675S536e0
         ft/Z5+Tlr4/ywSUWt4vYh4MrpMlT7R+pvlpLedsmOxMBbEi1uSPsCJYba1gzWxUk9Taz
         qMQNdA8aQ4llHI0vhqvwpnrWMH2UWHfxagJitV7YXJm+M/jC2NwiYGF3DAB++D7vTNUe
         QyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693318258; x=1693923058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBqWv4e1Gjj7of3GyyxrGemSm1v+8ObJePi42aV+azg=;
        b=LswdB/R5YSup9hmAQOv6too1lil17R5c3m9r0ETbefCmtMLHPSTS4DTFsRnqsJegs9
         cRUbPoPwhRBgNknObySy9I7F9xKx9NWqYxpvPa49ChHp4bIK/05oGHQ8Vgw8JGvNGxk6
         M/u8EQS/sd5DFQlSuzmyIoFEgKmhW2cNFhm0mbePWGpGhLyxJ0Q4SygrTLcTZnV/RNRM
         9OrnE3gUleBkHhOFF1K5Z55OqPDHgHeS7r7qK8N/xO30PxaYxd+YJNLo8RoOyrDVhqcx
         j1EWVBrzDJc8HBkUACrymFxw7JgGI/zPI5De6kpvatH3wh6UOPPKy7FVak9F5dCzp8aK
         KYkw==
X-Gm-Message-State: AOJu0YxLEK759cQ14k7o+/XTgQYzYDDFs+r3pKHIJPFv4DhyicZsym3r
        lLNr1y+rO859AqR9N1GJSnHVM9V5GL3PA+5uKGtCjA==
X-Google-Smtp-Source: AGHT+IHH+s4YTNdALwYPKftq6Hz16++6ElXEtcVm0UiGcfvFxLhlHXT+ZZi/SCUqVsjUyEE2uT2Uims1sUqMpYr1ZKI=
X-Received: by 2002:a17:90b:124f:b0:26c:f6d2:2694 with SMTP id
 gx15-20020a17090b124f00b0026cf6d22694mr21798362pjb.12.1693318257776; Tue, 29
 Aug 2023 07:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230820203429.568884-1-qyousef@layalina.io>
In-Reply-To: <20230820203429.568884-1-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Aug 2023 16:10:46 +0200
Message-ID: <CAKfTPtCq+-U34WSUHjs3CkqQM769_Q+FN-5Y+uK=AzdB0YNiLQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Check a task has a fitting cpu when updating misfit
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 at 22:34, Qais Yousef <qyousef@layalina.io> wrote:
>
> From: Qais Yousef <qais.yousef@arm.com>
>
> If a misfit task is affined to a subset of the possible cpus, we need to
> verify that one of these cpus can fit it. Otherwise the load balancer
> code will continuously trigger needlessly leading the balance_interval
> to increase in return and eventually end up with a situation where real
> imbalances take a long time to address because of this impossible
> imbalance situation.
>
> This can happen in Android world where it's common for background tasks
> to be restricted to little cores.
>
> Similarly if we can't fit the biggest core, triggering misfit is
> pointless as it is the best we can ever get on this system.
>
> To speed the search up, don't call task_fits_cpu() which will repeatedly
> call uclamp_eff_value() for the same task. Call util_fits_cpu() instead.
> And only do so when we see a cpu with higher capacity level than
> passed cpu_of(rq).
>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0b7445cd5af9..f08c5f3bf895 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4853,17 +4853,50 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  {
> +       unsigned long uclamp_min, uclamp_max;
> +       unsigned long util, cap_level;
> +       bool has_fitting_cpu = false;
> +       int cpu = cpu_of(rq);
> +
>         if (!sched_asym_cpucap_active())
>                 return;
>
> -       if (!p || p->nr_cpus_allowed == 1) {
> -               rq->misfit_task_load = 0;
> -               return;
> -       }
> +       if (!p || p->nr_cpus_allowed == 1)
> +               goto out;
>
> -       if (task_fits_cpu(p, cpu_of(rq))) {
> -               rq->misfit_task_load = 0;
> -               return;
> +       uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> +       uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> +       util = task_util_est(p);
> +
> +       if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0)
> +               goto out;
> +
> +       cap_level = capacity_orig_of(cpu);
> +
> +       /* If we can't fit the biggest CPU, that's the best we can ever get. */
> +       if (cap_level == SCHED_CAPACITY_SCALE)
> +               goto out;
> +
> +       /*
> +        * If the task affinity is not set to default, make sure it is not
> +        * restricted to a subset where no CPU can ever fit it. Triggering
> +        * misfit in this case is pointless as it has no where better to move
> +        * to. And it can lead to balance_interval to grow too high as we'll
> +        * continuously fail to move it anywhere.
> +        */
> +       if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> +               for_each_cpu(cpu, p->cpus_ptr) {

I haven't looked at the problem in detail and at other possibilities
so far but for_each_cpu doesn't scale and update_misfit_status() being
called in pick_next_task_fair() so you must find another way to detect
this


> +                       if (cap_level < capacity_orig_of(cpu)) {
> +                               cap_level = capacity_orig_of(cpu);
> +                               if (util_fits_cpu(util, uclamp_min, uclamp_max, cpu) > 0) {
> +                                       has_fitting_cpu = true;
> +                                       break;
> +                               }
> +                       }
> +               }
> +
> +               if (!has_fitting_cpu)
> +                       goto out;
>         }
>
>         /*
> @@ -4871,6 +4904,9 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>          * task_h_load() returns 0.
>          */
>         rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> +       return;
> +out:
> +       rq->misfit_task_load = 0;
>  }
>
>  #else /* CONFIG_SMP */
> --
> 2.34.1
>
