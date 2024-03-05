Return-Path: <linux-kernel+bounces-92206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B76871CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6282858DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA53548FB;
	Tue,  5 Mar 2024 11:02:33 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF601C6AD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636552; cv=none; b=NBx2sgWDSwFFJVTgqNmpnbswZUzwqyYtBZ86lktD1I4UYpQzex08olQeS+OoGbyULZjpFOvGMMt3/EmT7t/x2e3PX90ISiRMaJnlKo+xwp4X3DJHpv6T67U2cWhqgU0I8a47PCoJmdVRRBsCgy/r/wyVvYeTZHtMbiTf/E2iF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636552; c=relaxed/simple;
	bh=44i2yzYMTM/Qx38/LmUkZCiU4dgfaMnAk7sThNoPnQA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JksolMoxVi6hyw32vqTGBBaOyjOZf1NUNsHWP6a4A5R0hS/PlCYTevv3nONi4ryQZI0d4CTHFU8RyWm5xYNRIBNnFgTvFZorRH4k76gAN6zVCjTxRtAahdItac0ag3r+eIyiAAFKKylIuoOBdqA+NIBJcM8+RGTET4AzFgr5+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c84ad0cc57so196091039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636549; x=1710241349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zu0yjfYkSXS39+0GR+0nFOnyp2xdyOS4P2L+zSt+RHs=;
        b=D0RnH4LfvVAm4E3uGb5Gs7wxukp/kIZBJfUfi7zrs8IufQnAx/lthj+bt4oHsNrtrr
         yvZGdGYjuqSUba5jTrafmH6NLZpc+d8sp+9tud62W5boBFFRAhGrEDvubVhcP0hB+/DI
         bZH+zkAxpXpBHc3LYlSujBSjZGLHraQTfrvW63T7K4HyEq25N2uq5U1Pr90UNnHf3b4P
         Y5kfxJtaxi9wF7yTQzcYyWSGVpy01kfg9ZXeJWDmjP6KABR0F1xBVUiMnSc0jsuvlkGE
         pxkmW7oNpbFmr4cPo7r8AYLFQ/uW21dSmr8MXfxnWwHftMGe+C8D/hc4UC1FnMRWQ89y
         lc5w==
X-Forwarded-Encrypted: i=1; AJvYcCXo5pVXKbSuz3BYsmIO59GfC5MvmZCi40jFfoaVRuYrY3V0KLnizourwFYIvX71fvw9ZGkATv93/n7di4Lb+dhsi8yUME8AweRxZqkJ
X-Gm-Message-State: AOJu0Yw7o1iaVKSgMiSDtLTF55zgT10BfwT79avY0FBWT7NxsPDkBd1F
	385JBaqILQK87l2F0OEG1rp50r8bdrWSTFI4J8xsb4Zexhidke6aLZ/TjitPf34+43FtrCog2yY
	E1rlB8IQpJpRSSWw9TEeAQFi642nY0Hu5mNiBLjl89e7vslN73DeDkpw=
X-Google-Smtp-Source: AGHT+IFvxzOq9Z6qyDXqxm1bNTjiulhlu5dWuPCZ9yTRcdmgN+c3JuK8P99v2WH6eNIiMjl3LyhZMh9sdLHZ4IAeLuEQJ61GZpX3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16ca:b0:474:7c07:5dda with SMTP id
 g10-20020a05663816ca00b004747c075ddamr355448jat.5.1709636549242; Tue, 05 Mar
 2024 03:02:29 -0800 (PST)
