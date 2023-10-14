Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4507C96FC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjJNWL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 18:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjJNWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 18:11:55 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BCEC9;
        Sat, 14 Oct 2023 15:11:53 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7b6043d0bbeso1199597241.1;
        Sat, 14 Oct 2023 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697321512; x=1697926312; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=922hJygixreFW+0cKKHmIjw4XB2i8/UpVFo+15nI/8I=;
        b=MZyUqMbYLlkFiGWPAruC7T404mcPx1waI1drmL69WZHl/Ec3dPVlPzG9NQ+2d1e6E8
         ySYKOnlkZAK3Y0jiI8DOlk1rKFarw8ylO4B1wt68mmWUzdsghqdSpCYBAstMQiQm/0sT
         W0qLomkB6lD7mLhl4WngRfWrCwNRRSbXg4CjvwjhTTvXIODevDR3wDqukmXmZNnQbfbt
         s0bL4wjLZwJgowJMRVgWcNTQqocVWyYC+mCF7bAxBC0cQhYzFSIygYJGH99EZH8jY5IQ
         crkOCYzgolaHCxhNsZIZitBfsPZWEqCq6oUSGNjRCqrG0+cacVw1womlgknUVX4VLgn8
         ODIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697321512; x=1697926312;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=922hJygixreFW+0cKKHmIjw4XB2i8/UpVFo+15nI/8I=;
        b=amlGTIRH6HNLM1XnX9g7GrInD9GQqMZfqUfA1ZOuGiVCuHvYW/wJRgn01eub9KvsgA
         xJN3j8RieU7SvZMn11WBCrfkEPJa7COR1X1sx/Z7XJwDVD1QWRUQfjaf18x5tQUaBFG/
         zk2mtZROSzqAHOd9mcsrg7aizjksGvQXuEdMwQ43eUxrDxQ/3YYJPc5MN7/lHFEBSsrr
         6xbwOBz5Ndig7/8gYYHIJGDlOueGfAL6DTmrCV2Bh9N8uWlYzQHGXaATI2SUBGgcodi2
         AUOG5H+hbrrrEFHC9TW1zYRzBsX/VnhlHrvPtqkpjankZ9/ykc8f3c7Bb2sjMLbF7RKl
         hFyg==
X-Gm-Message-State: AOJu0YysoMGMbAVGzgp9uIiLle9jQSbLptjFHcqQf6szGrArwdcZTvS4
        CigNW7P/L1WPvewH9sU7cvdJ19dQGJHeWmCBKAUDQq/lnlE=
X-Google-Smtp-Source: AGHT+IFGtshUN76cYx7azc0NDgRZ37H442tEIT6mxail/0QCfmOG2s6zEWaa2KYU34/u3qdY2W0qFRy2nY05GOP/Kb0=
X-Received: by 2002:a67:cd11:0:b0:452:67fd:e5c1 with SMTP id
 u17-20020a67cd11000000b0045267fde5c1mr24367198vsl.4.1697321512373; Sat, 14
 Oct 2023 15:11:52 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 15 Oct 2023 00:11:41 +0200
Message-ID: <CAA85sZtpYOiDkax_epshYq78vtgGRCo9xdf1uTnharDB4Dugkw@mail.gmail.com>
Subject: [bug] 6.5.7 - ixbe freezes and causes RCU deadlock?
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, this keeps happening - it's happened for quite some time now...
I can't really reproduce it but it starts with a network adapter
freezing and ends with RCU errors
and watchdog reboot... :/

cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
[185433.169006] ------------[ cut here ]------------
[185433.169018] NETDEV WATCHDOG: eno3 (ixgbe): transmit queue 2 timed
out 9736 ms
[185433.169094] WARNING: CPU: 3 PID: 0 at net/sched/sch_generic.c:525
dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3))
[185433.169113] Modules linked in: chaoskey
[185433.169126] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.5.7 #393
[185433.169136] Hardware name: Supermicro Super
Server/A2SDi-12C-HLN4F, BIOS 1.7a 10/13/2022
[185433.169142] RIP: 0010:dev_watchdog (net/sched/sch_generic.c:525
(discriminator 3))
[185433.169152] Code: ff ff ff 48 89 df c6 05 e7 2a f8 00 01 e8 30 1f
fa ff 45 89 f8 44 89 f1 48 89 de 48 89 c2 48 c7 c7 98 f9 cd 89 e8 48
65 28 ff <0f> 0b e9 2a ff ff ff 90 55 53 48 89 fb 48 8b 6f 18 0f 1f 44
00 00
All code
========
   0: ff                    (bad)
   1: ff                    (bad)
   2: ff 48 89              decl   -0x77(%rax)
   5: df c6                ffreep %st(6)
   7: 05 e7 2a f8 00        add    $0xf82ae7,%eax
   c: 01 e8                add    %ebp,%eax
   e: 30 1f                xor    %bl,(%rdi)
  10: fa                    cli
  11: ff 45 89              incl   -0x77(%rbp)
  14: f8                    clc
  15: 44 89 f1              mov    %r14d,%ecx
  18: 48 89 de              mov    %rbx,%rsi
  1b: 48 89 c2              mov    %rax,%rdx
  1e: 48 c7 c7 98 f9 cd 89 mov    $0xffffffff89cdf998,%rdi
  25: e8 48 65 28 ff        call   0xffffffffff286572
  2a:* 0f 0b                ud2 <-- trapping instruction
  2c: e9 2a ff ff ff        jmp    0xffffffffffffff5b
  31: 90                    nop
  32: 55                    push   %rbp
  33: 53                    push   %rbx
  34: 48 89 fb              mov    %rdi,%rbx
  37: 48 8b 6f 18          mov    0x18(%rdi),%rbp
  3b: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)

