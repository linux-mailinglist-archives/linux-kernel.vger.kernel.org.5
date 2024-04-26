Return-Path: <linux-kernel+bounces-160135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46A8B3998
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814871C226B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA581487F3;
	Fri, 26 Apr 2024 14:17:22 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB872147C71
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141041; cv=none; b=efl/vUVLepxVx6sU8igvhjSdIw/s3DiC/PerOExBJrLvCvh6KLrv7DfFZ2Oxx43qOxAlRihKEa7nNtNJI7rgRvoQQqAcCbbBPh0eBy4tXXJZZlzEdoydVYHkulxrBpUKgHY11n7E3ETpdxrQZnQkWhljtvroW17LwjaQTJmRAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141041; c=relaxed/simple;
	bh=i3kgqrHHpbXMW27S2FervM6XeCNKONpsKToZKBi58xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6ctrnVoxy7yD+mxFRyr+9gpHB3Vm1ma4uP9sfO42Cfyr0XYW7XuNHDsAQ9HnXg6uyRDnNKRpy5rFr76iQFcxbPmAfsLn6VAIy2QtBVyn9mk70x95acLYnAiucm+KJjvjQhyBtr3CmtdlFgBz3ixm69JJNAPBEPA/Uv4kQzpleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.235])
	by sina.com (172.16.235.25) with ESMTP
	id 662BB75B00006D3A; Fri, 26 Apr 2024 22:17:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6332034210490
X-SMAIL-UIID: 5E451C7B22CD492B879366B2EF650F06-20240426-221703-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com>
Cc: edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Fri, 26 Apr 2024 22:17:02 +0800
Message-Id: <20240426141702.3419-1-hdanton@sina.com>
In-Reply-To: <000000000000ffc5d80616fea23d@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Apr 2024 04:59:32 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1662179e180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
> dashboard link: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1058e7b9180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11919365180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08073-g480e035fc4c7 #0 Not tainted
> ------------------------------------------------------
> syz-executor419/5074 is trying to acquire lock:
> ffff888023dc4d20 (team->team_lock_key){+.+.}-{3:3}, at: team_del_slave+0x32/0x1d0 drivers/net/team/team.c:1988
> 
> but task is already holding lock:
> ffff88802a210768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: nl80211_del_interface+0x11a/0x140 net/wireless/nl80211.c:4389
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&rdev->wiphy.mtx){+.+.}-{3:3}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        wiphy_lock include/net/cfg80211.h:5951 [inline]
>        ieee80211_open+0xe7/0x200 net/mac80211/iface.c:449
>        __dev_open+0x2d3/0x450 net/core/dev.c:1430

	ASSERT_RTNL();

>        dev_open+0xae/0x1b0 net/core/dev.c:1466
>        team_port_add drivers/net/team/team.c:1214 [inline]
>        team_add_slave+0x9b3/0x2750 drivers/net/team/team.c:1974
>        do_set_master net/core/rtnetlink.c:2685 [inline]
>        do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2891
>        rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3185
>        rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
>        netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
>        netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>        netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>        netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
>        sock_sendmsg_nosec net/socket.c:730 [inline]
>        __sock_sendmsg+0x221/0x270 net/socket.c:745
>        ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>        ___sys_sendmsg net/socket.c:2638 [inline]
>        __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> -> #0 (team->team_lock_key){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        team_del_slave+0x32/0x1d0 drivers/net/team/team.c:1988
>        team_device_event+0x200/0x5b0 drivers/net/team/team.c:3029
>        notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
>        call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
>        call_netdevice_notifiers net/core/dev.c:2002 [inline]
>        unregister_netdevice_many_notify+0xd96/0x16d0 net/core/dev.c:11096
>        unregister_netdevice_many net/core/dev.c:11154 [inline]
>        unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11033
>        unregister_netdevice include/linux/netdevice.h:3115 [inline]
>        _cfg80211_unregister_wdev+0x162/0x560 net/wireless/core.c:1206
>        ieee80211_if_remove+0x25d/0x3a0 net/mac80211/iface.c:2242

	ASSERT_RTNL();
	lockdep_assert_wiphy(sdata->local->hw.wiphy);

Given ASSERT_RTNL() on both sides, difficult to understand the
deadlock reported.

>        ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:202
>        rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
>        cfg80211_remove_virtual_intf+0x230/0x3f0 net/wireless/util.c:2847
>        genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
>        genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
>        genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
>        netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
>        netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>        netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>        netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
>        sock_sendmsg_nosec net/socket.c:730 [inline]
>        __sock_sendmsg+0x221/0x270 net/socket.c:745
>        ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>        ___sys_sendmsg net/socket.c:2638 [inline]
>        __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&rdev->wiphy.mtx);
>                                lock(team->team_lock_key);
>                                lock(&rdev->wiphy.mtx);
>   lock(team->team_lock_key);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by syz-executor419/5074:
>  #0: ffffffff8f3f1a30 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1216
>  #1: ffffffff8f38ce88 (rtnl_mutex){+.+.}-{3:3}, at: nl80211_pre_doit+0x5f/0x8b0 net/wireless/nl80211.c:16401
>  #2: ffff88802a210768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: nl80211_del_interface+0x11a/0x140 net/wireless/nl80211.c:4389
> 
> stack backtrace:
> CPU: 1 PID: 5074 Comm: syz-executor419 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>  __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>  team_del_slave+0x32/0x1d0 drivers/net/team/team.c:1988
>  team_device_event+0x200/0x5b0 drivers/net/team/team.c:3029
>  notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
>  call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
>  call_netdevice_notifiers net/core/dev.c:2002 [inline]
>  unregister_netdevice_many_notify+0xd96/0x16d0 net/core/dev.c:11096
>  unregister_netdevice_many net/core/dev.c:11154 [inline]
>  unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11033
>  unregister_netdevice include/linux/netdevice.h:3115 [inline]
>  _cfg80211_unregister_wdev+0x162/0x560 net/wireless/core.c:1206
>  ieee80211_if_remove+0x25d/0x3a0 net/mac80211/iface.c:2242
>  ieee80211_del_iface+0x19/0x30 net/mac80211/cfg.c:202
>  rdev_del_virtual_intf net/wireless/rdev-ops.h:62 [inline]
>  cfg80211_remove_virtual_intf+0x230/0x3f0 net/wireless/util.c:2847
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
>  genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f963cb981a9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdde1419a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f963cbe53f6 RCX: 00007f963cb981a9
> RDX: 0000000000000000 RSI: 0000000020000400 RDI: 0000000000000004
> RBP: 00007f963cc17440 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000031
> R13: 0000000000000003 R14: 0000000000050012 R15: 00007ffdde141a02
>  </TASK>
> team0: Port device wlan0 removed
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
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

