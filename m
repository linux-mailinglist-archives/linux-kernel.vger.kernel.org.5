Return-Path: <linux-kernel+bounces-129787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1852B896FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3431C2629E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB969147C78;
	Wed,  3 Apr 2024 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdsBP+OH"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3046DD0D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149880; cv=none; b=b3+PrUNaCnlFSJzvCZPepIOh6TqWZI3CBp5LeHzmefphv7uLYwOSyPw8KgVVGAJ0+4wA5dGkA8RTfG5NtmX1hDb11aJJ+gTKfqgHMKHdU6kL23pZ7qaTaFR3TnmWuxng/eVs9NJsFRPih/dBus693hjRVxC54yNNEbZkMRIsilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149880; c=relaxed/simple;
	bh=Sag0DzN8AsqvSINoHp2kUU3HJcJlBlDGPHoyaqvFsZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTec7uUH3Lea61+aK4l0SImmmak7fSnN4At3MGrInjQ35ROFr0FxtvxvgDx3lMFGWATFoqW0vzGgifRB3SYGiLDAaQIuC4TLkApV115VJKN7K3DmJXfx5ae94C0+Hjr2H0WRsRYAuBXFXo+6HHkLcsY5wAYrCsC8AIhlq7YyHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SdsBP+OH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so4079560a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712149878; x=1712754678; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAozVBLzxos7hGGlEjbIZwuJzzO+tOt4DRLyd4wDLQ4=;
        b=SdsBP+OHYA/0vv6y/gxpDEDx08xHbxnsaOqKkwjl7bKrOjZ4INEE/Db5N1asbjJAR4
         VXKKAGKuBx5XLWvQjhqL+IWAl5uJM321G/JY3BnVrkj6VXuef3Y5NeKGKsRWi5Oj79pu
         HGValgVIapcxGDFxPa+l3NOC4CwaaHT94EWKHUkIE+P3KiSlU0chso0mLYILTVpHvpmd
         LM1xwW+HPd3suYguH7PZbsLVgN9UtsSANMKykpKCaKP2tcfsk715OasfElfS8yeU/fR9
         kvyk4HlaD227MMir28XYbCcDH2N3aDOfDOI7Ireo3hhSto5j4bdU/JCKaeIA/ZS7kWjC
         /cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149878; x=1712754678;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAozVBLzxos7hGGlEjbIZwuJzzO+tOt4DRLyd4wDLQ4=;
        b=iqxXYVExkyPqQriVD+sytDq70VIjVmAl+4FlrEQOC7+xlm8YKGNrmq/r3T3860NEHe
         FKMXEZJvhMuM4m8dNg2hzS66JWhEBHY31AuDUSPlrsFWHFKkHOSe2JrEJz5Cy+HLhQ2V
         46VF9iOJXr/Mt85cLi6VRufIDg2VRv0Jxs/RLf9jwzJ9+S9aKwU25FsqNhSU8lWQ7Isl
         lfEl7aA3NS3jTEV4x6kB9iuQsgSDg171xgq+GjUA3r+kz+/4iLYMLm07G5yapr7/wDXC
         5toSEDWT6WG4AX1ISWeT7ClflliHYFnH1ylV2AYAX/Wh77LB0bX44VoIJVFrhh4fxqKs
         Q31A==
X-Forwarded-Encrypted: i=1; AJvYcCURY/m+uwUbOrLSiRHh+H7I4Nvpd07rI4QSiHf1B4Wgx3RNOF1RqtmcfHEZSgPGJ8h47YgBON0kN10Og5YaSiRRO3Jar/O3s+WT2vWW
X-Gm-Message-State: AOJu0Yxnq1G2HnX4eMWWVHNeihgL7w0WYFRurdNDXqcxL0NV8qyN0J3L
	6Zfr3tPyiKyPdEtI4fLMAMhqfa+KtL58lqDU6S2IhbOkCS+GhogAsf9PzkkWloLzwGWDiNs+EwA
	fp8nI+723Oz3eo8DV70l8Gd9tyjYCUOVJXZDhxg==
