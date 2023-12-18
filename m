Return-Path: <linux-kernel+bounces-3856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45F817408
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC581C2404A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0042373;
	Mon, 18 Dec 2023 14:44:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576531D132
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fb35e557cso7299995ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910667; x=1703515467;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdr6Pd6fw7LwaclRYgeuilcUVrKfZtWFz2t88DKZ0NI=;
        b=kCllUbGXKg73cPCfReiUdaQPskCSSqp2y3AK0oN8cicTbIr7cdMqqQS9rj08CtxNdU
         +HInLUkfRT2m6znxkD6pBCHljLp1rm2jcJlXNM0CD5M4Ni2i5ycbf7WeS0qebnkQlnyb
         IVBsriRdVEtJS0YE8uZxVAyUd23YVu2qxhWCmGM4OKw/eN9ea3btrLXxV0/KFCr2ecNs
         asIGLDfo+tgXaclwc4gArTq6ZoMOk0KZRJ2DUJC/hUcb9I9efyy2meA2uooqwYDXe1xb
         cg1k1WBw4S878FmfvEpj0J+RFK6AY5jlhSrudFFtfvTWzBqQcvsCHJ+ECb0k7Sfs2xbX
         SLHA==
X-Gm-Message-State: AOJu0Yz3YeEfkkRXxoF8/WD4wEYG6Z/HBpsKhhZGVx7HEZqtoqRQ1o/E
	AjFbPvrWV57d+ybTpYNi0BHWZwdyDy2vNh7iAdT02DU5P13I
X-Google-Smtp-Source: AGHT+IGC2DsvykjQgFi/Ot2UUh+mgeRJ/M+aNJMfMK9gO0Xelzd3z5hT6tLut5jE8/g0nbuSjdepDNC4tzwKP54KFstgCUhw36WQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:35f:90ab:8d91 with SMTP id
 i14-20020a056e0212ce00b0035f90ab8d91mr802994ilm.1.1702910667500; Mon, 18 Dec
 2023 06:44:27 -0800 (PST)
Date: Mon, 18 Dec 2023 06:44:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bb5b5060cc9c999@google.com>
Subject: [syzbot] [net?] INFO: task hung in addrconf_verify_work (8)
From: syzbot <syzbot+e6b87f5edf5469e359e9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1dfc0f76231 net: phy: skip LED triggers on PHYs on SFP mo..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=113bc4d6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=e6b87f5edf5469e359e9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11611749e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1629b876e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fcd0802bfd92/disk-b1dfc0f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3d9e5ecc7f0/vmlinux-b1dfc0f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b04f82a5ed6/bzImage-b1dfc0f7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6b87f5edf5469e359e9@syzkaller.appspotmail.com

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc5-syzkaller-00167-gb1dfc0f76231 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:25984 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_verify_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:747
 addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4679
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:1/9:
 #0: ffff888025733538 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2602
 #1: ffffc900000e7d80 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2603
 #2: ffffffff8eaad7a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4679
3 locks held by kworker/1:1/27:
1 lock held by khungtaskd/30:
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by getty/4825:
 #0: ffff8880260860a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
3 locks held by syz-executor383/5095:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.7.0-rc5-syzkaller-00167-gb1dfc0f76231 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5095 Comm: syz-executor383 Not tainted 6.7.0-rc5-syzkaller-00167-gb1dfc0f76231 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:write_comp_data+0x35/0x80 kernel/kcov.c:236
Code: 8b 14 25 c0 bc 03 00 65 8b 05 7f 34 7c 7e a9 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 fc 15 00 00 85 c0 74 4f 8b 82 d8 15 00 00 <83> f8 03 75 44 48 8b 82 e0 15 00 00 8b 92 dc 15 00 00 48 8b 38 48
RSP: 0018:ffffc900040ef360 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00000000fffffff8 RCX: ffffffff8a21a0a0
RDX: ffff888024df8000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff88814b3ba058 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff8 R11: 0000000000000000 R12: ffffc900040ef3c0
R13: ffff88814b3ba098 R14: dffffc0000000000 R15: ffff888021d118c0
FS:  0000555556e1c380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ee31815440 CR3: 0000000079951000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 tipc_udp_is_known_peer+0x110/0x250 net/tipc/udp_media.c:292
 tipc_udp_nl_bearer_add+0x20f/0x2f0 net/tipc/udp_media.c:646
 tipc_nl_bearer_add+0x21b/0x360 net/tipc/bearer.c:1089
 genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:972
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fb2f32cae19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3d73e478 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb2f32cae19
RDX: 0000000000000000 RSI: 0000000020000f00 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.222 msecs


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

