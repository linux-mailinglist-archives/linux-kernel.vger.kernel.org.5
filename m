Return-Path: <linux-kernel+bounces-62335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C366C851EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4158C1F2171D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E92482D4;
	Mon, 12 Feb 2024 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPVamoda"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A846435
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769752; cv=none; b=nc5Q+k6/dTY85P+nNd8Rzl/qcUA24ex6i5w+HhjijMX6UIoK+yt8aCiybtAZ3lmcpShUFFLzikO9HIJKq71UkiKLEKu5yIQt+TsUXLY3S2utZcku3Fw+qY9iZ1fDoa87O8JjeXAYiYjQ9j9hyGF+8arPzWvMxY34MAIcIPCMsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769752; c=relaxed/simple;
	bh=4DG/2AulWdm1bfaag4echIs9kSH2jj0kQ6qcGW9ZFNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxYrQegrqgUGgf/RWNe8NReFq7hODOkCnONShMXVZg8xP5jDzddkgOtFMjsbMNTev2I/rBDKheIZIEdpfJyqRuAYQYv4pubY6EEWWtx8VuCvPxheqWAu7xr61/s4YYCgsdmKd5N1TS46c0wbaryi947n79eL7jWegNQae0HVMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPVamoda; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so2815a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707769749; x=1708374549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGH4gStnAh2cVluN25q7Y7nHy88Q9ENXq3FqeNVOM/s=;
        b=FPVamodaZe9hN1dQI9wgE0+u2VWM4vC4Wopi+kKYErkIx/NvB0F+QYpwik5FcC+U6t
         itwG93iP7mXIw5M3gvtcH5y9UK/Y7i9TuN5O20bOAlomWW38GMjeBP2l6Fq69D0Zk3+Z
         IiINFOOYYP2/9D1hTrrsmgGRjHGs6QW17dFURb/iqCZAdSakBZQ/XhkGF2fwXAsMqNK9
         I1vBVkquMRUkJiyf/9DkqptglzPRmp2TXcTt9P7kUS80oq7+85JONT2GpWjPblRw2U7R
         8Kp4ndITC/euRF2dUI6OJTM3QFtG8S9MXIE9E4oSqNjIYix4omFIGHzzTY9m4tmmsD+D
         6RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769749; x=1708374549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGH4gStnAh2cVluN25q7Y7nHy88Q9ENXq3FqeNVOM/s=;
        b=EO2kipIBNmmxbpUPcNk48TJIaHFA76CtQ9gq4mEwWMWFeZcSaO/aKIwVQjpONBaJBO
         ZSrhZB6IoF9UMtBJHdHj3uICrDOdT90c0De+Ft35QFokjMM88NVVEv78rx8NWSd5G+pn
         IvZXmbzfHkooNdSvlEuEyZZOM4QAfYOF78N+MrAK9UM1VOhukjm7tHdGKSAB3bqb1uaU
         +rPEe10w1vphxC6bqcMYIhSmCm34Yju7SjcEZWmOXfIP7i/zENbSOzu14w/EtgJWzYTG
         3IpaXqrTeTH3S5TBUSH+1vrBcRzQJWxZJd2wJm6TuwoK1iT4xqaJrZGfUSb41XVccFic
         ihjA==
X-Forwarded-Encrypted: i=1; AJvYcCWi6m/zljE7iHkKUSelJrtqgwkoOglhAx/Ibi2y/0p1xq509sf7k/uSqv/CeBkTcUAfjSLVGYCYmke9r0cpX98EToc1VscgK3tmy2Vr
X-Gm-Message-State: AOJu0YxxowGtWVKPtLZ0VyjTRLefZrT8h0fXHVnLlRTb4b8yWgjdLjDN
	IIPY7w+3r1a/HK1QPfGuijTkQIJ+2cYRFcQljcefqnaSUhIl1BQ8QO5/T15tBU8Lh8YpSPjVKvi
	R2hcZG8PSyFQD94siybXrnhv9YllFwhD5eXpg
X-Google-Smtp-Source: AGHT+IGuYchSscpq9fWAFb5Vzs8WMDTwNcFt6X4bssqA5EbwrkI48Fp8X67xME2pYpEP1CvrnyG7xZmyeKfe2FxC1Ig=
X-Received: by 2002:a50:8a9e:0:b0:560:f37e:2d5d with SMTP id
 j30-20020a508a9e000000b00560f37e2d5dmr295831edj.5.1707769748536; Mon, 12 Feb
 2024 12:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220825122726.20819-1-vincent.guittot@linaro.org> <20220825122726.20819-2-vincent.guittot@linaro.org>
In-Reply-To: <20220825122726.20819-2-vincent.guittot@linaro.org>
From: Josh Don <joshdon@google.com>
Date: Mon, 12 Feb 2024 12:28:55 -0800
Message-ID: <CABk29NsQf_xStzWg8bB_hpNpPC_LduMs-M058LjdhnDG16wN_A@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: make sure to try to detach at least one
 movable task
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On Thu, Aug 25, 2022 at 5:27=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> During load balance, we try at most env->loop_max time to move a task.
> But it can happen that the loop_max LRU tasks (ie tail of
> the cfs_tasks list) can't be moved to dst_cpu because of affinity.
> In this case, loop in the list until we found at least one.

We had a user recently trigger a hard lockup which we believe is due
to this patch. The user in question had O(10k) threads affinitized to
a cpu; seems like the process had an out of control thread spawning
issue, and was in the middle of getting killed. However, that was
being slowed down due to the fact that load balance was iterating all
these threads and bouncing the rq lock (and making no progress due to
ALL_PINNED). Before this patch, load balance would quit after hitting
loop_max.

Even ignoring that specific instance, it seems pretty easy for this
patch to cause a softlockup due to a buggy or malicious process.

For the tradeoff you were trying to make in this patch (spend more
time searching in the hopes that there's something migratable further
in the list), perhaps it would be better to adjust
sysctl.sched_nr_migrate instead of baking this into the kernel?

Best,
Josh

>
> The maximum of detached tasks remained the same as before.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index da388657d5ac..02b7b808e186 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
>                 p =3D list_last_entry(tasks, struct task_struct, se.group=
_node);
>
>                 env->loop++;
> -               /* We've more or less seen every task there is, call it q=
uits */
> -               if (env->loop > env->loop_max)
> +               /*
> +                * We've more or less seen every task there is, call it q=
uits
> +                * unless we haven't found any movable task yet.
> +                */
> +               if (env->loop > env->loop_max &&
> +                   !(env->flags & LBF_ALL_PINNED))
>                         break;
>
>                 /* take a breather every nr_migrate tasks */
> @@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq *=
this_rq,
>
>                 if (env.flags & LBF_NEED_BREAK) {
>                         env.flags &=3D ~LBF_NEED_BREAK;
> -                       goto more_balance;
> +                       /* Stop if we tried all running tasks */
> +                       if (env.loop < busiest->nr_running)
> +                               goto more_balance;
>                 }
>
>                 /*
> --
> 2.17.1
>

