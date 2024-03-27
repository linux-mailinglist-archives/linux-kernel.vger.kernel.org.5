Return-Path: <linux-kernel+bounces-121468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC8D88E98F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7809B357FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20313E895;
	Wed, 27 Mar 2024 14:52:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9613E414
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551144; cv=none; b=RhZlxhHPI5920l/0CfALxUlf9CgpJE0bTuUWmZn6N+UoZsT1RYrKLyVz0VxFggoAtLhNw1OfSawccFwtrI4wAqgF6sPW8ZIHbuiHAICPhP4Wcuvbl7h9uK5k8MU8QulIg2EskksGyzv4qmlqjlKXUgG6XUCizMC6xMsWQT+empU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551144; c=relaxed/simple;
	bh=71rJq7Xp8Cqgp8M2d8+P1WXkdN3xzz0kedDaTR9okh8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nQNN1FD7xLxd6KstyTq7LWqiR9LvGBJrTvFHwIVBZ+nVQ/d7qpeZe+dWdGUiyzyKIuUZTDMJ+3jit+sxfXSAd34wgoTQ8D3vHxGRMXAekPOw/LamZWmwPZPvx2TvRfRPCd3dbB1Oxa/vswy3cxzbbaPomVeD5QuBaRyWsq2nJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc012893acso713857439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711551139; x=1712155939;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Zz5Gummoz+kjUDcBWiUlBWeOeyMoyGTY6ig/qkgeKg=;
        b=dN5CLL9PcMY/HCePl6COuR58zqUovNgxPrbN05QJ+v5C9Zxf0VPo8+N+dR9zqjDkRR
         DYJ3v8Nr7GfxyLXV5vjfWVfv41dLptMSn/XuUnRRaZwfyld3qDG7RDq6giyKssxtKv9d
         UpL3uI7G12M9kNg7I7N2cvDjpsawbC53U4LYoBRFKimaTX3P69oj9x+F7QswZpIXPaw9
         kCle75zOuJu3leHZq1pgvgph6hY6ezG1dBVlz1wFA72H5F04sqFx0DgFfgclXbgOi1aO
         tz8n5RoGZq54F1mmnJtsnaGMHyZvxEGX4fk3J6LHoMMO3UhwxHmpxG+jCT88zbjhLhac
         uaHw==
X-Forwarded-Encrypted: i=1; AJvYcCWzEx9vY1npM9W08ykWnnlQJciy5ctwDqprvXah2sMpr0B36RCMzAMpdw+05+BozlEZWNXJ1tP4IodhWJRJ5DBbgp45XhyTK5Fp1dGk
X-Gm-Message-State: AOJu0YzmoyJzwW1xnWcAJA04cHjk2nudB0TKYKMfHwfMRqqjBarpd7KA
	Bz81Pq7uw46M6hZ++kqOIcfrO1xvLtJ4y3RK+GBYufpPxdLc86kQpckYhxMGSfx5xWl1vqJYx2B
	ThIszLqk5O05kSI6lKj5I9XJytySlpqeA8aeLhwXLzsehrT0yxShPm9w=
X-Google-Smtp-Source: AGHT+IHBacTzIE+E1O1ogxORsrkRvTUqLPNLlGhjmN8DFpzF0NyBgHXnhmdHMvgV+Iht5TXt+tVCSAfgmiROLTwxAwKTVtJ4aecF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640f:b0:7d0:7c06:805a with SMTP id
 gn15-20020a056602640f00b007d07c06805amr9787iob.3.1711551139625; Wed, 27 Mar
 2024 07:52:19 -0700 (PDT)
Date: Wed, 27 Mar 2024 07:52:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b146890614a58da4@google.com>
Subject: [syzbot] [wireless?] possible deadlock in ieee80211_open
From: syzbot <syzbot+7526b1c2ce0b9a92e9a6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    237bb5f7f7f5 cxgb4: unnecessary check for 0 in the free_sg..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=113622a5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=7526b1c2ce0b9a92e9a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/728c4d735738/disk-237bb5f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcd84ee276f5/vmlinux-237bb5f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/366f6292e769/bzImage-237bb5f7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7526b1c2ce0b9a92e9a6@syzkaller.appspotmail.com

