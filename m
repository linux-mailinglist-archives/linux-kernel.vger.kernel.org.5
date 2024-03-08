Return-Path: <linux-kernel+bounces-97433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D792876A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167161C213D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B01F55E78;
	Fri,  8 Mar 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NqcoGwTs"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAE5102A;
	Fri,  8 Mar 2024 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921036; cv=none; b=qeFWNCmJWtlVO4kkM7RwopwQhqjvcCTWqmJxbXESgDBBmSqePX8/m+5lQaDSXVlaj4tn/8VPhVZPpj9pHAAvXypp0XMIKEDUrMmR3KMxCaB+qyfg+hH6OmIIz2RWLkRS+vCpwHVl4PNFtbLQgzwFxXCgUnbIs6Pdy6KSBdhwxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921036; c=relaxed/simple;
	bh=PAzm2GiniLKpKFC+LeDesWIkkjP8990bk01Z8PFogq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urK3yLA9iIT26cdXrVXmmqmmSVJ1AJLAmVTwtiR28n5SzqENWEmYOXHSKMep+3J9ctab0ea4x96/8dn/s51X/j0CE4OK9u3TVtoyUSHIgQw/lGsdEIF7GN9Lcr9ZI+Hp6Y1+zwWpnHrbguqpVUSfBzQnCiG1rp0DSP1blNz0alk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NqcoGwTs; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709921034; x=1741457034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QveIAf1ldaT9oI1wUssG+IX1MKZ+YUw+EkppgFFt6QA=;
  b=NqcoGwTswY6PVMrJyF+nsub2VdvocfzPzD6132LAduq/Ns0PiMIMqHUp
   ecOHW8pvc8ONZuk40nk9JLLuiNVU5933px8srRqJ0t9vOllBc/hZJOd+a
   SdYAChA9eMF9mybaLCuI0c+nHv6NRgUxZb3LM1zvJRAR3g9mkWlnGJ7El
   0=;
X-IronPort-AV: E=Sophos;i="6.07,110,1708387200"; 
   d="scan'208";a="618388821"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 18:03:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:37089]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.117:2525] with esmtp (Farcaster)
 id b5ba1483-0e78-4d17-989b-b009b39c3e3d; Fri, 8 Mar 2024 18:03:51 +0000 (UTC)
X-Farcaster-Flow-ID: b5ba1483-0e78-4d17-989b-b009b39c3e3d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 18:03:50 +0000
Received: from 88665a182662.ant.amazon.com (10.142.235.16) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 18:03:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING in sk_nulls_del_node_init_rcu
Date: Fri, 8 Mar 2024 10:03:39 -0800
Message-ID: <20240308180339.53907-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iKXHAoJqVkxSGtFep3Ww+A-v9NeExzgfTKubVo7wYX7_Q@mail.gmail.com>
References: <CANn89iKXHAoJqVkxSGtFep3Ww+A-v9NeExzgfTKubVo7wYX7_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 18:36:45 +0100
> On Fri, Mar 8, 2024 at 6:34 PM syzbot
> <syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c055fc00c07b net/rds: fix WARNING in rds_conn_connect_if_d..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16aa17f2180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
> > dashboard link: https://syzkaller.appspot.com/bug?extid=12c506c1aae251e70449
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c39eb6fb3ad1/disk-c055fc00.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/110f1226eb89/vmlinux-c055fc00.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/1303e2df5cc4/bzImage-c055fc00.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com
> >
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
> >  </TASK>
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 23948 at include/net/sock.h:799 sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
> > Modules linked in:
> > CPU: 0 PID: 23948 Comm: syz-executor.2 Not tainted 6.8.0-rc6-syzkaller-00159-gc055fc00c07b #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > RIP: 0010:sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
> > Code: e8 7f 71 c6 f7 83 fb 02 7c 25 e8 35 6d c6 f7 4d 85 f6 0f 95 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 1b 6d c6 f7 90 <0f> 0b 90 eb b2 e8 10 6d c6 f7 4c 89 e7 be 04 00 00 00 e8 63 e7 d2
> > RSP: 0018:ffffc900032d7848 EFLAGS: 00010246
> > RAX: ffffffff89cd0035 RBX: 0000000000000001 RCX: 0000000000040000
> > RDX: ffffc90004de1000 RSI: 000000000003ffff RDI: 0000000000040000
> > RBP: 1ffff1100439ac26 R08: ffffffff89ccffe3 R09: 1ffff1100439ac28
> > R10: dffffc0000000000 R11: ffffed100439ac29 R12: ffff888021cd6140
> > R13: dffffc0000000000 R14: ffff88802a9bf5c0 R15: ffff888021cd6130
> > FS:  00007f3b823f16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f3b823f0ff8 CR3: 000000004674a000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __inet_hash_connect+0x140f/0x20b0 net/ipv4/inet_hashtables.c:1139
> >  dccp_v6_connect+0xcb9/0x1480 net/dccp/ipv6.c:956
> >  __inet_stream_connect+0x262/0xf30 net/ipv4/af_inet.c:678
> >  inet_stream_connect+0x65/0xa0 net/ipv4/af_inet.c:749
> >  __sys_connect_file net/socket.c:2048 [inline]
> >  __sys_connect+0x2df/0x310 net/socket.c:2065
> >  __do_sys_connect net/socket.c:2075 [inline]
> >  __se_sys_connect net/socket.c:2072 [inline]
> >  __x64_sys_connect+0x7a/0x90 net/socket.c:2072
> >  do_syscall_64+0xf9/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> > RIP: 0033:0x7f3b8167dda9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f3b823f10c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> > RAX: ffffffffffffffda RBX: 00007f3b817abf80 RCX: 00007f3b8167dda9
> > RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
> > RBP: 00007f3b823f1120 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
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
> CC Kuniyuki, because this is probably caused by
> 
> commit 66b60b0c8c4a163b022a9f0ad6769b0fd3dc662f
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Wed Feb 14 11:13:08 2024 -0800
> 
>     dccp/tcp: Unhash sk from ehash for tb2 alloc failure after
> check_estalblished().

I'll look into it.

Thanks!

