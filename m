Return-Path: <linux-kernel+bounces-40565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E040583E280
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47985B243DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EABD225CC;
	Fri, 26 Jan 2024 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A61AI+Wl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B7225A5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297317; cv=none; b=E4vK4P8pFfvbtEpzinWByJZkqPXmuM0wpBXi+D1uB/W1WoItNxCSqb2i/L7nVoTgnUSf34zeIFeep3AVOKdvdCQ0UIYjLRLQ4vwmalgRUR36BKXFhn13pZCS81Rm9U2cUFHHfkm1h5vQigd0QmqprHnt6YJIDe37tKR4GjPNsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297317; c=relaxed/simple;
	bh=Empeq3ucS02WOyouPVGXH13ovk7UTCkWj7M0VaBG69c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjUyZvuxft/gxEwFcLVdSjPlTeanh7nOHmAw09mRq+0X8t6tdIzgVn9aWIiSyRfJ9X3+iYDZmI/IWB6NHldXnd5qr4BZ4Sf6Bwscg7xBTEeyWuA8N5CC8NQvkx+mOxZf2qGp3Lnn0YBbsqjhPOnw6IAONqPM4A1ChmRR/iLz/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A61AI+Wl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5B3C433C7;
	Fri, 26 Jan 2024 19:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706297317;
	bh=Empeq3ucS02WOyouPVGXH13ovk7UTCkWj7M0VaBG69c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=A61AI+Wl5uFXsH2nsSJVYRMZV02JTkU125JCqdYklmmpJcUt751/Etgy+LBJNxcvB
	 XyuLJDcGMwTkb1rqvhVSxYCc6biLQ1PNgshKBN+BBYGd2+oeOCbD9/XNmHJtuDx3sc
	 rukOKH865ZQ+IlAZKDmUCtqIzjzUglszkC8N0jaKHTczs4HwUTLA+SpTxC8PRmwCWv
	 b9A3zNBj9OHN+BBj098dScIKJ6Ma/CJhYdgTKaWVLYsxHCAXZYsZRU4OzmrROB61VE
	 p714ey2rg7YDrOVyCo/7elc68WnZ7a79ZOl5rSP5CtSVAJzk15RTtoJD3IVLzmvlZp
	 lxD/IjtIcvbJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EEAE7CE12D9; Fri, 26 Jan 2024 11:28:36 -0800 (PST)
Date: Fri, 26 Jan 2024 11:28:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Feng Tang <feng.tang@intel.com>, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Jin Wang <jin1.wang@intel.com>
Subject: Re: [PATCH] clocksource: Scale the max retry number of watchdog read
 according to CPU numbers
Message-ID: <2955c8b0-cdb5-459e-9d98-9db7a252f0ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240126091250.79985-1-feng.tang@intel.com>
 <3b3d9499-dc7a-4ea0-9615-526940f5fcf2@paulmck-laptop>
 <ZbO3bN3WEUvejRBp@feng-clx.sh.intel.com>
 <ebeff3e5-cd57-49ac-86d3-6ebe3c53fa40@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebeff3e5-cd57-49ac-86d3-6ebe3c53fa40@redhat.com>

