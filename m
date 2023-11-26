Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2C67F923D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjKZKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKZKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:32:58 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20782F0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:33:05 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cfc2a7e382so7231845ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700994784; x=1701599584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMo4oMk8KWpiO8Pe9yfxadp69pAW1CkMZqZUaziqlNA=;
        b=VtpLdx49+OvdCjH4BKlbFLqwZqSCLzUEUQBr8PhNgVk7IHVWtQL9pyejX8xYY/ktzO
         3bMJnLPRz9Tf68VnACiFVgHc/ANBEdxFpODQQx98DPCnCEyrtIfTqVVqcXGv6Qm1hj2/
         YuMW9konBwWPKMYwg4MaHorF53EMoGq4h6jrK91uPChoYtUpWx8JcTCfZj7u/WYWoYsN
         AKs/Xc95k1d0hInXMv9t4+u/GIzc6CuhD5ggyLJd/osDUywGqJEC/HgLwJaJcthyjh1W
         4s/lBedv0HIXPm02iSZNjE5C6HLZGvEQ7lyTC5yiyqlzmEE/v3ckLymkcyexgk1ZRoAq
         SxrA==
X-Gm-Message-State: AOJu0YyiXQPygs4Jx1zEACUzKvbOrI4rGeLfLtDpOmdxdAIQPn53zLz1
        MxIRDiEXdJ/tjT+uFMvnYS0H6dlROqeG7gbfM/TWQfC3GJic
X-Google-Smtp-Source: AGHT+IGED48ue99l4JQnbenMsrOLU/IohGkcxv3O1JiZ33bO23PI/h9DgoFfGEjvo1uzF/2i2iOUKl5GKzIBqvxA4FMCxMZdbuBH
MIME-Version: 1.0
X-Received: by 2002:a17:902:e154:b0:1cf:61c5:69c8 with SMTP id
 d20-20020a170902e15400b001cf61c569c8mr2051823pla.0.1700994784700; Sun, 26 Nov
 2023 02:33:04 -0800 (PST)
Date:   Sun, 26 Nov 2023 02:33:04 -0800
In-Reply-To: <tencent_955C09A52EC46EC24C9327E746D852CD4606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e86360060b0bb572@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit (2)
From:   syzbot <syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __dev_queue_xmit

============================================
WARNING: possible recursive locking detected
6.7.0-rc2-syzkaller-00242-g090472ed9c92-dirty #0 Not tainted
--------------------------------------------
syz-executor.0/5354 is trying to acquire lock:
ffff8880216e40d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff8880216e40d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4403 [inline]
ffff8880216e40d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __dev_queue_xmit+0x1622/0x38e0 net/core/dev.c:4342

but task is already holding lock:
ffff88807a6cfcd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88807a6cfcd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4403 [inline]
ffff88807a6cfcd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x24d/0x5f0 net/sched/sch_generic.c:341

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(_xmit_ETHER#2);
  lock(_xmit_ETHER#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by syz-executor.0/5354:
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x467/0x1360 net/ipv4/ip_output.c:228
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:799 [inline]
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x23e/0x38e0 net/core/dev.c:4271
 #2: ffff88814b0da258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #2: ffff88814b0da258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: qdisc_run_begin include/net/sch_generic.h:194 [inline]
 #2: ffff88814b0da258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_xmit_skb net/core/dev.c:3759 [inline]
 #2: ffff88814b0da258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x11d0/0x38e0 net/core/dev.c:4312
 #3: ffff88807a6cfcd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff88807a6cfcd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4403 [inline]
 #3: ffff88807a6cfcd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x24d/0x5f0 net/sched/sch_generic.c:341
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x467/0x1360 net/ipv4/ip_output.c:228
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:799 [inline]
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x23e/0x38e0 net/core/dev.c:4271

stack backtrace:
CPU: 0 PID: 5354 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00242-g090472ed9c92-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 __lock_acquire+0x6a81/0x7f70 kernel/locking/lockdep.c:3062
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __netif_tx_lock include/linux/netdevice.h:4403 [inline]
 __dev_queue_xmit+0x1622/0x38e0 net/core/dev.c:4342
 ip_finish_output2+0xe6d/0x1360 include/net/neighbour.h:542
 iptunnel_xmit+0x540/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x20e4/0x2940 net/ipv4/ip_tunnel.c:831
 erspan_xmit+0x9c6/0x13e0 net/ipv4/ip_gre.c:717
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3545 [inline]
 dev_hard_start_xmit+0x241/0x750 net/core/dev.c:3561
 sch_direct_xmit+0x2db/0x5f0 net/sched/sch_generic.c:343
 __dev_queue_xmit+0x187c/0x38e0 net/core/dev.c:3772
 ip_finish_output2+0xe6d/0x1360 include/net/neighbour.h:542
 ip_send_skb+0x117/0x1b0 include/net/dst.h:451
 udp_send_skb+0x931/0x1200 net/ipv4/udp.c:963
 udp_sendmsg+0x1c17/0x2a70 net/ipv4/udp.c:1250
 udpv6_sendmsg+0x1342/0x3220 net/ipv6/udp.c:1390
 ____sys_sendmsg+0x592/0x890 net/socket.c:730
 __sys_sendmmsg+0x3b2/0x730 net/socket.c:2638
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6d49e798a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6d4b01e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f6d49f8bf60 RCX: 00007f6d49e798a9
RDX: 0000000000000001 RSI: 0000000020004d80 RDI: 0000000000000004
RBP: 00007f6d49ed5074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000004000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6d49f8bf60 R15: 00007ffe004ace78
 </TASK>
syz-executor.0 (5354) used greatest stack depth: 18544 bytes left


Tested on:

commit:         090472ed Merge tag 'usb-6.7-rc3' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=150d960ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3813bb4934ffb745
dashboard link: https://syzkaller.appspot.com/bug?extid=e18ac85757292b7baf96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142cb6e8e80000

