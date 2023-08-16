Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEFF77E450
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjHPO5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343891AbjHPO5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:57:12 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D9271E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:08 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-68874dec6c6so1959011b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197827; x=1692802627;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IU+zhRagu+MzhgOcvrwt8NJxUvyHeuFhSuPKpqThiG4=;
        b=hdhMTQ+OyQF4el1z9SmEpwVIpXdsZ0eRURG2SpFc+3CpFMryhwlLeI5RZp+eQRedrT
         H7B3ycWtgm0Vg9WvWA7d3+4TJL+7nLV0PkaS37fYWJqlKh36utAkJBxeb+jrCxG0W3Us
         zSH+f+Z2M9DEi0Pcqxwn2fyN4hU2XJkU6pUgmglrKXfMs/UwfKX1kajihFAKpwVh1gMv
         0VVnbPmDYOnVfQfalSaXDfVCsQC/iJf3N1D0Sh2443mKHHQY5O3/0zKHTXJAr7YR/2MZ
         hXPmnkHRG9VCOPlXh/2xcjAqghAW3eOA8+IgdpUw4rQC6dEFWj2twWAeDsQmXK8I1ZE/
         oG8A==
X-Gm-Message-State: AOJu0Yzdtb2TSh4Z91xZOjvR1Hk1Oi8ij9ersOJVBSbPc7jWsd1182V4
        a5QBqaVYOWHerrZDiz3uyo66FIJji6jBlo7+PJrNasYK5bHp
X-Google-Smtp-Source: AGHT+IF6saZZR4VKDBPL/DY5WQHz2TsBLk5ZFvlDNrIo54ArkrfEb3jwo1zm19TSEYb48KzjiGYi1Ku9M+94eX+8Sc2RyvjcWGBx
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1393:b0:682:140c:2459 with SMTP id
 t19-20020a056a00139300b00682140c2459mr963166pfg.0.1692197827785; Wed, 16 Aug
 2023 07:57:07 -0700 (PDT)
Date:   Wed, 16 Aug 2023 07:57:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a3b1806030b82e8@google.com>
Subject: [syzbot] [kernel?] WARNING in fault_dirty_shared_page
From:   syzbot <syzbot+6a684137d3f229008920@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, longman@redhat.com, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    21ef7b1e17d0 Add linux-next specific files for 20230809
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fe4e3ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28e9e38cc16e8f0
dashboard link: https://syzkaller.appspot.com/bug?extid=6a684137d3f229008920
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10185a3ba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e6c569a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e961d9a9b52d/disk-21ef7b1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c9bb17b02c/vmlinux-21ef7b1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ebef5bdf7465/bzImage-21ef7b1e.xz

The issue was bisected to:

commit 88e2667632d43928d3ed50d0163ecd73aaa2d455
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Jul 24 18:54:10 2023 +0000

    mm: handle faults that merely update the accessed bit under the VMA lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11db2763a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13db2763a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=15db2763a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a684137d3f229008920@syzkaller.appspotmail.com
Fixes: 88e2667632d4 ("mm: handle faults that merely update the accessed bit under the VMA lock")

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff888029c88130, owner = 0x1, curr 0xffff88801d1c5940, list empty
WARNING: CPU: 0 PID: 5046 at kernel/locking/rwsem.c:1348 __up_read+0x330/0x750 kernel/locking/rwsem.c:1348
Modules linked in:
CPU: 0 PID: 5046 Comm: syz-executor231 Not tainted 6.5.0-rc5-next-20230809-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:__up_read+0x330/0x750 kernel/locking/rwsem.c:1348
Code: 80 3c 02 00 0f 85 e2 03 00 00 48 8b 13 4d 89 f1 55 4d 89 e0 4c 89 f9 48 c7 c6 e0 9c 6c 8a 48 c7 c7 40 9b 6c 8a e8 d0 d6 e6 ff <0f> 0b 58 e9 12 ff ff ff be 08 00 00 00 4c 89 e7 e8 9b e2 75 00 4c
RSP: 0000:ffffc90003a1faf0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888029c88130 RCX: 0000000000000000
RDX: ffff88801d1c5940 RSI: ffffffff814e00c6 RDI: 0000000000000001
RBP: ffffffff8a6c9a80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: 1ffff92000743f62 R14: ffff88801d1c5940 R15: ffff888029c88130
FS:  0000555555dea380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001248 CR3: 000000007904e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mmap_read_unlock include/linux/mmap_lock.h:173 [inline]
 maybe_unlock_mmap_for_io mm/internal.h:709 [inline]
 fault_dirty_shared_page+0x378/0x530 mm/memory.c:3004
 wp_page_shared mm/memory.c:3324 [inline]
 do_wp_page+0xd72/0x3550 mm/memory.c:3393
 handle_pte_fault mm/memory.c:5029 [inline]
 __handle_mm_fault+0x180f/0x4180 mm/memory.c:5154
 handle_mm_fault+0x47a/0xa00 mm/memory.c:5319
 do_user_addr_fault+0x2e7/0xfe0 arch/x86/mm/fault.c:1342
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x5c/0xd0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f28c7f77726
Code: 01 00 20 80 00 00 20 48 c7 04 25 48 01 00 20 01 00 00 00 48 8b 35 ba 79 0a 00 e8 75 07 03 00 31 d2 66 0f ef c0 b9 0a 00 00 00 <48> 89 14 25 48 12 00 20 ba a0 12 00 20 48 b8 73 65 63 75 72 69 74
RSP: 002b:00007ffc9f9d1e90 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 000000000000002a RCX: 000000000000000a
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f28c801b610 R08: 0000000000000000 R09: 65732f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc9f9d20c8 R14: 0000000000000001 R15: 0000000000000001
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
