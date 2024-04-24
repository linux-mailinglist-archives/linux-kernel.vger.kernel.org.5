Return-Path: <linux-kernel+bounces-156061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C58AFD68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23A72842CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158434C84;
	Wed, 24 Apr 2024 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A2SEmj3V"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4341723BE;
	Wed, 24 Apr 2024 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919433; cv=none; b=HkitpJgYKONyaAjERUuvHMWYCAgzElWdmuvseqhCDYB7nGY69Zhd2wxNy6OyEhfw5UfNZu5hLEWTWOM2DwIJfBHHSqbpzyK8DPx6xC6eo0tYRai/93iWVvJTC8v77gVoVsOusdHdEGTiNkJS4vQ60aD+UInZjGhoTW4Jq/nFEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919433; c=relaxed/simple;
	bh=O8wl/Uhaoi25AoQcK8Qye2zjsMrxEmlq/WcSI1+5HuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjAHGyLR5dnxeuPh+aGil+PYO0Ku/7eHmCjGWyC7EpMnS+x+U2k8U9G73gqrZMarr3cYqgokn8HaJMTXkWH3AwSK75WKzByUUNzwHG2H9nkOyVfEsVUkD4LlOAeiyXNJNArr89R13GLg4QWmyZVALbfw+UeA05Qb/kwsGsMQUwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A2SEmj3V; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713919431; x=1745455431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TPqPRfF6wM4f85KoG+cWRKaYn2hNEwgBsXYhCaPG90g=;
  b=A2SEmj3VwgqH3aANQ/GES5cjTBvJ+cr+ZWuQ5Q8ftMXvyoJvn7ssgx8o
   AnMI+n/gWY1997QGDuEQfl4CJZwUNK4vyKdRwnFrKqJRWgrnKm35eHrg6
   J/Z0CEj0/IS5ZjbvqyK17WpTtEGocci+T6PyUZN8/Sb4OUhBwoOkNhn5N
   E=;
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="649898425"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:43:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:38367]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.168:2525] with esmtp (Farcaster)
 id 8f7a98c8-b9a9-4758-bdd2-a2dc1fcce6d0; Wed, 24 Apr 2024 00:43:47 +0000 (UTC)
X-Farcaster-Flow-ID: 8f7a98c8-b9a9-4758-bdd2-a2dc1fcce6d0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 00:43:45 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 24 Apr 2024 00:43:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] possible deadlock in __unix_gc
Date: Tue, 23 Apr 2024 17:43:34 -0700
Message-ID: <20240424004334.10593-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <000000000000f1761a0616c5c629@google.com>
References: <000000000000f1761a0616c5c629@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
Date: Tue, 23 Apr 2024 09:09:22 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4d2008430ce8 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14a15280980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a8fb4f180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ceeb73180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5670e5771b96/disk-4d200843.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/03314e6c8879/vmlinux-4d200843.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/41aca7a9505a/bzImage-4d200843.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0 Not tainted
> ------------------------------------------------------
> kworker/u8:1/11 is trying to acquire lock:
> ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
> 
> but task is already holding lock:
> ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (unix_gc_lock){+.+.}-{2:2}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        spin_lock include/linux/spinlock.h:351 [inline]
>        unix_notinflight+0x13d/0x390 net/unix/garbage.c:140
>        unix_detach_fds net/unix/af_unix.c:1819 [inline]
>        unix_destruct_scm+0x221/0x350 net/unix/af_unix.c:1876
>        skb_release_head_state+0x100/0x250 net/core/skbuff.c:1188
>        skb_release_all net/core/skbuff.c:1200 [inline]
>        __kfree_skb net/core/skbuff.c:1216 [inline]
>        kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1252
>        kfree_skb include/linux/skbuff.h:1262 [inline]
>        manage_oob net/unix/af_unix.c:2672 [inline]
>        unix_stream_read_generic+0x1125/0x2700 net/unix/af_unix.c:2749
>        unix_stream_splice_read+0x239/0x320 net/unix/af_unix.c:2981

This is a normal socket calling recvmsg(),


>        do_splice_read fs/splice.c:985 [inline]
>        splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
>        do_splice+0xf2d/0x1880 fs/splice.c:1379
>        __do_splice fs/splice.c:1436 [inline]
>        __do_sys_splice fs/splice.c:1652 [inline]
>        __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&u->lock){+.+.}-{2:2}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>        spin_lock include/linux/spinlock.h:351 [inline]

and this is for TCP_LISTEN introduced by this patch.
https://lore.kernel.org/netdev/20240409201047.1032217-1-mhal@rbox.co/

So, this is false positive.


>        __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
>        process_one_work kernel/workqueue.c:3254 [inline]
>        process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
>        worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>        kthread+0x2f0/0x390 kernel/kthread.c:388
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(unix_gc_lock);
>                                lock(&u->lock);
>                                lock(unix_gc_lock);
>   lock(&u->lock);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by kworker/u8:1/11:
>  #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
>  #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3335
>  #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
>  #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3335
>  #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
>  #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261
[...]
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

This suppressed the splat on my setup but just in case

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4d2008430ce87061c9cefd4f83daf2d5bb323a96

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 627ea8e2d915..6dcbccfaac04 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -85,6 +85,9 @@ enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
 	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
 	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+	U_LOCK_GC_LISTENER, /* used while determining gc candidates for listneing
+			     * socket to remove a small race window.
+			     */
 };
 
 static inline void unix_state_lock_nested(struct sock *sk,
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 6433a414acf8..0104be9d4704 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -299,7 +299,7 @@ static void __unix_gc(struct work_struct *work)
 			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
 
 			if (sk->sk_state == TCP_LISTEN) {
-				unix_state_lock(sk);
+				unix_state_lock_nested(sk, U_LOCK_GC_LISTENER);
 				unix_state_unlock(sk);
 			}
 		}

