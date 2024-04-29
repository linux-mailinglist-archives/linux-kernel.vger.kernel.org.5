Return-Path: <linux-kernel+bounces-162849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C683D8B6155
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA10284107
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241DD13B7A7;
	Mon, 29 Apr 2024 18:46:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FFB13AD3D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416393; cv=none; b=MvTwyyW/0XZf2qVAwYv0VRUIyc9pC+6binypgJU3srW5Klm+lfjPQBNYoF2Z00cDQOBu/zUitdoK5ru1qkPvgzKmvn7ADhMjmFz1CuBgZwWrj2Sa7ahovUq8Qd/8AMksJ+uojHXbACfpKyKeDxSscuZv4fDxt/IzWNECYsFBO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416393; c=relaxed/simple;
	bh=E6nEDOURzan/s99ngaZ55VFRv+NYSUB2csvrJCDBJco=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hFKF6IkECMTZloU+tjAFpvITnGHqkaXQ2pO+mmxCKKI9SS2G4GAev0KBmMGGP41IxpPGrx7UYJEiSPXSHqdBF9KxY/q12gpsVlSppe1j89xul54OtL7bXUMxzwSISGtlkkRbSs7FgtjarZ3sXZoXFXh1iT3oGQ4drf0PUPipz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so396058539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416391; x=1715021191;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQUVSGDgQ3BY7pRuv3m1CWYAlTc+q68tm3HIk6GMcS8=;
        b=YskejQhcqpdgZE5g02DpZe/QqGs/3fL8HaADkliIponRFTZ2EJbLUyYBjAxYjGWtsU
         Oy4wMld5f5dULPAyT8zFNsblWVVyZn57EbPQ3rFLjHtVx+kb4/PiK4kn727h08gQPaio
         rDMDtBRP4ct7hA1Gau2jYzAtdFyHv1WitReqSP5g8U47YO/L11RmUFh3ycrF3fqPqrd8
         Pja5Hly4khJjN7/xe24jEhysi+1oVwNy3j4/jufu3y5VXhVP9jH5fmCe1mLETmRGTL6e
         Iv8ne6lqkUjgf+U5xfSlPShbtqXCLAN1/x/1lhE0Mz5btZUop8buIPLEiC82QzXe78zZ
         N5LQ==
X-Gm-Message-State: AOJu0YwTvzczCFqPtuaW+IpCX3D0D0evzDxFk7iaRNscY2jrecnWZGgO
	i56kpWvnSoJzA4JM94u1JOGiJ8SNnK10t7HsObruOIFWP0rVjNpFO2Cr2P21XerBZ9cmpgraGE6
	h34iR9YTtqnIWfkcVRU6FgVmlgcqAep/WWAZ/W+5nMp4ztDE+M9yiB4I=
X-Google-Smtp-Source: AGHT+IHVbpqrSCcG5rRIK7+RozEDVP3BceosW4yJXfj/mNjizeVdiPnZvj38e/XKk2eak1+j9nM5hbmyTlSNtw9TRUTzJPGlONcx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d95:b0:7de:da38:b7df with SMTP id
 k21-20020a0566022d9500b007deda38b7dfmr16771iow.0.1714416390892; Mon, 29 Apr
 2024 11:46:30 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:46:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa00a1061740ab6d@google.com>
