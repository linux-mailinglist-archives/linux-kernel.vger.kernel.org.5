Return-Path: <linux-kernel+bounces-96874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26504876277
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10392844CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D955777;
	Fri,  8 Mar 2024 10:55:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23055C27
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895305; cv=none; b=UzF8iMdhbXuvTzwH9/nazGlAHXWf1UxzUZzPE3ipRnIf1Qnoxv1czUpI5L+kAFhLmvfUa8mEKOmmGyP9E+fQ3gwkhm8dt00ToQnUJC/4DbCA2r8P+cTRqwL0XEhCCyRj05NOuBl2PiymIdRFa09oeBo7F9pSUfHaWhu7BXBurS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895305; c=relaxed/simple;
	bh=ULEUrnVXX8p6saENKgtdLSLGzNiaR9BTHfZ03AWmgvo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y2pqXi8KShsPM7/VtpWD/C+IfqmGW+owAv7FxJR/XTSIXSTqUc5jqrZ7OYk3RzaxFN7JaQmT9wsBcn1bZQsPz5rYBJyw/ZeyuTfdf9tH/9bg6k5rmJ69yfse9qu6TgoAsKpiJRb5HALS4BluoUlCiWMjylKrGSSh3dvfUAKA6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8371ac855so61118839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895303; x=1710500103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbXuNxkW4f9CF4qtQSPT2hIJGpFmqcd6n7D/+7VR3sM=;
        b=YYdtRMswHPqABEKwILOZmEOh3A8mtL8R6bvjxgElyLLQeV7Yhm52/ZUiMIpXzmXH1q
         VCDZ+cWNXSks7wuuiLvieyvloLxjixGqIkmP6Q4bh5ULpyqtWwaUa9sbwNCTDHuTpLYG
         MWquc7oKPTZBHeJ130ahJ34y5MkxW+0B7VJ4VJAmhEX8f1NKJu+31IDHOZDO/LXOa5N+
         sNJ4C6eNPQXsZ7FX7diNWESzeoLgJkldzoraD9W4dRnNhQuxgClu+ABWeWtO4bvhm4CU
         vs0m6xoSSx5qACpKX4G85XRhLjbeke2k+3XifwQNZUTzY8xleV4aBA2IRprcsg6XoKac
         J1wA==
X-Forwarded-Encrypted: i=1; AJvYcCVq28vEGGpo6NPGL17jXwefcVw2SJo1XpgtJsMvRL75jGHiWjA/ENbqf+ze/Kag3y03xGJR7GlTORTTypjj5es6A3OjBUGD8SLWB6d1
X-Gm-Message-State: AOJu0Yx5xYjMFcafJxm96bH24WnM7l38ifcPmuXZLtu9SQ8iYvV1Zggb
	Wu6jIy8AvrWkvi97PMrTZPqbhNMQ6Va7xMFDZoSgIxKXbvzttWvTODC5kiImDuGsEUXEyIV+ByM
	8EyQZtqfWMPsJHaYi+ceqj5iptqt2yveTT/UJqC1G6LZdhbyE3KQLW/c=
X-Google-Smtp-Source: AGHT+IExgd6mYGWJWErv8YllSOGlRujxPiCZAZHua74MHP8eM68xnWW4ocUK67llBZKeFk726/e4tl0KrLGNYof2KQTZw3zFjAKn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1686:b0:7c8:4874:5eea with SMTP id
 s6-20020a056602168600b007c848745eeamr331797iow.0.1709895303125; Fri, 08 Mar
 2024 02:55:03 -0800 (PST)
Date: Fri, 08 Mar 2024 02:55:03 -0800
In-Reply-To: <20240308103336.1587-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000256de906132406d3@google.com>
Subject: Re: [syzbot] [usb] INFO: rcu detected stall in syscall_exit_to_user_mode
 (2)
