Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7B75C3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjGUJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjGUJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:56:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7630EC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:56:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2790169e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689933385; x=1690538185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTEGRVkT8CKn5J1Vn/9lojeQOLpRrPpL+X4tf5ExcgA=;
        b=J+bDxPusqfrRf1zv+ns/fiWApc9BfphwdRUXdF2NvPGIfVgiW8VY/Hc6rEn/7EE31Y
         932Ai5CIMqno/eYvFjkYTPoGNBOraesquvftcPHdNVsttWKCF/g95fFyOuV12pnzCyu7
         HDmiUHFB5TVF7HG0yR0rCdy0Wa6hvrmH0t8hDPHurniZxAMRmInI8hakYfvb72WRbiJ6
         Bs4CaUm77v5uuiVZioxPS5DJQ28eS1UQr2YnPe5RnCI4TntWfDeNjnLTLuv5dDz/giMm
         aGeM5iowuSth1y/r1zi7CaYCcHQWfzR0wKPEEFVT9Sig9SAXXsDC8TDeY61ZeUfXio9U
         B7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933385; x=1690538185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTEGRVkT8CKn5J1Vn/9lojeQOLpRrPpL+X4tf5ExcgA=;
        b=bMogmQ4+TunsWKqC4G2vzZ/ttwdRPDtWTwnFGIWA69vrS23ErmJKe3jD/ThVidtNyc
         /NcVjAO6qo93odIyDJ15gOErc+UspsIT1BuRlloxFjiXls3JUQlGPXxVE0MBsfMg1hGb
         RWfGZP3pnzBWDuB+OSslC6D7zMEkZDzL6H47HwkSHD1LdJV08IQDNnUh6SOfzve46qE/
         InaW60Pt3I2p1FEccxdDA+RatwrOU38gwAIgpwUSNPR0Qoc2NCmI8d8OD7wauhE6xJuU
         5dQvl6EeP+T9Et118tCpFIXrMt9YV6jZwkUnE3sg98qjGN4S33LM3eVU/KF+B4yi0mpC
         0Zug==
X-Gm-Message-State: ABy/qLYv8Eb+bHZaQXoUMNAqovOL4oTwkHMfNnsw0Rk+Wl3/vQ+R4JuC
        h0eUc6Tq+/p81IsTP9L64CbUPeGQHTTivMixnvgM1w==
X-Google-Smtp-Source: APBJJlG0uy4E5xCU1kb3qKP6+/MLxLPEjuJggPkO0/m8vS8jj0oqKoaFe+jHRzKM0rzPLUcmiGcfuwVTsY4FbDuwcOY=
X-Received: by 2002:a05:6512:214e:b0:4fb:e06f:4cf0 with SMTP id
 s14-20020a056512214e00b004fbe06f4cf0mr945779lfr.19.1689933385348; Fri, 21 Jul
 2023 02:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230717215717.309174-1-qyousef@layalina.io> <20230717215717.309174-2-qyousef@layalina.io>
In-Reply-To: <20230717215717.309174-2-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Jul 2023 11:56:14 +0200
Message-ID: <CAKfTPtA6Ur6O4OO76Krx6U6=JQZD_oZVLDF7NFJBHXt2SNoW7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 at 23:57, Qais Yousef <qyousef@layalina.io> wrote:
>
> When uclamp_max is being used, the util of the task could be higher than
> the spare capacity of the CPU, but due to uclamp_max value we force fit
> it there.
>
> The way the condition for checking for max_spare_cap in
> find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> hence ending up never performing compute_energy() for this cluster and
> missing an opportunity for a better energy efficient placement to honour
> uclamp_max setting.
>
>         max_spare_cap = 0;
>         cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
>
>         ...
>
>         util_fits_cpu(...);             // will return true if uclamp_max forces it to fit
>
>         ...
>
>         // this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
>         if (cpu_cap > max_spare_cap) {
>                 max_spare_cap = cpu_cap;
>                 max_spare_cap_cpu = cpu;
>         }
>
> prev_spare_cap suffers from a similar problem.
>
> Fix the logic by converting the variables into long and treating -1
> value as 'not populated' instead of 0 which is a viable and correct
> spare capacity value. We need to be careful signed comparison is used
> when comparing with cpu_cap in one of the conditions.
>
> Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0cd1cdbae534..d489eece5a0d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7596,11 +7596,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>         for (; pd; pd = pd->next) {
>                 unsigned long util_min = p_util_min, util_max = p_util_max;
>                 unsigned long cpu_cap, cpu_thermal_cap, util;
> -               unsigned long cur_delta, max_spare_cap = 0;
> +               long prev_spare_cap = -1, max_spare_cap = -1;
>                 unsigned long rq_util_min, rq_util_max;
> -               unsigned long prev_spare_cap = 0;
> +               unsigned long cur_delta, base_energy;
>                 int max_spare_cap_cpu = -1;
> -               unsigned long base_energy;
>                 int fits, max_fits = -1;
>
>                 cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> @@ -7663,7 +7662,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                                 prev_spare_cap = cpu_cap;
>                                 prev_fits = fits;
>                         } else if ((fits > max_fits) ||
> -                                  ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> +                                  ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
>                                 /*
>                                  * Find the CPU with the maximum spare capacity
>                                  * among the remaining CPUs in the performance
> @@ -7675,7 +7674,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                         }
>                 }
>
> -               if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> +               if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
>                         continue;
>
>                 eenv_pd_busy_time(&eenv, cpus, p);
> @@ -7683,7 +7682,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 base_energy = compute_energy(&eenv, pd, cpus, p, -1);
>
>                 /* Evaluate the energy impact of using prev_cpu. */
> -               if (prev_spare_cap > 0) {
> +               if (prev_spare_cap > -1) {
>                         prev_delta = compute_energy(&eenv, pd, cpus, p,
>                                                     prev_cpu);
>                         /* CPU utilization has changed */
> --
> 2.25.1
>
