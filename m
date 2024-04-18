Return-Path: <linux-kernel+bounces-150542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB668AA0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A68285B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE41174EF1;
	Thu, 18 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DVDkuqQe"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894617109D;
	Thu, 18 Apr 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460049; cv=none; b=MlNSMgk62vcHXE03b0BVMGi+LpMCBfmd6mhtZnguQN8QDksTzU1BneKgOBc/3EnaZLI1PDGJOe+F4H2UGmRoA1ynPkHoyuExefpfrN8GzjqQPXTcXMxSkV7YwS10pnunnOjuIMV9KF4Zpz1Z3PAvGZxnykByMVBwYzQA5DyB8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460049; c=relaxed/simple;
	bh=CM8nI49mltTWyh4988wuYDUXZS3yI7+5n5mJ6JmHjME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/Ccby9z5VA0K10N7WuhtDrXqPBbe2frRzuodFSV5oDvO9cjwALChPjFmkmmUvX0cAe4oqlHGibaBh2rnlRbqk20hmrUG1EGfVubhay9kT1AaK1nX4urrU/t6fAeoIts+w0a9zl76BHxQTDyjoGlaimsIgfwKyIRs/SU9ZPKiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DVDkuqQe; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713460047; x=1744996047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TnpL60BmwUQXb8PJ1rdJnfwkYwzlGEVJGSnW8ntW7ww=;
  b=DVDkuqQe9afaKYg5GwT8qTpUPMoz8Irw3fcgZ17v6sZQA7kprWIorOBa
   yKPk2qyY8lVJl3Sjrpv/GJJ4YAxSCnk9Dxw09stF5G65/uTr8++52gPY0
   /VPT552Bl/FRP/qGBxkQSAPNxg4wfrVFpewAdPIppZRku84hmv63QMePg
   g=;
X-IronPort-AV: E=Sophos;i="6.07,212,1708387200"; 
   d="scan'208";a="289833836"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 17:07:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:14707]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.251:2525] with esmtp (Farcaster)
 id 68146c37-eb72-4c08-a36e-2026240dca63; Thu, 18 Apr 2024 17:07:25 +0000 (UTC)
X-Farcaster-Flow-ID: 68146c37-eb72-4c08-a36e-2026240dca63
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 17:07:24 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 18 Apr 2024 17:07:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in ipvlan_queue_xmit (2)
Date: Thu, 18 Apr 2024 10:07:13 -0700
Message-ID: <20240418170713.24385-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iLFjPiWdLw170ng2=9juwMnN8TxrKd1D1MntWPhWRxt-g@mail.gmail.com>
References: <CANn89iLFjPiWdLw170ng2=9juwMnN8TxrKd1D1MntWPhWRxt-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 09:19:20 +0200
> On Thu, Apr 18, 2024 at 9:05 AM syzbot
> <syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.ker..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=144a8d4a180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
> > dashboard link: https://syzkaller.appspot.com/bug?extid=42a0dc856239de4de60e
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149caa54180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bb8e22180000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0dabc03369d1/disk-f2e367d6.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/240ca250d398/vmlinux-f2e367d6.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/cc38bcdb48c9/bzImage-f2e367d6.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com
> >
> > =====================================================
> > BUG: KMSAN: uninit-value in ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:524 [inline]
> > BUG: KMSAN: uninit-value in ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
> > BUG: KMSAN: uninit-value in ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ipvlan/ipvlan_core.c:668
> >  ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:524 [inline]
> >  ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
> >  ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ipvlan/ipvlan_core.c:668
> >  ipvlan_start_xmit+0x5c/0x1a0 drivers/net/ipvlan/ipvlan_main.c:222
> >  __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
> >  netdev_start_xmit include/linux/netdevice.h:5003 [inline]
> >  xmit_one net/core/dev.c:3547 [inline]
> >  dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
> >  __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
> >  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
> >  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
> >  packet_snd net/packet/af_packet.c:3081 [inline]
> >  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg net/socket.c:745 [inline]
> >  __sys_sendto+0x735/0xa10 net/socket.c:2191
> >  __do_sys_sendto net/socket.c:2203 [inline]
> >  __se_sys_sendto net/socket.c:2199 [inline]
> >  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> > Uninit was created at:
> >  slab_post_alloc_hook mm/slub.c:3819 [inline]
> >  slab_alloc_node mm/slub.c:3860 [inline]
> >  __do_kmalloc_node mm/slub.c:3980 [inline]
> >  __kmalloc_node_track_caller+0x705/0x1000 mm/slub.c:4001
> >  kmalloc_reserve+0x249/0x4a0 net/core/skbuff.c:582
> >  __alloc_skb+0x352/0x790 net/core/skbuff.c:651
> >  skb_segment+0x20aa/0x7080 net/core/skbuff.c:4647
> >  udp6_ufo_fragment+0xcab/0x1150 net/ipv6/udp_offload.c:109
> >  ipv6_gso_segment+0x14be/0x2ca0 net/ipv6/ip6_offload.c:152
> >  skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
> >  nsh_gso_segment+0x6f4/0xf70 net/nsh/nsh.c:108
> >  skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
> >  __skb_gso_segment+0x4b0/0x730 net/core/gso.c:124
> >  skb_gso_segment include/net/gso.h:83 [inline]
> >  validate_xmit_skb+0x107f/0x1930 net/core/dev.c:3628
> >  __dev_queue_xmit+0x1f28/0x51c0 net/core/dev.c:4343
> >  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
> >  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
> >  packet_snd net/packet/af_packet.c:3081 [inline]
> >  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
> >  sock_sendmsg_nosec net/socket.c:730 [inline]
> >  __sock_sendmsg net/socket.c:745 [inline]
> >  __sys_sendto+0x735/0xa10 net/socket.c:2191
> >  __do_sys_sendto net/socket.c:2203 [inline]
> >  __se_sys_sendto net/socket.c:2199 [inline]
> >  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> > CPU: 1 PID: 5101 Comm: syz-executor421 Not tainted 6.8.0-rc5-syzkaller-00297-gf2e367d6ad3b #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > =====================================================
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
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
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
> Cc Kuniyuki Iwashima
> 
> This is the syzbot bug I mentioned earlier to you.

Will look into it.

Thanks!

