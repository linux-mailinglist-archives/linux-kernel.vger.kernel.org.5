Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228BC8053C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442375AbjLEMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442328AbjLEMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:05:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69F6C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:05:20 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701777919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1r0rHwKvAq8UD1DxN9U58B4Dag1H1uArzbdH/NRW3o=;
        b=VX7Voooxsq2R3voHwJVgNJMqJepRmQQ/9IDQt10OUEMABb1eLcGc2ytSi88IiEsuuETRQG
        0YUCyPJIMZxcJdPutdDQQo8zBYT0eeNG0G4Gpyhd3ceENkSaIn736g9lHr9FitX9x5QB6Z
        kd0Tw0dtY77rO7Aj2W2bqNQzNCW2nlLPvKsRk+Mmg2vOWnd16qTPiRq8Sfy1KJ0E4D7QtS
        1AEObDzQq8BM0ypHt8XYMBznNVoXeU6S61NNukFASxKvSm5qQqMElkoWRi37EoF7R+p8j8
        MgglAKOu/K5GMIjhvaYN4BoQBWSuHdnvNgSbw64T7RIZctLWa8+EOpok4gcuCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701777919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N1r0rHwKvAq8UD1DxN9U58B4Dag1H1uArzbdH/NRW3o=;
        b=p4bzjKtaiteYaGdKgzzXauZkiPgP5DhYywNrVjssQ+YvHsRC6VJzoje5zPT2G8Cf5tCs9O
        qrUkaFPc0IeabxBA==
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
Subject: Re: [PATCH v9 16/32] timers: Optimization for
 timer_base_try_to_set_idle()
In-Reply-To: <20231204175246.J_8wNRQp@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-17-anna-maria@linutronix.de>
 <20231204175246.J_8wNRQp@linutronix.de>
Date:   Tue, 05 Dec 2023 13:05:18 +0100
Message-ID: <87wmtsdfcx.fsf@somnus>
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

> On 2023-12-01 10:26:38 [+0100], Anna-Maria Behnsen wrote:
>> When tick is stopped also the timer base is_idle flag is set. When
>> reentering the timer_base_try_to_set_idle() with the tick stopped, there is
>> no need to check whether the timer base needs to be set idle again. When a
>> timer was enqueued in the meantime, this is already handled by the
>> nohz_get_next_event() call which was executed before tick_nohz_stop_tick().
>
> as of #15 tick_stopped is set later in tick_nohz_stop_tick() and both
> (tick_sched::tick_stopped and timer_base::is_idle) are cleared in
> tick_nohz_restart_sched_tick().
>
> Then we have tick_nohz_idle_retain_tick() with only one caller and is
> only clearing timer_base::is_idle. Now, wouldn't it make sense to
> preload timer_idle based on timer_base::is_idle?

When revisting the code, this timer_clear_idle() is no longer required
in tick_nohz_idle_retain_tick(). This is only called when the tick is
not stopped - so timer base is not idle as well and this call is
superfluous.

As we keep both states in sync (tick_sched::tick_stopped and
timer_base::is_idle) it doesn't matter which one is used. In
tick_nohz_stop_tick() I don't have access to timer base. I could add it
to timer_base_try_to_set_idle() but it will not make a difference.

> I don't know if it there is a different outcome if timer_base::is_idle
> gets cleared in the idle path vs tick_sched::tick_stopped.
> I can't find nohz_get_next_event().

s/nohz_get_next_event/tick_nohz_next_event/ ...

>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Sebastian

Thanks,

	Anna-Maria
