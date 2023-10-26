Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF37D8463
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbjJZOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjJZOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:20:24 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC91B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:20:20 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6cd0a9b5a90so1148351a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330020; x=1698934820;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7laoKfp6mRSUnZKN04Wpi3amSzI30zHY1zAqCLX4lI=;
        b=HTpfAVnnQJ6zysGN1Bc+z9HY5zFRI9r7wBxwTbeUvYAFxM4SBV4YVJeCJb59MUnu+r
         3fnAra+lUnroM8eneQlk7T6zCqtsl25F9bT7dLhqtwpxt1qDhaLRdPgGCwU/18FE2/zQ
         EVGdyFkH4mKQ64+LJJGeJSfuI2ajOSG+hjKiBs89EeolP15h5USd3Yb50HCQrRVACGKF
         Uu+yZOhmRihaEEcd9qB5MqNHab9ppB6SQLWOE6KTSm7PABFpfKeVdps0s2ZGJZNctDeq
         G4CKSNEZUIcK6rjeMZpmKol5KvWcC83nZdO70zPgVz8v9lraHWc3Zefx9S1v1MPk3F+1
         KM/w==
X-Gm-Message-State: AOJu0YyOH/uXjgleeD7KcejSGbiHnMXtg+x+thlJzEXAgLsKMTWqIp50
        /p4jRB9HUimC3yZNXYDJkLGO5sv4uW56J4Tk8zOhZO7ZlglZ
X-Google-Smtp-Source: AGHT+IH4qEDAGCgxLl0bZ+zsAy+kNl3QmFFaPFp4Ws6LnKYJ9+Bz1cSjpQ/dHdQMTYfAFLuXz7DdZ6MK1oY6/XkEUmrz9uOwJPGE
MIME-Version: 1.0
X-Received: by 2002:a9d:4f0b:0:b0:6b7:3eba:59d3 with SMTP id
 d11-20020a9d4f0b000000b006b73eba59d3mr4980998otl.6.1698330020217; Thu, 26 Oct
 2023 07:20:20 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:20:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000910ad106089f45eb@google.com>
Subject: [syzbot] [net?] BUG: corrupted list in ptp_open
From:   syzbot <syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2030579113a1 Add linux-next specific files for 20231020
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ab79a3680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37404d76b3c8840e
dashboard link: https://syzkaller.appspot.com/bug?extid=df3f3ef31f60781fa911
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140aa715680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11037669680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a99a981e5d78/disk-20305791.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/073a5ba6a2a6/vmlinux-20305791.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7c1a7107f7b/bzImage-20305791.xz

The issue was bisected to:

commit 8f5de6fb245326704f37d91780b9a10253a8a100
Author: Xabier Marquiegui <reibax@gmail.com>
Date:   Wed Oct 11 22:39:55 2023 +0000

    ptp: support multiple timestamp event readers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15475b89680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17475b89680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13475b89680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")

list_add corruption. prev->next should be next (ffff88814a1325e8), but was ffff888078d25048. (prev=ffff888078d21048).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:32!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7237 Comm: syz-executor182 Not tainted 6.6.0-rc6-next-20231020-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:__list_add_valid_or_report+0xb6/0x100 lib/list_debug.c:32
Code: e8 2f a5 3a fd 0f 0b 48 89 d9 48 c7 c7 40 9d e9 8a e8 1e a5 3a fd 0f 0b 48 89 f1 48 c7 c7 c0 9d e9 8a 48 89 de e8 0a a5 3a fd <0f> 0b 48 89 f2 48 89 d9 48 89 ee 48 c7 c7 40 9e e9 8a e8 f3 a4 3a
RSP: 0018:ffffc90009b3f898 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88814a1325e8 RCX: ffffffff816bb8d9
RDX: 0000000000000000 RSI: ffffffff816c4d42 RDI: 0000000000000005
RBP: ffff88807c7a9048 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88814a132000
R13: ffffc90009b3f900 R14: ffff888078d21048 R15: ffff88807c7a9048
FS:  0000555556c00380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef0aa1138 CR3: 000000007d17e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 ptp_open+0x1c5/0x4f0 drivers/ptp/ptp_chardev.c:122
 posix_clock_open+0x17e/0x240 kernel/time/posix-clock.c:134
 chrdev_open+0x26d/0x6e0 fs/char_dev.c:414
 do_dentry_open+0x8d4/0x18d0 fs/open.c:948
 do_open fs/namei.c:3621 [inline]
 path_openat+0x1d36/0x2cd0 fs/namei.c:3778
 do_filp_open+0x1dc/0x430 fs/namei.c:3808
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fc6c2099ae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef0aa1238 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc6c2099ae9
RDX: 0000000000000000 RSI: 0000000020000300 RDI: ffffffffffffff9c
RBP: 00000000000f4240 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000130fc
R13: 00007ffef0aa124c R14: 00007ffef0aa1260 R15: 00007ffef0aa1250
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xb6/0x100 lib/list_debug.c:32
Code: e8 2f a5 3a fd 0f 0b 48 89 d9 48 c7 c7 40 9d e9 8a e8 1e a5 3a fd 0f 0b 48 89 f1 48 c7 c7 c0 9d e9 8a 48 89 de e8 0a a5 3a fd <0f> 0b 48 89 f2 48 89 d9 48 89 ee 48 c7 c7 40 9e e9 8a e8 f3 a4 3a
RSP: 0018:ffffc90009b3f898 EFLAGS: 00010286
RAX: 0000000000000075 RBX: ffff88814a1325e8 RCX: ffffffff816bb8d9
RDX: 0000000000000000 RSI: ffffffff816c4d42 RDI: 0000000000000005
RBP: ffff88807c7a9048 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88814a132000
R13: ffffc90009b3f900 R14: ffff888078d21048 R15: ffff88807c7a9048
FS:  0000555556c00380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef0aa1138 CR3: 000000007d17e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
