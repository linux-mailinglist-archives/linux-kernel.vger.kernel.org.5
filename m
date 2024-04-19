Return-Path: <linux-kernel+bounces-151817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610528AB44D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCB31F22443
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7F13A88D;
	Fri, 19 Apr 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CsLIaXhh"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC913A3E4;
	Fri, 19 Apr 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547398; cv=none; b=obYFR40IEm+gotid+obEFIX58Pt+AdlW10VYwDp1+l3S0nz0ngqRHj0eXC5LK2xGMIYFWdf4O4XI9YRcwtDUH4YAG1+4zTS4WyHZHNhje5NucKp8SJqARzL8soWgu62XvKJ2vsu1uJ93VZW1Q1U0t6ezwhUBnopwkCMsfT2X7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547398; c=relaxed/simple;
	bh=puamuPI71baQimptO7zyeVOerLj1tr1Hqsuh2hoHvK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzKd7WT6dJ+ifU6/iOHsyrTwumvQxogH8QP+Fdet0fX6OWFDhU9QcuKwC4vLrTOc431q6PsINx/TXpKWzjJ813aOeNcbtJnlUQlDtRe/bLhXnTWR66xcZtzvFXuCapM08uYWlpI9vscU0EzYfogoAvYWk3MZOQQPgvF9TdUdYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CsLIaXhh; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713547397; x=1745083397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9q0M0X8NBVjwBl35ZnQ5GxeU28VDX1AEAvGVSY063dA=;
  b=CsLIaXhh9lKLYc7Rdazm0odxdfySDTIVP8jRDLt5aZOoTraN0+JqB8vO
   8dksAxT6S4PU1rKITyxZE5Y8NItJKrWjelTbdGYQLeIcdAdmI1rI4OOpt
   kbvI9e6RAbX4pAiKaRGQETBZbvmCWCYrrMICs4fNp4ldyXzgjyVUWWGdb
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,214,1708387200"; 
   d="scan'208";a="412998639"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 17:23:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:38399]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.190:2525] with esmtp (Farcaster)
 id c3c060b8-6c4d-4fa5-9eb4-01c1fe25df9a; Fri, 19 Apr 2024 17:23:01 +0000 (UTC)
X-Farcaster-Flow-ID: c3c060b8-6c4d-4fa5-9eb4-01c1fe25df9a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 17:23:01 +0000
Received: from 88665a182662.ant.amazon.com (10.119.231.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 19 Apr 2024 17:22:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING in gre_tap_xmit (2)
Date: Fri, 19 Apr 2024 10:22:50 -0700
Message-ID: <20240419172250.83685-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKNcQOcRX1vGVXFBXn1Z2axGS+hWuhxKOAaq8BCo4W0bw@mail.gmail.com>
References: <CANn89iKNcQOcRX1vGVXFBXn1Z2axGS+hWuhxKOAaq8BCo4W0bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 12:10:42 +0200
> On Fri, Apr 19, 2024 at 11:39 AM syzbot
> <syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
> > git tree:       bpf
> > console output: https://syzkaller.appspot.com/x/log.txt?x=165886c3180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c298c9f0e46a3c86332b
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
> > WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_may_pull include/linux/skbuff.h:2756 [inline]
> > WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
> > WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
> > WARNING: CPU: 0 PID: 13407 at include/linux/skbuff.h:2740 gre_tap_xmit+0x4ff/0x6e0 net/ipv4/ip_gre.c:734
> > Modules linked in:
> > CPU: 0 PID: 13407 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
> > RIP: 0010:pskb_may_pull include/linux/skbuff.h:2756 [inline]
> > RIP: 0010:pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
> > RIP: 0010:pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
> > RIP: 0010:gre_tap_xmit+0x4ff/0x6e0 net/ipv4/ip_gre.c:734
> > Code: 00 4c 89 ef 48 89 ee 48 89 da e8 7c 8f fb ff 31 c0 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 62 55 9d f7 90 <0f> 0b 90 e9 09 fc ff ff 44 89 e7 89 ee e8 0f 57 9d f7 41 39 ec 0f
> > RSP: 0018:ffffc90004b66e00 EFLAGS: 00010287
> > RAX: ffffffff89f79b0e RBX: ffff888061667718 RCX: 0000000000040000
> > RDX: ffffc9000c375000 RSI: 00000000000124e0 RDI: 00000000000124e1
> > RBP: 00000000ffffffb6 R08: ffffffff89f79712 R09: 1ffffffff1f0d5cd
> > R10: dffffc0000000000 R11: ffffffff89f79610 R12: 0000000000000000
> > R13: ffff888061667640 R14: ffff888062b64000 R15: dffffc0000000000
> > FS:  00007f08d29ff6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020010000 CR3: 0000000061678000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> > Call Trace:
> >  <TASK>
> >  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
> >  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
> >  xmit_one net/core/dev.c:3531 [inline]
> >  dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
> >  sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
> >  __dev_xmit_skb net/core/dev.c:3760 [inline]
> >  __dev_queue_xmit+0x1912/0x3b10 net/core/dev.c:4301
> >  bond_start_xmit+0x1389/0x1c40 drivers/net/bonding/bond_main.c:5469
> >  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
> >  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
> >  xmit_one net/core/dev.c:3531 [inline]
> >  dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
> >  __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
> >  packet_snd net/packet/af_packet.c:3083 [inline]
> >  packet_sendmsg+0x4932/0x63d0 net/packet/af_packet.c:3115
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg+0x221/0x270 net/socket.c:745
> >  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
> >  ___sys_sendmsg net/socket.c:2638 [inline]
> >  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
> >  do_syscall_64+0xfb/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > RIP: 0033:0x7f08d2e7dea9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f08d29ff0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007f08d2fabf80 RCX: 00007f08d2e7dea9
> > RDX: 00000000200400c4 RSI: 0000000020000180 RDI: 0000000000000006
> > RBP: 00007f08d2eca4a4 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000000b R14: 00007f08d2fabf80 R15: 00007ffcba0da4f8
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> 
> Kuniyuki , this is another manifestation of NSH bug, thanks !

Thanks, will take a look at the repro !

I got a similar v6 gre splat yesterday with no repro, but
this v4 one has, nice :)

Call trace:
 pskb_may_pull_reason include/linux/skbuff.h:2740 [inline]
 pskb_may_pull include/linux/skbuff.h:2756 [inline]
 pskb_network_may_pull include/linux/skbuff.h:3077 [inline]
 pskb_inet_may_pull include/net/ip_tunnels.h:361 [inline]
 ip6gre_tunnel_xmit+0xea0/0x13b8 net/ipv6/ip6_gre.c:901

