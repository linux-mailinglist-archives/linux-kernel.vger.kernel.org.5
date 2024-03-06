Return-Path: <linux-kernel+bounces-94339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EBA873D98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D591C223C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC1013BAE7;
	Wed,  6 Mar 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXN9fcRJ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2285E08B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746831; cv=none; b=LQyPQOEJ7hRCn13knpTUk5zOWY4E6sU6lRWRCgiOIdh0gvzcUdmBij8PZClE22vPhf5Yn6dYh6N6e687TnjWgqVGgxvnrDlLAaI/qOydiKxnKi6Ly1peYIIw3MC3gPYMZlwh5DXgrSDvQgR1DSPN/8DLH778osIjnw773y5SvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746831; c=relaxed/simple;
	bh=mVV7zXlN8fszW38oHKvvJRLttQm7teAyxRGq3P9YKcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIc9VY576yGzsnViXJQPZtb7PHKXNEWuCaZsEHkTlVB9ZltSXKUozJ3VyNGhee97OD0cCKKksTaulzEyaCzhDlUB0jPDrL8EkofSPZd/cc7bnc+p0DUemlzmfgZV95zbvlrW6js3H0IyuKmiEGZN/VkFE5C8APUaV3Nk+h4Sths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VXN9fcRJ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a2d0f69a6so5127750a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709746829; x=1710351629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MOwDT3mxKZpx/kT9fAlhLNpVaeUclbZHbSik1IBFPr8=;
        b=VXN9fcRJDJ3esgvm0uJIhBYfnEU7Ro/T2MWRxfAH0EGeXGpwHQLZS1LbLQwBOMLg3O
         ENTbKVunmUMDgloEyjJObeWo7Ky/O5UDaYXbHnxPW1ed07f8haed1/mGPFX04H71BZRM
         HME2NmEPfSG42gdiZrfp88gBxK1+wcC5lryuApIC37W0XjCFFuPA0QypUcBEm0ITUUmQ
         3sZWBalcFH3HXlo+fBt/cu+2PdD5hWOTJsJWdwnQORqB9tf99dCLs3SBk7H+1SDWmwiv
         2owEvDc3a3jKpM0GAOtJ3MiC+sj6hSebzkZasiJpzfXL/TpXw8m//3zq8vkrf/UeBzYm
         LQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746829; x=1710351629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOwDT3mxKZpx/kT9fAlhLNpVaeUclbZHbSik1IBFPr8=;
        b=akHxonJJc3lXJCt/RW1wiQTtlX/J+HmpSPsGOpdbvU/Z3ej1NMKCRbRzqmtBGBOne5
         t0A+5WFsA0irBaRc93lFvexqqoaQF2AU5zI/2xqBAMXCkdpXa54pI1lMuuGG+p4zlWgB
         xtv9Vi9EEplc7+zl32mO7o5OP9n9N/DDQX8gLYAWlMWSEzZhBthjq10Qkw75cagf9vTq
         04L/eN3Al6fmj45jav4OGreMIvwNRahuPeiFChb7h44zDlSvOF9fNnb0BoxfKDevM3pe
         odCeWV4pnGra6bhjJSXNroTWS/N2IlpHl0MAHX+cR4ihbS7kFa+x/bbSvVbopxCyKNhM
         4LXA==
X-Forwarded-Encrypted: i=1; AJvYcCVyjE/1Fppl3rwdF4sNnLa1XuROaewTGMjy2L2e+eWAgmyV20/N7Mz6UdG3OlrfM9Mae36OCak0XfapWfbxlEXAmqFkc6NSfMV05ISv
X-Gm-Message-State: AOJu0YyJQnN/sy4Kvlw2DkYBwwWGvg48BSuDJLvYgFwwEKDyFOT7b740
	EVoEg42frQOxT6FBfc0qn6e8ddu7pQBx20/443fmxciBAt67YoIzJJoYXwxA2gym4aKTMAkokXY
	Asb29ez8BcZbrF2K71gTRbk8XtVu5DBIKwFjRxA==
X-Google-Smtp-Source: AGHT+IHAkBq70pcCGsKGL5RKfrfdawncIUvLiDdEraLvmQdgeU4THjXrsB/E5Z/zEkWW4FfXWruPN33jkIH+hUoUvXQ=
X-Received: by 2002:a17:90a:3004:b0:299:6389:2961 with SMTP id
 g4-20020a17090a300400b0029963892961mr14227703pjb.13.1709746829085; Wed, 06
 Mar 2024 09:40:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306102454.341014-1-sshegde@linux.ibm.com> <20240306102454.341014-3-sshegde@linux.ibm.com>
In-Reply-To: <20240306102454.341014-3-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Mar 2024 18:40:18 +0100
Message-ID: <CAKfTPtCyw7KLzwW6KEhva89hKF-yC91nARvx87wcP6GKGk_YKQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] sched/fair: Use helper function to access rd->overutilized
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, yu.c.chen@intel.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com, 
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com, 
	pierre.gondois@arm.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:25, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Overutilized field is accessed directly in multiple places.
> So it could use a helper function. That way one might be more
> informed that it needs to be used only in case of EAS.
>
> No change in functionality intended.
>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 997e570d9423..e3086c8930ea 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6675,6 +6675,15 @@ static inline bool cpu_overutilized(int cpu)
>         return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
>  }
>
> +/*
> + * Ensure that caller can do EAS. overutilized value
> + * make sense only if EAS is enabled
> + */
> +static inline int is_rd_overutilized(struct root_domain *rd)
> +{
> +       return READ_ONCE(rd->overutilized);
> +}
> +
>  static inline void set_rd_overutilized_status(struct root_domain *rd,
>                                               unsigned int status)
>  {
> @@ -6694,7 +6703,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
>         if (!sched_energy_enabled())
>                 return;
>
> -       if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +       if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>                 set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  }
>  #else
> @@ -6708,6 +6717,11 @@ static inline void set_rd_overutilized_status(struct root_domain *rd,
>  {
>         return 0;
>  }
> +
> +static inline int is_rd_overutilized(struct root_domain *rd)

I don't think that is_rd_overutilized() is called outside #ifdef
CONFIG_SMP so you can remove it.


> +{
> +       return 0;
> +}
>  #endif
>
>  /* Runqueue only has SCHED_IDLE tasks enqueued */
> @@ -7989,7 +8003,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>         rcu_read_lock();
>         pd = rcu_dereference(rd->pd);
> -       if (!pd || READ_ONCE(rd->overutilized))
> +       if (!pd || is_rd_overutilized(rd))
>                 goto unlock;
>
>         /*
> @@ -10872,7 +10886,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>         if (sched_energy_enabled()) {
>                 struct root_domain *rd = env->dst_rq->rd;
>
> -               if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
> +               if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
>                         goto out_balanced;
>         }
>
> --
> 2.39.3
>

