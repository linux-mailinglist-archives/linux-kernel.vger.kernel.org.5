Return-Path: <linux-kernel+bounces-75227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13A85E4ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C9B24422
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1F84FAD;
	Wed, 21 Feb 2024 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGvbddyI"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C619839F9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537897; cv=none; b=egDJXwcdvv0f141i5+khC+COZrZ3Pn9eT5oVlTHEu8on4A2Hb4U8O71n/EeiTzX5jmmSWGpx86ndlJok1twZ+imJ1uG2JIFFIA93DLyg44BwOZhlZVwo95lJYtv83v21IQ3FKgfU/9GNLKcckYdKLceZDRlTj0zdll0cqyhWaQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537897; c=relaxed/simple;
	bh=Fda278FTR/5zMJ4YPLlXLcjCkr0VfwBO0Aaliz79MDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdYD4186G1IRnqC7ebyz3cgo7/XvF3WBV2n8yQH1EbcyyXfnXVcN948Lw8Umhb5R9Lxg8TpZy2OzWwU0G6E4sgP8rFjKGv3z2GsPXuigCA64Vzvi3J7oeCaDubU0gnDQtxi2f4R/0O0+ZnADZRqrrdkZe4/sES5bwRcQjhdcHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dGvbddyI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2997c5fe6abso670641a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708537895; x=1709142695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4c6JOQ+FrSe0D6YFyR6qod+/IDocW0FckRUNcekKjE4=;
        b=dGvbddyIeumIz6Od+KrvNb3kslvCS3xj46z4eTtCR+TR1QXsym+onhiFVfYsuYXCKB
         1/Z4dq98kNTASH6y8h+IJFkDD/a7c1IPtsha4KIH8+ypRj5F+7gay18en9G77OrRV1Mm
         5BVvcxQxDGu4K34ZieRVhkyqcfAkWm8F8EyKlkY9RD7YiHS4BUxWbw3/hm8ZPeSiK9e0
         VdxTVJ3z5Ca5LMUsfhr6T0friwd6qXJVxLlDh5uW/0LnDcu4MuWCgEjIWjmIsdXJaWn3
         L0DP++Pdg9PRjt8WcCa6hwaU3hXx1RpEMsXiXAtd6gxTO+IbZdzuvpZXVc0arZF8tO8D
         6inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537895; x=1709142695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4c6JOQ+FrSe0D6YFyR6qod+/IDocW0FckRUNcekKjE4=;
        b=R4Cbajr5LY2a4MmJy9LE6o7so++Ay5Jc7JcYpR86XZdDqj2pYusGqw171cAX2qcyhw
         14o0aVWL0AY3TwimCdM5BTYD4uQTkVG27dEiYhUR11TG1f/sRqLKBsqzVG8zf1GylysA
         lSccYHc/0yDTsSM1trZN1YMZx5LwXT6jWROAHiS1Vi3wHaKVm2/W7hJ3uPnai8sr3BNv
         AAz+rfOqfiQ/0GX6r7gMhq088JinmqwbgTSNZ1ui4u+isCcQcmAN617UVk97oGeu5gTZ
         kOOKB0TxRgTbsXeviv7Qp9yHjfwMnBCwbA/7LMYXIy3mPrVPJHTGhEDtmV0kXsT2oQ/7
         N+aw==
X-Forwarded-Encrypted: i=1; AJvYcCVJYL7XVRGuKqDbbh4DBHVFLY91sM3uwSr0YkHjZZS1EDfeuEoS1feQSvStB126ap/1D1AJazDJNRWcPpWLsA60C7oG+tRCOqLxcvWn
X-Gm-Message-State: AOJu0YxZSFkAt2FFjSa+ISjPQ3VZlWvi6c9CwPYo39GYDBtFlVinwhkF
	2J563xosqsa4jNRRfm42i6nDsDXuCok85pSuX/RVXzB30y0MgjzUot+QFk19TrCrg7q7B9tdSnB
	plTQCLFslyVPHf3KGwm2Zx9e06O6pY3WpCFGSxQ==
X-Google-Smtp-Source: AGHT+IFeE56/qU5RJZPjGhSa8rqSHr150i/t1QrHgQ7Ys9e8cxyefrsUL+ZIrdKRDSpjARmKXd9Q8k1L/VGnJCgaL2Y=
X-Received: by 2002:a17:90a:d157:b0:299:64d8:10ef with SMTP id
 t23-20020a17090ad15700b0029964d810efmr10391553pjw.10.1708537895370; Wed, 21
 Feb 2024 09:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220061542.489922-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240220061542.489922-1-zhaoyang.huang@unisoc.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 21 Feb 2024 18:51:23 +0100
Message-ID: <CAKfTPtCbxk4_pAwi_+0ROo52f7R4+kZawe=OFEcOc2bTCYfsHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched: introduce helper function to calculate
 distribution over sched class
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 07:16, zhaoyang.huang <zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> As RT, DL, IRQ time could be deemed as lost time of CFS's task, some

It's lost only if cfs has been actually preempted

> timing value want to know the distribution of how these spread
> approximately by using utilization account value (nivcsw is not enough
> sometimes). This commit would like to introduce a helper function to
> achieve this goal.
>
> eg.
> Effective part of A = Total_time * cpu_util_cfs / cpu_util
>
> Timing value A
> (should be a process last for several TICKs or statistics of a repeadted
> process)
>
> Timing start
> |
> |
> preempted by RT, DL or IRQ
> |\
> | This period time is nonvoluntary CPU give up, need to know how long
> |/

preempted means that a cfs task stops running on the cpu and lets
another rt/dl task or an irq run on the cpu instead. We can't know
that. We know an average ratio of time spent in rt/dl and irq contexts
but not if the cpu was idle or running cfs task

> sched in again
> |
> |
> |
> Timing end
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/sched.h |  1 +
>  kernel/sched/core.c   | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 77f01ac385f7..99cf09c47f72 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2318,6 +2318,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
>
>  /* Returns effective CPU energy utilization, as seen by the scheduler */
>  unsigned long sched_cpu_util(int cpu);
> +unsigned long cfs_prop_by_util(struct task_struct *tsk, unsigned long val);
>  #endif /* CONFIG_SMP */
>
>  #ifdef CONFIG_RSEQ
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 802551e0009b..217e2220fdc1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7494,6 +7494,26 @@ unsigned long sched_cpu_util(int cpu)
>  {
>         return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
>  }
> +
> +/*
> + * Calculate the approximate proportion of timing value consumed in cfs.
> + * The user must be aware of this is done by avg_util which is tracked by
> + * the geometric series as decaying the load by y^32 = 0.5 (unit is 1ms).
> + * That is, only the period last for at least several TICKs or the statistics
> + * of repeated timing value are suitable for this helper function.
> + */
> +unsigned long cfs_prop_by_util(struct task_struct *tsk, unsigned long val)
> +{
> +       unsigned int cpu = task_cpu(tsk);
> +       struct rq *rq = cpu_rq(cpu);
> +       unsigned long util;
> +
> +       if (tsk->sched_class != &fair_sched_class)
> +               return val;
> +       util = cpu_util_rt(rq) + cpu_util_cfs(cpu) + cpu_util_irq(rq) + cpu_util_dl(rq);

This is not correct as irq is not on the same clock domain: look at
effective_cpu_util()

You don't care about idle time ?

> +       return min(val, cpu_util_cfs(cpu) * val / util);
> +}
> +
>  #endif /* CONFIG_SMP */
>
>  /**
> --
> 2.25.1
>

