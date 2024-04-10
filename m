Return-Path: <linux-kernel+bounces-139440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A68D8A0363
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E16E1C226B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983838827;
	Wed, 10 Apr 2024 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MzW6M2HN"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0401FA5;
	Wed, 10 Apr 2024 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788256; cv=none; b=a+GflR+mJBlF/wWRSOUelT+jBiUSHAmNMyubq2u79kXB73/Jv9QO85ZnXMq+CZx87bjCJVgv3XTnp1kQWNUO5CXJY0Rps8AVBYmGHiCT0/y4M5TgWWqyO1BrKd96FxpZb3nQ6uDNrGVZmvtBkxEAg2PgL9TbZUDXXsE8WjSYqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788256; c=relaxed/simple;
	bh=eZpvc/UWoNCsyDX2JCr+wbJJvkCqUk4ra0ykRwG47Mw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWtHM36pg9zWygnGFk+XhSAlgxrvWyasmAMjzuUKpOfdqpkXuk5qS6n57F6Y6PyTyqcTmPMazpNHr8cZ4Vzbh0vUFHCVxtqHOa59DykTl52dkvLpJV76XD8G8FS9uXk67ZokRAonseAvrIY+O2OnP7e7vVyf4+wnnKz6XumP4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MzW6M2HN; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712788255; x=1744324255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JPI1KtiiDGXI7/vfDxcBZE2ymTPw6triV6+LgtAEZpM=;
  b=MzW6M2HNTIEaxQbewiYkEUmnmFviGP2CG3HX+1wZ1HrCsFcQJ1K9/P8Z
   PVKWfA+TCfnT4cheeTMeYAQ0ZDCWTbVvgplkhz97rkEDsQsKtFvTlaQSf
   XuFF/C6Z2j4zBRErqGcHTMmrKua/ex7ttxEplOSAdI94JYsCIjkCV0Ypg
   o=;
X-IronPort-AV: E=Sophos;i="6.07,191,1708387200"; 
   d="scan'208";a="197779335"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 22:30:52 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:54801]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.109:2525] with esmtp (Farcaster)
 id b96aa329-3e17-476f-9cb5-5ce0c370c4ff; Wed, 10 Apr 2024 22:30:50 +0000 (UTC)
X-Farcaster-Flow-ID: b96aa329-3e17-476f-9cb5-5ce0c370c4ff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 22:30:50 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 22:30:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+38b3aa8cd529958bd27a@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] possible deadlock in unix_notinflight
Date: Wed, 10 Apr 2024 15:30:40 -0700
Message-ID: <20240410223040.45801-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0000000000005576ad0615c2710b@google.com>
References: <0000000000005576ad0615c2710b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+38b3aa8cd529958bd27a@syzkaller.appspotmail.com>
Date: Wed, 10 Apr 2024 11:45:29 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12898aa9180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=38b3aa8cd529958bd27a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d693e3180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aee305180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+38b3aa8cd529958bd27a@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.8.0-syzkaller-05236-g443574b03387 #0 Not tainted
> --------------------------------------------
> kworker/u8:0/10 is trying to acquire lock:
> ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: unix_notinflight+0x204/0x390 net/unix/garbage.c:140
> 
> but task is already holding lock:
> ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf10 net/unix/garbage.c:261
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
> 3 locks held by kworker/u8:0/10:
>  #0: ffff888014c81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
>  #0: ffff888014c81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
>  #1: ffffc900000f7d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
>  #1: ffffc900000f7d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
>  #2: ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #2: ffffffff8f48b798 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf10 net/unix/garbage.c:261
> 
> stack backtrace:
> CPU: 1 PID: 10 Comm: kworker/u8:0 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: events_unbound __unix_gc
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
>  check_deadlock kernel/locking/lockdep.c:3062 [inline]
>  validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  unix_notinflight+0x204/0x390 net/unix/garbage.c:140
>  unix_detach_fds net/unix/af_unix.c:1819 [inline]
>  unix_destruct_scm+0x221/0x350 net/unix/af_unix.c:1876
>  skb_release_head_state+0x100/0x250 net/core/skbuff.c:1188
>  skb_release_all net/core/skbuff.c:1200 [inline]
>  __kfree_skb net/core/skbuff.c:1216 [inline]
>  kfree_skb_reason+0x15d/0x390 net/core/skbuff.c:1252
>  kfree_skb include/linux/skbuff.h:1267 [inline]
>  __unix_gc+0xaf3/0xf10 net/unix/garbage.c:330
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
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

#syz fix: af_unix: Clear stale u->oob_skb.