Code starting with the faulting instruction
===========================================
   0: 0f 0b                ud2
   2: e9 2a ff ff ff        jmp    0xffffffffffffff31
   7: 90                    nop
   8: 55                    push   %rbp
   9: 53                    push   %rbx
   a: 48 89 fb              mov    %rdi,%rbx
   d: 48 8b 6f 18          mov    0x18(%rdi),%rbp
  11: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
[185433.169161] RSP: 0018:ffffad6e4017cea8 EFLAGS: 00010282
[185433.169170] RAX: 0000000000000000 RBX: ffff9f2ac5a38000 RCX:
0000000000000027
[185433.169177] RDX: ffff9f2e2fadb408 RSI: 0000000000000001 RDI:
ffff9f2e2fadb400
[185433.169183] RBP: ffff9f2ac5a38488 R08: 0000000000000000 R09:
ffffad6e4017cd48
[185433.169189] R10: 0000000000000003 R11: ffffffff89f47928 R12:
ffff9f2ac5c18280
[185433.169194] R13: ffff9f2ac5a383dc R14: 0000000000000002 R15:
0000000000002608
[185433.169200] FS:  0000000000000000(0000) GS:ffff9f2e2fac0000(0000)
knlGS:0000000000000000
[185433.169208] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[185433.169214] CR2: 00007f16daf82638 CR3: 000000010273a000 CR4:
00000000003526e0
[185433.169221] Call Trace:
[185433.169228]  <IRQ>
[185433.169233] ? dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3))
[185433.169242] ? __warn (kernel/panic.c:673)
[185433.169255] ? dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3))
[185433.169264] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[185433.169273] ? handle_bug (arch/x86/kernel/traps.c:324)
[185433.169282] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1))
[185433.169291] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
[185433.169305] ? dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3))
[185433.169313] ? dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3))
[185433.169320] ? pfifo_fast_reset (net/sched/sch_generic.c:496)
[185433.169328] ? pfifo_fast_reset (net/sched/sch_generic.c:496)
[185433.169336] call_timer_fn (./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207 ./include/trace/events/timer.h:127
kernel/time/timer.c:1701)
[185433.169345] __run_timers.part.0 (kernel/time/timer.c:1752
kernel/time/timer.c:2022)
[185433.169354] ? __hrtimer_run_queues (./include/linux/seqlock.h:612
kernel/time/hrtimer.c:1714 kernel/time/hrtimer.c:1752)
[185433.169362] ? recalibrate_cpu_khz
(./arch/x86/include/asm/msr.h:215 arch/x86/kernel/tsc.c:1130)
[185433.169375] ? ktime_get (kernel/time/timekeeping.c:292
(discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3)
kernel/time/timekeeping.c:848 (discriminator 3))
[185433.169384] run_timer_softirq (kernel/time/timer.c:2037)
[185433.169392] __do_softirq (./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142
kernel/softirq.c:554)
[185433.169404] irq_exit_rcu (kernel/softirq.c:427
kernel/softirq.c:632 kernel/softirq.c:644)
[185433.169413] sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1109 (discriminator 14))
[185433.169425]  </IRQ>
[185433.169429]  <TASK>
[185433.169433] asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[185433.169445] RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
[185433.169456] Code: 00 e8 c2 8f fa fe e8 7d fa ff ff 8b 53 04 49 89
c5 0f 1f 44 00 00 31 ff e8 5b 02 fa fe 45 84 ff 0f 85 60 02 00 00 fb
45 85 f6 <0f> 88 8e 01 00 00 49 63 ce 4c 8b 14 24 48 8d 04 49 48 8d 14
81 48
All code
========
   0: 00 e8                add    %ch,%al
   2: c2 8f fa              ret    $0xfa8f
   5: fe                    (bad)
   6: e8 7d fa ff ff        call   0xfffffffffffffa88
   b: 8b 53 04              mov    0x4(%rbx),%edx
   e: 49 89 c5              mov    %rax,%r13
  11: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  16: 31 ff                xor    %edi,%edi
  18: e8 5b 02 fa fe        call   0xfffffffffefa0278
  1d: 45 84 ff              test   %r15b,%r15b
  20: 0f 85 60 02 00 00    jne    0x286
  26: fb                    sti
  27: 45 85 f6              test   %r14d,%r14d
  2a:* 0f 88 8e 01 00 00    js     0x1be <-- trapping instruction
  30: 49 63 ce              movslq %r14d,%rcx
  33: 4c 8b 14 24          mov    (%rsp),%r10
  37: 48 8d 04 49          lea    (%rcx,%rcx,2),%rax
  3b: 48 8d 14 81          lea    (%rcx,%rax,4),%rdx
  3f: 48                    rex.W

