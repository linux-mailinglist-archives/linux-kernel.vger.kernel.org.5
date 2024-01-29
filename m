Return-Path: <linux-kernel+bounces-42045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539AA83FB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414E61C21FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5834EDDA0;
	Mon, 29 Jan 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fITSTYbH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885AED502
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490271; cv=none; b=l1Z/xkUvDy36ycuPHtnigRjiCMiDgUSxGty5LYPzSBrQRNvSMTtDfZObNWJneQGWJjH7jI9315n+ck95bHRGBP2y/3zRcWJl29XIb1iaauDnAEekpNoXM+2pUOzR7s+o4wzMs+YoHnbqknShqcvxeNW/n+FSfVc3J81jTgUt/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490271; c=relaxed/simple;
	bh=UJSUvX2MlCm3/p/mU2fq3AVkWGexBrbA9bclMJ7Mgew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKOceDfeB77KNIMN1cXZG5o5ehNqkcSFouK6t7UMnotvNG1lithh9jOPZKJp1Q+y5qsG2/QUMRUZzgYZEoI3BnI+YpZqGqbgcw6FpJpJ1+2QDENgIybFQeMPl8E3lk2uUBm/YeNfo+ZePp+QaN5cf2TkpimXmZoYam9xNCCJZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fITSTYbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCBAC433F1;
	Mon, 29 Jan 2024 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706490270;
	bh=UJSUvX2MlCm3/p/mU2fq3AVkWGexBrbA9bclMJ7Mgew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fITSTYbHdIRMTM6dBtdj5XSkSK4MN+I5NiQwLzf9+0vWjfD+PFDFpAm7xYQMM0xSU
	 WVe1POI4qqj3EFR7kHv+jbz+ZjNhoSbKDyM2coCxmVRy89UoXi5SZKGislvY+nqDXt
	 +hlbCqzZT126pertG6fBrkicSOU7hwg4PLWwNWDXeKSdq+zhVRHPpkgAtpxCVa24V3
	 +syjG8AoN1KDJLhV/B9of6S00ovVVMC6Lo1+i/Yq3k2pNU8loZBYQkULOwsnjURmin
	 AKJmpLL5SKkSHhzWtUOYnxne73OXvoqy5oApj365JYNmx6wtUhL8u4wA1kMOM6OqKw
	 t31ZZo8fvBsPQ==
