Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB97534CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjGNIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjGNIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:12:20 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34774211
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:10:18 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6b754fa9c34so2664550a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322194; x=1691914194;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eG10Q/hmBG2OUVGxO4TY4oCGJnod3I5xRT0tU+zLy4E=;
        b=QmQjO1uuChvxG9q2HtPoM8prw6fZsdbQj++HGcYGVuyKXh3jpIstsHzGXAtx8Q/RfD
         U5b9vynPj26mzLt+sMaWKIOmQo4XVQBxyejKYkbmF9QgAA2Ozx7fh8O1U0tb+FKELnqQ
         LEF9k5tZk9rPoKkV5NDnLC5PNxHAka2pl96ho+wIoEdRCqdoYjslsYGODr1eaU8Ik2E9
         dCTDK8g64YadmaTmlk8ep/OVGTnugnjm5+9KqI/LAbMJ7E1P+xPnmND8sxJ2dijLEjnE
         DVaE6kY4j6qW2aP34kL/8yfdG7KZvDIlGTj41i49iFqZGWBLxCfWvIRteHYOGefxE94M
         cjqg==
X-Gm-Message-State: ABy/qLZRazHxDp2Ie4F7bIf2Vw9hXq624pnSyCDchxKYHe8Rz2kuU9eQ
        F7q2XqRgHLOyenCvlPGgE8QEld6Iu9m4DZBnb0fV1FWHYvlx
X-Google-Smtp-Source: APBJJlGNxOUzULuvHMO3Tp38852/tyzyT6O1qJ9RVY4aBISRyK+5w8nPOrUvKG27qLXKOVjSC8WIxguz5nypy8eGzNVry5bVBYB5
MIME-Version: 1.0
X-Received: by 2002:a05:6830:1e58:b0:6b7:4d84:ce4d with SMTP id
 e24-20020a0568301e5800b006b74d84ce4dmr3690014otj.1.1689322194777; Fri, 14 Jul
 2023 01:09:54 -0700 (PDT)
Date:   Fri, 14 Jul 2023 01:09:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054bd5b06006df9c8@google.com>
Subject: [syzbot] [iommu?] WARNING in iommufd_access_destroy
From:   syzbot <syzbot+7574ebfe589049630608@syzkaller.appspotmail.com>
To:     iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
        kevin.tian@intel.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    06c2afb862f9 Linux 6.5-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1310ded8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e75667d82b529c4f
dashboard link: https://syzkaller.appspot.com/bug?extid=7574ebfe589049630608
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12150d5aa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13164474a80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-06c2afb8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5107fc9d7e9/vmlinux-06c2afb8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c34d4df7975/bzImage-06c2afb8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7574ebfe589049630608@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 5730 at drivers/iommu/iommufd/device.c:462 iommufd_access_destroy+0x55/0x70 drivers/iommu/iommufd/device.c:462
Modules linked in:
CPU: 2 PID: 5730 Comm: syz-executor207 Not tainted 6.5.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:iommufd_access_destroy+0x55/0x70 drivers/iommu/iommufd/device.c:462
Code: 48 8b bd a8 00 00 00 48 89 ee e8 26 f1 00 00 31 ff 89 c5 89 c6 e8 1b 37 ec fc 40 84 ed 74 06 5d e9 30 3b ec fc e8 2b 3b ec fc <0f> 0b 5d e9 23 3b ec fc e8 3e 7b 3e fd eb c7 66 66 2e 0f 1f 84 00
RSP: 0018:ffffc90003bd7cc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90003bd7e50 RCX: 0000000000000000
RDX: ffff888023385840 RSI: ffffffff8497c765 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000004
R13: ffff88802a1a8000 R14: ffffc90003bd7e10 R15: 00000000fffffffe
FS:  00007f57a46fc700(0000) GS:ffff88806b800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57a47c0ba8 CR3: 000000001d1bd000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iommufd_test_create_access drivers/iommu/iommufd/selftest.c:743 [inline]
 iommufd_test+0x1506/0x2c30 drivers/iommu/iommufd/selftest.c:961
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f57a476b989
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f57a46fc308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f57a476b989
RDX: 0000000020000080 RSI: 0000000000003ba0 RDI: 0000000000000003
RBP: 00007f57a47f3418 R08: 00007f57a46fc700 R09: 0000000000000000
R10: 00007f57a46fc700 R11: 0000000000000246 R12: 00007ffd6af68f3e
R13: 00007f57a47f3410 R14: 6d6f692f7665642f R15: 0000000000022000
 </TASK>


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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
