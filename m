Return-Path: <linux-kernel+bounces-106248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFE987EB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C426B227D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10C4E1B5;
	Mon, 18 Mar 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuQrv8ea"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D14D9EC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773212; cv=none; b=PTeBwFcRQ+8fnmbRHBillcP0xySPvDED1LtSydtZcQkPW6ycnwKnVt8EnRLoZM1KaBhfai4xsG2oYTsMqJAT+sYj5PNbqKXXDO5y19vaK+/Bf4SltFikgrshf2D1+TVZac4ZxKFb90WSotZ+tv2i/MCZoqG6975DNAmZZppASn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773212; c=relaxed/simple;
	bh=ziidudFLEe4skD6hG9sfaAp4YHmbkk5sirG6GeIGKpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9R5Z7i8GLe2NZ3QZ0BBXgoc+oCAs3X2KBZHcOE3OgKetFOGrvf2+x4hepTIiG2z9/YXFlt88MjIGOV8fKZ/HrJO+HRjpcElmX3Fn8Eq9joVMAP58rTQPj8jQq26IGXdeBj3BIDQwKhJ/1VeBh0jU8F7wxcPYL5/d4ozt2f64Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuQrv8ea; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-568d160155aso10189a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710773208; x=1711378008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rvN70qnpmInI/F7BaI0PXo0E0JO4DIK4z5aYsstS+o=;
        b=XuQrv8ea1vOigUHIoMw/lEND0YGyZvPUwyi7+9Peu8HxHS+LwsweAz+LJ5fojx8xfC
         6J6bhr6nEuUkFaV0cb5Tqa2g121sUWtO8lzsOGVZroP7C6ehrNMGXeesWt5dTG84+Ux3
         rcmHuwxwUbSg8KqktOjU3kTnDE2/yqHwcmpxLykBXtu7mehkdMCYl4zg7crv/hQMRQzk
         b6+FjiK2YlYeq1kgkvqSYnoQEtrLTkPfnbUdPmiP7zajmlG0Gy45PO14DsMHyb4Us8eW
         ea16qjE8Qzmc1KW3Ibi37ojFrN8b7h45fcu44pUvJ02tuCfb6dkWd/h8Xib2pqhgrbNn
         fW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710773208; x=1711378008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rvN70qnpmInI/F7BaI0PXo0E0JO4DIK4z5aYsstS+o=;
        b=BrUI3v0sCbyLd0Kco8Kjbq1M+DGrO7/oRY8JrzvY7sjgC8iXbnv1CHLFaI349pWzdh
         N6ch+XpUhrBw9hnYI3QviGyw/Vfm7Izh3ifQn7rMAxJzotZ8mKWgsVmrw3jAY1ut0e70
         2HqKa4yAK+qHpiKpmGeWLJt9pLs7idgbyYo/gnPWHLFk+LfmfuqyEuO6pvyF/3e4qSqr
         yvZu/Ajwn+KV11HT5tS9UnkXfkP4WoEW8kkMdd55XnMSzPfGR3qyRFhbWEQdaFEYRTsD
         Bm+fV9uvFX1jDL8drK1UaWo6ZGyLMbhnLYgJVIqA78Z+EwUOQZ2VqmBlYbLkvPZghJ3E
         7wsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt0Wj2ckakcTh1hEu4yYQSl/X3GF7ItYTEKfrE8/KdrhGjY7HwbZTPcpCAtXjiTbhjeblGOX86fTsa1Ca47Je8dfRFgGAOVxAOE0lI
X-Gm-Message-State: AOJu0YxQnxsyPbwZRnb6hZxjJTuSDh0KZ75tvQ/Jr/AClZhpfLXKLwjA
	xo42De2trjxerxd3FKPC6/aypelZhtlLsMMMGP/DtUwxTxWRQqTSklRmNbpzaYqmVsEOAQrIqAq
	/Jy7/vFbEMOcvfnMfP8M9g3hxnJVJhoHD7MJZ
X-Google-Smtp-Source: AGHT+IFq6bEhaCqjSlVKkb/syx+X8OXqYUhFtes/z/qTAeb3qGQd4cw9i4t0tDPLaXu2oYBevScWYyPv5DuGBYWLius=
X-Received: by 2002:aa7:ce1a:0:b0:56a:9183:214 with SMTP id
 d26-20020aa7ce1a000000b0056a91830214mr126833edv.0.1710773208027; Mon, 18 Mar
 2024 07:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009485160613eda067@google.com>
