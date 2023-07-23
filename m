Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0709C75E503
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGWVV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGWVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 17:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C5CE6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67AA460E0B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 21:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F891C433C7;
        Sun, 23 Jul 2023 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690147315;
        bh=6LWEmhjCqGdhTb3ZoPLAE8w60Ov+r4yfBadWBvADE4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFF2Xz0pEHdxYH29sTDhySQH3I7rDTTM1f245Ciz6CgfGa7z8j01aSw2Y+XihvEQ+
         w16KRhLrJqeObSFp0V4cDCPpm7NQGOjhcaSFuoJ1V7nBrOsfkh4jL6cB0j1B+LW0WC
         pz9dbdZc3+HOsap+oxwq4ECLdjmlaRDZPYxHOWC4f1ZlmKDqRaV5S7gTp/mSAhzq4t
         GMGZl1+lqL8G/LpWROyTztLascLMJaOGdu2Sa+LBDMOIAxVfVkINx+1L+wzbs+Acn/
         vLu56VfJct0UJKXoipZt31iKbMAV4oRYOoB79CpRsEoNa1ddYblGJCRoC7IHvPWKBE
         Uyi515YCv7KMQ==
Date:   Sun, 23 Jul 2023 23:21:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: Stopping the tick on a fully loaded system
Message-ID: <ZL2Z8InSLmI5GU9L@localhost.localdomain>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Rafael in Cc)

Le Thu, Jul 20, 2023 at 03:00:37PM +0200, Anna-Maria Behnsen a écrit :
> I had also a look at teo. It makes things better but does not solve the
> underlying problem that I see here - please correct me if I missed
> something or if I'm simply wrong:
> 
> Yes, the governors have to decide in the end, whether it makes sense to
> stop the tick or not. For this decision, the governors require information
> about the current state of the core and how long nothing has to be done
> propably. At the moment the governors therefore call
> tick_nohz_get_sleep_length(). This checks first whether the tick can be
> stopped. Then it takes into account whether rcu, irq_work, arch_work needs
> the CPU or a timer softirq is pending. If non of this is true, then the
> timers are checked. So tick_nohz_get_sleep_length() isn't only based on
> timers already.

Right but those things (rcu/irq work, etc...) act kind of like timers here
and they should be considered as exceptions.

The timer infrastructure shouldn't take into account the idle activity,
this is really a job for the cpuidle governors.
 
> The information about the sleep length of the scheduler perspective is
> completely missing in the current existing check for the probable sleep
> length.
> 
> Sure, teo takes scheduler utilization into account directly in the
> governor. But for me it is not comprehensible, why the CPU utilization
> check is done after asking for the possible sleep length where timers are
> taken into account. If the CPU is busy anyway, the information generated by
> tick_nohz_next_event() is irrelevant. And when the CPU is not busy, then it
> makes sense to ask for the sleep length also from a timer perspective.
> 
> When this CPU utilization check is implemented directly inside the
> governor, every governor has to implement it on it's own. So wouldn't it
> make sense to implement a "how utilized is the CPU out of a scheduler
> perspective" in one place and use this as the first check in
> tick_nohz_get_sleep_length()/tick_nohz_next_event()?
> 

Well, beyond that, there might be other situations where the governor may
decide not to stop the tick even if tick_nohz_next_event() says it's possible
to do so. That's the purpose of having that next event as an input among many
others for the cpuidle governors.

As such, calling tmigr_cpu_deactivate() on next tick _evaluation_ time instead of
tick _stop_ time is always going to be problematic.

Can we fix that and call tmigr_cpu_deactivate() from tick_nohz_stop_tick()
instead? This will change a bit the locking scenario because
tick_nohz_stop_tick() doesn't hold the base lock. Is it a problem though?
In the worst case a remote tick happens and handles the earliest timer
for the current CPU while it's between tick_nohz_next_event() and
tick_nohz_stop_tick(), but then the current CPU would just propagate
an earlier deadline than needed. No big deal.

Though I could be overlooking some race or something else making that
not possible of course...

Thanks.
