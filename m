Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F377766E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjHJLFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHJLFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:05:38 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035602106
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:05:38 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-53ff4f39c0fso1036356a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691665537; x=1692270337;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nFfUFGdhoT+Yfqih2F0c/V+K5aje8ZqS4XkIxDYyk8=;
        b=KEOww9sl5CVkK7bTXMsUOingairtW48ItyecuwfzjW0crQZz3w3Kq47N6kKOw4osQg
         WSm1SvKvbdc+37Z8GGolMolz/kJkG9pdVrQCK1fXA0yZ04df4xiZ4apW0wHDSZJ4j8Yu
         zXKX2aTecbkr6Z4A3tGn1aUBuVBx5Lpy87XjjvDG3AdcPz49/VQ56e0ntrETSI+pKSWt
         jK2IKdbA2BJe8V4lmSjcIpZHsqWrTmGGHeGw2wjCuk1iRlvkT1CvsOJ+ghfrO35RHQiW
         SmUI8c7BCwdEW6aTomg0vZjGjeouEtnf6J1p8I5a9Ym+Nq5ECr1PTE8UP4ojiXqFySkn
         FWYg==
X-Gm-Message-State: AOJu0Yyy96QCVbbwusGIp96LTsVdXWKMBAEn/Ii/qju4O1F0m8ugTS38
        40qABJVyUTdz2wIec6elHnB3pLI9TBQaktCqMo6hNUU3PPWo
X-Google-Smtp-Source: AGHT+IF2eIeM7arlD1IgtTciFtvmwCHTamIV6p6YJK94mGBgHBxLNM9srJ2iTGyv0+0ZLS/Ck4JSFDJQoEKKOR7fh+ygn2q1Z/z+
MIME-Version: 1.0
X-Received: by 2002:a63:3852:0:b0:564:aeb6:c371 with SMTP id
 h18-20020a633852000000b00564aeb6c371mr435687pgn.3.1691665537442; Thu, 10 Aug
 2023 04:05:37 -0700 (PDT)
Date:   Thu, 10 Aug 2023 04:05:37 -0700
In-Reply-To: <20230810104550.2217-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000702e7506028f9395@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_open_devices
From:   syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in percpu_counter_destroy

BTRFS error (device loop3): open_ctree failed
==================================================================
BUG: KASAN: use-after-free in percpu_counter_destroy+0x47/0x50 lib/percpu_counter.c:182
Read of size 8 at addr ffff88807307d030 by task syz-executor.3/5615

CPU: 0 PID: 5615 Comm: syz-executor.3 Not tainted 6.5.0-rc5-next-20230807-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 percpu_counter_destroy+0x47/0x50 lib/percpu_counter.c:182
 btrfs_free_fs_info+0x1c/0x380 fs/btrfs/disk-io.c:1246
 btrfs_mount_root+0x3ea/0xe60 fs/btrfs/super.c:1544
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1587
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8b6847e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8b691f0ee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8b691f0f80 RCX: 00007f8b6847e1ea
RDX: 00000000200051c0 RSI: 0000000020005200 RDI: 00007f8b691f0f40
RBP: 00000000200051c0 R08: 00007f8b691f0f80 R09: 0000000001000008
R10: 0000000001000008 R11: 0000000000000246 R12: 0000000020005200
R13: 00007f8b691f0f40 R14: 00000000000051ab R15: 0000000020000280
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001cc1f40 refcount:0 mapcount:0 mapping:0000000000000000 index:0x4 pfn:0x7307d
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 ffffffff00000201 0000000000000000
raw: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x152dc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_ZERO), pid 5615, tgid 5614 (syz-executor.3), ts 74051625164, free_ts 74183131126
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1567
 prep_new_page mm/page_alloc.c:1574 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3253
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4509
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x87/0x1c0 mm/slab_common.c:1164
 __do_kmalloc_node mm/slab_common.c:1011 [inline]
 __kmalloc_node.cold+0x5/0xdd mm/slab_common.c:1030
 kmalloc_node include/linux/slab.h:619 [inline]
 kvmalloc_node+0x6f/0x1a0 mm/util.c:604
 kvmalloc include/linux/slab.h:737 [inline]
 kvzalloc include/linux/slab.h:745 [inline]
 btrfs_mount_root+0xf4/0xe60 fs/btrfs/super.c:1462
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1587
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1158 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2380
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2475
 kvfree+0x47/0x50 mm/util.c:650
 deactivate_locked_super+0x9a/0x170 fs/super.c:330
 btrfs_mount_root+0x62d/0xe60 fs/btrfs/super.c:1533
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1587
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807307cf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807307cf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88807307d000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                     ^
 ffff88807307d080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807307d100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         f7dc24b3 Add linux-next specific files for 20230807
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10e4c645a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c512b3a80000

