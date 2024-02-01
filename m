Return-Path: <linux-kernel+bounces-48357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B9845AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C0285146
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543525F49A;
	Thu,  1 Feb 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2h+5lTo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE255F48A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799924; cv=none; b=Fw7cJ5mBSwyTiEfuOR8+IccR95sotD8OyiFXX8kuguIh50+klMlrYYp816OvvO6DIfYG8B9fAjPe+4/cNjljD0NJi8MI7/OtOXimV72aOe79jBjiQ47Zf8R5tQrZ7r0seAt2Tkx/EuuhAc86sqEZcbgtR7JGayOz8Lf1wEsO/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799924; c=relaxed/simple;
	bh=hF2rGZBhBeW+6gNXaslLZ5SHszZwUNtMi/CpapcZonI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmrYDiudUYv43wFvnXz6mVx8t3o9oRtbYhiMEwmXlSjqxttDu4xxgaHN2uo5eqxNh0hfr6Gcfi0dSbnxZCMxUXQwrtHuda9Py1q5ZHTW27jaDw/zmn05eFO3lo8kdKSZ6nC5DhAZfRLpeCaUFdRjeQAWaVlXVvDH/PIm3R34lZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2h+5lTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A3CC433C7;
	Thu,  1 Feb 2024 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706799924;
	bh=hF2rGZBhBeW+6gNXaslLZ5SHszZwUNtMi/CpapcZonI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2h+5lToAcdkT4fECMMxln8Tb7A2X/Q6bcvSgKeZmC8TyM/ScBSvtNUOMM5GYoj/Q
	 Q2OXbB0lNzBOEYQcTRetmHnEX8zPYF6SXSbpKQJigKslpCtCb0UWUZJc085nf9zvHE
	 C8r0u0akt6InC1H69GMftrlcVrrH2HpuANA+snHwcQjwNj/s3NHbMjflkMt382A0I8
	 +TeeSmZaX1ylAezsvRfiL/xcKNEp9U7IQzcN7Qpe7veszkK7Btd6qWzHWeyZBmGxvZ
	 p55yglFtG4FvnL14wqn+luzOfRRTKZh0ZTLTKr32drRNE/D4TIWPvs8lIeiXFzt+of
	 +9g2qmyX44fjQ==
Date: Thu, 1 Feb 2024 16:05:21 +0100
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
Message-ID: <ZbuzMeKlCgebhJZ-@localhost.localdomain>
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
> +static void tmigr_connect_child_parent(struct tmigr_group *child,
> +				       struct tmigr_group *parent)
> +{
> +	union tmigr_state childstate;
> +
> +	raw_spin_lock_irq(&child->lock);
> +	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
> +
> +	child->parent = parent;
> +	child->childmask = BIT(parent->num_children++);
> +
> +	raw_spin_unlock(&parent->lock);
> +	raw_spin_unlock_irq(&child->lock);
> +
> +	/*
> +	 * To prevent inconsistent states, active children need to be active in
> +	 * the new parent as well. Inactive children are already marked inactive
> +	 * in the parent group.
> +	 */
> +	childstate.state = atomic_read(&child->migr_state);
> +	if (childstate.migrator != TMIGR_NONE) {

Is it possible here to connect a running online child (not one that we just
created) to a new parent? If not, is it possible that a newly created child is
not TMIGR_NONE?


> +		struct tmigr_walk data;
> +
> +		data.childmask = child->childmask;
> +
> +		/*
> +		 * There is only one new level per time. When connecting the
> +		 * child and the parent and set the child active when the parent
> +		 * is inactive, the parent needs to be the uppermost
> +		 * level. Otherwise there went something wrong!
> +		 */
> +		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
> +	}
> +}
[...]
> +static int tmigr_cpu_online(unsigned int cpu)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +	int ret;
> +
> +	/* First online attempt? Initialize CPU data */
> +	if (!tmc->tmgroup) {
> +		raw_spin_lock_init(&tmc->lock);
> +
> +		ret = tmigr_add_cpu(cpu);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (tmc->childmask == 0)
> +			return -EINVAL;
> +
> +		timerqueue_init(&tmc->cpuevt.nextevt);
> +		tmc->cpuevt.nextevt.expires = KTIME_MAX;
> +		tmc->cpuevt.ignore = true;
> +		tmc->cpuevt.cpu = cpu;
> +
> +		tmc->remote = false;
> +		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
> +	}
> +	raw_spin_lock_irq(&tmc->lock);
> +	tmc->idle = timer_base_is_idle();
> +	if (!tmc->idle)
> +		__tmigr_cpu_activate(tmc);

Heh, I was about to say that it's impossible that timer_base_is_idle()
at this stage but actually if we run in nohz_full...

It happens so that nohz_full is deactivated until rcutree_online_cpu()
which calls tick_dep_clear() but it's a pure coincidence that might
disappear one day. So yes, let's keep it that way.

Thanks.

> +	tmc->online = true;
> +	raw_spin_unlock_irq(&tmc->lock);
> +	return 0;
> +}

