Return-Path: <linux-kernel+bounces-51615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771A8848D3E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9124E1C20C40
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3EC2231A;
	Sun,  4 Feb 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM9faMsm"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799E22309
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047557; cv=none; b=SirFcnts4WAlykDfH876zWVJy7333Pvmc+lRX+NBaqoT3qXLRBazaTq+X5uO3zsPA4NlRXcM2rzUTcpSoAcDYZbLWN3OmUEARtK4pHeVFnLMT+SxZo20uiCNEN+GSyM+rXq0H6gUmweRizpsFbnW/6WePGEx4nSddpQMJExTBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047557; c=relaxed/simple;
	bh=bxBPGGvwVJJzUc1Vl+e1Akemh2MukMeXMa1+AKCYn+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tEq2vcBc2S6TCp/xsQtc7GTOQz/nSKhm3aTZ4HyP8iymNDWu8oAv9ih7sfWUnOnqIJOFIRKeQtaHKJAkSwQY5yaABUMGBJXlELoH2c1csqw2w0hw1eAnZeqBEzUwjkDFaPA/MgchR+MeMZH95EyNlF36zyWGeJUGDj0Ci0rBWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM9faMsm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce2aada130so3286850a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707047555; x=1707652355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lOtzn1Z2sTKXrKJx+kwGpJgHDKcK6EEaVP/X1yHlRk0=;
        b=KM9faMsmZFW0nFOmydocU+L8+LHKca1MAE/pWki0MFmY5rN/40OAtkR0+KPlAE5BCY
         G9n0mMuTznGJdqcXh9MhLeI/2ZLQ5VdEfKNAYCBDAe0w2R8t/OVIlxP9Oq7WxHsaGL7o
         4gzqBNMpMf333zQpplrOKnFtCwNVlCebmPVWeB7C7UT6eNYqFufgtU368GLoLTUEUGQB
         kA3wPjpfOzgKvj9OYYzYoLnivpd6oaGdwTWw1oKZfp9t0ebJZkKfKsZ+ilr/uHubowXD
         Q7+zkSugWRNN2EbWYSXVevjgnKEa98AIalMA6zOm6VV6f+8BIWqmMUVNOI1O9cTzVM6K
         qIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707047555; x=1707652355;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOtzn1Z2sTKXrKJx+kwGpJgHDKcK6EEaVP/X1yHlRk0=;
        b=V9jfEd4NpVxWA0MDyE2ityk/lsdW0CEFSkMi1hfaaQ//SZIDiRokYJER/ombKpLAGH
         THH+tYzV3j57Jj5NrEA53qghvcXELG8G8FKXigAmFJTO1YJ8f14DUtoRkQlZLBSU7ZFY
         ZDBkn9hj39XNad4ucb07bLQXIuRd2jnBqugEWAOgXuGjlX10laEX7Juteu3qXiuq2Bo2
         zXZ00jBPZkNKRydw2jffuxmyC/FXxiEvBSLaD5ptpoCK6xyIEKaJHxIPacquhTmukkmN
         Cu7ghjVtojqMpODvs6Kz8cRsw8BgA4TPZ9MqpwONa22I7TjNHzsGmzDhPTvoaX70oJEb
         DIsw==
X-Gm-Message-State: AOJu0YxdAhKgugLMjX5FBucZxDpuRcdb76QmEcU/9V2ZxJBD6kOY1VTQ
	y3DR6Bp1mXvHIyoYE1f77yEbPC7s8SFqYIWK80aW9v+9NKbSHW0B
X-Google-Smtp-Source: AGHT+IHQ3rUT7K5t2xMXc8cpoDtzAG44GFXJSkabWq19LuXGh7+mFE3+wyPOMlYLzH2hD3oW5KV7yw==
X-Received: by 2002:a05:6a20:7a24:b0:19c:955e:7100 with SMTP id t36-20020a056a207a2400b0019c955e7100mr10817398pzh.62.1707047555483;
        Sun, 04 Feb 2024 03:52:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzY3qjs0M38VTvUtE8KI7uDGsuzZNAPwJeSulvgJwSkmFjhGY2DQZTT/aPThvsVo/5U+U2kmU6odqGr+S8vz/SvgeAGJutROqwhKNNzVN+qHr9twvQUdSxNSYGM3pSzKkD5GzTLZjnwj+GzGfogzTm9hBc6x2Kg9LfFqIy0flkSos0KL2oPc0cwuwSRTPYCJ2TZVsYk/sYgIqMoK4OyuG5MpXLstlHxssd/9kuJA+78OzwWU9XWqUr1hQVTl33cQ3YblKO4q2rBOtBOlMkjXWfcZj6gbpVndDrIZdoClbjd95Vdqm0IJtLYch6M1dtrm/9vM8GSwUy0XVk2Et6k3lt7Eib03g/RhwH70bWUhsm9AqetbtyKe1Y7qQgewQkDqFYF19swXnXiUwOvM05iul6v9m+eSmQ+JCJKO1TLQjEoPfuOGfYyIBEXFiWdroblYLw
