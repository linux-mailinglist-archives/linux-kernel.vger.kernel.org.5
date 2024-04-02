Return-Path: <linux-kernel+bounces-128477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F91895B5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE931C22606
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C9715AACF;
	Tue,  2 Apr 2024 18:05:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36115A4BF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081134; cv=none; b=INLcGgX3EFuse2dEvutYUendVqHMt4bjYOr8lDh5zCcEVA1BSjoHcT8bzFiDLYU53qQA2KOMSZYjhe2hisJzDjdMVilkkXOjQfPDQOtcuqpXtSNeNQGgAi+ryl0Jp8tZi1/a3Nf3aXhZ+qtT4cLJDNy++/wi2Y6wp05hd7nZIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081134; c=relaxed/simple;
	bh=dkXQJP9gSp0LDBiscX5mx2dCkiLN5f8Yrt8fZ2cyQ/4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Me3iid+GVWBjbQ3ECQdr6wO8YgOQbhT+aSlQmmYq3vgl9p8JBJ3fNbtawQnRsPbrD73JONpdcz8NrY/HRKokLhaUJkF25fsI1V//RisCaV+z0R7p8aEZhvUWNDNb195fTosdaSYEi6jQkfQ1JKXaVikkRsQhj9FSfn+eI2ojJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf092a502so579896039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 11:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081132; x=1712685932;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fgn+HgfxTrwm3YOBIeLknr7d/C8EDy3eOMNmQ6Kchk0=;
        b=UDDU5hK8olPyx3KCYimVgI2yu6Vm2TMk/XqVm2bqKD7EJ/zboY/t30P3XEDiJfszqM
         NxY3S/YWy4YcEbwRmWTfrLMMgZB0utHA4pmGGLVromJzjNfnm9nj20b2+X3wdRChuv20
         vaP0eSL049h96Wvr9vFyQKA89Jq5lD04/f9qtpYAUY+StenfYtLNLawZ2/LDxJaSbrll
         FsibqmMhy6yd6jawfxn8o59HkXE0Zs1OltnzKOy/nj2zT0a/e5i75bl1dXft7HBc6pLf
         1OkKZhjbxD6XdrtVdjiCx1J4nKATKBWd8oNZJEe5byTV+51vdY6Kayf4v6Q96cxb5Zgb
         d5iQ==
X-Gm-Message-State: AOJu0Yw8DkRKA9LRrKBg+2zvYVmY4f9NKNeSlRQHjiPyTgobjdfKjts1
	5N+94QvU4UpTfZLNjUg6NX4NMXGvbJ0MHyPqWqV95G4imWfyK7ThZ77sYXISr0/Yc60it9blgnB
	fi0lTnrrkKysu0NXvW7B9V0mVm9ga7MYtcTdtpi+fvgP/rLyA3oVt1yTrhA==
X-Google-Smtp-Source: AGHT+IET7COpMwygSkjwekzFT7E4b9NFTwqdDC69UepXdwQnUMw79V3CHBx4m39A5WWQXheKB4OtgYNsEIcRwP65nnmHHUIb/ok5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1543:b0:7cc:558:ee68 with SMTP id
 h3-20020a056602154300b007cc0558ee68mr588841iow.1.1712081131944; Tue, 02 Apr
 2024 11:05:31 -0700 (PDT)
Date: Tue, 02 Apr 2024 11:05:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b24903061520f3e9@google.com>
Subject: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
From: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15f64776180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
dashboard link: https://syzkaller.appspot.com/bug?extid=dce04ed6d1438ad69656
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f00471180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
-----------------------------
kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by ksoftirqd/0/16:
 #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid include/linux/mmzone.h:2019 [inline]
 #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: __virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65

stack backtrace:
CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 rcu_softirq_qs+0xd9/0x370 kernel/rcu/tree.c:273
 __do_softirq+0x5fd/0x980 kernel/softirq.c:568
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:debug_lockdep_rcu_enabled+0xd/0x40 kernel/rcu/update.c:320
Code: f5 90 0f 0b 90 90 90 eb c6 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d c7 0f 28 04 00 <74> 1e 83 3d 26 42 28 04 00 74 15 65 48 8b 0c 25 c0 d3 03 00 31 c0
RSP: 0018:ffffc90000157a50 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcae740 RDI: ffffffff8c1f7ec0
RBP: dffffc0000000000 R08: ffffffff92f3a527 R09: 1ffffffff25e74a4
R10: dffffc0000000000 R11: fffffbfff25e74a5 R12: 0000000029373578
R13: 1ffff9200002af64 R14: ffffffff814220f3 R15: ffff88813fff90a0
 rcu_read_lock_sched include/linux/rcupdate.h:934 [inline]
 pfn_valid include/linux/mmzone.h:2019 [inline]
 __virt_addr_valid+0x1a9/0x520 arch/x86/mm/physaddr.c:65
 kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
 __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526
 __call_rcu_common kernel/rcu/tree.c:3096 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3200
 context_switch kernel/sched/core.c:5412 [inline]
 __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	90                   	nop
   2:	0f 0b                	ud2
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	eb c6                	jmp    0xffffffcf
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	f3 0f 1e fa          	endbr64
  21:	31 c0                	xor    %eax,%eax
  23:	83 3d c7 0f 28 04 00 	cmpl   $0x0,0x4280fc7(%rip)        # 0x4280ff1
* 2a:	74 1e                	je     0x4a <-- trapping instruction
  2c:	83 3d 26 42 28 04 00 	cmpl   $0x0,0x4284226(%rip)        # 0x4284259
  33:	74 15                	je     0x4a
  35:	65 48 8b 0c 25 c0 d3 	mov    %gs:0x3d3c0,%rcx
  3c:	03 00
  3e:	31 c0                	xor    %eax,%eax


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