Date: Mon, 29 Jan 2024 02:04:27 +0100
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
Message-ID: <Zbb5m0hRHgk59-8z@pavilion.home>
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
> +int tmigr_requires_handle_remote(void)
> +{
> +	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
> +	struct tmigr_remote_data data;
> +	unsigned int ret = 0;
> +	unsigned long jif;
> +
> +	if (tmigr_is_not_available(tmc))
> +		return ret;
> +
> +	data.now = get_jiffies_update(&jif);
> +	data.childmask = tmc->childmask;
> +	data.firstexp = KTIME_MAX;
> +	data.tmc_active = !tmc->idle;
> +	data.check = false;
> +
> +	/*
> +	 * If the CPU is active, walk the hierarchy to check whether a remote
> +	 * expiry is required.
> +	 *
> +	 * Check is done lockless as interrupts are disabled and @tmc->idle is
> +	 * set only by the local CPU.
> +	 */
> +	if (!tmc->idle) {
> +		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
> +
> +		if (data.firstexp != KTIME_MAX)
> +			ret = 1;
> +
> +		return ret;
> +	}
> +
> +	/*
> +	 * If the CPU is idle, check whether the recalculation of @tmc->wakeup
> +	 * is required. @tmc->wakeup_recalc is set, when the last active CPU
> +	 * went offline. The last active CPU delegated the handling of the timer
> +	 * migration hierarchy to another (this) CPU by updating this flag and
> +	 * sending a reschedule.
> +	 *
> +	 * Racy lockless check is valid:
> +	 * - @tmc->wakeup_recalc is set by the remote CPU before it issues
> +	 *   reschedule IPI.
> +	 * - As interrupts are disabled here this CPU will either observe
> +	 *   @tmc->wakeup_recalc set before the reschedule IPI can be handled or
> +	 *   it will observe it when this function is called again on return
> +	 *   from handling the reschedule IPI.
> +	 */
> +	if (tmc->wakeup_recalc) {
> +		__walk_groups(&tmigr_requires_handle_remote_up, &data, tmc);
> +
> +		if (data.firstexp != KTIME_MAX)
> +			ret = 1;
> +
> +		raw_spin_lock(&tmc->lock);
> +		WRITE_ONCE(tmc->wakeup, data.firstexp);
> +		tmc->wakeup_recalc = false;
> +		raw_spin_unlock(&tmc->lock);

Suppose we have:

            [GRP1:0]
            migrator = GRP0:1
            active   = GRP0:0, GRP0:1
              /                \
     [GRP0:0]                  [GRP0:1]
     migrator = CPU 1         migrator = CPU 3
     active   = CPU 1         active   = CPU 3
       /         \               /         \
CPUs  0           1             2           3
     idle        active        idle        active

CPU 0 and CPU 2 have no timer.
CPU 1 has a timer in a few millisecs.

            [GRP1:0]
            migrator = GRP0:1
            active   = GRP0:1
              /                \
     [GRP0:0]                  [GRP0:1]
     migrator = NONE           migrator = CPU 3
     active   = NONE           active   = CPU 3
       /         \                /         \
CPUs  0           1              2           3
     idle        idle         idle        active


CPU 1 went idle, CPU 3 will take care of CPU 1's timer. Then come two
things happening at the same time: CPU 0 has a timer interrupt, due to
RCU callbacks handling for example, and CPU 3 goes offline:

CPU 0                                   CPU 3
-----                                   -----
                                        // On top level [GRP1:0], just set migrator = TMIGR_NONE
                                        tmigr_inactive_up() {
                                            cpu = cpumask_any_but(cpu_online_mask, cpu);
                                            //cpu == 0
                                            tmc_resched = per_cpu_ptr(&tmigr_cpu, CPU 0);
                                            raw_spin_lock(&tmc_resched->lock);
                                            tmc_resched->wakeup_recalc = true;
                                            raw_spin_unlock(&tmc_resched->lock);
// timer interrupt
run_local_timers() {
    tmigr_requires_handle_remote() {
        data.firstexp = KTIME_MAX;
        // CPU 0 sees the tmc_resched->wakeup_recalc
        // latest update
        if (tmc->wakeup_recalc) {
            tmigr_requires_handle_remote_up() {
                // CPU 0 doesn't see GRP0:0 
                // latest update from CPU 1,
                // because it has no locking
                // and does a racy check.
        	    if (!tmigr_check_migrator(group, childmask))
                    return true;
            }
            raw_spin_lock(&tmc->lock);
            WRITE_ONCE(tmc->wakeup, data.firstexp);
            tmc->wakeup_recalc = false;
            raw_spin_unlock(&tmc->lock)
            return 0;
        }
                                            // IPI is sent only now
		                                    smp_send_reschedule(cpu);
                                            }


There is nothing that prevents CPU 0 from not seeing the hierarchy updates from
other CPUs since it checks the migrators in a racy way. As a result the timer of
CPU 1 may be ignored by CPU 0.

You'd need to lock the tmc while calling tmigr_requires_handle_remote_up(), so
that CPU 0 "inherits" everything that CPU 3 has seen, and that includes changes
from CPU 1.


But I see that tmigr_cpu_new_timer() does it right. Wouldn't it be possible to
exlusively let tmigr_cpu_new_timer() handle the wakeup_recalc thing? This is
going to be called after the end of the IRQ (whether timer interrupt or sched
IPI) in any case.

Thanks.

