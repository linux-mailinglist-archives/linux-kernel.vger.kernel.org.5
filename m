Return-Path: <linux-kernel+bounces-144100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7758A41C8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356E7281A04
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829752D61B;
	Sun, 14 Apr 2024 10:15:31 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9823759
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089730; cv=none; b=ffvvX/uuNMVwJC2BzLFvsLuxn6o5O+1Iu+Eq/2cKtIhDInjCmw+19sv2uFNNdRUbXHusKPlv6lpyGZ4SxBvXT+TNhMYVheybVaJ/H5gm9zgynXq8mGPNCnGTgv7xLQqPMvQ/w1+DbJmDlfpXKum+FtCIEuxQ/lQ8r7gkUbnVWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089730; c=relaxed/simple;
	bh=thV89zTAH9T9yfIaUnFScOHKDh/20+g8RfPyyZpVaro=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EZV0qMQh/HldEfWyL9HkIXezSDng6rkQQWgiTqGX0oBkyQ/2y3rCTH1CGEPxF6oNlDN4Y3Cb8VMDSeNFLh7/EquaG1r1gHYUGs6EHo7sFd6/fxcUx0VpA0TLsfDIWcYxDK1Iy7o7jQY2a51z9stsJwu7PtAd3ZNHIjB2AoIZ/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5e9c1232dso291579839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 03:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713089728; x=1713694528;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxmaXZ0IXrPbx9OZK8yJxhMv3FJZPl7SVZPcxKKtOfA=;
        b=ILDEOwChHSWtkB2g/mIGVl+Xdxz8eIh7fCGhd96e9pQmmedXZkAwosFfSfmc4CvhjW
         8fMbJ4OI1Q55MI88eozu6Sf0GAcDPMSBYM5NC6L1wdZTUBVoZsP+08LiS0UWj1IHYI6L
         AmjWQGZbZ2pvumYDKFMjtyAvuDBsYmgo6fBhLboG3c93PUsjILZuetdGvdfpBY72v8e6
         fzu+viHDbkTLiRfloqADDNdvN1DQEXmlT4YHMDaz9GCcDCmY5vveWTGUvAgC5y1q1oCO
         k1Pu1LSdLSt998uKj9jX3nz7nHaqoqZqaYbgqC6PVth0TriOSqTPfYWVwrM4PDwxI5R5
         rBig==
X-Forwarded-Encrypted: i=1; AJvYcCVdK03vzj3fZhmmqgzvKyBba7MTpM3fTCwDtoD9nM+Je5+WP4fAWyMsAmVAP8qSED2Q7m9+Q0fhzZy3O5aP0ixH0cTwAgAAeQz81NgY
X-Gm-Message-State: AOJu0Ywp9VIA/Q9dGbxr0Xc5Vl4DGu5xiZNZ7jkfi97rvhRGC/0D/Rok
	VEWfVM4gCfzqB/vJR2GqUwwzOnyRj6sVmWl3U55J6uWJB67hvXxSx2k1+UR54fJhmLxA9DKTaUv
	Nf94qNsysi0Fx7uS0ts+aO+klofmhm2YTky/PjSnu7u9ciYKJI3AQudU=
X-Google-Smtp-Source: AGHT+IFonPvDNADiAq4lnE77ET/jtIys8tl5Skf/1IzI/vKjVTNSwcPz3Zc8L5qpkHzyCwPt0kB1rk/dXN/eIo7ahIbejulXu0oC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1411:b0:482:bc4b:4bfc with SMTP id
 k17-20020a056638141100b00482bc4b4bfcmr295274jad.6.1713089728407; Sun, 14 Apr
 2024 03:15:28 -0700 (PDT)
Date: Sun, 14 Apr 2024 03:15:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bafb9f06160bc800@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in __sock_map_delete
From: syzbot <syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8c39d0f57f3 Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d1ef13180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=a4ed4041b9bea8177ac3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e8c39d0f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d33b002ae0bf/vmlinux-e8c39d0f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/047d0bfb2db7/bzImage-e8c39d0f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3 #0 Not tainted
------------------------------------------------------
kworker/u32:0/10 is trying to acquire lock:
ffff888024dbea00 (&stab->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888024dbea00 (&stab->lock){+.-.}-{2:2}, at: __sock_map_delete+0x43/0xe0 net/core/sock_map.c:417

but task is already holding lock:
ffff8880260e5290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff8880260e5290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
ffff8880260e5290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xbf/0x6e0 net/core/sock_map.c:180

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&psock->link_lock){+...}-{2:2}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_map_add_link net/core/sock_map.c:134 [inline]
       sock_map_update_common+0x622/0x870 net/core/sock_map.c:503
       sock_map_update_elem_sys+0x3bb/0x570 net/core/sock_map.c:582
       bpf_map_update_value+0x36c/0x6c0 kernel/bpf/syscall.c:172
       map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
       __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
       __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
       __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&stab->lock){+.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       __sock_map_delete+0x43/0xe0 net/core/sock_map.c:417
       sock_map_delete_elem+0xb5/0x100 net/core/sock_map.c:449
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
       trace_kfree include/trace/events/kmem.h:94 [inline]
       kfree+0x225/0x390 mm/slub.c:4377
       sk_psock_free_link include/linux/skmsg.h:421 [inline]
       sock_map_del_link net/core/sock_map.c:158 [inline]
       sock_map_unref+0x392/0x6e0 net/core/sock_map.c:180
       sock_map_free+0x260/0x470 net/core/sock_map.c:351
       bpf_map_free_deferred+0x1ce/0x420 kernel/bpf/syscall.c:734
       process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
       process_scheduled_works kernel/workqueue.c:3335 [inline]
       worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
       kthread+0x2c1/0x3a0 kernel/kthread.c:388
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&psock->link_lock);
                               lock(&stab->lock);
                               lock(&psock->link_lock);
  lock(&stab->lock);

 *** DEADLOCK ***

6 locks held by kworker/u32:0/10:
 #0: ffff888015091148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3229
 #1: ffffc900000d7d80 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3230
 #2: ffff88802556ea58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1671 [inline]
 #2: ffff88802556ea58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: sock_map_free+0x20f/0x470 net/core/sock_map.c:349
 #3: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: sock_map_free+0x231/0x470 net/core/sock_map.c:350
 #4: ffff8880260e5290 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #4: ffff8880260e5290 (&psock->link_lock){+...}-{2:2}, at: sock_map_del_link net/core/sock_map.c:145 [inline]
 #4: ffff8880260e5290 (&psock->link_lock){+...}-{2:2}, at: sock_map_unref+0xbf/0x6e0 net/core/sock_map.c:180
 #5: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #5: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #5: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #5: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0xe4/0x420 kernel/trace/bpf_trace.c:2420

stack backtrace:
CPU: 1 PID: 10 Comm: kworker/u32:0 Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 __sock_map_delete+0x43/0xe0 net/core/sock_map.c:417
 sock_map_delete_elem+0xb5/0x100 net/core/sock_map.c:449
 ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x225/0x390 mm/slub.c:4377
 sk_psock_free_link include/linux/skmsg.h:421 [inline]
 sock_map_del_link net/core/sock_map.c:158 [inline]
 sock_map_unref+0x392/0x6e0 net/core/sock_map.c:180
 sock_map_free+0x260/0x470 net/core/sock_map.c:351
 bpf_map_free_deferred+0x1ce/0x420 kernel/bpf/syscall.c:734
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

