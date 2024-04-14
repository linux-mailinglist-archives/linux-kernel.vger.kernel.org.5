Return-Path: <linux-kernel+bounces-143937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD098A3FE2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533721F214E7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB73175AA;
	Sun, 14 Apr 2024 02:04:37 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6017551
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713060276; cv=none; b=QHaJ0kQ5vn2ffl7+kzZp597MsEjDN7lGYVeoeRrqA4k4scjO1vgynUZ7LdDuEh5d3vgX8fsOTh20s2bcroUlGtUGYqCuqTj3wPRJ7W8sI5CQc847hc/MbtGdtsr5IG7SgdY7L2CNLVvO9TOqvECYjwykQLUaVZ3LLGNUTpm7Ee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713060276; c=relaxed/simple;
	bh=C2Fsx+2NfUj28JIBVQ45CAyz+h3NEvygZ/BBl7Arzy0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Owfqq1WME9gwboB99RNlMa3c8KoYA2CCxMH4h++I+IdkF6XPNj2trCBOWgkzo4eAs09g+uLRkTnSoHSYpH5TsWKxbRXg+QpMRv5s94BdBMKxbPzW9bKAOLpHDBs+6ZRDEZuMwpA0FIi71LoTWYCdfk2RkVwBtcrswYvKhC51wSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d096c4d663so279932639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713060274; x=1713665074;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCFSM1aTc7Bv7FQ0N3Tjzux7zsi15j98rP+EcecD/hk=;
        b=aQJVTd1bj8g4LKB+Gbpl3iA5UZM6YGN0yOSQWUgPUejwI2Y5I63sSXpJRK1luXF1he
         LHdgtJEFLMV5ZKLN4YA3qky5ez7tV2oNSJ9WT09/pK5apOdocYHGb3tJATpNC0ti6ZNy
         ZOGgAvNf0nI6u3GGfwsOSTrmQUt+6aezgLD5iP0YSF1T/ip5Qlwke95Rd66l1gqeReYt
         ZrkKRBWYufXGropriOhgNn8Ty4bX5GbVRVnSD6Z246dJeexv9H++vkNe/rpHw8HW0B3v
         YvgTMa9ATTUBVUFTlfpqJdUnoLjKn9qYcrJZcSqZ2m3/0H8794E9ODPNnWhOtqjgUkDr
         eX6g==
X-Forwarded-Encrypted: i=1; AJvYcCVFn0/mOc3y9Rl3g96cdyVeEBwJo5xfqNmip4OpKRW5XvPZy8QrmUFGw/TgAOn0TiyyaMcmP/Pqa7y5kz5M7GtAT2kSiW4IBCiSMo0K
X-Gm-Message-State: AOJu0YxAAWJwR8qsFaPdELrEnJsI1jSkE26AoVX8FH1M6aNuNhGrMLR8
	ziXLGS1GY3gujFgC3qR6/P5XaStbUriWyhb4KkgU7dIscm1gD0LX4K1/pTmqTgEmYZ8yDTSifEu
	KNdt7UcObPYnE86IxcodVxSRNwbIeRWE8pMsxS+AxP/PEOIbYO14Yzl4=
X-Google-Smtp-Source: AGHT+IFj3LwOCgFdJLhlJ/hvletYRrI+O0W3fOWWZpdVn4fC11E8odpIeHSqA/yx/csusnjv9SRU0uBWND+FIVS+c9o/WKne/dpi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:369:b997:7342 with SMTP id
 j25-20020a056e02219900b00369b9977342mr419685ila.3.1713060274409; Sat, 13 Apr
 2024 19:04:34 -0700 (PDT)
Date: Sat, 13 Apr 2024 19:04:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022a23c061604edb3@google.com>
Subject: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dvyukov@google.com, elver@google.com, 
	glider@google.com, kasan-dev@googlegroups.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c64113180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16435913180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111600cb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=d3cc/1/0x4000000000000000 softirq=6440/6443 fqs=2
