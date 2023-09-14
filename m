Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BF87A0538
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbjINNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbjINNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:14:32 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6751A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:14:28 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 38EDE3Gv081530;
        Thu, 14 Sep 2023 22:14:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Thu, 14 Sep 2023 22:14:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 38EDDgLu081460
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Sep 2023 22:14:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c59d62ef-0f69-7744-cefe-1fdb71d6cbfc@I-love.SAKURA.ne.jp>
Date:   Thu, 14 Sep 2023 22:13:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: BUG: soft lockup in smp_call_function
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
References: <20230913110709.6684-1-hdanton@sina.com>
 <20230914122134.6783-1-hdanton@sina.com>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230914122134.6783-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/14 21:21, Hillf Danton wrote:
> On Wed, 13 Sep 2023 23:30:23 +0900 Tetsuo Handa wrote:
>> On 2023/09/13 20:07, Hillf Danton wrote:
>>>
>>> 	cpu1			cpu4 (see below)
>>> 	====			====
>>> 	drm_crtc_vblank_off	__run_hrtimer
>>> 	spin_lock_irq(&dev->event_lock);
>>> 	...
>>> 				drm_handle_vblank
>>> 	hrtimer_cancel		spin_lock_irqsave(&dev->event_lock, irqflags);
>>>
>>>
>>> Deadlock should have been reported instead provided the lockdep_map in
>>> struct timer_list were added also to hrtimer, so it is highly appreciated
>>> if Tetsuo or Thomas adds it before 6.8 or 6.10.
>>
>> Not me. ;-)
>>
>> Since hrtimer_cancel() retries forever until lock_hrtimer_base() succeeds,
>> we want to add a lockdep annotation into hrtimer_cancel() so that we can
>> detect this type of deadlock?

Here is a reproducer.

