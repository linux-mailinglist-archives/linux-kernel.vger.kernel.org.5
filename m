Return-Path: <linux-kernel+bounces-96970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294308763EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07FFB21A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFE856479;
	Fri,  8 Mar 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHfelmDe"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED485579D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899406; cv=none; b=UuJ4sczx8vielYSuo8JcfuSHv7L56UyVreh0KZDiOdfY9dMoPPLuySRBZ3VulsBY7CZKgzEGuAGR8F2zEPykGaWiL1SejxysZATAWb2YDs+Q0d0leQhTmjZtwfYhivBz1jnMEj80IIrA0nsL4qQrfAXTGyBYagO9hkh+q8+nm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899406; c=relaxed/simple;
	bh=ETgP2lj760pIFPdZqiPAus+1NeMvzLtFCePmbZ3NWYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFms7pJ4kr+V4qe70IIcyi3iaDQpshQiplMYXUglGtlJBebxpW06pwAG295+kaP4v71PJ4k8dE9noAu173v+NVvLOz94+eLQJDdkgNzyKkceQTWddiw6zqd3hdSGIB8qZplxkZXfgatsYhQ6v8cCDkdERYvJ0s9fgn68+qNpxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHfelmDe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29b780569d1so556353a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709899404; x=1710504204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RmI6aRkHLUk924FwSbrPosO853X8+438VxPHVQo7rOg=;
        b=cHfelmDeuotJbdFwyQWQsxQ25fwf6hmDrHLGxc/18vN4K9ygBk/ErYrdQOOQjsszbC
         vsigK0XNRNtC3vVPHowX0x6WlL6NiWvMjeyHmBeb4PE3VLz7nM+jfHU6vJ3UE/t8CiqE
         mouQO9LiDKnXBZI3YpPVzXUI7Vql57h7tQ83gjlNBlZHrO6fTg8nBjAwdCWqf/vP1UZA
         1t39QVuVCX7CJQaYODOUtcNE/WFEHSraG5Xu4VS9bo/iO0RbXuVcdPZMxA2B9gcK0Kl9
         LH+ndpIDC9OHCPPcDGj67B44qjaF1rdle57Eka3xcX/KeX7FTzclFNOGKshd3A03qNa/
         yRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709899404; x=1710504204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmI6aRkHLUk924FwSbrPosO853X8+438VxPHVQo7rOg=;
        b=p7/9o2g4DKHC8mTuvD1MLpQB5i3vfKoqZYo6cF3LaobO6llHBfJGst0qZ74qJXeNC4
         8Vr3/3DjWCbIT/y3FqL4uPREd8YL60p7LFJaoRPeONwf/GGyBKET5JaTsdVxbqGAItXI
         TWvv1mtBrsNcx5YIr2VywcSyf+BXrMmbPmkpGL6vNuiGmwhQ+VqjRkPlon9J77VHfeGB
         3+Vi6ddbOVjUHvdaKb0mCES+t0Bu8kKJePec1VUzU1rqBbXQJtZtfrtH4OJVp/HMIBCE
         8lh1R+DNuuEcsYslyphtrvicfXIUpAIlNyZry22kmfAjhMCtcJ9dHSR8kox4PczOBPoY
         Ydlg==
X-Gm-Message-State: AOJu0YwQslHGamhc75/YPFgcYuTRMJ8LCmVg5huZ10uyNv7/D/rpnM2w
	5SdWQpCOqxWH6Dy1Wz6HQT6iC8tMbCuWDS19w+vbuCUChsEu2H7GguRJOu9TI/zbG+2QFFF/z9N
	rDzIE4pp4GCPYj9/6SRe1mJDtl8TcAbBZZNklNA==
X-Google-Smtp-Source: AGHT+IHX+0P2Su8rKDk+l+4x6Wxs839b5aud7/EMgejxk7fCyaCiBcqpcbehuLGyapXgDv5ynVuB3sfBX7lFQAbuI6g=
X-Received: by 2002:a17:90a:1082:b0:29b:b5b1:aaf3 with SMTP id
 c2-20020a17090a108200b0029bb5b1aaf3mr834125pja.9.1709899403813; Fri, 08 Mar
 2024 04:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308105901.1096078-1-mingo@kernel.org> <20240308105901.1096078-8-mingo@kernel.org>
In-Reply-To: <20240308105901.1096078-8-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Mar 2024 13:03:12 +0100
Message-ID: <CAKfTPtCoxBNWfdNJeqkO6qA9YumgYSjzQEDqHty2zw1grM1Gdg@mail.gmail.com>
Subject: Re: [PATCH 07/10] sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 11:59, Ingo Molnar <mingo@kernel.org> wrote:
>
> Fix two typos:
>
>  - There's no such thing as 'nohz_balancing_kick', the
>    flag is named 'BALANCE' and is capitalized:  NOHZ_BALANCE_KICK.
>
>  - Likewise there's no such thing as a 'pending nohz_balance_kick'
>    either, the NOHZ_BALANCE_KICK flag is all upper-case.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 84d4791cf628..f3c03c6db3c8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12409,15 +12409,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  }
>
>  /*
> - * run_rebalance_domains is triggered when needed from the scheduler tick.
> - * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
> + * This softirq may be triggered from the scheduler tick, or by
> + * any of the flags in NOHZ_KICK_MASK: NOHZ_BALANCE_KICK,
> + * NOHZ_STATS_KICK or NOHZ_NEXT_KICK.
>   */
>  static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
>  {
>         struct rq *this_rq = this_rq();
>         enum cpu_idle_type idle = this_rq->idle_balance;
>         /*
> -        * If this CPU has a pending nohz_balance_kick, then do the
> +        * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
>          * balancing on behalf of the other idle CPUs whose ticks are
>          * stopped. Do nohz_idle_balance *before* rebalance_domains to
>          * give the idle CPUs a chance to load balance. Else we may
> --
> 2.40.1
>