rcu: 	(detected by 1, t=10506 jiffies, g=7245, q=210 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5367 Comm: syz-executor780 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
RIP: 0010:lock_release+0x5c0/0x9d0 kernel/locking/lockdep.c:5776
Code: 00 fc ff df 4c 8b 64 24 08 48 8b 5c 24 28 49 89 dd 4c 8d b4 24 90 00 00 00 48 c7 c7 60 d3 aa 8b e8 d5 9c 02 0a b8 ff ff ff ff <65> 0f c1 05 28 c5 90 7e 83 f8 01 0f 85 9a 00 00 00 4c 89 f3 48 c1
RSP: 0000:ffffc90000007720 EFLAGS: 00000082
RAX: 00000000ffffffff RBX: 0000000000000046 RCX: ffffc90000007703
RDX: 0000000000000001 RSI: ffffffff8baad360 RDI: ffffffff8bfed300
RBP: ffffc90000007860 R08: ffffffff8f873a6f R09: 1ffffffff1f0e74d
R10: dffffc0000000000 R11: fffffbfff1f0e74e R12: 1ffff92000000ef0
R13: 0000000000000046 R14: ffffc900000077b0 R15: dffffc0000000000
FS:  0000555594caf380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 0000000023676000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 rcu_lock_release include/linux/rcupdate.h:308 [inline]
 rcu_read_unlock include/linux/rcupdate.h:783 [inline]
 advance_sched+0xb37/0xca0 net/sched/sch_taprio.c:987
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x597/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x109/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 0a b4 f2 f5 48 89 df e8 c2 f3 f3 f5 e8 1d 19 1d f6 fb bf 01 00 00 00 <e8> 52 e0 e5 f5 65 8b 05 a3 c4 84 74 85 c0 74 06 5b e9 71 40 00 00
RSP: 0000:ffffc90000007cb0 EFLAGS: 00000282
RAX: 49e89c1a0716e600 RBX: ffff8880b942a740 RCX: ffffffff81720c2a
RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: 0000000000000001
RBP: ffffc90000007e10 R08: ffffffff92ce5537 R09: 1ffffffff259caa6
R10: dffffc0000000000 R11: fffffbfff259caa7 R12: ffff8880b942a788
R13: ffffc90000007d60 R14: dffffc0000000000 R15: 00000000ffffdaa5
 __run_timer_base+0x1c0/0x8e0 kernel/time/timer.c:2420
 run_timer_base kernel/time/timer.c:2428 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
 __do_softirq+0x2be/0x943 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:srso_safe_ret+0x0/0x20 arch/x86/lib/retpoline.S:208
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 b8 <48> 8d 64 24 08 c3 cc cc 0f ae e8 e8 f0 ff ff ff 0f 0b 66 2e 0f 1f
RSP: 0000:ffffc90004907030 EFLAGS: 00000293
RAX: ffffffff814095ec RBX: 0000000000000000 RCX: ffff888028fe0000
RDX: 0000000000000000 RSI: ffffffff8140c1eb RDI: ffffffff8140c035
RBP: 1ffff92000920e30 R08: ffffffff81409480 R09: 0000000000000000
R10: ffffc90004907180 R11: fffff52000920e3c R12: ffffffff8f9755b0
R13: dffffc0000000000 R14: 1ffff92000920e30 R15: ffffffff9008ea3e
 srso_return_thunk+0x5/0x5f arch/x86/lib/retpoline.S:222
 unwind_next_frame+0x67c/0x2a00 arch/x86/kernel/unwind_orc.c:495
 __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:129
 __set_page_owner+0x29/0x380 mm/page_owner.c:195
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 alloc_pages_mpol+0x3de/0x650 mm/mempolicy.c:2133
 pagetable_alloc include/linux/mm.h:2842 [inline]
 __pud_alloc_one include/asm-generic/pgalloc.h:169 [inline]
 pud_alloc_one include/asm-generic/pgalloc.h:189 [inline]
 __pud_alloc+0x93/0x4b0 mm/memory.c:5692
 pud_alloc include/linux/mm.h:2799 [inline]
 __handle_mm_fault+0x4472/0x72d0 mm/memory.c:5236
 handle_mm_fault+0x3c2/0x8a0 mm/memory.c:5470
 do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x2a8/0x890 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f37687f9bcc
Code: 00 00 e8 67 52 03 00 48 83 f8 ff 74 07 48 89 05 3a 15 0b 00 31 d2 b9 00 06 00 20 bf 10 00 00 00 48 b8 74 65 61 6d 30 00 00 00 <48> 89 04 25 00 06 00 20 31 c0 48 89 14 25 08 06 00 20 48 8b 35 0b
RSP: 002b:00007ffc3f74a370 EFLAGS: 00010246
RAX: 000000306d616574 RBX: 0000000000000000 RCX: 0000000020000600
RDX: 0000000000000000 RSI: 0000000800000003 RDI: 0000000000000010
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc3f74a3c0
R13: 000000000003239a R14: 00007ffc3f74a38c R15: 0000000000000003
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 4.146 msecs
rcu: rcu_preempt kthread starved for 10495 jiffies! g7245 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26256 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17d3/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2572
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 61 Comm: kworker/u8:4 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x1855/0x2960 kernel/smp.c:855
Code: 89 e6 83 e6 01 31 ff e8 d9 d5 0b 00 41 83 e4 01 49 bc 00 00 00 00 00 fc ff df 75 07 e8 84 d1 0b 00 eb 38 f3 90 42 0f b6 04 23 <84> c0 75 11 41 f7 45 00 01 00 00 00 74 1e e8 68 d1 0b 00 eb e4 44
RSP: 0018:ffffc900015c76e0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 1ffff11017288c0d RCX: ffff88801aadbc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900015c78e0 R08: ffffffff818923b7 R09: 1ffffffff259caa0
R10: dffffc0000000000 R11: fffffbfff259caa1 R12: dffffc0000000000
R13: ffff8880b9446068 R14: ffff8880b953f480 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555594cafca8 CR3: 000000000df32000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2086 [inline]
 text_poke_bp_batch+0x352/0xb30 arch/x86/kernel/alternative.c:2296
 text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2494
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa02/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

