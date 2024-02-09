Return-Path: <linux-kernel+bounces-59957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87D84FDE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D0281568
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A8DF63;
	Fri,  9 Feb 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Id9rrK+Q"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A050610D;
	Fri,  9 Feb 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511685; cv=none; b=ilDJMJe4Z8Muamy5jjdd8kyrQgmXxqdDNto61iJL0kfp2pIyAjSh8Y0e+R1gp4CVejoZUUcpZhyzDO90rh8/k+1PxdrbZSnVjgJKny2x9piuHRQpNebW8Bp4TMQl6qadkhbFBjWIMsbxdxfGA8MMKSAfTfgItxzMOoKeLfbY0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511685; c=relaxed/simple;
	bh=v7x2cv3cLaefXsKv1oCZw7imDpO7JPajJ8J0xnTg1mI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHfu1I20ROiQ+Z1NcCrkK0j59i0+wN/XTgxEngxGYJsipL4m9NSTpMBUF/BNm/WRo8iVqGdY6tj4/phj0Kw9uZ4zVB9yX2bjtDK9YgNa+G7iHwxOUb14t8rq4wPE12t4moHHPf4zBLq6VZVOtYvCrtG7zpbqIUONX86HznW1Vaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Id9rrK+Q; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707511683; x=1739047683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FrTFehTP/3NIYoM1mVpt+q0WoGuz/xdkAlWXzO6iBNM=;
  b=Id9rrK+QUmBRuFlNlL+FNhjcOEeFuM3nC9iB6QlDyXx4ImpzTRKcGYJx
   ZyGB690uGTG9UptphJpQgJZF9BL16E09c0fDyR2mPoMF5iWwdb297w+ur
   9ezYgt71CFq2MGWtk99/iHAaD+tEjKEOeR0Nr2drNqup/HpKiMiLbOiAf
   4=;
X-IronPort-AV: E=Sophos;i="6.05,257,1701129600"; 
   d="scan'208";a="380190350"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:47:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:55540]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.244:2525] with esmtp (Farcaster)
 id 03dd3009-5fc6-4bd9-9784-e08ba959e9d0; Fri, 9 Feb 2024 20:47:57 +0000 (UTC)
X-Farcaster-Flow-ID: 03dd3009-5fc6-4bd9-9784-e08ba959e9d0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 20:47:57 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 20:47:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com>
CC: <asml.silence@gmail.com>, <axboe@kernel.dk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] INFO: task hung in unix_dgram_sendmsg
Date: Fri, 9 Feb 2024 12:47:45 -0800
Message-ID: <20240209204745.89949-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <00000000000067de160610f791be@google.com>
References: <00000000000067de160610f791be@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com>
Date: Fri, 09 Feb 2024 11:02:22 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1f719a2f3fa6 Merge tag 'net-6.8-rc4' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a21d04180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=53985487b59d9442
> dashboard link: https://syzkaller.appspot.com/bug?extid=4fa4a2d1f5a5ee06f006
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1636f042180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141c0cec180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b8bd7b1c1c4d/disk-1f719a2f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/58ee6966cdfc/vmlinux-1f719a2f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3de15662a476/bzImage-1f719a2f.xz
> 
> The issue was bisected to:
> 
> commit 1279f9d9dec2d7462823a18c29ad61359e0a007d
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Sat Feb 3 18:31:49 2024 +0000
> 
>     af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e71d7c180000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14171d7c180000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10171d7c180000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4fa4a2d1f5a5ee06f006@syzkaller.appspotmail.com
> Fixes: 1279f9d9dec2 ("af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.")

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1279f9d9dec2d7462823a18c29ad61359e0a007d

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 3e4b986de94b..51acf795f096 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -340,10 +340,11 @@ static void __unix_gc(struct work_struct *work)
 	__skb_queue_purge(&hitlist);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	list_for_each_entry_safe(u, next, &gc_candidates, link) {
-		struct sk_buff *skb = u->oob_skb;
+	while (!list_empty(&gc_candidates)) {
+		u = list_entry(gc_candidates.next, struct unix_sock, link);
+		if (u->oob_skb) {
+			struct sk_buff *skb = u->oob_skb;
 
-		if (skb) {
 			u->oob_skb = NULL;
 			kfree_skb(skb);
 		}

