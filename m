Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45877EEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347595AbjHQB4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347503AbjHQB4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:56:05 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39C270A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:56:03 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-26b139f4e2aso10179444a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692237363; x=1692842163;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8V9XkajV6ljTOCotpnGckWIdYBATaJK32ONI2Pb2tw=;
        b=ULGEiF1zSdST9ncNFOgYVc1xWEdbywlGiDWb0x6i+iAphJ6ssJvMyqit8HqJQadxww
         sE0ZsSGQLIqoV3k9A+AZNSV7yVLfKajqeYl3sCNb4GgC/hD+y6dhDZ3JKyymE/8w3b56
         1mZiD0BWsddGZIpku9dCgUMJFdcrUHqJTDSfx5IQFA3tKBUgX2dUUpuogrD4vFq4pgSt
         iEnXVKzX7gQMzVinKXY+6IugIjO7Q9LrE+lsHbVmtn4QRn8NMj5pLTIOx94B8MceqXIi
         u4I2QEcrL07/Jyf6nk3KcZHtWsDDwB+3+PADS9dQr6xEODWdUsFx86OdJAnzFl40vAxB
         iMaA==
X-Gm-Message-State: AOJu0Yy9EdK7rIVQwpkPxPUKrZWKI5PnBCAFaLsLlhDeO+Dim7wVcM1l
        e66Fl45g83sJicXpzKVbtKz3g36h/EheASqtePoVB+qSkCZn
X-Google-Smtp-Source: AGHT+IGfthxfMAsX8gV+ClK1SZfMjDY5oWvLu/89fUxbqw4q8mvBhOalJAe1Nj9qjAZ6+UWQGok0eU6K9yyH5RIVpV/0csjR42hF
MIME-Version: 1.0
X-Received: by 2002:a17:903:1c3:b0:1b3:e4f1:1b3f with SMTP id
 e3-20020a17090301c300b001b3e4f11b3fmr1629629plh.2.1692237362831; Wed, 16 Aug
 2023 18:56:02 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:56:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e32603060314b623@google.com>
Subject: [syzbot] [block?] memory leak in iov_iter_extract_pages
From:   syzbot <syzbot+cb729843d0f42a5c1a50@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    ae545c3283dc Merge tag 'gpio-fixes-for-v6.5-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d1456fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bf8962e4f7984f4
dashboard link: https://syzkaller.appspot.com/bug?extid=cb729843d0f42a5c1a50
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143edef7a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e93037a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab6a1e819c1f/disk-ae545c32.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/55f3314970f5/vmlinux-ae545c32.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a27c3b2a812/bzImage-ae545c32.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb729843d0f42a5c1a50@syzkaller.appspotmail.com

