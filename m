Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF77D76DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjJYVbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjJYVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:31:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DDD132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:31:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698269495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xcDcsO81M9vK0hceytiQ1PbO/SvCwbp0ScdGs67d9so=;
        b=1co65Z8hfV62olLoJAmJt46iO9SecDx8c35M7OrFrsM4FCcQAuoiMJANaJaTElgaxQERf+
        Xchc0f1sgogBRqm1N0lXxbS7YJ2wCOgYmkwOM92aV6m4h0q+9QGnutI2wMs8gGmeA7RRB8
        BAP/I+sjDF1h5zRYDiIJioh9OuhZM1NsKkpaY5RYabeov4UjAuGUU5Hfp39PksyoUw+4Qt
        Dq6c16+EYhwr28H+7U8HlWYa4XFFa7l6jkRcep7Avt1xW+CJH5oAaBFAA26sI19ORuF4H2
        sJdtPeJm1xX69Jij+PjKq7/2LrgJaxvJrXzYIhAgLFnTkuNr/K9dA7GcbJcq2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698269495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xcDcsO81M9vK0hceytiQ1PbO/SvCwbp0ScdGs67d9so=;
        b=bjd5BGpVaX8zgazGbahtwdKQbJPM0SYQOw1EsizBKJffYkuf8fQD1iOkAHzMZ651JgNNYf
        7Myq4/OyHH9sU/Ag==
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Stultz <jstultz@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org
Subject: [PATCH] x86/tsc: Defer marking TSC unstable to a worker
In-Reply-To: <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
Date:   Wed, 25 Oct 2023 23:31:35 +0200
Message-ID: <87zg064ceg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo reported the following lockdep splat when the TSC synchronization
fails during CPU hotplug:

   tsc: Marking TSC unstable due to check_tsc_sync_source failed
  
   WARNING: inconsistent lock state
   inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
   ffffffff8cfa1c78 (watchdog_lock){?.-.}-{2:2}, at: clocksource_watchdog+0x23/0x5a0
   {IN-HARDIRQ-W} state was registered at:
     _raw_spin_lock_irqsave+0x3f/0x60
     clocksource_mark_unstable+0x1b/0x90
     mark_tsc_unstable+0x41/0x50
     check_tsc_sync_source+0x14f/0x180
     sysvec_call_function_single+0x69/0x90

   Possible unsafe locking scenario:
     lock(watchdog_lock);
     <Interrupt>
       lock(watchdog_lock);

   stack backtrace:
    _raw_spin_lock+0x30/0x40
    clocksource_watchdog+0x23/0x5a0
    run_timer_softirq+0x2a/0x50
    sysvec_apic_timer_interrupt+0x6e/0x90

The reason is the recent conversion of the TSC synchronization function
during CPU hotplug on the control CPU to a SMP function call. In case
that the synchronization with the upcoming CPU fails, the TSC has to be
marked unstable via clocksource_mark_unstable().

clocksource_mark_unstable() acquires 'watchdog_lock', but that lock is
taken with interrupts enabled in the watchdog timer callback to minimize
interrupt disabled time. That's obviously a possible deadlock scenario,

Before that change the synchronization function was invoked in thread
context so this could not happen.

As it is not crucical whether the unstable marking happens slightly
delayed, defer the call to a worker thread which avoids the lock context
problem.

Fixes: 9d349d47f0e3 ("x86/smpboot: Make TSC synchronization function call based")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: stable@vger.kernel.org

---
 arch/x86/kernel/tsc_sync.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -15,6 +15,7 @@
  * ( The serial nature of the boot logic and the CPU hotplug lock
  *   protects against more than 2 CPUs entering this code. )
  */
+#include <linux/workqueue.h>
 #include <linux/topology.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
@@ -342,6 +343,13 @@ static inline unsigned int loop_timeout(
 	return (cpumask_weight(topology_core_cpumask(cpu)) > 1) ? 2 : 20;
 }
 
+static void tsc_sync_mark_tsc_unstable(struct work_struct *work)
+{
+	mark_tsc_unstable("check_tsc_sync_source failed");
+}
+
+static DECLARE_WORK(tsc_sync_work, tsc_sync_mark_tsc_unstable);
+
 /*
  * The freshly booted CPU initiates this via an async SMP function call.
  */
@@ -395,7 +403,7 @@ static void check_tsc_sync_source(void *
 			"turning off TSC clock.\n", max_warp);
 		if (random_warps)
 			pr_warn("TSC warped randomly between CPUs\n");
-		mark_tsc_unstable("check_tsc_sync_source failed");
+		schedule_work(&tsc_sync_work);
 	}
 
 	/*
