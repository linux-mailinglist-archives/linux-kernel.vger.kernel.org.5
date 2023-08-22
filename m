Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85E783D12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjHVJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjHVJj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:39:59 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408ABCCC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:39:57 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-56385c43eaeso4568438a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692697196; x=1693301996;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UICpq6r5xOWf0+sNmvDtxNk8IwDDZXnsUDmAR56LhQs=;
        b=fkSEtnAPYktp5YKUuEeKsJemBpFKKlRghtg5cmFw24yRk9qNv56zcUHFXUOGpgDUcG
         DC8Jp/GfB87NSj/RVURg3VZ1sHT+DVxWxf5D3he09BDVpEdxqOJf7CBoAzLkuEFQ7clZ
         yl2kUMCDs5H0C+3zAzdjdfVLZ6m7n86VPryGngUeInQ4vslvFu+cGtaDLFF7zl1TMrnJ
         BTY7C3oszYOkFYNEXXJ41zbfJdgykzHQa5kqFCffMbbk7ptx6NkMSnqTJVkUDqI4C8nB
         nUeTY6BiN0pKRlbh5UpQUy3QoQtv0jTuh2j6wuUI3Q+dgAWMGybQBL+BsKGLHP3+fj98
         uiaA==
X-Gm-Message-State: AOJu0YwCiXafiaMxt8iMsf5J7lxOYiEKwtXK5pv/P4bEMeRPLTd02ovQ
        JakW1atbExxn+ycjd8drQZF3ssLpUvGBgGP5hroZneGJ2pK/
X-Google-Smtp-Source: AGHT+IGfYLilLfst0g4d42LBpBLoGkF/gZvEyIAIEFbaFQGmxf2atEBqZH8ClJV/Fw81XB4/PplqK760mwcYgvYym19rKUmKfl68
MIME-Version: 1.0
X-Received: by 2002:a63:754f:0:b0:564:6e43:a00d with SMTP id
 f15-20020a63754f000000b005646e43a00dmr1185691pgn.3.1692697196708; Tue, 22 Aug
 2023 02:39:56 -0700 (PDT)
Date:   Tue, 22 Aug 2023 02:39:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f4d4806037fc7b8@google.com>
Subject: [syzbot] [mm?] kernel BUG in free_unref_page_prepare
From:   syzbot <syzbot+7423f066b632d9ff23d5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    7271b2a53042 Add linux-next specific files for 20230818
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=119dbe4ba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=7423f066b632d9ff23d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112386f3a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15044717a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d81109bc02c1/disk-7271b2a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b3bf8e2a4f7/vmlinux-7271b2a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6404cd473c1e/bzImage-7271b2a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7423f066b632d9ff23d5@syzkaller.appspotmail.com

 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2441
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6391
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d7e/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:1107!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5045 Comm: syz-executor350 Not tainted 6.5.0-rc6-next-20230818-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:free_pages_prepare mm/page_alloc.c:1107 [inline]
RIP: 0010:free_unref_page_prepare+0x885/0xa40 mm/page_alloc.c:2348
Code: 48 89 d7 e8 5d 2e f4 ff 0f 0b c7 44 24 08 00 00 00 00 4d 8d 77 40 e9 79 fd ff ff 48 c7 c6 80 b9 99 8a 4c 89 ff e8 3b 2e f4 ff <0f> 0b 48 89 ef e8 81 db 0b 00 e9 aa f7 ff ff 4c 89 f7 e8 74 db 0b
RSP: 0018:ffffc9000397f6c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000009 RCX: 0000000000000000
RDX: ffff88807af30000 RSI: ffffffff81d178f5 RDI: 0000000000000000
RBP: ffffea0001b10008 R08: 0000000000000000 R09: fffffbfff1d9bbf2
R10: ffffffff8ecddf97 R11: 1ffffffff1976ca9 R12: 000000000006c400
R13: 0000000000000009 R14: ffffea0001b10040 R15: ffffea0001b10000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f154f89164c CR3: 0000000029448000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2441
 __update_and_free_hugetlb_folio+0x3c1/0x4a0 mm/hugetlb.c:1765
 update_and_free_hugetlb_folio+0x82/0x120 mm/hugetlb.c:1821
 free_huge_folio+0x6e0/0xbb0 mm/hugetlb.c:1917
 release_pages+0x51b/0x14e0 mm/swap.c:1008
 __folio_batch_release+0x77/0xe0 mm/swap.c:1062
 folio_batch_release include/linux/pagevec.h:83 [inline]
 remove_inode_hugepages+0xb7b/0xe20 fs/hugetlbfs/inode.c:691
 hugetlbfs_evict_inode+0x22/0x70 fs/hugetlbfs/inode.c:703
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1775 [inline]
 iput.part.0+0x55e/0x7a0 fs/inode.c:1801
 iput+0x5c/0x80 fs/inode.c:1791
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
 __dentry_kill+0x3b8/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x8dd/0xfd0 fs/dcache.c:913
 __fput+0x536/0xa70 fs/file_table.c:392
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa99/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f154f8c0b09
Code: Unable to access opcode bytes at 0x7f154f8c0adf.
RSP: 002b:00007fffeb55e118 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f154f8c0b09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f154f93b290 R08: ffffffffffffffb8 R09: 0000000000000000
R10: 0000000000048031 R11: 0000000000000246 R12: 00007f154f93b290
R13: 0000000000000000 R14: 00007f154f93bce0 R15: 00007f154f891d60
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:free_pages_prepare mm/page_alloc.c:1107 [inline]
RIP: 0010:free_unref_page_prepare+0x885/0xa40 mm/page_alloc.c:2348
Code: 48 89 d7 e8 5d 2e f4 ff 0f 0b c7 44 24 08 00 00 00 00 4d 8d 77 40 e9 79 fd ff ff 48 c7 c6 80 b9 99 8a 4c 89 ff e8 3b 2e f4 ff <0f> 0b 48 89 ef e8 81 db 0b 00 e9 aa f7 ff ff 4c 89 f7 e8 74 db 0b
RSP: 0018:ffffc9000397f6c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000009 RCX: 0000000000000000
RDX: ffff88807af30000 RSI: ffffffff81d178f5 RDI: 0000000000000000
RBP: ffffea0001b10008 R08: 0000000000000000 R09: fffffbfff1d9bbf2
R10: ffffffff8ecddf97 R11: 1ffffffff1976ca9 R12: 000000000006c400
R13: 0000000000000009 R14: ffffea0001b10040 R15: ffffea0001b10000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d22c54e0b8 CR3: 0000000029448000 CR4: 00000000003506f0
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
