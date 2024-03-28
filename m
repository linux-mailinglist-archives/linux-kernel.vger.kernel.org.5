Return-Path: <linux-kernel+bounces-123059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7596C890192
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A817296F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F29712BEA0;
	Thu, 28 Mar 2024 14:20:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1335823CB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635633; cv=none; b=D4Oe+4UUvGKyzqz1VHs4NMwRPQflGtQYT/5A19e0SJ/lEc+P7VYrC2n0HLXTeZqgozAnmFqqWFSQVbl48wIDkYShVWtcfZmw4uvtwx5RhfcniyImJYu+Nz6hmFWG3jOaunJkOCIB5yEiCfTszoTlXjuZjWBNI3Rlh2KbS/k72zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635633; c=relaxed/simple;
	bh=Bq9LWOx+1iPt2NmZWbnO9eJmfYrUT9ZFxtW8nkO9COA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WEH9eLPDm4RHHvj0bKStC6+7aEUK6xuYYFBnVCsbFXcZp+juSKXiigK00FSVNRn3M98QnbwM06dKFS03ebMzNmmyeaYZ6AQ6tZjXCy4NF/65toNIHFA/alW9ijFzf0lIIRXTRaVopTtu6YNQ/WhwWf4QygsEMUDSkyF7u4rLc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-368a3864192so7387135ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635631; x=1712240431;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EtBIqGObUrXQ9PDYL92r63zx6gFykZehyqeUGmcuBHc=;
        b=oKNq+vCdVYvDPswrMQjqrkUzFIqGNw9sTbO7j3aFtQ3Pa9vdkfDCqMaxUvsRfBWJbr
         UihBXEO69emsL7QDrPVjBUUte9oBKf9mzwtys5QKCuaEZvyJ8+cEfYfNdHgTq6n+9f97
         3PR1QoyT6hbIAmClzAtZy0JI8fO41qS/dQdrNpXt+GODL3BonC6Uy18ZLIRaIdihCosx
         DrZ4UoZ+ggLDvVFX/nukKWTe3T4stLlL4KFb8EYYbrG/oyD+joNZGzq/4Uxx1Pb8p8fZ
         PV9Hkl3Lh2BTWvxdxCv41H0tOn5n1nzK0pN8aEAO9DFIM7dSY8cXUv3wvufKiq/jwJuP
         qbjg==
X-Forwarded-Encrypted: i=1; AJvYcCViyXtWsSV3T6GD4K2kAoWdDls/nmlPPYuZZhiCEOq/CkZ1W8Z+zPWJYy6Q9M8fuERMeGVs6AGVjz0qKqTLcIVU/FAD6XwYR+DcYblL
X-Gm-Message-State: AOJu0Yz43IJO3G9wXRWRd11twrMPhC9JJP4/OKGzKmEfsvxolt1LOe8z
	dyA3ktvaAVaiE660J4OYQ2gbrvfCr3GNT9uyhnit7RAs3iMG9V/5ywVFdT2jefPZCZi28eOhNQ5
	xhNf+qRCkIvLarchOGFb7fuWa3Vc5/VY+eBf1C2KyF4SfaX815riGpJg=
X-Google-Smtp-Source: AGHT+IF2okDFYYACtM78GHxJSW7p6ypgkem81yHhPqKP6LvZ5bVld3W2oLnEEXSYlqAtJNOeFP5QVMMUjRI2y5nX0LRea7OuEUMl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d81:b0:368:b289:38b2 with SMTP id
 h1-20020a056e021d8100b00368b28938b2mr64156ila.1.1711635630923; Thu, 28 Mar
 2024 07:20:30 -0700 (PDT)
Date: Thu, 28 Mar 2024 07:20:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c430800614b93936@google.com>
Subject: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
From: syzbot <syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cc4c51180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/55a16212fbdf/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/704972635ac7/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a04b0d8c481f/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------------------
kworker/u8:3/49 is trying to acquire lock:
ffff888050f26da0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888050f26da0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: hsr_dev_xmit+0x13e/0x1d0 net/hsr/hsr_device.c:229

but task is already holding lock:
ffff88807cdaeda0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88807cdaeda0 (&hsr->seqnr_lock){+.-.}-{2:2}, at: send_hsr_supervision_frame+0x276/0xad0 net/hsr/hsr_device.c:310

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hsr->seqnr_lock);
  lock(&hsr->seqnr_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

9 locks held by kworker/u8:3/49:
 #0: ffff88802a81f948 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff88802a81f948 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90000b97d00 ((work_completion)(&(&bat_priv->nc.work)->work)
){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffc90000a08ca0 ((&hsr->announce_timer)){+.-.}-{0:0}
, at: call_timer_fn+0xc0/0x600 kernel/time/timer.c:1789
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hsr_announce+0xa3/0x370 net/hsr/hsr_device.c:387
 #4: ffff88807cdaeda0 (&hsr->seqnr_lock
){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
){+.-.}-{2:2}, at: send_hsr_supervision_frame+0x276/0xad0 net/hsr/hsr_device.c:310
 #5: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #5: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #5: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hsr_forward_skb+0xae/0x2400 net/hsr/hsr_forward.c:614
 #6: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #6: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
 #6: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4260
 #7: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #7: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #7: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: br_dev_xmit+0x1b9/0x1a10 net/bridge/br_device.c:44
 #8: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #8: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
 #8: ffffffff8e132080 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4260

stack backtrace:
CPU: 1 PID: 49 Comm: kworker/u8:3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 hsr_dev_xmit+0x13e/0x1d0 net/hsr/hsr_device.c:229
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
 __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 br_dev_queue_push_xmit+0x701/0x8d0 net/bridge/br_forward.c:53
 NF_HOOK+0x3a7/0x460 include/linux/netfilter.h:314
 br_forward_finish+0xe5/0x140 net/bridge/br_forward.c:66
 NF_HOOK+0x3a7/0x460 include/linux/netfilter.h:314
 __br_forward+0x489/0x660 net/bridge/br_forward.c:115
 deliver_clone net/bridge/br_forward.c:131 [inline]
 maybe_deliver+0xb3/0x150 net/bridge/br_forward.c:190
 br_flood+0x2e4/0x660 net/bridge/br_forward.c:236
 br_dev_xmit+0x118c/0x1a10
 __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
 netdev_start_xmit include/linux/netdevice.h:4917 [inline]
 xmit_one net/core/dev.c:3531 [inline]
 dev_hard_start_xmit+0x26a/0x790 net/core/dev.c:3547
 __dev_queue_xmit+0x19f4/0x3b10 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 hsr_xmit net/hsr/hsr_forward.c:380 [inline]
 hsr_forward_do net/hsr/hsr_forward.c:471 [inline]
 hsr_forward_skb+0x183f/0x2400 net/hsr/hsr_forward.c:619
 send_hsr_supervision_frame+0x548/0xad0 net/hsr/hsr_device.c:333
 hsr_announce+0x1a9/0x370 net/hsr/hsr_device.c:389
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2408 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2419
 run_timer_base kernel/time/timer.c:2428 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x30f/0x3b0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

