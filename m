Return-Path: <linux-kernel+bounces-87174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0E086D0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C511F252DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB870ACE;
	Thu, 29 Feb 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="201SB3Su";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fimFcHP6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4F6CBEB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227872; cv=none; b=Ovc4yAGrHczoPiHPFA8yU0tLGOZI1Te1IXDVo2EfTG7I9y3uztRw0CuU+c2ZTaGL5tzw/fgpMWFClLsdrbOrpvlzY51ng7ITD/MWaUb0K+ZoaUaihe1upeYGZZ5hHgRQQCw5AT8DC8F3VMdTOHamJFVKsK+1+Tnl2MQwmDj+BxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227872; c=relaxed/simple;
	bh=B3ln6B3b1FKGpz4kZqkRPSpkIwGqt5XO8/XXUGaLxBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=unfJZGtmfK7ld20U+PwCJCBde0wpFrwY5WykAlSBw++HN3Lbwsn8MZtQGFWKDeeUzouPPbhWx34lkTxxLsfBNsTO/MlM27musvp5QrstXkbYB4WsmsNJFlZgQhojtNrX/DRvM+Ui9QiYUmXl2RhPd6NZ8trlXalWGXczXOnlW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=201SB3Su; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fimFcHP6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709227868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBZ3N6JJXjlh48m+F+Wmr5K33vvLF5DHDzgoUyYVEx8=;
	b=201SB3SuYDgHPVFHR3QV6E84Y8i4rnFiCpAFCliTCUUGU5oAfaT705E16WcqjHtVP9VwKe
	fUG1wy7bqD97ysi/NK2a+sp7ZQFoFpvqII5U/gwLjXm5fJfmszQHdZJwldyMpZiFTITS2O
	VoziEnyDN+hemZzep0Wb39xB8wTAc2jxS/qw5tuOuGckNILqAyM4xkP80pcL1z4GIfIRHX
	8ZaazdNlGypqUWdO2Hyi2OxURRyUkS6c46GBfocPqNR2VAXaGVvyXvH37KY/ZmahBfTBsM
	Rn4s2zV3Gtc0oG1cEsReebWwkq9aeEEob2UFJt+kC8jBi8sQ4kcmYZkNOSa2xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709227868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBZ3N6JJXjlh48m+F+Wmr5K33vvLF5DHDzgoUyYVEx8=;
	b=fimFcHP6oXB1AbAIhee09SXluv9+i7soxfl1mXEXCOSS+xnmAiogYxpbojjgd7L4oSNmgL
	TzCTDtTIhns42OBA==
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] sched/core: split iowait state into two states
In-Reply-To: <20240228192355.290114-3-axboe@kernel.dk>
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-3-axboe@kernel.dk>
Date: Thu, 29 Feb 2024 18:31:08 +0100
Message-ID: <87zfvj6uub.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 28 2024 at 12:16, Jens Axboe wrote:
> iowait is a bogus metric, but it's helpful in the sense that it allows
> short waits to not enter sleep states that have a higher exit latency
> than we would've picked for iowait'ing tasks. However, it's harmless in
> that lots of applications and monitoring assumes that iowait is busy
> time, or otherwise use it as a health metric. Particularly for async
> IO it's entirely nonsensical.
>
> Split the iowait part into two parts - one that tracks whether we need
> boosting for short waits, and one that says we need to account the
> task

We :)

> as such. ->in_iowait_acct nests inside of ->in_iowait, both for
> efficiency reasons, but also so that the relationship between the two
> is clear. A waiter may set ->in_wait alone and not care about the
> accounting.

> +/*
> + * Returns a token which is comprised of the two bits of iowait wait state -
> + * one is whether we're making ourselves as in iowait for cpufreq reasons,
> + * and the other is if the task should be accounted as such.
> + */
>  int io_schedule_prepare(void)
>  {
> -	int old_iowait = current->in_iowait;
> +	int old_wait_flags = 0;
> +
> +	if (current->in_iowait)
> +		old_wait_flags |= TASK_IOWAIT;
> +	if (current->in_iowait_acct)
> +		old_wait_flags |= TASK_IOWAIT_ACCT;
>  
>  	current->in_iowait = 1;
> +	current->in_iowait_acct = 1;
>  	blk_flush_plug(current->plug, true);
> -	return old_iowait;
> +	return old_wait_flags;
>  }
>  
> -void io_schedule_finish(int token)
> +void io_schedule_finish(int old_wait_flags)
>  {
> -	current->in_iowait = token;
> +	if (!(old_wait_flags & TASK_IOWAIT))
> +		current->in_iowait = 0;
> +	if (!(old_wait_flags & TASK_IOWAIT_ACCT))
> +		current->in_iowait_acct = 0;

Why? TASK_IOWAIT_ACCT requires TASK_IOWAIT, right? So if TASK_IOWAIT was
not set then TASK_IOWAIT_ACCT must have been clear too, no?

Thanks,

        tglx

