Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5079434D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243953AbjIFSvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbjIFSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:51:27 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C5B1739
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:51:21 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-55afcc54d55so1348413a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026281; x=1694631081;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAZ7rOCfOseME4MuaL44Zi7XvvoyFn8GUdJw0Q0acE0=;
        b=BBJHDeKcH4jTP68seNj2ggShfpj/JZ9gJXlC2prEk4qCEaMJUHJ2pZpXyBsBWBOD5E
         B027QRepvI/8wxkuiHJLYjdKJLaNYo1kEdJygL3401qIX/yCwy9x0+O5wg+PBhe2/Oe1
         XQ64BtSu8h1QzEIV3h1DK77T0f1UF2r/T9RZfLd1Lp9TlgNdKhVq02HTQboSSfsX6+SF
         UN8EXKNUO2pCxeR0Bs8xfYXGin+gYhyYD07ZSJFDHvN6PIhqEe3x9C9Gs2rsAzkJ/d5M
         UzcLVPJ9jKFjI2PHi0nkuHdMsWVN0FWnGyb+lvikbn6gs352nF1NAMso15SZcHXTjp6f
         Cz1A==
X-Gm-Message-State: AOJu0Yzz34ujYE01mCJt3Pt+fRAB1uwWHN9NP6iNRFIe7a+9y10hLfhc
        MAkLcb5w9hRAYuhBMxFykfJzEZWmqoKM5n7t5LSy/FuCjBed
X-Google-Smtp-Source: AGHT+IH/ao/tEHf9luggasAQ9yvDmeoUACnLftF7K0iw2dwc41ni6fgtIU0wUmOoWD9Wcev+JLJR69b69RpaPl/xyelFlJmvHoTd
MIME-Version: 1.0
X-Received: by 2002:a17:903:41cd:b0:1b7:f55e:4ab0 with SMTP id
 u13-20020a17090341cd00b001b7f55e4ab0mr125118ple.0.1694026281399; Wed, 06 Sep
 2023 11:51:21 -0700 (PDT)
Date:   Wed, 06 Sep 2023 11:51:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be3c1a0604b53a1c@google.com>
Subject: [syzbot] [mm?] kernel BUG in filemap_unaccount_folio
From:   syzbot <syzbot+17a207d226b8a5fb0fd9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

syzbot found the following issue on:

HEAD commit:    db906f0ca6bb Merge tag 'phy-for-6.6' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16cbb32fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
dashboard link: https://syzkaller.appspot.com/bug?extid=17a207d226b8a5fb0fd9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11609f38680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c1fc00680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46394f3ca3eb/disk-db906f0c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eeaa594bfd1f/vmlinux-db906f0c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c8df8de79ec/bzImage-db906f0c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17a207d226b8a5fb0fd9@syzkaller.appspotmail.com

 search_binary_handler fs/exec.c:1739 [inline]
 exec_binprm fs/exec.c:1781 [inline]
 bprm_execve fs/exec.c:1856 [inline]
 bprm_execve+0x80a/0x1a50 fs/exec.c:1812
 do_execveat_common.isra.0+0x5d3/0x740 fs/exec.c:1964
 do_execve fs/exec.c:2038 [inline]
 __do_sys_execve fs/exec.c:2114 [inline]
 __se_sys_execve fs/exec.c:2109 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2109
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
------------[ cut here ]------------
kernel BUG at mm/filemap.c:158!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5043 Comm: syz-executor729 Not tainted 6.5.0-syzkaller-11275-gdb906f0ca6bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:filemap_unaccount_folio+0x62e/0x870 mm/filemap.c:158
Code: 0f 85 68 01 00 00 8b 6b 5c 31 ff 89 ee e8 6a 3e d2 ff 85 ed 7e 16 e8 f1 42 d2 ff 48 c7 c6 c0 3b 97 8a 48 89 df e8 a2 58 10 00 <0f> 0b e8 db 42 d2 ff 48 8d 6b 58 be 04 00 00 00 48 89 ef e8 0a 0d
RSP: 0018:ffffc900039ef828 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffea0001cfe400 RCX: 0000000000000000
RDX: ffff88807e171dc0 RSI: ffffffff81b559ae RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d9be7a
R10: ffffffff8ecdf3d7 R11: 0000000000000001 R12: ffff8880258003b8
R13: ffffea0001cfe400 R14: ffffea0001cfe418 R15: ffffea0001cfe420
FS:  0000555556b42380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007a443000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __filemap_remove_folio+0x110/0x820 mm/filemap.c:227
 filemap_remove_folio+0xca/0x210 mm/filemap.c:260
 truncate_inode_folio+0x49/0x70 mm/truncate.c:195
 shmem_undo_range+0x365/0x1040 mm/shmem.c:1018
 shmem_truncate_range mm/shmem.c:1114 [inline]
 shmem_evict_inode+0x392/0xb50 mm/shmem.c:1243
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1775 [inline]
 iput.part.0+0x55e/0x7a0 fs/inode.c:1801
 iput+0x5c/0x80 fs/inode.c:1791
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
 __dentry_kill+0x3b8/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x8dd/0xfd0 fs/dcache.c:913
 __fput+0x536/0xa70 fs/file_table.c:392
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6700c6aa90
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d f1 85 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007ffd27935ca8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6700c6aa90
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000000000003
RBP: 00007ffd27935cc0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000028011 R11: 0000000000000202 R12: 00007f6700cde5f0
R13: 00007ffd27935ea8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:filemap_unaccount_folio+0x62e/0x870 mm/filemap.c:158
Code: 0f 85 68 01 00 00 8b 6b 5c 31 ff 89 ee e8 6a 3e d2 ff 85 ed 7e 16 e8 f1 42 d2 ff 48 c7 c6 c0 3b 97 8a 48 89 df e8 a2 58 10 00 <0f> 0b e8 db 42 d2 ff 48 8d 6b 58 be 04 00 00 00 48 89 ef e8 0a 0d
RSP: 0018:ffffc900039ef828 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffea0001cfe400 RCX: 0000000000000000
RDX: ffff88807e171dc0 RSI: ffffffff81b559ae RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d9be7a
R10: ffffffff8ecdf3d7 R11: 0000000000000001 R12: ffff8880258003b8
R13: ffffea0001cfe400 R14: ffffea0001cfe418 R15: ffffea0001cfe420
FS:  0000555556b42380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007a443000 CR4: 00000000003506f0
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

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
