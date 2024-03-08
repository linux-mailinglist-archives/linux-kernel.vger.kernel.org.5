Return-Path: <linux-kernel+bounces-97491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA274876B01
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E643F1C21880
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04E59140;
	Fri,  8 Mar 2024 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gMfmjehV"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EBC225D4;
	Fri,  8 Mar 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924515; cv=none; b=n4j95crvv7QzwlEDy46ctULa+LyKg3gOmZaTMB7F0IJM47H1dJyblxDQ28P4OwANsYmyvSH/FOMJacjecC7dB4QOgTX/gUD8QfGakEhYlJSWFQjOGtkc7e2Yt9d5EfzwTmSpn9gs65lAZChm3QQGUtDF7Ho+Fun/4UdK4/l6QNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924515; c=relaxed/simple;
	bh=m+eeRPdseEbp1q6czC2WNsFEAQDLt512Oea/8oYoztg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRG9KHm9KpLOmdgwYLOvuzvYdz5SAiBPjC6bFViQUjPE3wqGgeO0xlOe9tn4DOVfTX7aC8iEsGZlmyoA2eLGOSM809Z70vGouBC/CXfYPs+EwayeA9KGaX4j1MRYunzggzzLm3Pc+jyMTU9rZV1+N1W+/wzRRWeejEY8Z1fL1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gMfmjehV; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709924513; x=1741460513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zl4aK2NfwrOO4Bg03NI8PJKDWOogDZuHv69Wgg9Jrz8=;
  b=gMfmjehVR0GBL6m71xP3rULc4KQTuB6pW6Hu5J7V8+ipm34w5oomzKio
   2z0b+NtnXCNPjzeq6N3N7j10IxWkcjjSdG0NSVIT3CMIrAohKUT6SRxwB
   oKCBAfPobe3oNlD0aEKkYNmEj9Vm37AiE2UUwfR/j8uu4+J3QOz+aTlNs
   k=;
X-IronPort-AV: E=Sophos;i="6.07,110,1708387200"; 
   d="scan'208";a="71838891"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 19:01:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:41067]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.13:2525] with esmtp (Farcaster)
 id dd49f6fc-2db3-465e-ac57-09b636006db0; Fri, 8 Mar 2024 19:01:48 +0000 (UTC)
X-Farcaster-Flow-ID: dd49f6fc-2db3-465e-ac57-09b636006db0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 8 Mar 2024 19:01:44 +0000
Received: from 88665a182662.ant.amazon.com (10.142.235.16) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 8 Mar 2024 19:01:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING in sk_nulls_del_node_init_rcu
Date: Fri, 8 Mar 2024 11:01:34 -0800
Message-ID: <20240308190134.58475-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <00000000000094b65a0613299ae7@google.com>
References: <00000000000094b65a0613299ae7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com>
Date: Fri, 08 Mar 2024 09:34:28 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c055fc00c07b net/rds: fix WARNING in rds_conn_connect_if_d..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=16aa17f2180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
> dashboard link: https://syzkaller.appspot.com/bug?extid=12c506c1aae251e70449
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c39eb6fb3ad1/disk-c055fc00.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/110f1226eb89/vmlinux-c055fc00.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1303e2df5cc4/bzImage-c055fc00.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com
> 
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
>  </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 23948 at include/net/sock.h:799 sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
> Modules linked in:
> CPU: 0 PID: 23948 Comm: syz-executor.2 Not tainted 6.8.0-rc6-syzkaller-00159-gc055fc00c07b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
> Code: e8 7f 71 c6 f7 83 fb 02 7c 25 e8 35 6d c6 f7 4d 85 f6 0f 95 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 1b 6d c6 f7 90 <0f> 0b 90 eb b2 e8 10 6d c6 f7 4c 89 e7 be 04 00 00 00 e8 63 e7 d2
> RSP: 0018:ffffc900032d7848 EFLAGS: 00010246
> RAX: ffffffff89cd0035 RBX: 0000000000000001 RCX: 0000000000040000
> RDX: ffffc90004de1000 RSI: 000000000003ffff RDI: 0000000000040000
> RBP: 1ffff1100439ac26 R08: ffffffff89ccffe3 R09: 1ffff1100439ac28
> R10: dffffc0000000000 R11: ffffed100439ac29 R12: ffff888021cd6140
> R13: dffffc0000000000 R14: ffff88802a9bf5c0 R15: ffff888021cd6130
> FS:  00007f3b823f16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3b823f0ff8 CR3: 000000004674a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __inet_hash_connect+0x140f/0x20b0 net/ipv4/inet_hashtables.c:1139

Here I had to use non-refcnt variant as check_established() doesn't
increment it.

I'll post a fix soon.

---8<---
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 308ff34002ea..4e470f18487f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1136,7 +1136,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		sock_prot_inuse_add(net, sk->sk_prot, -1);
 
 		spin_lock(lock);
-		sk_nulls_del_node_init_rcu(sk);
+		__sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
 
 		sk->sk_hash = 0;
---8<---