Date: Tue, 05 Mar 2024 03:02:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003686890612e7c7f1@google.com>
Subject: [syzbot] [block?] possible deadlock in mempool_free
From: syzbot <syzbot+03a410b5470dc0d57748@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17ba56605bfd Merge tag 'iommu-fix-v6.8-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14240bba180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be0288b26c967205
dashboard link: https://syzkaller.appspot.com/bug?extid=03a410b5470dc0d57748
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-17ba5660.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1846d2ec3e0f/vmlinux-17ba5660.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c24b84f13f11/bzImage-17ba5660.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03a410b5470dc0d57748@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.8.0-rc6-syzkaller-00194-g17ba56605bfd #0 Not tainted
-----------------------------------------------------
syz-executor.0/13441 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8d93fc00 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: fs_reclaim_acquire mm/page_alloc.c:3709 [inline]
ffffffff8d93fc00 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: fs_reclaim_acquire+0xb0/0x150 mm/page_alloc.c:3700

and this task is already holding:
ffff88801a379718 (&pool->lock#3){..-.}-{2:2}, at: mempool_alloc+0x1ff/0x390 mm/mempool.c:412
which would create a new lock dependency:
 (&pool->lock#3){..-.}-{2:2} -> (mmu_notifier_invalidate_range_start){+.+.}-{0:0}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&pool->lock#3){..-.}-{2:2}

.. which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
  mempool_free+0x10a/0x3b0 mm/mempool.c:545
  bvec_free+0xfb/0x120 block/bio.c:168
  bio_free+0xaa/0x130 block/bio.c:237
  bio_put_percpu_cache block/bio.c:767 [inline]
  bio_put+0x2fb/0x650 block/bio.c:806
  iomap_dio_bio_end_io+0x28a/0x6c0 fs/iomap/direct-io.c:230
  bio_endio+0x59c/0x6b0 block/bio.c:1608
  req_bio_endio block/blk-mq.c:792 [inline]
  blk_update_request+0x635/0x1710 block/blk-mq.c:937
  scsi_end_request+0x7b/0x9c0 drivers/scsi/scsi_lib.c:539
  scsi_io_completion+0x17c/0x14c0 drivers/scsi/scsi_lib.c:977
  scsi_complete+0x124/0x250 drivers/scsi/scsi_lib.c:1439
  blk_complete_reqs+0xae/0xf0 block/blk-mq.c:1135
  __do_softirq+0x21c/0x8e7 kernel/softirq.c:553
  run_ksoftirqd kernel/softirq.c:921 [inline]
  run_ksoftirqd+0x35/0x60 kernel/softirq.c:913
  smpboot_thread_fn+0x669/0xa20 kernel/smpboot.c:164
  kthread+0x2c6/0x3b0 kernel/kthread.c:388
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

to a SOFTIRQ-irq-unsafe lock:
 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}

.. which became SOFTIRQ-irq-unsafe at:
..
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
  fs_reclaim_acquire mm/page_alloc.c:3709 [inline]
  fs_reclaim_acquire+0xcc/0x150 mm/page_alloc.c:3700
  might_alloc include/linux/sched/mm.h:303 [inline]
  slab_pre_alloc_hook mm/slub.c:3761 [inline]
  slab_alloc_node mm/slub.c:3842 [inline]
  kmalloc_trace+0x51/0x340 mm/slub.c:4007
  kmalloc include/linux/slab.h:590 [inline]
  kzalloc include/linux/slab.h:711 [inline]
  __kthread_create_worker+0x4d/0x200 kernel/kthread.c:864
  kthread_create_worker+0xcd/0x110 kernel/kthread.c:907
  wq_cpu_intensive_thresh_init kernel/workqueue.c:6704 [inline]
  workqueue_init+0x25/0x830 kernel/workqueue.c:6753
  kernel_init_freeable+0x335/0xc10 init/main.c:1536
  kernel_init+0x1c/0x2a0 init/main.c:1441
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mmu_notifier_invalidate_range_start);
                               local_irq_disable();
                               lock(&pool->lock#3);
                               lock(mmu_notifier_invalidate_range_start);
  <Interrupt>
    lock(&pool->lock#3);

 *** DEADLOCK ***

4 locks held by syz-executor.0/13441:
 #0: ffff8880241da420 (sb_writers#5){.+.+}-{0:0}, at: do_pwritev+0x1b3/0x260 fs/read_write.c:1072
 #1: ffff888031e54000 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:804 [inline]
 #1: ffff888031e54000 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_dio_write_iter fs/ext4/file.c:530 [inline]
 #1: ffff888031e54000 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: ext4_file_write_iter+0xc8b/0x1960 fs/ext4/file.c:696
 #2: ffffffff8d7ad220 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #2: ffffffff8d7ad220 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #2: ffffffff8d7ad220 (rcu_read_lock){....}-{1:2}, at: blk_mq_run_hw_queue+0x619/0x9a0 block/blk-mq.c:2285
 #3: ffff88801a379718 (&pool->lock#3){..-.}-{2:2}, at: mempool_alloc+0x1ff/0x390 mm/mempool.c:412

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&pool->lock#3){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    mempool_free+0x10a/0x3b0 mm/mempool.c:545
                    bvec_free+0xfb/0x120 block/bio.c:168
                    bio_free+0xaa/0x130 block/bio.c:237
                    bio_put_percpu_cache block/bio.c:767 [inline]
                    bio_put+0x2fb/0x650 block/bio.c:806
                    iomap_dio_bio_end_io+0x28a/0x6c0 fs/iomap/direct-io.c:230
                    bio_endio+0x59c/0x6b0 block/bio.c:1608
                    req_bio_endio block/blk-mq.c:792 [inline]
                    blk_update_request+0x635/0x1710 block/blk-mq.c:937
                    scsi_end_request+0x7b/0x9c0 drivers/scsi/scsi_lib.c:539
                    scsi_io_completion+0x17c/0x14c0 drivers/scsi/scsi_lib.c:977
                    scsi_complete+0x124/0x250 drivers/scsi/scsi_lib.c:1439
                    blk_complete_reqs+0xae/0xf0 block/blk-mq.c:1135
                    __do_softirq+0x21c/0x8e7 kernel/softirq.c:553
                    run_ksoftirqd kernel/softirq.c:921 [inline]
                    run_ksoftirqd+0x35/0x60 kernel/softirq.c:913
                    smpboot_thread_fn+0x669/0xa20 kernel/smpboot.c:164
                    kthread+0x2c6/0x3b0 kernel/kthread.c:388
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                   mempool_alloc+0x1ff/0x390 mm/mempool.c:412
                   bvec_alloc+0x192/0x210 block/bio.c:211
                   bio_alloc_bioset+0x4b9/0x8b0 block/bio.c:558
                   bio_alloc include/linux/bio.h:437 [inline]
                   iomap_dio_alloc_bio fs/iomap/direct-io.c:61 [inline]
                   iomap_dio_alloc_bio.isra.0+0x86/0xc0 fs/iomap/direct-io.c:55
                   iomap_dio_bio_iter+0xaa7/0x16c0 fs/iomap/direct-io.c:379
                   iomap_dio_iter fs/iomap/direct-io.c:500 [inline]
                   __iomap_dio_rw+0xd7b/0x1bd0 fs/iomap/direct-io.c:659
                   iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:748
                   ext4_dio_write_iter fs/ext4/file.c:577 [inline]
                   ext4_file_write_iter+0x12c6/0x1960 fs/ext4/file.c:696
                   call_write_iter include/linux/fs.h:2087 [inline]
                   do_iter_readv_writev+0x41d/0x670 fs/read_write.c:741
                   vfs_writev+0x36f/0xdb0 fs/read_write.c:971
                   do_pwritev+0x1b3/0x260 fs/read_write.c:1072
                   __do_sys_pwritev2 fs/read_write.c:1131 [inline]
                   __se_sys_pwritev2 fs/read_write.c:1122 [inline]
                   __x64_sys_pwritev2+0xef/0x160 fs/read_write.c:1122
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x6f/0x77
 }
 ... key      at: [<ffffffff9463bc00>] __key.1+0x0/0x40

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (mmu_notifier_invalidate_range_start){+.+.}-{0:0} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
                    fs_reclaim_acquire mm/page_alloc.c:3709 [inline]
                    fs_reclaim_acquire+0xcc/0x150 mm/page_alloc.c:3700
                    might_alloc include/linux/sched/mm.h:303 [inline]
                    slab_pre_alloc_hook mm/slub.c:3761 [inline]
                    slab_alloc_node mm/slub.c:3842 [inline]
                    kmalloc_trace+0x51/0x340 mm/slub.c:4007
                    kmalloc include/linux/slab.h:590 [inline]
                    kzalloc include/linux/slab.h:711 [inline]
                    __kthread_create_worker+0x4d/0x200 kernel/kthread.c:864
                    kthread_create_worker+0xcd/0x110 kernel/kthread.c:907
                    wq_cpu_intensive_thresh_init kernel/workqueue.c:6704 [inline]
                    workqueue_init+0x25/0x830 kernel/workqueue.c:6753
                    kernel_init_freeable+0x335/0xc10 init/main.c:1536
                    kernel_init+0x1c/0x2a0 init/main.c:1441
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
                    fs_reclaim_acquire mm/page_alloc.c:3709 [inline]
                    fs_reclaim_acquire+0xcc/0x150 mm/page_alloc.c:3700
                    might_alloc include/linux/sched/mm.h:303 [inline]
                    slab_pre_alloc_hook mm/slub.c:3761 [inline]
                    slab_alloc_node mm/slub.c:3842 [inline]
                    kmalloc_trace+0x51/0x340 mm/slub.c:4007
                    kmalloc include/linux/slab.h:590 [inline]
                    kzalloc include/linux/slab.h:711 [inline]
                    __kthread_create_worker+0x4d/0x200 kernel/kthread.c:864
                    kthread_create_worker+0xcd/0x110 kernel/kthread.c:907
                    wq_cpu_intensive_thresh_init kernel/workqueue.c:6704 [inline]
                    workqueue_init+0x25/0x830 kernel/workqueue.c:6753
                    kernel_init_freeable+0x335/0xc10 init/main.c:1536
                    kernel_init+0x1c/0x2a0 init/main.c:1441
                    ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
                   fs_reclaim_acquire mm/page_alloc.c:3709 [inline]
                   fs_reclaim_acquire+0xcc/0x150 mm/page_alloc.c:3700
                   might_alloc include/linux/sched/mm.h:303 [inline]
                   slab_pre_alloc_hook mm/slub.c:3761 [inline]
                   slab_alloc_node mm/slub.c:3842 [inline]
                   kmalloc_trace+0x51/0x340 mm/slub.c:4007
                   kmalloc include/linux/slab.h:590 [inline]
                   kzalloc include/linux/slab.h:711 [inline]
                   __kthread_create_worker+0x4d/0x200 kernel/kthread.c:864
                   kthread_create_worker+0xcd/0x110 kernel/kthread.c:907
                   wq_cpu_intensive_thresh_init kernel/workqueue.c:6704 [inline]
                   workqueue_init+0x25/0x830 kernel/workqueue.c:6753
                   kernel_init_freeable+0x335/0xc10 init/main.c:1536
                   kernel_init+0x1c/0x2a0 init/main.c:1441
                   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff8d93fc00>] __mmu_notifier_invalidate_range_start_map+0x0/0x60
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5754 [inline]
   lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
   fs_reclaim_acquire mm/page_alloc.c:3709 [inline]
   fs_reclaim_acquire+0xcc/0x150 mm/page_alloc.c:3700
   might_alloc include/linux/sched/mm.h:303 [inline]
   prepare_alloc_pages.constprop.0+0x155/0x560 mm/page_alloc.c:4338
   __alloc_pages+0x193/0x2440 mm/page_alloc.c:4556
   alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
   stack_depot_save_flags+0x568/0x900 lib/stackdepot.c:676
   kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
   unpoison_slab_object mm/kasan/common.c:312 [inline]
   __kasan_mempool_unpoison_object+0x12c/0x1b0 mm/kasan/common.c:535
   kasan_mempool_unpoison_object include/linux/kasan.h:339 [inline]
   kasan_unpoison_element mm/mempool.c:130 [inline]
   remove_element+0x160/0x1e0 mm/mempool.c:150
   mempool_alloc+0x257/0x390 mm/mempool.c:414
   __sg_alloc_table+0x25d/0x390 lib/scatterlist.c:321
   sg_alloc_table_chained+0x97/0x1d0 lib/sg_pool.c:133
   scsi_alloc_sgtables+0x1cd/0xfc0 drivers/scsi/scsi_lib.c:1042
   sd_setup_read_write_cmnd drivers/scsi/sd.c:1200 [inline]
   sd_init_command+0xafa/0x34b0 drivers/scsi/sd.c:1325
   scsi_prepare_cmd drivers/scsi/scsi_lib.c:1607 [inline]
   scsi_queue_rq+0x1ff8/0x35f0 drivers/scsi/scsi_lib.c:1741
   blk_mq_dispatch_rq_list+0x452/0x2030 block/blk-mq.c:2070
   __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
   blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
   __blk_mq_sched_dispatch_requests+0xce0/0x1620 block/blk-mq-sched.c:309
   blk_mq_sched_dispatch_requests+0xd4/0x150 block/blk-mq-sched.c:331
   blk_mq_run_hw_queue+0x645/0x9a0 block/blk-mq.c:2285
   blk_mq_dispatch_plug_list block/blk-mq.c:2785 [inline]
   blk_mq_flush_plug_list.part.0+0x5f3/0x1d20 block/blk-mq.c:2833
   blk_mq_flush_plug_list block/blk-mq.c:1296 [inline]
   blk_add_rq_to_plug+0x117/0x540 block/blk-mq.c:1299
   blk_mq_submit_bio+0x1625/0x2270 block/blk-mq.c:3027
   __submit_bio+0xfd/0x310 block/blk-core.c:608
   __submit_bio_noacct_mq block/blk-core.c:687 [inline]
   submit_bio_noacct_nocheck+0x84b/0xba0 block/blk-core.c:716
   submit_bio_noacct+0x747/0x1b50 block/blk-core.c:826
   iomap_dio_submit_bio+0x1d3/0x240 fs/iomap/direct-io.c:80
   iomap_dio_bio_iter+0xa4a/0x16c0 fs/iomap/direct-io.c:417
   iomap_dio_iter fs/iomap/direct-io.c:500 [inline]
   __iomap_dio_rw+0xd7b/0x1bd0 fs/iomap/direct-io.c:659
   iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:748
   ext4_dio_write_iter fs/ext4/file.c:577 [inline]
   ext4_file_write_iter+0x12c6/0x1960 fs/ext4/file.c:696
   call_write_iter include/linux/fs.h:2087 [inline]
   do_iter_readv_writev+0x41d/0x670 fs/read_write.c:741
   vfs_writev+0x36f/0xdb0 fs/read_write.c:971
   do_pwritev+0x1b3/0x260 fs/read_write.c:1072
   __do_sys_pwritev2 fs/read_write.c:1131 [inline]
   __se_sys_pwritev2 fs/read_write.c:1122 [inline]
   __x64_sys_pwritev2+0xef/0x160 fs/read_write.c:1122
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x6f/0x77


