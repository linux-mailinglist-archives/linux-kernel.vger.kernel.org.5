Return-Path: <linux-kernel+bounces-95249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBEF874B43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C0E282127
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800DF84FB9;
	Thu,  7 Mar 2024 09:50:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98482D9C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805005; cv=none; b=A5H8t9szvhms+gdxT/P/5NwAEnwuoc2ccuurYhOkjaUYClYPBjpgmq2fPpqVP8T2oEcY+QoMtG7e7Vk4K+8+lMhVl4pXD+9ajWMouX7S8lsjty7Gyh4wnpu2EENdRp2H1Wrr4g73UJ7k4B4eRSf5/gv58AyT1mQB6KjAjIwV+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805005; c=relaxed/simple;
	bh=slnB0VkPCmYRjEMKYGVTvhGjXrhDQHvvukoTVT6e47A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dVPlB3ICe12u/lsHLq8vFmwRM43RaUVRS9YilRw7vSQT8HInwR3YK0r0Dgd5CrdHT0Tyj+amgSHYMC12swSlMi/0tX/HF7Cuj9VLvgW1c4f6BnOTL+jf9mWu1/IlQZBztZQcSl4zVKmJNniOTZFOVotbO2Z6i1cEE3xwW9Op7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36541324e57so5078795ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 01:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709805002; x=1710409802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50bHIWv34gOWuzWRTJWazDpYdtTy9+axEClGHGpCYuA=;
        b=tvj6B4oZ8nNlXmAxk5HnC4yWuKzQF/dmElQgqhMF3hSRHkERDrHUvNGnx2sn3x6BZ9
         F00lB7i0pC1aswkuemkHL2C5/dPEpJXo/ZoLFQxoigAhuEAQrXSpTpMVoy7TsU5q9uHM
         7SnUzdr6RzhAKsDNMt2Oiz7vuKKb94izfuPwwriOjsmTZ+yXkh5RUrPez8LWG4GICnLU
         ZHENOH8gfpXNhxVgyaPZe29m3bqGmQP3uNQlpbn3hT2nuDvUTsvQ348ho41yALdWobk/
         onO0Dy3cg00z7Qz5fnkNU0yKp1Gl46wSPIDxILynk4opoWxp3teJKb67mt7YDqLI+cfK
         ZL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU26+fabm7wIHz+1pabWVYUfQArTGckPVkh26OIqMJuWUcHi6YS0ShV67+4kkusCbm5Ij1wEwrU12gSZTm6xOQwroTmPvXIePKRfdGk
X-Gm-Message-State: AOJu0YwR/AMqLpKcLos+NkqfFPotO1N6SczMlEq6doR+o2GlIPQziPxX
	AJU3PbVw96ruI92xGcIJgr01qCuAu8kZ3qJroGFJ/e+3DueMLPgbV9AGZ8UZlHBYW597+vPfYUG
	V2qHC1kAmkyTL75ormXpQilYtCeMfa1U7KPcjJcNFx0k/fPavVJpMuGI=
X-Google-Smtp-Source: AGHT+IGhM9mrbJuSzTA1W5jR6v4ssyHW5Eyc6A5pBae3PyR2kXjDqjjaRzZOla370YKuRoNJkPdJYPY0Xzo5qrKpi7NIFT0a7Ymz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a68:b0:365:366f:b652 with SMTP id
 w8-20020a056e021a6800b00365366fb652mr977138ilv.1.1709805002501; Thu, 07 Mar
 2024 01:50:02 -0800 (PST)
Date: Thu, 07 Mar 2024 01:50:02 -0800
In-Reply-To: <tencent_11DF52D0864289AB2EC56EE80C82E7EA0606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf41ca06130effb3@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_port_change_check (2)
From: syzbot <syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in team_port_change_check

veth0_vlan: left promiscuous mode
veth0_vlan: entered promiscuous mode
team0: Device veth0_vlan failed to register rx_handler
============================================
WARNING: possible recursive locking detected
6.8.0-rc7-syzkaller-00051-g67be068d31d4-dirty #0 Not tainted
--------------------------------------------
syz-executor.0/5487 is trying to acquire lock:
ffff88802dce4d00 (team->team_lock_key){+.+.}-{3:3}, at: team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2999

but task is already holding lock:
ffff88802dce4d00 (team->team_lock_key){+.+.}-{3:3}, at: team_port_add drivers/net/team/team.c:1217 [inline]
ffff88802dce4d00 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave+0x9bb/0x2710 drivers/net/team/team.c:1977

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key);
  lock(team->team_lock_key);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor.0/5487:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614
 #1: ffff88802dce4d00 (team->team_lock_key){+.+.}-{3:3}, at: team_port_add drivers/net/team/team.c:1217 [inline]
 #1: ffff88802dce4d00 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave+0x9bb/0x2710 drivers/net/team/team.c:1977

stack backtrace:
CPU: 1 PID: 5487 Comm: syz-executor.0 Not tainted 6.8.0-rc7-syzkaller-00051-g67be068d31d4-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2999
 team_device_event+0x161/0x5b0 drivers/net/team/team.c:3025
 notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 dev_close_many+0x33c/0x4c0 net/core/dev.c:1559
 vlan_device_event+0x18b7/0x1de0 net/8021q/vlan.c:449
 notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 dev_close_many+0x33c/0x4c0 net/core/dev.c:1559
 dev_close+0x1c0/0x2c0 net/core/dev.c:1581
 team_port_add drivers/net/team/team.c:1314 [inline]
 team_add_slave+0x1ac5/0x2710 drivers/net/team/team.c:1977
 do_set_master net/core/rtnetlink.c:2707 [inline]
 do_setlink+0xe58/0x41c0 net/core/rtnetlink.c:2913
 rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3209
 rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6617
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 do_iter_readv_writev+0x46c/0x640
 vfs_writev+0x395/0xbb0 fs/read_write.c:971
 do_writev+0x1b1/0x350 fs/read_write.c:1018
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f19b167dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f19b247f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f19b17abf80 RCX: 00007f19b167dda9
RDX: 0000000000000001 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007f19b16ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f19b17abf80 R15: 00007ffdad2a3d88
 </TASK>


Tested on:

commit:         67be068d Merge tag 'vfs-6.8-release.fixes' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16f71336180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
dashboard link: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15998cea180000


