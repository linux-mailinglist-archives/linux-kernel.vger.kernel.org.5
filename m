Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01BA753004
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjGNDev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbjGNDer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:34:47 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825926B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:34:46 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3a359611a98so2578971b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689305685; x=1691897685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0a5kS/ibUgmVMe/2DNfyHaQk85Po9Hnp9hWfz7j7VII=;
        b=P9InxH+pUz2bk4rt2HTXyTa8ZCzn5tpotjQO5Q3/E+rlz4p6sXNbClUwYE+bWHVWW2
         7n35F4QXzEr7zdjP34yz8wQ89tHSISSNgAD9Z5i/t5cNhAo1E476VI1Zb3oheLm+uLk2
         av0fIUEAdc26XFtfINRmcgc2fmx8fACgVrcIbQ3gb/QGSsIcCM/aDPLPZ8nn0LsG/PeY
         +U1BVTSxe0oA9raiExMEnClAVZJqGfmtJsFOH/+0nHamEbvD2pxWO9AGogDMaxO4LWqC
         gH2W0Lu2ODsrWuhYPV1x8F4ESurxeDxLWQhlNeEfceQX1tq0lBEleFprYfWe5Ty9Nknw
         g+mg==
X-Gm-Message-State: ABy/qLYUgQL+8/nEvzZZkgz4fkqDAc7/zcdoLtl+VAxO+zLO61ZtyRma
        WamHdcx+jDvhSSYa3jSGoo2UpybXQ/TVEg6FYGEJ7ZRI7AJ7
X-Google-Smtp-Source: APBJJlH6BkGTXkYhI8GA0LeWFlLStdhapw2vxnozolcPhN1cgMAIND3ah8tWpHv0aGCm4Dh375qFCdhP1xx2aZN1aexIrAkYprVR
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc3:b0:3a2:943d:da3e with SMTP id
 o3-20020a0568080bc300b003a2943dda3emr5166075oik.1.1689305685611; Thu, 13 Jul
 2023 20:34:45 -0700 (PDT)
Date:   Thu, 13 Jul 2023 20:34:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004edae006006a2109@google.com>
Subject: [syzbot] [mm?] kernel BUG in mfill_atomic_copy
From:   syzbot <syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fe57d0d86f03 Add linux-next specific files for 20230710
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14d46ed8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eaa6217eed71d333
dashboard link: https://syzkaller.appspot.com/bug?extid=42309678e0bc7b32f8e9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b63e18a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13784d64a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e7627fb1623/disk-fe57d0d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/848a690045db/vmlinux-fe57d0d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36e5c3ae635e/bzImage-fe57d0d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/userfaultfd.c:573!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5031 Comm: syz-executor410 Not tainted 6.5.0-rc1-next-20230710-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:mfill_atomic mm/userfaultfd.c:573 [inline]
RIP: 0010:mfill_atomic_copy+0x9ed/0x17e0 mm/userfaultfd.c:725
Code: 8d 8c 24 a8 00 00 00 4c 89 e7 e8 be 54 d9 ff 4c 63 f0 e9 71 fc ff ff e8 51 eb a1 ff 0f 0b e8 4a eb a1 ff 0f 0b e8 43 eb a1 ff <0f> 0b e8 3c eb a1 ff 0f 0b 49 c7 c6 ef ff ff ff e9 54 fd ff ff e8
RSP: 0018:ffffc9000395fb48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff88801f67bb80 RSI: ffffffff81e32bad RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000006 R09: ffffffffffffffff
R10: 0000000005ffffff R11: 0000000000000001 R12: 0000200000000000
R13: 00005ffffffff001 R14: ffffffffffffffff R15: 0000000005ffffff
FS:  00005555571e03c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000060 CR3: 000000002ba7a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 userfaultfd_copy fs/userfaultfd.c:1766 [inline]
 userfaultfd_ioctl+0xe43/0x4c40 fs/userfaultfd.c:2098
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2e41c4b4b9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff13a95188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff13a95198 RCX: 00007f2e41c4b4b9
RDX: 0000000020000040 RSI: 00000000c028aa03 RDI: 0000000000000003
RBP: 00007fff13a95190 R08: 00007fff13a95190 R09: 00007f2e41c0e380
R10: 00007fff13a95190 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mfill_atomic mm/userfaultfd.c:573 [inline]
RIP: 0010:mfill_atomic_copy+0x9ed/0x17e0 mm/userfaultfd.c:725
Code: 8d 8c 24 a8 00 00 00 4c 89 e7 e8 be 54 d9 ff 4c 63 f0 e9 71 fc ff ff e8 51 eb a1 ff 0f 0b e8 4a eb a1 ff 0f 0b e8 43 eb a1 ff <0f> 0b e8 3c eb a1 ff 0f 0b 49 c7 c6 ef ff ff ff e9 54 fd ff ff e8
RSP: 0018:ffffc9000395fb48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff88801f67bb80 RSI: ffffffff81e32bad RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000006 R09: ffffffffffffffff
R10: 0000000005ffffff R11: 0000000000000001 R12: 0000200000000000
R13: 00005ffffffff001 R14: ffffffffffffffff R15: 0000000005ffffff
FS:  00005555571e03c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000060 CR3: 000000002ba7a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
