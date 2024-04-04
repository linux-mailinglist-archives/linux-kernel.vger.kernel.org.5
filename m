Return-Path: <linux-kernel+bounces-131866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1215898CDE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F831C21600
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CEC12C554;
	Thu,  4 Apr 2024 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sEiK7mdm"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A91C6BC;
	Thu,  4 Apr 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250070; cv=none; b=rgeCZRY0vhPrN7DO0dc6hzy5whphiFUD+jT3x7fWTvC1mg4cQkiO2qGwnKqyOQZC6tfUY7YD3GK/UMRld+BRNU8ooePbmOn5SqbswEbfDFsH3uUEHnyBmLRdMKRz853b3EP9lzW1UE/c4UPNhJFwu1lnblJyNLd4fS5c2Ny2N7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250070; c=relaxed/simple;
	bh=PqSmR1m/kxIKKQ02yrSEFmZNiCX/dQmiQo6vvM69aIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8PnHwCDJjTiPWr7kaSRZXqSdi8Xw+uSCf4ihjevd7SHUmqUItV/TSPJurL5NHjMKSy4CYGak90/NJRJXhwHnjPts8voDwUXYte3T2dM6ouFZO4W9LmL5hjF5DI3AFnNUPn1QaXOL9u3sywJkU2NBPVnZy8080S8WNJbK446OkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sEiK7mdm; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712250069; x=1743786069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ZAP3iBYUElsswLWsCDfAW4etC+dKAmHx5pcwoa9O+s=;
  b=sEiK7mdmJja/Q7DVwffS5HJhYnfi8KSXkgP4FDc7y6d88994oKeba7sQ
   44bCqD0ICcFhTKfwCVQ8OHSYylSCz7aNVywuYsnwEotMCSAwhIlQlwAad
   XST7DEavWhXUYRhr9vtMnCTxqY1VOlnPihCyW2imptl4uZS0gz8SQIKmO
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,179,1708387200"; 
   d="scan'208";a="387600483"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 17:01:04 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:4135]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.213:2525] with esmtp (Farcaster)
 id f6af92f5-2cfe-47c1-8fc2-21a8ca6d6f74; Thu, 4 Apr 2024 17:01:03 +0000 (UTC)
X-Farcaster-Flow-ID: f6af92f5-2cfe-47c1-8fc2-21a8ca6d6f74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 17:01:03 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 17:01:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] possible deadlock in unix_del_edges
Date: Thu, 4 Apr 2024 10:00:52 -0700
Message-ID: <20240404170052.3813-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <00000000000083ca480615479e79@google.com>
References: <00000000000083ca480615479e79@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
Date: Thu, 04 Apr 2024 09:13:26 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2b3d5988ae2c Add linux-next specific files for 20240404
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13114d8d180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9c48fd2523cdee5e
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f7f201cc2668a8fd169
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113c7103180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1133aaa9180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/136270ed2c7b/disk-2b3d5988.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/466d2f7c1952/vmlinux-2b3d5988.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7dfaf3959891/bzImage-2b3d5988.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.9.0-rc2-next-20240404-syzkaller #0 Not tainted
> --------------------------------------------
> kworker/u8:3/51 is trying to acquire lock:
> ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: unix_del_edges+0x30/0x590 net/unix/garbage.c:227
> 
> but task is already holding lock:
> ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0xc5/0x1830 net/unix/garbage.c:547
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(unix_gc_lock);
>   lock(unix_gc_lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 4 locks held by kworker/u8:3/51:
>  #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3193 [inline]
>  #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3299
>  #1: ffffc90000bb7d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3194 [inline]
>  #1: ffffc90000bb7d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3299
>  #2: ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #2: ffffffff8f6dc178 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0xc5/0x1830 net/unix/garbage.c:547
>  #3: ffff88802bd76118 (rlock-AF_UNIX){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #3: ffff88802bd76118 (rlock-AF_UNIX){+.+.}-{2:2}, at: unix_collect_skb+0xb8/0x700 net/unix/garbage.c:343
> 
> stack backtrace:
> CPU: 0 PID: 51 Comm: kworker/u8:3 Not tainted 6.9.0-rc2-next-20240404-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: events_unbound __unix_gc
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  check_deadlock kernel/locking/lockdep.c:3062 [inline]
>  validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  unix_del_edges+0x30/0x590 net/unix/garbage.c:227
>  unix_destroy_fpl+0x59/0x210 net/unix/garbage.c:286
>  unix_detach_fds net/unix/af_unix.c:1816 [inline]
>  unix_destruct_scm+0x13e/0x210 net/unix/af_unix.c:1873
>  skb_release_head_state+0x100/0x250 net/core/skbuff.c:1162
>  skb_release_all net/core/skbuff.c:1173 [inline]
>  __kfree_skb net/core/skbuff.c:1189 [inline]
>  kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1225
>  kfree_skb include/linux/skbuff.h:1262 [inline]
>  unix_collect_skb+0x5e4/0x700 net/unix/garbage.c:361

It seems OOB skb has already lost a refcount but not cleared ?

Will look into the repro today.

Thanks!


>  __unix_walk_scc net/unix/garbage.c:481 [inline]
>  unix_walk_scc net/unix/garbage.c:506 [inline]
>  __unix_gc+0x108c/0x1830 net/unix/garbage.c:559
>  process_one_work kernel/workqueue.c:3218 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

