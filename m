Return-Path: <linux-kernel+bounces-72076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723F85AEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EFC28575F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91956448;
	Mon, 19 Feb 2024 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYDxt3Gf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341E55E51
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382231; cv=none; b=Zp+MCmHd6KnBVN+b6vVT+7hanRmOMnGEaGyUdrXbsOHl7zy78uAi6FdZ2UgsngL//zUzFmzjVux/SQqrr9a9tAfiUSytQcFZBhFkDiMBSQS9o5XjctusIE9ta0g43zAR/RovkvRjF91jPq8gG2WqfX/QwBAu3hKR3wfkVwtEFhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382231; c=relaxed/simple;
	bh=BxTAU7ttYJsPF5ccAHvoPkmvx4enzVGfDMz/Fa/Fyn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWN3Z+GW0k+oUSSvnuEYr4V5LzE+w98uzunPgUT4Lyl3zzcV9qAXOZ8syfuFp9tMDCNgeEU0nPulG02WfoawCR35Mx8YqLIAAmXSilBIKziIcC3SKYS7LQr7thurSdzijBUkmnEd9rVqktnwhhu33YQXCWDYXNoKBrD5CEudT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYDxt3Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99311C433C7;
	Mon, 19 Feb 2024 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708382231;
	bh=BxTAU7ttYJsPF5ccAHvoPkmvx4enzVGfDMz/Fa/Fyn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYDxt3Gf4kQiiuUJeyuG2QjWgiv6+BKcxmyc/9pv20kQ9o5DExyV1sR+MODENPTQH
	 zD6Ry+YwypIPULZVbOno76sTZHr4jguF98SpbBXLFhE1peRjFkcYKeQJN4mcCLc3Bo
	 S14sAeZzT7iCuDg9DlXcsvSFP+UC0oAz4HHjMlsSda7Dg05rNRzb+SK7gIivT0Q18O
	 Lfkfkt8gECNepOdSKvg3lfmFLCAOeWErPCzbVZQLc6p/1mDCVTQl+4W3kcQ0s+VHQ3
	 3IygLciHQ7cRW0qXlB2jmBQwpRNr+xTGYvxcc0xDUUi/hWWA/Opa0DVoNd+btFwZEp
	 biXryqr0iB/gQ==
Date: Mon, 19 Feb 2024 23:37:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10a] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
Message-ID: <ZdPYEzno3KqIPo4S@localhost.localdomain>
References: <20240115143743.27827-4-anna-maria@linutronix.de>
 <20240219085236.10624-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219085236.10624-1-anna-maria@linutronix.de>

Le Mon, Feb 19, 2024 at 09:52:36AM +0100, Anna-Maria Behnsen a écrit :
> The timer base is marked idle when get_next_timer_interrupt() is
> executed. But the decision whether the tick will be stopped and whether the
> system is able to go idle is done later. When the timer bases is marked
> idle and a new first timer is enqueued remote an IPI is raised. Even if it
> is not required because the tick is not stopped and the timer base is
> evaluated again at the next tick.
> 
> To prevent this, the timer base is marked idle in tick_nohz_stop_tick() and
> get_next_timer_interrupt() is streamlined by only looking for the next timer
> interrupt. All other work is postponed to timer_base_try_to_set_idle() which is
> called by tick_nohz_stop_tick(). timer_base_try_to_set_idle() never resets
> timer_base::is_idle state. This is done when the tick is restarted via
> tick_nohz_restart_sched_tick().
> 
> With this, tick_sched::tick_stopped and timer_base::is_idle are always in
> sync. So there is no longer the need to execute timer_clear_idle() in
> tick_nohz_idle_retain_tick(). This was required before, as
> tick_nohz_next_event() set timer_base::is_idle even if the tick would not be
> stopped. So timer_clear_idle() is only executed, when timer base is idle. So the
> check whether timer base is idle, is now no longer required as well.
> 
> While at it fix some nearby whitespace damage as well.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just a small detail below that can be fixed in a further patch:

> @@ -930,6 +947,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	 * scheduler tick in tick_nohz_restart_sched_tick().
>  	 */
>  	if (!ts->tick_stopped) {
> +		/* If the timer base is not idle, retain the tick. */
> +		if (!timer_idle)
> +			return;

This happens after tick_do_timer_cpu has been set to TICK_DO_TIMER_NONE. Ideally
it would be better to do it before. Not that it hurts in practice: another CPU
or this one will take the duty. But it looks weird to stop halfway.

Thanks!

