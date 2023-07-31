Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC77768F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjGaH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjGaH6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:58:01 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFB91A5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:57:59 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1a9e48f8e71so9654307fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 00:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790278; x=1691395078;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iPXHzk/BZ/Q4PQzBz4wJPb3Eoe2+5Gm/gYE7LjWFAwQ=;
        b=CZ+vpsr4IW4eNJdyTd9povukTON4KXkzTnvSyi4MEOSanCNa4FMjSvhqMl/lo+p1jA
         l8TuULm61haLF16m4Ome3cMTuhh4Z3tOCpp823IxOtUdS2v5UxK8jliVnHVd6FafWnmA
         0BYCRbOijRwsCCHILOPESoczYMwD1SS+Pta7nmljpClvPlz92iOKn/QIUMv5f47Z7Vk0
         Hx5rZ1QwjZtmRXDes/JmdICLbOxKVNuKL4ysnKYEJsC0Rmfuv6d8Dfq6s50V+B/BtA1S
         DJ5r6g6KgQnuwgGHnQFeEYug6njenUxRmgrho3rIGyjiipcnK0nD7xoJg4MEklF5FHiM
         oRqg==
X-Gm-Message-State: ABy/qLavwM2xzxJIOTT5zML/b0LLu08ecmosVpASOwW9z5S5lxhIaTMQ
        blQTuT7T7LHpeMy0pgGvtbR/kr9uZN9ygXjqmKdRYES0pUUm
X-Google-Smtp-Source: APBJJlE72MwYWSbzqqQTBsauH9F3ycZfcx7u7sahtIOvp55hjEgxEiPtapmcPi+7a6rDuNw+iY16OH9GPLA3RRteHW4BgUOGnJ1+
MIME-Version: 1.0
X-Received: by 2002:a05:6870:956f:b0:1bb:6993:1fb5 with SMTP id
 v47-20020a056870956f00b001bb69931fb5mr12182255oal.0.1690790278739; Mon, 31
 Jul 2023 00:57:58 -0700 (PDT)
Date:   Mon, 31 Jul 2023 00:57:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f43cab0601c3c902@google.com>
Subject: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
From:   syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>
To:     brauner@kernel.org, chao@kernel.org, hch@lst.de,
        huyue2@coolpad.com, jack@suse.cz, jefflexu@linux.alibaba.com,
        linkinjeon@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
        xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13018b26a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
dashboard link: https://syzkaller.appspot.com/bug?extid=69c477e882e44ce41ad9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b490c5a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139a9c7ea80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5efa5e68267f/disk-d7b3af5a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1f5d3e10263/vmlinux-d7b3af5a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57cab469d186/bzImage-d7b3af5a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2cf2189f623b/mount_0.gz

The issue was bisected to:

commit 1dbd9ceb390c4c61d28cf2c9251dd2015946ce51
Author: Jan Kara <jack@suse.cz>
Date:   Mon Jul 24 17:51:45 2023 +0000

    fs: open block device after superblock creation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1613d586a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1513d586a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1113d586a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com
Fixes: 1dbd9ceb390c ("fs: open block device after superblock creation")

/dev/nullb0: Can't open blockdev
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5047 at fs/erofs/super.c:862 erofs_kill_sb+0x206/0x260 fs/erofs/super.c:862
Modules linked in:
CPU: 0 PID: 5047 Comm: syz-executor356 Not tainted 6.5.0-rc3-next-20230728-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:erofs_kill_sb+0x206/0x260 fs/erofs/super.c:862
Code: 00 00 5b 5d 41 5c 41 5d e9 e7 27 b7 fd e8 e2 27 b7 fd 48 89 df e8 6a 81 1b fe 5b 5d 41 5c 41 5d e9 cf 27 b7 fd e8 ca 27 b7 fd <0f> 0b e9 41 fe ff ff e8 5e f6 0b fe e9 1a fe ff ff e8 54 f6 0b fe
RSP: 0018:ffffc90003c2fca0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888029aee000 RCX: 0000000000000000
RDX: ffff8880268e9dc0 RSI: ffffffff83cfdc26 RDI: 0000000000000007
RBP: 00000000e0f5e1e2 R08: 0000000000000007 R09: 00000000e0f5e1e2
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 1ffff92000785fa0 R14: 00000000fffffff0 R15: ffff88807d747cf8
FS:  0000555556001380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aecc7b6468 CR3: 000000007b9d9000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 deactivate_locked_super+0x9a/0x170 fs/super.c:330
 get_tree_bdev+0x4c7/0x6a0 fs/super.c:1347
 vfs_get_tree+0x88/0x350 fs/super.c:1521
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7610a75f09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffaf351d38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 6c756e2f7665642f RCX: 00007f7610a75f09
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000555556002378
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffaf351d70 R14: 00007fffaf351d5c R15: 00007f7610abf03b
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
