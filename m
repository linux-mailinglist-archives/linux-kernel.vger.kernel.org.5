Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC6B7562D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGQMes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQMeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:34:46 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9E1B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:34:45 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3a4074304faso6151694b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597284; x=1692189284;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Qxxk2eJbYAKbnfupAVN1mfxLNH2wLBqel6UnpkYr8U=;
        b=Stf/bJKCwrAn7uJi7z2bGNxvbqYKH2eP1o+Ku7zzY7tWshnkWq+A2JKvrPN92VlE5Z
         k9g1JD5opCQFwPLRwOTAiWoDkQ5cm0NeS0/7P3S7giulEvBXCJEEXYyglydzYxpEllWr
         8FyjnFITI5tvLERj/QDs3aYGmAlOcMpGrY0/Fck2vv5gcFUL+UEHg+uo1bw0A39JPs0v
         fQxP40+PYb/xemO5d1ctE5YWrUgfaOYR2Ib4HsEkpc8lOV51+yy3WJc/6uY8HPMdfr17
         Ifr0s40gUdgqdP1Ij0lSJ5c0snsqtFvSKiPtKil+od4ROl3QcdO6+vSQELFcVLpzwDk8
         hUrA==
X-Gm-Message-State: ABy/qLYljzV/l1FWz3EPL/8pQY3zsUxbKxE4g0FLtr68y8d6+X/lEgLI
        YTFiS3k1pzSxxVbKI0dNY3OLvOH+fC/2rh+aynB3TMdgMeRD
X-Google-Smtp-Source: APBJJlHNqKA/r/QGf07Md1lLfugrH6AuFtsMKVuU0dDPzruFw9SNRprxkZ9CiIGNSXoemO4eRmQv6DWROttNy0kmS58Zji6pnU6/
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1520:b0:3a3:a8d1:1aa1 with SMTP id
 u32-20020a056808152000b003a3a8d11aa1mr15909067oiw.2.1689597284833; Mon, 17
 Jul 2023 05:34:44 -0700 (PDT)
Date:   Mon, 17 Jul 2023 05:34:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9de430600ae05db@google.com>
Subject: [syzbot] [mm?] kernel BUG in collapse_file (3)
From:   syzbot <syzbot+fe7b1487405295d29268@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    e32622656258 Add linux-next specific files for 20230713
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16cd037aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55a2f8abfda98f31
dashboard link: https://syzkaller.appspot.com/bug?extid=fe7b1487405295d29268
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131922e4a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14277fd8a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1c2a7ce287f/disk-e3262265.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2041e3e43285/vmlinux-e3262265.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44f789cdae5d/bzImage-e3262265.xz

The issue was bisected to:

commit 49a44d59344d1a6a4cc841d6e4a8727f99ed97bf
Author: Hugh Dickins <hughd@google.com>
Date:   Wed Jul 12 04:42:19 2023 +0000

    mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105af56aa80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=125af56aa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=145af56aa80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe7b1487405295d29268@syzkaller.appspotmail.com
Fixes: 49a44d59344d ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")

------------[ cut here ]------------
kernel BUG at mm/khugepaged.c:1785!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5058 Comm: syz-executor181 Not tainted 6.5.0-rc1-next-20230713-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:collapse_file+0x1150/0x5510 mm/khugepaged.c:1785
Code: 89 c6 e8 e3 67 a6 ff 84 db 0f 85 66 f1 ff ff e8 a6 6c a6 ff 0f 0b e9 5a f1 ff ff c6 44 24 48 00 e9 65 f0 ff ff e8 90 6c a6 ff <0f> 0b e8 89 6c a6 ff 4d 85 ed 74 1c e8 7f 6c a6 ff 44 89 eb 31 ff
RSP: 0018:ffffc90003bff810 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000000000ff RCX: 0000000000000000
RDX: ffff88807e618000 RSI: ffffffff81df5fb0 RDI: 0000000000000007
RBP: 0000000777fa80ff R08: 0000000000000007 R09: 0000000000000000
R10: 00000000000000ff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880227b3680 R15: 0000000777fa7eff
FS:  00007fdc40a816c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc40b169f8 CR3: 00000000278a9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hpage_collapse_scan_file+0xc8d/0x1650 mm/khugepaged.c:2285
 madvise_collapse+0x52c/0xb50 mm/khugepaged.c:2729
 madvise_vma_behavior+0x200/0x1e60 mm/madvise.c:1094
 madvise_walk_vmas+0x1c6/0x2b0 mm/madvise.c:1268
 do_madvise.part.0+0x29c/0x5d0 mm/madvise.c:1448
 do_madvise mm/madvise.c:1461 [inline]
 __do_sys_madvise mm/madvise.c:1461 [inline]
 __se_sys_madvise mm/madvise.c:1459 [inline]
 __x64_sys_madvise+0x115/0x150 mm/madvise.c:1459
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdc40ac0399
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdc40a81238 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fdc40b4a308 RCX: 00007fdc40ac0399
RDX: 0000000000000019 RSI: 000000000040c101 RDI: 0000000020000000
RBP: 00007fdc40b4a300 R08: 00007fdc40a816c0 R09: 00007fdc40a816c0
R10: 00007fdc40a816c0 R11: 0000000000000246 R12: 00007fdc40b4a30c
R13: 0000000000000000 R14: 00007fffbeb44cf0 R15: 00007fffbeb44dd8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:collapse_file+0x1150/0x5510 mm/khugepaged.c:1785
Code: 89 c6 e8 e3 67 a6 ff 84 db 0f 85 66 f1 ff ff e8 a6 6c a6 ff 0f 0b e9 5a f1 ff ff c6 44 24 48 00 e9 65 f0 ff ff e8 90 6c a6 ff <0f> 0b e8 89 6c a6 ff 4d 85 ed 74 1c e8 7f 6c a6 ff 44 89 eb 31 ff
RSP: 0018:ffffc90003bff810 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000000000ff RCX: 0000000000000000
RDX: ffff88807e618000 RSI: ffffffff81df5fb0 RDI: 0000000000000007
RBP: 0000000777fa80ff R08: 0000000000000007 R09: 0000000000000000
R10: 00000000000000ff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880227b3680 R15: 0000000777fa7eff
FS:  00007fdc40a816c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc40a60d58 CR3: 00000000278a9000 CR4: 00000000003506f0
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

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
