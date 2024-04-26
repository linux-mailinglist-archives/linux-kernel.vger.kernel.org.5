Return-Path: <linux-kernel+bounces-159887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE058B3579
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3809C1C20DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F7A13FD9D;
	Fri, 26 Apr 2024 10:43:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F3144D0E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128209; cv=none; b=UQL3ot4sWyNP4FxbqupM19O6Srn2Vm97772DfAt9xUA5Fjp9vuVHCZ6hVStf1WdQqpcCX00zu9u3xdiVeGZkC7eMntE4dkZlczTMJ/U9h4PMwnTDgKpLUldzFGgDzTNczKUODUERvwDLOngWgVN01MNCtmJO5mis1z2d7MCYO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128209; c=relaxed/simple;
	bh=cen6lNgCCVz8btlmq0zy0Ql0ebvrg1gcAgqQtz9IKrg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aZCXZYpdQ7KXS87aDUPNM2zumuA6Y8wOBOMzj0NuUkxzIjyGkSsz95dD0iI3GK0mfetlcnIUuzdeFocdPhvNLE91DkVpGbbBxrjd8VFrYlSLPLx8XiKxLK1TXQxm+htcdAgVrCcPrKiCa6Hdxgmf/9yfXIFiubanZgyQlG/o2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dab89699a8so200451239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128207; x=1714733007;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzRmLjOEnJOZg8+lS/UMp/8p9lMjC4NxeXqmjjML8I8=;
        b=a8Wv0NB94uDu7nmEhcUVi7kwf9rNfTeeZdRRFl+SPffmcb57CGQkxC0vBRxD5agbWn
         0UdnDZxYTqAwwjUq0PIm8wUy4a+BfpF8CXzLruf+jfWfqQkQGRiy/Es3uUQAnS4y/x23
         Lo3UREGfs/trx4ohhyOPHxHLF70jDPOc46V/s0T7gHXkpXpmhSp8fkz2c03MHUWnQ55a
         PLHT9AMwYjqTtZR2uwGH31ieUYPLiGx/fIIrgqY73lNcf2HqKVgDT32H7OXv0yfMxBRX
         DjPB0qGeEdwrvLjBl5brdlQAar4SEa8oyuqnQKhBUp5joBtUHE29EAk7H3NIF+vBHyQr
         CUOA==
X-Forwarded-Encrypted: i=1; AJvYcCWF61ggvrqzlxVmexWxd9Nm2esPZxshx4/SOLu4rCk6VeyANpmBVPMt7E5CBIfMTDeS8kIbhfij1coSGyhaaYUYSWYzOQQyff6W9630
X-Gm-Message-State: AOJu0YzP+8MqMqnOpRDuDF41GMXatSjvIbf1O4N6q3wnIuCU96hQOnAA
	jkzsF55US5Jhhxhd4cOAMRjaB9pTi6eEy2nGODUU0ob0Lh/HlCD3G/QhwEmZVPKIv5qpO0aGw8r
	IICLsFZvuS/I1JaU+WhLgl6boUeQ6JGgviYVKiDaxyu2tY4LxS2jNfoY=
X-Google-Smtp-Source: AGHT+IElkBi0g7Hhssi3DomJ640r/MCw2iXIavYBxhXYG3mGaBr/0iyBQHnb0g/fOwvIE1qUVGkr+qJhzgRMZBmAP556UkrXKWqG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b81:b0:7da:cb80:784b with SMTP id
 r1-20020a0566022b8100b007dacb80784bmr42574iov.0.1714128207176; Fri, 26 Apr
 2024 03:43:27 -0700 (PDT)
Date: Fri, 26 Apr 2024 03:43:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e378d80616fd9248@google.com>
Subject: [syzbot] [serial?] possible deadlock in pty_flush_buffer (2)
From: syzbot <syzbot+87da1f0dd6b631f8bfb9@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ed30a4a51bb1 Linux 6.9-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111df107180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=87da1f0dd6b631f8bfb9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d0f558a8144/disk-ed30a4a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca1e84aa7770/vmlinux-ed30a4a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9183b6bdee8e/bzImage-ed30a4a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87da1f0dd6b631f8bfb9@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/26340 is trying to acquire lock:
ffff888062bca570 (&tty->read_wait){....}-{2:2}, at: __wake_up_common_lock kernel/sched/wait.c:105 [inline]
ffff888062bca570 (&tty->read_wait){....}-{2:2}, at: __wake_up+0x1c/0x60 kernel/sched/wait.c:127

