Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A427F8B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjKYNWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjKYNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:21:57 -0500
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BC9C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:22:04 -0800 (PST)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cc021f658bso674104b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700918523; x=1701523323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/u0knbZFspBdhoGDx1rtdXXroGcxahRT9I+tbTyqeg=;
        b=pKySBLFRacy4ZrHyQf5o2e4rvmkyuewUtLmGNbiqgBKSbKw3iaJrZY191LuAyrT28a
         oyei70QF+rf45zs2lXkrGbfh7yyA2ishMBPr8AcQmBXRsPu3zAuCToC+jXrg+GvT7rAm
         2oke/PUigrCyDI3SVD/3ZDcP66Acnk3mKwcRQeOBRsyrefVubluvYaxgpbWyxGEy+jsm
         BfqrMzQMa8keVvPIKvaOornxuolQAK8Rx1/qgs0T0QWNg4VmMVf2Dh8hM+2LczdXV9xK
         aR30PFDuC0iu7pnNN7X68HfGcQ8zpxPcTyeutIIsKJxcUYZQXSYJz5Wc3WZN1U0pbpep
         OXyw==
X-Gm-Message-State: AOJu0YzQ9KDwAt3FFessBu6JNgbelfbDZOcd7i6HbJpiDRs3hJ13opqK
        UEPeYT+SM0jW7t8qW5MOyBw+2OsLpaMNAuSUDbybW0i16An7
X-Google-Smtp-Source: AGHT+IFNb4XxaBdx5SpXNKGiq9rn5LpEjL04Tw7dRhvw3mypbMzfB72fhTILAvL/HooMrkyPxFTink+qKXK1bwmqtFyQOHY6OCbz
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3907:b0:6be:aed:7ad0 with SMTP id
 fh7-20020a056a00390700b006be0aed7ad0mr1402527pfb.2.1700918523089; Sat, 25 Nov
 2023 05:22:03 -0800 (PST)
Date:   Sat, 25 Nov 2023 05:22:02 -0800
In-Reply-To: <20231125130757.765-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c581d060af9f403@google.com>
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
WARNING: bad unlock balance in __dev_queue_xmit

=====================================
WARNING: bad unlock balance detected!
6.7.0-rc2-syzkaller-00195-g0f5cc96c367f-dirty #0 Not tainted
-------------------------------------
syz-executor.0/5357 is trying to release lock (_xmit_ETHER) at:
[<ffffffff8854264e>] spin_unlock include/linux/spinlock.h:391 [inline]
[<ffffffff8854264e>] __netif_tx_unlock include/linux/netdevice.h:4441 [inline]
[<ffffffff8854264e>] __dev_queue_xmit+0x1dce/0x3940 net/core/dev.c:4353
but there are no more locks to release!

other info that might help us debug this:
6 locks held by syz-executor.0/5357:
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x467/0x1360 net/ipv4/ip_output.c:228
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:799 [inline]
 #1: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x23e/0x3940 net/core/dev.c:4272
 #2: ffff88814ab86258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #2: ffff88814ab86258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: qdisc_run_begin include/net/sch_generic.h:194 [inline]
 #2: ffff88814ab86258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_xmit_skb net/core/dev.c:3759 [inline]
 #2: ffff88814ab86258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x10f4/0x3940 net/core/dev.c:4314
 #3: ffff8880639ff8d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff8880639ff8d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4403 [inline]
 #3: ffff8880639ff8d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #4: ffffffff8cb25ba0 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x467/0x1360 net/ipv4/ip_output.c:228
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:799 [inline]
 #5: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x23e/0x3940 net/core/dev.c:4272

