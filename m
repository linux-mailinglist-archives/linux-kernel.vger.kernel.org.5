Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4B07E6FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbjKIRQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344475AbjKIRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:16:31 -0500
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCCA2736
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:16:29 -0800 (PST)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-28011e1cdcbso1002106a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550188; x=1700154988;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ik92Kb8UgHu1nXrWB5uLRqqbBTtMjzV+DKu4EtXnCA=;
        b=eyzgal5fkHHpFQl9pWc6gVAh4bXtXjBiyI6tFxXDW6AP8Fx/+zDRWgONYlWx/ONn7F
         EO8Z0pebTPYuVFaIDOXxf+PpgoerNFAzFq3AnBKpjZJidM+rDK7IiWo2HtJnwNrjAwsT
         KbLMRsEjU1KQ8+/J+PuI4JSgjUVchCw24xYMLcbNO/eOvjVJrqJgeGu/Gtrp+Vk7Y7ZY
         6pade84N/gAGzZ/cacOFYDgucRm1uq+EfqdEbZIvDo6GJtaIZXcN64LN4ulRu+MZT6sP
         /jJjRP5cW7OmjPlfB/+YBBwVUS+/y93EokOLBGFc4/G04c9F680ZjLfd+cB3aBz2z16d
         HHDQ==
X-Gm-Message-State: AOJu0YygEf7qLbd4aV2/vOfU2Esudx+dW/8wD5mGXhPtCY6gjRduRfAc
        U2MFPv0g4IcIsj9w1T26cvqF/Bk3K4MU84z4AtHRzIzULW2K
X-Google-Smtp-Source: AGHT+IF0TbJvKilgxVAad9fEdPkvKA7Dq7Gw6FY3fKi2d3XYn/e7BqKBg0qu10ZUudgFCGOs9nvR0e2P0sVRNHkWQl4Av7IZ2uo9
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d70a:b0:280:941b:9471 with SMTP id
 y10-20020a17090ad70a00b00280941b9471mr550463pju.7.1699550186216; Thu, 09 Nov
 2023 09:16:26 -0800 (PST)
Date:   Thu, 09 Nov 2023 09:16:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020a5790609bb5db8@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in direntry_check_right
From:   syzbot <syzbot+e57bfc56c27a9285a838@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    305230142ae0 Merge tag 'pm-6.7-rc1-2' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106da588e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=e57bfc56c27a9285a838
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb0588e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce91ef680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0aab25a831ba/disk-30523014.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d1b7b8fdf8a/vmlinux-30523014.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9b6822fcd5f/bzImage-30523014.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d31901503cbc/mount_0.gz

The issue was bisected to:

commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri Mar 31 12:32:18 2023 +0000

    reiserfs: Add security prefix to xattr name in reiserfs_security_write()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175ffa1f680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dffa1f680000
console output: https://syzkaller.appspot.com/x/log.txt?x=10dffa1f680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e57bfc56c27a9285a838@syzkaller.appspotmail.com
Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")

REISERFS (device loop0): using 3.5.x disk format
REISERFS warning (device loop0): vs-13060 reiserfs_update_sd_size: stat data of object [1 2 0x0 SD] (nlink == 4) not found (pos 2)
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
------------[ cut here ]------------
kernel BUG at fs/reiserfs/item_ops.c:569!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5062 Comm: syz-executor395 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:direntry_check_right+0x26b/0x280 fs/reiserfs/item_ops.c:569
Code: df e9 38 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c 3e ff ff ff be 04 00 00 00 48 89 df e8 7f 36 af ff e9 2c ff ff ff e8 d5 13 53 ff <0f> 0b e8 ce 13 53 ff 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3
RSP: 0018:ffffc90003afeed0 EFLAGS: 00010293
RAX: ffffffff823ba82b RBX: 0000000000000020 RCX: ffff888079929dc0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000041
RBP: 0000000000000021 R08: ffffffff823ba69e R09: ffffffff8235650d
R10: 0000000000000004 R11: ffff888079929dc0 R12: 00000000fffffffe
R13: 0000000000000000 R14: 0000000000000002 R15: ffff8880549c4120
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e01595ed8 CR3: 0000000028720000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_right+0x4d1/0x770 fs/reiserfs/fix_node.c:355
 dc_check_balance_leaf fs/reiserfs/fix_node.c:1983 [inline]
 dc_check_balance fs/reiserfs/fix_node.c:2039 [inline]
 check_balance fs/reiserfs/fix_node.c:2086 [inline]
 fix_nodes+0x3ff3/0x8ce0 fs/reiserfs/fix_node.c:2636
 reiserfs_cut_from_item+0x466/0x2580 fs/reiserfs/stree.c:1740
 reiserfs_do_truncate+0x9b9/0x14c0 fs/reiserfs/stree.c:1971
 reiserfs_truncate_file+0x4da/0x820 fs/reiserfs/inode.c:2302
 reiserfs_file_release+0x8ca/0xaa0 fs/reiserfs/file.c:109
 __fput+0x3cc/0xa10 fs/file_table.c:394
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa34/0x2750 kernel/exit.c:871
 do_group_exit+0x206/0x2c0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe19c8650b9
Code: Unable to access opcode bytes at 0x7fe19c86508f.
RSP: 002b:00007ffdbbdc7968 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe19c8650b9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007fe19c8e0370 R08: ffffffffffffffb8 R09: 00007ffdbbdc7b88
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe19c8e0370
R13: 0000000000000000 R14: 00007fe19c8e10e0 R15: 00007fe19c833980
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:direntry_check_right+0x26b/0x280 fs/reiserfs/item_ops.c:569
Code: df e9 38 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c 3e ff ff ff be 04 00 00 00 48 89 df e8 7f 36 af ff e9 2c ff ff ff e8 d5 13 53 ff <0f> 0b e8 ce 13 53 ff 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3
RSP: 0018:ffffc90003afeed0 EFLAGS: 00010293
RAX: ffffffff823ba82b RBX: 0000000000000020 RCX: ffff888079929dc0
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000041
RBP: 0000000000000021 R08: ffffffff823ba69e R09: ffffffff8235650d
R10: 0000000000000004 R11: ffff888079929dc0 R12: 00000000fffffffe
R13: 0000000000000000 R14: 0000000000000002 R15: ffff8880549c4120
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3e01595ed8 CR3: 0000000028720000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
