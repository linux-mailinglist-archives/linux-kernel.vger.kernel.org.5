Return-Path: <linux-kernel+bounces-92486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63282872113
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B88BB223E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C8E86141;
	Tue,  5 Mar 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHA1BF9L"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA85676A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647561; cv=none; b=nJv+jtCcZWRVH00c1BrcY6vJd2hRATuZrhXy2e92azAbKEolL5KETrtfo7CsNZRW6LOWONVgOaDAgOKajS8qPg28LdLnSieMz2riMFVGXccxXEm6ZmiTtTwHduHEsfeW84kFdACVq24hub0WZnCqlvrqXGtqFTzcaPWu3xppg6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647561; c=relaxed/simple;
	bh=T4PIDq9YbN7EXeKboyaiaQql26HqGIFxVk4Bm4vDlDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbxpBjJEIz4Ka+wxb1cXM9raPGzznwQS8APYixuoTzEbJfsLxaQU1rJti/tddZdBp37/+FBJ6Y5Sk3rmT9vJfBPQINEUr0KmU9gAkHjf/7sJty6WPFCXttbDkAcv2SOmY8wqzhv1fygXUyvqyd6QCr1BoM7eJPYIm28TnPvzyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHA1BF9L; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cedfc32250so4925114a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709647559; x=1710252359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8l5SZlHRKRj2m05Qh9umaXWe72RlmywcWHoY7Z9nDY=;
        b=EHA1BF9LaRM3tmElhWOs4Qu8pr4MWeaBjA7OOAZptgNgTPUhaIET4HWzCTDzemnlTw
         VK0ZEBYGjdR0HmeV1Agd+73l+ONZ94z1R8c1+a+g3sS23aMNhj5yCEvP30i0nv9FcsVq
         q5FPeA/wU92w4aQXykbR2+hAhCpAqDn3vnAewQTxBplTcLDeiaf0F6CTNlVp33XB1j3C
         83V260y1L+gAue8yYwogu7NBrhzx4Kzct8vnFO2oid+PSVYPMjU+HbW/kQ+YnkEEOBAV
         LUloZrGYHarwDHiRAwimkUC9Ey6KVBI8TSpl2qAa5DFSMv0bX+V5wop+DmVv7hMh2xHT
         Bn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709647559; x=1710252359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8l5SZlHRKRj2m05Qh9umaXWe72RlmywcWHoY7Z9nDY=;
        b=J7+Axd+X1/MqkoDhtDkTvcxwsW7yq6zC5WoJwGG5LuhtbCMEZzrvrpiqEKB2Bo99Gt
         5993owBYGIFLTaS6YHvDbKiJlI9iUob37s+5/ONZDajan7ila5TPXIqGMrOzJx9xyENW
         otQjgwRt/6y2+D+Ze42T8LNMU14ihLUmSJIaBipYiGYoJ1tFSe1Kdf6UPMhkxyojHiWu
         7YHWUSrPXQtE8AFJ6Wo1fQnj2iyTRvVx5PiU4HVAdW21w7ZKAGHix8quqQJKSc/4vcAj
         XAcGj09bkURPtWHvFzSanraAmux3tba3rSiQmfGt+9m010baaNMZo3qWPwZi+nKIt3Uk
         +o/A==
X-Forwarded-Encrypted: i=1; AJvYcCVvrzkAlzvZhml4+dV8rINKgvR3BBGsYu2aCZ5X3LTwt656R3KKAvYJklsYm1gQMKIG8NNpko3It1JsAlhm9/QZz5BDRQpycqkVKvUc
X-Gm-Message-State: AOJu0Yw+M5kRF7is3rZzHRMXKuYDNgo4WDXmhQe9icG2gGZaWF6a+Nzi
	ICCPGXNLepyOEV28L9c+azFY0kCZo80OIWatDEe73euDyaIm3+61wNAzDh0gMVxnn6S3OJyk8wy
	wO/MrUBpZ0hoJeXxFapTPUZePIc8n6SXZ7mRNbQ==
X-Google-Smtp-Source: AGHT+IFYSxhznVC8f5PWJnDse2rfS2MMz8y6Zp37w1PKXOvhv46BM7n54iaKZHofV7fmyaKNO0rzhB/yRgcGf1XV4d8=
X-Received: by 2002:a17:90a:d24f:b0:29a:e097:50be with SMTP id
 o15-20020a17090ad24f00b0029ae09750bemr9580386pjw.31.1709647558676; Tue, 05
 Mar 2024 06:05:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301151725.874604-1-sshegde@linux.ibm.com> <20240301151725.874604-3-sshegde@linux.ibm.com>
In-Reply-To: <20240301151725.874604-3-sshegde@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 5 Mar 2024 15:05:47 +0100
Message-ID: <CAKfTPtCzHf_R4SwR29FsnxXTv2J4Xrmh3gfoHcVPu3KU5OLDcQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sched/fair: Use helper function to access rd->overutilized
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, yu.c.chen@intel.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, nysal@linux.ibm.com, 
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com, 
	pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Mar 2024 at 16:18, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Overutilized field is accessed directly in multiple places.
> So it could use a helper function. That way one might be more
> informed that it needs to be used only in case of EAS.
>
> No change in functionality intended.
>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a71f8a1506e4..650909a648d0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6670,6 +6670,15 @@ static inline bool cpu_overutilized(int cpu)
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

It seems that is_rd_overutilized() is always used with
sched_energy_enabled() in the pattern:

If (sched_energy_enabled() && !is_rd_overutilized(rd))
       do something

This pattern includes feec() case where we have in select_task_rq_fair():

If (sched_energy_enabled())
       feec():
       |->  if (is_rd_overutilized())
       |->       goto unlock

which could be changed into
If (sched_energy_enabled() && !is_rd_overutilized(rd))
       feec()

Then you can create the function is_rd_not_overutilized() instead of
is_rd_overutilized()

-static inline int is_rd_overutilized(struct root_domain *rd)
+static inline int is_rd_not_overutilized(struct root_domain *rd)
 {
-       return READ_ONCE(rd->overutilized);
+       return sched_energy_enabled() && READ_ONCE(rd->overutilized);
 }

and use is_rd_not_overutilized() instead

> +
>  static inline void set_rd_overutilized_status(struct root_domain *rd,
>                                               unsigned int status)
>  {
> @@ -6686,13 +6695,14 @@ static inline void check_update_overutilized_status(struct rq *rq)
>         if (!sched_energy_enabled())
>                 return;
>
> -       if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
> +       if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>                 set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>  }
>  #else
>  static inline void check_update_overutilized_status(struct rq *rq) { }
>  static inline void set_rd_overutilized_status(struct root_domain *rd,
>                                               unsigned int status) { }
> +static inline int is_rd_overutilized(struct root_domain *rd) { }

It should be
static inline int is_rd_overutilized(struct root_domain *rd) { return 0; }

>  #endif
>
>  /* Runqueue only has SCHED_IDLE tasks enqueued */
> @@ -7974,7 +7984,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>         rcu_read_lock();
>         pd = rcu_dereference(rd->pd);
> -       if (!pd || READ_ONCE(rd->overutilized))
> +       if (!pd || is_rd_overutilized(rd))
>                 goto unlock;
>
>         /*
> @@ -10859,7 +10869,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
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

