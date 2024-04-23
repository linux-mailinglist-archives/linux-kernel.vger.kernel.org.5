Return-Path: <linux-kernel+bounces-155523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E08AF383
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FD11C22089
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BB113D290;
	Tue, 23 Apr 2024 16:09:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD913CA8C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888564; cv=none; b=Nm6lF7VXjtUTce8IBHZNrQhk0yT0S7OUuliBmNK+r3gjdOZOj86IH/rBccwXBvmigedLUc7doL/LNqlXqxIWyKVeJQyNI5PjnIds403iAdN+lir6whFOcK/qyAmDGRNHg1+1BtmSVxD9t5KwgBJOoHOzR1uEPn+p1Jl3goEWEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888564; c=relaxed/simple;
	bh=LL6Bn5JcSzwliiLuDQ78JZdeqM3pl5MZa4j3ubP5F80=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Rh0s+AXbyTqNNSjXTdDrs+NlbPHKCcp3D+ORYjaxeDWhaOsCAdG2lfUKm1zlWsKfcO1oM7lP+AqYXbwOCtZwOZj8BTCJ65a105wVfkQ0YzlgAKxObnZ4mfY+kdrulE9DbwtMAFJPNWGtQY66fxi9E9aSQaajb7UGCJ8ztKRQfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dadd5636ccso186695039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713888562; x=1714493362;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8J3OxauynARCzPhSLU5/ak2dxpVPJ+Bfj7eFyVyks4=;
        b=m5+Ksb+t+Pu0akT/m5CNIZlXEEmtw0SqiNpwydEu0Crp/QE3sfcVVhuDWE+lxjn0Kf
         wCMikaGKDC4PfVLJolVX/p/jdPtUG/7a0SQI9+oPCTJwEU6AR+lEisduwa6KKQoIOLwe
         iKBwbHs7JSEjgNYyEP2sWw1V3ft/yO70uGTibR+NHbZHdSHlt6xWL0SbDdIa71YRz9CE
         suXrmUnEHQxGxmphbYEd1o0CcmnX1LPYuq4AGyznIq/daidDD+1QznObp3MjmxN4wve8
         tLdbl7IvqLNpCpvcRhNeU5Brq88HJwRIDi5TpeB9dXOVH3EYbCT6/x8E3W1iqUlFZHAb
         2G2g==
X-Forwarded-Encrypted: i=1; AJvYcCXYCtzy31VxXZUE1/AqRC+h/SH31fJodIqnV0TmoXZmPz62raPSOI0H/EykMhOn2OG/I15LJ+HozcDyhoNb/05oqhGc2Rc8arlOLUDx
X-Gm-Message-State: AOJu0Yx9D4wBYYHFj5uBPFd8PgxLqwm0tGNjjzAzTSomMjmtbC3TARsa
	xyfhmYOuzEqPzyvC+BqV+8IQm90m3HAJo0CBkiGv5ioy8jiGvsnQm/FZztMWWsO9kwalm4wACGe
	sS08vouEsLXvdKAg3vzp2fpMgKIpmLxR8ckNpidTA36zVhGn7fFS6lIM=
X-Google-Smtp-Source: AGHT+IHtCjhHDwurnWyMvfS1ZtFj8hEag/m7u5e1xnNDD5kvOqbF8jFgh+LwcUOGTMVmM3gPmK/9YVVNK3QO5xwqzCfBxD4snq2x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4126:b0:485:7333:8c29 with SMTP id
 ay38-20020a056638412600b0048573338c29mr186877jab.1.1713888562340; Tue, 23 Apr
 2024 09:09:22 -0700 (PDT)
Date: Tue, 23 Apr 2024 09:09:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1761a0616c5c629@google.com>
Subject: [syzbot] [net?] possible deadlock in __unix_gc
From: syzbot <syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d2008430ce8 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14a15280980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=fa379358c28cc87cc307
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a8fb4f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ceeb73180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5670e5771b96/disk-4d200843.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03314e6c8879/vmlinux-4d200843.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41aca7a9505a/bzImage-4d200843.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa379358c28cc87cc307@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0 Not tainted
------------------------------------------------------
kworker/u8:1/11 is trying to acquire lock:
ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88807cea4e70 (&u->lock){+.+.}-{2:2}, at: __unix_gc+0x40e/0xf70 net/unix/garbage.c:302

but task is already holding lock:
ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (unix_gc_lock){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       unix_notinflight+0x13d/0x390 net/unix/garbage.c:140
       unix_detach_fds net/unix/af_unix.c:1819 [inline]
       unix_destruct_scm+0x221/0x350 net/unix/af_unix.c:1876
       skb_release_head_state+0x100/0x250 net/core/skbuff.c:1188
       skb_release_all net/core/skbuff.c:1200 [inline]
       __kfree_skb net/core/skbuff.c:1216 [inline]
       kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1252
       kfree_skb include/linux/skbuff.h:1262 [inline]
       manage_oob net/unix/af_unix.c:2672 [inline]
       unix_stream_read_generic+0x1125/0x2700 net/unix/af_unix.c:2749
       unix_stream_splice_read+0x239/0x320 net/unix/af_unix.c:2981
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_splice+0xf2d/0x1880 fs/splice.c:1379
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&u->lock){+.+.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
       process_one_work kernel/workqueue.c:3254 [inline]
       process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
       kthread+0x2f0/0x390 kernel/kthread.c:388
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(unix_gc_lock);
                               lock(&u->lock);
                               lock(unix_gc_lock);
  lock(&u->lock);

 *** DEADLOCK ***

3 locks held by kworker/u8:1/11:
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888015089148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3335
 #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90000107d00 (unix_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x17c0 kernel/workqueue.c:3335
 #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #2: ffffffff8f6ab638 (unix_gc_lock){+.+.}-{2:2}, at: __unix_gc+0x117/0xf70 net/unix/garbage.c:261

stack backtrace:
CPU: 0 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound __unix_gc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __unix_gc+0x40e/0xf70 net/unix/garbage.c:302
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

