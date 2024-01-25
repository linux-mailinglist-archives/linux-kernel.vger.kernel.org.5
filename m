Return-Path: <linux-kernel+bounces-38554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC4483C179
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F180B2549E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF9033CDB;
	Thu, 25 Jan 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoApaRSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061B35884
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183922; cv=none; b=HZW2o4qkHFgBAuZ4laJCMThPGNpnwj2y56HGIfGkLtOT+bWIyFQ2xfYwwavHcPNi+Jv1Vs3v9l1Cs/ftDk4b9IYkaA7o4aeS8nl4L64e1evN+pK5gDmH6hjAdRpMSf+8WNoLg/KhbUlwBeN8vXYVxl96NLJfuWmpUneTbGvYGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183922; c=relaxed/simple;
	bh=as5HZhNyN7qD8p/ZHD9C3ND2Yp5b3eeuVL6G6Yfokoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk7sikFl4x0OMqmDUPjjtfpKlF69DhcyebZRWnmXy8r6fMLIlT5WeJtnQfUrk0cx/bnIQpjH250UtIwOZ/qNHj5smleHmE0/Q6vfLuwleMfveMGYMaB5ySatUcU0Xk6fBbvUxka1R+Va2/JiM8qms3cK/NmGhw0VGJIde5kpoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoApaRSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B1AC43390;
	Thu, 25 Jan 2024 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706183921;
	bh=as5HZhNyN7qD8p/ZHD9C3ND2Yp5b3eeuVL6G6Yfokoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VoApaRSF/5Nrohhuh2Md0uscjCbXksrYM78KzRq8Dj9YL5fJvxbrjfWMA8EZuwlUf
	 qmRpm0XG2gtgBp/UkU8hzrYB8qcoY4oRpgbmKxV/RmA5QUHgvYYtAE+xYkmxtJmm9j
	 D7lsEvivxJjYG207zvvJfZ5Ye+VhG6W/k5m4uJadsUPGpt30/WbA5LK0VGH7OwN2Rp
	 r9qlkXruwRnU3GWeiiV3tuYNlcF4EY2Ol3zmlQmT8JX8yZSdauRScUFFqPOq6liQdl
	 SaaTAhyOOMShcuKXSrcAiSB2lslOwN+FCKK0ch4+tNPAx1qb70gJ53S8xxkElq2fV0
	 mlPUBcKpixl3A==
Date: Thu, 25 Jan 2024 12:58:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peng Liu <liupeng17@lenovo.com>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 02/15] tick/nohz: Remove duplicate between lowres and
 highres handlers
Message-ID: <ZbJM7uP2tWJrqbk/@lothringen>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-3-frederic@kernel.org>
 <87ede5kbc6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ede5kbc6.ffs@tglx>

On Thu, Jan 25, 2024 at 10:32:09AM +0100, Thomas Gleixner wrote:
> On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> > +/*
> > + * We rearm the timer until we get disabled by the idle code.
> > + * Called with interrupts disabled.
> > + */
> > +static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
> 
> Isn't that a misnomer now?

Would tick_nohz_hrtimer_handler() make more sense then? Because it's clearly
an hrtimer handler, just emulated in low-res mode.

> 
> > +{
> > +	struct tick_sched *ts =
> > +		container_of(timer, struct tick_sched, sched_timer);
> 
> Let it stick out please.

Ok.

Thanks.
> 
> > +	struct pt_regs *regs = get_irq_regs();
> > +	ktime_t now = ktime_get();
> > +	if (likely(tick_nohz_highres_handler(&ts->sched_timer) == HRTIMER_RESTART))
> >  		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
> 
> Thanks,
> 
>         tglx

