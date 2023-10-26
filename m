Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67617D7FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbjJZJjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344531AbjJZJj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:39:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA095184;
        Thu, 26 Oct 2023 02:39:22 -0700 (PDT)
Date:   Thu, 26 Oct 2023 09:39:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698313161;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQR5bG3ChxzzuGKMfvufTVkFsRJ3Z4MiCUwYE4xjOTI=;
        b=ch2O0QVAfF/qqayQdS/3eT3ILe+S5HWfzbgVXWlACSskeONt3esE2Y6WUeKotWB3h3LGUG
        rxeeiMh4d6gxv0FTRcdRrgx9fUn4dl2jciodTmen1G2vsihmRg+JvNLJEz9UrGA/9Yc59Q
        fAz9xX0lCkRGSG5y5mYqi5vV48N9vId2aVpOO9p0lUlR9WsC+0DxoeJ6q5fcb/3JEfT+de
        n2aVId8AzDFVCe5ZKDipb2DZuMqnERNMGePdQ1SE5230RyPZAxbbZXFKSkY3y2+rvyFcsl
        BPaXCMIcL71wX3QcOI9VecGDAyEtbfYIkKrPUMDQY0LxdMhfzi6v7GWrpieQVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698313161;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQR5bG3ChxzzuGKMfvufTVkFsRJ3Z4MiCUwYE4xjOTI=;
        b=NMMgTYL9pr+0gJcFkHvq/yAOeSgqOKJoNIy933il3W/PaIi0m5MqlLAKf7ST0QHnVy2Lf+
        zXt0VpgR0BSS3rDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tsc: Defer marking TSC unstable to a worker
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87zg064ceg.ffs@tglx>
References: <87zg064ceg.ffs@tglx>
MIME-Version: 1.0
Message-ID: <169831316032.3135.3671424483564604046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4f0d5e708ef88b58c954581ca54161064beaaaf5
Gitweb:        https://git.kernel.org/tip/4f0d5e708ef88b58c954581ca54161064beaaaf5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Oct 2023 23:31:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Oct 2023 11:31:45 +02:00

x86/tsc: Defer marking TSC unstable to a worker

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
Link: https://lore.kernel.org/r/87zg064ceg.ffs@tglx
---
 arch/x86/kernel/tsc_sync.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index bbc440c..1123ef3 100644
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
@@ -342,6 +343,13 @@ static inline unsigned int loop_timeout(int cpu)
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
@@ -395,7 +403,7 @@ retry:
 			"turning off TSC clock.\n", max_warp);
 		if (random_warps)
 			pr_warn("TSC warped randomly between CPUs\n");
-		mark_tsc_unstable("check_tsc_sync_source failed");
+		schedule_work(&tsc_sync_work);
 	}
 
 	/*
