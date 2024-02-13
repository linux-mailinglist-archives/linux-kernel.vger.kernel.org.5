Return-Path: <linux-kernel+bounces-63942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B498685369B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A328CEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27DC5F866;
	Tue, 13 Feb 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTpN3ypD"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE32C695
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843123; cv=none; b=X8V7wxpOAA3bmiCFuHeLVRu586gHGpkl9/636WFTQa6M9pKGaSlxHZpXjw9QimPF/ESxe/O+53YO4+S66TYNJkJmcqn4fYzCo6WrSNYbcSaWDqTaDdapooEgdfa5wgLt8iOYGclVzAId55q67Nld5QFy/qRyc3dX0cInOSLf/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843123; c=relaxed/simple;
	bh=BtZDDUgyXKOvkfYTc+1OipN0Z1hTF7MpB8Bw2BocVkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukHw+xvyRtczpyWFYfPd+xMU+5OkKPr8ztVYuRaZr57ieAEATADbqWUaNz6QodwcnDcR4VuDwj3if3JOaEs/nAXeI8za8yongwmR1WUks9BIklbiTszBWVcBQS8ora8kIYiPLbTqsMx+LT2H92ofa9SAkyQIYfXlxgzknQZoExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTpN3ypD; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8900bb93so33533811cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707843121; x=1708447921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mRn5606vOVX5+HtkYIAFTEtGh672feJdsnbMQPVIbYo=;
        b=kTpN3ypDHu1dlz2IE3/QGX6Z7QL3QTCaeRbBs/MSDmmdlq8mYPUTMhb+Fv/ldFIzYv
         1pRCn/Vr+iFemmtgvT26kmHJbJczrQGrsmy+O4P5RLs2XsG96map+bZJZbUbzkT6dNK7
         opaDJlAN0CIFV9z2raP4rmJiQxJJp/RBYmUNyudJ0GxArh3MdraBZTbb6U5AbGcjCP8I
         63dg+yQlqQg/Kwf/Q7Syjv8nG4IWj2LtqHhYN12BgIbmm5Hn5W3TK30h4VUrvKMvkDh5
         yVBPSh/SslDV9MNJyeo4WrAm1T5Zs0Y8ZNkqgXs07+vvemhyPni5g3iNi2pGYlsdYRFY
         k7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843121; x=1708447921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRn5606vOVX5+HtkYIAFTEtGh672feJdsnbMQPVIbYo=;
        b=KHqTdafGYbZlmQHjfkCQRFPbxvKJBcX2nLUeSA4gDgOY1HqZiQkgFN4v8ZBmem9hl/
         uAmFxHXgjie75670zAzf4oSAg9XZwfHQPiWfYWlkOF7sbZNdeWEjcqDbzl1dgMgoEMBs
         AAvYSwTQRKbqAxUmzBLef0n6xZVvmLgX30k5uRU3IbcrajHnwQyhDq9w5dVAGmKNf+N5
         A48SwSIlp5siXm5aWDEMQb16kre0K1XiKLba1cjB7rdGu3q3y+7QOkAG5t/GVoWaR6/H
         x/FLaeK1iU1SiqX319GaYR0bBoaoGgLtJt6uWf9dPPxm4beSBiaawOkTKoAwX7J1wpNR
         TJlg==
X-Forwarded-Encrypted: i=1; AJvYcCXSiuDKMxgaCzfQ1YbiUzcaejvSpeV3mMmMMhBzcWYXFf1vP6yOnHE8LqzKv9eylRUkO+ZRyzCnxi4+vPoIgefY/yz9XPQn6NTlJ3Ee
X-Gm-Message-State: AOJu0Yz/va5GjKpZNeZFIG6YxKwofP7kZPYoI2cG3WcdO5Iq5oLVrktD
	cM5C0UsE6filcga0sqUPS63L5GgIkobM4S251HBKnfZKBkrMR102HgsCvzv/pRIz4M28hiH5WRX
	OvRjgP/E78jEsuFfBTtmdF3dGozBYRYIqc1nahA==
X-Google-Smtp-Source: AGHT+IGL3s5MvEgET6k00OXUwPAuzQ1wyEhMt8naqCYl3j/bT6K5MvvERCKCB5I8RdgTPi/c8cdcDVP28CFoAAjFM94=
X-Received: by 2002:ac8:5e0a:0:b0:42d:b559:17e4 with SMTP id
 h10-20020ac85e0a000000b0042db55917e4mr717576qtx.0.1707843120936; Tue, 13 Feb
 2024 08:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210113924.1130448-1-alexs@kernel.org> <20240210113924.1130448-3-alexs@kernel.org>
