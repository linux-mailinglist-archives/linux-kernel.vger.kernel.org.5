Return-Path: <linux-kernel+bounces-139245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2CD8A005D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1B0B2A3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62653181331;
	Wed, 10 Apr 2024 19:08:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203EB18131D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776103; cv=none; b=ui3PlpXcV169PFyrwSeKq61WgSq/5GMnPrVF2Nhf9LNI+LgEMQNXUHk8d2PSe3ysxVTM/HNhId8Gb04l3Sibx2ucpWz5Cs99hg86rV5nGEi/9fSCDKNc7j0owFw/Kvrz4LWDeth4QEHvgXRi5Jx5e3tJp+OEpqiPJrZ+95kmLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776103; c=relaxed/simple;
	bh=HT1XZJR/qlc0XkxYHH+3aFuCWQVQf8MogU1h9aS4uCI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HsZEeoWwNOffnUHvbLfJOAtIwEyluue6e97VLWjitTRBEpy1dyA/eCTMXHSmqoyZY4JusjyEOSGBaWkYS/+JaEmQhrZehB3fKkSJ+mVe2Jg7kz/xR9GE2BDR0KccyjTcQ0zZlyX5UP9AXwrMxRem0dGx7MQ2dxM2VAsD3Y5jcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d65ffc786fso64253839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712776101; x=1713380901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OnTsP4jmC5XfWpSMcsV7u4wY4+L80ZlzQHyjEq4B1jg=;
        b=lbyJ62d0jAtz8qGORqFRotdPcvJYEsevj4MceadGOM5X7zYzmjHrE0ooTTmYlyVQIy
         fvqngJDZRNq/NXykjjWb+RvfIeCdwf5WjGOIBKgA/+0vAl3gLaQU2jTzb/XfaqyzRhJA
         skriGrNHhjXmdsvTleMiatVn2P+O5dDrVlWB748z/UqvhZ04evSdqKTu8NmIdu17/Vqy
         X+ZQfNcMoDuZpb76WUPPcVZIb0XUzNkj2lAZSipSS9Y3ofEqUMG0W12PFUpAPWkq5Yfz
         WSbsxQb747xTMODe94LzImjzqiRLifKVuiVptydOY6dKEtv8LPxY99ForIZ4dKda4rQD
         lK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsmMMvoKFVC8oaPcoG6T4bEWoMOmnkeySxtk6ZLMrDcIS/TMZxCAG28nBXNx16rZHVeTsPgfZQtgSXHcnHjfdI2UMua9dRirGTDOig
X-Gm-Message-State: AOJu0YxNkdylR/qClEmCa6lO+TQIOVFV+h/JlxjcPum0Rf3jK/q2nBNa
	gtbYpPpkc0WSntsnM78o4JDr4si2yZPM5Rqs4aMw3mjli6bL9S7nt8+xpeXrgtKxoxTa1LqEljT
	pwctf+P5xpPRCC770QjlHCzzO2ILlz0Ac/ULkaYCycV5hUQsCGhyaa2A=
X-Google-Smtp-Source: AGHT+IE/PtQO+4WxksgQ2s8Y3z7q1ivVK9c0RxVpktDXlgHNcM2eGpN+U3CweVNAjn07XB/Nxt4dmqelGdVhv/ofiZI5CTQNX05c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e96:b0:482:8ae4:639f with SMTP id
 ch22-20020a0566383e9600b004828ae4639fmr92557jab.1.1712776101176; Wed, 10 Apr
 2024 12:08:21 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:08:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001734c60615c2c35e@google.com>
Subject: [syzbot] [kernel?] WARNING in __mod_timer (2)
From: syzbot <syzbot+85c55d5ba79e862d9f10@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e12923180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=85c55d5ba79e862d9f10
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85c55d5ba79e862d9f10@syzkaller.appspotmail.com

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 9339 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:

