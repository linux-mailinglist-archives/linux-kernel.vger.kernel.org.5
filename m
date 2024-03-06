Return-Path: <linux-kernel+bounces-94338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117A873D96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26D31C21F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F52913BADE;
	Wed,  6 Mar 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4HDI7Rc"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9F5E08B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746822; cv=none; b=WWLgyXnsc24VyeNIxeuM+wCPIszL/Yphrwf0r8tpGeHF5e/5wSTiHX/HhhfGb65Az/os3qR0g8zXFinnt/1zys1mwGkUosmGQ4hQlSXu16kTWC4VVFIdltb1cGhhkXZdGbmVCQzNoeIYOBYO4fxgty/amqXPBjXdQuf1NqFgUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746822; c=relaxed/simple;
	bh=+UXpkKd9uBAwhOreKKmpmRBiXdMvt3tWxYP+26JRLzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuTIlnbv/DvAizIkZiepUUA4CaeyluM7ZY4Zf/bBRi8dUVUpu2Y4HQdeJi+zcsXKNg05J0z1Zrlje6DBTnnhjotCmWwMosoymVNk6SUoy/umHJddyexKQb5CxI9T2s8Ch6+0jh9Wc4DzW++Dja4TLDEd9//VG8dq96o8+XsgA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4HDI7Rc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso6195774a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 09:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709746820; x=1710351620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jjEQ2qy4p9w+zhcqLZMn3ai4LJLFbv1uViASPRI0Mg=;
        b=T4HDI7RcVelCcR33jxBSpxLJjocVvUAocLtKUdGEP08t5tFnCRGzBUPAu/pBxCVW7z
         iwM9qya+CUE9xY6yhaR5mRQ6ADrd57uQVaOUmSQkNlWyua/vYarBo7l6wI1AqhR6pGVO
         g+XTKCMDMmwxAsdjEzT7186mnfO6WBgLbUKFt/yP5hd6v3kpRxfDgbrB2IXQxJcQT/Bj
         OMmvmNeRwdqhSxLjWJP0P1DHLiwZdHD696SGB269n/zUU5Xs/N58dTwC+9ZMYmR6SMH0
         EXAbmPdSl6VjbyPFhN3z+vDbeklpfFMvSRiuAG6ooYINplZyHiSzU1XegI0feJO1Mpwp
         ImTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746820; x=1710351620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jjEQ2qy4p9w+zhcqLZMn3ai4LJLFbv1uViASPRI0Mg=;
        b=NxCPBCkzMDk5I5WoDy1Qo6FZ9uWuRah9Lj7PWQqn3XVrcSrRiF/B8fCSMOX6PyOmgE
         GZ51hfGvOuBw0CscxO+PfskEjCfd5dzaSW/V3qb5KQzaQhi7Weav/45cq3gxi+oJc9xc
         Ah7xNgFH4XxZ1ijJuwuM6hqdLSlu53bkYendwK+/a2k3L6iPSAFGzD26X7V/E9gDIUo3
         GaO7Gs+jcJqOQ5h0/iv4HEbcKGud8DxUndfWUALRJdlHx7Uapvct8qYSzenPAyxJ8Jvn
         hhLKdzSz6UqCnNzXnDhwDQOxgHODolkKKv7V9lcwBcVJYzSdquAJQKHLgjSvEOLONGHZ
         YajA==
X-Forwarded-Encrypted: i=1; AJvYcCW35YOuPJD/U+R9IV/RlxtjAdqJdc0E1zDGRKABr1KmLWBqDFXv+oedla4JziJ3gms671jhssg6Dmwou5V8+nFPSGQ8BT5KfQoTFRKI
X-Gm-Message-State: AOJu0YwxUC7YFX+4PuNngySOrNvI64Cdtk5LGBgIY/kKWDeedE6FAaJq
	Fp6xETHc+XVXG8W1HJ/sW2ahLxalL8YUDXUc8svip+6mcInwbG3JmOJLbU3vohTrrPrezEESzqV
	G6PiodwZj6PQPEV+ZKyI9Khxg5LK3KThg5KC6dw==
X-Google-Smtp-Source: AGHT+IFEFQHYcpTnrdmuLPc8a39HUAS4enft7K9I+PbDh0VEkgjaiIpW7GpFqE+Me9qp84wgA29q+RhAe7Sa2eEVf+U=
X-Received: by 2002:a17:90a:fb81:b0:29a:1708:9878 with SMTP id
 cp1-20020a17090afb8100b0029a17089878mr15023639pjb.38.1709746820080; Wed, 06
 Mar 2024 09:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306102454.341014-1-sshegde@linux.ibm.com> <20240306102454.341014-2-sshegde@linux.ibm.com>
