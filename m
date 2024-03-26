Return-Path: <linux-kernel+bounces-119146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEB488C4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE51F66621
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C612A171;
	Tue, 26 Mar 2024 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngKfhZtd"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798B4129E6C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462351; cv=none; b=TxnEuGfFQGTV7t4L0f32yV5gO8uHYjZF3Lb50k3Ha+h5JjwldrFHcMqF+pzL4KyTdJemZXLSz9/vqVxcp20SfQblhiSrN9c2BRqUTu7jl6NyWXVU4Inx/phGbzLV+i7HntiSwJd6RfglPQG09jUgmD5FanPemTNC8giq0xOANDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462351; c=relaxed/simple;
	bh=rqD+9oinJK3/MbfIo9oYM9IoKJ5n0iVPVmUSbQUjcPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hU5ObRtuFucuGPRfVRxNdI1A3GwCuWqTjsiFUcTAvUrFeFRpl1Kcb8U3LZrBGnP1KE62SxhJ8Y+IuUe4TQaTCtf8DoPG+TIOjMkAemYM7q4xOdfcSvhqzNlcZ07m+pKvCnCTdF3aRCLhSV33SB0qRW44XO1QpdbUOCYIZlf4jiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngKfhZtd; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3983112a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711462349; x=1712067149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mSBOeRjNSlZVOdoSuzOxvESWRKYZQlmkHO76+F8yIFI=;
        b=ngKfhZtdNx+tzUhzGz3XOmKc3Tb7EPQbPNzLyBISEGtbW2yr8RXzytfkyA3kIkr7Lo
         WfQwAHW9g+TuTWxOYZkzUNBvrHiUjufimgX00x1O4Se7BjS3w6oeKHSktzHrld5YPDEV
         Hn7jIeRW2geH18yZ+wG6jYViJ8VN4QkToxUYimdIOGsRy0/dnpoR/gmsfm+CtWRFLOJI
         fUM9Y6U/IPuj4YVTYh14L0PhfwBMLLuEhPOEFHAPg7OF9VEwCEbVOSz0h/YLeFne6RYq
         IZImvBW5ovGw1rsG0SZdysuzetaG22FU7yV8yWGwi7uSkouvPNhzncnc0XyAvbKdTkM+
         rejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462349; x=1712067149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSBOeRjNSlZVOdoSuzOxvESWRKYZQlmkHO76+F8yIFI=;
        b=PmwIjdHq4bsTLk/ygNi1or/5EzVOMAiG92lIpiGGZYVgRkGWAIiFC+WtHPOt0QmVVW
         C02rcdRvhMioPMGA3AspdbHUM764SLBQOq/oxmVRUEq4DfS+CLXIVZjb+rHduLzzTdLY
         WBCjIq3vwO1opiB2smlXcAFR97m5ITo66HqP3kzT/9Fsxo00w9/E0W6fYZQJc/wC+s/d
         KpX1rnhA8p+XngCqyJYrrUHINkL56ehVc0xQ/+46T1WYgQrKikSLdEjhUQDx7MIP3JH/
         x3GyVEuYnTMh4Ik32FgOGTxlVBhCuwSk1KYX2RzPsQqhd3dkal8KxNSgqZamn7Gwt/j7
         rBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhNmAQEYoHjrmE34Xk3CZ50x88Xigv73+d1VuggrwSjHS6jB2LIM0AZwTIKj2DxJNw29xWk0pbiqKrWmQr/DqngO26MpJ7IGIq/8/f
X-Gm-Message-State: AOJu0Yz7mH9AF4ekjp+JVACvUiCwhrb8Xb+LBdawJ9aOjTPElnFCTwaI
	4I16zr0CbjtxG5Nl/pjwCytyCdrhxlM6OmPvFN28GAabcyCUn25Cox0Fs7il94rPv3saqvnEVjY
	oo0nzZWXuaO+SXAaAcBA7BnVKWdEqo0dqDKoFnA==
X-Google-Smtp-Source: AGHT+IEWXXKT04XrUR7cK4Zm9RvznF7JSL0/rOqWbzBXe5OCsMb3XOlkguPM2+YqxehMgasxM72bvL6PPeppfF8pt8k=
X-Received: by 2002:a17:90b:109:b0:29c:5ba6:c518 with SMTP id
 p9-20020a17090b010900b0029c5ba6c518mr8867359pjz.6.1711462348807; Tue, 26 Mar
 2024 07:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307085725.444486-1-sshegde@linux.ibm.com>
 <20240307085725.444486-4-sshegde@linux.ibm.com> <ZgKAJAiAM61MLPBN@gmail.com>
 <CAKfTPtBTUHv3xBe0U75_4GGYPLYj-NC1uSGd6QjdQyS5k1N0QA@mail.gmail.com> <3495922c-91cd-448f-8831-5ce8bab0eda4@linux.ibm.com>