stack backtrace:
CPU: 1 PID: 5357 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00195-g0f5cc96c367f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_unlock_imbalance_bug+0x252/0x2c0 kernel/locking/lockdep.c:5193
 lock_release+0x59d/0x9d0 kernel/locking/lockdep.c:5430
 _raw_spin_unlock+0x16/0x40 include/linux/spinlock_api_smp.h:141
 spin_unlock include/linux/spinlock.h:391 [inline]
 __netif_tx_unlock include/linux/netdevice.h:4441 [inline]
 __dev_queue_xmit+0x1dce/0x3940 net/core/dev.c:4353
 ip_finish_output2+0xe6d/0x1360 include/net/neighbour.h:542
 iptunnel_xmit+0x540/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x20e4/0x2940 net/ipv4/ip_tunnel.c:831
 erspan_xmit+0x9c6/0x13e0 net/ipv4/ip_gre.c:717
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3545 [inline]
 dev_hard_start_xmit+0x241/0x750 net/core/dev.c:3561
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:342
 __dev_queue_xmit+0x17f5/0x3940 net/core/dev.c:3772
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
RIP: 0033:0x7fc4686798a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc4697f40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fc46878bf60 RCX: 00007fc4686798a9
RDX: 0000000000000001 RSI: 0000000020004d80 RDI: 0000000000000004
RBP: 00007fc4686d5074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000004000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc46878bf60 R15: 00007fff01466ec8
 </TASK>
------------[ cut here ]------------
pvqspinlock: lock 0xffff88807a476cc0 has corrupted value 0x0!
WARNING: CPU: 1 PID: 5357 at kernel/locking/qspinlock_paravirt.h:510 __pv_queued_spin_unlock_slowpath+0x23b/0x2f0 kernel/locking/qspinlock_paravirt.h:508
Modules linked in:
CPU: 1 PID: 5357 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00195-g0f5cc96c367f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__pv_queued_spin_unlock_slowpath+0x23b/0x2f0 kernel/locking/qspinlock_paravirt.h:508
Code: e8 0a 70 71 f7 4c 89 f0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 9a 00 00 00 41 8b 16 48 c7 c7 40 c6 aa 8a 4c 89 f6 e8 45 19 db f6 <0f> 0b eb 95 44 89 f1 80 e1 07 38 c1 0f 8c 2e ff ff ff 4c 89 f7 e8
RSP: 0018:ffffc900050ce398 EFLAGS: 00010246
RAX: 3a091d8f59dedc00 RBX: dffffc0000000000 RCX: ffff88807bebbb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff81524a02 R09: 1ffff92000a19c14
R10: dffffc0000000000 R11: fffff52000a19c15 R12: 1ffff1100f48ed9a
R13: ffff88807a476cd0 R14: ffff88807a476cc0 R15: ffff88807a476cc0
FS:  00007fc4697f46c0(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020004540 CR3: 000000001e0b6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
 .slowpath+0x9/0x1a
 do_raw_spin_unlock+0x13b/0x8b0 arch/x86/include/asm/paravirt.h:591
 _raw_spin_unlock+0x1e/0x40 include/linux/spinlock_api_smp.h:142
 spin_unlock include/linux/spinlock.h:391 [inline]
 __netif_tx_unlock include/linux/netdevice.h:4441 [inline]
 __dev_queue_xmit+0x1dce/0x3940 net/core/dev.c:4353
 ip_finish_output2+0xe6d/0x1360 include/net/neighbour.h:542
 iptunnel_xmit+0x540/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x20e4/0x2940 net/ipv4/ip_tunnel.c:831
 erspan_xmit+0x9c6/0x13e0 net/ipv4/ip_gre.c:717
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3545 [inline]
 dev_hard_start_xmit+0x241/0x750 net/core/dev.c:3561
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:342
 __dev_queue_xmit+0x17f5/0x3940 net/core/dev.c:3772
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
RIP: 0033:0x7fc4686798a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc4697f40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fc46878bf60 RCX: 00007fc4686798a9
RDX: 0000000000000001 RSI: 0000000020004d80 RDI: 0000000000000004
RBP: 00007fc4686d5074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000004000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc46878bf60 R15: 00007fff01466ec8
 </TASK>


Tested on:

commit:         0f5cc96c Merge tag 's390-6.7-3' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=128b55af680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3813bb4934ffb745
dashboard link: https://syzkaller.appspot.com/bug?extid=e18ac85757292b7baf96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d18da4e80000

