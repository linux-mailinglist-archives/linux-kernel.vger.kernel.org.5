Return-Path: <linux-kernel+bounces-136043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42A89CF50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478F71F22144
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F95E3C24;
	Tue,  9 Apr 2024 00:24:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EC7E9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622270; cv=none; b=hWAVWK84RiwXImeGtqmui3dVgi/e4yce/dwZPK59G/0hv6gplv1/K/JGrVtEo17YCp9EoILNlfS5euUamTckymOlcAbHylVol1EUbZqk40pcjYmPHVEOU66QfMO70tE5OjVcZMfHC8ULMQ0KWaLk2rv4iudygnlYwWN4k7wvKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622270; c=relaxed/simple;
	bh=dC6xtOxP5KS5RLDMbnSFrG/7OHFy7zHcuxyFYTPbYMc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dka01EtXD3oTtnUtQh7c0YAauw6+DLTYvIIPOYTp72suDsqCb7NDEItIP/FTfMil9QvlvIMOA1eyIbtPMNpfzjtxkAyeno4O3TabaHGtFApm9trvu+JNz2j8Htu5C7FLHstQorH1WV3k0+6yr9y2pJJae2cd02VxVTF1vDRwgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d5db4db530so248557839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 17:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622268; x=1713227068;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqqphGxKGTlfGO+avG/t+jpfkcZEzB/oypFCv6i7ITY=;
        b=c7w4H0rMeprsG0ai2e+mlUJCVdbZ4zNyTjq36DWE9XEwwolJQhpMaMB54ODsSrqKAM
         qOQxwbdqpomqMfB3WKr6m5yhPCbzDZqe6DDr8Ixt4Dv0zJhsSMnsA/FqWfJ+vn8wsI6B
         ybbwuae3V0GUoR3ATqXfsXDexpYaJ/t/JJbz10porUPYW1eiPxTfRnVlBlQlgWn9Upf8
         YYTzawdcYkwRyPkH08FyN+jd71lRd8HtLQPSRnj/mhKibBpdVJWQ4Wan595kFlir+xN+
         GT1Lj/qoBezd92pHIiXCot6k7d8N1Y/hcORYLOthgdHXvhhJTuPqNLaZgcx2F6txZVXP
         Iz5g==
X-Gm-Message-State: AOJu0YwDYWvuO1nuQSnxIOzI+jsO9eGbUxPtvrWYm2bdXOsfUH7leQ2q
	d8LTrru763vVHaDbVGrICLbVDZG629mAkkts+fBFdkBgj4XI83uKYjeoCbuU+BHrdJLvSZ/2l5o
	SX9/NOWOISGKh+xONC1SOwgILyULHXYFdHpkSsnxr3cU6WzznoDzdMGjvRQ==
X-Google-Smtp-Source: AGHT+IHqZI8/QUXS393tyITF+mL4EV4nO5d1G6Avpavq8ccEU77Y/Obt8bFNK4wL8HQOouW/gva0MQbEF9YxwM4IKjZ2Sg+wFehe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c7:b0:47b:f666:f7e5 with SMTP id
 l7-20020a05663814c700b0047bf666f7e5mr610848jak.6.1712622268357; Mon, 08 Apr
 2024 17:24:28 -0700 (PDT)
Date: Mon, 08 Apr 2024 17:24:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0aed206159ef199@google.com>
Subject: [syzbot] [sound?] INFO: rcu detected stall in snd_timer_user_release (2)
From: syzbot <syzbot+3e603db0222a2db35117@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1190cda9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=3e603db0222a2db35117
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150e7e75180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ff3a9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e603db0222a2db35117@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 ticks this GP) idle=6cdc/1/0x4000000000000000 softirq=5910/5910 fqs=0
rcu: 	(detected by 0, t=10502 jiffies, g=6389, q=12 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5087 Comm: syz-executor228 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:lock_acquire+0x9e/0x530 kernel/locking/lockdep.c:5722
Code: ec 03 48 b8 f1 f1 f1 f1 00 f2 f2 f2 4b 89 04 2c 43 c7 44 2c 09 f2 f2 f2 00 43 c7 44 2c 11 f3 f3 f3 f3 66 43 c7 44 2c 15 f3 f3 <43> c6 44 2c 17 f3 0f 1f 44 00 00 65 8b 05 7c 36 92 7e 83 f8 08 0f
RSP: 0018:ffffc90000a08a40 EFLAGS: 00000806
RAX: f2f2f200f1f1f1f1 RBX: ffff888026fff930 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888026fff948
RBP: ffffc90000a08b90 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100f93db16 R12: 1ffff92000141150
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888026fff9a0
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa1e64710d0 CR3: 000000002d3b6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 snd_timer_process_callbacks+0x26e/0x320 sound/core/timer.c:797
 snd_timer_interrupt+0xf02/0x10d0 sound/core/timer.c:919
 snd_hrtimer_callback+0x20b/0x380 sound/core/hrtimer.c:50
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 fe 49 79 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> a3 f1 e5 f5 65 8b 05 f4 d5 84 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc90003b47940 EFLAGS: 00000206
RAX: 6bc00ddc6210a000 RBX: 1ffff92000768f2c RCX: ffffffff81720c2a
RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: 0000000000000001
RBP: ffffc90003b479d0 R08: ffffffff92ce1587 R09: 1ffffffff259c2b0
R10: dffffc0000000000 R11: fffffbfff259c2b1 R12: dffffc0000000000
R13: 1ffff92000768f28 R14: ffffc90003b47960 R15: 0000000000000246
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 snd_timer_stop1+0x7d9/0x930 sound/core/timer.c:660
 snd_timer_stop sound/core/timer.c:710 [inline]
 snd_timer_close_locked+0x217/0x8c0 sound/core/timer.c:408
 snd_timer_close sound/core/timer.c:463 [inline]
 snd_timer_user_release+0x129/0x2d0 sound/core/timer.c:1524
 __fput+0x429/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fa1e63f8db9
Code: Unable to access opcode bytes at 0x7fa1e63f8d8f.
RSP: 002b:00007fff8aadfdd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa1e63f8db9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fa1e64732b0 R08: ffffffffffffffb8 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000246 R12: 00007fa1e64732b0
R13: 0000000000000000 R14: 00007fa1e6473d20 R15: 00007fa1e63c9f50
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.887 msecs
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g6389 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=2760
rcu: rcu_preempt kthread starved for 10502 jiffies! g6389 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:26256 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17d3/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2572
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

