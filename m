Return-Path: <linux-kernel+bounces-152862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA978AC55A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B1F1C21DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C969D51031;
	Mon, 22 Apr 2024 07:20:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE99502B6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770424; cv=none; b=LbKIMyrU0Mb5JbdQ6ERVJCsf+GN+CceDWKROpTeRx8Cr0UwVfvAZR8UjLGzq2u5oX86SvBirOLEVsx0wrrjyKPdPIAEWNeT5j39CJgje8kstIMP6ztELXu1MnfcVHE/ED+/RCSL135E11UI7/qRVfLqhFMgbKSbEQnSMIAw45GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770424; c=relaxed/simple;
	bh=AdeJsEOAMTzJhFDgYYiZ8pdUbJ+2r4M99cV0iDb0+/Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jqstP7+jUMbxz+0n86XjVdxWOCoKO5/Kpi1Wraui/nUD0rhr9rhZ/XqcQv42dwmfiVha3J6OVS9EPIvevuXX3tCkIN58BCc9CsHctvLeU/GqhMNlNCuoDVBOQwFdOE7TJnQ5HtggIPxdbxWT28UgKbG1KXKZ/KTyPHfjFYeVGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da41c44e78so428699039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770421; x=1714375221;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpqmMgJ4ByfxvbvXjjLlWRhuBbXpK1CMz74bsVfUqlo=;
        b=hTRaDMoSRKRftMpv2P96jUM9b1w/1ScWDisUriicx/9QwcVHscBzcxVa9qNL/ETJSx
         s3a1mSG+iLmaIbZdSs4f7v0RCS/zjrKJ82JmG/CQT/MV2LYh0dbE7KmHmYxIY4s5ZR2E
         7o7xq86BOQiGB6zMtstQ4boap2Ou7vah3I3Ysx5lTYhHilC/9HCjqrOc/fzvRO90M8p3
         TzosipbtdBji18KQv6CbtsUPUaLgDrYAp3ZbcybrzLW4UV6B211YacONakdp6bcX4XNQ
         /yX9tnd0T4/NaHLnC3/Rf/n5faMcZ8k+Lj7Xqbz2lfn6mz889of7IlIFbwsHwr/yjRmA
         lpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjA6FF0zxK+ofIPcaitnMWwBFe4RDBQWb3ayK1Emu83dbWGCYzmNQ1tbQSYHrtEzcOvzBQ+bso7w98IGA+mTyXJiw41lKBnoRsyHJE
X-Gm-Message-State: AOJu0YzjWeNJSBgrHTxjXo/L610Y1Lx7FzoqAtWvSaUHpXFnkqZrKdtR
	W4b31+JLAM9Ht0UuG7bRuLEmiPk6qog1LDE+EBkKE/isNMcvT/rpCFdvy7rvwr1mrqTa2n/AJTj
	FvmZaX8XZrZrAjGfe/0oSOf1tyG0sv0FCX8fZ3OEvRIcrQ55jS1D9jSQ=
X-Google-Smtp-Source: AGHT+IEGzQ2fabO43dVcI23npLwNId3Wgfcu9nvXu4uiGEmhLXqn5h4zeuGCbfGQ3lmzeHQOuEHPRaSENCVHWh63Euq15e4s9dR9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1652:b0:485:4f60:6017 with SMTP id
 a18-20020a056638165200b004854f606017mr84759jat.6.1713770421576; Mon, 22 Apr
 2024 00:20:21 -0700 (PDT)
Date: Mon, 22 Apr 2024 00:20:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003470d30616aa450a@google.com>
Subject: [syzbot] [perf?] BUG: using __this_cpu_add() in preemptible code in graph_lock
From: syzbot <syzbot+60761fc6ef65e4f00974@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=10755af5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=60761fc6ef65e4f00974
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60761fc6ef65e4f00974@syzkaller.appspotmail.com

BUG: using __this_cpu_add() in preemptible [00000000] code: syz-executor.3/9981
caller is __pv_queued_spin_lock_slowpath+0x945/0xc60 kernel/locking/qspinlock.c:565
CPU: 0 PID: 9981 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
 __pv_queued_spin_lock_slowpath+0x945/0xc60 kernel/locking/qspinlock.c:565
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 lockdep_lock+0x1b0/0x2b0 kernel/locking/lockdep.c:144
 graph_lock+0x5/0x60 kernel/locking/lockdep.c:170
 mark_lock+0x15c/0x350 kernel/locking/lockdep.c:4659
 __lock_acquire+0x116e/0x1fd0 kernel/locking/lockdep.c:5091
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 percpu_down_write+0x57/0x320 kernel/locking/percpu-rwsem.c:229
 bp_constraints_lock+0xdd/0x1c0 kernel/events/hw_breakpoint.c:133
 reserve_bp_slot kernel/events/hw_breakpoint.c:600 [inline]
 register_perf_hw_breakpoint+0x90/0x250 kernel/events/hw_breakpoint.c:718
 hw_breakpoint_event_init+0x8d/0x110 kernel/events/hw_breakpoint.c:958
 perf_try_init_event+0x139/0x3f0 kernel/events/core.c:11668
 perf_init_event kernel/events/core.c:11738 [inline]
 perf_event_alloc+0xeed/0x2130 kernel/events/core.c:12018
 __do_sys_perf_event_open kernel/events/core.c:12525 [inline]
 __se_sys_perf_event_open+0x7f9/0x38d0 kernel/events/core.c:12416
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4f88a7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4f897950c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f4f88babf80 RCX: 00007f4f88a7dea9
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000020000180
RBP: 00007f4f88aca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4f88babf80 R15: 00007fffadfb1b08
 </TASK>

