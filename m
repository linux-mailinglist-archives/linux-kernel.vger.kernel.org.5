Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACAE7CFB41
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbjJSNhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345990AbjJSNhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:37:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809FF7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:37:13 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697722630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OM2GoBUexM8Y1Ck7LQ4oTD8qZmSDa+roy4ad+WON+bk=;
        b=Uouh5MFux3ETuWZpQp7hP4sDxbBr1lXlOpz96wmLJOAS8x5QRnwG/RZv08fI9vtxdnZpQR
        GSyFCroWbwyJTLe/8uisa5+eODupO1TLZqfLPiPEArh9itFDFIkersCe779yPfo13ayxKc
        WfrA98hs/3oEhomsXKDybcmhH+1qQactA1uNSVV6q1zhQ4VQ2E0WB3kvLZXFWmRHBnHI6W
        kxCvC+cOyAb0n3tXURS4k9tXWfOtPxnDQoXNxXhC3mdHt1KPLL6nSoRLdkGKvAvJSZGpr6
        87p6+xYikUt7i7ncUDkW/xz3/7lIW9BBNMjBEx1fgvUel79CO5CPO0FDLd7ePA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697722630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OM2GoBUexM8Y1Ck7LQ4oTD8qZmSDa+roy4ad+WON+bk=;
        b=NAwmKZz0v2LcoAB1Wx3HvXiosMEQnD9agr/XJU1iCyrySVgi9mfMChTtR5T87Vs3LXNVoF
        N9i9nHbqVcr0ZJBQ==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v8 10/25] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
In-Reply-To: <ZSgWUTsV37rEeh3t@localhost.localdomain>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-11-anna-maria@linutronix.de>
 <ZSgWUTsV37rEeh3t@localhost.localdomain>
Date:   Thu, 19 Oct 2023 15:37:10 +0200
Message-ID: <87ttqm91ix.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> Le Wed, Oct 04, 2023 at 02:34:39PM +0200, Anna-Maria Behnsen a =C3=A9crit=
 :
>>  static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>>  {
>>  	struct clock_event_device *dev =3D __this_cpu_read(tick_cpu_device.evt=
dev);
>> +	unsigned long basejiff =3D ts->last_jiffies;
>>  	u64 basemono =3D ts->timer_expires_base;
>> -	u64 expires =3D ts->timer_expires;
>> +	bool timer_idle =3D ts->tick_stopped;
>> +	u64 expires;
>>=20=20
>>  	/* Make sure we won't be trying to stop it twice in a row. */
>>  	ts->timer_expires_base =3D 0;
>>=20=20
>> +	/*
>> +	 * Now the tick should be stopped definitely - so timer base needs to =
be
>> +	 * marked idle as well to not miss a newly queued timer.
>> +	 */
>> +	expires =3D timer_set_idle(basejiff, basemono, &timer_idle);
>> +	if (!timer_idle) {
>> +		/*
>> +		 * Do not clear tick_stopped here when it was already set - it will
>> +		 * be retained on next idle iteration when tick expired earlier
>> +		 * than expected.
>> +		 */
>> +		expires =3D basemono + TICK_NSEC;
>> +
>> +		/* Undo the effect of timer_set_idle() */
>> +		timer_clear_idle();
>
> Looks like you don't even need to clear ->is_idle on failure. timer_set_i=
dle()
> does it for you.

You are right. I tried several approaches and then forgot to remove it
here.

>> +	} else if (expires < ts->timer_expires) {
>> +		ts->timer_expires =3D expires;
>> +	} else {
>> +		expires =3D ts->timer_expires;
>
> Is it because timer_set_idle() doesn't recalculate the next hrtimer (as o=
pposed
> to get_next_timer_interrupt())? And since tick_nohz_next_event() did, the=
 fact
> that ts->timer_expires has a lower value may mean there is an hrtimer to =
take
> into account and so you rather use the old calculation?

Yes and because power things rely on it.

> If so please add a comment explaining that because it's not that obvious.=
 It's
> worth noting also the side effect that the nearest timer may have been ca=
ncelled
> in-between and we might reprogram too-early but the event should be rare =
enough
> that we don't care.
>
> Another reason also is that cpuidle may have programmed a shallow C-state
> because it saw an early next expiration estimation. And if the related ti=
mer is
> cancelled in-between and we didn't keep the old expiration estimation, we=
 would
> otherwise stop the tick for a long time with a shallow C-state.

I'll add a comment covering all your input! Thanks!
The probability that there happens a lot of enqueue and dequeue of
timers between get_next_timer_interrupt() and setting timer base idle is
not very high. But we have to make sure that we do not miss a new first
timer there.

>> @@ -926,7 +944,7 @@ static void tick_nohz_stop_tick(struct tick_sched *t=
s, int cpu)
>>  	 * first call we save the current tick time, so we can restart
>>  	 * the scheduler tick in nohz_restart_sched_tick.
>>  	 */
>> -	if (!ts->tick_stopped) {
>> +	if (!ts->tick_stopped && timer_idle) {
>
> In fact, if (!ts->tick_stopped && !timer_idle) then you
> should return now and avoid the reprogramming.

You are right. I'll add it and test it.

>> @@ -1950,6 +1950,40 @@ u64 get_next_timer_interrupt(unsigned long basej,=
 u64 basem)
>>  	if (cpu_is_offline(smp_processor_id()))
>>  		return expires;
>>=20=20
>> +	raw_spin_lock(&base->lock);
>> +	nextevt =3D __get_next_timer_interrupt(basej, base);
>> +	raw_spin_unlock(&base->lock);
>
> It's unfortunate we have to lock here, which means we lock twice
> on the idle path. But I can't think of a better way and I guess
> the follow-up patches rely on that.

We have to do it like this, because power people need the sleep length
information to able to decide whether to stop the tick or not. If we do
not want to have the timer base locked two times in idle path, we will
not be able to move timer base idle marking into
tick_nohz_stop_tick(). But the good thing is, that we do not mark timer
bases idle, when tick is not stopped with this approach.

btw, I try to rewrite this patch completely as tglx was not happy about
some parts of code duplication. I'll make sure that your remarks are
also covered.

Thanks,

	Anna-Maria
