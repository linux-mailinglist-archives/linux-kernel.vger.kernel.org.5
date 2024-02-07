Return-Path: <linux-kernel+bounces-55872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2584C2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4451DB277FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1084101E6;
	Wed,  7 Feb 2024 02:53:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53CF9EA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274412; cv=none; b=n1qgQ+2IlO4fCmXI223ROdhezWTri4nKO7/RnLhydyd6LufxesoZKxPoxCQMTKcI35GhJjosgtrTM4JYSb5nZix1ZX7JQIOwwCAZ7B1U/v6yiYIs5cL81HxIHNTTDU1He8oLFef794i03ZEcTju/GH7iYVi+hYOzmlcTxIbGZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274412; c=relaxed/simple;
	bh=rXuLxq8PMLFa/N3kCZkK8FMCTXhxqbXE66cROn4QaEk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nCP4omBApg2hH3ZHumJh+K4j992e0obNfXdVw+e47q9FVGjcOXQQujC30qCWf3sVBiLr45rdPYMdWVC2jkupxCSLkElM1MYUkxc73xZ6VxlkeXGTIm9amEQKdm+kS14WT+wAb7TI7+xDcR5rGVCY9rtFlnW7gG01vPZAsIEII6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf36117dfbso20228539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 18:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707274409; x=1707879209;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMQDtUTDEkh0XYMSCWcCDXuGoNKijaPNFCa9l/60NMs=;
        b=DSO3k/QimUqwB1LLn4OX90K8mYFly24ZEOz0BxreOb76K9jW+JlFx9RX4MRUDqM0JH
         +YDmlfZ5o7zq63VPrH2L7er6S3xgXy/T4wVzED2Vsme9gTLxM4VhHNlBj5SW3Hj9Wl/6
         1BmsktxHip9tvOqp51ErJHZTwTkV2XW3smxBkLZPQjSuGXc6iI7+U64JD5azBg70cw1O
         QlwC16Y+7ej+8q7g7F9JEZsYaFIABaQ+EHdiWyQxmf+Ss5483xC8dzep1MvYiMH/S8Jm
         wwOFzhQOu5KqyovEOUlCxjb3HIgfVBmCrYGLM/TnCC2D9o7zAbj21l8A0ko5E5iRw7Sx
         +Ibg==
X-Forwarded-Encrypted: i=1; AJvYcCVayDdq85U4FkeQ54M2F3MIUltQlxCA2/zyPbEeHZ+XVpVM2CT9ekIusW3eqElvd+AKLCU4a7UAa6SHjt3022YJS7HqdnBkw79Yhf85
X-Gm-Message-State: AOJu0Yy5Kh+J3YRPOJenNVpLGYggRcz7EcO5q5UBVRmK+4MyXfaJx/Qx
	jWRlrVcy4RXBu98wKv72JZvmmfdeNAuoC1tklObGyZr5ODYJ2f6uecQKxk3piiRE5Z7JHbenMlz
	Wc7hNymUrNCf8QZILT9VxMy6sJrbXn0FA5EJwxjAEQe5AxjFD9c58dBc=
X-Google-Smtp-Source: AGHT+IG1sN5kgtXH8FdMHqwG99f6ZisVtn4XVYnF1if5YGFZ6rSO75G/8CT84cwjna6KL6GLPzHdp09cgtLW2qETBg2VsHI0XQsA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411a:b0:471:4445:42f1 with SMTP id
 ay26-20020a056638411a00b00471444542f1mr129894jab.4.1707274409475; Tue, 06 Feb
 2024 18:53:29 -0800 (PST)
Date: Tue, 06 Feb 2024 18:53:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b602300610c1ccb0@google.com>
Subject: [syzbot] [ceph?] [net?] INFO: task hung in ceph_monc_stop
From: syzbot <syzbot+388fe6c0b08b54d6d8f9@syzkaller.appspotmail.com>
To: ceph-devel@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	idryomov@gmail.com, jlayton@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109a7ccbe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=388fe6c0b08b54d6d8f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157cf5b0180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103ae618180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dece45d1a4b5/disk-076d56d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4921e269b178/vmlinux-076d56d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a9156da9091/bzImage-076d56d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+388fe6c0b08b54d6d8f9@syzkaller.appspotmail.com

INFO: task syz-executor388:5228 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor388 state:D stack:25328 pid:5228  tgid:5228  ppid:5095   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17df/0x4a40 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6804 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6819
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2159
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3617
 ceph_monc_stop+0x7c/0x1e0 net/ceph/mon_client.c:1248
 ceph_destroy_client+0x74/0x130 net/ceph/ceph_common.c:768
 destroy_fs_client+0x192/0x270 fs/ceph/super.c:899
 deactivate_locked_super+0xc4/0x130 fs/super.c:477
 ceph_get_tree+0x9a9/0x17b0 fs/ceph/super.c:1361
 vfs_get_tree+0x90/0x2a0 fs/super.c:1784
 vfs_cmd_create+0xe4/0x230 fs/fsopen.c:230
 __do_sys_fsconfig fs/fsopen.c:476 [inline]
 __se_sys_fsconfig+0x967/0xec0 fs/fsopen.c:349
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fa0aaddda39
RSP: 002b:00007ffeca02e718 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa0aaddda39
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00000000000a06e0 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeca02e72c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
1 lock held by kworker/u4:4/79:
 #0: ffff8880b943c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
2 locks held by getty/4824:
 #0: ffff88802aa2e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
1 lock held by syz-executor388/5228:
 #0: ffff888023aa6070 (&fc->uapi_mutex){+.+.}-{3:3}, at: __do_sys_fsconfig fs/fsopen.c:474 [inline]
 #0: ffff888023aa6070 (&fc->uapi_mutex){+.+.}-{3:3}, at: __se_sys_fsconfig+0x8e6/0xec0 fs/fsopen.c:349

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfb0/0xff0 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 79 Comm: kworker/u4:4 Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:load_new_mm_cr3+0x164/0x210 arch/x86/mm/tlb.c:300
Code: ff 07 00 00 73 56 41 f7 c5 00 08 00 00 75 5e 41 ff c5 41 0f b7 c5 48 09 c1 48 b8 00 00 00 00 00 00 00 80 48 09 c8 0f 22 d8 5b <41> 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 0f 0b 90 eb a6 90 0f
RSP: 0018:ffffc900020df650 EFLAGS: 00000046
RAX: 0000000014c6e000 RBX: 0000000000000001 RCX: ffff888017bd9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900020df770 R08: ffffffff8141cf6c R09: 1ffff1100298e0c4
R10: dffffc0000000000 R11: ffffed100298e0c5 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888014c6e000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559e76ed7600 CR3: 0000000014c6e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 switch_mm_irqs_off+0x7c1/0xae0
 use_temporary_mm arch/x86/kernel/alternative.c:1810 [inline]
 __text_poke+0x713/0xd30 arch/x86/kernel/alternative.c:1921
 text_poke arch/x86/kernel/alternative.c:1985 [inline]
 text_poke_bp_batch+0x8cd/0xb30 arch/x86/kernel/alternative.c:2374
 text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2494
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
 static_key_enable+0x1a/0x20 kernel/jump_label.c:218
 toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
 process_one_work kernel/workqueue.c:3049 [inline]
 process_scheduled_works+0x913/0x14f0 kernel/workqueue.c:3125
 worker_thread+0xa60/0x1000 kernel/workqueue.c:3206
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.423 msecs


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

