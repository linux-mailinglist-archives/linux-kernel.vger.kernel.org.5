Return-Path: <linux-kernel+bounces-49896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B65084711C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C991F2353F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237147A53;
	Fri,  2 Feb 2024 13:26:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41724776E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880390; cv=none; b=H4xBkmSGwaMPWO+XolQqbEfnAOwgy9/PUOf+seJ1XgrgMYVbeJdQCmvHZk4FlBimqQOl1xCrxIUFhRVECwGnBd0u6+6Lk2o8Tx/Ftfepg1zXhPwgqeKYfFPEtIQDaTkCX5nZG2LBslxCIC2YwLrQ3PUOooA9911fV6aYb4ltshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880390; c=relaxed/simple;
	bh=rZUItvUy42628+VUh8ZdC9wLv5M5dfSKVc3zge5/VKE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bjvrwOK80KNlX/RWawxa6MS4eYqOcQowcT1ru9xhxjaLUeNn8tfSLMGPO8CL97+XIiNG7k5XSseLBZJ0E9ONSRo1JpT99/GXbhxFZgBTL/9+GIZu6Gtg6Dq9H3gv6ZZJNI8rnbwbtUnR94xMhSdbgra9tiNm0gI4HcPHAAbWyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363b161279aso5913575ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 05:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706880388; x=1707485188;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq3gE8L2F0+AWJlNCpBN/xvpjBEAx1qKhvkQOqtnNzQ=;
        b=A9B7JGgO9J0RZ3WQu+pq8R9Q/i9/OHw3TVLnMQEKOd1tT8eHfhMxo+nxXoIuNuj76S
         hvyiC2+fsN2b5CmzEVVMSB57PzX/LY/EtjJDmWEFJ9/YzChNDWvZU6TnD1On4W3Hwd7N
         lmnyQHfLhM39J1yEqwm/dImUMAgvarSqyOb3bt3HFJvAHhatUHnD2/z9dHTx/kH5NQU7
         JTFWefG5Dz9ACLeBcOnPUFxnMg3KBPNmUlJ/1rOeUbnaEeVvNtEPsZKVcp9ZwHoBVXhG
         I4PAgpBu8KAzfi2coplqtPD3qlar7ZSLBIcAzpvom2uUmbomsX/WPZsmpoJLzhnaUwVX
         DLBQ==
X-Gm-Message-State: AOJu0YwuS9jlLfl11rbgp08r7e0j8NVyrk1NYEFTtttQvvE/8bfoAw4i
	qtQrqGmq3YKtfP8nSSFUIq2U8TvQS1z/V6dbSKlukJEKav3nn+Ry7+VrE90LTi0C++2cuWX9F2C
	iIfgqlMA1uN9BstgICvPtLoaNGXhNOq1HhvIvBvTfrGDuSupczo9zwsU=
X-Google-Smtp-Source: AGHT+IFOZBjXi1sEWeED2C/wD/aODxFJ/2YPaIx+09DCJLd7+GfzFDtUtLm0DUEXof22VcewpQYg5y+NcJPJBIUokfs5pzCrmXit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:35f:eb20:3599 with SMTP id
 s10-20020a056e02216a00b0035feb203599mr134384ilv.2.1706880387890; Fri, 02 Feb
 2024 05:26:27 -0800 (PST)
Date: Fri, 02 Feb 2024 05:26:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031c6c50610660f17@google.com>
Subject: [syzbot] [net?] [s390?] possible deadlock in smc_release
From: syzbot <syzbot+621fd56ba002faba6392@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    41bccc98fb79 Linux 6.8-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16b3a953e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165642dfe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1431092fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/00fc8ba1cd49/disk-41bccc98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15fd4e4ee5f8/vmlinux-41bccc98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/13be3add2183/bzImage-41bccc98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+621fd56ba002faba6392@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor225/5062 is trying to acquire lock:
ffff8880218893f8 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}, at: __flush_work+0xfa/0xa10 kernel/workqueue.c:3406

but task is already holding lock:
ffff888021888130 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at: smc_release+0x3a3/0x640 net/smc/af_smc.c:336

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_SMC/1){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3524
       smc_listen_out+0x1e7/0x4b0 net/smc/af_smc.c:1914
       smc_listen_out_connected net/smc/af_smc.c:1934 [inline]
       smc_listen_work+0x56e/0x5190 net/smc/af_smc.c:2448
       process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
       process_scheduled_works kernel/workqueue.c:2706 [inline]
       worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
       kthread+0x2c6/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

-> #0 ((work_completion)(&new_smc->smc_listen_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2445/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
       __flush_work+0x103/0xa10 kernel/workqueue.c:3406
       __cancel_work_timer+0x3ef/0x590 kernel/workqueue.c:3497
       smc_clcsock_release+0x5f/0xe0 net/smc/smc_close.c:29
       __smc_release+0x5b9/0x890 net/smc/af_smc.c:301
       smc_close_non_accepted+0xda/0x230 net/smc/af_smc.c:1846
       smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
       smc_close_active+0xc2d/0x1070 net/smc/smc_close.c:225
       __smc_release+0x62b/0x890 net/smc/af_smc.c:277
       smc_release+0x209/0x640 net/smc/af_smc.c:344
       __sock_release+0xae/0x260 net/socket.c:659
       sock_close+0x1c/0x20 net/socket.c:1421
       __fput+0x270/0xb70 fs/file_table.c:376
       task_work_run+0x14d/0x240 kernel/task_work.c:180
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xa8a/0x2ad0 kernel/exit.c:871
       do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
       __do_sys_exit_group kernel/exit.c:1031 [inline]
       __se_sys_exit_group kernel/exit.c:1029 [inline]
       __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x63/0x6b

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_SMC/1);
                               lock((work_completion)(&new_smc->smc_listen_work));
                               lock(sk_lock-AF_SMC/1);
  lock((work_completion)(&new_smc->smc_listen_work));

 *** DEADLOCK ***

2 locks held by syz-executor225/5062:
 #0: ffff8880791f6210 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #0: ffff8880791f6210 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release+0x86/0x260 net/socket.c:658
 #1: ffff888021888130 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at: smc_release+0x3a3/0x640 net/smc/af_smc.c:336

stack backtrace:
CPU: 1 PID: 5062 Comm: syz-executor225 Not tainted 6.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x317/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2445/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __flush_work+0x103/0xa10 kernel/workqueue.c:3406
 __cancel_work_timer+0x3ef/0x590 kernel/workqueue.c:3497
 smc_clcsock_release+0x5f/0xe0 net/smc/smc_close.c:29
 __smc_release+0x5b9/0x890 net/smc/af_smc.c:301
 smc_close_non_accepted+0xda/0x230 net/smc/af_smc.c:1846
 smc_close_cleanup_listen net/smc/smc_close.c:45 [inline]
 smc_close_active+0xc2d/0x1070 net/smc/smc_close.c:225
 __smc_release+0x62b/0x890 net/smc/af_smc.c:277
 smc_release+0x209/0x640 net/smc/af_smc.c:344
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1421
 __fput+0x270/0xb70 fs/file_table.c:376
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8804a8bc09
Code: Unable to access opcode bytes at 0x7f8804a8bbdf.
RSP: 002b:00007ffcbc267b78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8804a8bc09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f8804b062d0 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007f8804b062d0
R13: 0000000000000000 R14: 00007f8804b06d20 R15: 00007f8804a5ce60
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

