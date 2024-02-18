Return-Path: <linux-kernel+bounces-70575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5185995B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1501C20CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348957317B;
	Sun, 18 Feb 2024 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tBBVBKCu"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CFE1DFF2;
	Sun, 18 Feb 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708289298; cv=none; b=j8XmYaY14f9RIoyNPPT8bKaxM3+wY9cKknQa7dA87ksY+qEF2ZOhc2RxDnfsdkunm2l0+zmWor7t3duwdIfY4eD9agf3uQW1T33TVpBzGAIfTQ07eKO4AVx4RKFD1af+IFTE0jn/Wx200HgXRfM4c5ffgbGpkEnTFA/w+VRfBRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708289298; c=relaxed/simple;
	bh=9bATrPaJgYzxYTDKfJzf/TKaYtgSOETUcC55meCckb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrXXLEEQVZBJwkFrT/Bf8ERuBFN3IGThwm4+NFVK1wk/JQ/EpdJywaPxk6aSj3yqsvbLYBBksWwFMxNEOo5cD9TSVFGTtpOE+g7JJWTMCX/01Kk4fSPWrE/1OngCJXGfjI13moGYH/2TekI7EIGcTNcmQvzwP4SVFoOIZM96Hw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tBBVBKCu; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708289297; x=1739825297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIV67kZg4QlKSP3VyemACoH9wt5kljwpXBkMuGulQMU=;
  b=tBBVBKCui0k7ng4q1PS+/cJrcj+mzkMBFSwO8i6458fjm41Mu+scZKZX
   drtrQL6RX8vFEUPSjDcXaqsaIBLCaxwn+/8Eo2TT+uQE964yiQjw8vwFP
   cpwwqFhEKbQGATJAWmnkLMao9EEN+r6K/GBEdBrvUanV4cMqEeHJFde0C
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,169,1705363200"; 
   d="scan'208";a="274069731"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 20:48:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:18880]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.209:2525] with esmtp (Farcaster)
 id b90e66ec-0e54-49da-99b6-61789e1e1639; Sun, 18 Feb 2024 20:48:14 +0000 (UTC)
X-Farcaster-Flow-ID: b90e66ec-0e54-49da-99b6-61789e1e1639
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 18 Feb 2024 20:48:14 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 18 Feb 2024 20:48:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com>
CC: <asml.silence@gmail.com>, <axboe@kernel.dk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] INFO: task hung in unix_stream_sendmsg
Date: Sun, 18 Feb 2024 12:48:02 -0800
Message-ID: <20240218204802.51284-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <00000000000073a1b90611a37e67@google.com>
References: <00000000000073a1b90611a37e67@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com>
Date: Sun, 18 Feb 2024 00:09:19 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    71b605d32017 net: phy: aquantia: add AQR113 PHY ID
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1107270c180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=970c7b6c80a096da
> dashboard link: https://syzkaller.appspot.com/bug?extid=ecab4d36f920c3574bf9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a0522c180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1557b752180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4e43093a84c4/disk-71b605d3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f0cccd84c6e5/vmlinux-71b605d3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/581c58b8f080/bzImage-71b605d3.xz
> 
> The issue was bisected to:
> 
> commit 25236c91b5ab4a26a56ba2e79b8060cf4e047839
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Fri Feb 9 22:04:53 2024 +0000
> 
>     af_unix: Fix task hung while purging oob_skb in GC.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177f209c180000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14ff209c180000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10ff209c180000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ecab4d36f920c3574bf9@syzkaller.appspotmail.com
> Fixes: 25236c91b5ab ("af_unix: Fix task hung while purging oob_skb in GC.")
> 
> INFO: task syz-executor397:5487 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc4-syzkaller-01028-g71b605d32017 #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor397 state:D stack:26800 pid:5487  tgid:5487  ppid:5066   flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_timeout+0xb0/0x310 kernel/time/timer.c:2159
>  do_wait_for_common kernel/sched/completion.c:95 [inline]
>  __wait_for_common kernel/sched/completion.c:116 [inline]
>  wait_for_common kernel/sched/completion.c:127 [inline]
>  wait_for_completion+0x354/0x620 kernel/sched/completion.c:148
>  __flush_work+0x950/0xad0 kernel/workqueue.c:3410
>  unix_stream_sendmsg+0x1c3/0xe60 net/unix/af_unix.c:2264
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f4cfb950b39
> RSP: 002b:00007ffd1e7e2758 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4cfb950b39
> RDX: 0000000000008001 RSI: 00000000200015c0 RDI: 0000000000000004
> RBP: 000000000001bf72 R08: 0000000000000006 R09: 0000000000000006
> R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffd1e7e276c
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
>  #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
>  #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
> 2 locks held by kworker/u4:8/2784:
> 1 lock held by syslogd/4503:
>  #0: ffff8880b953c958 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
> 2 locks held by getty/4822:
>  #0: ffff8880304f90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002efe2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc4-syzkaller-01028-g71b605d32017 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
>  watchdog+0xfaf/0xff0 kernel/hung_task.c:379
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 2784 Comm: kworker/u4:8 Not tainted 6.8.0-rc4-syzkaller-01028-g71b605d32017 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Workqueue: events_unbound __unix_gc
> RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
> Code: 89 fb e8 23 00 00 00 48 8b 3d 84 f5 1a 0c 48 89 de 5b e9 43 26 57 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0d 90 52 70 7e 65 8b 15 91 52 70
> RSP: 0018:ffffc9000a17fa78 EFLAGS: 00000287
> RAX: ffffffff8a0a6108 RBX: ffff88802b6c2640 RCX: ffff88802c0b3b80
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> RBP: ffffc9000a17fbf0 R08: ffffffff89383f1d R09: 1ffff1100ee5ff84
> R10: dffffc0000000000 R11: ffffed100ee5ff85 R12: 1ffff110056d84ee
> R13: ffffc9000a17fae0 R14: 0000000000000000 R15: ffffffff8f47b840
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffef5687ff8 CR3: 0000000029b34000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  __unix_gc+0xe69/0xf40 net/unix/garbage.c:343
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
>  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.061 msecs
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

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git 25236c91b5ab4a26a56ba2e79b8060cf4e047839

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 51acf795f096..fa39b6265238 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -322,9 +322,17 @@ static void __unix_gc(struct work_struct *work)
 	 * which are creating the cycle(s).
 	 */
 	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link)
+	list_for_each_entry(u, &gc_candidates, link) {
 		scan_children(&u->sk, inc_inflight, &hitlist);
 
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+		if (u->oob_skb) {
+			kfree_skb(u->oob_skb);
+			u->oob_skb = NULL;
+		}
+#endif
+	}
+
 	/* not_cycle_list contains those sockets which do not make up a
 	 * cycle.  Restore these to the inflight list.
 	 */
@@ -339,18 +347,6 @@ static void __unix_gc(struct work_struct *work)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	while (!list_empty(&gc_candidates)) {
-		u = list_entry(gc_candidates.next, struct unix_sock, link);
-		if (u->oob_skb) {
-			struct sk_buff *skb = u->oob_skb;
-
-			u->oob_skb = NULL;
-			kfree_skb(skb);
-		}
-	}
-#endif
-
 	spin_lock(&unix_gc_lock);
 
 	/* All candidates should have been detached by now. */


