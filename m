Return-Path: <linux-kernel+bounces-61339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B03851141
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF401C2231F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62525383BF;
	Mon, 12 Feb 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sDhq388a"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B62BAEA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734517; cv=none; b=dKDVhNO1wYaDT6FvCMqzJFXNxhUfu8+hytwZC40WvoVyuNkIIiKbJ8uYuKrzxJhSaaeCy5dJv4ElwZtny67+eDTV+2Ovx6qwgb6rizcBbte8SO0/8xScvrbr4ca8HtOjHRMfzswVLPFKB2DAUPbB4BucoenzsxgmrGWbO3ZLz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734517; c=relaxed/simple;
	bh=sb+BUbpAKNdAjV5BfvBUmozIG93UDVkuI+FFaQoAjp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yz0cUezlsL4QLd9D+UwPwqd1NNIKGznHWUE4D6riTwkxJ5VA+hU0LpJX3jcbqfQDHThtRRImmJvWy7i8OPxxsN/E40v9GIYxACFH/lKtrNq39NGs5ZyueR1o+8vDPMrosOX/e9T8zfWBZb2bTYSLq7bLaun/M4jRVZPP9rUy/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDhq388a; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56154f4c9c8so17861a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707734513; x=1708339313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+78diOCZPHLp3izRsQEIMDqxF/GnwBM3MnY4r3LURs=;
        b=sDhq388atdZxf+oHowYc5CIfyYTejfg8Vw3CfjvvvwIMgqPZcDYKBdcVFkSM/wvvRC
         vxyOYA1UJTEthQdjnl3WDkcGdrkXv4pb3+MTsWjEaqkUhefE05p/KGasysKZRumLR91P
         B0v15tbKkOxftmqLejyrIdf3k+60RdKiLjAse907RhJ6XGXCDipOAGHj43n2181EMRGH
         9WKHuug673a9dLKP2v1WTmx3QfGrbeMA/s3zO8CmaKbmG3LxSEcg1PrP/p3j3cBqrM9u
         MboFuozwMgJ0yPWzngYoCxovPe2QJrfTZT+Xpv1Q86Buk4WdXOfS8w+5zjIv/hOip+hA
         lG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734513; x=1708339313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+78diOCZPHLp3izRsQEIMDqxF/GnwBM3MnY4r3LURs=;
        b=fQ3UqYbxi4rEHDM15NYZN5otH1TKEGLaaYt/H5Of8R1f+G1ivqY9ce8FfQuqTBuDTk
         SdCquJRomWUWFSW1NQdGJ8NwXr/RPbw/IQvaBJakZzjMl9SxuX7zlXrlJW0Kjuqrti3O
         EiKh+92CCgD9+mQzbsWkucFyHZqy8zVY8tMdkO/GjeCQxTB4eb3yFLtVQYrS8EkkrUkz
         JccG6QkQ14VkATPm/dA2TkIZHjIemJzcEm3uzfnR938Tf9Xb0qQgOBWeslkJa+L2+xkt
         Y6k+8xT8TOm9qS308U0jNC299wwKCajLcpQHTy2N9OvqAKC4gIi6ZvKb87RjB3ZlAnjs
         JYlw==
X-Gm-Message-State: AOJu0Yw3HySsqMnSCYBKWP60lFq89lYVdVNmYqly4YwEUESg2sIC141S
	Du+zdyl3/VhTjGK+bFuWX+Qi11hsFnHT5Kd3L1eXp3z+vFyyOwBR6W7fMiPewKdGz1m4u0Z0EaF
	7cgrF3w3VmYcfE5GDpUt5sZ8UAKaP3ojoU2Js
X-Google-Smtp-Source: AGHT+IFJ2TR8vLIjcwFGIqV1t5PL/WV6+3mRWSzVhvtQmnWz17FztMyRhFL7k6YnS0/tmXT1yBl4qprTazklTi+mZmY=
X-Received: by 2002:a50:8a93:0:b0:55f:8851:d03b with SMTP id
 j19-20020a508a93000000b0055f8851d03bmr195865edj.5.1707734513245; Mon, 12 Feb
 2024 02:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ae28ce06112cb52e@google.com>
In-Reply-To: <000000000000ae28ce06112cb52e@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Feb 2024 11:41:38 +0100
Message-ID: <CANn89iKPYAY226+kV9D0jUn6Kfjq1gQJBAjSRxxFgQJK-QbLwA@mail.gmail.com>
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
To: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, 
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:26=E2=80=AFAM syzbot
<syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    41bccc98fb79 Linux 6.8-rc2
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1420011818000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D451a1e62b11ea=
4a6
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da6a4b5bb3da1655=
94cff
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0772069e29cf/dis=
k-41bccc98.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/659d3f0755b7/vmlinu=
x-41bccc98.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7780a45c3e51/I=
mage-41bccc98.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com
>
> watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [syz-executor.0:28718]
> Modules linked in:
> irq event stamp: 45929391
> hardirqs last  enabled at (45929390): [<ffff8000801d9dc8>] __local_bh_ena=
ble_ip+0x224/0x44c kernel/softirq.c:386
> hardirqs last disabled at (45929391): [<ffff80008ad57108>] __el1_irq arch=
/arm64/kernel/entry-common.c:499 [inline]
> hardirqs last disabled at (45929391): [<ffff80008ad57108>] el1_interrupt+=
0x24/0x68 arch/arm64/kernel/entry-common.c:517
> softirqs last  enabled at (2040): [<ffff80008002189c>] softirq_handle_end=
 kernel/softirq.c:399 [inline]
