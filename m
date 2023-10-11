Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D817C5736
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbjJKOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjJKOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:44:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72EBB6;
        Wed, 11 Oct 2023 07:44:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5030CC433C8;
        Wed, 11 Oct 2023 14:44:07 +0000 (UTC)
Date:   Wed, 11 Oct 2023 10:45:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4.19 00/29] 4.19.282-rc1 review
Message-ID: <20231011104529.75f53d4b@gandalf.local.home>
In-Reply-To: <2023101125-subpanel-enviably-28cd@gregkh>
References: <20230424131121.155649464@linuxfoundation.org>
        <CA+G9fYstB_fROK9LHYuQ8dc2ArieGGAW_x69eEX-eAi5xMeE3Q@mail.gmail.com>
        <20230426170945.0ec0f1ef@gandalf.local.home>
        <20230426181415.17c893f5@gandalf.local.home>
        <CA+G9fYtd=dJEM=+xOHA9Egs88r+gEfrnW_gFnTFm4of5uTQ7mA@mail.gmail.com>
        <CA+G9fYt518bg10DVo=ag=iGB8dj_NQZEmEty1CdkU3Cj+gtW0w@mail.gmail.com>
        <2023101132-playable-flagstick-1abf@gregkh>
        <2023101125-subpanel-enviably-28cd@gregkh>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 11:05:48 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > Ok, I'll queue it up now, I didn't realize it needed to be there, sorry.  
> 
> Nope, I can't, it doesn't apply there, so I need a backported, and
> TESTED version, for 5.4.y and 4.19.y if anyone wants to see it there.

This is a quick backport for 4.19 as the conflict seemed to be due to added
code that is unrelated to this change. I built and booted it, but it should
have more testing.

Naresh, if you want this in 4.19, please run it through your tests and give
your tested by.

Greg, please do not take it until Naresh has tested it.

Thanks,

-- Steve

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2d182dc1b49e..01bde6dec13a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -140,13 +140,14 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 * executing it contains RCU usage regarded as invalid in the idle
 	 * context, so tell RCU about that.
 	 */
-	RCU_NONIDLE(tick_freeze());
+	tick_freeze();
 	/*
 	 * The state used here cannot be a "coupled" one, because the "coupled"
 	 * cpuidle mechanism enables interrupts and doing that with timekeeping
 	 * suspended is generally unsafe.
 	 */
 	stop_critical_timings();
+	rcu_idle_enter();
 	drv->states[index].enter_s2idle(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
 		local_irq_disable();
@@ -155,7 +156,8 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 * first CPU executing it calls functions containing RCU read-side
 	 * critical sections, so tell RCU about that.
 	 */
-	RCU_NONIDLE(tick_unfreeze());
+	rcu_idle_exit();
+	tick_unfreeze();
 	start_critical_timings();
 
 	time_end = ns_to_ktime(local_clock());
@@ -224,16 +226,18 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
 
-	trace_cpu_idle_rcuidle(index, dev->cpu);
+	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock());
 
 	stop_critical_timings();
+	rcu_idle_enter();
 	entered_state = target_state->enter(dev, drv, index);
+	rcu_idle_exit();
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
 	time_end = ns_to_ktime(local_clock());
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
+	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
 	sched_idle_set_state(NULL);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 44a17366c8ec..4e3d149d64ad 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -53,17 +53,18 @@ __setup("hlt", cpu_idle_nopoll_setup);
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
+	trace_cpu_idle(0, smp_processor_id());
+	stop_critical_timings();
 	rcu_idle_enter();
-	trace_cpu_idle_rcuidle(0, smp_processor_id());
 	local_irq_enable();
-	stop_critical_timings();
 
 	while (!tif_need_resched() &&
-		(cpu_idle_force_poll || tick_check_broadcast_expired()))
+	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
-	start_critical_timings();
-	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
+
 	rcu_idle_exit();
+	start_critical_timings();
+	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 
 	return 1;
 }
@@ -90,7 +91,9 @@ void __cpuidle default_idle_call(void)
 		local_irq_enable();
 	} else {
 		stop_critical_timings();
+		rcu_idle_enter();
 		arch_cpu_idle();
+		rcu_idle_exit();
 		start_critical_timings();
 	}
 }
@@ -148,7 +151,6 @@ static void cpuidle_idle_call(void)
 
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
 
 		default_idle_call();
 		goto exit_idle;
@@ -166,19 +168,15 @@ static void cpuidle_idle_call(void)
 
 	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
 		if (idle_should_enter_s2idle()) {
-			rcu_idle_enter();
 
 			entered_state = cpuidle_enter_s2idle(drv, dev);
 			if (entered_state > 0) {
 				local_irq_enable();
 				goto exit_idle;
 			}
-
-			rcu_idle_exit();
 		}
 
 		tick_nohz_idle_stop_tick();
-		rcu_idle_enter();
 
 		next_state = cpuidle_find_deepest_state(drv, dev);
 		call_cpuidle(drv, dev, next_state);
@@ -195,8 +193,6 @@ static void cpuidle_idle_call(void)
 		else
 			tick_nohz_idle_retain_tick();
 
-		rcu_idle_enter();
-
 		entered_state = call_cpuidle(drv, dev, next_state);
 		/*
 		 * Give the governor an opportunity to reflect on the outcome
@@ -212,8 +208,6 @@ static void cpuidle_idle_call(void)
 	 */
 	if (WARN_ON_ONCE(irqs_disabled()))
 		local_irq_enable();
-
-	rcu_idle_exit();
 }
 
 /*
