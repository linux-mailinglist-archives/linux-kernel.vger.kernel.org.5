Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40163806CA0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377787AbjLFKrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377809AbjLFKrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:47:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168C01BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:46:38 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701859596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9aRQq+zieE0m16GYSiYxRfSkKp588OkR4iM+AM0LTZ0=;
        b=daGyl5VypH7joHf/rofXPAZeTeKFcgMRnHGDjGBXsqwZT3NxInsXjZb/F/wIk/s90YYw4/
        j/IgYuAh3ctW/N6MiBQNf2ldPLz5STmtCJSrBDoBtUzZMrWWCC66CI1q54IZkyNGBb5q0K
        4HAt0kni+m7RkaQwFXE1wI5dGSTEhICj+uIO9QsBE4kP6nD4YivWiL58FmzJ4mvWIarmNJ
        PIniTd0SiTFLSl8+l5fjKeYKsyRUO+Olt6Tu3M0QAtCYrsX8LlDcdqPc3/gifDf9XbFthS
        /lEvZwpKALrimrKdYvbS0Xj1kPXx850Bfj2S2jgBPosfx9vXnMiwKeG19kLVPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701859596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9aRQq+zieE0m16GYSiYxRfSkKp588OkR4iM+AM0LTZ0=;
        b=9+gfpkTJI4BGoTGc+DOYLrCMyDLyckc0OSfLz2vGRprRatpqAjJM390rXTRDJ5/QYZWlub
        64Vtn+3fuKkKD6BA==
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
In-Reply-To: <20231206102629.auU8wCDH@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-20-anna-maria@linutronix.de>
 <20231205182924.SFCmSKXe@linutronix.de> <87o7f3ejq2.fsf@somnus>
 <20231206102629.auU8wCDH@linutronix.de>
Date:   Wed, 06 Dec 2023 11:46:35 +0100
Message-ID: <8734wffw1g.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
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

> On 2023-12-06 10:57:57 [+0100], Anna-Maria Behnsen wrote:
>> Sebastian Siewior <bigeasy@linutronix.de> writes:
>> 
>> > On 2023-12-01 10:26:41 [+0100], Anna-Maria Behnsen wrote:
>> >> When adding a timer to the timer wheel using add_timer_on(), it is an
>> >> implicitly pinned timer. With the timer pull at expiry time model in place,
>> >> TIMER_PINNED flag is required to make sure timers end up in proper base.
>> >> 
>> >> Add TIMER_PINNED flag unconditionally when add_timer_on() is executed.
>> >
>> > This is odd. I have some vague memory that this was already the case.
>> > Otherwise all add_timer_on() users without TIMER_PINNED may get it wrong
>> > due to optimisation.
>> 
>> Which optimisation are you talking about? Are you talking about the
>> heuristic for finding the best CPU in get_target_base()? This heuristic
>> is not used for add_timer_on().
>
> Yes, true. And nobody probably mixes add_timer_on() and mod_timer().

Workqueue mixes add_timer_on() and add_timer(). But therefore the
add_timer_global() function is introduced in patch 17 which drops the
TIMER_PINNED flag. In patch 18 the add_timer() in workqueue code is
replaced by the new function.

Thanks,

        Anna-Maria

