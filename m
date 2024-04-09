Return-Path: <linux-kernel+bounces-137134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE08F89DD5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D6A28C414
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BD12D210;
	Tue,  9 Apr 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cApc3IOR"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066B4F898
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674509; cv=none; b=rfSsxt0xJnINH7H2av0Umi6sslWJBkW4t/0fKkphOwx0SyRCAfFETJJlvojffA63gMNujOypWevVMnpFI7wL43R+trrNrv9Plqi+GZIJFkkdft+3LjEPb4ev1HFFXJky/7at5ZiYCr29vkse3TFBFQTX7zd1D1w4o0SLdnYAP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674509; c=relaxed/simple;
	bh=h1zpcBEfo5s/qBnZyGDn5N6ppBTTOjf6Dpkf2ZJp1xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5IFwdrYaEz9UUbyFRPvaTLy3vui49wgfqtFGRFWsf5V4GojOCEd9YZngwXPK5E+7E4YDpeYSI2Lt1txQXDH/kojfsqQ6x6QuWLdW3RTSxzuz4gWhZ4OthOl4dUUd7DTpIaKYpKoxlQtvOrthk9I+jrASsDtV9/0F46fsDrMog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cApc3IOR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4644bde1d4so785057166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712674504; x=1713279304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a5TeOnCYnarmtCuB6dBllBFGd3v/ZvhWkluiDpbsGMI=;
        b=cApc3IORTSHiuIcex72SPWTboSIvvd3iUUxodJg77KvDDGWoynRLOrmtc6xCj1TxaN
         hG8Wit0PvwGJqNqdl08WvhF+iYGNdlDXc9SjJOqYXbtvREVkQi0Y3sJnQf+fxL3Fg/AA
         8phqOV+eQk0joDwL1fe6EgBMzv0JOos3sFcxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674504; x=1713279304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5TeOnCYnarmtCuB6dBllBFGd3v/ZvhWkluiDpbsGMI=;
        b=Oyvb7sPQFu7+EBDy10s15hMBhxDCEEP5lXy1YVBcR1Z1jFnUlk/0HfWXB2qa81yqda
         Gr7dnapwDDgkTmvoOlcYgQwvkZu7BuMA0PUTT8A3ITAbzmn8wUYFt2RMY+gefx/NN/Vt
         eMlUqP+1lKpNBn4uT0dRf+VIBc665f6sF5rKqXg3pUiOQNv/RnL8Rhqr+BhuGPPQjSvM
         Hz45L6nfjPGsgCcm30WbStfoJbiSFLGU35ljuwBmuE2WP+mTk8UQNXRshfbu8R+w2RyN
         dZB+lg3m3XOheqHvGw4F1ASLV7cqTr/r64BupOe3X7FEmcOa0hi3raMbOozoTB0FtAn9
         qI1w==
X-Forwarded-Encrypted: i=1; AJvYcCX0YGtRnNW1aQnpFM0e2lEv7C2HhCIYe+FHaDMBTwogq/8fIZ7xyNXwf04WbF72EjXfGtNsbXfuo3u0S/6omXzrI9Po6tAD7BRUfMuz
X-Gm-Message-State: AOJu0Ywqpw5O0/uLDX6Q1RevKEA5hC3ewnR/jova0JvbsWr18sO5kw1m
	KKfXblXHJwWoixqxzWev5Os74c/d3vTlSy3e9xjhYbkjnlnMJt5Gd4aG2wr3LnDVWXMGSanbZR4
	q4xgHNXXmQsKpQqWldniHUQbGZ0VcnMxy//8ks6wycMfmYOqf2ug=
X-Google-Smtp-Source: AGHT+IEiT6A1b2G7RPTOaQoSZH80Ptyrx2WFoTVnMG0AGW3iTo6sJEffA9Ejf25rPzedrw9sajlMBRKDqMwYx3R12zk=
X-Received: by 2002:a17:907:7dab:b0:a4e:2d7d:3fab with SMTP id
 oz43-20020a1709077dab00b00a4e2d7d3fabmr9196314ejc.10.1712674503536; Tue, 09
 Apr 2024 07:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dc3d170615846225@google.com>
In-Reply-To: <000000000000dc3d170615846225@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Apr 2024 16:54:52 +0200
Message-ID: <CAJfpegtnsG99Nf-FVZV1o9Q2kuarQGO7vTTVv+yT4qfubPf+RQ@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in walk_component (3)
To: syzbot <syzbot+fa60c773a1654e2eda40@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I think this has the same underlying cause as the other
kernfs-overlayfs deadlocks.

#syz dup: possible deadlock in kernfs_fop_llseek


