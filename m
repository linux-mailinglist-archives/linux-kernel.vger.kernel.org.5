Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8797893D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjHZE3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjHZE3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:29:30 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564FD2125
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:29:27 -0700 (PDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-564fa3b49e1so1480116a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693024167; x=1693628967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzLKIj7738CHBK5hqDFLq6dRuWSOn+KOL0WTI7lNSpA=;
        b=XZ7gbgK5meU+xQgVaFRzsM8S+2KU6OMtgJwgtvyxmDygBkl0vCj3oCoLdQRgcELB+g
         SUDCELcznTAUGAvHY2Ah5hF36fS3qZuloTFw5/mmTMhbwJZ3F/AmNgC2SPpdaxgOqGl+
         xWCiZ1+mwHXX3kaNficuMJEHXVmF7z8xDRU0anKqT7JJwLnF4jU9PeS2Z4IpVTStNDm7
         DL6S3AcaewR4LhSnE+lMiZefeRRIsMDDztGUV0PBbfR+R9DdJisDKnTDk1WnFECu/Lgs
         Kyllg32AittWJgvHz9Y9CtTGcZQStPjzRs7ngHMhMn6+Z5jbLBeXQgd5G7K0paaZhUBx
         Szgw==
X-Gm-Message-State: AOJu0Yz/yJFNzo5QvsyrTKX7/Cup5s8row1CEttPeChS0+mD0Uj/BkWY
        Cw/YTYpZ20Kiz6Lr82yKzXvpY99dbLlE3l/O3691XzI2y3Eg
X-Google-Smtp-Source: AGHT+IGyc1C2i00cXzEc4J+s9hP8upxYmjilm3rP5HDC9USp91NQ4PtUYkQFqCLJTZ7KYi8f8IqqSiwzgBGqVeuzNmGEejBSLBBQ
MIME-Version: 1.0
X-Received: by 2002:a63:935b:0:b0:569:425b:7ec7 with SMTP id
 w27-20020a63935b000000b00569425b7ec7mr3336969pgm.2.1693024166925; Fri, 25 Aug
 2023 21:29:26 -0700 (PDT)
Date:   Fri, 25 Aug 2023 21:29:26 -0700
In-Reply-To: <20230826035531.3320-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010dead0603cbe8f4@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
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
KASAN: use-after-free Read in hci_get_route

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: use-after-free in hci_get_route+0x1cc/0x510 net/bluetooth/hci_conn.c:1156
Read of size 8 at addr ffff888068d1c0a8 by task syz-executor.0/5857

CPU: 0 PID: 5857 Comm: syz-executor.0 Not tainted 6.5.0-rc6-next-20230818-syzkaller-dirty #0
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
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hci_get_route+0x1cc/0x510 net/bluetooth/hci_conn.c:1156
 get_l2cap_conn.constprop.0+0xe9/0x6b0 net/bluetooth/6lowpan.c:968
 lowpan_control_write+0x1ba/0x730 net/bluetooth/6lowpan.c:1100
 full_proxy_write+0x124/0x190 fs/debugfs/file.c:236
 vfs_write+0x2a4/0xe40 fs/read_write.c:582
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f728f47cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f72900ee0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f728f59bf80 RCX: 00007f728f47cae9
RDX: 000000000000001b RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007f728f4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f728f59bf80 R15: 00007ffd19482978
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001a34700 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x68d1c
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea00008a6e08 ffff8880b9842670 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x140dc0(GFP_USER|__GFP_COMP|__GFP_ZERO), pid 5393, tgid 5393 (syz-executor.0), ts 86181654329, free_ts 106465252737
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3219
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4475
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x87/0x1c0 mm/slab_common.c:1145
 __do_kmalloc_node mm/slab_common.c:992 [inline]
 __kmalloc.cold+0xb/0xe0 mm/slab_common.c:1017
 kmalloc include/linux/slab.h:604 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 hci_alloc_dev_priv+0x1d/0x2770 net/bluetooth/hci_core.c:2467
 hci_alloc_dev include/net/bluetooth/hci_core.h:1598 [inline]
 __vhci_create_device+0xf7/0x800 drivers/bluetooth/hci_vhci.c:402
 vhci_create_device drivers/bluetooth/hci_vhci.c:475 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:532 [inline]
 vhci_write+0x2c7/0x470 drivers/bluetooth/hci_vhci.c:612
 call_write_iter include/linux/fs.h:1983 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2441
 bt_host_release+0x87/0xb0 net/bluetooth/hci_sysfs.c:95
 device_release+0xa1/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x5b0 lib/kobject.c:737
 put_device+0x1f/0x30 drivers/base/core.c:3731
 hci_dev_put include/net/bluetooth/hci_core.h:1558 [inline]
 hci_conn_timeout+0x215/0x2d0 net/bluetooth/hci_conn.c:633
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888068d1bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888068d1c000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888068d1c080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                  ^
 ffff888068d1c100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888068d1c180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         7271b2a5 Add linux-next specific files for 20230818
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11425db7a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170c63a7a80000