but task is already holding lock:
ffff88807e9eb4c0 (&tty->ctrl.lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
ffff88807e9eb4c0 (&tty->ctrl.lock){....}-{2:2}, at: pty_flush_buffer+0xaf/0x120 drivers/tty/pty.c:213

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&tty->ctrl.lock){....}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __proc_set_tty+0x2c/0x6b0 drivers/tty/tty_jobctrl.c:102
       tty_open_proc_set_tty+0x1f6/0x250 drivers/tty/tty_jobctrl.c:154
       tty_open+0xdb0/0x1020 drivers/tty/tty_io.c:2184
       chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
       do_dentry_open+0x8da/0x18c0 fs/open.c:955
       do_open fs/namei.c:3642 [inline]
       path_openat+0x1dfb/0x2990 fs/namei.c:3799
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&sighand->siglock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __lock_task_sighand+0xc2/0x340 kernel/signal.c:1414
       lock_task_sighand include/linux/sched/signal.h:746 [inline]
       do_send_sig_info kernel/signal.c:1300 [inline]
       group_send_sig_info+0x290/0x300 kernel/signal.c:1453
       bpf_send_signal_common+0x2e8/0x3a0 kernel/trace/bpf_trace.c:881
       ____bpf_send_signal_thread kernel/trace/bpf_trace.c:898 [inline]
       bpf_send_signal_thread+0x16/0x20 kernel/trace/bpf_trace.c:896
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
       __bpf_trace_mmap_lock_acquire_returned+0x134/0x180 include/trace/events/mmap_lock.h:52
       trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:52 [inline]
       __mmap_lock_do_trace_acquire_returned+0x456/0x790 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       get_mmap_lock_carefully mm/memory.c:5633 [inline]
       lock_mm_and_find_vma+0xeb/0x580 mm/memory.c:5693
       do_user_addr_fault+0x29c/0x1080 arch/x86/mm/fault.c:1385
       handle_page_fault arch/x86/mm/fault.c:1505 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1563
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       rep_movs_alternative+0x4a/0x70 arch/x86/lib/copy_user_64.S:65
       copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
       raw_copy_to_user arch/x86/include/asm/uaccess_64.h:131 [inline]
       copy_to_user_iter lib/iov_iter.c:25 [inline]
       iterate_ubuf include/linux/iov_iter.h:29 [inline]
       iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
       iterate_and_advance include/linux/iov_iter.h:271 [inline]
       _copy_to_iter+0x37e/0x1110 lib/iov_iter.c:185
       copy_page_to_iter lib/iov_iter.c:362 [inline]
       copy_page_to_iter+0xf1/0x180 lib/iov_iter.c:349
       pipe_read+0x543/0x1400 fs/pipe.c:327
       call_read_iter include/linux/fs.h:2104 [inline]
       new_sync_read fs/read_write.c:395 [inline]
       vfs_read+0x9fd/0xb80 fs/read_write.c:476
       ksys_read+0x1f8/0x260 fs/read_write.c:619
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (lock#10){+.+.}-{2:2}:
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_acquire_returned+0x97/0x790 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       stack_map_get_build_id_offset+0x5df/0x7d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x6bf/0x700 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
       bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1975
       ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
       __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
       bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
       bpf_trace_run3+0x167/0x440 kernel/trace/bpf_trace.c:2421
       __bpf_trace_workqueue_queue_work+0x101/0x140 include/trace/events/workqueue.h:23
       trace_workqueue_queue_work include/trace/events/workqueue.h:23 [inline]
       __queue_work+0x627/0x1020 kernel/workqueue.c:2382
       queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
       queue_work include/linux/workqueue.h:605 [inline]
       loop_queue_work drivers/block/loop.c:882 [inline]
       loop_queue_rq+0x5e5/0x1210 drivers/block/loop.c:1874
       __blk_mq_issue_directly+0xe0/0x270 block/blk-mq.c:2595
       blk_mq_try_issue_directly+0x1c8/0x410 block/blk-mq.c:2654
       blk_mq_submit_bio+0x18fd/0x20f0 block/blk-mq.c:3019
       __submit_bio+0xfd/0x310 block/blk-core.c:621
       __submit_bio_noacct_mq block/blk-core.c:700 [inline]
       submit_bio_noacct_nocheck+0x98a/0xd50 block/blk-core.c:729
       submit_bio_noacct+0x746/0x1ba0 block/blk-core.c:839
       submit_bh fs/buffer.c:2809 [inline]
       __bread_slow fs/buffer.c:1267 [inline]
       __bread_gfp+0x1ac/0x370 fs/buffer.c:1477
       sb_bread_unmovable include/linux/buffer_head.h:327 [inline]
       ntfs_bread+0xd9/0x210 fs/ntfs3/fsntfs.c:1025
       ntfs_read_run_nb+0x3a0/0x8f0 fs/ntfs3/fsntfs.c:1245
       ntfs_read_bh+0x3c/0xb0 fs/ntfs3/fsntfs.c:1313
       mi_read+0x1e7/0x660 fs/ntfs3/record.c:133
       ntfs_read_mft fs/ntfs3/inode.c:70 [inline]
       ntfs_iget5+0x4c2/0x3860 fs/ntfs3/inode.c:532
       ntfs_fill_super+0x22ae/0x4490 fs/ntfs3/super.c:1328
       get_tree_bdev+0x36f/0x610 fs/super.c:1614
       vfs_get_tree+0x8f/0x380 fs/super.c:1779
       do_new_mount fs/namespace.c:3352 [inline]
       path_mount+0x14e6/0x1f20 fs/namespace.c:3679
       do_mount fs/namespace.c:3692 [inline]
       __do_sys_mount fs/namespace.c:3898 [inline]
       __se_sys_mount fs/namespace.c:3875 [inline]
       __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x39e/0x1020 kernel/workqueue.c:2360
       queue_work_on+0xf4/0x120 kernel/workqueue.c:2435
       queue_work include/linux/workqueue.h:605 [inline]
       schedule_work include/linux/workqueue.h:666 [inline]
       p9_pollwake+0xc1/0x1d0 net/9p/trans_fd.c:538
       __wake_up_common+0x131/0x1e0 kernel/sched/wait.c:89
       __wake_up_common_lock kernel/sched/wait.c:106 [inline]
       __wake_up+0x31/0x60 kernel/sched/wait.c:127
       tty_set_termios+0x6db/0x9b0 drivers/tty/tty_ioctl.c:352
       set_termios+0x57e/0x7f0 drivers/tty/tty_ioctl.c:516
       tty_mode_ioctl+0x9dc/0xd20 drivers/tty/tty_ioctl.c:826
       n_tty_ioctl_helper+0x4b/0x2b0 drivers/tty/tty_ioctl.c:986
       n_tty_ioctl+0x7f/0x370 drivers/tty/n_tty.c:2511
       tty_ioctl+0x6fa/0x1590 drivers/tty/tty_io.c:2812
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:904 [inline]
       __se_sys_ioctl fs/ioctl.c:890 [inline]
       __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&tty->read_wait){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       __wake_up_common_lock kernel/sched/wait.c:105 [inline]
       __wake_up+0x1c/0x60 kernel/sched/wait.c:127
       pty_flush_buffer+0xf0/0x120 drivers/tty/pty.c:215
       tty_driver_flush_buffer+0x61/0x80 drivers/tty/tty_ioctl.c:85
       tty_ldisc_hangup+0xde/0x6a0 drivers/tty/tty_ldisc.c:694
       __tty_hangup.part.0+0x426/0x8c0 drivers/tty/tty_io.c:630
       __tty_hangup drivers/tty/tty_io.c:697 [inline]
       tty_vhangup drivers/tty/tty_io.c:700 [inline]
       tty_vhangup drivers/tty/tty_io.c:697 [inline]
       tty_ioctl+0xf4e/0x1590 drivers/tty/tty_io.c:2743
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:904 [inline]
       __se_sys_ioctl fs/ioctl.c:890 [inline]
       __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &tty->read_wait --> &sighand->siglock --> &tty->ctrl.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tty->ctrl.lock);
                               lock(&sighand->siglock);
                               lock(&tty->ctrl.lock);
  lock(&tty->read_wait);

 *** DEADLOCK ***

