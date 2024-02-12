Return-Path: <linux-kernel+bounces-62512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D9852230
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA5284CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16654F5FE;
	Mon, 12 Feb 2024 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QVWVS5P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lDBRH2wk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00854EB32;
	Mon, 12 Feb 2024 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778868; cv=none; b=o6PJA588msDg6OI6Ara6sSvE468agwlocmzgr+VpcDzKcLTdBnNOdutriewrwP1LI0JU5LkVs132896hzQhg7iPgCOXxn/VcuaxKQIxgLb6Ggijs7A+IcgDIBAcTWZeLd4DXLVICw+EBA5u+1Zv/4ynr1wwdFJTpaEr9QxLUh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778868; c=relaxed/simple;
	bh=dz7Bo1p6nMIUN4HZJcwpOyE8WVu5se81Ug/mMhzK6uE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pun6XKd8c4auOGiDLrse2MrM/Aet2P1MlkYKst7cnlqEnPbFpgA7fjTVrNHwDioDmINKC4cHFwJX3rRYgpC2+HI0XgeyvU5PqWrC9KMGr+47lXrDTN+KlrqruKN7RLwq4/A7s3cZdV16HRpyV5LcIgXGOL1GKM8v3IMNKebLpJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QVWVS5P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lDBRH2wk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707778863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJvi9CRczxtyvt+qDDAp8M1Cn+0bYcrQ7i1j7oLPeQ0=;
	b=4QVWVS5P8I5fXGOVrY9yhMPnb2fr6bh5DstEwe9iyViUGasAAce0JhykHVrbma4jNBnd4Y
	bJlwmkgZe1xx716rstpRBKVrqHN/THOe88UDz5+ffgYp4IH4rK8tfkb77ht+0E5QwPwMUW
	WvvHYKa3dwoVgL4NvSbZkVOKuVKvDTN078CIHboWrZCFTNkYTuNe1plQ3/MK0URLcf6UL5
	cJKUpVf6phI5gSlUkz5bez5sSyyf1pBVZGicPVXiup2weX1N5hu8bK+PngRyOPbYT0PhjM
	zSxQ8bcSsh2pLO4nNovEs6pAdIZ8lh6aJpLK2kqSIIUTNiA46zrnwItg4/CTqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707778863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJvi9CRczxtyvt+qDDAp8M1Cn+0bYcrQ7i1j7oLPeQ0=;
	b=lDBRH2wkcBL4ybc1JUik/fBkcxnxlfhNUH8/+IaAX1ZpWWS2Aj2u1jJ/vRqlhL2Olqe4/m
	kSBbaC99OGfImqCQ==
To: syzbot <syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in hrtimer_active
In-Reply-To: <00000000000014671906112cb2ef@google.com>
References: <00000000000014671906112cb2ef@google.com>
Date: Tue, 13 Feb 2024 00:01:03 +0100
Message-ID: <875xytjnio.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Cc: +netdev

On Mon, Feb 12 2024 at 02:25, syzbot wrote:
> HEAD commit:    4a7bbe7519b6 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10476de0180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=264238120cdb2bda
> dashboard link: https://syzkaller.appspot.com/bug?extid=039399a9b96297ddedca
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-4a7bbe75.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ee3f97d1ed38/vmlinux-4a7bbe75.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eb6f9f8f9f37/Image-4a7bbe75.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com
>
> infiniband syz0: set active
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> CPU: 1 PID: 3665 Comm: syz-executor.0 Not tainted 6.8.0-rc3-syzkaller-00279-g4a7bbe7519b6 #0
> pc : __seqprop_raw_spinlock_sequence include/linux/seqlock.h:226 [inline]

That's:

        seq = raw_read_seqcount_begin(&base->seq);

where base == NULL. That can only happen when hrtimer_cancel() is
invoked with a non-initialized timer.

> pc : hrtimer_active+0x4/0x60 kernel/time/hrtimer.c:1614
> lr : hrtimer_try_to_cancel+0x1c/0xf8 kernel/time/hrtimer.c:1331
> sp : ffff800082c63300
> x29: ffff800082c63300 x28: 0000000000000000 x27: 0000000000000000
> x26: 0000000000000340 x25: 0000000000000000 x24: f3ff00001ab7e9e0
> x23: 0000000000000000 x22: 000061100fc019e9 x21: 0000000000000009
> x20: 0000000000000000 x19: fbff00001abf9920 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008144d28c
> x14: ffff80008144d20c x13: ffff80008144d28c x12: ffff80008144d20c
> x11: ffff800080011558 x10: ffff800081907d14 x9 : ffff8000819078a4
> x8 : ffff800082c63408 x7 : 0000000000000000 x6 : ffff800080026d20
> x5 : f2ff000033f2c800 x4 : 000061100fc019e9 x3 : 0000000000000340
> x2 : 0000000000000000 x1 : 000000000000000d x0 : fbff00001abf9920
> Call trace:
>  hrtimer_active+0x4/0x60 kernel/time/hrtimer.c:1613
>  hrtimer_cancel+0x1c/0x38 kernel/time/hrtimer.c:1446
>  napi_disable+0x5c/0x11c net/core/dev.c:6502
>  veth_napi_del_range+0x64/0x1d8 drivers/net/veth.c:1109
>  veth_napi_del drivers/net/veth.c:1129 [inline]
>  veth_set_features+0x68/0x98 drivers/net/veth.c:1580
>  __netdev_update_features+0x200/0x6ec net/core/dev.c:9872
>  netdev_update_features+0x28/0x6c net/core/dev.c:9946
>  veth_xdp_set drivers/net/veth.c:1681 [inline]
>  veth_xdp+0x108/0x224 drivers/net/veth.c:1694
>  dev_xdp_install+0x64/0xf8 net/core/dev.c:9243
>  dev_xdp_attach+0x250/0x52c net/core/dev.c:9395
>  dev_change_xdp_fd+0x16c/0x218 net/core/dev.c:9643
>  do_setlink+0xdd0/0xf14 net/core/rtnetlink.c:3132
>  rtnl_group_changelink net/core/rtnetlink.c:3452 [inline]
>  __rtnl_newlink+0x460/0x898 net/core/rtnetlink.c:3711
>  rtnl_newlink+0x50/0x7c net/core/rtnetlink.c:3748
>  rtnetlink_rcv_msg+0x12c/0x380 net/core/rtnetlink.c:6615
>  netlink_rcv_skb+0x5c/0x128 net/netlink/af_netlink.c:2543
>  rtnetlink_rcv+0x18/0x24 net/core/rtnetlink.c:6633
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x2f4/0x360 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0x1a4/0x3e8 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x54/0x60 net/socket.c:745
>  ____sys_sendmsg+0x274/0x2ac net/socket.c:2584
>  ___sys_sendmsg+0xac/0x100 net/socket.c:2638
>  __sys_sendmsg+0x84/0xe0 net/socket.c:2667
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2674

So something in that syzbot test case manages to tear down a napi
context which has not yet been fully initialized. While the rest of
napi_disable() does not care much as long as neither NAPIF_STATE_SCHED
nor NAPIF_STATE_NPSVC are set in napi->state, hrtimer_cancel() pretty
much cares as demonstrated by the NULL pointer dereference.

While it would be trivial to harden the hrtimer code for the case that a
non-initialized hrtimer is canceled, I wonder whether this invocation of
napi_disable() is harmless (aside of the hrtimer issue) or if there are
some hidden subtle issues with that.

Thanks,

        tglx



