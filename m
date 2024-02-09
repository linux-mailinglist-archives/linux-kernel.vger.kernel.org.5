Return-Path: <linux-kernel+bounces-59871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B142184FCC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7111F2652A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A05E84A36;
	Fri,  9 Feb 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H4bl0PLB"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8D54F86;
	Fri,  9 Feb 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506713; cv=none; b=S1zQIGpATry3Te8lAjdMs0hSUQgJHnBIqd/Ij86XfydLrp7ZAhnGXPjKg0kI3Pmie+y5E1l3gO7qMl0TaYm3VuJWtj3XNdskCGvYaZjByRjxVsUi8+qpxB94BL6d0ogYNLirZMvfX4RvlmN9S60FLSpJ2u7kST/69yzDKnZyO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506713; c=relaxed/simple;
	bh=ytm1lnDs8dOQPwX1R9RylvsegFDTYx4xbxouZWJ+hAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BM0k6YbgkH9s80hDk9+w72PKZU9oEEz0pkYcT8oJvIl19IOSJxit4101cwDLFAhY3wqTNOIL226+GymQgdeNoW6w/fv/E5RRSWnAABJbYCGv7d2p34isNyGO4exEJKK31WMuUaVbWZE2NB4K76qkHewarHqg7L4Mux+nVX8S/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H4bl0PLB; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707506711; x=1739042711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ytplo0DieVvzLJRpVZ47jk6dUm0eYeo5cHOCfRB7TM=;
  b=H4bl0PLBk3b621lB9w5TtFgUchajcl/KFA2+WVOWjeyfSRe09AfewjHs
   cyYfGfd4YP1T5ruYV5AFW1vNjMYV13SXWV9LZgCdBL8EKPXsyOrhaAG05
   cbXXNenKPNiu8BaE98RatpU9ABRSqZF3ojXFdrlJ8F1sMHbiDuK04oPKB
   A=;
X-IronPort-AV: E=Sophos;i="6.05,257,1701129600"; 
   d="scan'208";a="65019850"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 19:25:09 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:27201]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.24:2525] with esmtp (Farcaster)
 id 89753254-d6aa-4047-a676-a4bb68ce7c9d; Fri, 9 Feb 2024 19:25:09 +0000 (UTC)
X-Farcaster-Flow-ID: 89753254-d6aa-4047-a676-a4bb68ce7c9d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 19:25:08 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 19:25:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com>
CC: <asml.silence@gmail.com>, <axboe@kernel.dk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] INFO: task hung in unix_dgram_sendmsg
Date: Fri, 9 Feb 2024 11:24:54 -0800
Message-ID: <20240209192454.81559-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <00000000000067de160610f791be@google.com>
References: <00000000000067de160610f791be@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com>
Date: Fri, 09 Feb 2024 11:02:22 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1f719a2f3fa6 Merge tag 'net-6.8-rc4' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a21d04180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=53985487b59d9442
> dashboard link: https://syzkaller.appspot.com/bug?extid=4fa4a2d1f5a5ee06f006
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1636f042180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141c0cec180000

I'll look into it.

Thanks.

> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b8bd7b1c1c4d/disk-1f719a2f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/58ee6966cdfc/vmlinux-1f719a2f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3de15662a476/bzImage-1f719a2f.xz
> 
> The issue was bisected to:
> 
> commit 1279f9d9dec2d7462823a18c29ad61359e0a007d
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Sat Feb 3 18:31:49 2024 +0000
> 
>     af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e71d7c180000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14171d7c180000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10171d7c180000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com
> Fixes: 1279f9d9dec2 ("af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.")
> 
> INFO: task klogd:4499 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc3-syzkaller-00136-g1f719a2f3fa6 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:klogd           state:D stack:26360 pid:4499  tgid:4499  ppid:1      flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0xf12/0x5c60 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0xe9/0x280 kernel/sched/core.c:6817
>  wait_for_unix_gc+0x192/0x200 net/unix/garbage.c:201
>  unix_dgram_sendmsg+0x10e/0x1d10 net/unix/af_unix.c:1924
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x47f/0x4e0 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f52bb0e69b5
> RSP: 002b:00007ffc4e4eb038 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f52bb0e69b5
> RDX: 0000000000000058 RSI: 000055b5f9c3e420 RDI: 0000000000000003
> RBP: 000055b5f9c382c0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
> R13: 00007f52bb274212 R14: 00007ffc4e4eb138 R15: 0000000000000000
>  </TASK>
> INFO: task dhcpcd:4723 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc3-syzkaller-00136-g1f719a2f3fa6 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:dhcpcd          state:D stack:26384 pid:4723  tgid:4723  ppid:1      flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0xf12/0x5c60 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0xe9/0x280 kernel/sched/core.c:6817
>  wait_for_unix_gc+0x192/0x200 net/unix/garbage.c:201
>  unix_dgram_sendmsg+0x10e/0x1d10 net/unix/af_unix.c:1924
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  sock_write_iter+0x50a/0x5c0 net/socket.c:1160
>  call_write_iter include/linux/fs.h:2085 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0x6de/0x1110 fs/read_write.c:590
>  ksys_write+0x1f8/0x260 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f09e4d40bf2
> RSP: 002b:00007ffdd90b9f68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000055f6a34d4030 RCX: 00007f09e4d40bf2
> RDX: 0000000000000047 RSI: 00007ffdd90b9f80 RDI: 0000000000000005
> RBP: 00007ffdd90b9f80 R08: 0000000000000008 R09: 0000000000000036
> R10: 0000000000000000 R11: 0000000000000246 R12: 000055f6a22eeefc
> R13: 00007ffdd90ba3b0 R14: 000055f6a35abbb0 R15: 0000000000000001
>  </TASK>
> INFO: task udevd:5066 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc3-syzkaller-00136-g1f719a2f3fa6 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:udevd           state:D stack:26920 pid:5066  tgid:5066  ppid:4510   flags:0x00000006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0xf12/0x5c60 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0xe9/0x280 kernel/sched/core.c:6817
>  wait_for_unix_gc+0x192/0x200 net/unix/garbage.c:201
>  unix_dgram_sendmsg+0x10e/0x1d10 net/unix/af_unix.c:1924
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  sock_write_iter+0x50a/0x5c0 net/socket.c:1160
>  call_write_iter include/linux/fs.h:2085 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0x6de/0x1110 fs/read_write.c:590
>  ksys_write+0x1f8/0x260 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f5dea316bf2
> RSP: 002b:00007ffe87a832d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5dea316bf2
> RDX: 0000000000000000 RSI: 00007ffe87a8332f RDI: 000000000000000a
> RBP: 00007ffe87a8332f R08: 0000000000000001 R09: bff9cdc4d7b79566
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000a
> R13: 00007f5dea6d7ae0 R14: 0000000000000000 R15: 0000564f4f9ec2c0
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8d7ad160 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
>  #0: ffffffff8d7ad160 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
>  #0: ffffffff8d7ad160 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
> 2 locks held by getty/4820:
>  #0: ffff88802b6b90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
>  #1: ffffc900015d02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfca/0x1490 drivers/tty/n_tty.c:2201
> 1 lock held by syz-executor236/5065:
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc3-syzkaller-00136-g1f719a2f3fa6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
>  watchdog+0xf87/0x1210 kernel/hung_task.c:379
>  kthread+0x2c6/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 5065 Comm: syz-executor236 Not tainted 6.8.0-rc3-syzkaller-00136-g1f719a2f3fa6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
> RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> RIP: 0010:__sanitizer_cov_trace_pc+0xd/0x60 kernel/kcov.c:207
> Code: cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 14 25 40 c2 03 00 <65> 8b 05 b4 7c 78 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74
> RSP: 0018:ffffc900033efa58 EFLAGS: 00000283
> RAX: ffff88807b077800 RBX: ffff88807b077800 RCX: 1ffffffff27b1189
> RDX: ffff88802a5a3b80 RSI: ffffffff8968488d RDI: ffff88807b077f70
> RBP: ffffc900033efbb0 R08: 0000000000000001 R09: fffffbfff27a900c
> R10: ffffffff93d48067 R11: ffffffff8ae000eb R12: ffff88807b077800
> R13: dffffc0000000000 R14: ffff88807b077e40 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000564f4fc1e3a8 CR3: 000000000d57a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  unix_gc+0x563/0x13b0 net/unix/garbage.c:319
>  unix_release_sock+0xa93/0xf80 net/unix/af_unix.c:683
>  unix_release+0x91/0xf0 net/unix/af_unix.c:1064
>  __sock_release+0xb0/0x270 net/socket.c:659
>  sock_close+0x1c/0x30 net/socket.c:1421
>  __fput+0x270/0xb80 fs/file_table.c:376
>  task_work_run+0x14f/0x250 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xa8a/0x2ad0 kernel/exit.c:871
>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
>  __do_sys_exit_group kernel/exit.c:1031 [inline]
>  __se_sys_exit_group kernel/exit.c:1029 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1029
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f9d6cbdac09
> Code: Unable to access opcode bytes at 0x7f9d6cbdabdf.
> RSP: 002b:00007fff5952feb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9d6cbdac09
> RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
> RBP: 00007f9d6cc552b0 R08: ffffffffffffffb8 R09: 0000000000000006
> R10: 0000000000000006 R11: 0000000000000246 R12: 00007f9d6cc552b0
> R13: 0000000000000000 R14: 00007f9d6cc55d00 R15: 00007f9d6cbabe70
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.801 msecs
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

