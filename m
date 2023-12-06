Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E20806BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377658AbjLFKUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377640AbjLFKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:20:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9B18F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:21:00 -0800 (PST)
Date:   Wed, 6 Dec 2023 11:20:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701858059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C45DOZNqHlf6CtGNEEnMCQuBPql4ZJgTYbpJ0anoEpc=;
        b=kHZjeKMACP4LSXeNS373k9go61+HkPqpxnycDGNdTjvA0+Yc0fudud7Eg/vWERJhxwuATK
        KfYf2O//1XLTvTxC7aeb7hQj6fF9HwBzOzo6flb/nnrFzOnzJPB1IUIUuFAGzLy8BlqN84
        y1rfr7XTUtPue9UAzu8vw92Dv5wu5QqjrO7jCFLzuH4Tsy8Q4BmMWjZ9mEEwsWHetavGTD
        gbi0werKZBx/po5EJpcdi3zu8gwd89px0MotAiR3/yRwz9OY/tbbbTyuEzJBKYTE8u3Pd9
        HdT+LjM4DcLaUF9ApHzMt2V3VzI49+2lQblmAxlvjYlR0RgMW0qI4nDDRPuDng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701858059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C45DOZNqHlf6CtGNEEnMCQuBPql4ZJgTYbpJ0anoEpc=;
        b=pJnDOB3fUSN2YgPfX8TmjKgkgMwZcCSWYofRXmuPgVHmKii9e6EQasbkqqfBpPQLAl+r6X
        ENLJJrIc5PN888Cg==
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
Subject: Re: [PATCH v9 24/32] timers: Split out "get next timer interrupt"
 functionality
Message-ID: <20231206102057.RrJjegFf@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-25-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201092654.34614-25-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:46 [+0100], Anna-Maria Behnsen wrote:
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 0d53d853ae22..fc376e06980e 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
=E2=80=A6
> +static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 ba=
sem,
> +					     bool *idle)
> +{
> +	struct timer_events tevt =3D { .local =3D KTIME_MAX, .global =3D KTIME_=
MAX };
> +	struct timer_base *base_local, *base_global;
> +	unsigned long nextevt;
> +	u64 expires;
> +
> +	/*
> +	 * Pretend that there is no timer pending if the cpu is offline.
> +	 * Possible pending timers will be migrated later to an active cpu.
> +	 */
> +	if (cpu_is_offline(smp_processor_id())) {
> +		if (idle)
> +			*idle =3D true;
> +		return tevt.local;
> +	}
> +
> +	base_local =3D this_cpu_ptr(&timer_bases[BASE_LOCAL]);
> +	base_global =3D this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
> +
> +	raw_spin_lock(&base_local->lock);
> +	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
> +
> +	nextevt =3D fetch_next_timer_interrupt(basej, basem, base_local,
> +					     base_global, &tevt);

Now you split it, move it and we have the __forward_timer_base() back in
case of the shortcut which is now in fetch_next_timer_interrupt().
All good.

> =20
>  	/*
>  	 * We have a fresh next event. Check whether we can forward the

Sebastian