=============================
WARNING: suspicious RCU usage
6.8.0-syzkaller-05236-g443574b03387 #0 Not tainted
-----------------------------
kernel/sched/core.c:5982 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor.3/9981:
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: perf_init_event kernel/events/core.c:11698 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc+0xacf/0x2130 kernel/events/core.c:12018

stack backtrace:
CPU: 0 PID: 9981 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 schedule_debug kernel/sched/core.c:5982 [inline]
 __schedule+0x23b/0x4a20 kernel/sched/core.c:6629
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6915
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6939
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
 unwind_next_frame+0x2124/0x2a00 arch/x86/kernel/unwind_orc.c:672
 __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_trace+0x5a/0xb40 kernel/locking/lockdep.c:582
 mark_lock+0x1d3/0x350 kernel/locking/lockdep.c:4673
 __lock_acquire+0x116e/0x1fd0 kernel/locking/lockdep.c:5091
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 percpu_down_write+0x57/0x320 kernel/locking/percpu-rwsem.c:229
 bp_constraints_lock+0xdd/0x1c0 kernel/events/hw_breakpoint.c:133
 reserve_bp_slot kernel/events/hw_breakpoint.c:600 [inline]
 register_perf_hw_breakpoint+0x90/0x250 kernel/events/hw_breakpoint.c:718
 hw_breakpoint_event_init+0x8d/0x110 kernel/events/hw_breakpoint.c:958
 perf_try_init_event+0x139/0x3f0 kernel/events/core.c:11668
 perf_init_event kernel/events/core.c:11738 [inline]
 perf_event_alloc+0xeed/0x2130 kernel/events/core.c:12018
 __do_sys_perf_event_open kernel/events/core.c:12525 [inline]
 __se_sys_perf_event_open+0x7f9/0x38d0 kernel/events/core.c:12416
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4f88a7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4f897950c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f4f88babf80 RCX: 00007f4f88a7dea9
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000020000180
RBP: 00007f4f88aca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4f88babf80 R15: 00007fffadfb1b08
 </TASK>

=============================
WARNING: suspicious RCU usage
6.8.0-syzkaller-05236-g443574b03387 #0 Not tainted
-----------------------------
kernel/sched/core.c:5982 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor.3/9981:
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: perf_init_event kernel/events/core.c:11698 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc+0xacf/0x2130 kernel/events/core.c:12018

stack backtrace:
CPU: 0 PID: 9981 Comm: syz-executor.3 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 schedule_debug kernel/sched/core.c:5982 [inline]
 __schedule+0x28a/0x4a20 kernel/sched/core.c:6629
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6915
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6939
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:12
 unwind_next_frame+0x2124/0x2a00 arch/x86/kernel/unwind_orc.c:672
 __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_trace+0x5a/0xb40 kernel/locking/lockdep.c:582
 mark_lock+0x1d3/0x350 kernel/locking/lockdep.c:4673
 __lock_acquire+0x116e/0x1fd0 kernel/locking/lockdep.c:5091
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 percpu_down_write+0x57/0x320 kernel/locking/percpu-rwsem.c:229
 bp_constraints_lock+0xdd/0x1c0 kernel/events/hw_breakpoint.c:133
 reserve_bp_slot kernel/events/hw_breakpoint.c:600 [inline]
 register_perf_hw_breakpoint+0x90/0x250 kernel/events/hw_breakpoint.c:718
 hw_breakpoint_event_init+0x8d/0x110 kernel/events/hw_breakpoint.c:958
 perf_try_init_event+0x139/0x3f0 kernel/events/core.c:11668
 perf_init_event kernel/events/core.c:11738 [inline]
 perf_event_alloc+0xeed/0x2130 kernel/events/core.c:12018
 __do_sys_perf_event_open kernel/events/core.c:12525 [inline]
 __se_sys_perf_event_open+0x7f9/0x38d0 kernel/events/core.c:12416
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4f88a7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4f897950c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f4f88babf80 RCX: 00007f4f88a7dea9
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000020000180
RBP: 00007f4f88aca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f4f88babf80 R15: 00007fffadfb1b08
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

