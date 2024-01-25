Return-Path: <linux-kernel+bounces-38274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E56F83BD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A481F2E58B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60B1C6BE;
	Thu, 25 Jan 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvWEJZnW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JfKkIHrW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7F1C6BB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175133; cv=none; b=YJEgamzzlPSg+jMJtmzNFH0DZIP+tDkj1P5sLO26fzFqKULN82aDr41M/v5pKMCFg7AGNqnD1Cp0U96JqynSXJQtuBV4H2k19Ym4ArmSite1almgrHS16VkBZtY1sNmT7NiPhk1Vy1cOMMmY3qH2n5loZK+SnFX1EgYbvaVx+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175133; c=relaxed/simple;
	bh=NxgGGEvaIfQTjNPxcN9BZqIvfJ371lOwZ+R4OCybqDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ieHjdP8XpFNcFVr6jE0t3mq9V45QKXAT5RIuf6HCKI6Yn8KruF36WLiZW5ZeKVWBaLWZNNYm51VUadLZCBERMC1zuCdeb99HtGTrvD8gPtKn3DnVLtZA4K+jmQ6Xks3UV7MEdIKzNNZMWolml9Zd/RohaX7x5ENtgQZqOuCDLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvWEJZnW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JfKkIHrW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHaNmuuMFoccSi7UKzoNUMbU4aXCm8j8ix/KK8/y4kA=;
	b=YvWEJZnWIb+9pDwzHiI3zFE+9XxrQ8B8YnLkRYHk1Tmaumop036e8PAMfxGD9w2z4gCgWE
	B0GGRyVxaMlXrJwuVkA3YbjTuudl9WlrtER92xZyR5eR36kUUUMKRXZ4/k8T+uGPY0ZrpG
	m1/ZojmHWCPZk7yZugg2kSpZ2xxVHS8nVYUKF0fodDXeDriuC5iPXxebr2i9QuVsVOQHLD
	s2Y6T5H4vX/o93iXipt/nxfYYE4SPy2dRsYOWAyw8QqYPEm9SBoqFbMbPvLoWsrwSmIxRU
	+e0EOqc/UM+cu5XLGD4uoD2czED6WTvcbkBIHWPJgzyeRxGGf9NE9cVAfAgX+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHaNmuuMFoccSi7UKzoNUMbU4aXCm8j8ix/KK8/y4kA=;
	b=JfKkIHrW4ixYzZUF9boPqwnuWHZQvCuTTzhAk1d/UxJbjt52DhICjAJbFNRnPKDnDApX3o
	4v3zH95t2dT26iBg==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peng Liu <liupeng17@lenovo.com>, Ingo Molnar <mingo@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 02/15] tick/nohz: Remove duplicate between lowres and
 highres handlers
In-Reply-To: <20240124170459.24850-3-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-3-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:32:09 +0100
Message-ID: <87ede5kbc6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> +/*
> + * We rearm the timer until we get disabled by the idle code.
> + * Called with interrupts disabled.
> + */
> +static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)

Isn't that a misnomer now?

> +{
> +	struct tick_sched *ts =
> +		container_of(timer, struct tick_sched, sched_timer);

Let it stick out please.

> +	struct pt_regs *regs = get_irq_regs();
> +	ktime_t now = ktime_get();
> +	if (likely(tick_nohz_highres_handler(&ts->sched_timer) == HRTIMER_RESTART))
>  		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);

Thanks,

        tglx

