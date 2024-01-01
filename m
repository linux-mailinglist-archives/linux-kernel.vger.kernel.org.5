Return-Path: <linux-kernel+bounces-13870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B5E8213D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150D9281D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482935664;
	Mon,  1 Jan 2024 13:38:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE133C32
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35ff5a2f9c0so79248925ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 05:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704116304; x=1704721104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z5YDMiJSlsHOP12PCKlsRYjuR3Y0/7OZtq/1K6RFk70=;
        b=DWxPQqV+2zyWYa8qMdNOOMdyC4uOthXDAwAtwjDDBzocF4LGTTBG96hN5/5Is9Q8E3
         TO41sih9H+zmaKOkjXneDMhWa60Hf3qV2mwG4mDX2HVMO8SqI7KawnzuvhFusPNC6zHX
         1NtM+kf7jDvH40oGs8XEjvwjY+U7eIf9JkZ8G+WVIksaMvpkiu4bfAzRjJnQJlT9L8VW
         cZ9zhGdqHfZQqFhIutf79tjMNGKl82FoiBNXAu0pKjd60awDfUXW0/Ip5C4B/WKRZwkh
         BSeZjAShvgMCztAENg3olrfy6ANe7jlluYLchyHnPUsIjj0Ht1Ox9Tn/v0pGV/Rd45NM
         TohQ==
X-Gm-Message-State: AOJu0Yy9faAIQ2EiWfHXmEYVBC4NmtfihCqS2zDwRbSenKGD5uJQk928
	NU7WWYVJIrCHAM1D/L7BZdNxoy4DNQeEBbZ45x+3ugE9ii2q
X-Google-Smtp-Source: AGHT+IEXSvlSbRC6oNtINCqL3gA2YPz1FBSJoXBpGKJLrPe6jk9+j32YcD/6x9Wy4ktUOnQMQUPaQscdjjGJQ3TXjbsEoBqDwu9H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:360:f2c:cde6 with SMTP id
 k13-20020a056e021a8d00b003600f2ccde6mr1708877ilv.6.1704116304564; Mon, 01 Jan
 2024 05:38:24 -0800 (PST)
Date: Mon, 01 Jan 2024 05:38:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd588e060de27ef4@google.com>
Subject: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=173df3e9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1300b4a1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130b0379e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
BUG: KMSAN: uninit-value in virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
BUG: KMSAN: uninit-value in virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
 vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
 virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
 virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
 virtqueue_add_sgs+0x186/0x1a0 drivers/virtio/virtio_ring.c:2244
 __virtscsi_add_cmd drivers/scsi/virtio_scsi.c:467 [inline]
 virtscsi_add_cmd+0x838/0xad0 drivers/scsi/virtio_scsi.c:501
 virtscsi_queuecommand+0x896/0xa60 drivers/scsi/virtio_scsi.c:598
 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1516 [inline]
 scsi_queue_rq+0x4874/0x5790 drivers/scsi/scsi_lib.c:1758
 blk_mq_dispatch_rq_list+0x13f8/0x3600 block/blk-mq.c:2049
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
 __blk_mq_sched_dispatch_requests+0x10af/0x2500 block/blk-mq-sched.c:309
 blk_mq_sched_dispatch_requests+0x160/0x2d0 block/blk-mq-sched.c:333
 blk_mq_run_work_fn+0xd0/0x280 block/blk-mq.c:2434
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages mm/mempolicy.c:2204 [inline]
 folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
 filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
 __filemap_get_folio+0xa5a/0x1760 mm/filemap.c:1918
 ext4_da_write_begin+0x7f8/0xec0 fs/ext4/inode.c:2891
 generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
 ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
 ext4_file_write_iter+0x20f/0x3460
 __kernel_write_iter+0x329/0x930 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x593/0xcd0 fs/coredump.c:915
 elf_core_dump+0x528d/0x5a40 fs/binfmt_elf.c:2077
 do_coredump+0x32c9/0x4920 fs/coredump.c:764
 get_signal+0x2185/0x2d10 kernel/signal.c:2890
 arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0xd/0x30 kernel/entry/common.c:309
 irqentry_exit+0x16/0x40 kernel/entry/common.c:412
 exc_page_fault+0x246/0x6f0 arch/x86/mm/fault.c:1564
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:570

Bytes 0-4095 of 4096 are uninitialized
Memory access of size 4096 starts at ffff88812c79c000

CPU: 0 PID: 997 Comm: kworker/0:1H Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: kblockd blk_mq_run_work_fn
=====================================================


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