CPU: 1 PID: 9339 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d bd 16 05 04 00 74 06 90 c3 cc cc cc cc c6 05 ae 16 05 04 01 90 48 c7 c7 e0 b9 aa 8b e8 88 34 ec f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90000a089b8 EFLAGS: 00010246

RAX: f1cc9c4c319efc00 RBX: 1ffff9200014113c RCX: ffff888021afda00
RDX: 0000000080000101 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000a08a50 R08: ffffffff8157cb22 R09: 1ffff110172a51a2
R10: dffffc0000000000 R11: ffffed10172a51a3 R12: dffffc0000000000
R13: 1ffff92000141138 R14: ffffc90000a089e0 R15: 0000000000000246
FS:  00005555950bb480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31f21000 CR3: 000000002cc6c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x120/0x140 kernel/locking/spinlock.c:194
 __mod_timer+0xb89/0xeb0 kernel/time/timer.c:1186
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2408 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2419
 run_timer_base kernel/time/timer.c:2428 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:sched_update_worker kernel/sched/core.c:6799 [inline]
RIP: 0010:schedule+0x182/0x320 kernel/sched/core.c:6829
Code: 23 00 74 d4 48 89 ef e8 2c 33 80 f6 eb ca 4c 8d 75 2c 4d 89 f5 49 c1 ed 03 43 0f b6 44 25 00 84 c0 0f 85 06 01 00 00 41 8b 06 <a9> 30 00 00 20 74 7c a9 00 00 00 20 74 5c 49 89 ef 49 81 c7 70 12
RSP: 0018:ffffc900034e7be8 EFLAGS: 00000246

RAX: 0000000000400040 RBX: 1ffff1100435fb40 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff888021afda00 R08: ffff888062cc0003 R09: 1ffff1100c598000
R10: dffffc0000000000 R11: ffffed100c598001 R12: dffffc0000000000
R13: 1ffff1100435fb45 R14: ffff888021afda2c R15: ffff888021afec70
 do_nanosleep+0x197/0x600 kernel/time/hrtimer.c:2051
 hrtimer_nanosleep+0x227/0x470 kernel/time/hrtimer.c:2104
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep+0x32b/0x3c0 kernel/time/posix-timers.c:1373
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fef2e8a9275
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 f6 b9 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 4f ba ff ff 48 8b 04 24 48 83 c4 28 f7 d8
RSP: 002b:00007ffead8be8f0 EFLAGS: 00000293
 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00007fef2e9abf80 RCX: 00007fef2e8a9275
RDX: 00007ffead8be930 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fef2e9ad980 R08: 0000000000000000 R09: 00007fef2f52e0b0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000038234
R13: ffffffffffffffff R14: 00007fef2e400000 R15: 0000000000037ef3
 </TASK>
----------------
Code disassembly (best guess):
   0:	23 00                	and    (%rax),%eax
   2:	74 d4                	je     0xffffffd8
   4:	48 89 ef             	mov    %rbp,%rdi
   7:	e8 2c 33 80 f6       	call   0xf6803338
   c:	eb ca                	jmp    0xffffffd8
   e:	4c 8d 75 2c          	lea    0x2c(%rbp),%r14
  12:	4d 89 f5             	mov    %r14,%r13
  15:	49 c1 ed 03          	shr    $0x3,%r13
  19:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
  1f:	84 c0                	test   %al,%al
  21:	0f 85 06 01 00 00    	jne    0x12d
  27:	41 8b 06             	mov    (%r14),%eax
* 2a:	a9 30 00 00 20       	test   $0x20000030,%eax <-- trapping instruction
  2f:	74 7c                	je     0xad
  31:	a9 00 00 00 20       	test   $0x20000000,%eax
  36:	74 5c                	je     0x94
  38:	49 89 ef             	mov    %rbp,%r15
  3b:	49                   	rex.WB
  3c:	81                   	.byte 0x81
  3d:	c7                   	(bad)
  3e:	70 12                	jo     0x52


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