Warning: Permanently added '10.128.1.14' (ED25519) to the list of known hosts.
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888109d2e400 (size 1024):
  comm "syz-executor121", pid 5006, jiffies 4294943225 (age 17.760s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554bbb>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554bbb>] __kmalloc_node+0x4b/0x150 mm/slab_common.c:992
    [<ffffffff815440f9>] kmalloc_node include/linux/slab.h:602 [inline]
    [<ffffffff815440f9>] kvmalloc_node+0x99/0x170 mm/util.c:604
    [<ffffffff824c52fe>] kvmalloc include/linux/slab.h:720 [inline]
    [<ffffffff824c52fe>] kvmalloc_array include/linux/slab.h:738 [inline]
    [<ffffffff824c52fe>] want_pages_array lib/iov_iter.c:985 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_user_pages lib/iov_iter.c:1765 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_pages+0x1ee/0xa40 lib/iov_iter.c:1831
    [<ffffffff824125a7>] bio_map_user_iov+0x167/0x5d0 block/blk-map.c:297
    [<ffffffff82412df3>] blk_rq_map_user_iov+0x3e3/0xb30 block/blk-map.c:664
    [<ffffffff82413943>] blk_rq_map_user block/blk-map.c:691 [inline]
    [<ffffffff82413943>] blk_rq_map_user_io+0x143/0x160 block/blk-map.c:724
    [<ffffffff82ca0925>] sg_io+0x285/0x510 drivers/scsi/scsi_ioctl.c:456
    [<ffffffff82ca1025>] scsi_cdrom_send_packet+0x1b5/0x480 drivers/scsi/scsi_ioctl.c:820
    [<ffffffff82ca13ba>] scsi_ioctl+0xca/0xd30 drivers/scsi/scsi_ioctl.c:903
    [<ffffffff82d35964>] sg_ioctl+0x5f4/0x10a0 drivers/scsi/sg.c:1163
    [<ffffffff8168e602>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff8168e602>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff8168e602>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff8168e602>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:856
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109d2dc00 (size 1024):
  comm "syz-executor121", pid 5007, jiffies 4294943747 (age 12.540s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554bbb>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554bbb>] __kmalloc_node+0x4b/0x150 mm/slab_common.c:992
    [<ffffffff815440f9>] kmalloc_node include/linux/slab.h:602 [inline]
    [<ffffffff815440f9>] kvmalloc_node+0x99/0x170 mm/util.c:604
    [<ffffffff824c52fe>] kvmalloc include/linux/slab.h:720 [inline]
    [<ffffffff824c52fe>] kvmalloc_array include/linux/slab.h:738 [inline]
    [<ffffffff824c52fe>] want_pages_array lib/iov_iter.c:985 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_user_pages lib/iov_iter.c:1765 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_pages+0x1ee/0xa40 lib/iov_iter.c:1831
    [<ffffffff824125a7>] bio_map_user_iov+0x167/0x5d0 block/blk-map.c:297
    [<ffffffff82412df3>] blk_rq_map_user_iov+0x3e3/0xb30 block/blk-map.c:664
    [<ffffffff82413943>] blk_rq_map_user block/blk-map.c:691 [inline]
    [<ffffffff82413943>] blk_rq_map_user_io+0x143/0x160 block/blk-map.c:724
    [<ffffffff82ca0925>] sg_io+0x285/0x510 drivers/scsi/scsi_ioctl.c:456
    [<ffffffff82ca1025>] scsi_cdrom_send_packet+0x1b5/0x480 drivers/scsi/scsi_ioctl.c:820
    [<ffffffff82ca13ba>] scsi_ioctl+0xca/0xd30 drivers/scsi/scsi_ioctl.c:903
    [<ffffffff82d35964>] sg_ioctl+0x5f4/0x10a0 drivers/scsi/sg.c:1163
    [<ffffffff8168e602>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff8168e602>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff8168e602>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff8168e602>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:856
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109d2d800 (size 1024):
  comm "syz-executor121", pid 5010, jiffies 4294944269 (age 7.320s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81554bbb>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff81554bbb>] __kmalloc_node+0x4b/0x150 mm/slab_common.c:992
    [<ffffffff815440f9>] kmalloc_node include/linux/slab.h:602 [inline]
    [<ffffffff815440f9>] kvmalloc_node+0x99/0x170 mm/util.c:604
    [<ffffffff824c52fe>] kvmalloc include/linux/slab.h:720 [inline]
    [<ffffffff824c52fe>] kvmalloc_array include/linux/slab.h:738 [inline]
    [<ffffffff824c52fe>] want_pages_array lib/iov_iter.c:985 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_user_pages lib/iov_iter.c:1765 [inline]
    [<ffffffff824c52fe>] iov_iter_extract_pages+0x1ee/0xa40 lib/iov_iter.c:1831
    [<ffffffff824125a7>] bio_map_user_iov+0x167/0x5d0 block/blk-map.c:297
    [<ffffffff82412df3>] blk_rq_map_user_iov+0x3e3/0xb30 block/blk-map.c:664
    [<ffffffff82413943>] blk_rq_map_user block/blk-map.c:691 [inline]
    [<ffffffff82413943>] blk_rq_map_user_io+0x143/0x160 block/blk-map.c:724
    [<ffffffff82ca0925>] sg_io+0x285/0x510 drivers/scsi/scsi_ioctl.c:456
    [<ffffffff82ca1025>] scsi_cdrom_send_packet+0x1b5/0x480 drivers/scsi/scsi_ioctl.c:820
    [<ffffffff82ca13ba>] scsi_ioctl+0xca/0xd30 drivers/scsi/scsi_ioctl.c:903
    [<ffffffff82d35964>] sg_ioctl+0x5f4/0x10a0 drivers/scsi/sg.c:1163
    [<ffffffff8168e602>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff8168e602>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff8168e602>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff8168e602>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:856
    [<ffffffff84ad2bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad2bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



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