netlink: 'syz-executor.0': attribute type 10 has an invalid length.
======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05204-g237bb5f7f7f5 #0 Not tainted
------------------------------------------------------
syz-executor.0/7478 is trying to acquire lock:
ffff888077110768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5951 [inline]
ffff888077110768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_open+0xe7/0x200 net/mac80211/iface.c:449

but task is already holding lock:
ffff888064974d20 (team->team_lock_key#17){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team.c:1973

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (team->team_lock_key#17){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2995
       team_device_event+0x161/0x5b0 drivers/net/team/team.c:3021
       notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
       call_netdevice_notifiers net/core/dev.c:2002 [inline]
       dev_close_many+0x33c/0x4c0 net/core/dev.c:1543
       unregister_netdevice_many_notify+0x544/0x16d0 net/core/dev.c:11071
       macvlan_device_event+0x7bc/0x850 drivers/net/macvlan.c:1828
       notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
       call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
       call_netdevice_notifiers net/core/dev.c:2002 [inline]
       unregister_netdevice_many_notify+0xd96/0x16d0 net/core/dev.c:11096
       unregister_netdevice_many net/core/dev.c:11154 [inline]
       unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11033
       unregister_netdevice include/linux/netdevice.h:3115 [inline]
       _cfg80211_unregister_wdev+0x162/0x560 net/wireless/core.c:1206
       ieee80211_if_remove+0x25d/0x3a0 net/mac80211/iface.c:2242
       ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:202
       rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
       cfg80211_remove_virtual_intf+0x230/0x3f0 net/wireless/util.c:2847
       genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
       genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
       genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
       netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
       netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
       netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
       ___sys_sendmsg net/socket.c:2638 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&rdev->wiphy.mtx){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       wiphy_lock include/net/cfg80211.h:5951 [inline]
       ieee80211_open+0xe7/0x200 net/mac80211/iface.c:449
       __dev_open+0x2d3/0x450 net/core/dev.c:1430
       dev_open+0xae/0x1b0 net/core/dev.c:1466
       team_port_add drivers/net/team/team.c:1214 [inline]
       team_add_slave+0x9b3/0x2750 drivers/net/team/team.c:1974
       do_set_master net/core/rtnetlink.c:2685 [inline]
       do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2891
       __rtnl_newlink net/core/rtnetlink.c:3680 [inline]
       rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3727
       rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
       netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
       netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
       netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
       ___sys_sendmsg net/socket.c:2638 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(team->team_lock_key#17);
                               lock(&rdev->wiphy.mtx);
                               lock(team->team_lock_key#17);
  lock(&rdev->wiphy.mtx);

 *** DEADLOCK ***

2 locks held by syz-executor.0/7478:
 #0: ffffffff8f385a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f385a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
 #1: ffff888064974d20 (team->team_lock_key#17){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team.c:1973

stack backtrace:
CPU: 0 PID: 7478 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-05204-g237bb5f7f7f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 wiphy_lock include/net/cfg80211.h:5951 [inline]
 ieee80211_open+0xe7/0x200 net/mac80211/iface.c:449
 __dev_open+0x2d3/0x450 net/core/dev.c:1430
 dev_open+0xae/0x1b0 net/core/dev.c:1466
 team_port_add drivers/net/team/team.c:1214 [inline]
 team_add_slave+0x9b3/0x2750 drivers/net/team/team.c:1974
 do_set_master net/core/rtnetlink.c:2685 [inline]
 do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2891
 __rtnl_newlink net/core/rtnetlink.c:3680 [inline]
 rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3727
 rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc81627dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc81701e0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc8163abf80 RCX: 00007fc81627dda9
RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000003
RBP: 00007fc8162ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc8163abf80 R15: 00007ffd5f0eb6a8
 </TASK>
team0: Port device wlan1 added


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