> softirqs last  enabled at (2040): [<ffff80008002189c>] __do_softirq+0xac8=
/0xce4 kernel/softirq.c:582
> softirqs last disabled at (2052): [<ffff80008aacbc40>] spin_lock_bh inclu=
de/linux/spinlock.h:356 [inline]
> softirqs last disabled at (2052): [<ffff80008aacbc40>] batadv_tt_local_re=
size_to_mtu+0x60/0x154 net/batman-adv/translation-table.c:3949
> CPU: 1 PID: 28718 Comm: syz-executor.0 Not tainted 6.8.0-rc2-syzkaller-g4=
1bccc98fb79 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : should_resched arch/arm64/include/asm/preempt.h:79 [inline]
> pc : __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:388
> lr : __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
> sp : ffff80009a0670b0
> x29: ffff80009a0670c0 x28: ffff70001340ce60 x27: ffff80009a0673d0
> x26: ffff00011e860290 x25: ffff0000d08a9f08 x24: 0000000000000001
> x23: 1fffe00023d4d3c1 x22: dfff800000000000 x21: ffff80008aacbf98
> x20: 0000000000000202 x19: ffff00011ea69e08 x18: ffff80009a066800
> x17: 77656e2074696620 x16: ffff80008031ffc8 x15: 0000000000000001
> x14: 1fffe0001ba5a290 x13: 0000000000000000 x12: 0000000000000003
> x11: 0000000000040000 x10: 0000000000000003 x9 : 0000000000000000
> x8 : 0000000002bcd3ae x7 : ffff80008aacbe30 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000002 x1 : ffff80008aecd7e0 x0 : ffff80012545c000
> Call trace:
>  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
>  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
>  __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:386
>  __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
>  _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:210
>  spin_unlock_bh include/linux/spinlock.h:396 [inline]
>  batadv_tt_local_purge+0x264/0x2e8 net/batman-adv/translation-table.c:135=
6
>  batadv_tt_local_resize_to_mtu+0xa0/0x154 net/batman-adv/translation-tabl=
e.c:3956
>  batadv_update_min_mtu+0x74/0xa4 net/batman-adv/hard-interface.c:651
>  batadv_netlink_set_mesh+0x50c/0x1078 net/batman-adv/netlink.c:500
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
>  genl_rcv_msg+0x874/0xb6c net/netlink/genetlink.c:1208
>  netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2543
>  genl_rcv+0x38/0x50 net/netlink/genetlink.c:1217
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x26c/0x33c net/socket.c:2667
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-syzkaller-g41bccc98fb=
79 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:51
> lr : default_idle_call+0xf8/0x128 kernel/sched/idle.c:103
> sp : ffff80008ebe7cd0
> x29: ffff80008ebe7cd0 x28: dfff800000000000 x27: 1ffff00011d7cfa8
> x26: ffff80008ec6d000 x25: 0000000000000000 x24: 0000000000000001
> x23: 1ffff00011d8da74 x22: ffff80008ec6d3a0 x21: 0000000000000000
> x20: ffff80008ec94e00 x19: ffff8000802cff08 x18: 1fffe000367ff796
> x17: ffff80008ec6d000 x16: ffff8000802cf7cc x15: 0000000000000001
> x14: 1fffe00036801310 x13: 0000000000000000 x12: 0000000000000003
> x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
> x8 : 0000000000bf0413 x7 : ffff800080461668 x6 : 0000000000000000
> x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008ad5af48
> x2 : 0000000000000000 x1 : ffff80008aecd7e0 x0 : ffff80012543a000
> Call trace:
>  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
>  arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:49
>  cpuidle_idle_call kernel/sched/idle.c:170 [inline]
>  do_idle+0x1f0/0x4e8 kernel/sched/idle.c:312
>  cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:410
>  rest_init+0x2dc/0x2f4 init/main.c:730
>  start_kernel+0x0/0x4e8 init/main.c:827
>  start_kernel+0x3e8/0x4e8 init/main.c:1072
>  __primary_switched+0xb4/0xbc arch/arm64/kernel/head.S:523
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

This patch [1] looks suspicious

I think batman-adv should reject too small MTU values.

[1]

commit d8e42a2b0addf238be8b3b37dcd9795a5c1be459
Author: Sven Eckelmann <sven@narfation.org>
Date:   Wed Jul 19 10:01:15 2023 +0200

    batman-adv: Don't increase MTU when set by user

    If the user set an MTU value, it usually means that there are special
    requirements for the MTU. But if an interface gots activated, the MTU w=
as
    always recalculated and then the user set value was overwritten.

    The only reason why this user set value has to be overwritten, is when =
the
    MTU has to be decreased because batman-adv is not able to transfer pack=
ets
    with the user specified size.

    Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
    Cc: stable@vger.kernel.org
    Signed-off-by: Sven Eckelmann <sven@narfation.org>
    Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

