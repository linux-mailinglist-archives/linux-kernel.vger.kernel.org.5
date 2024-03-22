Return-Path: <linux-kernel+bounces-111603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71729886E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C460E285259
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017247F42;
	Fri, 22 Mar 2024 14:23:22 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CB46546
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117401; cv=none; b=ORfhC+D3fY1cgutMFpicZRO2BaU6uGGNShsn+E0GgZk7YrUOMtW3LRuAqGkhr7VN/no0Bf4ftjZ+RnBrM1ua+xrFSAbssN4Cs5i4/eyBrl6KicvTwkK75X3YVgX80WYjrpOzUiCILJck5s1MxaL0CXlq5mTtX+kIp4ZDlKpTuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117401; c=relaxed/simple;
	bh=2+GAX8mF1sd3HHQD8mlqOGIl4Rkh7q+UFoPR9Vlydkk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ma/WRIK5iQEb3KdS+90hbKil0JPv+YLtBZKZESfE2xsBmTMsdf6XeQVnuvYUipy6oRx0DNB/myc2wnR7n5ZJzB9ui29bZNWH8AzcSVKWH2nc3qI39CwMQ7fq1eZ7cCgvdOeKHb7US7MNYBWr1Oe6S8xjyg9wFGM6IwWoY8fFJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36696c9cb23so18929095ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711117399; x=1711722199;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ELuwCSaPf6wI4WdhkwLBd9M2w8F0DWEJlKujSx97tA=;
        b=r2fi9Aa+BxeW8yWwhqMHHUPprxw9MIR3iBzdTMJkD8fDK+94FtiqGIPmLhWaI+J2v+
         GBAx48xN8qS2HhKLuMex2Jc/isAbna+xcY8+2elxaGwQqow8QMQQ1SheCXI6OJAlyoNj
         e3I/1CrSgZWxOxvPRbJn4JNIIEko+1vAyrxHs3zvXU1MU2rKnCp1VUFcQO6vZ4qQ6OSD
         MJAQba+/QUWlLO9k4xjrSvHNtz7l8TNZNfg1OGqaa9RR+IP5K1+Azd91NRuAU6lPQAI1
         9xdYAcUsXvbyL5vQj7tj1uvOeSwY+b/pvL1Ba9x2zO/scyeQ8605esRcHfinFfdLzz3l
         wWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCP2UVe4CEKnCFO6aO5Erq+RBw5IkjhcPcWMyFothW2ugGH++Jlj1Z3nB78q4jB0dJvUDDQqzE/krxEI6vnG39tyJ0FE8WyiCkSbhR
X-Gm-Message-State: AOJu0Yx2QYSQjHLKv9BqBciXP3Fj+LE0+OEVDwKMU0yRExUR7UXpQN2i
	zvGWKb2D7b3xmwV8nHzEL7v9ZaiijxmbIbu+2V8M8gYj5Db+oM8lO8YpWD1H8vh48i4Isld7w1H
	FiEnNql9B1M7M+1hQad8uNdlN1dQ4WTgssTECpxvFcvqxbz7lguAHOVY=
X-Google-Smtp-Source: AGHT+IGGSL3lHMfKNZu7Oa/q4KZ/HEQx9IJJZTURaLq4R2UzsYH8+FCCZDtDm3NukeoYXeJccD35140RXbQw/jCvIGF/zvEDX6Xt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:366:94e2:f17b with SMTP id
 k5-20020a056e02156500b0036694e2f17bmr100472ilu.0.1711117398932; Fri, 22 Mar
 2024 07:23:18 -0700 (PDT)
