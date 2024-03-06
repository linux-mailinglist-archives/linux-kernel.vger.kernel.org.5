Return-Path: <linux-kernel+bounces-94181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2DE873AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881FA2836F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43E7135412;
	Wed,  6 Mar 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WE9xVCsp"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638C1353F5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739808; cv=none; b=V44Z+oC7CxfCvAbtDJemesG66a/OWNGY8qhG+savnBZGW0lobgn8k7pVZXO89liTOBVMRxu/8IKiaOT1F6Bk1CPIxSRjWCso2kokcdx6X4RAPKuHYXPQmijOeNZMu6V+T64loli8BfRXHfUXg+4TuPCMBIRj+JB9agB9VLUbVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739808; c=relaxed/simple;
	bh=q1Sr04tnFsRH814f0QQJ69mKSe8yxuDJGVALpNWqjt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOPvi6acCgAW9KWjxPhBHmZMIot/gVG9g8HWvoCMmzlgSeuDjxLPzbLBE39Biv2Yu2O4exZMnEactQPAFDC1OLRA+4e+e43rHJBWMUh2WSVAhcJjzJ2uHvdshnJnUA11pCjjlToMVi6jhIPplAZoGk7gz1QfJkL18inke3DhJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WE9xVCsp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-299b92948a6so4288042a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709739805; x=1710344605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5CNjO6fRwWWLhHVESxFT0gyoTqLvzXziHO/f8PUqrEg=;
        b=WE9xVCspxXPCFM9WgZgtrJw3BK1vyVz4ADFCoer7D05ffiR3N+zUR9WnzkPkkPs3Mv
         EspGo86hlmF9M1QJRSh70/gsaww8ASZ/hcmyEeEuSJ67KC1BcEErQa3hNX9vBy9ilZJd
         jDyj9i9FK8JIpMx3WFVXpY7GQKijr4UmuC/YDH6D4liOmytuQcknhFLyrquNTtUXj5G/
         KW8XNXiwdRBDK1ZJiPieYf5GSlwWODIEVokaneebzbZZ2S9dk2L6enTPjfhcaHRPyePW
         sgg4Jg0f1LN78XA3EsSrlyUewQXf1to7F0Hj95DozUeSVvr0Nf93ts1Eq38Cv2fw5pth
         kuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739805; x=1710344605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CNjO6fRwWWLhHVESxFT0gyoTqLvzXziHO/f8PUqrEg=;
        b=P3MbIYL9EAwHWA801AprkVmBgFL7p7vvZjeGP/qo9vqMFyaVlc5ogdJtibXrBMXkXB
         sNOWSIuzo0CAG/pvZCXOn2QLFnrp6G5rx2apGp53jo1kBr2zEkwjNeYPbpgLkSIap+VO
         wfZ7+fhFeojKtAMVXbr/RNYS9o3UL/6z4UGhVD4B8dU1FczPEEIt51yod+yCmunOX5dS
         XfcJ0t0lhexxgiByvJhnPwLNIUxUCTRBE4kbFQWfseG6+cKpYCMnej+QUtNQy4girnIL
         MxFVnis5tDms9dKReaE81cfnqTFXDTaeC9iAN6OfgLS51f+Wm09y3Zr7oJncpbGi+ahk
         QnNQ==
X-Gm-Message-State: AOJu0Yx4PsIjutABZmI0ISx3j4Q89r6hji/nOVoyjQ4Qzrj+rg0v2uVI
	6R5vI3B6Z3izrV6U73/VomWWIMjgROYfv6iwNGhe2Iu8JUUR2pCmt4HZUSuHmCEixeJXroj56YM
	ARoBgqHAO6MirT1SgfU1YS++o7iuapN4vXSnyog==
X-Google-Smtp-Source: AGHT+IGpWgaC4w8ryN2K4BkF789VFv6Jxj6YodiapCQOv321R3Ir+p3wjY5ZHWjCRztOoA835KFjrF4KCxYBCsM0UO0=
X-Received: by 2002:a17:90a:f2c9:b0:29a:d44d:4231 with SMTP id
 gt9-20020a17090af2c900b0029ad44d4231mr11729420pjb.4.1709739805197; Wed, 06
 Mar 2024 07:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094831.3639338-1-mingo@kernel.org> <20240304094831.3639338-6-mingo@kernel.org>
In-Reply-To: <20240304094831.3639338-6-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Mar 2024 16:43:13 +0100
Message-ID: <CAKfTPtCNmnsLL+OwyYjn+DysbXUyjqAdsWXr1Q6pGBybdkhYGw@mail.gmail.com>
Subject: Re: [PATCH 5/9] sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 10:48, Ingo Molnar <mingo@kernel.org> wrote:
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
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 934ace69eb30..4c46bffb6a7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12410,14 +12410,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>  /*
>   * run_rebalance_domains is triggered when needed from the scheduler tick.
> - * Also triggered for nohz idle balancing (with nohz_balancing_kick set).

I think it should be nohz_balancer_kick() instead of nohz_balancing_kick


> + * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).

In fact, this can be triggered even without NOHZ_BALANCE_KICK. Any of
the below can trigger this
  - NOHZ_BALANCE_KICK
  - NOHZ_STATS_KICK
  - NOHZ_NEXT_KICK

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

