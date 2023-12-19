Return-Path: <linux-kernel+bounces-4699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059BA8180BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92D01C21FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66B63D1;
	Tue, 19 Dec 2023 04:59:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E25C97
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7139b04eeso505502439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 20:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702961971; x=1703566771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWrz+k3w0q2RfIBYcx3jvDrB/zw4jgFH4jF/O7VFotI=;
        b=YY6taM83sQMEdHvym46WkDwpr3exXfEyo33UD2e1MwEuDniH+vLjWiHc8Vn2g7OLmr
         MbkSXUIQBckxRuaD19KXZiUxbO1h1cBs51+Yr+UtOAslHqLJqR7N3Do8wAAfrQvpkkRX
         klMjZlKKZCLBWynovW0h89TR7e0xDO4Q9GGLa/RGtsqRAgFZ6ODwwH62GxVIwBFrD0lF
         LoM3ZGpxzXpz2ic/uKHRR0J+I/QFIfmXNXmtYP6IvR/FoR95v3/85sRPREdqGGPv+WLF
         pid8GgVRchGtSeBPpikHF5wm2+h+NG/msuHW0ntk6LEOwIx8ZiQl5431Mzb2More4N1n
         nW7w==
X-Gm-Message-State: AOJu0YxDdqLgahT+4q2idpNsKjYrbbTLoCqS3ilQmhLullNP1hOb7VmR
	YdjtbaMQu153Y/ySxZO+GpDw7kH8wz864HD3yGF6XsBfwWra
X-Google-Smtp-Source: AGHT+IHAkKs4Y9cvBgqNFVChrOXlAuY/nhDwJGc1OGlrZ+CC0OfzvxqONJalgt1miJ5sxCxdc/1eAZdrd0/iHCTMJtrN+9WY3NCR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410e:b0:464:11fa:46e1 with SMTP id
 ay14-20020a056638410e00b0046411fa46e1mr568381jab.3.1702961971277; Mon, 18 Dec
 2023 20:59:31 -0800 (PST)
Date: Mon, 18 Dec 2023 20:59:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d37a1060cd5bb2a@google.com>
Subject: [syzbot] [mm?] general protection fault in folio_flags (2)
From: syzbot <syzbot+2dcf98b2c111b6d34370@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, ddstreet@ieee.org, fengwei.yin@intel.com, 
	hannes@cmpxchg.org, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, sjenning@redhat.com, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17cb8a20bde6 Add linux-next specific files for 20231215
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1202a4d1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=2dcf98b2c111b6d34370
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12053571e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d3998ae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae1915546a0a/disk-17cb8a20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0f2ec7a35f4/vmlinux-17cb8a20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/619edb9cb864/bzImage-17cb8a20.xz

The issue was bisected to:

commit bb509720dcf526875364865e47c2fc26e742ee31
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Wed Dec 13 21:58:30 2023 +0000

    mm: return the folio from __read_swap_cache_async()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f99206e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f99206e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f99206e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2dcf98b2c111b6d34370@syzkaller.appspotmail.com
Fixes: bb509720dcf5 ("mm: return the folio from __read_swap_cache_async()")

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 6983 Comm: syz-executor113 Not tainted 6.7.0-rc5-next-20231215-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:PageTail include/linux/page-flags.h:286 [inline]
RIP: 0010:folio_flags.constprop.0+0x21/0x150 include/linux/page-flags.h:313
Code: 8f 42 00 5b 48 98 5d c3 90 41 54 55 53 48 89 fb e8 d4 0a b1 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 01 01 00 00 48 8b 6b 08 31 ff 83 e5 01 48 89 ee
RSP: 0018:ffffc9000b12f2c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81d74b41
RDX: 0000000000000001 RSI: ffffffff81d704fc RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000008
R13: 00000000000002a0 R14: ffffc9000b12f640 R15: ffffffff92a38840
FS:  00007f49dab2d6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000203d8000 CR3: 000000001c321000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_test_head include/linux/page-flags.h:785 [inline]
 folio_test_large include/linux/page-flags.h:806 [inline]
 folio_nr_pages include/linux/mm.h:2059 [inline]
 folio_file_page include/linux/pagemap.h:826 [inline]
 swapin_readahead+0x1d5/0xe40 mm/swap_state.c:888
 do_swap_page+0x4a0/0x3150 mm/memory.c:3891
 handle_pte_fault mm/memory.c:5138 [inline]
 __handle_mm_fault+0x139c/0x48f0 mm/memory.c:5276
 handle_mm_fault+0x476/0xa00 mm/memory.c:5441
 faultin_page mm/gup.c:958 [inline]
 __get_user_pages+0x4b1/0x1490 mm/gup.c:1241
 __get_user_pages_locked mm/gup.c:1509 [inline]
 __gup_longterm_locked+0x278/0x2ab0 mm/gup.c:2211
 pin_user_pages_remote+0xee/0x140 mm/gup.c:3358
 process_vm_rw_single_vec mm/process_vm_access.c:106 [inline]
 process_vm_rw_core.constprop.0+0x439/0xa00 mm/process_vm_access.c:216
 process_vm_rw+0x2fd/0x360 mm/process_vm_access.c:284
 __do_sys_process_vm_readv mm/process_vm_access.c:296 [inline]
 __se_sys_process_vm_readv mm/process_vm_access.c:292 [inline]
 __x64_sys_process_vm_readv+0xe2/0x1b0 mm/process_vm_access.c:292
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f49db39b999
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f49dab2d228 EFLAGS: 00000246 ORIG_RAX: 0000000000000136
RAX: ffffffffffffffda RBX: 00007f49db420438 RCX: 00007f49db39b999
RDX: 0000000000000002 RSI: 0000000020008400 RDI: 0000000000000133
RBP: 00007f49db420430 R08: 0000000000000286 R09: 0000000000000000
R10: 0000000020008640 R11: 0000000000000246 R12: 00007f49db3ec70c
R13: 000000000000006e R14: 00007ffcb5988390 R15: 00007ffcb5988478
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:PageTail include/linux/page-flags.h:286 [inline]
RIP: 0010:folio_flags.constprop.0+0x21/0x150 include/linux/page-flags.h:313
Code: 8f 42 00 5b 48 98 5d c3 90 41 54 55 53 48 89 fb e8 d4 0a b1 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 01 01 00 00 48 8b 6b 08 31 ff 83 e5 01 48 89 ee
RSP: 0018:ffffc9000b12f2c0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81d74b41
RDX: 0000000000000001 RSI: ffffffff81d704fc RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000008
R13: 00000000000002a0 R14: ffffc9000b12f640 R15: ffffffff92a38840
FS:  00007f49dab2d6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200bf038 CR3: 000000001c321000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8f 42 00             	pop    0x0(%rdx)
   3:	5b                   	pop    %rbx
   4:	48 98                	cltq
   6:	5d                   	pop    %rbp
   7:	c3                   	ret
   8:	90                   	nop
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	e8 d4 0a b1 ff       	call   0xffb10ae9
  15:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 01 01 00 00    	jne    0x135
  34:	48 8b 6b 08          	mov    0x8(%rbx),%rbp
  38:	31 ff                	xor    %edi,%edi
  3a:	83 e5 01             	and    $0x1,%ebp
  3d:	48 89 ee             	mov    %rbp,%rsi


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