In-Reply-To: <0000000000009485160613eda067@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Mar 2024 15:46:37 +0100
Message-ID: <CANn89iKnOzz_Bs_ygLWZGjsTw=266p8KALv=QWheTanoHYj+nw@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in register_nexthop_notifier (3)
To: syzbot <syzbot+99b8125966713aa4b0c3@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 12:26=E2=80=AFPM syzbot
<syzbot+99b8125966713aa4b0c3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    76839e2f1fde net/packet: Add getsockopt support for PACKE=
T..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c38e3e18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D63afafeedf00e=
f8f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D99b8125966713aa=
4b0c3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1fdcc43b8d91/dis=
k-76839e2f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7710da23cc3a/vmlinu=
x-76839e2f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2b8715f33de4/b=
zImage-76839e2f.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+99b8125966713aa4b0c3@syzkaller.appspotmail.com
>
> INFO: task syz-executor.3:6975 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc7-syzkaller-02500-g76839e2f1fde #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.3  state:D stack:20920 pid:6975  tgid:6975  ppid:1     =
 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3863
>  nsim_fib_create+0x8a6/0xa70 drivers/net/netdevsim/fib.c:1587
>  nsim_drv_probe+0x747/0xb80 drivers/net/netdevsim/dev.c:1582
>  really_probe+0x29e/0xc50 drivers/base/dd.c:658
>  __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
>  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
>  __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
>  bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
>  __device_attach+0x333/0x520 drivers/base/dd.c:1030
>  bus_probe_device+0x189/0x260 drivers/base/bus.c:532
>  device_add+0x8ff/0xca0 drivers/base/core.c:3639
>  nsim_bus_dev_new drivers/net/netdevsim/bus.c:442 [inline]
>  new_device_store+0x3f2/0x890 drivers/net/netdevsim/bus.c:173
>  kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334

So we have a sysfs handler ultimately calling register_nexthop_notifier() o=
r any
other network control path requiring RTNL.

Note that we have rtnl_trylock() for a reason...

Or maybe the reason is wrong, if we could change kernfs_fop_write_iter()
to no longer hold a mutex...

>  call_write_iter include/linux/fs.h:2087 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa81/0xcb0 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f12ecc7caef
> RSP: 002b:00007ffd6d32df00 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f12ecc7caef
> RDX: 0000000000000003 RSI: 00007ffd6d32df50 RDI: 0000000000000005
> RBP: 00007f12eccca045 R08: 0000000000000000 R09: 00007ffd6d32dd57
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 00007ffd6d32df50 R14: 00007f12ed8d4620 R15: 0000000000000003
>  </TASK>
> INFO: task syz-executor.2:7486 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc7-syzkaller-02500-g76839e2f1fde #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.2  state:D stack:26768 pid:7486  tgid:7483  ppid:5094  =
 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  rtnl_lock net/core/rtnetlink.c:79 [inline]
>  rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f406d87dda9
> RSP: 002b:00007f406e5dd0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f406d9abf80 RCX: 00007f406d87dda9
> RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
> RBP: 00007f406d8ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f406d9abf80 R15: 00007ffe1ff0e4a8
>  </TASK>
> INFO: task syz-executor.0:7485 blocked for more than 144 seconds.
>       Not tainted 6.8.0-rc7-syzkaller-02500-g76839e2f1fde #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.0  state:D stack:26768 pid:7485  tgid:7484  ppid:5093  =
 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  rtnl_lock net/core/rtnetlink.c:79 [inline]
>  rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f7143c7dda9
> RSP: 002b:00007f714491f0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f7143dabf80 RCX: 00007f7143c7dda9
> RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
> RBP: 00007f7143cca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f7143dabf80 R15: 00007ffe6918ff78
>  </TASK>
> INFO: task syz-executor.4:7489 blocked for more than 144 seconds.
>       Not tainted 6.8.0-rc7-syzkaller-02500-g76839e2f1fde #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.4  state:D stack:25520 pid:7489  tgid:7488  ppid:5107  =
 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  ieee802154_nl_fill_phy+0xf2/0x790 net/ieee802154/nl-phy.c:45