From: syzbot <syzbot+a68ef3b1f46bc3aced5c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in worker_thread

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P42/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=11789, q=668 ncpus=2)
task:kworker/u4:2    state:R  running task     stack:22848 pid:42    tgid:42    ppid:2      flags:0x00004000
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7047
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:348
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x25a/0x530 kernel/locking/lockdep.c:5758
Code: 2b 00 74 08 4c 89 f7 e8 04 75 84 00 f6 44 24 61 02 0f 85 8e 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90000b2f9c0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000165f44 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8baac7e0 RDI: ffffffff8bfe6da0
RBP: ffffc90000b2fb10 R08: ffffffff92c8d427 R09: 1ffffffff2591a84
R10: dffffc0000000000 R11: fffffbfff2591a85 R12: 1ffff92000165f40
R13: dffffc0000000000 R14: ffffc90000b2fa20 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 rcu_read_lock include/linux/rcupdate.h:750 [inline]
 batadv_nc_process_nc_paths+0xd6/0x3a0 net/batman-adv/network-coding.c:687
 batadv_nc_worker+0x42a/0x610 net/batman-adv/network-coding.c:728
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x915/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
rcu: rcu_preempt kthread starved for 10535 jiffies! g11789 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:23864 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_timeout+0x1bd/0x310 kernel/time/timer.c:2183
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5658 Comm: syz-executor.3 Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
RIP: 0010:static_key_false include/linux/jump_label.h:207 [inline]
RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:147 [inline]
RIP: 0010:wrmsr arch/x86/include/asm/msr.h:254 [inline]
RIP: 0010:native_apic_msr_write+0x39/0x50 arch/x86/include/asm/apic.h:195
Code: 74 2a 83 ff 30 74 25 eb 10 81 ff d0 00 00 00 74 1b 81 ff e0 00 00 00 74 13 c1 ef 04 81 c7 00 08 00 00 89 f9 89 f0 31 d2 0f 30 <66> 90 e9 60 43 33 0a f3 0f 1e fa 89 f6 31 d2 e9 73 6d 9b 03 0f 1f
RSP: 0018:ffffc900001f0e68 EFLAGS: 00000046
RAX: 000000000004d432 RBX: 0000000000000020 RCX: 0000000000000838
RDX: 0000000000000000 RSI: 000000000004d432 RDI: 0000000000000838
RBP: 000000000004d432 R08: ffffffff81850879 R09: 1ffffffff1f0ad85
R10: dffffc0000000000 R11: ffffffff813dad70 R12: 00000000004d426b
R13: dffffc0000000000 R14: 0000000010002696 R15: ffff8880b9528340
FS:  00007fdd9db536c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdd9db52f00 CR3: 0000000029a14000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 apic_write arch/x86/include/asm/apic.h:401 [inline]
 lapic_next_event+0x11/0x20 arch/x86/kernel/apic/apic.c:448
 clockevents_program_event+0x1c3/0x350 kernel/time/clockevents.c:334
 hrtimer_interrupt+0x54a/0x990 kernel/time/hrtimer.c:1828
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x109/0x3a0 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x92/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 da 5c ff f5 48 89 df e8 92 9c 00 f6 e8 5d bc 28 f6 fb bf 01 00 00 00 <e8> 62 6d f2 f5 65 8b 05 e3 dd 91 74 85 c0 74 06 5b e9 71 40 00 00
RSP: 0018:ffffc90009967c70 EFLAGS: 00000282
RAX: 7a78bd9c4bd32000 RBX: ffff888028141280 RCX: ffffffff94485303
RDX: dffffc0000000000 RSI: ffffffff8baab660 RDI: 0000000000000001
RBP: ffffc90009967db0 R08: ffffffff8f856c2f R09: 1ffffffff1f0ad85
R10: dffffc0000000000 R11: fffffbfff1f0ad86 R12: 1ffff110050282e3
R13: 000000001c000004 R14: 0000000000000021 R15: ffff888028141718
 spin_unlock_irq include/linux/spinlock.h:401 [inline]
 get_signal+0x156d/0x1850 kernel/signal.c:2896
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc8/0x360 kernel/entry/common.c:212
 do_syscall_64+0x108/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fdd9ce7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd9db530c8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00007fdd9cfabf80 RCX: 00007fdd9ce7dda9
RDX: 000000002006b000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fdd9ceca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdd9cfabf80 R15: 00007ffd320bad98
 </TASK>
sched: RT throttling activated
hrtimer: interrupt took 1020224749 ns


Tested on:

commit:         3aaa8ce7 Merge tag 'mm-hotfixes-stable-2024-03-07-16-1..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14aeada6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=165e1d0fff4d3c47
dashboard link: https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1053695a180000


