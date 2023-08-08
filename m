Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72D774F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjHHXiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHHXiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:38:24 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695F7DC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:38:23 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a5ad07254cso9617777b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 16:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691537902; x=1692142702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEJn6Pyjr7q36TqDIr0AkC8WD8+EGugxwkFsN3YngW4=;
        b=gjpC6Gzq+PIg9Btb4SRbN29OF60474X2Rga3HFEOvao8FxmM9j420n14dZ6yjL6k8F
         lZK+sBgeS8GD2QsNfFZcxtMjtRBQxbdzua/IcYOI/+cM281NSNsh0PzNyBam6doMmZgk
         lPM8JTG/fFYzJ5enOu6bkU0b2ZJP53aViRKMnPQd4pKlmZkU8R2vlSHlRu9mp73Nxd1c
         EQRyI4lUk8XRfp9OKFM7ZzJ9faq5XCEqW3YgU5oWWEUF4LUohQOAtVEZB7bgIIPWlkaL
         DqOcWjwVvnTTB6UwuX0ODIEg83ekck1zeJ7GEqWYvtywtm1Dv4tyj63BQl3+x8QnqZiR
         Rh6A==
X-Gm-Message-State: AOJu0Ywzff/xH64DCaAwO32+w3n8cKbazx+9+noURoINGrMEODEN6cx0
        U5BYdxriV9YP4w307K1CnIi59BsfUqyzmBCBLxBZF3Fbn3mL
X-Google-Smtp-Source: AGHT+IGvU2CUQkDT3s6yLU4tJr6xbIZbK0c8PtuhI2xZpWAwMaxJ8QGcYwNJJG4Cx3DpOjsIsNvGCR7/dFAj6tHIsiUQgUgisak3
MIME-Version: 1.0
X-Received: by 2002:a05:6808:180f:b0:3a6:feb1:bb83 with SMTP id
 bh15-20020a056808180f00b003a6feb1bb83mr679585oib.3.1691537902775; Tue, 08 Aug
 2023 16:38:22 -0700 (PDT)
Date:   Tue, 08 Aug 2023 16:38:22 -0700
In-Reply-To: <20230808232313.2035-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1c439060271db4a@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in btrfs_open_devices
From:   syzbot <syzbot+26860029a4d562566231@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in btrfs_mount_root

==================================================================
BUG: KASAN: use-after-free in btrfs_mount_root+0xf1b/0xf70 fs/btrfs/super.c:1539
Read of size 8 at addr ffff8880636d1110 by task syz-executor.2/5580

CPU: 1 PID: 5580 Comm: syz-executor.2 Not tainted 6.5.0-rc5-next-20230807-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 btrfs_mount_root+0xf1b/0xf70 fs/btrfs/super.c:1539
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129
 btrfs_mount+0x292/0xb10 fs/btrfs/super.c:1586
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
RIP: 0033:0x7fa214e7e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa215c9aee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fa215c9af80 RCX: 00007fa214e7e1ea
RDX: 00000000200051c0 RSI: 0000000020005200 RDI: 00007fa215c9af40
RBP: 00000000200051c0 R08: 00007fa215c9af80 R09: 0000000001000008
R10: 0000000001000008 R11: 0000000000000246 R12: 0000000020005200
R13: 00007fa215c9af40 R14: 00000000000051ab R15: 0000000020000280
 </TASK>

The buggy address belongs to the physical page:
page:ffffea00018db440 refcount:0 mapcount:0 mapping:0000000000000000 index:0x4 pfn:0x636d1
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 0000000000000000 ffffffff00000201 0000000000000000
raw: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x102000(__GFP_NOWARN|__GFP_HARDWALL), pid 5580, tgid 5579 (syz-executor.2), ts 76159898184, free_ts 76159901250
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1567
 prep_new_page mm/page_alloc.c:1574 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3253
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4509
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 __stack_depot_save+0x3c2/0x510 lib/stackdepot.c:410
 kasan_save_stack+0x43/0x50 mm/kasan/common.c:46
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 list_lru_destroy mm/list_lru.c:598 [inline]
 list_lru_destroy+0x153/0x700 mm/list_lru.c:589
 deactivate_locked_super+0xb2/0x170 fs/super.c:338
 btrfs_mount_root+0x625/0xf70 fs/btrfs/super.c:1534
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1158 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2380
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2475
 __stack_depot_save+0x193/0x510 lib/stackdepot.c:443
 kasan_save_stack+0x43/0x50 mm/kasan/common.c:46
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 list_lru_destroy mm/list_lru.c:598 [inline]
 list_lru_destroy+0x153/0x700 mm/list_lru.c:589
 deactivate_locked_super+0xb2/0x170 fs/super.c:338
 btrfs_mount_root+0x625/0xf70 fs/btrfs/super.c:1534
 legacy_get_tree+0x109/0x220 fs/fs_context.c:611
 vfs_get_tree+0x88/0x350 fs/super.c:1544
 fc_mount fs/namespace.c:1112 [inline]
 vfs_kern_mount.part.0+0xcb/0x170 fs/namespace.c:1142
 vfs_kern_mount+0x3f/0x60 fs/namespace.c:1129

Memory state around the buggy address:
 ffff8880636d1000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880636d1080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880636d1100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff8880636d1180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880636d1200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         f7dc24b3 Add linux-next specific files for 20230807
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=121811fda80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7847c9dca13d6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=26860029a4d562566231
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163b52eda80000