Code starting with the faulting instruction
===========================================
   0: 0f 88 8e 01 00 00    js     0x194
   6: 49 63 ce              movslq %r14d,%rcx
   9: 4c 8b 14 24          mov    (%rsp),%r10
   d: 48 8d 04 49          lea    (%rcx,%rcx,2),%rax
  11: 48 8d 14 81          lea    (%rcx,%rax,4),%rdx
  15: 48                    rex.W
[185433.169463] RSP: 0018:ffffad6e400afe98 EFLAGS: 00000202
[185433.169472] RAX: ffff9f2e2faebb80 RBX: ffff9f2e2faf6500 RCX:
000000000000001f
[185433.169478] RDX: 0000000000000003 RSI: 0000000040000000 RDI:
0000000000000000
[185433.169483] RBP: 0000000000000002 R08: 0000000000000000 R09:
ffff9f2e2faea6c4
[185433.169489] R10: 0000000000000008 R11: 00000000000003d9 R12:
ffffffff8a017140
[185433.169494] R13: 0000a8a6862ac667 R14: 0000000000000002 R15:
0000000000000000
[185433.169505] ? cpuidle_enter_state (drivers/cpuidle/cpuidle.c:285)
[185433.169516] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
[185433.169530] do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
[185433.169540] cpu_startup_entry (kernel/sched/idle.c:379 (discriminator 1))
[185433.169550] start_secondary (arch/x86/kernel/smpboot.c:326)
[185433.169562] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:441)
[185433.169575]  </TASK>
[185433.169579] ---[ end trace 0000000000000000 ]---
[185433.169594] ixgbe 0000:07:00.0 eno3: initiating reset due to tx timeout
[185433.169621] ixgbe 0000:07:00.0 eno3: Reset adapter

And in the IPMI console:
[185433.169621] ixgbe 0000:07:00.0 eno3: Reset adapter
[185444.166717] rcu: INFO: rcu_preempt self-detected stall on CPU
[185444.172665] rcu: 0-...!: (20999 ticks this GP)
idle=8d84/1/0x4000000000000000 softirq=1976223/1976223 fqs=2
[185444.182681] rcu: (t=21015 jiffies g=6787421 q=738 ncpus=12)
[185444.188523] rcu: rcu_preempt kthread timer wakeup didn't happen
for 21009 jiffies! g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[185444.200361] rcu: Possible timer handling issue on cpu=8
timer-softirq=1196063
[185444.207761] rcu: rcu_preempt kthread starved for 21032 jiffies!
g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=8
[185444.218639] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
[185444.227946] rcu: RCU grace-period kthread stack dump:
[185444.233347] rcu: Stack dump where RCU GP kthread last ran:
[185507.243156] rcu: INFO: rcu_preempt self-detected stall on CPU
[185507.249098] rcu: 0-....: (84002 ticks this GP)
idle=8d84/1/0x4000000000000000 softirq=1976223/1976223 fqs=1559
[185507.259375] rcu: (t=84094 jiffies g=6787421 q=1213 ncpus=12)
[185570.265595] rcu: INFO: rcu_preempt self-detected stall on CPU
[185570.271532] rcu: 0-....: (147002 ticks this GP)
idle=8d84/1/0x4000000000000000 softirq=1976223/1976223 fqs=13844
[185570.282016] rcu: (t=147117 jiffies g=6787421 q=1273 ncpus=12)
[185570.288049] rcu: rcu_preempt kthread timer wakeup didn't happen
for 13787 jiffies! g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[185570.299914] rcu: Possible timer handling issue on cpu=9
timer-softirq=1211534
[185570.307347] rcu: rcu_preempt kthread starved for 13810 jiffies!
g6787421 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=9
[185570.318258] rcu: Unless rcu_preempt kthread gets sufficient CPU
time, OOM is now expected behavior.
[185570.327601] rcu: RCU grace-period kthread stack dump:
[185570.333005] rcu: Stack dump where RCU GP kthread last ran:

And thats everything i have...