On Fri, Jan 26, 2024 at 11:19:50AM -0500, Waiman Long wrote:
> On 1/26/24 08:45, Feng Tang wrote:
> > Hi Paul,
> > 
> > On Fri, Jan 26, 2024 at 04:27:19AM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 26, 2024 at 05:12:50PM +0800, Feng Tang wrote:
> > > > There was a bug on one 8-socket server that the TSC is wrongly marked as
> > > > 'unstable' and disabled during boot time. (reproduce rate is every 120
> > > > rounds of reboot tests), with log:
> > > > 
> > > >      clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
> > > >      wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
> > > >      tsc: Marking TSC unstable due to clocksource watchdog
> > > >      TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> > > >      sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
> > > >      clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
> > > >      clocksource: Switched to clocksource hpet
> > > > 
> > > > The reason is for platform with lots of CPU, there are sporadic big or huge
> > > > read latency of read watchog/clocksource during boot or when system is under
> > > > stress work load, and the frequency and maximum value of the latency goes up
> > > > with the increasing of CPU numbers. Current code already has logic to detect
> > > > and filter such high latency case by reading 3 times of watchdog, and check
> > > > the 2 deltas. Due to the randomness of the latency, there is a low possibility
> > > > situation that the first delta (latency) is big, but the second delta is small
> > > > and looks valid, which can escape from the check, and there is a
> > > > 'max_cswd_read_retries' for retrying that check covering this case, whose
> > > > default value is only 2 and may be not enough for machines with huge number
> > > > of CPUs.
> > > > 
> > > > So scale and enlarge the max retry number according to CPU number to better
> > > > filter those latency noise on large system, which has been verified fine in
> > > > 4 days and 670 rounds of reboot test on the 8-socket machine.
> > > > 
> > > > Tested-by: Jin Wang <jin1.wang@intel.com>
> > > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > > > ---
> > > >   kernel/time/clocksource.c | 9 +++++++++
> > > >   1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > > index c108ed8a9804..f15283101906 100644
> > > > --- a/kernel/time/clocksource.c
> > > > +++ b/kernel/time/clocksource.c
> > > > @@ -226,6 +226,15 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> > > >   	u64 wd_end, wd_end2, wd_delta;
> > > >   	int64_t wd_delay, wd_seq_delay;
> > > > +	/*
> > > > +	 * If no user changes the default value, scale the retry threshold
> > > > +	 * according to CPU numbers. As per test, the more CPU a platform has,
> > > > +	 * the bigger read latency is found during boot time or under stress
> > > > +	 * work load. Increase the try nubmer to reduce false alarms.
> > > > + 	 */
> > > > +	if (max_cswd_read_retries == 2)
> > > I like the self-adjusting behavior!
> > Thanks!
> > > But why not make max_cswd_read_retries be a long (instead of a ulong)
> > > defaulting to -1.  Then when someone sets it to a specific positive
> > > value, they get exactly that value, while leaving it -1 gets the default
> > > CPU-scaling behavior.  Zero and other negative values should get a
> > > warning in order to reserve the for possible future use.
> > Good suggestions!
> > 
> > > I also suggest doing the adjustment at boot time, for example, using
> > > an early_initcall().  That way the test code also sees the scaled value.
> > I also thought about doing the adjustment once in early boot phase
> > using num_possible_cpus(), but gave up as that parameters could be
> > changed runtime using sysfs's module parameter interface, and cpu
> > runtime hotplugging.
> > 
> > Since the watchdog timer only happens (if not skipped) every 500 ms,
> > how about doing the ilog2 math everytime, like below:
> > 
> > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > index 1d42d4b17327..9104bdecf34e 100644
> > --- a/include/linux/clocksource.h
> > +++ b/include/linux/clocksource.h
> > @@ -291,7 +291,7 @@ static inline void timer_probe(void) {}
> >   #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
> >   	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
> > -extern ulong max_cswd_read_retries;
> > +extern long max_cswd_read_retries;
> >   void clocksource_verify_percpu(struct clocksource *cs);
> >   #endif /* _LINUX_CLOCKSOURCE_H */
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > index c108ed8a9804..867bb36e6dad 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -208,8 +208,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
> >   	spin_unlock_irqrestore(&watchdog_lock, flags);
> >   }
> > -ulong max_cswd_read_retries = 2;
> > -module_param(max_cswd_read_retries, ulong, 0644);
> > +long max_cswd_read_retries = -1;
> > +module_param(max_cswd_read_retries, long, 0644);
> >   EXPORT_SYMBOL_GPL(max_cswd_read_retries);
> >   static int verify_n_cpus = 8;
> >   module_param(verify_n_cpus, int, 0644);
> > @@ -225,8 +225,17 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> >   	unsigned int nretries;
> >   	u64 wd_end, wd_end2, wd_delta;
> >   	int64_t wd_delay, wd_seq_delay;
> > +	long max_retries = max_cswd_read_retries;
> > +	
> > +	if (max_cswd_read_retries <= 0) {
> > +		if (max_cswd_read_retries != -1)
> > +			pr_warn_once("max_cswd_read_retries has been set a invalid number: %d\n",
> > +				max_cswd_read_retries);
> > -	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
> > +		max_retries = ilog2(num_online_cpus()) + 1;
> > +	} 		
> > +
> > +	for (nretries = 0; nretries <= max_retries; nretries++) {
> >   		local_irq_disable();
> >   		*wdnow = watchdog->read(watchdog);
> >   		*csnow = cs->read(cs);
> > @@ -238,7 +247,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> >   		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
> >   					      watchdog->shift);
> >   		if (wd_delay <= WATCHDOG_MAX_SKEW) {
> > -			if (nretries > 1 || nretries >= max_cswd_read_retries) {
> > +			if (nretries > 1 || nretries >= max_retries) {
> >   				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> >   					smp_processor_id(), watchdog->name, nretries);
> >   			}
> 
> The max_cswd_read_retries value is also used in
> kernel/time/clocksource-wdtest.c. You will have to apply similar logic to
> clocksource-wdtest.c if it is not done once in early_init.

Good point!  If it is not done in an early_init(), could we please
have a function for the common code?

							Thanx, Paul