Date: Fri, 22 Mar 2024 07:23:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb900e061440909c@google.com>
Subject: [syzbot] [tipc?] BUG: soft lockup in do_sock_setsockopt
From: syzbot <syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16d23231180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=10a41dc44eef71aa9450
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126fea6e180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114e4c81180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10a41dc44eef71aa9450@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor178:13146]
Modules linked in:
irq event stamp: 29265101
hardirqs last  enabled at (29265100): [<ffff8000801dae10>] __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
hardirqs last disabled at (29265101): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (29265101): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (638): [<ffff80008a7fe730>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (638): [<ffff80008a7fe730>] tipc_skb_peek_port net/tipc/msg.h:1235 [inline]
softirqs last  enabled at (638): [<ffff80008a7fe730>] tipc_sk_rcv+0x34c/0x1888 net/tipc/socket.c:2494
softirqs last disabled at (640): [<ffff80008a7fe750>] spin_trylock_bh include/linux/spinlock.h:411 [inline]
softirqs last disabled at (640): [<ffff80008a7fe750>] tipc_sk_rcv+0x36c/0x1888 net/tipc/socket.c:2499
CPU: 0 PID: 13146 Comm: syz-executor178 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : lock_acquire+0x278/0x71c
lr : lockdep_recursion_finish kernel/locking/lockdep.c:467 [inline]
lr : lock_acquire+0x248/0x71c kernel/locking/lockdep.c:5756
sp : ffff80009ab86080
x29: ffff80009ab86190 x28: dfff800000000000 x27: ffff700013570c1c
x26: ffff0001b3fffdc0 x25: ffff80008ee74ac0 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
x20: ffff80008ebebdc0 x19: ffff0001b3fffdc0 x18: ffff80009ab862e0
x17: 000000000000c55c x16: ffff80008ad6b1c0 x15: 0000000000000001
x14: ffff80008eca0458 x13: dfff800000000000 x12: 00000000af1c601b
x11: 00000000a4e03a31 x10: 0000000000000003 x9 : 0000000000000000
x8 : 00000000000000c0 x7 : ffff80008a80b3f8 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : ffff80008aedfba0 x0 : 0000000000000000
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:196 [inline]
 lock_acquire+0x278/0x71c kernel/locking/lockdep.c:5757
 rcu_lock_acquire+0x40/0x4c include/linux/rcupdate.h:298
 rcu_read_lock include/linux/rcupdate.h:750 [inline]
 tipc_sk_lookup+0xc8/0x8b4 net/tipc/socket.c:3003
 tipc_sk_rcv+0x358/0x1888 net/tipc/socket.c:2495
 tipc_node_xmit+0x1b0/0xdb0 net/tipc/node.c:1703
 tipc_node_xmit_skb net/tipc/node.c:1768 [inline]
 tipc_node_distr_xmit+0x28c/0x3a4 net/tipc/node.c:1783
 tipc_sk_rcv+0x1280/0x1888 net/tipc/socket.c:2504
 tipc_node_xmit+0x1b0/0xdb0 net/tipc/node.c:1703
 tipc_sk_push_backlog net/tipc/socket.c:1317 [inline]
 tipc_sk_filter_connect net/tipc/socket.c:2258 [inline]
 tipc_sk_filter_rcv+0x13f8/0x2cac net/tipc/socket.c:2367
 tipc_sk_enqueue net/tipc/socket.c:2448 [inline]
 tipc_sk_rcv+0x6d0/0x1888 net/tipc/socket.c:2500
 tipc_node_xmit+0x1b0/0xdb0 net/tipc/node.c:1703
 tipc_node_xmit_skb net/tipc/node.c:1768 [inline]
 tipc_node_distr_xmit+0x28c/0x3a4 net/tipc/node.c:1783
 tipc_sk_backlog_rcv+0x164/0x214 net/tipc/socket.c:2415
 sk_backlog_rcv include/net/sock.h:1092 [inline]
 __release_sock+0x1a8/0x408 net/core/sock.c:2972
 release_sock+0x68/0x1b8 net/core/sock.c:3538
 sk_setsockopt+0xbdc/0x306c
 sock_setsockopt+0x68/0x80 net/core/sock.c:1548
 do_sock_setsockopt+0x238/0x4e0 net/socket.c:2307
 __sys_setsockopt+0x128/0x1a8 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2340
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


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