>  ieee802154_dump_phy_iter+0x110/0x200 net/ieee802154/nl-phy.c:129
>  class_for_each_device+0x262/0x380 drivers/base/class.c:404
>  wpan_phy_for_each+0xbf/0x100 net/ieee802154/core.c:62
>  ieee802154_dump_phy+0x160/0x290 net/ieee802154/nl-phy.c:154
>  genl_dumpit+0x107/0x1a0 net/netlink/genetlink.c:1025
>  netlink_dump+0x6ff/0xe50 net/netlink/af_netlink.c:2269
>  __netlink_dump_start+0x59d/0x780 net/netlink/af_netlink.c:2386
>  genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1074 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1190 [inline]
>  genl_rcv_msg+0x88c/0xec0 net/netlink/genetlink.c:1208
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7fdbb3e7dda9
> RSP: 002b:00007fdbb4b300c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fdbb3fabf80 RCX: 00007fdbb3e7dda9
> RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000004
> RBP: 00007fdbb3eca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fdbb3fabf80 R15: 00007ffc0809fb68
>  </TASK>
> INFO: task syz-executor.1:7491 blocked for more than 145 seconds.
>       Not tainted 6.8.0-rc7-syzkaller-02500-g76839e2f1fde #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:27536 pid:7491  tgid:7490  ppid:6204  =
 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  genl_lock net/netlink/genetlink.c:33 [inline]
