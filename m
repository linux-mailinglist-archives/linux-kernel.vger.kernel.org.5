Return-Path: <linux-kernel+bounces-95884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C12875489
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38DC1C213E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8218F130ACA;
	Thu,  7 Mar 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaABZPfm"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02612FF73
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830264; cv=none; b=c+jK15nyo3NNost7imK6s8ZX8sQsX3WIu44oY/ni5sOidXAbTpsb4nyZbTJ5tTpge3fqsCN/WBuO5d6hQgVY/WVQsQYhHz4V+cD+LZUxZJF84FPPcKBD7of8XlucMKLG0AxSi+03mFNVWAtcUNMxLBbDTD+1gZziYqdFUczWS1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830264; c=relaxed/simple;
	bh=o0wDnFQE/UgRHDJUP8xHoJ0uQCB6x96A53eFl+42EdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=In5dVs0ZH1EbXhNRpMMlEYPi/msqa/NTEoA5VLhJncVHx0+Knq1wPErjoENv+Yov0gSDW6QT7jYkTSNomiGUo427/UZewtrp6iuYjtWIKHVJ3AvdegCNwYk6TyBydJiVdAG9aKheV3SJLw7g7la58qGMygqMG4XL92I9dwKWqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vaABZPfm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e5d7f1f25fso880041b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 08:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709830262; x=1710435062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V5mzOB5/19EpsZsphgp+c/bCZCD3f/8ktYCIs8YfkTE=;
        b=vaABZPfmc6dXS0DNxuA0ljd2PNXcE1eSPdW9jNa08stwp3oTIbEhJaQAF9n6FuLHOE
         X8tEE0yRVDv+28DLbzkvEyNfQzStDkNPXsi4XyV/lTL86gETsx9hkOL1QwZn3h4PlM21
         o0o2VvB/0QEUctAD9FWlsB53B3hhAdnrO0+diPWr/9OHzTGkUzJXvakAs6Zm0whgoh9k
         9RyVxPFZuSIjDmyz21XMuTJss1l33ylyVz8M+kWA16HFT+n1EJ2ztk7oxKLSr+nZSzGn
         +jwhOKD/3thTBbc5fKq7wXlLr/yybfu0JZZQIB7coQ8OBkl9waiCXdONAcmIlvKiCL8T
         5LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830262; x=1710435062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5mzOB5/19EpsZsphgp+c/bCZCD3f/8ktYCIs8YfkTE=;
        b=DfvquReKz9+v9pAcxsO9L3jgvX/5n08yOky/7KeMWQZR68cZReqpTVtKzJ5XtV2wxe
         bKAgxXHqMbE130rrmFG/Akvi6U2czaV7TylynZECFvp9SVIFFYn6E26Ufnhm5+dlIFSl
         wzS1pCedwtDKZlcBkEMrw0in+Grzz8+t8acrEofJhG4dHsbb3rPvSJ0LiSBJZggTqcWw
         OS9Jx6pGaqEB1ZOa/xQqbpAkUBD3inSMWaRvwT8U5teGm84PxtcWnJu5c6pnuC88m0mg
         hp7lwxxP8jWh1BwYYTqsIl1jD7XsEo58x1BTz/IdHV/gFB40Q4p4YAOoA1B/gb2/n/nr
         /v/g==
X-Forwarded-Encrypted: i=1; AJvYcCUJttk8bmckPJMgr53EaJXwfDR3xhQC4beQu2e12HX2oLMsYGbr1so7BXgf/enUrXyLCzKqx92Zs+XTUp1KwPLokZPSOFQnHQcu3/iB
X-Gm-Message-State: AOJu0YyykI3ZKi2ocW/apXpx/3LIHsPyKFiHF2dvxOhtcpweCpPRzhoK
	DD5yPXajkg1HFC7Hti7n3xPly0ihBTT/UubQCkNjFllwMSv5dL4F9/aszh/nH6dXlj9rdkVztal
	OIggYoYI3J3ibp2vsUXhyJebR1H+8TVyjRXwz4Q==
X-Google-Smtp-Source: AGHT+IFRmiMildRJG7i4OFd65XF5q2651R4vc3ctJyW1223ICgqLhAqThtXII8T5kEr0PATip2VR6BtqaL02g8QeovM=
X-Received: by 2002:a17:90a:94cc:b0:29b:aaf2:95a2 with SMTP id
 j12-20020a17090a94cc00b0029baaf295a2mr199200pjw.8.1709830262432; Thu, 07 Mar
 2024 08:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307085725.444486-1-sshegde@linux.ibm.com> <20240307085725.444486-3-sshegde@linux.ibm.com>
In-Reply-To: <20240307085725.444486-3-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 7 Mar 2024 17:50:51 +0100
Message-ID: <CAKfTPtBMyxrG+nUB1cZo3kuq9u0t4vqqxxOzh-g7h_jABx4qrg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] sched/fair: Use helper function to access rd->overutilized
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, yu.c.chen@intel.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com, 
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com, 
	pierre.gondois@arm.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 09:58, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Overutilized field is accessed directly in multiple places.
> So it could use a helper function. That way one might be more
> informed that it needs to be used only in case of EAS.
>
> No change in functionality intended.
>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
>  kernel/sched/fair.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5aa6e918598c..87e08a252f94 100644
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
> @@ -7980,7 +7989,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>         rcu_read_lock();
>         pd = rcu_dereference(rd->pd);
> -       if (!pd || READ_ONCE(rd->overutilized))
> +       if (!pd || is_rd_overutilized(rd))
>                 goto unlock;
>
>         /*
> @@ -10863,7 +10872,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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