Received: from [192.168.255.10] ([43.132.141.26])
        by smtp.gmail.com with ESMTPSA id kk2-20020a17090b4a0200b00295b592189dsm3170396pjb.3.2024.02.04.03.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 03:52:34 -0800 (PST)
Message-ID: <fa3d3e19-b95e-4160-85ce-3a68d73fd7c0@gmail.com>
Date: Sun, 4 Feb 2024 19:52:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] sched/fair: packing func
 sched_use_asym_prio()/sched_asym_prefer()
Content-Language: en-US
To: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 ricardo.neri-calderon@linux.intel.com, sshegde@linux.ibm.com
References: <20240201115447.522627-1-alexs@kernel.org>
 <20240201115447.522627-3-alexs@kernel.org>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240201115447.522627-3-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

Since your good suggestions took in this and the next patch, do you mind to give Reviewed-by for both of them?

Thanks
Alex

On 2/1/24 7:54 PM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> Consolidate the functions sched_use_asym_prio() and sched_asym_prefer()
> into one. and rename sched_asym() as sched_group_asym().
> This makes the code easier to read. No functional changes.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8d70417f5125..44fd5e2ca642 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9747,8 +9747,15 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
>  }
>  
> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
> +{
> +	/* Check if asym balance applicable, then check priorities.*/
> +	return sched_use_asym_prio(sd, dst_cpu) &&
> +		sched_asym_prefer(dst_cpu, src_cpu);
> +}
> +
>  /**
> - * sched_asym - Check if the destination CPU can do asym_packing load balance
> + * sched_group_asym - Check if the destination CPU can do asym_packing balance
>   * @env:	The load balancing environment
>   * @sgs:	Load-balancing statistics of the candidate busiest group
>   * @group:	The candidate busiest group
> @@ -9768,22 +9775,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>   * otherwise.
>   */
>  static inline bool
> -sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
> +sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>  {
> -	/* Ensure that the whole local core is idle, if applicable. */
> -	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
> -		return false;
> -
>  	/*
> -	 * CPU priorities does not make sense for SMT cores with more than one
> +	 * CPU priorities do not make sense for SMT cores with more than one
>  	 * busy sibling.
>  	 */
> -	if (group->flags & SD_SHARE_CPUCAPACITY) {
> -		if (sgs->group_weight - sgs->idle_cpus != 1)
> -			return false;
> -	}
>  
> -	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> +	if ((group->flags & SD_SHARE_CPUCAPACITY) &&
> +	    (sgs->group_weight - sgs->idle_cpus != 1))
> +		return false;
> +
> +	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
>  }
>  
>  /* One group has more than one SMT CPU while the other group does not */
> @@ -9939,7 +9942,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  	/* Check if dst CPU is idle and preferred to this group */
>  	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>  	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -	    sched_asym(env, sgs, group)) {
> +	    sched_group_asym(env, sgs, group)) {
>  		sgs->group_asym_packing = 1;
>  	}
>  
> @@ -11038,8 +11041,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		 * SMT cores with more than one busy sibling.
>  		 */
>  		if ((env->sd->flags & SD_ASYM_PACKING) &&
> -		    sched_use_asym_prio(env->sd, i) &&
> -		    sched_asym_prefer(i, env->dst_cpu) &&
> +		    sched_asym(env->sd, i, env->dst_cpu) &&
>  		    nr_running == 1)
>  			continue;
>  
> @@ -11909,8 +11911,7 @@ static void nohz_balancer_kick(struct rq *rq)
>  		 * preferred CPU must be idle.
>  		 */
>  		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> -			if (sched_use_asym_prio(sd, i) &&
> -			    sched_asym_prefer(i, cpu)) {
> +			if (sched_asym(sd, i, cpu)) {
>  				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>  				goto unlock;
>  			}

