Return-Path: <linux-kernel+bounces-50897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73684800A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B6B1F27CAC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A940FBF2;
	Sat,  3 Feb 2024 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k2HRrMgL"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B659F9E4;
	Sat,  3 Feb 2024 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932839; cv=none; b=k2Lv0rbv50mTSaDc/udh1LPzygIYEYjdKzZsQ774nHtTaC1YJT1ONb2qAipiKC9RWoqKpT35kWuOw4rN57LFrunk3XNXS1BeFwUg6SfxbodQIIIlF/UzUKs/36xw0UoNlC3/mlljjhie9Nc1diG5C5RCEO/RPUxR/zXqc/42M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932839; c=relaxed/simple;
	bh=nPNcVMyJMqOzODkfQyo8r4ZLd/p2EiOmJqZC2GbOwHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKJOi3w2TsyqeXvsD6pObyDYTu0GulM57/OZne42WSnWnJaW8hUGKIrLwMTSCu62aTphousoEJ8LlueNIm9UZ3+lZRAeY757JGpIwBfYuVpD5ojX8pBNbdSOlNgo77TyuVCByy8sP/eHGu7W5TQlnQowVSE2zFUvoL4URBLR6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=k2HRrMgL; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706932838; x=1738468838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k41X4sc9DdtTYFgJF4SnAf1wbpUf7pf1w3fjGixgous=;
  b=k2HRrMgLM30o5V9m/vT1Cd8hOBNNdiLIcXO86sRQLBygApFJCsepYH3L
   YY8pKOzq6zmnfk/zCQz5eFxKDugm4PSciZKFeNCy0xcK+eqNW4t/6nkmN
   C0N+brAs3gdObpDf6pTwQoxBxc0polZdVjrRNsRFhAcpK+jjMykqQ5TuY
   E=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="182307099"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 04:00:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:15805]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.97:2525] with esmtp (Farcaster)
 id 8e386eaa-6d50-4d8a-8bab-47c198efb151; Sat, 3 Feb 2024 04:00:35 +0000 (UTC)
X-Farcaster-Flow-ID: 8e386eaa-6d50-4d8a-8bab-47c198efb151
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 04:00:33 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 04:00:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING in __unix_gc
Date: Fri, 2 Feb 2024 20:00:21 -0800
Message-ID: <20240203040021.65783-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0000000000003555920610660fbc@google.com>
References: <0000000000003555920610660fbc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com>
Date: Fri, 02 Feb 2024 05:26:28 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1701940b1a02 Merge branch 'tools-net-ynl-add-features-for-..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15cbca88180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=43ed254f922f56d0
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa3ef895554bdbfd1183
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b512ffe80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d6927be80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/00090c03ed53/disk-1701940b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/fc03bbe45eb3/vmlinux-1701940b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8a5b859954ca/bzImage-1701940b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fa3ef895554bdbfd1183@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 2863 at net/unix/garbage.c:345 __unix_gc+0xc74/0xe80 net/unix/garbage.c:345
> Modules linked in:
> CPU: 0 PID: 2863 Comm: kworker/u4:11 Not tainted 6.8.0-rc1-syzkaller-00583-g1701940b1a02 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Workqueue: events_unbound __unix_gc
> RIP: 0010:__unix_gc+0xc74/0xe80 net/unix/garbage.c:345
> Code: 8b 5c 24 50 e9 86 f8 ff ff e8 f8 e4 22 f8 31 d2 48 c7 c6 30 6a 69 89 4c 89 ef e8 97 ef ff ff e9 80 f9 ff ff e8 dd e4 22 f8 90 <0f> 0b 90 e9 7b fd ff ff 48 89 df e8 5c e7 7c f8 e9 d3 f8 ff ff e8
> RSP: 0018:ffffc9000b03fba0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc9000b03fc10 RCX: ffffffff816c493e
> RDX: ffff88802c02d940 RSI: ffffffff896982f3 RDI: ffffc9000b03fb30
> RBP: ffffc9000b03fce0 R08: 0000000000000001 R09: fffff52001607f66
> R10: 0000000000000003 R11: 0000000000000002 R12: dffffc0000000000
> R13: ffffc9000b03fc10 R14: ffffc9000b03fc10 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005559c8677a60 CR3: 000000000d57a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  process_one_work+0x889/0x15e0 kernel/workqueue.c:2633
>  process_scheduled_works kernel/workqueue.c:2706 [inline]
>  worker_thread+0x8b9/0x12a0 kernel/workqueue.c:2787
>  kthread+0x2c6/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>

Ugh, I should've noticed this before sending another series.

It seems syzbot creates a self-ref cycle.
I'll look into it.

Thanks.

