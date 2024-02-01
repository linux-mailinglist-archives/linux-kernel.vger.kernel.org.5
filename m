Return-Path: <linux-kernel+bounces-48536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A8845D53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E842A1C257CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D542C686;
	Thu,  1 Feb 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw9t4vA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E6F2C1AE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805184; cv=none; b=OkdHncSAPiZqmWxC+pmeaxUPo2t+hNNABzh/cMGx/RJzCg5y0FjAPS5b+cj9kr4Gb8qJmgwiY5bqVg4dUoMp499gtUZpSvIV5rEqyRxEcVnBAvF/8BpP0z9Rn7pvCt4i5shWkAXzfZlNyiu3n0LBrMjA/Sc9KmZmY+jRMCyPXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805184; c=relaxed/simple;
	bh=Qbj8bC/1djsl/mFIrDJjtIIWu8Mt7SSW3NUMv5sfBBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYNXhPW0g3TvXdtAK68p7wG5A5a2N65kXyWgWgpBca5eRcO/wqctsn4UWN9qbsEEIfUgibTWu1i6V1sSj1cqt1jzpWr/Kdc4OAvRKrhZbXQTor9dCEebJMS8DzJbFCpzYoU5qWBfx9TaxUfa64M32HYjH3CDkUHDV8jpB1Dfpu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw9t4vA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375D4C433C7;
	Thu,  1 Feb 2024 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706805183;
	bh=Qbj8bC/1djsl/mFIrDJjtIIWu8Mt7SSW3NUMv5sfBBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nw9t4vA1lCCoPasrABF2ca+EBAhDPTCM5PPgXWU7bJ1ID0s940UZkOJ2eyGo7qBsw
	 HlaRBoPen+OlTnJKjWTZ5e+I0+ttu7PQf5gGZatGGHAt0bUDrBkIKjLcHwu4/8WaK4
	 GTh/Ts9Fbs/MzYL/EBpNmnnZyi6PSbXUxn1CbE2zd3yyApkHSGigR/6BQLlFRWtVyq
	 QPSI/kHTwFuD3F13O7+/RbWe+5dZQ62r3KsRSTLdMQ5RzZQ0AcfMYMWsRHtjTDDzYv
	 XNY5Oksxi4He9wvMsQXiy92VRXaw/AYE454DuSsb0o1dIRuSVXiq4YPaI3YqwpcDVY
	 HL5zCzwBY+QBw==
Date: Thu, 1 Feb 2024 17:33:00 +0100
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
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZbvHvKdpgqfsJp0E@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-19-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> +static bool tmigr_handle_remote_up(struct tmigr_group *group,
> +				   struct tmigr_group *child,
> +				   void *ptr)
> +{
> +	struct tmigr_remote_data *data = ptr;
> +	u64 now, next = KTIME_MAX;
> +	struct tmigr_event *evt;
> +	unsigned long jif;
> +	u8 childmask;
> +
> +	jif = data->basej;
> +	now = data->now;
> +
> +	childmask = data->childmask;
> +
> +again:
> +	/*
> +	 * Handle the group only if @childmask is the migrator or if the
> +	 * group has no migrator. Otherwise the group is active and is
> +	 * handled by its own migrator.
> +	 */
> +	if (!tmigr_check_migrator(group, childmask))
> +		return true;
> +
> +	raw_spin_lock_irq(&group->lock);
> +
> +	evt = tmigr_next_expired_groupevt(group, now);
> +
> +	if (evt) {
> +		unsigned int remote_cpu = evt->cpu;
> +
> +		raw_spin_unlock_irq(&group->lock);
> +
> +		next = tmigr_handle_remote_cpu(remote_cpu, now, jif);
> +
> +		/* check if there is another event, that needs to be handled */
> +		goto again;
> +	} else {
> +		raw_spin_unlock_irq(&group->lock);
> +	}
> +
> +	/*
> +	 * Update of childmask for the next level and keep track of the expiry
> +	 * of the first event that needs to be handled
> +	 */
> +	data->childmask = group->childmask;
> +	data->firstexp = next;

So assume we have:

            [GRP1:0]
        migrator = [GRP0:0]
        active   = [GRP0:0]
        nextevt  = TIMER3
        /                    \
    [GRP0:0]                  [GRP0:1]
 migrator = CPU0           migrator = NONE
 active   = CPU0           active   = NONE
 nextevt  = KTIME_MAX      nextevt  = TIMER3
    /         \                /         \
   0           1              2           3
  idle       idle           idle         idle (TIMER3)

Then CPU 0 goes idle:

            [GRP1:0]
        migrator = NONE
        active   = NONE
        nextevt  = TIMER3
        /                    \
    [GRP0:0]                  [GRP0:1]
 migrator = NONE           migrator = NONE
 active   = NONE           active   = NONE
 nextevt  = KTIME_MAX      nextevt  = TIMER3
    /         \                /         \
   0           1              2           3
  idle       idle           idle         idle (TIMER3)

CPU 0 is the idle migrator and its tmc->wakeup is TIMER3.
But CPU 0 has a local timer that expires before TIMER3.

When that timer interrupt fires, it raises the softirq, which
executes on IRQ tail. So CPU0 eventually calls tmigr_handle_remote()
before TIMER3 has expired.

This leads to tmigr_next_expired_groupevt() to return NULL and then
data->firstexp = KTIME_MAX and then tmc->wakeup = KTIME_MAX.

Later on, tmigr_new_timer() is called with a KTIME_MAX global
event and so tmc->wakeup stays with KTIME_MAX, ignoring TIMER3.

It looks like you need to handle the tmigr_next_expired_groupevt()
case returning NULL.

Thanks.