----------------------------------------
#include <linux/module.h>
#include <linux/delay.h>
static DEFINE_SPINLOCK(lock1);
static struct hrtimer timer1;
static enum hrtimer_restart timer_func(struct hrtimer *timer)
{
	unsigned long flags;
	mdelay(100); // Wait for test_init() to hold lock1.
	spin_lock_irqsave(&lock1, flags);
	spin_unlock_irqrestore(&lock1, flags);
	return HRTIMER_RESTART;
}
static int __init test_init(void)
{
	unsigned long flags;
	hrtimer_init(&timer1, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
	timer1.function = &timer_func;
	hrtimer_start(&timer1, 1, HRTIMER_MODE_REL);
	mdelay(10); // Wait for timer_func() to start.
	spin_lock_irqsave(&lock1, flags);
	hrtimer_cancel(&timer1); // Wait for timer_func() to finish.
	spin_unlock_irqrestore(&lock1, flags);
	return -EINVAL;
}
module_init(test_init);
MODULE_LICENSE("GPL");
----------------------------------------

----------------------------------------
[  996.507681] test: loading out-of-tree module taints kernel.
[  996.514019] test: module verification failed: signature and/or required key missing - tainting kernel
[ 1061.893054] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 1061.900411] rcu: 	4-...0: (1 GPs behind) idle=ed6c/1/0x4000000000000000 softirq=3304/3305 fqs=15784
[ 1061.909128] rcu: 	(detected by 0, t=65018 jiffies, g=12625, q=4422 ncpus=12)
[ 1061.915003] Sending NMI from CPU 0 to CPUs 4:
[ 1061.918972] NMI backtrace for cpu 4
[ 1061.919036] CPU: 4 PID: 3826 Comm: insmod Tainted: G           OE      6.6.0-rc1+ #20
[ 1061.919093] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[ 1061.919095] RIP: 0010:delay_tsc+0x34/0xa0
[ 1061.919560] Code: ff 05 e8 b1 26 70 65 44 8b 0d e4 b1 26 70 0f 01 f9 66 90 48 c1 e2 20 48 09 c2 49 89 d0 eb 21 65 ff 0d c8 b1 26 70 74 54 f3 90 <65> ff 05 bd b1 26 70 65 8b 35 ba b1 26 70 41 39 f1 75 28 41 89 f1
[ 1061.919563] RSP: 0018:ffffb471c059cf00 EFLAGS: 00000083
[ 1061.919567] RAX: 0000028efe104ef6 RBX: 0000000000000041 RCX: 0000000000000004
[ 1061.919569] RDX: 00000000002192f8 RSI: 0000000000000004 RDI: 000000000027d81e
[ 1061.919571] RBP: ffff8970dafe5040 R08: 0000028efdeebbfe R09: 0000000000000004
[ 1061.919572] R10: 0000000000000001 R11: ffffffffc0a8d600 R12: ffffffff90e030e0
[ 1061.919574] R13: ffff8970dafe5040 R14: ffffffffc0a8b010 R15: ffff8970dafe5100
[ 1061.919630] FS:  00007fdd998eb740(0000) GS:ffff8970dae00000(0000) knlGS:0000000000000000
[ 1061.919633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1061.919635] CR2: 0000000001edf678 CR3: 00000001a1060000 CR4: 0000000000350ee0
[ 1061.919639] Call Trace:
[ 1061.919641]  <NMI>
[ 1061.919646]  ? nmi_cpu_backtrace+0xb1/0x130
[ 1061.919711]  ? nmi_cpu_backtrace_handler+0x11/0x20
[ 1061.922096]  ? nmi_handle+0xe4/0x290
[ 1061.922163]  ? default_do_nmi+0x49/0x100
[ 1061.922196]  ? exc_nmi+0x152/0x1e0
[ 1061.922198]  ? end_repeat_nmi+0x16/0x67
[ 1061.922340]  ? __pfx_timer_func+0x10/0x10 [test]
[ 1061.922347]  ? delay_tsc+0x34/0xa0
[ 1061.922349]  ? delay_tsc+0x34/0xa0
[ 1061.922350]  ? delay_tsc+0x34/0xa0
[ 1061.922352]  </NMI>
[ 1061.922353]  <IRQ>
[ 1061.922353]  timer_func+0x19/0xff0 [test]
[ 1061.922358]  __hrtimer_run_queues+0x177/0x3a0
[ 1061.922362]  hrtimer_interrupt+0x104/0x240
[ 1061.922364]  ? __do_softirq+0x2db/0x392
[ 1061.922827]  __sysvec_apic_timer_interrupt+0x64/0x180
[ 1061.922833]  sysvec_apic_timer_interrupt+0x65/0x80
[ 1061.922894]  </IRQ>
[ 1061.922896]  <TASK>
[ 1061.922898]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 1061.922902] RIP: 0010:delay_tsc+0x4d/0xa0
[ 1061.922907] Code: c2 49 89 d0 eb 21 65 ff 0d c8 b1 26 70 74 54 f3 90 65 ff 05 bd b1 26 70 65 8b 35 ba b1 26 70 41 39 f1 75 28 41 89 f1 0f 01 f9 <66> 90 48 c1 e2 20 48 09 d0 48 89 c2 4c 29 c2 48 39 fa 72 c8 65 ff
[ 1061.922909] RSP: 0018:ffffb471c1e63bd0 EFLAGS: 00000246
[ 1061.922912] RAX: 00000000751ed8ab RBX: 000000000000000a RCX: 0000000000000004
[ 1061.922914] RDX: 0000000000000267 RSI: 0000000000000004 RDI: 000000000027d81e
[ 1061.922915] RBP: ffffffffc0a91010 R08: 00000267751adc59 R09: 0000000000000004
[ 1061.922917] R10: 0000000000000001 R11: ffffffff90cd85c8 R12: 0000000000000000
[ 1061.922918] R13: ffffb471c1e63d20 R14: 0000000000000000 R15: ffffffffc0a8d080
[ 1061.922923]  ? __pfx_test_init+0x10/0x10 [test]
[ 1061.922934]  test_init+0x52/0xff0 [test]
[ 1061.922941]  do_one_initcall+0x5c/0x280
[ 1061.923004]  ? kmalloc_trace+0xa9/0xc0
[ 1061.923105]  do_init_module+0x60/0x240
[ 1061.923111]  load_module+0x1f6e/0x20d0
[ 1061.923119]  ? ima_post_read_file+0xe3/0xf0
[ 1061.923225]  ? init_module_from_file+0x88/0xc0
[ 1061.923229]  init_module_from_file+0x88/0xc0
[ 1061.923238]  idempotent_init_module+0x19c/0x250
[ 1061.923244]  ? security_capable+0x39/0x60
[ 1061.923304]  __x64_sys_finit_module+0x5b/0xb0
[ 1061.923310]  do_syscall_64+0x3b/0x90
[ 1061.923366]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 1061.923421] RIP: 0033:0x7fdd986f8e29
[ 1061.923427] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 17 e0 2c 00 f7 d8 64 89 01 48
[ 1061.923429] RSP: 002b:00007ffe2f34dd18 EFLAGS: 00000206 ORIG_RAX: 0000000000000139
[ 1061.923432] RAX: ffffffffffffffda RBX: 0000000001ede240 RCX: 00007fdd986f8e29
[ 1061.923434] RDX: 0000000000000000 RSI: 000000000041a96e RDI: 0000000000000003
[ 1061.923435] RBP: 000000000041a96e R08: 0000000000000000 R09: 00007ffe2f34deb8
[ 1061.923436] R10: 0000000000000003 R11: 0000000000000206 R12: 0000000000000000
[ 1061.923437] R13: 0000000001ede210 R14: 0000000000000000 R15: 0000000000000000
[ 1061.923444]  </TASK>
[ 1061.923446] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.474 msecs
----------------------------------------

