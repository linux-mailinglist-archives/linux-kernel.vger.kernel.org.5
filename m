Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF66A806B20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377310AbjLFJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377279AbjLFJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:57:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6F5109
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:58:00 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701856678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+smYO4H/d2owAwpszZT3HQ9Rmb/gtJuTgYaTeXzf6o=;
        b=Qex7qhkGxMWm1qXAgXnl7MLFUUf8Yi5pvG52H5f8qjwn1kc9Wt5Q+MYMI2Z1mqatTdFNeW
        HZk/47/7NYsOsZnhoxMyhl1ycVyEZsxGupXHGXACqWzcNgkyrlXlybhXj2KSOb05JxGhjQ
        6bkkHaHO5xOKozjiNayOX1y/Oa4eZMHkmoiue52F/WDrIMHVm0rLDzPW4ZEhNhHqccyEBe
        UTcOOZ10ZCUItKgNmM/XSGp2dWMJ1QUOsDLF0znk+QQkpAF9Z1poKLCdzr8yatm5GcZQXX
        PrfFF8vJ3t9p9ND7ulT3FY9xUZA+VJwxwmdS+BI302rtBs3WZKlr4Txfxcxnxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701856678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+smYO4H/d2owAwpszZT3HQ9Rmb/gtJuTgYaTeXzf6o=;
        b=nTMl3rcrf76JFJCuIOuNTH0eqq9U1UJTGJU1eNL4YMwNbXPWQ1OTbeKxhUNuFKLygYJMti
        NNHTu3Q+aGPBqxAA==
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
Subject: Re: [PATCH v9 19/32] timers: add_timer_on(): Make sure TIMER_PINNED
 flag is set
In-Reply-To: <20231205182924.SFCmSKXe@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-20-anna-maria@linutronix.de>
 <20231205182924.SFCmSKXe@linutronix.de>
Date:   Wed, 06 Dec 2023 10:57:57 +0100
Message-ID: <87o7f3ejq2.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Siewior <bigeasy@linutronix.de> writes:

> On 2023-12-01 10:26:41 [+0100], Anna-Maria Behnsen wrote:
>> When adding a timer to the timer wheel using add_timer_on(), it is an
>> implicitly pinned timer. With the timer pull at expiry time model in pla=
ce,
>> TIMER_PINNED flag is required to make sure timers end up in proper base.
>>=20
>> Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.
>
> This is odd. I have some vague memory that this was already the case.
> Otherwise all add_timer_on() users without TIMER_PINNED may get it wrong
> due to optimisation.

Which optimisation are you talking about? Are you talking about the
heuristic for finding the best CPU in get_target_base()? This heuristic
is not used for add_timer_on().

> Looking at git history it was never the case and I
> can't confuse it with hrtimer since it never supported the "_on()"
> feature=E2=80=A6
> At least the mix timer in drivers/char/random.c is not using the PINNED
> flag with _on(). So this was wrong then?=E2=80=A6

No, this it is not wrong, as at the moment timers expires always on the
CPU where they have been queued. So when a timer should be queued on a
dedicated CPU several approaches are valid:

- using add_timer_on() with or without TIMER_PINNED flag set to enqueue
  timers on any specified CPU

- use add_timer()/mod_timer()/... with TIMER_PINNED flag set - but this
  only works to enqueue timer on this CPU!

When using the add_timer()/mod_timer()/... functions without
TIMER_PINNED flag, the heuristic is used for finding the best CPU.

So without the timer pull model the change doesn't hurt.

But with the timer pull model in place, it is required to keep the
pinned and non pinned timers in separate per CPU wheels (local wheel =3D
TIMER_PINNED is set; global wheel =3D TIMER_PINNED is not set). So without
this change but with the timer pull model, the mix timer of random.c
would be enqueued on the dedicated CPU, but it would end up in the wrong
wheel (global wheel). And then the timer could also expire on another
CPUs as the global wheels are handled by the migrator when the CPU is
idle.

Does this makes it a little more clear, why the change is required and
why it is also valid right now?

Thanks,

	Anna-Maria

