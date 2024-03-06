Return-Path: <linux-kernel+bounces-94245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED6A873BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071651F2587E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96960912;
	Wed,  6 Mar 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntBLHK8U"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F102D7B8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741862; cv=none; b=UdOuEG/GsnsY7cxvdjAX8B4pvVnWrTQ58GJhne+5b8H3oN0BYG+WtIxDOSOcKzN12pBjhnWpw7GIJzEuMTLc/26RP0MoRxxhqVOOT+++sFI+lIskfX6/P5+LFnr40Ng0HhXi0J8hUE8g0iB8OpPxQgege3YhkcQvivmJhL1cTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741862; c=relaxed/simple;
	bh=eftI6tZPbcLL8W7wUvhKywRyoMMqM/pPVo8R7ShNHw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txxuv6Uu0lDXyx4fzDRodVGThRwRfWAws8qKbrQBqMtmhglYc9//rozaiMjkI1jHfs2+MuhXegQzK2QID+t1AfqpAV5ZlZoEh3JK6EtZN4AOn+vb/dvzamOpxkdviiKhKHi70NiPWLstj5ccAbDEzEXGQxRncrKgTCS96QnSWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ntBLHK8U; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29b70bf6c58so1028775a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709741860; x=1710346660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9y87/VDV1L40Mfn/3qXeczkAF2KrwS6IiUpwEhk9Wk=;
        b=ntBLHK8UMyACHA92iyVTaSoPoblQhOStUNvU0/2iKw6NjOQIu8+mbIqXTAYTSOYH48
         NlvA18FkZAKQmr8by5FxiUO0MjE1NdSd75WlGCvdpbOjZNca8jjBNjPMp5D4imF1P/hC
         qa7n1zcGb9479l5NP+2TqmLvGhRxO+TuRoDopmVoBi79hMUlK/Ik07Z/5nzH/4GTQ+FU
         Q1WiMwDYz81/ZcDjBtHaNk78Vw2QbDBpyHCAoqobMS3dpxGm2aFtJ2Lw4ZTq8vnnfXCn
         Q8+vWN9qg6Tfftg9n/vCYcujb24jGMYGqu3Iy3yg6aSbWHW0wD4hvCNPSVZalYdCthNt
         gwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709741860; x=1710346660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9y87/VDV1L40Mfn/3qXeczkAF2KrwS6IiUpwEhk9Wk=;
        b=f1Wb+04w5qlf7e/YvXX9/G2TmLd7qOWUmsKeae1WbRHvrPeDM7xQM/mwySAdVRZsaA
         zYL6DZ8+yeNXnf27eSLkWnpINjB33YOzMkRqRUkgmcJlRhhKts3xFgJWwNwidrDCB4vI
         phIjRZgTz5gzx93wx3c7eSoslj20lDhZio3RB+Qbn5nHLhnEf48fCTnqdjflxXzwgGUO
         frpIetBkvi5iJCPnb7Lo7+Fx8gmTUKXyeo/CutYgI9eU1nO/8o48vtjOoR2Q/6NA4rvl
         iePjfZoX+lsUOxOS5FdGmrZlebRECefU9VFEDzpDlpKXKADsmfRECXhM/GMfXlxIaCCc
         GXHw==
X-Forwarded-Encrypted: i=1; AJvYcCXQgKTT0FgCBgduqxIqQfVBpM4gRFpMc1HbrM20fsh6VqffkhMhfiyDmpBskZ6sKE5XMumKXnzeuCrDVxAqksS3T3BfaPlpvHa5wU1P
X-Gm-Message-State: AOJu0YyQnFnNkxMAyUEY4/YSmf/PYASHwO9SuPtrtp0zkWLwo3qdkSgF
	0LEe5tFdgU52N2aFeb9Pi0pMuALTyZUBykQZ8EA81nIgB65Fa+eGCKPHrh3hRxkeXZhY3FrG6e+
	T0K79iz0ckOOnaAnomjP4pqZYYzSLLPRVp8v2TcCZ3CjDR2C5n6I=
X-Google-Smtp-Source: AGHT+IH+N60alFbnLJOdZedHMMqzJ8Kj1Ek8lqC7Egvk50aAq20Ss2dfrr4k4MJ/xxyo26gKjsxfxcLEO5IKxhTFnFI=
X-Received: by 2002:a17:90a:5515:b0:29b:2237:2b8d with SMTP id
 b21-20020a17090a551500b0029b22372b8dmr12757717pji.4.1709741859961; Wed, 06
 Mar 2024 08:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094831.3639338-1-mingo@kernel.org> <20240304094831.3639338-7-mingo@kernel.org>
 <xhsmhbk7tdkac.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhbk7tdkac.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Mar 2024 17:17:28 +0100
Message-ID: <CAKfTPtCNnTVFdf85sRdJxPhdNZxc8qKcnHL3sznjg-KBVn8Bew@mail.gmail.com>
Subject: Re: [PATCH 6/9] sched/balancing: Update run_rebalance_domains() comments
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 11:50, Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 04/03/24 10:48, Ingo Molnar wrote:
> > The first sentence of the comment explaining run_rebalance_domains()
> > is historic and not true anymore:
> >
> >     * run_rebalance_domains is triggered when needed from the scheduler tick.
> >
> > ... contradicted/modified by the second sentence:
> >
> >     * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
> >
> > Avoid that kind of confusion straight away and explain from what
> > places sched_balance_softirq() is triggered.
> >
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > ---
> >  kernel/sched/fair.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4c46bffb6a7a..18b7d2999cff 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12409,8 +12409,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >  }
> >
> >  /*
> > - * run_rebalance_domains is triggered when needed from the scheduler tick.
> > - * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
> > + * The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
> > + * from two places:
> > + *
> > + *  - the scheduler_tick(),
> > + *
> > + *  - from the SMP cross-call function nohz_csd_func(),
> > + *    used by NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
>
> Bit of a nit but the CSD is also triggered via the scheduler_tick():
>
>   scheduler_tick()
>   `\
>     trigger_load_balance()
>     `\
>       raise_softirq(SCHED_SOFTIRQ)
>
>   scheduler_tick()
>   `\
>     trigger_load_balance()
>     `\
>       nohz_balance_kick()
>       `\
>         kick_ilb()
>         `\
>           smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
>
> I got to the below which is still somewhat confusing, thoughts?
>




> """
> The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
> from two places:
>
> - directly from trigger_load_balance() in scheduler_tick(), for periodic
>   load balance
>
> - indirectly from kick_ilb() (invoked down the scheduler_tick() too), which
>   issues an SMP cross-call to nohz_csd_func() which will itself raise the
>   softirq, for NOHZ idle balancing.

I'm not sure that we should provide too many details of the path as
this might change in the future. What about the below ?

 - directly from the local scheduler_tick() for periodic load balance

- indirectly from a remote scheduler_tick() for NOHZ idle balancing
through the SMP cross-call nohz_csd_func()

> """
>
> >   */
> >  static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
> >  {
> > --
> > 2.40.1
>