stack backtrace:
CPU: 3 PID: 13441 Comm: syz-executor.0 Not tainted 6.8.0-rc6-syzkaller-00194-g17ba56605bfd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe3c/0x1490 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2465/0x3b40 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 fs_reclaim_acquire mm/page_alloc.c:3709 [inline]
 fs_reclaim_acquire+0xcc/0x150 mm/page_alloc.c:3700
 might_alloc include/linux/sched/mm.h:303 [inline]
 prepare_alloc_pages.constprop.0+0x155/0x560 mm/page_alloc.c:4338
 __alloc_pages+0x193/0x2440 mm/page_alloc.c:4556
 alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
 stack_depot_save_flags+0x568/0x900 lib/stackdepot.c:676
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_mempool_unpoison_object+0x12c/0x1b0 mm/kasan/common.c:535
 kasan_mempool_unpoison_object include/linux/kasan.h:339 [inline]
 kasan_unpoison_element mm/mempool.c:130 [inline]
 remove_element+0x160/0x1e0 mm/mempool.c:150
 mempool_alloc+0x257/0x390 mm/mempool.c:414
 __sg_alloc_table+0x25d/0x390 lib/scatterlist.c:321
 sg_alloc_table_chained+0x97/0x1d0 lib/sg_pool.c:133
 scsi_alloc_sgtables+0x1cd/0xfc0 drivers/scsi/scsi_lib.c:1042
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1200 [inline]
 sd_init_command+0xafa/0x34b0 drivers/scsi/sd.c:1325
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1607 [inline]
 scsi_queue_rq+0x1ff8/0x35f0 drivers/scsi/scsi_lib.c:1741
 blk_mq_dispatch_rq_list+0x452/0x2030 block/blk-mq.c:2070
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xce0/0x1620 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xd4/0x150 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x645/0x9a0 block/blk-mq.c:2285
 blk_mq_dispatch_plug_list block/blk-mq.c:2785 [inline]
 blk_mq_flush_plug_list.part.0+0x5f3/0x1d20 block/blk-mq.c:2833
 blk_mq_flush_plug_list block/blk-mq.c:1296 [inline]
 blk_add_rq_to_plug+0x117/0x540 block/blk-mq.c:1299
 blk_mq_submit_bio+0x1625/0x2270 block/blk-mq.c:3027
 __submit_bio+0xfd/0x310 block/blk-core.c:608
 __submit_bio_noacct_mq block/blk-core.c:687 [inline]
 submit_bio_noacct_nocheck+0x84b/0xba0 block/blk-core.c:716
 submit_bio_noacct+0x747/0x1b50 block/blk-core.c:826
 iomap_dio_submit_bio+0x1d3/0x240 fs/iomap/direct-io.c:80
 iomap_dio_bio_iter+0xa4a/0x16c0 fs/iomap/direct-io.c:417
 iomap_dio_iter fs/iomap/direct-io.c:500 [inline]
 __iomap_dio_rw+0xd7b/0x1bd0 fs/iomap/direct-io.c:659
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:748
 ext4_dio_write_iter fs/ext4/file.c:577 [inline]
 ext4_file_write_iter+0x12c6/0x1960 fs/ext4/file.c:696
 call_write_iter include/linux/fs.h:2087 [inline]
 do_iter_readv_writev+0x41d/0x670 fs/read_write.c:741
 vfs_writev+0x36f/0xdb0 fs/read_write.c:971
 do_pwritev+0x1b3/0x260 fs/read_write.c:1072
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __x64_sys_pwritev2+0xef/0x160 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f4b1d87dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4b1e6ad0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f4b1d9abf80 RCX: 00007f4b1d87dda9
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007f4b1e6ad120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f4b1d9abf80 R15: 00007ffcd63e5928
 </TASK>
BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 13441, name: syz-executor.0
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
irq event stamp: 89064
hardirqs last  enabled at (89063): [<ffffffff8ac7fb72>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (89063): [<ffffffff8ac7fb72>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
hardirqs last disabled at (89064): [<ffffffff8ac7f882>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (89064): [<ffffffff8ac7f882>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (88412): [<ffffffff8ac829dc>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (88412): [<ffffffff8ac829dc>] __do_softirq+0x59c/0x8e7 kernel/softirq.c:582
softirqs last disabled at (88351): [<ffffffff815166db>] invoke_softirq kernel/softirq.c:427 [inline]
softirqs last disabled at (88351): [<ffffffff815166db>] __irq_exit_rcu kernel/softirq.c:632 [inline]
softirqs last disabled at (88351): [<ffffffff815166db>] irq_exit_rcu+0xbb/0x120 kernel/softirq.c:644
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 3 PID: 13441 Comm: syz-executor.0 Not tainted 6.8.0-rc6-syzkaller-00194-g17ba56605bfd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c7/0x5e0 kernel/sched/core.c:10176
 might_alloc include/linux/sched/mm.h:306 [inline]
 prepare_alloc_pages.constprop.0+0x3d2/0x560 mm/page_alloc.c:4338
 __alloc_pages+0x193/0x2440 mm/page_alloc.c:4556
 alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
 stack_depot_save_flags+0x568/0x900 lib/stackdepot.c:676
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_mempool_unpoison_object+0x12c/0x1b0 mm/kasan/common.c:535
 kasan_mempool_unpoison_object include/linux/kasan.h:339 [inline]
 kasan_unpoison_element mm/mempool.c:130 [inline]
 remove_element+0x160/0x1e0 mm/mempool.c:150
 mempool_alloc+0x257/0x390 mm/mempool.c:414
 __sg_alloc_table+0x25d/0x390 lib/scatterlist.c:321
 sg_alloc_table_chained+0x97/0x1d0 lib/sg_pool.c:133
 scsi_alloc_sgtables+0x1cd/0xfc0 drivers/scsi/scsi_lib.c:1042
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1200 [inline]
 sd_init_command+0xafa/0x34b0 drivers/scsi/sd.c:1325
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1607 [inline]
 scsi_queue_rq+0x1ff8/0x35f0 drivers/scsi/scsi_lib.c:1741
 blk_mq_dispatch_rq_list+0x452/0x2030 block/blk-mq.c:2070
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0xce0/0x1620 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0xd4/0x150 block/blk-mq-sched.c:331
 blk_mq_run_hw_queue+0x645/0x9a0 block/blk-mq.c:2285
 blk_mq_dispatch_plug_list block/blk-mq.c:2785 [inline]
 blk_mq_flush_plug_list.part.0+0x5f3/0x1d20 block/blk-mq.c:2833
 blk_mq_flush_plug_list block/blk-mq.c:1296 [inline]
 blk_add_rq_to_plug+0x117/0x540 block/blk-mq.c:1299
 blk_mq_submit_bio+0x1625/0x2270 block/blk-mq.c:3027
 __submit_bio+0xfd/0x310 block/blk-core.c:608
 __submit_bio_noacct_mq block/blk-core.c:687 [inline]
 submit_bio_noacct_nocheck+0x84b/0xba0 block/blk-core.c:716
 submit_bio_noacct+0x747/0x1b50 block/blk-core.c:826
 iomap_dio_submit_bio+0x1d3/0x240 fs/iomap/direct-io.c:80
 iomap_dio_bio_iter+0xa4a/0x16c0 fs/iomap/direct-io.c:417
 iomap_dio_iter fs/iomap/direct-io.c:500 [inline]
 __iomap_dio_rw+0xd7b/0x1bd0 fs/iomap/direct-io.c:659
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:748
 ext4_dio_write_iter fs/ext4/file.c:577 [inline]
 ext4_file_write_iter+0x12c6/0x1960 fs/ext4/file.c:696
 call_write_iter include/linux/fs.h:2087 [inline]
 do_iter_readv_writev+0x41d/0x670 fs/read_write.c:741
 vfs_writev+0x36f/0xdb0 fs/read_write.c:971
 do_pwritev+0x1b3/0x260 fs/read_write.c:1072
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __x64_sys_pwritev2+0xef/0x160 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f4b1d87dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4b1e6ad0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f4b1d9abf80 RCX: 00007f4b1d87dda9
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007f4b1e6ad120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f4b1d9abf80 R15: 00007ffcd63e5928
 </TASK>
syz-executor.0 (13441) used greatest stack depth: 20904 bytes left


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