>  genl_op_lock net/netlink/genetlink.c:58 [inline]
>  genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1207
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
>  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x8e0/0xcb0 net/netlink/af_netlink.c:1905
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2199
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f13f947fa9c
> RSP: 002b:00007f13fa1eef60 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f13fa1ef050 RCX: 00007f13f947fa9c
> RDX: 0000000000000020 RSI: 00007f13fa1ef0a0 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 00007f13fa1eefb4 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000004
> R13: 00007f13fa1ef008 R14: 00007f13fa1ef0a0 R15: 0000000000000000
>  </TASK>
>
> Showing all locks held in the system:
> 2 locks held by kworker/u4:1/12:
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:298 [inline]
>  #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:750 [inline]
>  #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_loc=
ks+0x55/0x2a0 kernel/locking/lockdep.c:6614
> 2 locks held by getty/4820:
>  #0: ffff888029f0d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wa=
it+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_r=
ead+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
> 5 locks held by kworker/u4:7/23559:
>  #0: ffff888015ea4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:2608 [inline]
>  #0: ffff888015ea4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_sch=
eduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #1: ffffc90012b8fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_one_wor=
k kernel/workqueue.c:2608 [inline]
>  #1: ffffc90012b8fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_schedul=
ed_works+0x825/0x1420 kernel/workqueue.c:2706
>  #2: ffffffff8f36d250 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x1=
6a/0xcc0 net/core/net_namespace.c:591
>  #3: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: cleanup_net+0x6af/0xc=
c0 net/core/net_namespace.c:627
>  #4: ffffffff8e136440 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barr=
ier+0x4c/0x550 kernel/rcu/tree.c:4064
> 1 lock held by syz-executor.3/895:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/ne=
t/tun.c:698 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x=
1b0 drivers/net/tun.c:3498
> 1 lock held by syz-executor.3/2766:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/ne=
t/tun.c:698 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x=
1b0 drivers/net/tun.c:3498
> 1 lock held by syz-executor.3/4747:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/ne=
t/tun.c:698 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x=
1b0 drivers/net/tun.c:3498
> 7 locks held by syz-executor.3/6975:
>  #0: ffff888029d6a420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write in=
clude/linux/fs.h:2794 [inline]
>  #0: ffff888029d6a420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x233/0xc=
b0 fs/read_write.c:586
>  #1: ffff88809c7ab888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter=
+0x1eb/0x500 fs/kernfs/file.c:325
>  #2: ffff888021caba00 (kn->active#51){.+.+}-{0:0}, at: kernfs_fop_write_i=
ter+0x20f/0x500 fs/kernfs/file.c:326
>  #3: ffffffff8ecb8508 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_devic=
e_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
>  #4: ffff88809acf50e8 (&dev->mutex){....}-{3:3}, at: device_lock include/=
linux/device.h:990 [inline]
>  #4: ffff88809acf50e8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e=
/0x520 drivers/base/dd.c:1005
>  #5: ffff88809acf0250 (&devlink->lock_key#7){+.+.}-{3:3}, at: nsim_drv_pr=
obe+0xcb/0xb80 drivers/net/netdevsim/dev.c:1534
>  #6: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_noti=
fier+0x84/0x290 net/ipv4/nexthop.c:3863
> 1 lock held by syz-executor.2/7486:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.0/7485:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 4 locks held by syz-executor.4/7489:
>  #0: ffffffff8f3de3b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/n=
etlink/genetlink.c:1216
>  #1: ffff88808f3dd678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_d=
ump_start+0x119/0x780 net/netlink/af_netlink.c:2350
>  #2: ffffffff8f3de268 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink=
/genetlink.c:33 [inline]
>  #2: ffffffff8f3de268 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netl=
ink/genetlink.c:58 [inline]
>  #2: ffffffff8f3de268 (genl_mutex){+.+.}-{3:3}, at: genl_dumpit+0xd6/0x1a=
0 net/netlink/genetlink.c:1024
>  #3: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: ieee802154_nl_fill_ph=
y+0xf2/0x790 net/ieee802154/nl-phy.c:45
> 2 locks held by syz-executor.1/7491:
>  #0: ffffffff8f3de3b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/n=
etlink/genetlink.c:1216
>  #1: ffffffff8f3de268 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink=
/genetlink.c:33 [inline]
>  #1: ffffffff8f3de268 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netl=
ink/genetlink.c:58 [inline]
>  #1: ffffffff8f3de268 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0x=
ec0 net/netlink/genetlink.c:1207
> 3 locks held by kworker/u4:0/7496:
>  #0: ffff88802998bd38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: pro=
cess_one_work kernel/workqueue.c:2608 [inline]
>  #0: ffff88802998bd38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: pro=
cess_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #1: ffffc9000314fd20 ((work_completion)(&(&net->ipv6.addr_chk_work)->wor=
k)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #1: ffffc9000314fd20 ((work_completion)(&(&net->ipv6.addr_chk_work)->wor=
k)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.=
c:2706
>  #2: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+=
0x19/0x30 net/ipv6/addrconf.c:4731
> 1 lock held by syz-executor.0/7498:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.4/7505:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.1/7506:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.2/7509:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.3/7516:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.0/7528:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.4/7533:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.1/7537:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.2/7539:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
> 1 lock held by syz-executor.3/7543:
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x8=
42/0x10d0 net/core/rtnetlink.c:6592
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> NMI backtrace for cpu 0
> CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc7-syzkaller-02500-g76=
839e2f1fde #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
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
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 12 Comm: kworker/u4:1 Not tainted 6.8.0-rc7-syzkaller-02500-g=
76839e2f1fde #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> Workqueue: bat_events batadv_nc_worker
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:89 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
> RIP: 0010:kasan_check_range+0x8c/0x290 mm/kasan/generic.c:189
> Code: 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 0=
0 4c 89 cd 48 f7 d5 48 01 dd 41 80 3b 00 0f 85 c9 01 00 00 <49> ff c3 48 ff=
 c5 75 ee e9 1e 01 00 00 45 89 dc 41 83 e4 07 0f 84
> RSP: 0018:ffffc90000117860 EFLAGS: 00000046
> RAX: 0000000000000001 RBX: 1ffffffff259469f RCX: ffffffff81713084
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff92ca34f8
> RBP: ffffffffffffffff R08: ffffffff92ca34ff R09: 1ffffffff259469f
> R10: dffffc0000000000 R11: fffffbfff259469f R12: ffff888016ead940
> R13: ffff888016ead940 R14: dffffc0000000001 R15: fffffbfff25946a0
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c00b564de0 CR3: 000000000df32000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inli=
ne]
>  hlock_class kernel/locking/lockdep.c:228 [inline]
>  __lock_acquire+0x1264/0x1fd0 kernel/locking/lockdep.c:5134
>  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
>  spin_lock_bh include/linux/spinlock.h:356 [inline]
>  batadv_nc_purge_paths+0xe8/0x3b0 net/batman-adv/network-coding.c:442
>  batadv_nc_worker+0x365/0x610 net/batman-adv/network-coding.c:722
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
>  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