Subject: [syzbot] [sound?] INFO: rcu detected stall in snd_timer_user_release (3)
From: syzbot <syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1343b727180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=43120c2af6ca2938cc38
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15aef608980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1039c208980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f00739ef493d/disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5ab311a2b65/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d097344a5b6/bzImage-e88c4cfc.xz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b6e6d8980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b6e6d8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b6e6d8980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43120c2af6ca2938cc38@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 GPs behind) idle=477c/1/0x4000000000000000 softirq=6170/6171 fqs=0
rcu: 	(detected by 0, t=10502 jiffies, g=7293, q=28 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5111 Comm: syz-executor278 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:get_bucket lib/debugobjects.c:492 [inline]
RIP: 0010:debug_object_activate+0x13a/0x510 lib/debugobjects.c:706
Code: 8b 43 fd 48 8b 44 24 18 48 89 84 24 80 00 00 00 45 31 e4 80 3d aa 57 f2 0a 00 0f 85 b7 02 00 00 e8 eb 03 00 00 4c 89 7c 24 10 <49> c1 ef 0c 48 b9 eb 83 b5 80 46 86 c8 61 49 0f af cf 48 c1 e9 2f
RSP: 0018:ffffc90000a08c00 EFLAGS: 00000046
RAX: a301fc934e8fa400 RBX: ffffc90000a08c70 RCX: ffffc90000a08903
RDX: 0000000000000003 RSI: ffffffff8bcaca20 RDI: ffffffff8c1f9760
RBP: ffffc90000a08d18 R08: ffffffff8fa8fdaf R09: 1ffffffff1f51fb5
R10: dffffc0000000000 R11: fffffbfff1f51fb6 R12: 0000000000000000
R13: 1ffff92000141188 R14: dffffc0000000000 R15: ffff88801aadbc88
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2070b46d33 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 debug_hrtimer_activate kernel/time/hrtimer.c:423 [inline]
 debug_activate kernel/time/hrtimer.c:478 [inline]
 enqueue_hrtimer+0x30/0x3c0 kernel/time/hrtimer.c:1090
 __run_hrtimer kernel/time/hrtimer.c:1709 [inline]
 __hrtimer_run_queues+0x6d5/0xd50 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 2e bb 6f f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> b3 fe da f5 65 8b 05 24 2b 79 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc900022ef940 EFLAGS: 00000206
RAX: a301fc934e8fa400 RBX: 1ffff9200045df2c RCX: ffffffff8172edda
RDX: dffffc0000000000 RSI: ffffffff8bcab8a0 RDI: 0000000000000001
RBP: ffffc900022ef9d0 R08: ffffffff92f34587 R09: 1ffffffff25e68b0
R10: dffffc0000000000 R11: fffffbfff25e68b1 R12: dffffc0000000000
R13: 1ffff9200045df28 R14: ffffc900022ef960 R15: 0000000000000246
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 class_spinlock_irqsave_destructor include/linux/spinlock.h:574 [inline]
 snd_timer_stop1+0x7e6/0x950 sound/core/timer.c:634
 snd_timer_stop sound/core/timer.c:679 [inline]
 snd_timer_close_locked+0x223/0x8d0 sound/core/timer.c:423
 snd_timer_close sound/core/timer.c:464 [inline]
 snd_timer_user_release+0x138/0x2e0 sound/core/timer.c:1468
 __fput+0x429/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2070b46db9
Code: Unable to access opcode bytes at 0x7f2070b46d8f.
RSP: 002b:00007ffdfb750b08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2070b46db9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f2070bc12b0 R08: ffffffffffffffb8 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000246 R12: 00007f2070bc12b0
R13: 0000000000000000 R14: 00007f2070bc1d20 R15: 00007f2070b17f50
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.845 msecs
rcu: rcu_preempt kthread starved for 10502 jiffies! g7293 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:23704 pid:16    tgid:16    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6838
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2582
 rcu_gp_fqs_loop+0x2df/0x1370 kernel/rcu/tree.c:1663
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:1862
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 PID: 1106 Comm: kworker/u8:7 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
RIP: 0010:smp_call_function_many_cond+0x1894/0x2a00 kernel/smp.c:855
Code: 45 8b 65 00 44 89 e6 83 e6 01 31 ff e8 15 db 0b 00 41 83 e4 01 49 bc 00 00 00 00 00 fc ff df 75 07 e8 c0 d6 0b 00 eb 38 f3 90 <42> 0f b6 04 23 84 c0 75 11 41 f7 45 00 01 00 00 00 74 1e e8 a4 d6
RSP: 0018:ffffc90004d676e0 EFLAGS: 00000293
RAX: ffffffff818a2abc RBX: 1ffff110172a8869 RCX: ffff888022bb9e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90004d678e0 R08: ffffffff818a2a8b R09: 1ffffffff25e68a0
R10: dffffc0000000000 R11: fffffbfff25e68a1 R12: dffffc0000000000
R13: ffff8880b9544348 R14: ffff8880b943f7c0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2070b9101d CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

