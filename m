Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F375A75C3DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGUJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjGUJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:57:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7E359F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:57:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so2791778e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689933450; x=1690538250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gPHvr2xG2elRxQWye2+JAWmvpQlba73DvvbR+kzMAxQ=;
        b=TJ2Vntmmy6A1WqfZzOVNjOZzj3QfVbrkUdMAKmQFHObyxAlSyRjLZbB6AFzqfPz57D
         asCRHVSgXHHJCHX2S0UqIqwPmLD9whUvJJhavpyIYY+hTC6ZndReCXdTZ4nleqhR8TFk
         TvnW7mPYWUuR4N6NR/M06xD1Pt7H7j1nnrpMziWOxRTNp4biv9UIxOSVEfQT7D709LYV
         spxZrGdJVpQVgJ4fLfQ8uj1Os/jN3b+HqPFZ/y5jJSe0dzyZ5wHFETy90CL8vHJnMt+i
         tiiis1i/TC13FPZ8FKznxrVzX2EqM+9xtxYPIl7J7fSwlJPSHkIf8rH6VkFTt2kNHTHY
         0wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933450; x=1690538250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPHvr2xG2elRxQWye2+JAWmvpQlba73DvvbR+kzMAxQ=;
        b=TcnpUuD2NeBqopS+S620ixRnoDpAZWtDEK2oc3dHJ2i5n7VtNf9rYbT0091C3ed7RK
         nRCyF1+YT8x0fL/B8oP8FFhflbwtcT4pIh8PyPRRKgEcWxJNLAfIWh3xIZJOBEMXrE7g
         nneGQxWYpFO3LRtRxZytWnJhfZJANnJQa8XC0+L5JV4NSfiaPkpdTMwcC/SHcNahp1Us
         ZIcCwLupPoK59IqKwvZ3nNZDZoEm7HmrGoe//M8xCw2kVuQquPsmR2/RE0RJWANN1Flz
         Wkb56PMYvRCgMLRlLzpq1TAn9KFyfMeUHNtm+zdByk8NRKCfVp6bP9s9Yl48vWuSSFpT
         zsQw==
X-Gm-Message-State: ABy/qLasFtmuRy/9HydwAB3Jo43bowkF49qCMm/3dj7xwRFeSr2+ZkX2
        PFMnTw9fQkCDYQNNRJf3GoKfgWrh1tbw1qqa+0H15g==
X-Google-Smtp-Source: APBJJlExE1WE9usysa+SH5E40w8HLRq36PF68Ekg+azf7PetA/CDBtShO8itT1P4gLYlz2RwPR92vbDNClhQPmotEbw=
X-Received: by 2002:a19:c516:0:b0:4fb:79b5:5512 with SMTP id
 w22-20020a19c516000000b004fb79b55512mr933965lfe.66.1689933450007; Fri, 21 Jul
 2023 02:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230717215717.309174-1-qyousef@layalina.io> <20230717215717.309174-3-qyousef@layalina.io>
In-Reply-To: <20230717215717.309174-3-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Jul 2023 11:57:19 +0200
Message-ID: <CAKfTPtCAs5_LDkaxVBHW1wHZzpOHvgsL7Tz1PyDDqDHN2UU5Xw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
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
> find_energy_efficient_cpu() bails out early if effective util of the
> task is 0 as the delta at this point will be zero and there's nothing
> for EAS to do. When uclamp is being used, this could lead to wrong
> decisions when uclamp_max is set to 0. In this case the task is capped
> to performance point 0, but it is actually running and consuming energy
> and we can benefit from EAS energy calculations.
>
> Rework the condition so that it bails out for when util is actually 0 or
> uclamp_min is requesting a higher performance point.
>
> We can do that without needing to use uclamp_task_util(); remove it.
>
> Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d489eece5a0d..c701f490ca4c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4348,22 +4348,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
>         return max(task_util(p), _task_util_est(p));
>  }
>
> -#ifdef CONFIG_UCLAMP_TASK
> -static inline unsigned long uclamp_task_util(struct task_struct *p,
> -                                            unsigned long uclamp_min,
> -                                            unsigned long uclamp_max)
> -{
> -       return clamp(task_util_est(p), uclamp_min, uclamp_max);
> -}
> -#else
> -static inline unsigned long uclamp_task_util(struct task_struct *p,
> -                                            unsigned long uclamp_min,
> -                                            unsigned long uclamp_max)
> -{
> -       return task_util_est(p);
> -}
> -#endif
> -
>  static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
>                                     struct task_struct *p)
>  {
> @@ -7588,7 +7572,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>         target = prev_cpu;
>
>         sync_entity_load_avg(&p->se);
> -       if (!uclamp_task_util(p, p_util_min, p_util_max))
> +       if (!task_util_est(p) && p_util_min == 0)
>                 goto unlock;
>
>         eenv_task_busy_time(&eenv, p, prev_cpu);
> --
> 2.25.1
>
