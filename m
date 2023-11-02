Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE57DF656
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbjKBP0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKBP0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:26:37 -0400
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79AB136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:26:28 -0700 (PDT)
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-6d309886d9fso1289143a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698938788; x=1699543588;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36jTIk8RNWrAuIMJmC5HqYBs4sdtGNKnTTHc+A6SXu8=;
        b=vjYJ6pJ8JcXqAJLsrPf9Br+PlSnj/EzOMoWCcDsKozbZM663aKWcRZ0OfJhRclvrCJ
         Wv1nIOJfK+QtrHXrYBs1rQZSBRJXHp3y125a5F7cJ+D8kAcGWaJamu4IYJ+JsSi2DFXw
         7Cv3n+Ytgv48hZ5eo6z1vwzIF7kO1BDZkXUTzZMjvD8hA3ZxY6dvJGIHP4SjTni/O8jP
         HY82zl4r2iBAp1Xa3HU18wEYf0KY8k1xByqfVN3HnW2vU0JIXJX0rBuQIFxRPojnYi4M
         yKf1hmW2wXhojyqGXk5jFXtW8L7spDvyopRk/5jlkMLJvqjunOSWoZVw/VBv2DEW0IlN
         lzzQ==
X-Gm-Message-State: AOJu0Yy+WRnSmx5SQqwgXHcAqWaMMHzXmZdtQXxffbS+FNRw/DGXw9qb
        KkqZVG1HqRNUtkvDBNLnbQwY/BXXYmlt6mzVDEaJkXwXCfxS
X-Google-Smtp-Source: AGHT+IEWlYNHZ8FBPDPfTtKasOoO9DDEe2aMzCjLNuY/eunbWx/0Dx23U9vkHQAGwGrZmEfOiGN4XMP/wdHHKYAgSp9iDYgca8ce
MIME-Version: 1.0
X-Received: by 2002:a9d:6197:0:b0:6cd:f9b7:dadf with SMTP id
 g23-20020a9d6197000000b006cdf9b7dadfmr5320954otk.2.1698938788231; Thu, 02 Nov
 2023 08:26:28 -0700 (PDT)
Date:   Thu, 02 Nov 2023 08:26:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7bf4906092d02cb@google.com>
Subject: [syzbot] [mm?] general protection fault in hugetlb_vma_lock_read
From:   syzbot <syzbot+93e7c679006f0d4e6105@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    babe393974de Merge tag 'docs-6.7' of git://git.lwn.net/linux
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176e7813680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34994593e74fdcfe
dashboard link: https://syzkaller.appspot.com/bug?extid=93e7c679006f0d4e6105
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/81ff19e40c77/disk-babe3939.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a92e6d2d9507/vmlinux-babe3939.xz
kernel image: https://storage.googleapis.com/syzbot-assets/afd2bad18cfc/bzImage-babe3939.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93e7c679006f0d4e6105@syzkaller.appspotmail.com

netlink: 12 bytes leftover after parsing attributes in process `syz-executor.1'.
general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
CPU: 1 PID: 15736 Comm: syz-executor.1 Not tainted 6.6.0-syzkaller-10265-gbabe393974de #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 21 dc 81 0b 45 85 c0 0f 84 be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80> 3c 11 00 0f 85 e8 40 00 00 49 81 3a e0 09 b3 90 0f 84 96 0d 00
RSP: 0018:ffffc90003387378 EFLAGS: 00010006
RAX: ffff88801d5e9dc0 RBX: 1ffff92000670e9f RCX: 000000000000001d
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 00000000000000e8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 00000000000000e8 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f07477fc6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000b80 CR3: 000000006a8b7000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 down_read+0x9c/0x470 kernel/locking/rwsem.c:1526
 hugetlb_vma_lock_read mm/hugetlb.c:274 [inline]
 hugetlb_vma_lock_read+0xae/0x100 mm/hugetlb.c:265
 hugetlb_follow_page_mask+0x156/0xf20 mm/hugetlb.c:6500
 follow_page_mask+0x49e/0xda0 mm/gup.c:824
 __get_user_pages+0x366/0x1480 mm/gup.c:1237
 __get_user_pages_locked mm/gup.c:1504 [inline]
 __gup_longterm_locked+0x755/0x2570 mm/gup.c:2198
 pin_user_pages_remote+0xee/0x140 mm/gup.c:3346
 process_vm_rw_single_vec mm/process_vm_access.c:105 [inline]
 process_vm_rw_core.constprop.0+0x43d/0xa10 mm/process_vm_access.c:215
 process_vm_rw+0x2ff/0x360 mm/process_vm_access.c:283
 __do_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:298 [inline]
 __x64_sys_process_vm_writev+0xe2/0x1b0 mm/process_vm_access.c:298
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0746a7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f07477fc0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000137
RAX: ffffffffffffffda RBX: 00007f0746b9bf80 RCX: 00007f0746a7cae9
RDX: 0000000000000001 RSI: 0000000020000b80 RDI: 0000000000001d1b
RBP: 00007f0746ac847a R08: 0000000000000001 R09: 0000000000000000
R10: 0000000020000f80 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0746b9bf80 R15: 00007f0746cbfa48
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x109/0x5de0 kernel/locking/lockdep.c:5004
Code: 45 85 c9 0f 84 cc 0e 00 00 44 8b 05 21 dc 81 0b 45 85 c0 0f 84 be 0d 00 00 48 ba 00 00 00 00 00 fc ff df 4c 89 d1 48 c1 e9 03 <80> 3c 11 00 0f 85 e8 40 00 00 49 81 3a e0 09 b3 90 0f 84 96 0d 00
RSP: 0018:ffffc90003387378 EFLAGS: 00010006
RAX: ffff88801d5e9dc0 RBX: 1ffff92000670e9f RCX: 000000000000001d
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 00000000000000e8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 00000000000000e8 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f07477fc6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000b80 CR3: 000000006a8b7000 CR4: 00000000003506f0
----------------
Code disassembly (best guess):
   0:	45 85 c9             	test   %r9d,%r9d
   3:	0f 84 cc 0e 00 00    	je     0xed5
   9:	44 8b 05 21 dc 81 0b 	mov    0xb81dc21(%rip),%r8d        # 0xb81dc31
  10:	45 85 c0             	test   %r8d,%r8d
  13:	0f 84 be 0d 00 00    	je     0xdd7
  19:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  20:	fc ff df
  23:	4c 89 d1             	mov    %r10,%rcx
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2e:	0f 85 e8 40 00 00    	jne    0x411c
  34:	49 81 3a e0 09 b3 90 	cmpq   $0xffffffff90b309e0,(%r10)
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

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
