Return-Path: <linux-kernel+bounces-151900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D68AB580
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365FAB2122E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A706F13C9D4;
	Fri, 19 Apr 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g5AoHKUe"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACF1386CC;
	Fri, 19 Apr 2024 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554285; cv=none; b=YwY0ZMZ6SNFSHje2xASfytZSsw6kJgv77G2nbxixL1ERPgZhrz3c6G2kf/7+Pz62IiX5ybSOtwQsbemm/+HjbYvYqjgnFh5c+gSXrxJicmxZc+GDLbysCRg0DDTmzTVE2lOM5KO/xh3gLxUKkdF1bg8txJ3oWlha9/hhA5BRE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554285; c=relaxed/simple;
	bh=8eDSdIeci7PHFHMul2cl3RqUdX0y2ydIGM5nV8OJ3uA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElevYNsuitF0pxZ79LSAdYLNYJ5zSKOF5JQ/qGNrNK5wtjcAUflyAQrcCVzEwyVMM56w5tyzd4oWsZBNnZ16spDn7B59Xj7A2AwjQqsZBcaqLILKdol2HEpmwnWkJaLx28rzj99Sq4xAxQtf59HV7Q/vc6bI03zLzEisKuBrF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g5AoHKUe; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713554284; x=1745090284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y16rQY3a6VI2FtJP+n5WLA1CAN7n5CQaojBnaE5dtAk=;
  b=g5AoHKUe7ZQch/3oFDZaq7J51p9Yb/UGRlREOxC8yRdJAHYbdlEc+/OI
   CwW7/3jXh1afaLMjh4sk9aXTc2TnrV268UX1n5OH+XWSC0SWhCJLkM8Qo
   lDeR0pQSSAr4cM4vQ9f4pHi40JHn8QlznG1c+0/WEm4Om9RNSh9fFMXS8
   o=;
X-IronPort-AV: E=Sophos;i="6.07,214,1708387200"; 
   d="scan'208";a="395873253"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 19:18:00 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:26448]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.15:2525] with esmtp (Farcaster)
 id 1a44db09-abae-42b4-a56a-9ddc54a63876; Fri, 19 Apr 2024 19:18:00 +0000 (UTC)
X-Farcaster-Flow-ID: 1a44db09-abae-42b4-a56a-9ddc54a63876
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 19:17:59 +0000
Received: from 88665a182662.ant.amazon.com (10.119.231.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 19 Apr 2024 19:17:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_del_edges
Date: Fri, 19 Apr 2024 12:17:49 -0700
Message-ID: <20240419191749.94398-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000c1fa0506166fdcfe@google.com>
References: <000000000000c1fa0506166fdcfe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
Date: Fri, 19 Apr 2024 02:39:21 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a54a53180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
> dashboard link: https://syzkaller.appspot.com/bug?extid=f3f3eef1d2100200e593
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e53af180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128b1d53180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/524a18e6c5be/disk-7b4f2bc9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/029f1b84d653/vmlinux-7b4f2bc9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c02d1542e886/bzImage-7b4f2bc9.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in unix_edge_successor net/unix/garbage.c:109 [inline]
> BUG: KASAN: slab-use-after-free in unix_del_edge net/unix/garbage.c:165 [inline]
> BUG: KASAN: slab-use-after-free in unix_del_edges+0x148/0x630 net/unix/garbage.c:237
> Read of size 8 at addr ffff888079c6e640 by task kworker/u8:6/1099
> 
> CPU: 0 PID: 1099 Comm: kworker/u8:6 Not tainted 6.9.0-rc4-next-20240418-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: events_unbound __unix_gc
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  unix_edge_successor net/unix/garbage.c:109 [inline]

It seems successor is freed during the same GC iteration ?

Will cook a patch soon.

Thanks!


>  unix_del_edge net/unix/garbage.c:165 [inline]
>  unix_del_edges+0x148/0x630 net/unix/garbage.c:237
>  unix_destroy_fpl+0x59/0x210 net/unix/garbage.c:298
>  unix_detach_fds net/unix/af_unix.c:1811 [inline]
>  unix_destruct_scm+0x13e/0x210 net/unix/af_unix.c:1826
>  skb_release_head_state+0x100/0x250 net/core/skbuff.c:1127
>  skb_release_all net/core/skbuff.c:1138 [inline]
>  __kfree_skb net/core/skbuff.c:1154 [inline]
>  kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1190
>  __skb_queue_purge_reason include/linux/skbuff.h:3251 [inline]
>  __skb_queue_purge include/linux/skbuff.h:3256 [inline]
>  __unix_gc+0x1732/0x1830 net/unix/garbage.c:575
>  process_one_work kernel/workqueue.c:3218 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> Allocated by task 14427:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:312 [inline]
>  __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3897 [inline]
>  slab_alloc_node mm/slub.c:3957 [inline]
>  kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
>  sk_prot_alloc+0x58/0x210 net/core/sock.c:2074
>  sk_alloc+0x38/0x370 net/core/sock.c:2133
>  unix_create1+0xb4/0x770
>  unix_create+0x14e/0x200 net/unix/af_unix.c:1034
>  __sock_create+0x490/0x920 net/socket.c:1571
>  sock_create net/socket.c:1622 [inline]
>  __sys_socketpair+0x33e/0x720 net/socket.c:1773
>  __do_sys_socketpair net/socket.c:1822 [inline]
>  __se_sys_socketpair net/socket.c:1819 [inline]
>  __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 1805:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2190 [inline]
>  slab_free mm/slub.c:4393 [inline]
>  kmem_cache_free+0x145/0x340 mm/slub.c:4468
>  sk_prot_free net/core/sock.c:2114 [inline]
>  __sk_destruct+0x467/0x5f0 net/core/sock.c:2208
>  sock_put include/net/sock.h:1948 [inline]
>  unix_release_sock+0xa8b/0xd20 net/unix/af_unix.c:665
>  unix_release+0x91/0xc0 net/unix/af_unix.c:1049
>  __sock_release net/socket.c:659 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1421
>  __fput+0x406/0x8b0 fs/file_table.c:422
>  delayed_fput+0x59/0x80 fs/file_table.c:445
>  process_one_work kernel/workqueue.c:3218 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

