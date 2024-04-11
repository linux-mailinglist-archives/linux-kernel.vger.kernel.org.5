Return-Path: <linux-kernel+bounces-141451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93B8A1E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3251C2341F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E8F13792B;
	Thu, 11 Apr 2024 18:07:36 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C714D5AA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858856; cv=none; b=mDEmI4S8nfziXco9GlhPqXUO8Ru+myYMu8luQiYI5BnnQRmFywEW4oLPjeI1Bnd66dIOiZYoNe8ClO7xFlMC3XLoRTufO1neQy0KWGfA0UkuFsO5Di4FafBJKE6HoOunsSA1vVZfcPq2Zz6Q5PC26e52BrJ5+wHiAL5EEve346M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858856; c=relaxed/simple;
	bh=MsMlsdSq47Yk6dx2TNPOAxIFD+rS0FTMwbEajVrZuaw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o4b40eZE4J2bkOrKmoGV95V0DQam2ulSw+LevjzUXepuMWME6AjwMSKoqqE5aD7WE8RotdKzrpg6+AC739mmPG66JMNZeZds7bCAz5z5zlJoDx0KvrfTCcZoNFgwqn6afHjxLoKiJOPNiacW0iMi+fLN1aIqa1N//xnZByhrt38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5dbc0e4b3so7607839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858854; x=1713463654;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMLutmDNFAekhD1OdqE8AAG8IxfKETrCJBx80Cj4cLY=;
        b=C0ne4/d4uKUsXYnFDMC+pIGK0UQwlGecTjb8CCTeN/yHuuL0nssUkR8KORkMQuKJ0+
         nMeFvW49KfxEgmJwZ1pBVfvPfiB9zcj75vvfxdwpBu6b0tnLyAGUGZf06BwFuhy5umef
         haOF38cF/MG7fw5Ehdv/PRvnOX4xE/MFO/7HEiCOKIn3e64WywbfNEQ2kg9o9V+B/XoA
         /Bw28tv+tLSomfdZ7UokVQ0gXiceC5BWNEEsmwiRJzcbfefKrMofqZMwYvSpVnkdrO+Z
         3PFhnQNXED2CpYXtSQQB5l8v5Uxe4YYuTNkKXce0QtaF+JTVdXsuA52CmCvQSWoRKnIV
         L+nA==
X-Gm-Message-State: AOJu0YxdUprLX4vHeJdN+v4IH7RJN1Rou/LC+T5fsCFHYo9m60nE0fkV
	1bg9NW8dcmiYKEnZgHZPz63WIM6VofeGqFYiv+zNJc73IoCr1ZGDW2m2uGEK07dUG0OuB6fs6Vq
	fFg6Q20jrIf9BUagg2sgMdnNgnbT85BV1qhSDtdYBSSkmfCHfByHIqvg=
X-Google-Smtp-Source: AGHT+IFvT1qDXxxtoROMgy9Bu4Bn/Nw43/S9Rj/eW044k4adq6xyKLFDfU5TRx5+yxFQ7jyIX3fjquXq4Br2/Xipl6gs32lrciUd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8910:b0:482:c4cd:4798 with SMTP id
 jc16-20020a056638891000b00482c4cd4798mr1555jab.4.1712858853979; Thu, 11 Apr
 2024 11:07:33 -0700 (PDT)
Date: Thu, 11 Apr 2024 11:07:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ac77c0615d60760@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in sys_wait4 (4)
From: syzbot <syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dda955180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=6969434de600a6ba9f07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1091a5f6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22c13180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6969434de600a6ba9f07@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 ticks this GP) idle=e314/1/0x4000000000000000 softirq=5879/5879 fqs=0
rcu: 	(detected by 1, t=10505 jiffies, g=6797, q=86 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5083 Comm: syz-executor176 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__raw_spin_lock_irq include/linux/spinlock_api_smp.h:120 [inline]
RIP: 0010:_raw_spin_lock_irq+0xd7/0x120 kernel/locking/spinlock.c:170
Code: bf 01 00 00 00 e8 69 e1 e5 f5 49 8d 7c 24 18 31 f6 31 d2 31 c9 41 b8 01 00 00 00 45 31 c9 ff 75 08 e8 1d 90 f2 f5 48 83 c4 08 <4c> 89 e7 e8 c1 f0 f3 f5 48 c7 04 24 0e 36 e0 45 4b c7 04 2f 00 00
RSP: 0018:ffffc90000007cc0 EFLAGS: 00000096
RAX: c05eb13d16091700 RBX: 1ffff92000000f9c RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8baad360 RDI: ffffffff8bfed300
RBP: ffffc90000007d50 R08: ffffffff92ce550f R09: 1ffffffff259caa1
R10: dffffc0000000000 R11: fffffbfff259caa2 R12: ffff8880b942c8c0
R13: 1ffff92000000f98 R14: ffffc90000007ce0 R15: dffffc0000000000
FS:  000055556b411380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556b411ca8 CR3: 000000002dd76000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __run_hrtimer kernel/time/hrtimer.c:1696 [inline]
 __hrtimer_run_queues+0x65a/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x109/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 4e 39 79 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> f3 e0 e5 f5 65 8b 05 44 c5 84 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc900042f7b40 EFLAGS: 00000206
RAX: c05eb13d16091700 RBX: 1ffff9200085ef6c RCX: ffffffff944dd603
RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: 0000000000000001
RBP: ffffc900042f7bd8 R08: ffffffff8f873a6f R09: 1ffffffff1f0e74d
R10: dffffc0000000000 R11: fffffbfff1f0e74e R12: dffffc0000000000
R13: 1ffff9200085ef68 R14: ffffc900042f7b60 R15: 0000000000000246
 do_wait+0x16e/0x540 kernel/exit.c:1627
 kernel_wait4+0x2a7/0x3e0 kernel/exit.c:1790
 __do_sys_wait4 kernel/exit.c:1818 [inline]
 __se_sys_wait4 kernel/exit.c:1814 [inline]
 __x64_sys_wait4+0x134/0x1e0 kernel/exit.c:1814
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f6df57cd893
Code: fe ff e9 41 ff ff ff 31 c9 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 80 3d 11 f8 07 00 00 49 89 ca 74 14 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5d c3 0f 1f 40 00 48 83 ec 28 89 54 24 14 48
RSP: 002b:00007ffe2065f398 EFLAGS: 00000202 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f6df57cd893
RDX: 0000000040000001 RSI: 00007ffe2065f3bc RDI: 00000000ffffffff
RBP: 00000000000f4240 R08: 0000000000000010 R09: 00007f6df578b0b0
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffe2065f3f0
R13: 00000000000306b6 R14: 00007ffe2065f3bc R15: 0000000000000003
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.866 msecs
rcu: rcu_preempt kthread timer wakeup didn't happen for 10504 jiffies! g6797 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=7994
rcu: rcu_preempt kthread starved for 10505 jiffies! g6797 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:25400 pid:16    tgid:16    ppid:2      flags:0x00004000
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

