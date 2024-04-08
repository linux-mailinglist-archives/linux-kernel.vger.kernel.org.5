Return-Path: <linux-kernel+bounces-135056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD33689BA7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252A61F22933
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A5E39ACD;
	Mon,  8 Apr 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="puiN0zwf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD23B782;
	Mon,  8 Apr 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565613; cv=none; b=QRTniy+C2bSMBWF0GfFFH1ngCUQEwK3W9+2cCeycxlnCW8S3WKABjcIfHnpgQJv5Yr6EBoSKlOYthTLZ22DnbYjvrLlRFguNPlk1gbysaxxO+U57SQqCN513joPmMOYXdMc7e67z3j3wWC236Zah/rlXhk5X+nGeLwEb/PrTNuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565613; c=relaxed/simple;
	bh=WW5+hHjcsxB9x6WQC+HMnXKiBa0BcTm9jDWDx74O4zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaCQke6/eYQaaty/n/pVcNB9Bs/Fs6L7XMORrkfOpM/9FTzaqGpI4qHEnUk6dG6TyJp1jTTZf1R/MJXP8atkPbzQwTEaLnEdHHrpjsX7ne7eRPpQ8PjrFwkVEfoWGrmP89ioooK0HvbyaAedIP8MT9sJTOs21dhzMd93s0vgVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=puiN0zwf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kU2LySyqzhc1jD606wj3XB31fd3/av5BMZR/yy1wlfk=; b=puiN0zwfVipwqU0Y0AjrSJ5R5Q
	6pliaWcJlcIRcrcO1Cm11miUPLzFFiqhbpR3mZeGcX7o7TBhW9za5S1yU4Fu02Km6OwVDODoIpdDy
	6DYEe22uJH/CLBRzNTAL9h0X33mobqKiPExxjuj5YbmpPgbu2on0loiw5p4Iw9kXIvUi8XnvZT3qa
	mBRTLgab/3jPpzQdgUobtExMQDqIiDa6ecsqC/Yv/zkc0z685q0xxG05RpP3YXw4as2QvTQNvC11E
	Y1fNuMcMbJXByQBlhmxGbsjPamA+//yndq7Z7RN6RTCK+dXm68mks2b5YsXRKFDAHuKmkjmKY/Hk8
	VIRIZIcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtkXs-0000000H3jo-0lOt;
	Mon, 08 Apr 2024 08:40:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CD06D30046F; Mon,  8 Apr 2024 10:40:03 +0200 (CEST)
Date: Mon, 8 Apr 2024 10:40:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>, stable@kernel.org
Subject: Re: [PATCH v2] PM: s2idle: Make sure CPUs will wakeup directly on
 resume
Message-ID: <20240408084003.GB21904@noisy.programming.kicks-ass.net>
References: <20240405083410.4896-1-anna-maria@linutronix.de>
 <87r0fg5ocg.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0fg5ocg.fsf@somnus>

On Mon, Apr 08, 2024 at 09:02:23AM +0200, Anna-Maria Behnsen wrote:
> s2idle works like a regular suspend with freezing processes and freezing
> devices. All CPUs except the control CPU go into idle. Once this is
> completed the control CPU kicks all other CPUs out of idle, so that they
> reenter the idle loop and then enter s2idle state. The control CPU then
> issues an swait() on the suspend state and therefore enters the idle loop
> as well.
> 
> Due to being kicked out of idle, the other CPUs leave their NOHZ states,
> which means the tick is active and the corresponding hrtimer is programmed
> to the next jiffie.
> 
> On entering s2idle the CPUs shut down their local clockevent device to
> prevent wakeups. The last CPU which enters s2idle shuts down its local
> clockevent and freezes timekeeping.
> 
> On resume, one of the CPUs receives the wakeup interrupt, unfreezes
> timekeeping and its local clockevent and starts the resume process. At that
> point all other CPUs are still in s2idle with their clockevents switched
> off. They only resume when they are kicked by another CPU or after resuming
> devices and then receiving a device interrupt.
> 
> That means there is no guarantee that all CPUs will wakeup directly on
> resume. As a consequence there is no guarantee that timers which are queued
> on those CPUs and should expire directly after resume, are handled. Also
> timer list timers which are remotely queued to one of those CPUs after
> resume will not result in a reprogramming IPI as the tick is
> active. Queueing a hrtimer will also not result in a reprogramming IPI
> because the first hrtimer event is already in the past.
> 
> The recent introduction of the timer pull model (7ee988770326 ("timers:
> Implement the hierarchical pull model")) amplifies this problem, if the
> current migrator is one of the non woken up CPUs. When a non pinned timer
> list timer is queued and the queuing CPU goes idle, it relies on the still
> suspended migrator CPU to expire the timer which will happen by chance.
> 
> The problem exists since commit 8d89835b0467 ("PM: suspend: Do not pause
> cpuidle in the suspend-to-idle path"). There the cpuidle_pause() call which
> in turn invoked a wakeup for all idle CPUs was moved to a later point in
> the resume process. This might not be reached or reached very late because
> it waits on a timer of a still suspended CPU.
> 
> Address this by kicking all CPUs out of idle after the control CPU returns
> from swait() so that they resume their timers and restore consistent system
> state.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218641
> Fixes: 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle path")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: stable@kernel.org

Cute,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/power/suspend.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -106,6 +106,12 @@ static void s2idle_enter(void)
>  	swait_event_exclusive(s2idle_wait_head,
>  		    s2idle_state == S2IDLE_STATE_WAKE);
>  
> +	/*
> +	 * Kick all CPUs to ensure that they resume their timers and restore
> +	 * consistent system state.
> +	 */
> +	wake_up_all_idle_cpus();
> +
>  	cpus_read_unlock();
>  
>  	raw_spin_lock_irq(&s2idle_lock);

