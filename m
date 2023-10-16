Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B757CB594
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjJPVsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:48:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A99EA1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:47:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697492876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f59bG+a2eADGxW7wAhinP+pAokYq41IIQASxg536iqM=;
        b=4b0hZ1jwsVNGf8ZQPQlclMglY6PnHSAkZrLg2te83n/7CXJMIrXZ8JrGVYeHG8Ic2ti78j
        coC+APj/tRVbMCCreHh7mTGQIqyNk2JZigCNy4xORZkYQneQIYu3zEbiwex9k75KQ2bzBZ
        EJmptX+xvD7mgT4rcB2aGE2F4JziCcx8O5nKncfdWVqfTM6aj3D36UE110LvW91CMr9c5h
        0mQWB7MD52MFOj/td2ZYClKG5Gg1gXrc8ez1kApqMtCBhmJGFkage6KcCM65GWeNJ0YuN6
        vaQKNhSkjYogDnFE4CW1k7QQDNzKajhMDgISoGGJalJDoKeNFIxoeIERbZKarQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697492876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f59bG+a2eADGxW7wAhinP+pAokYq41IIQASxg536iqM=;
        b=KL/R+mWD7BMAFG9eXLCF0MlASOO4RHg6RcR30TofofC7Hy9oo9/jI6MBnnqjeDvUYX3Cj5
        Mj5+6SWTbnm12hBg==
To:     John Stultz <jstultz@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
In-Reply-To: <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
Date:   Mon, 16 Oct 2023 23:47:55 +0200
Message-ID: <878r826xys.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16 2023 at 10:46, John Stultz wrote:
> On Fri, Oct 13, 2023 at 7:51=E2=80=AFAM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Lockdep found that spin_lock(&watchdog_lock) from call_timer_fn()
>> is not safe. Use spin_lock_irqsave(&watchdog_lock, flags) instead.
>>
>> [    0.378387] TSC synchronization [CPU#0 -> CPU#1]:
>> [    0.378387] Measured 55060 cycles TSC warp between CPUs, turning off =
TSC clock.

<SNIP/>

Please trim splats down to the relevant content. Timestamps and the bulk
of the backtraces are completely uninteresting. Something like this is
completely sufficient and readable:

   tsc: Marking TSC unstable due to check_tsc_sync_source failed
=20=20
   WARNING: inconsistent lock state
   inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
   ffffffff8cfa1c78 (watchdog_lock){?.-.}-{2:2}, at: clocksource_watchdog+0=
x23/0x5a0
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

20 lines of useful information vs. ~100 lines containing mostly
noise. No?

Documentation/process/* clearly asks for this.

>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>> index c108ed8a9804..4e8fc0a5ca9d 100644
>> --- a/kernel/time/clocksource.c
>> +++ b/kernel/time/clocksource.c
>> @@ -405,8 +405,9 @@ static void clocksource_watchdog(struct timer_list *=
unused)
>>         enum wd_read_status read_ret;
>>         unsigned long extra_wait =3D 0;
>>         u32 md;
>> +       unsigned long flags;

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variab=
le-declarations

>> -       spin_lock(&watchdog_lock);
>> +       spin_lock_irqsave(&watchdog_lock, flags);

That looks obvious, but it's just making the problem worse. See below.

> At first glance this looks sane to me.

Emphasis on "first glance" :)

> The only thing that gives me pause is that I'm a little shocked this
> hasn't been caught earlier, and I don't right off see recent changes
> that would have caused this to trip. But Thomas may have more insight.

From looking at the (for you neatly trimmed) backtrace:

     {IN-HARDIRQ-W} state was registered at:
     _raw_spin_lock_irqsave+0x3f/0x60
     clocksource_mark_unstable+0x1b/0x90
     mark_tsc_unstable+0x41/0x50
     check_tsc_sync_source+0x14f/0x180
     sysvec_call_function_single+0x69/0x90

it's bloody obvious which change caused that:

  9d349d47f0e3 ("x86/smpboot: Make TSC synchronization function call based")

Even if you don't recognize it immediately then:

  git grep -l check_tsc_sync_source | xargs git blame | grep check_tsc_sync=
_source

is not really rocket science either, right?

Vs. you being shocked: As long as that synchronization function does not
try to mark the TSC unstable, lockdep won't notice. Definitely
surprising that this took a few months to surface.

But that's not what shocks me...

That spinlock_irqsave() conversion is not a solution. Why?

  If that happens on RT then this is even worse. mark_tsc_unstable()
  is invoked from hard interrupt context via smp function call which
  is a NONO due to watchdog_lock being a spinlock and the _irqsave()
  change won't help anything.

  Yes, I broke it and did not think about that particular side effect
  when moving check_tsc_sync_source() from thread to smp function call
  context.

But that's just a distraction. What's even worse is that the patch
blindly slaps spinlock_irqsave() at the problem without actually looking
what the function does and why it does not use the irqsave variant in
the first place.

  The watchdog function deliberately runs with interrupts enabled and
  only explicitly disables them for the actual readout because there is
  no point in delaying interrupts for this horrorshow accross the whole
  function.

  But the explicit local_irq_disable()/enable() pair around the readout
  means that the patch above is obviously broken:

    spin_lock_irqsave(&watchdog_lock, flags);
    cs_watchdog_read()
      local_irq_disable();
      ...
      local_irq_enable();  <--- FAIL

  Lockdep should have yelled at that too, but even if it failed to do
  so then it's still very obviously wrong.

Something like the uncompiled/untested below should cure it for real. It
really does not matter whether the TSC unstable event happens a bit
later. The system is unhappy no matter what.

That said, this whole clocksource watchdog mess wants a proper
overhaul. It has become a pile of warts and duct tape by now and after
staring at it long enough there is no real reason to run it in a timer
callback anymore. It just can move into delayed work and the whole
locking problem can be reduced to the clocksource_mutex and some well
thought out atomic operations to handle the mark unstable case. But
that's a different story and not relevant for curing the problem at
hand.

Thanks,

        tglx
---
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
=20
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
=20
 	/*