On Sun, 7 Apr 2024 at 18:43, syzbot
<syzbot+fa60c773a1654e2eda40@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3e92c1e6cd87 Merge tag 'selinux-pr-20240402' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16ebae03180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=411644804960f423
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa60c773a1654e2eda40
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3e92c1e6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/34cc55fbbf72/vmlinux-3e92c1e6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/09668ee3251b/bzImage-3e92c1e6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fa60c773a1654e2eda40@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc2-syzkaller-00042-g3e92c1e6cd87 #0 Not tainted
> ------------------------------------------------------
> syz-executor.2/22789 is trying to acquire lock:
> ffff888032f275b0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:803 [inline]
> ffff888032f275b0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: lookup_slow fs/namei.c:1708 [inline]
> ffff888032f275b0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: walk_component+0x342/0x5b0 fs/namei.c:2004
>
> but task is already holding lock:
> ffff888040373488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #3 (&of->mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
>        kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
>        call_write_iter include/linux/fs.h:2108 [inline]
>        iter_file_splice_write+0x906/0x10b0 fs/splice.c:743
>        do_splice_from fs/splice.c:941 [inline]
>        do_splice+0x12c7/0x1f10 fs/splice.c:1354
>        __do_splice+0x327/0x360 fs/splice.c:1436
>        __do_sys_splice fs/splice.c:1652 [inline]
>        __se_sys_splice fs/splice.c:1634 [inline]
>        __x64_sys_splice+0x1d2/0x260 fs/splice.c:1634
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> -> #2 (&pipe->mutex){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
>        pipe_lock fs/pipe.c:92 [inline]
>        pipe_lock+0x64/0x80 fs/pipe.c:89
>        iter_file_splice_write+0x1f0/0x10b0 fs/splice.c:687
>        do_splice_from fs/splice.c:941 [inline]
>        do_splice+0x12c7/0x1f10 fs/splice.c:1354
>        __do_splice+0x327/0x360 fs/splice.c:1436
>        __do_sys_splice fs/splice.c:1652 [inline]
>        __se_sys_splice fs/splice.c:1634 [inline]
>        __x64_sys_splice+0x1d2/0x260 fs/splice.c:1634
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> -> #1 (sb_writers#5){.+.+}-{0:0}:
>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
>        __sb_start_write include/linux/fs.h:1662 [inline]
>        sb_start_write include/linux/fs.h:1798 [inline]
>        mnt_want_write+0x6f/0x450 fs/namespace.c:409
>        ovl_xattr_set+0x136/0x530 fs/overlayfs/xattrs.c:63
>        ovl_own_xattr_set+0x86/0xd0 fs/overlayfs/xattrs.c:213
>        __vfs_setxattr+0x173/0x1e0 fs/xattr.c:200
>        __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:234
>        __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
>        vfs_setxattr+0x146/0x350 fs/xattr.c:321
>        do_setxattr+0x146/0x170 fs/xattr.c:629
>        setxattr+0x15d/0x180 fs/xattr.c:652
>        path_setxattr+0x179/0x1e0 fs/xattr.c:671
>        __do_sys_setxattr fs/xattr.c:687 [inline]
>        __se_sys_setxattr fs/xattr.c:683 [inline]
>        __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:683
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> -> #0 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain kernel/locking/lockdep.c:3869 [inline]
>        __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>        lock_acquire kernel/locking/lockdep.c:5754 [inline]
>        lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>        down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
>        inode_lock_shared include/linux/fs.h:803 [inline]
>        lookup_slow fs/namei.c:1708 [inline]
>        walk_component+0x342/0x5b0 fs/namei.c:2004
>        lookup_last fs/namei.c:2461 [inline]
>        path_lookupat+0x17f/0x770 fs/namei.c:2485
>        filename_lookup+0x1e5/0x5b0 fs/namei.c:2514
>        kern_path+0x35/0x50 fs/namei.c:2622
>        lookup_bdev+0xd9/0x280 block/bdev.c:1079
>        resume_store+0x1d8/0x460 kernel/power/hibernate.c:1235
>        kobj_attr_store+0x55/0x80 lib/kobject.c:840
>        sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:136
>        kernfs_fop_write_iter+0x343/0x500 fs/kernfs/file.c:334
>        call_write_iter include/linux/fs.h:2108 [inline]
>        new_sync_write fs/read_write.c:497 [inline]
>        vfs_write+0x6db/0x1100 fs/read_write.c:590
>        ksys_write+0x12f/0x260 fs/read_write.c:643
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> other info that might help us debug this:
>
> Chain exists of:
>   &ovl_i_mutex_dir_key[depth] --> &pipe->mutex --> &of->mutex
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&of->mutex);
>                                lock(&pipe->mutex);
>                                lock(&of->mutex);
>   rlock(&ovl_i_mutex_dir_key[depth]);
>
>  *** DEADLOCK ***
>
> 4 locks held by syz-executor.2/22789:
>  #0: ffff88802cc70ac8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb/0x180 fs/file.c:1191
>  #1: ffff88802533e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
>  #2: ffff888040373488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
>  #3: ffff8880196eb5a8 (kn->active#85){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a4/0x500 fs/kernfs/file.c:326
>
> stack backtrace:
> CPU: 0 PID: 22789 Comm: syz-executor.2 Not tainted 6.9.0-rc2-syzkaller-00042-g3e92c1e6cd87 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
>  check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain kernel/locking/lockdep.c:3869 [inline]
>  __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>  lock_acquire kernel/locking/lockdep.c:5754 [inline]
>  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>  down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
>  inode_lock_shared include/linux/fs.h:803 [inline]
>  lookup_slow fs/namei.c:1708 [inline]
>  walk_component+0x342/0x5b0 fs/namei.c:2004
>  lookup_last fs/namei.c:2461 [inline]
>  path_lookupat+0x17f/0x770 fs/namei.c:2485
>  filename_lookup+0x1e5/0x5b0 fs/namei.c:2514
>  kern_path+0x35/0x50 fs/namei.c:2622
>  lookup_bdev+0xd9/0x280 block/bdev.c:1079
>  resume_store+0x1d8/0x460 kernel/power/hibernate.c:1235
>  kobj_attr_store+0x55/0x80 lib/kobject.c:840
>  sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x343/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2108 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0x6db/0x1100 fs/read_write.c:590
>  ksys_write+0x12f/0x260 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> RIP: 0033:0x7fb6a4e7dde9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb6a5b2f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fb6a4fabf80 RCX: 00007fb6a4e7dde9
> RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000007
> RBP: 00007fb6a4eca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000004d R14: 00007fb6a4fabf80 R15: 00007ffdad03fdb8
>  </TASK>
> PM: Image not found (code -6)
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
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