> 
> Yes, you are right.
> 
> The diff below is my two cents (only for thoughts).
> 

I'm thinking something like below. (Completely untested.)

I haven't checked IRQ state handling. But in the last diff chunk, why raw_spin_unlock_irqrestore()
(which does not re-enable IRQs if the caller already disabled IRQs) is used before calling the callback
function and raw_spin_lock_irq() (which always disables IRQs) is used after calling the callback
function? Is it legal to disable IRQs again when the caller already disabled IRQs?

----------------------------------------
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f10..5640730ec31c 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -123,8 +123,11 @@ struct hrtimer {
 	u8				state;
 	u8				is_rel;
 	u8				is_soft;
 	u8				is_hard;
+#ifdef CONFIG_LOCKDEP
+	struct lockdep_map lockdep_map;
+#endif
 };
 
 /**
  * struct hrtimer_sleeper - simple sleeper structure
@@ -440,15 +443,15 @@ static inline void hrtimer_restart(struct hrtimer *timer)
 	hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
 /* Query timers: */
-extern ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust);
+extern ktime_t __hrtimer_get_remaining(struct hrtimer *timer, bool adjust);
 
 /**
  * hrtimer_get_remaining - get remaining time for the timer
  * @timer:	the timer to read
  */
-static inline ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
+static inline ktime_t hrtimer_get_remaining(struct hrtimer *timer)
 {
 	return __hrtimer_get_remaining(timer, false);
 }
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 238262e4aba7..fe0681d34b56 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -161,14 +161,23 @@ static inline bool is_migration_base(struct hrtimer_clock_base *base)
  * possible to set timer->base = &migration_base and drop the lock: the timer
  * remains locked.
  */
 static
-struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
+struct hrtimer_clock_base *lock_hrtimer_base(struct hrtimer *timer,
 					     unsigned long *flags)
 	__acquires(&timer->base->lock)
 {
 	struct hrtimer_clock_base *base;
 
+#ifdef CONFIG_LOCKDEP
+	unsigned long flags2;
+
+	local_irq_save(flags2);
+	lock_map_acquire(&timer->lockdep_map);
+	lock_map_release(&timer->lockdep_map);
+	local_irq_restore(flags2);
+#endif
+
 	for (;;) {
 		base = READ_ONCE(timer->base);
 		if (likely(base != &migration_base)) {
 			raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
@@ -1456,9 +1465,9 @@ EXPORT_SYMBOL_GPL(hrtimer_cancel);
  * __hrtimer_get_remaining - get remaining time for the timer
  * @timer:	the timer to read
  * @adjust:	adjust relative timers when CONFIG_TIME_LOW_RES=y
  */
-ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust)
+ktime_t __hrtimer_get_remaining(struct hrtimer *timer, bool adjust)
 {
 	unsigned long flags;
 	ktime_t rem;
 
@@ -1574,8 +1583,14 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	timer->is_soft = softtimer;
 	timer->is_hard = !!(mode & HRTIMER_MODE_HARD);
 	timer->base = &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
+#ifdef CONFIG_LOCKDEP
+	{
+		static struct lock_class_key __key;
+		lockdep_init_map(&timer->lockdep_map, "hrtimer", &__key, 0);
+	}
+#endif
 }
 
 /**
  * hrtimer_init - initialize a timer to the given clock
@@ -1684,9 +1699,19 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	trace_hrtimer_expire_entry(timer, now);
 	expires_in_hardirq = lockdep_hrtimer_enter(timer);
 
+#ifdef CONFIG_LOCKDEP
+	local_irq_save(flags);
+	lock_map_acquire(&timer->lockdep_map);
+	local_irq_restore(flags);
+#endif
 	restart = fn(timer);
+#ifdef CONFIG_LOCKDEP
+	local_irq_save(flags);
+	lock_map_release(&timer->lockdep_map);
+	local_irq_restore(flags);
+#endif
 
 	lockdep_hrtimer_exit(expires_in_hardirq);
 	trace_hrtimer_expire_exit(timer);
 	raw_spin_lock_irq(&cpu_base->lock);
----------------------------------------

