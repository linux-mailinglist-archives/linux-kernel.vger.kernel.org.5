Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6576950D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGaLjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGaLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:39:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68209A1;
        Mon, 31 Jul 2023 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GfCDZly9m5cEnUMLI6BBT5Bp8X7DDKZH+I1z9AVhN6c=; b=g417rfymXApz8Vy9HCwYkEW4xI
        UTgl7xs0QKhbqhrxhcKMIpPqyAF9nIbqXZjOTMfl+GicpBturDJ5itYF2PQPJoUn4kFvUlVJl3h0E
        AM/o0azCSGg0256spxOImhQCpUDzAQwXSjwDO8tJmcyNIuKUMugrHnk3CreQz7Eu7csT274KtG9X4
        +CFv7dRftdMZZipEw+VpPzf1G34GG0iPJbMJhyUUNyCVcB3SsL7+ZNJria9+CreO3r9z/Qw72hmC/
        MxcXdM/rmoRf0KGdPVbw8+dyNeQVtVYd8SOroeyDZ29IgpENedJDJI6Gyth9h5xS2tbhieQkuUykH
        0+T1A9Pw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQREh-001Ons-Iw; Mon, 31 Jul 2023 11:38:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F317E3002CE;
        Mon, 31 Jul 2023 13:38:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB69A206A36EE; Mon, 31 Jul 2023 13:38:50 +0200 (CEST)
Date:   Mon, 31 Jul 2023 13:38:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
Message-ID: <20230731113850.GE29590@hirez.programming.kicks-ass.net>
References: <20230728145515.990749537@infradead.org>
 <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
 <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
 <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
 <20230731090935.GB29590@hirez.programming.kicks-ass.net>
 <CAJZ5v0jh5oozZm7OvN9j1iHtzYQzPMOJ=Nt0HaJKYyJ218Cezw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jh5oozZm7OvN9j1iHtzYQzPMOJ=Nt0HaJKYyJ218Cezw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:35:20PM +0200, Rafael J. Wysocki wrote:

> > So I agree with 1.
> >
> > I do not agree with 2. Disabling the tick is costly, doubly so with the
> > timer-pull thing, but even today. Simply disabling it because we picked
> > the deepest idle state, irrespective of the expected duration is wrong
> > as it will incur this significant cost.
> >
> > With 3 there is the question of how we get the expected sleep duration;
> > this is especially important with timer-pull, where we have this
> > chicken-and-egg thing.
> >
> > Notably: tick_nohz_get_sleep_length() wants to know if the tick gets
> > disabled
> 
> Well, it shouldn't.  Or at least it didn't before.

Correct, this is new in the timer-pull thing.

> It is expected to produce two values, one with the tick stopped (this
> is the return value of the function) and the other with the tick
> ticking (this is the one written under the address passed as the arg).
> This cannot depend on whether or not the tick will be stopped.  Both
> are good to know.
> 
> Now, I understand that getting these two values may be costly, so
> there is an incentive to avoid calling it, but then the governor needs
> to figure this out from its crystal ball and so care needs to be taken
> to limit the possible damage in case the crystal ball is not right.

If we can get the governor to decide the tick state up-front we can
avoid a lot of the expensive parts.

> > and cpuilde wants to use tick_nohz_get_sleep_length() to
> > determine if to disable the tick. This cycle needs to be broken for
> > timer-pull.
> >
> > Hence my proposal to introduce the extra tick state, that allows fixing
> > both 2 and 3.
> 
> I'm not sure about 3 TBH.
> 
> Say there are 2 idle states, one shallow (say its target residency is
> 10 us) and one deep (say its target residency is T = 2 * TICK_NSEC).

This is the easy case and that actually 'works' today. The
interesting case is where your deepest state has a target residency that
is below the tick (because for HZ=100, we have a 10ms tick and pretty
much all idle states are below that).

In that case you cannot tell the difference between I'm good to use this
state and I'm good to disable the tick and still use this state.


