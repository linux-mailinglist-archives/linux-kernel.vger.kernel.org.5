Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F818806BE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377354AbjLFK01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377325AbjLFK0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:26:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F0120
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:26:32 -0800 (PST)
Date:   Wed, 6 Dec 2023 11:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701858390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vh6aGIxYanNc976UlCBVGpDrHl7F+Xx6XVzJxs+RspE=;
        b=fuoLGjtdLExX5gsUNfgTjZKdCibPjfHL6ZGwt90lLdDBHW4iMKwghLwbawF34YJqPIShk9
        Z87mhDftkEW6qwKkMLt1FDxy9upVLvSbdZpNcSRtgEtW3aQsKPFwrxj65E4dpK636ldHak
        nDnvxFBELYvyamF8ssL1vEdOo+Q3viM3HZhxt5CToHcVWyA0saG4L9czPBMhpZUiR0R0+0
        TTLMw4otlQgNk58MsUU3DeVpm9BuglZop8qy0M/1thXXjYmXFGUlDpEQ/rP/+BYIQXStbo
        6B8KglXbjjbtdfuNUkaBwSGMHUIGJbIESoySX68vIJtv8p4+kJ1+CBj4VD/AgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701858390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vh6aGIxYanNc976UlCBVGpDrHl7F+Xx6XVzJxs+RspE=;
        b=U3M94fzgHkLV94aTwjvMpRo9sgwO5U3R4PS4OKjtO/t/0Ysd7KukN0VoR7IhG5sOr4MBtY
        kSxDN4lr52OSv+Ag==
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
Subject: Re: [PATCH v9 19/32] timers: add_timer_on(): Make sure TIMER_PINNED
 flag is set
Message-ID: <20231206102629.auU8wCDH@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-20-anna-maria@linutronix.de>
 <20231205182924.SFCmSKXe@linutronix.de>
 <87o7f3ejq2.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7f3ejq2.fsf@somnus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-06 10:57:57 [+0100], Anna-Maria Behnsen wrote:
> Sebastian Siewior <bigeasy@linutronix.de> writes:
> 
> > On 2023-12-01 10:26:41 [+0100], Anna-Maria Behnsen wrote:
> >> When adding a timer to the timer wheel using add_timer_on(), it is an
> >> implicitly pinned timer. With the timer pull at expiry time model in place,
> >> TIMER_PINNED flag is required to make sure timers end up in proper base.
> >> 
> >> Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.
> >
> > This is odd. I have some vague memory that this was already the case.
> > Otherwise all add_timer_on() users without TIMER_PINNED may get it wrong
> > due to optimisation.
> 
> Which optimisation are you talking about? Are you talking about the
> heuristic for finding the best CPU in get_target_base()? This heuristic
> is not used for add_timer_on().

Yes, true. And nobody probably mixes add_timer_on() and mod_timer().

> Does this makes it a little more clear, why the change is required and
> why it is also valid right now?

Yes, all good. Thanks.

> Thanks,
> 
> 	Anna-Maria

Sebastian