3 locks held by syz-executor.4/26340:
 #0: ffff88807e9eb1c0 (&tty->legacy_mutex/1){+.+.}-{3:3}, at: __tty_hangup.part.0+0xbe/0x8c0 drivers/tty/tty_io.c:590
 #1: ffff88807e9eb0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref drivers/tty/tty_ldisc.c:263 [inline]
 #1: ffff88807e9eb0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_hangup+0x30/0x6a0 drivers/tty/tty_ldisc.c:690
 #2: ffff88807e9eb4c0 (&tty->ctrl.lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #2: ffff88807e9eb4c0 (&tty->ctrl.lock){....}-{2:2}, at: pty_flush_buffer+0xaf/0x120 drivers/tty/pty.c:213

stack backtrace:
CPU: 0 PID: 26340 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 __wake_up_common_lock kernel/sched/wait.c:105 [inline]
 __wake_up+0x1c/0x60 kernel/sched/wait.c:127
 pty_flush_buffer+0xf0/0x120 drivers/tty/pty.c:215
 tty_driver_flush_buffer+0x61/0x80 drivers/tty/tty_ioctl.c:85
 tty_ldisc_hangup+0xde/0x6a0 drivers/tty/tty_ldisc.c:694
 __tty_hangup.part.0+0x426/0x8c0 drivers/tty/tty_io.c:630
 __tty_hangup drivers/tty/tty_io.c:697 [inline]
 tty_vhangup drivers/tty/tty_io.c:700 [inline]
 tty_vhangup drivers/tty/tty_io.c:697 [inline]
 tty_ioctl+0xf4e/0x1590 drivers/tty/tty_io.c:2743
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5d1667dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5d173780c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5d167abf80 RCX: 00007f5d1667dea9
RDX: 0000000000000000 RSI: 0000000000005437 RDI: 0000000000000006
RBP: 00007f5d166ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5d167abf80 R15: 00007ffe8e31ef58
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

