Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF0777F6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbjHQM5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351010AbjHQM46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:56:58 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC592D78
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:56:54 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1bb893e61d5so100396535ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692277014; x=1692881814;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqgK71bW3lu4NgQvdkM+4FZjdKgV8/F7Y8h3YEMGuiY=;
        b=JjUH6IgoGqkISUjwBZItnItkZYp+pEJkjtPaUYIj6aYwxaThfXTx9eIa8VABDnnD6s
         8LbXNilowRAEQMHgapXZGqpbxWRH8F0vjwnAXlMh/igrs3QL9yxj/AbanRtzCLOqZcWI
         Dmz5aSgD30EDaPkUtRKickRJ6K06/pGYkBVIvnHplji9kKZcnQ7sq1Wv+ceNim8BvYAb
         uhGX15gVgRb5YNuPPbTg4s8GLVoWKFDV4VCyc5AiNNYoP02wW/Gkc9UrM1KQnI9lezRJ
         h/QT2Zs1qf42EmTUwTuSjWAlSIsx5qdncGi+RHDi7O53iFyYmjxmV6UQ31KqztHwk44u
         zJ8Q==
X-Gm-Message-State: AOJu0Ywt3+A19WBuFu2GKj47tqTwN+RlhcMG7o+iJiBRjF25BVrVFIy1
        +5iMnt6J/LI/dEUp2/Rc9MGXOE9iaOdtcVmV96UmXEQIXlx7
X-Google-Smtp-Source: AGHT+IEume8RxbSuUxyOIsVAF/VQk762rGQdR911ce5w0JKTFxyAAC6KhtqrbUF2Rf7uBGqb9fYBSDzESjgq7LmgKFQrQysZ+7B/
MIME-Version: 1.0
X-Received: by 2002:a17:902:d484:b0:1bf:cc5:7b55 with SMTP id
 c4-20020a170902d48400b001bf0cc57b55mr1030401plg.0.1692277013892; Thu, 17 Aug
 2023 05:56:53 -0700 (PDT)
Date:   Thu, 17 Aug 2023 05:56:53 -0700
In-Reply-To: <00000000000013b93805fbbadc50@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046530206031df2e4@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_chan_del
From:   syzbot <syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, lrh2000@pku.edu.cn,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    47762f086974 Add linux-next specific files for 20230817
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17899507a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed03cf326b3ef94c
dashboard link: https://syzkaller.appspot.com/bug?extid=cf54c1da6574b6c1b049
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1125bc65a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ce8f03a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c6f2ea3b7d7d/disk-47762f08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf652ce6b802/vmlinux-47762f08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f329a7749b6/bzImage-47762f08.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/hci_core.h:1497 [inline]
BUG: KASAN: slab-use-after-free in sco_chan_del+0x102/0x4f0 net/bluetooth/sco.c:171
Write of size 4 at addr ffff88807cee0010 by task syz-executor360/8962

CPU: 1 PID: 8962 Comm: syz-executor360 Not tainted 6.5.0-rc6-next-20230817-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1497 [inline]
 sco_chan_del+0x102/0x4f0 net/bluetooth/sco.c:171
 __sco_sock_close+0xf2/0x690 net/bluetooth/sco.c:454
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0x6f/0x2c0 net/bluetooth/sco.c:1246
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1401
 __fput+0x3f7/0xac0 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa99/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23d1/0x27b0 kernel/signal.c:2892
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff68c148bb9
Code: Unable to access opcode bytes at 0x7ff68c148b8f.
RSP: 002b:00007ffe45e76968 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 0000000000000003 RCX: 00007ff68c148bb9
RDX: 0000000000000008 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 0000000000000003 R08: 00007ffe45e769a0 R09: 00007ffe45e769a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000555556df1370
R13: 0000000000000016 R14: 0000000000000251 R15: 431bde82d7b634db
 </TASK>

Allocated by task 8762:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 hci_conn_add+0xc2/0x1770 net/bluetooth/hci_conn.c:952
 hci_connect_sco+0x3ac/0xf80 net/bluetooth/hci_conn.c:1671
 sco_connect net/bluetooth/sco.c:266 [inline]
 sco_sock_connect+0x2c7/0xa50 net/bluetooth/sco.c:591
 __sys_connect_file+0x15b/0x1a0 net/socket.c:2032
 __sys_connect+0x145/0x170 net/socket.c:2049
 __do_sys_connect net/socket.c:2059 [inline]
 __se_sys_connect net/socket.c:2056 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5061:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 device_release+0xa1/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x5b0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3731
 hci_conn_unlink+0x60a/0x840 net/bluetooth/hci_conn.c:1071
 hci_conn_del+0x59/0xd10 net/bluetooth/hci_conn.c:1097
 hci_abort_conn_sync+0x7fc/0xb70 net/bluetooth/hci_sync.c:5417
 abort_conn_sync+0x18e/0x3a0 net/bluetooth/hci_conn.c:2869
 hci_cmd_sync_work+0x1a4/0x3c0 net/bluetooth/hci_sync.c:306
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 insert_work+0x38/0x230 kernel/workqueue.c:1647
 __queue_work+0x5d2/0x1060 kernel/workqueue.c:1799
 __queue_delayed_work+0x1bf/0x260 kernel/workqueue.c:1950
 queue_delayed_work_on+0x106/0x130 kernel/workqueue.c:1986
 queue_delayed_work include/linux/workqueue.h:569 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1523 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1493 [inline]
 sco_chan_del+0x1f8/0x4f0 net/bluetooth/sco.c:171
 __sco_sock_close+0xf2/0x690 net/bluetooth/sco.c:454
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0x6f/0x2c0 net/bluetooth/sco.c:1246
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1401
 __fput+0x3f7/0xac0 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa99/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23d1/0x27b0 kernel/signal.c:2892
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807cee0000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff88807cee0000, ffff88807cee1000)

The buggy address belongs to the physical page:
page:ffffea0001f3b800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7cee0
head:ffffea0001f3b800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012c42140 ffffea00009e7000 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5046, tgid 5046 (syz-executor360), ts 144073960140, free_ts 83497589835
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1550
 prep_new_page mm/page_alloc.c:1557 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3233
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4489
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1003 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1017
 kmalloc include/linux/slab.h:604 [inline]
 tomoyo_realpath_from_path+0xb9/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x271/0x450 security/tomoyo/file.c:822
 security_inode_getattr+0xf1/0x150 security/security.c:2153
 vfs_getattr fs/stat.c:206 [inline]
 vfs_statx+0x180/0x430 fs/stat.c:281
 vfs_fstatat+0x90/0xb0 fs/stat.c:315
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:485
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1150 [inline]
 free_unref_page_prepare+0x479/0xa50 mm/page_alloc.c:2362
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2455
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x185/0x3f0 mm/slub.c:3523
 __alloc_skb+0x287/0x330 net/core/skbuff.c:634
 alloc_skb_fclone include/linux/skbuff.h:1336 [inline]
 tcp_stream_alloc_skb+0x34/0x560 net/ipv4/tcp.c:869
 tcp_sendmsg_locked+0xea5/0x3430 net/ipv4/tcp.c:1150
 tcp_sendmsg+0x2e/0x40 net/ipv4/tcp.c:1336
 inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:840
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 sock_write_iter+0x29b/0x3d0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1983 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x1f0/0x250 fs/read_write.c:637

Memory state around the buggy address:
 ffff88807cedff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807cedff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807cee0000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88807cee0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807cee0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
