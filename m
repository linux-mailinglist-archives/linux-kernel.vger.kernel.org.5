Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA64809EB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573415AbjLHJB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjLHJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:01:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CF510F9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:02:02 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702026120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmRqxXj61KELQv47LOaO3sGoDuwnlNOMnlmAOuzslGQ=;
        b=lwObnaLMKAeAMYt25DmXyG+oTyx1hmeZ46o9OuKqQ1GKwsF3ZDkU33CVS843ZpXTA+eWOG
        H532ihNpEv3+23QmKB/GHdIkAgm22fTyCIOf3kA272LChJJyNfn662W1EE6tpNlqQG6tpe
        xdWHNyLDCggWChDB22jMxQ725sdp0P1XpSEugmhLXNiloauEOLJNppt/DNO+IXvBaSambQ
        eZCAinGMi3Z/sw+t6bGFWkt58/r0yGL17xrufgeyZdDzB8sXOtoHlW+6qyLO26H4seVSLj
        GDc9DspUX5M1EqDyzzoIvXzsCclOfcC9rYeWUYNTE/NqN1qcQb4Stwe8CofLjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702026120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmRqxXj61KELQv47LOaO3sGoDuwnlNOMnlmAOuzslGQ=;
        b=td9XBibe5SIOCQKq4SW1I7P/mKpM88EAjaxVvrYpWqdFvO6jsLBCfqJEP06wDxJ/n5ujZh
        /yypgUdjBXbHOuDQ==
To:     Sebastian Siewior <bigeasy@linutronix.de>
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
In-Reply-To: <20231206163536.r9DcrsWQ@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
 <20231206163536.r9DcrsWQ@linutronix.de>
Date:   Fri, 08 Dec 2023 10:01:59 +0100
Message-ID: <878r652hko.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Siewior <bigeasy@linutronix.de> writes:

> On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:

[...]

>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index b6c9ac0c3712..ac3e888d053f 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -2103,6 +2104,64 @@ void timer_lock_remote_bases(unsigned int cpu)
> =E2=80=A6
>> +static void timer_use_tmigr(unsigned long basej, u64 basem,
>> +			    unsigned long *nextevt, bool *tick_stop_path,
>> +			    bool timer_base_idle, struct timer_events *tevt)
>> +{
>> +	u64 next_tmigr;
>> +
>> +	if (timer_base_idle)
>> +		next_tmigr =3D tmigr_cpu_new_timer(tevt->global);
>> +	else if (tick_stop_path)
>> +		next_tmigr =3D tmigr_cpu_deactivate(tevt->global);
>> +	else
>> +		next_tmigr =3D tmigr_quick_check();
>> +
>> +	/*
>> +	 * If the CPU is the last going idle in timer migration hierarchy, make
>> +	 * sure the CPU will wake up in time to handle remote timers.
>> +	 * next_tmigr =3D=3D KTIME_MAX if other CPUs are still active.
>> +	 */
>> +	if (next_tmigr < tevt->local) {
>> +		u64 tmp;
>> +
>> +		/* If we missed a tick already, force 0 delta */
>> +		if (next_tmigr < basem)
>> +			next_tmigr =3D basem;
>> +
>> +		tmp =3D div_u64(next_tmigr - basem, TICK_NSEC);
>
> Is this considered a hot path? Asking because u64 divs are nice if can
> be avoided ;)

It's the 'try to go idle path' - so no hot path. Please correct me if
I'm wrong.

> I guess the original value is from fetch_next_timer_interrupt(). But
> then you only need it if the caller (__get_next_timer_interrupt()) has
> the `idle' value set. Otherwise the operation is pointless.
> Would it somehow work to replace
> 	base_local->is_idle =3D time_after(nextevt, basej + 1);
>
> with maybe something like
> 	base_local->is_idle =3D tevt.local > basem + TICK_NSEC
>
> If so you could avoid the `nextevt' maneuver.
>

This change could be done indepentant as an improvement on top of the
queue as well. I will not improve it right now, if it's ok.

>> +		*nextevt =3D basej + (unsigned long)tmp;
>> +		tevt->local =3D next_tmigr;
>> +	}
>> +}
>> +# else

Thanks for the other input - I already changed it for v10 of the queue.

Thanks,

	Anna-Maria

