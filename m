Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0EA7C8816
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjJMOv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjJMOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:51:55 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1BD8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:51:53 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39DEpUBj005234;
        Fri, 13 Oct 2023 23:51:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Fri, 13 Oct 2023 23:51:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39DEpTr6005229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 13 Oct 2023 23:51:30 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
Date:   Fri, 13 Oct 2023 23:51:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] clocksource: disable irq when holding watchdog_lock.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep found that spin_lock(&watchdog_lock) from call_timer_fn()
is not safe. Use spin_lock_irqsave(&watchdog_lock, flags) instead.

[    0.378387] TSC synchronization [CPU#0 -> CPU#1]:
[    0.378387] Measured 55060 cycles TSC warp between CPUs, turning off TSC clock.
[    0.378387] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    0.926101]
[    0.926387] ================================
[    0.926387] WARNING: inconsistent lock state
[    0.926387] 6.6.0-rc5-00192-g10a6e5feccb8 #2 Not tainted
[    0.926387] --------------------------------
[    0.926387] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[    0.926387] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[    0.926387] ffffffff8cfa1c78 (watchdog_lock){?.-.}-{2:2}, at: clocksource_watchdog+0x23/0x5a0
[    0.926387] {IN-HARDIRQ-W} state was registered at:
[    0.926387]   lock_acquire+0xc1/0x2c0
[    0.926387]   _raw_spin_lock_irqsave+0x3f/0x60
[    0.926387]   clocksource_mark_unstable+0x1b/0x90
[    0.926387]   mark_tsc_unstable+0x41/0x50
[    0.926387]   check_tsc_sync_source+0x14f/0x180
[    0.926387]   __flush_smp_call_function_queue+0x16f/0x560
[    0.926387]   __sysvec_call_function_single+0x36/0x110
[    0.926387]   sysvec_call_function_single+0x69/0x90
[    0.926387]   asm_sysvec_call_function_single+0x1a/0x20
[    0.926387]   default_idle+0xf/0x20
[    0.926387]   default_idle_call+0x7f/0x180
[    0.926387]   do_idle+0x1e1/0x220
[    0.926387]   cpu_startup_entry+0x2a/0x30
[    0.926387]   rest_init+0xf4/0x190
[    0.926387]   arch_call_rest_init+0xe/0x30
[    0.926387]   start_kernel+0x763/0x910
[    0.926387]   x86_64_start_reservations+0x18/0x30
[    0.926387]   x86_64_start_kernel+0xca/0xe0
[    0.926387]   secondary_startup_64_no_verify+0x178/0x17b
[    0.926387] irq event stamp: 138774
[    0.926387] hardirqs last  enabled at (138774): [<ffffffff8bb99968>] _raw_spin_unlock_irq+0x28/0x50
[    0.926387] hardirqs last disabled at (138773): [<ffffffff8bb99687>] _raw_spin_lock_irq+0x47/0x50
[    0.926387] softirqs last  enabled at (138216): [<ffffffff8b0904ff>] irq_exit_rcu+0x7f/0xa0
[    0.926387] softirqs last disabled at (138267): [<ffffffff8b0904ff>] irq_exit_rcu+0x7f/0xa0
[    0.926387]
[    0.926387] other info that might help us debug this:
[    0.926387]  Possible unsafe locking scenario:
[    0.926387]
[    0.926387]        CPU0
[    0.926387]        ----
[    0.926387]   lock(watchdog_lock);
[    0.926387]   <Interrupt>
[    0.926387]     lock(watchdog_lock);
[    0.926387]
[    0.926387]  *** DEADLOCK ***
[    0.926387]
[    0.926387] 1 lock held by swapper/0/0:
[    0.926387]  #0: ffffa2d680003ea0 ((&watchdog_timer)){+.-.}-{0:0}, at: call_timer_fn+0x77/0x220
[    0.926387]
[    0.926387] stack backtrace:
[    0.926387] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc5-00192-g10a6e5feccb8 #2
[    0.926387] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    0.926387] Call Trace:
[    0.926387]  <IRQ>
[    0.926387]  dump_stack_lvl+0x4b/0x80
[    0.926387]  mark_lock.part.0+0xa1c/0xf30
[    0.926387]  __lock_acquire+0x3a9/0x2550
[    0.926387]  lock_acquire+0xc1/0x2c0
[    0.926387]  ? clocksource_watchdog+0x23/0x5a0
[    0.926387]  ? __pfx_clocksource_watchdog+0x10/0x10
[    0.926387]  ? __pfx_clocksource_watchdog+0x10/0x10
[    0.926387]  _raw_spin_lock+0x30/0x40
[    0.926387]  ? clocksource_watchdog+0x23/0x5a0
[    0.926387]  clocksource_watchdog+0x23/0x5a0
[    0.926387]  ? __run_timers.part.0+0x30/0x2c0
[    0.926387]  ? __pfx_clocksource_watchdog+0x10/0x10
[    0.926387]  ? __pfx_clocksource_watchdog+0x10/0x10
[    0.926387]  call_timer_fn+0xa5/0x220
[    0.926387]  __run_timers.part.0+0x200/0x2c0
[    0.926387]  run_timer_softirq+0x2a/0x50
[    0.926387]  __do_softirq+0xc4/0x3c8
[    0.926387]  irq_exit_rcu+0x7f/0xa0
[    0.926387]  sysvec_apic_timer_interrupt+0x6e/0x90
[    0.926387]  </IRQ>
[    0.926387]  <TASK>
[    0.926387]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    0.926387] RIP: 0010:default_idle+0xf/0x20
[    0.926387] Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 03 a9 27 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
[    0.926387] RSP: 0000:ffffffff8c803e70 EFLAGS: 00010206
[    0.926387] RAX: 0000000000021bed RBX: ffffffff8c8369c0 RCX: 4000000000000000
[    0.926387] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8b0f0091
[    0.926387] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[    0.926387] R10: 0000000000000028 R11: 0000000000000000 R12: 0000000000000000
[    0.926387] R13: 0000000000000000 R14: ffffffff8c836038 R15: 0000000000000095
[    0.926387]  ? do_idle+0x1e1/0x220
[    0.926387]  default_idle_call+0x7f/0x180
[    0.926387]  do_idle+0x1e1/0x220
[    0.926387]  cpu_startup_entry+0x2a/0x30
[    0.926387]  rest_init+0xf4/0x190
[    0.926387]  arch_call_rest_init+0xe/0x30
[    0.926387]  start_kernel+0x763/0x910
[    0.926387]  x86_64_start_reservations+0x18/0x30
[    0.926387]  x86_64_start_kernel+0xca/0xe0
[    0.926387]  secondary_startup_64_no_verify+0x178/0x17b
[    0.926387]  </TASK>

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/time/clocksource.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..4e8fc0a5ca9d 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -405,8 +405,9 @@ static void clocksource_watchdog(struct timer_list *unused)
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
 	u32 md;
+	unsigned long flags;
 
-	spin_lock(&watchdog_lock);
+	spin_lock_irqsave(&watchdog_lock, flags);
 	if (!watchdog_running)
 		goto out;
 
@@ -554,7 +555,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 		add_timer_on(&watchdog_timer, next_cpu);
 	}
 out:
-	spin_unlock(&watchdog_lock);
+	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
 static inline void clocksource_start_watchdog(void)
-- 
2.34.1

