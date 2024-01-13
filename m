Return-Path: <linux-kernel+bounces-25328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A1082CDA2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E8DB2274E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507563C2D;
	Sat, 13 Jan 2024 16:02:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85E23A3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf178281a5so201969739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 08:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705161747; x=1705766547;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9VVLnGQHUIscpCdeOc8L7XQiGdtbk8HeZDlragMj1Y=;
        b=d5VZ9KX4lS1aeYiiQmZraeakQh1gTjeRWK3GrCjGV7K+k0XQcWBTrS0gCslxOtHv3l
         BV1euUpGkYyR5w7+Y+OUpdu2rMGoLZHzhLKBfry4ttKfcvTGEsYWnzb0qE0h+XrE0w/Z
         SDgyW2BJiajgPhEZxT98cYdzhkUgrX1eS9p5RrQP/H3Qa7fwHOHw8YaF7XqSruIn7JMF
         W8be7jTbRqeV4tG9kk9nOp4OEMlHYwkxk70YyCIpnPhGmS83zLqSqI5MqTHUK1h/n9ET
         7EriPPh353c385m057DcT7JIpuPV7KR+jOP+XcNxSM94iprU0us+BlGWnoT5tcXnwWJ5
         npqA==
X-Gm-Message-State: AOJu0Ywb9schqBTcYdNENJLevCz0iGQRYhL3PuxQOTygDy7LUXnIjxbx
	KrvU0t2QWh5jAoPnRoAt1UFRL9t9B5BqhRlaeHJ2p9PNndqg
X-Google-Smtp-Source: AGHT+IGzsHKnjrtVXRlBYuRlrMSRE3QAgW2j/3gTUJN5bT+OigJdkT2Upc4x+ZLBA0kS8eYVjFSinIIUMHKaqShW7SK1qZjRFj4b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130a:b0:46e:50ab:6a51 with SMTP id
 r10-20020a056638130a00b0046e50ab6a51mr219138jad.2.1705161747411; Sat, 13 Jan
 2024 08:02:27 -0800 (PST)
