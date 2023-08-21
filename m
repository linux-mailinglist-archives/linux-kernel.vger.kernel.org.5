Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109D9782E69
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjHUQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjHUQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:26:51 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D8EE4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:26:49 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-68a3cdf000cso2149564b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635209; x=1693240009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIFdnADsuVmDZrhClmaYqLWBg+suAptygUsK/Bos3yY=;
        b=lCKsqx6Gusj7mpz2L3Ohjbg1KK+zchxhZvG/L1TBN39/U3gYuCWHfKSejwWwc/MDWr
         kuXFDzGbbHzUP36RFCT4Vgc6SEdDfiNtkPbMtyjNDFbiLr70UPp9D/nriuscbu3+92dx
         yuTJoADh0qKLhaSOmRJnPEaGt1rkvBWtO8zPYAz+kx2AHqKfDYVMQufxZmgPaPWAOR7L
         sH0rUBqkFXMuNag78lWFMZ65sJS/V88jY/YpOhtEqAI0o4tyTyAvCcCpSRu4XPWROBU6
         MyP6be2Y/8Xq/IWBo3QY6+VBap+dncTppqzOZCVen/8NoEfb+8tLZl/QQMTxWTeU/N9j
         pQIA==
X-Gm-Message-State: AOJu0YxZIdHZjBo9Mhdq3iKjg7iZZw4vSezSbdDFVVP3LxzzD2uCMKoS
        u71UBabXzqJ+akhDV76wh1y6iueCn/+d1nhoocUMIdWhn0j2
X-Google-Smtp-Source: AGHT+IGiisCTx6f+95MPhyFdmGsAOGgbcEAM1DIg1f5NJFTmxLXeOry6VURDZiCe24OX5tdGz0+I3nLgqJzxiRVIGalJr2FOZ906
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:27ab:b0:68a:5e6f:9975 with SMTP id
 bd43-20020a056a0027ab00b0068a5e6f9975mr298332pfb.1.1692635208790; Mon, 21 Aug
 2023 09:26:48 -0700 (PDT)
Date:   Mon, 21 Aug 2023 09:26:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ab984060371583e@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7271b2a53042 Add linux-next specific files for 20230818
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13404b6ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13506923a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147569efa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81109bc02c1/disk-7271b2a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b3bf8e2a4f7/vmlinux-7271b2a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6404cd473c1e/bzImage-7271b2a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hci_send_acl+0xdf4/0xf30 net/bluetooth/hci_core.c:3228
Read of size 8 at addr ffff888025635618 by task kworker/1:1/27

CPU: 1 PID: 27 Comm: kworker/1:1 Not tainted 6.5.0-rc6-next-20230818-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events l2cap_info_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 hci_send_acl+0xdf4/0xf30 net/bluetooth/hci_core.c:3228
 l2cap_send_cmd+0x6dd/0x920 net/bluetooth/l2cap_core.c:977
 l2cap_send_conn_req+0x1e5/0x260 net/bluetooth/l2cap_core.c:1286
 l2cap_start_connection+0x11e/0x420 net/bluetooth/l2cap_core.c:1514
 l2cap_conn_start+0x7ae/0xa40 net/bluetooth/l2cap_core.c:1661
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5046:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 hci_chan_create+0xa6/0x3a0 net/bluetooth/hci_conn.c:2691
 l2cap_conn_add.part.0+0x1a/0xdf0 net/bluetooth/l2cap_core.c:7841
 l2cap_conn_add include/net/bluetooth/l2cap.h:866 [inline]
 l2cap_chan_connect+0x15b9/0x2140 net/bluetooth/l2cap_core.c:8053
 bt_6lowpan_connect net/bluetooth/6lowpan.c:894 [inline]
 lowpan_control_write+0x3d6/0x730 net/bluetooth/6lowpan.c:1129
 full_proxy_write+0x124/0x190 fs/debugfs/file.c:236
 vfs_write+0x2a4/0xe40 fs/read_write.c:582
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 50:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 hci_chan_list_flush+0x81/0xf0 net/bluetooth/hci_conn.c:2731
 hci_conn_cleanup net/bluetooth/hci_conn.c:152 [inline]
 hci_conn_del+0x1fc/0xd10 net/bluetooth/hci_conn.c:1140
 hci_abort_conn_sync+0xacb/0xe20 net/bluetooth/hci_sync.c:5432
 abort_conn_sync+0x18e/0x3a0 net/bluetooth/hci_conn.c:2878
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
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3373
 kernfs_unlink_open_file+0x3b6/0x4b0 fs/kernfs/file.c:633
 kernfs_fop_release+0xec/0x1e0 fs/kernfs/file.c:805
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3373
 kernfs_unlink_open_file+0x3b6/0x4b0 fs/kernfs/file.c:633
 kernfs_fop_release+0xec/0x1e0 fs/kernfs/file.c:805
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888025635600
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff888025635600, ffff888025635680)

The buggy address belongs to the physical page:
page:ffffea0000958d40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25635
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c418c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4500, tgid 4500 (udevd), ts 28013160887, free_ts 27864795775
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3219
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4475
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1095
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 kernfs_get_open_node fs/kernfs/file.c:572 [inline]
 kernfs_fop_open+0xad1/0xe00 fs/kernfs/file.c:740
 do_dentry_open+0x88b/0x1730 fs/open.c:929
 do_open fs/namei.c:3636 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3793
 do_filp_open+0x1de/0x430 fs/namei.c:3820
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2441
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3502
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x90/0xe0 fs/namei.c:219
 do_sys_openat2+0x100/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888025635500: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
 ffff888025635580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888025635600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888025635680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888025635700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
