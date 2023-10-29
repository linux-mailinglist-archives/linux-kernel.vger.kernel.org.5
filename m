Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB3E7DABDD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 10:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjJ2J1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2J1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 05:27:30 -0400
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D77C6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 02:27:24 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-1efb84e655aso899118fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 02:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698571644; x=1699176444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qso1XSA0QuRFmH2A3BDg6iJYmbyHJYnTJ3GqpiGhhVY=;
        b=udYbWZr6VMV4mJ//GQYZLoRUap0+8JZYb6SRRqokd72htnCahCUJU2HHWPxxOrAWj2
         NUJ4dVyv2ypknGt5vj2TSl4jMlm9Cr069FszYjtH6CmRUPioymm8zpxMblFoUCqXOhPl
         MfhN0N4I0FjMHHByo5b9Vp8963xPDyFWdRWIm4MjlHnlDG3WXHDJXa7iNkP9b/TwFjDF
         MEmvnH0O+HRqagamalNoT5kArpvuuBcJJTjabsl3fZwIPUtwZ3oFo4cINOCrFApw09jI
         awCDe22nxCV7zhILbQR35yasdrHQpbFXB9WmZ9yQqaI9fRkeR2nRk6OIxE1/svx8zu2N
         O5xw==
X-Gm-Message-State: AOJu0YxAt4+4T+i90Sw1sNRRWqRzf4sV/WaL2bJQ6VILRVofnvdsdvQ/
        2lr9O7DUbzCT4OfCKmL6j+DTv+F+vGaV5xS1GbxWdoGOJlcA
X-Google-Smtp-Source: AGHT+IE9lCHWsammt9dgPZ9adunUKQuAUxXugMdhCkbfofOMd2w737M/NaCdLftBsNVc3oq1yC7NSxERTRoLx2Lie6QaMWuaNMdl
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e993:b0:1ea:1bc1:4084 with SMTP id
 r19-20020a056870e99300b001ea1bc14084mr3465353oao.4.1698571644095; Sun, 29 Oct
 2023 02:27:24 -0700 (PDT)
Date:   Sun, 29 Oct 2023 02:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078d1e00608d7878b@google.com>
Subject: [syzbot] [mm?] general protection fault in hugetlb_vma_lock_write
From:   syzbot <syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        riel@surriel.com, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    888cf78c29e2 Merge tag 'iommu-fix-v6.6-rc7' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10cbee95680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee601744db6e780
dashboard link: https://syzkaller.appspot.com/bug?extid=6ada951e7c0f7bc8a71e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fa2557680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14285b57680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca8ad4106267/disk-888cf78c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aac2e80e0744/vmlinux-888cf78c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b14533456815/bzImage-888cf78c.xz

The issue was bisected to:

commit bf4916922c60f43efaa329744b3eef539aa6a2b2
Author: Rik van Riel <riel@surriel.com>
Date:   Fri Oct 6 03:59:07 2023 +0000

    hugetlbfs: extend hugetlb_vma_lock to private VMAs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d7dab5680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1437dab5680000
console output: https://syzkaller.appspot.com/x/log.txt?x=1037dab5680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com
Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")

general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
CPU: 0 PID: 5048 Comm: syz-executor139 Not tainted 6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 c1 1e 42 0b 45 85 c0 0f 84 be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80> 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 d9 5f 90 0f 84 96 0d 00
RSP: 0018:ffffc90003aa7798 EFLAGS: 00010016

RAX: ffff88807a0b9dc0 RBX: 1ffff92000754f23 RCX: 000000000000001d
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 00000000000000e8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 00000000000000e8 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000280 CR3: 00000000758bf000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 down_write+0x93/0x200 kernel/locking/rwsem.c:1573
 hugetlb_vma_lock_write mm/hugetlb.c:300 [inline]
 hugetlb_vma_lock_write+0xae/0x100 mm/hugetlb.c:291
 __hugetlb_zap_begin+0x1e9/0x2b0 mm/hugetlb.c:5447
 hugetlb_zap_begin include/linux/hugetlb.h:258 [inline]
 unmap_vmas+0x2f4/0x470 mm/memory.c:1733
 exit_mmap+0x1ad/0xa60 mm/mmap.c:3230
 __mmput+0x12a/0x4d0 kernel/fork.c:1349
 mmput+0x62/0x70 kernel/fork.c:1371
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9ad/0x2a20 kernel/exit.c:861
 __do_sys_exit kernel/exit.c:991 [inline]
 __se_sys_exit kernel/exit.c:989 [inline]
 __x64_sys_exit+0x42/0x50 kernel/exit.c:989
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff2b7a78ab9
Code: Unable to access opcode bytes at 0x7ff2b7a78a8f.
RSP: 002b:00007fff926ea6b8 EFLAGS: 00000246 ORIG_RAX: 000000000000003c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff2b7a78ab9
RDX: 00007ff2b7ab23f3 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000000cfda R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff926ea6cc
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 c1 1e 42 0b 45 85 c0 0f 84 be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80> 3c 11 00 0f 85 e8 40 00 00 49 81 3a a0 d9 5f 90 0f 84 96 0d 00
RSP: 0018:ffffc90003aa7798 EFLAGS: 00010016
RAX: ffff88807a0b9dc0 RBX: 1ffff92000754f23 RCX: 000000000000001d
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 00000000000000e8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 00000000000000e8 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000280 CR3: 00000000758bf000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	45 85 c9             	test   %r9d,%r9d
   3:	0f 84 cc 0e 00 00    	je     0xed5
   9:	44 8b 05 c1 1e 42 0b 	mov    0xb421ec1(%rip),%r8d        # 0xb421ed1
  10:	45 85 c0             	test   %r8d,%r8d
  13:	0f 84 be 0d 00 00    	je     0xdd7
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	4c 89 d1             	mov    %r10,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 e8 40 00 00    	jne    0x411c
  34:	49 81 3a a0 d9 5f 90 	cmpq   $0xffffffff905fd9a0,(%r10)
  3b:	0f                   	.byte 0xf
  3c:	84                   	.byte 0x84
  3d:	96                   	xchg   %eax,%esi
  3e:	0d                   	.byte 0xd


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