In-Reply-To: <20240210113924.1130448-3-alexs@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Feb 2024 17:51:49 +0100
Message-ID: <CAKfTPtDtf0WhtWV-eO2hMUpP2rDgTgUBPbHZYWMuytYJ9ifU5w@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] sched/fair: Rework sched_use_asym_prio() and sched_asym_prefer()
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 12:36, <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> sched_use_asym_prio() and sched_asym_prefer() are used together in various
> places. Consolidate them into a single function sched_asym().
>
> The existing sched_group_asym() is only used when collecting statistics

nit: The existing sched_asym()

> of a scheduling group. Rename it as sched_group_asym(), and remove the
> obsolete function description.
>
> This makes the code easier to read. No functional changes.
>
> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 45 ++++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 607dc310b355..426eda9eda57 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9746,8 +9746,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>         return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
>  }
>
> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
> +{
> +       /*
> +        * First check if @dst_cpu can do asym_packing load balance. Only do it
> +        * if it has higher priority than @src_cpu.
> +        */
> +       return sched_use_asym_prio(sd, dst_cpu) &&
> +               sched_asym_prefer(dst_cpu, src_cpu);
> +}
> +
>  /**
> - * sched_asym - Check if the destination CPU can do asym_packing load balance
> + * sched_group_asym - Check if the destination CPU can do asym_packing balance
>   * @env:       The load balancing environment
>   * @sgs:       Load-balancing statistics of the candidate busiest group
>   * @group:     The candidate busiest group
> @@ -9755,34 +9765,21 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>   * @env::dst_cpu can do asym_packing if it has higher priority than the
>   * preferred CPU of @group.
>   *
> - * SMT is a special case. If we are balancing load between cores, @env::dst_cpu
> - * can do asym_packing balance only if all its SMT siblings are idle. Also, it
> - * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
> - * imbalances in the number of CPUS are dealt with in find_busiest_group().
> - *
> - * If we are balancing load within an SMT core, or at PKG domain level, always
> - * proceed.
> - *
>   * Return: true if @env::dst_cpu can do with asym_packing load balance. False
>   * otherwise.
>   */
>  static inline bool
> -sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
> +sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>  {
> -       /* Ensure that the whole local core is idle, if applicable. */
> -       if (!sched_use_asym_prio(env->sd, env->dst_cpu))
> -               return false;
> -
>         /*
> -        * CPU priorities does not make sense for SMT cores with more than one
> +        * CPU priorities do not make sense for SMT cores with more than one
>          * busy sibling.
>          */
> -       if (group->flags & SD_SHARE_CPUCAPACITY) {
> -               if (sgs->group_weight - sgs->idle_cpus != 1)
> -                       return false;
> -       }
> +       if ((group->flags & SD_SHARE_CPUCAPACITY) &&
> +           (sgs->group_weight - sgs->idle_cpus != 1))
> +               return false;
>
> -       return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> +       return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
>  }
>
>  /* One group has more than one SMT CPU while the other group does not */
> @@ -9938,7 +9935,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>         /* Check if dst CPU is idle and preferred to this group */
>         if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>             env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -           sched_asym(env, sgs, group)) {
> +           sched_group_asym(env, sgs, group)) {
>                 sgs->group_asym_packing = 1;
>         }
>
> @@ -11037,8 +11034,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                  * SMT cores with more than one busy sibling.
>                  */
>                 if ((env->sd->flags & SD_ASYM_PACKING) &&
> -                   sched_use_asym_prio(env->sd, i) &&
> -                   sched_asym_prefer(i, env->dst_cpu) &&
> +                   sched_asym(env->sd, i, env->dst_cpu) &&
>                     nr_running == 1)
>                         continue;
>
> @@ -11908,8 +11904,7 @@ static void nohz_balancer_kick(struct rq *rq)
>                  * preferred CPU must be idle.
>                  */
>                 for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> -                       if (sched_use_asym_prio(sd, i) &&
> -                           sched_asym_prefer(i, cpu)) {
> +                       if (sched_asym(sd, i, cpu)) {
>                                 flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>                                 goto unlock;
>                         }
> --
> 2.43.0
>

