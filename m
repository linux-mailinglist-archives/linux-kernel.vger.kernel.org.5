Return-Path: <linux-kernel+bounces-38243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BE83BCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F51F2D072
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5241C6A3;
	Thu, 25 Jan 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YVrE1aOw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A/SW9iDi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E21C686
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173944; cv=none; b=ecCJHt7gxIpOImo435xEfqhq3dRlrXDR+vlI7Tw59ZGQjOyQZuIXXCcpAd4r9LJ/GJCwq1T2jdN+j7QY5G1DdD/bYPm8avzH1eErKVeuoD+8m/iZQxhYNAE6374jXtkKDXNYMiUpOXNJ+ODfEvb1cDehsgK8VQzmOK/kDNtPIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173944; c=relaxed/simple;
	bh=GnWManysdxZEUL3Qh+7o4Mw31tqs1951I1zgfm4soq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUtQ2Yvi46ItBDUGtjRlOHNkTkcj3DXRnTporpXP9wjfG+7NNitiL/DYLuzDq6KRug8UhV55j3kx++Iq2nzxSvx/imwJoaQc5lcFYtopPovqtupqJNdQHcmqb7K178S2NdU0whtOQzVZJI58gzCWmCGEv5VJbPybTdi8RAKdml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YVrE1aOw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A/SW9iDi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706173941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkcdchPRKnak4iKo1B0ziTaJ1SSruTm2eblHB6vWYvE=;
	b=YVrE1aOwcXyLpL6WiGgEDXKY3BYxYW6ZRK5mmfBOCbNk3l++fUQQb4iFAtjsSrRcnWDRyv
	C27MwJOSvhPpvO26VPGbuCgChC273885lx1OPkJ7KpNX0MLTNvcALpp6wnjGZkUSChjL3q
	zpVY2kCMqfFgMZEayV7uWXH6CPoIxkIzteREztjUExy9iP6QakatT4M20Z+GYgSiXMcUbh
	JtKCZO/+H56bOdfwvaJ4djB+iL07rS/nZ1GKPg6EYiYdJOFJjUJpzCpwKd0orWfy3B0+t+
	oVVrvk54AoFALKwexqMvS7vOk8YvvJyDf8NhKUPKppuICM9MZ/+VZeNsDxhUGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706173941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wkcdchPRKnak4iKo1B0ziTaJ1SSruTm2eblHB6vWYvE=;
	b=A/SW9iDibw3JQE5kAX2HRyniYksxnS662KP7clC5JOTT9jFaH/gUZYOqWtTZLLoeVx7TFO
	zTaGPlRm16bTCMBg==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peng Liu <liupeng17@lenovo.com>, Ingo Molnar <mingo@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 01/15] tick/nohz: Remove duplicate between
 tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
In-Reply-To: <20240124170459.24850-2-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-2-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:12:20 +0100
Message-ID: <87h6j1kc97.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
>  
>  /**
>   * tick_setup_sched_timer - setup the tick emulation timer
> + * @mode: tick_nohz_mode to setup for
>   */
> -void tick_setup_sched_timer(void)
> +void tick_setup_sched_timer(int mode)
>  {
>  	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> -	ktime_t now = ktime_get();
>  
>  	/* Emulate tick processing via per-CPU hrtimers: */
>  	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
> -	ts->sched_timer.function = tick_nohz_highres_handler;
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +	if (mode == NOHZ_MODE_HIGHRES)
> +		ts->sched_timer.function = tick_nohz_highres_handler;
> +#endif

Adding

#define tick_nohz_highres_handler NULL

for CONFIG_HIGH_RES_TIMERS=n somewhere allows you to write that as:

	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
		ts->sched_timer.function = tick_nohz_highres_handler;
    
> +	hrtimer_forward_now(&ts->sched_timer, TICK_NSEC);
> +	if (mode == NOHZ_MODE_HIGHRES)

Wants a (IS_ENABLED(HIGRES) && mode == ...) no?

Thanks,

        tglx

