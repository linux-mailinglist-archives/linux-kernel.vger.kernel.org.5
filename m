Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987180751F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379352AbjLFQfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379346AbjLFQfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:35:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7CCD64
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:35:39 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:35:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701880537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whJDSmpzGX50kYPMLNbdNdqjEVBZrB5OQX4QTVpQUhw=;
        b=lULJtP1S961DyobOF5Cy7I0eUTGIDj2gi35eg/YulHBTPQamJ57ZVOiF/3IY+R2U/x2Ch0
        HZismUnHwyHhYHsIRYkrsuMH6kS78hv/qDlgVdRSD9LBX5l6SSiiDLeM6WLjnscflXXfqr
        2KPT3YyjC8xQjcucdQQTkd3Gj9u1weITskqeWVjkxkyhcc6ssdXOLbQjq3TAOTeWlYXBYI
        rsQf0LF+/xwcHFo38xSajXaTAFNA2qoGVcBkiRiQY8t+Ofbu6mXArK3SvPwFfzfZE7DAM9
        BXqArlw20Ea+Mj0qV3/V//7EsRckIOVk8f16yaaqlcYo4s0mYOauVoLoHyjCBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701880537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whJDSmpzGX50kYPMLNbdNdqjEVBZrB5OQX4QTVpQUhw=;
        b=EjkSfRV6DcWBAYGyXeZq5BEWzbIl5YDBbyuY9MWrn6XL2eNuYn8+skPPAqnPOyXL5yuaHl
        X3jZr89EcBwoQCBQ==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 30/32] timers: Implement the hierarchical pull model
Message-ID: <20231206163536.r9DcrsWQ@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201092654.34614-31-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:
=E2=80=A6
> As long as a CPU is busy it expires both local and global timers. When a
> CPU goes idle it arms for the first expiring local timer. If the first
> expiring pinned (local) timer is before the first expiring movable timer,
> then no action is required because the CPU will wake up before the first
> movable timer expires. If the first expiring movable timer is before the
> first expiring pinned (local) timer, then this timer is queued into a idle
                                                                      an
> timerqueue and eventually expired by some other active CPU.
s/some other/another ?

=E2=80=A6
>=20
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index b6c9ac0c3712..ac3e888d053f 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2103,6 +2104,64 @@ void timer_lock_remote_bases(unsigned int cpu)
=E2=80=A6
> +static void timer_use_tmigr(unsigned long basej, u64 basem,
> +			    unsigned long *nextevt, bool *tick_stop_path,
> +			    bool timer_base_idle, struct timer_events *tevt)
> +{
> +	u64 next_tmigr;
> +
> +	if (timer_base_idle)
> +		next_tmigr =3D tmigr_cpu_new_timer(tevt->global);
> +	else if (tick_stop_path)
> +		next_tmigr =3D tmigr_cpu_deactivate(tevt->global);
> +	else
> +		next_tmigr =3D tmigr_quick_check();
> +
> +	/*
> +	 * If the CPU is the last going idle in timer migration hierarchy, make
> +	 * sure the CPU will wake up in time to handle remote timers.
> +	 * next_tmigr =3D=3D KTIME_MAX if other CPUs are still active.
> +	 */
> +	if (next_tmigr < tevt->local) {
> +		u64 tmp;
> +
> +		/* If we missed a tick already, force 0 delta */
> +		if (next_tmigr < basem)
> +			next_tmigr =3D basem;
> +
> +		tmp =3D div_u64(next_tmigr - basem, TICK_NSEC);

Is this considered a hot path? Asking because u64 divs are nice if can
be avoided ;)

I guess the original value is from fetch_next_timer_interrupt(). But
then you only need it if the caller (__get_next_timer_interrupt()) has
the `idle' value set. Otherwise the operation is pointless.
Would it somehow work to replace
	base_local->is_idle =3D time_after(nextevt, basej + 1);

with maybe something like
	base_local->is_idle =3D tevt.local > basem + TICK_NSEC

If so you could avoid the `nextevt' maneuver.

> +		*nextevt =3D basej + (unsigned long)tmp;
> +		tevt->local =3D next_tmigr;
> +	}
> +}
> +# else
=E2=80=A6
> @@ -2132,6 +2190,21 @@ static inline u64 __get_next_timer_interrupt(unsig=
ned long basej, u64 basem,
>  	nextevt =3D fetch_next_timer_interrupt(basej, basem, base_local,
>  					     base_global, &tevt);
> =20
> +	/*
> +	 * When the when the next event is only one jiffie ahead there is no

   If the next event is only one jiffy ahead then there is no

> +	 * need to call timer migration hierarchy related
> +	 * functions. @tevt->global will be KTIME_MAX, nevertheless if the next
> +	 * timer is a global timer. This is also true, when the timer base is

The second sentence is hard to parse.

> +	 * idle.
> +	 *
> +	 * The proper timer migration hierarchy function depends on the callsite
> +	 * and whether timer base is idle or not. @nextevt will be updated when
> +	 * this CPU needs to handle the first timer migration hierarchy event.
> +	 */
> +	if (time_after(nextevt, basej + 1))
> +		timer_use_tmigr(basej, basem, &nextevt, idle,
> +				base_local->is_idle, &tevt);
> +
>  	/*
>  	 * We have a fresh next event. Check whether we can forward the
>  	 * base.
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> new file mode 100644
> index 000000000000..05cd8f1bc45d
> --- /dev/null
> +++ b/kernel/time/timer_migration.c
> @@ -0,0 +1,1636 @@
=E2=80=A6
> +/*
> + * The timer migration mechanism is built on a hierarchy of groups. The
> + * lowest level group contains CPUs, the next level groups of CPU groups
> + * and so forth. The CPU groups are kept per node so for the normal case
> + * lock contention won't happen across nodes. Depending on the number of
> + * CPUs per node even the next level might be kept as groups of CPU grou=
ps
> + * per node and only the levels above cross the node topology.
> + *
> + * Example topology for a two node system with 24 CPUs each.
> + *
> + * LVL 2			[GRP2:0]
> + *			      GRP1:0 =3D GRP1:M
> + *
> + * LVL 1            [GRP1:0]		         [GRP1:1]
> + *	         GRP0:0 - GRP0:2	      GRP0:3 - GRP0:5
> + *
> + * LVL 0  [GRP0:0]  [GRP0:1]  [GRP0:2]  [GRP0:3]  [GRP0:4]  [GRP0:5]
> + * CPUS     0-7       8-15     16-23     24-31	   32-39     40-47

In the CPUS list between 24-31 and 32-39 is a tab while the other
separators are spaces. Could you please align it with spaces? Judging
form the top you have tabstop=3D8 but here tabstop=3D4 looks "nice".

> + *
> + * The groups hold a timer queue of events sorted by expiry time. These
> + * queues are updated when CPUs go in idle. When they come out of idle
> + * ignore flag of events is set.
> + *

Sebastian
