Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22C07F88FD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjKYID7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:03:58 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FAB7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:04:04 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cb42be51easo3408486b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700899444; x=1701504244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/g22jBGEBV5CY2tBMddEW8r6Zq9VAmGGcnIUFnjmBM=;
        b=s95cutFVoOI5y2c/q7NmIEjyEyOmt35UQlVcpMFobq6EWxKphRgElbwcV2QlCRkO1b
         zCqU3AeRwLnDWn1ekkD0vwg8xqZoNVGYjiblqnTTBOwBodAu7iMqZQiria7ZpEoBwJgP
         U3bWU8AkciXRAkRtKOHhoE7g0G6ANudoj77UYJ04fTDnxL45Io08UjlbHr17X+zCephF
         pJpZQKxcsfaGOkkH6Zl6a2itRoE4j4Y6gtbyY+KhEyxT/kxpxUGIdBjIYdyWoYz087AG
         o6j78EB1fV8VFCaNqJQQZJRGlbSWRxCdQeH/njid2xL7HKgw4rhwGCyJ2PphpmFi4ZN6
         j8OA==
X-Gm-Message-State: AOJu0YxzbaOC6z8Hr0Xw42Sm1T0t6/vXfRk7ZHJWt1VwpguoPnBXOqzx
        SiPm+D67ImnqtFHiOrOl6UpYDOYzU7U4R/PuvvpqiTT55J50
X-Google-Smtp-Source: AGHT+IH4za6SFY0TA9DEtz6togSrftb11n1ML8eqOQImEVUvH9BrOnfK1IUuqNfm6y8X4GfFmvYF5XNk8ouSpT00K1lAoGsMhgnc
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d15:b0:6c3:9efc:6747 with SMTP id
 fa21-20020a056a002d1500b006c39efc6747mr1226429pfb.3.1700899444085; Sat, 25
 Nov 2023 00:04:04 -0800 (PST)
Date:   Sat, 25 Nov 2023 00:04:03 -0800
In-Reply-To: <20231125071138.1665-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029da72060af58380@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit (2)
From:   syzbot <syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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
6.7.0-rc2-syzkaller-00195-g0f5cc96c367f-dirty #0 Not tainted
--------------------------------------------
syz-executor.0/5360 is trying to acquire lock:
ffff888077a4d0d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888077a4d0d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4403 [inline]
ffff888077a4d0d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __dev_queue_xmit+0x161e/0x38d0 net/core/dev.c:4342

but task is already holding lock:
ffff88807adc2cd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88807adc2cd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4403 [inline]
ffff88807adc2cd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c1/0x5f0 net/sched/sch_generic.c:340

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(_xmit_ETHER#2);
  lock(_xmit_ETHER#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by syz-executor.0/5360:
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x467/0x1360 net/ipv4/ip_output.c:228
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:799 [inline]
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x23e/0x38d0 net/core/dev.c:4271
 #2: ffff88801a9d1258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #2: ffff88801a9d1258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: qdisc_run_begin include/net/sch_generic.h:194 [inline]
 #2: ffff88801a9d1258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_xmit_skb net/core/dev.c:3759 [inline]
 #2: ffff88801a9d1258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x11d2/0x38d0 net/core/dev.c:4312
 #3: ffff88807adc2cd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff88807adc2cd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4403 [inline]
 #3: ffff88807adc2cd8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c1/0x5f0 net/sched/sch_generic.c:340
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x467/0x1360 net/ipv4/ip_output.c:228
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:799 [inline]
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x23e/0x38d0 net/core/dev.c:4271

stack backtrace:
CPU: 0 PID: 5360 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00195-g0f5cc96c367f-dirty #0
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
 __dev_queue_xmit+0x161e/0x38d0 net/core/dev.c:4342
 ip_finish_output2+0xe6d/0x1360 include/net/neighbour.h:542
 iptunnel_xmit+0x540/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x20e4/0x2940 net/ipv4/ip_tunnel.c:831
 erspan_xmit+0x9c6/0x13e0 net/ipv4/ip_gre.c:717
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3545 [inline]
 dev_hard_start_xmit+0x241/0x750 net/core/dev.c:3561
 sch_direct_xmit+0x2bb/0x5f0 net/sched/sch_generic.c:342
 __dev_queue_xmit+0x187e/0x38d0 net/core/dev.c:3772
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
RIP: 0033:0x7f668a8798a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f668ba420c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f668a98bf60 RCX: 00007f668a8798a9
RDX: 0000000000000001 RSI: 0000000020004d80 RDI: 0000000000000004
RBP: 00007f668a8d5074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000004000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f668a98bf60 R15: 00007ffed808a478
 </TASK>


Tested on:

commit:         0f5cc96c Merge tag 's390-6.7-3' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1183cbcce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3813bb4934ffb745
dashboard link: https://syzkaller.appspot.com/bug?extid=e18ac85757292b7baf96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d71c94e80000