In-Reply-To: <3495922c-91cd-448f-8831-5ce8bab0eda4@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 26 Mar 2024 15:12:17 +0100
Message-ID: <CAKfTPtDPMShXQYv7ZtfZ6RAgve3Ogsn7aDAYFj7vJuTYe9BOfg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] sched/fair: Combine EAS check with overutilized access
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, peterz@infradead.org, yu.c.chen@intel.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com, 
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com, 
	pierre.gondois@arm.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 13:26, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
>
>
> On 3/26/24 1:56 PM, Vincent Guittot wrote:
> > On Tue, 26 Mar 2024 at 08:58, Ingo Molnar <mingo@kernel.org> wrote:
> >>
> >>
> >> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> >>
> >>>  /*
> >>> - * Ensure that caller can do EAS. overutilized value
> >>> - * make sense only if EAS is enabled
> >>> + * overutilized value make sense only if EAS is enabled
> >>>   */
> >>> -static inline int is_rd_overutilized(struct root_domain *rd)
> >>> +static inline int is_rd_not_overutilized(struct root_domain *rd)
> >>>  {
> >>> -     return READ_ONCE(rd->overutilized);
> >>> +     return sched_energy_enabled() && !READ_ONCE(rd->overutilized);
> >>>  }
> >>
> >> While adding the sched_energy_enabled() condition looks OK, the _not prefix
> >> This is silly: putting logical operators into functions names is far less
> >> readable than a !fn()...
> >>
> >>> -     if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> >>> +     if (is_rd_not_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
> >>
> >> Especially since we already have cpu_overutilized(). It's far more coherent
> >> to have the same basic attribute functions and put any negation into
> >> *actual* logical operators.
> >
> > I was concerned by the || in this case that could defeat the purpose
> > of sched_energy_enabled() but it will return early anyway
> >
>
> > return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
>
> I think this would work.
>
> >
> >>
> >> Thanks,
> >>
> >>         Ingo
>
>
> If EAS - false, then is_rd_overutilized -> would be true always and all users of it do !is_rd_overutilized(). so No operation.
> If EAS - true, it reads rd->overutilized value.
>
> Does this look correct?

yes looks good to me

> -------------------------------------------------------------------------------------
> From 3adc0d58f87d8a2e96196a0f47bcd0d2afd057ae Mon Sep 17 00:00:00 2001
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> Date: Wed, 6 Mar 2024 03:58:58 -0500
> Subject: [PATCH v7 3/3] sched/fair: Combine EAS check with overutilized access
>
> Access to overutilized is always used with sched_energy_enabled in
> the pattern:
>
> if (sched_energy_enabled && !overutilized)
>        do something
>
> So modify the helper function to return this pattern. This is more
> readable code as it would say, do something when root domain is not
> overutilized. This function always return true when EAS is disabled.
>
> No change in functionality intended.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 24a7530a7d3f..e222e3ad4cfe 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6686,12 +6686,11 @@ static inline bool cpu_overutilized(int cpu)
>  }
>
>  /*
> - * Ensure that caller can do EAS. overutilized value
> - * make sense only if EAS is enabled
> + * overutilized value make sense only if EAS is enabled
>   */
>  static inline int is_rd_overutilized(struct root_domain *rd)
>  {
> -       return READ_ONCE(rd->overutilized);
> +       return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
>  }
>
>  static inline void set_rd_overutilized_status(struct root_domain *rd,
> @@ -6710,8 +6709,6 @@ static inline void check_update_overutilized_status(struct rq *rq)
>          * overutilized field is used for load balancing decisions only
>          * if energy aware scheduler is being used
>          */
> -       if (!sched_energy_enabled())
> -               return;
>
>         if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>                 set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
> @@ -7999,7 +7996,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>         rcu_read_lock();
>         pd = rcu_dereference(rd->pd);
> -       if (!pd || is_rd_overutilized(rd))
> +       if (!pd)
>                 goto unlock;
>
>         /*
> @@ -8202,7 +8199,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>                     cpumask_test_cpu(cpu, p->cpus_ptr))
>                         return cpu;
>
> -               if (sched_energy_enabled()) {
> +               if (!is_rd_overutilized(this_rq()->rd)) {
>                         new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>                         if (new_cpu >= 0)
>                                 return new_cpu;
> @@ -10903,12 +10900,9 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
>         if (busiest->group_type == group_misfit_task)
>                 goto force_balance;
>
> -       if (sched_energy_enabled()) {
> -               struct root_domain *rd = env->dst_rq->rd;
> -
> -               if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
> -                       goto out_balanced;
> -       }
> +       if (!is_rd_overutilized(env->dst_rq->rd) &&
> +           rcu_dereference(env->dst_rq->rd->pd))
> +               goto out_balanced;
>
>         /* ASYM feature bypasses nice load balance check */
>         if (busiest->group_type == group_asym_packing)
> --
> 2.39.3

