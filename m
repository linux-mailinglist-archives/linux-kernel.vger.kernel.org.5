Return-Path: <linux-kernel+bounces-93066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF853872A61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF651C250D0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29612D754;
	Tue,  5 Mar 2024 22:44:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3EA1EB33
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678663; cv=none; b=Qf+gT6oPqWi4JMWXF7ri+0Gfd/20+Xka2cywsgdvQUIUVQKXCD2swg++yBc4JW5vdmaOOihdlyZqUVKWPqLK5L6h7AS/zlq40DfwHdLpLr5JNzTHD7dz8nVY8ndreEuoZjYtZJeUJLw3f9NmfU7uSfRNORTzOIcKgjFClezOTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678663; c=relaxed/simple;
	bh=jixR8QDm2e3jHNpHT8oGnNznD6mImna6mrE/DyQZhwY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oIAvAmhnqZsS3KXi1/HEH5sW/ZskiYWjTxzGXSaj4f1ELnxlvn50iXrLk05TvlQDK8dK1WHZQVdRmDA2ATegk1ReYRM81/0Ntn8yJCT4x5DSDVQl4+mBTwbz4A6Cfi62Z0/PxZ+3o0D/1STI6hOwjsh1IuKVRzWE1TuAeGuHPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bc32b2226aso123790239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 14:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709678661; x=1710283461;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5Yx7pynpISvxY8YOA1v2/xHLqGOic15pvwGEm5e7yY=;
        b=cN830FCCi8mQZDEp/UgVa4CSGa3oJgH/4bK1XWeI1ttrh4yrq/cfbZsNFfmGnajO8I
         zF0qwrKKaZDT/M2mzF4Ml35W9uq2eNgbWiN+3PaHwoNnlSir+p4zIv+1dgrUpL75sSZM
         marMuTQ+/5D8ymXMfrhht9xGsY728uBiHuTyz1fJkMWvCyH41gBO8OQAydm9NZhETZ8v
         nWzPYKrHvsq4OlGrH0zZW7EoCUcDPtNmlYVUN43S+xc15SNP4K4tfWcaULP8LfzGyK59
         ZNd7hF1QJVhu+ZfYAxdbh3wjpGgUm5o1TZu3oZNLXbg4yI/ehBi5wzdc3s1y5vLlh/Cf
         6rTg==
X-Forwarded-Encrypted: i=1; AJvYcCW1WGOoBvJLykZts7rBowymkb2wD2LSV2Xy+MZ58nI5A8Q5fnx3o1FxBmOhdk2mvT53vcnzHbppXfHUfrT8OABYSxnx2hIdurAJZkdf
X-Gm-Message-State: AOJu0YxFf6hLZYvzciBuGaS40vg+cV3yDMp1DUWjbJbVt01hn776oKtc
	Bqw7q3EJPiuyCg8W/5ckpMi+N8/kuGEU08kwkck8225XjZvPvFtaiogZ7YWesE/2xKNeIWs4Ath
	tUER8nhlw/6c+JbNsNYjyDwCwuYABaKgq83l8BvxN6MwP8D10DYYkidw=
X-Google-Smtp-Source: AGHT+IFO702Z2izRAjJgapeupiz82wnJAa9eTQc4KZunYijjFtg2EYyHTFnK8yOJ7RUS0UAa+qEhZrzeDymbW80D+zKmHm5DkLbA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:474:e82a:7cec with SMTP id
 m35-20020a05663840a300b00474e82a7cecmr366016jam.1.1709678661395; Tue, 05 Mar
 2024 14:44:21 -0800 (PST)
Date: Tue, 05 Mar 2024 14:44:21 -0800
In-Reply-To: <000000000000a97e9f061287624c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004af86e0612f195c7@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_port_change_check (2)
From: syzbot <syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    885c36e59f46 net: Re-use and set mono_delivery_time bit fo..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c4c66c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=92e06b597766606e
dashboard link: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fe09f2180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167cc5ee180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/241b626fcf71/disk-885c36e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f0f3e287f32/vmlinux-885c36e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c31138ef60ba/bzImage-885c36e5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com

netlink: 'syz-executor286': attribute type 10 has an invalid length.
team0: Port device vlan1 added
netlink: 'syz-executor286': attribute type 10 has an invalid length.
veth0_vlan: left promiscuous mode
veth0_vlan: entered promiscuous mode
============================================
WARNING: possible recursive locking detected
6.8.0-rc6-syzkaller-01978-g885c36e59f46 #0 Not tainted
--------------------------------------------
syz-executor286/5073 is trying to acquire lock:
ffff888077f38d00 (team->team_lock_key){+.+.}-{3:3}, at: team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2995

but task is already holding lock:
ffff888077f38d00 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team.c:1973

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key);
  lock(team->team_lock_key);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor286/5073:
 #0: ffffffff8f378f88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f378f88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6595
 #1: ffff888077f38d00 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team.c:1973

stack backtrace:
CPU: 0 PID: 5073 Comm: syz-executor286 Not tainted 6.8.0-rc6-syzkaller-01978-g885c36e59f46 #0
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
 team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2995
 team_device_event+0x4e6/0x5b0 drivers/net/team/team.c:3018
 notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
 __dev_notify_flags+0x207/0x400
 dev_change_flags+0xf0/0x1a0 net/core/dev.c:8773
 vlan_device_event+0x1b81/0x1de0 net/8021q/vlan.c:468
 notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
 call_netdevice_notifiers net/core/dev.c:2002 [inline]
 dev_open+0x13a/0x1b0 net/core/dev.c:1471
 team_port_add drivers/net/team/team.c:1214 [inline]
 team_add_slave+0x9b3/0x2750 drivers/net/team/team.c:1974
 do_set_master net/core/rtnetlink.c:2688 [inline]
 do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2894
 rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3188
 rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6598
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2547
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1902
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 do_iter_readv_writev+0x46c/0x640
 vfs_writev+0x395/0xbb0 fs/read_write.c:971
 do_writev+0x1b1/0x350 fs/read_write.c:1018
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f5521197a89
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcaa0cf2c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f55211e53d3 RCX: 00007f5521197a89
RDX: 0000000000000001 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007ffcaa0cf2f0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffcaa0cf300
R13: 00007f55211e5004 R14: 00007ffcaa0cf2ec R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