X-Google-Smtp-Source: AGHT+IEY8YGoXazoXY8YKaBLPSQSg2pNn0q0QYBaQnN9km5o1FJoE5bp8/P3aEUqanQhhHcopXhIIM17FfOtFvWwXnw=
X-Received: by 2002:a17:90a:a602:b0:29f:b8e1:1dfc with SMTP id
 c2-20020a17090aa60200b0029fb8e11dfcmr12183778pjq.25.1712149877840; Wed, 03
 Apr 2024 06:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403005930.1587032-1-qyousef@layalina.io>
In-Reply-To: <20240403005930.1587032-1-qyousef@layalina.io>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 3 Apr 2024 15:11:06 +0200
Message-ID: <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	John Stultz <jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 02:59, Qais Yousef <qyousef@layalina.io> wrote:
>
> For fair tasks inheriting the priority (nice) without reweighting is
> a NOP as the task's share won't change.

AFAICT, there is no nice priority inheritance with rt_mutex; All nice
tasks are sorted with the same "default prio" in the rb waiter tree.
This means that the rt top waiter is not the cfs with highest prio but
the 1st cfs waiting for the mutex.

>
> This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
> with low priority values are susceptible to starvation leading to PI
> like impact on lock contention.
>
> The logic in rt_mutex will reset these low priority fair tasks into nice
> 0, but without the additional reweight operation to actually update the
> weights, it doesn't have the desired impact of boosting them to allow
> them to run sooner/longer to release the lock.
>
> Apply the reweight for fair_policy() tasks to achieve the desired boost
> for those low nice values tasks. Note that boost here means resetting
> their nice to 0; as this is what the current logic does for fair tasks.

But you can at the opposite decrease the cfs prio of a task
and even worse with the comment :
/* XXX used to be waiter->prio, not waiter->task->prio */

we use the prio of the top cfs waiter (ie the one waiting for the
lock) not the default 0 so it can be anything in the range [-20:19]

Then, a task with low prio (i.e. nice > 0) can get a prio boost even
if this task and the waiter are low priority tasks

>
> Handling of idle_policy() requires more code refactoring and is not
> handled yet. idle_policy() are treated specially and only run when the
> CPU is idle and get a hardcoded low weight value. Changing weights won't
> be enough without a promotion first to SCHED_OTHER.
>
> Tested with a test program that creates three threads.
>
>         1. main thread that spanws high prio and low prio task and busy
>            loops
>
>         2. low priority thread that holds a pthread_mutex() with
>            PTHREAD_PRIO_INHERIT protocol. Runs at nice +10. Busy loops
>            after holding the lock.
>
>         3. high priority thread that holds a pthread_mutex() with
>            PTHREADPTHREAD_PRIO_INHERIT, but made to start after the low
>            priority thread. Runs at nice 0. Should remain blocked by the
>            low priority thread.
>
> All tasks are pinned to CPU0.
>
> Without the patch I can see the low priority thread running only for
> ~10% of the time which is what expected without it being boosted.
>
> With the patch the low priority thread runs for ~50% which is what
> expected if it gets boosted to nice 0.
>
> I modified the test program logic afterwards to ensure that after
> releasing the lock the low priority thread goes back to running for 10%
> of the time, and it does.
>
> Reported-by: Yabin Cui <yabinc@google.com>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  kernel/sched/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0621e4ee31de..b90a541810da 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7242,8 +7242,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>         } else {
>                 if (dl_prio(oldprio))
>                         p->dl.pi_se = &p->dl;
> -               if (rt_prio(oldprio))
> +               else if (rt_prio(oldprio))
>                         p->rt.timeout = 0;
> +               else if (!task_has_idle_policy(p))
> +                       reweight_task(p, prio - MAX_RT_PRIO);
>         }
>
>         __setscheduler_prio(p, prio);
> --
> 2.34.1
>