In-Reply-To: <20240306102454.341014-2-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Mar 2024 18:40:08 +0100
Message-ID: <CAKfTPtCnN95A8kQ-uBA7ykTMAzQVRzwER-XNJt4YyQXdxhDCTQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] sched/fair: Add EAS checks before updating overutilized
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, yu.c.chen@intel.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com, 
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com, 
	pierre.gondois@arm.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:25, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Overutilized field of root domain is only used for EAS(energy aware scheduler)
> to decide whether to do load balance or not. It is not used if EAS
> not possible.
>
> Currently enqueue_task_fair and task_tick_fair accesses, sometime updates
> this field. In update_sd_lb_stats it is updated often. This causes cache
> contention due to true sharing and burns a lot of cycles. overload and
> overutilized are part of the same cacheline. Updating it often invalidates
> the cacheline. That causes access  to overload to slow down due to
> false sharing. Hence add EAS check before accessing/updating this field.
> EAS check is optimized at compile time or it is a static branch.
> Hence it shouldn't cost much.
>
> With the patch, both enqueue_task_fair and newidle_balance don't show
> up as hot routines in perf profile.
>
> 6.8-rc4:
> 7.18%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 6.78%  s                [kernel.vmlinux]              [k] newidle_balance
> +patch:
> 0.14%  swapper          [kernel.vmlinux]              [k] enqueue_task_fair
> 0.00%  swapper          [kernel.vmlinux]              [k] newidle_balance
>
> Minor change: trace_sched_overutilized_tp expect that second argument to
> be bool. So do a int to bool conversion for that.
>
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 62 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..997e570d9423 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6663,22 +6663,51 @@ static inline void hrtick_update(struct rq *rq)
>  #ifdef CONFIG_SMP
>  static inline bool cpu_overutilized(int cpu)
>  {
> -       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> -       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> +       unsigned long  rq_util_min, rq_util_max;
> +
> +       if (!sched_energy_enabled())
> +               return false;
> +
> +       rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> +       rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
>
>         /* Return true only if the utilization doesn't fit CPU's capacity */
>         return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
>
> -static inline void update_overutilized_status(struct rq *rq)
> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> +                                             unsigned int status)
>  {
> -       if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
> -               WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
> -       }
> +       if (!sched_energy_enabled())
> +               return;
> +
> +       WRITE_ONCE(rd->overutilized, status);
> +       trace_sched_overutilized_tp(rd, !!status);
> +}
> +
> +static inline void check_update_overutilized_status(struct rq *rq)
> +{
> +       /*
> +        * overutilized field is used for load balancing decisions only
> +        * if energy aware scheduler is being used
> +        */
> +       if (!sched_energy_enabled())
> +               return;
> +
> +       if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +               set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  }
>  #else
> -static inline void update_overutilized_status(struct rq *rq) { }
> +static inline void check_update_overutilized_status(struct rq *rq)
> +{
> +       return 0;
> +}

static inline void check_update_overutilized_status(struct rq *rq) { }

> +
> +static inline void set_rd_overutilized_status(struct root_domain *rd,
> +                                             unsigned int status)
> +{
> +       return 0;
> +}

static inline void set_rd_overutilized_status(struct rq *rq) { }

my comment on v4 about {return 0; } applies only for static inline int
is_rd_overutilized(struct root_domain *rd)

Also, I don't think that set_rd_overutilized_status() is called
outside #ifdef CONFIG_SMP so you can remove it.




>  #endif
>
>  /* Runqueue only has SCHED_IDLE tasks enqueued */
> @@ -6779,7 +6808,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>          * and the following generally works well enough in practice.
>          */
>         if (!task_new)
> -               update_overutilized_status(rq);
> +               check_update_overutilized_status(rq);
>
>  enqueue_throttle:
>         assert_list_leaf_cfs_rq(rq);
> @@ -10596,19 +10625,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                 env->fbq_type = fbq_classify_group(&sds->busiest_stat);
>
>         if (!env->sd->parent) {
> -               struct root_domain *rd = env->dst_rq->rd;
> -
>                 /* update overload indicator if we are at root domain */
> -               WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
> +               WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
>
>                 /* Update over-utilization (tipping point, U >= 0) indicator */
> -               WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
> +               set_rd_overutilized_status(env->dst_rq->rd,
> +                                          sg_status & SG_OVERUTILIZED);
>         } else if (sg_status & SG_OVERUTILIZED) {
> -               struct root_domain *rd = env->dst_rq->rd;
> -
> -               WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> -               trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> +               set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
>         }
>
>         update_idle_cpu_scan(env, sum_util);
> @@ -12609,7 +12633,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>                 task_tick_numa(rq, curr);
>
>         update_misfit_status(curr, rq);
> -       update_overutilized_status(task_rq(curr));
> +       check_update_overutilized_status(task_rq(curr));
>
>         task_tick_core(rq, curr);
>  }
> --
> 2.39.3
>