Date: Sat, 13 Jan 2024 08:02:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d3747060ed5e859@google.com>
Subject: [syzbot] [block?] KMSAN: kernel-infoleak in filemap_read
From: syzbot <syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    861deac3b092 Linux 6.7-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14d12f76e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ef73d6e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d27f76e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/disk-861deac3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmlinux-861deac3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452/bzImage-861deac3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/52b4443ce279/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:29 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x364/0x2520 lib/iov_iter.c:186
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x364/0x2520 lib/iov_iter.c:186
 copy_page_to_iter+0x419/0x870 lib/iov_iter.c:381
 copy_folio_to_iter include/linux/uio.h:181 [inline]
 filemap_read+0xc00/0x14d0 mm/filemap.c:2644
 blkdev_read_iter+0x6c0/0x8e0 block/fops.c:742
 call_read_iter include/linux/fs.h:2014 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x8f6/0xe00 fs/read_write.c:470
 ksys_read+0x20f/0x4c0 fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __x64_sys_read+0x93/0xd0 fs/read_write.c:621
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 memcpy_to_iter lib/iov_iter.c:65 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0xe41/0x2520 lib/iov_iter.c:186
 copy_page_to_iter+0x419/0x870 lib/iov_iter.c:381
 shmem_file_read_iter+0xa0a/0x12b0 mm/shmem.c:2841
 do_iter_read+0xd21/0x1380 fs/read_write.c:795
 vfs_iter_read+0x8e/0xe0 fs/read_write.c:837
 lo_read_simple drivers/block/loop.c:290 [inline]
 do_req_filebacked drivers/block/loop.c:500 [inline]
 loop_handle_cmd drivers/block/loop.c:1915 [inline]
 loop_process_work+0x12e7/0x39d0 drivers/block/loop.c:1950
 loop_rootcg_workfn+0x2b/0x30 drivers/block/loop.c:1981
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was stored to memory at:
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:268 [inline]
 copy_page_from_iter_atomic+0x12f1/0x2b70 lib/iov_iter.c:500
 generic_perform_write+0x4ae/0xc40 mm/filemap.c:3926
 shmem_file_write_iter+0x2b5/0x2e0 mm/shmem.c:2895
 do_iter_write+0xceb/0x1340 fs/read_write.c:860
 vfs_iter_write+0x8e/0xe0 fs/read_write.c:901
 lo_write_bvec drivers/block/loop.c:249 [inline]
 lo_write_simple drivers/block/loop.c:271 [inline]
 do_req_filebacked drivers/block/loop.c:495 [inline]
 loop_handle_cmd drivers/block/loop.c:1915 [inline]
 loop_process_work+0x20c3/0x39d0 drivers/block/loop.c:1950
 loop_rootcg_workfn+0x2b/0x30 drivers/block/loop.c:1981
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
 kthread+0x3ed/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was stored to memory at:
 memcpy_to_page include/linux/highmem.h:427 [inline]
 hfsplus_bnode_write+0xee/0x2e0 fs/hfsplus/bnode.c:83
 hfsplus_brec_insert+0xa9d/0x1400 fs/hfsplus/brec.c:133
 hfsplus_create_cat+0x1309/0x1810 fs/hfsplus/catalog.c:308
 hfsplus_link+0x7d8/0xbf0 fs/hfsplus/dir.c:342
 vfs_link+0x936/0xb60 fs/namei.c:4588
 do_linkat+0x6e1/0x1160 fs/namei.c:4659
 __do_sys_link fs/namei.c:4693 [inline]
 __se_sys_link fs/namei.c:4691 [inline]
 __x64_sys_link+0xec/0x140 fs/namei.c:4691
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 hfsplus_cat_build_record fs/hfsplus/catalog.c:167 [inline]
 hfsplus_create_cat+0x11d1/0x1810 fs/hfsplus/catalog.c:300
 hfsplus_link+0x7d8/0xbf0 fs/hfsplus/dir.c:342
 vfs_link+0x936/0xb60 fs/namei.c:4588
 do_linkat+0x6e1/0x1160 fs/namei.c:4659
 __do_sys_link fs/namei.c:4693 [inline]
 __se_sys_link fs/namei.c:4691 [inline]
 __x64_sys_link+0xec/0x140 fs/namei.c:4691
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
 alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
 alloc_pages+0x1be/0x1e0 mm/mempolicy.c:2204
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x421/0x1570 mm/slub.c:2070
 ___slab_alloc+0x13db/0x33d0 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc_lru+0x552/0x970 mm/slub.c:3509
 alloc_inode_sb include/linux/fs.h:2937 [inline]
 hfsplus_alloc_inode+0x5a/0xc0 fs/hfsplus/super.c:627
 alloc_inode+0x83/0x440 fs/inode.c:261
 iget_locked+0x2dd/0xe80 fs/inode.c:1316
 hfsplus_iget+0x59/0xaf0 fs/hfsplus/super.c:64
 hfsplus_btree_open+0x13e/0x1d00 fs/hfsplus/btree.c:150
 hfsplus_fill_super+0x1113/0x26f0 fs/hfsplus/super.c:473
 mount_bdev+0x3d7/0x560 fs/super.c:1650
 hfsplus_mount+0x4d/0x60 fs/hfsplus/super.c:641
 legacy_get_tree+0x110/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa5/0x520 fs/super.c:1771
 do_new_mount+0x68d/0x1550 fs/namespace.c:3337
 path_mount+0x73d/0x1f20 fs/namespace.c:3664
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3863
 __x64_sys_mount+0xe4/0x140 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Bytes 3258-3261 of 4096 are uninitialized
Memory access of size 4096 starts at ffff8881146b8000
Data copied to user address 000055ff3929d058

CPU: 1 PID: 5003 Comm: udevd Not tainted 6.7.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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

