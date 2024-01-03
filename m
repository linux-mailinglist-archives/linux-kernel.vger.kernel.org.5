Return-Path: <linux-kernel+bounces-15463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F524822C53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C851F230CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C0918E39;
	Wed,  3 Jan 2024 11:48:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CFB18E2D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fffb6fe5bso100707665ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 03:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704282500; x=1704887300;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiYP0qmV7EZ9B/nozhEJs3FbdPkxLeJC66aTZdOq1o4=;
        b=CbJD7MdSCFC/A8Gs0f2NeX4q2f6n9awFOKC3kgvSo8GkUArHi8HrOwqQPeM2PRcvpB
         MW5enrMvrPt3SCOXtd4nfG8YMyD/tqrwo9PyvgAysa80kFrTXwv/polskldw6fN/wWWX
         DsG6/7mJifMY3EOhfMf3HaS+ZXRRAEjkzUPKRQBXEC4fYi0h4b9+EKY/Nb+Rlp86xOVA
         gO+dp2l+OE7OkFmGp+jNe07gcH0gfF823xjMIiwhqz313ApZEatoIVcxeQ/UyJf2tTvG
         vocR35MWOY5poyRuLmkwoLmGMbzfMn0QNE3udtm6aqNzaut+oWnmFFdjmvqS57tqlhAo
         JMWg==
X-Gm-Message-State: AOJu0YxAB7Z7CWnn+fgD/q9mBJDSPgD4hZN4uBR4QExTiCogJwI7dElt
	7KtN89lVkCb9DbQYG0QOq42tvTwy4puEJsRYMsnHe/E0JFns
X-Google-Smtp-Source: AGHT+IFGSaoK0mRIGFc3vQHzS/iiXmS6RJk96OadXMTve9CHcgldGx6XIsvCiAXbz6PiQqUkPZtWhGoq8yeCmZ9FeIuK6uY3fVLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54d:0:b0:360:29f:b7b2 with SMTP id
 a13-20020a92c54d000000b00360029fb7b2mr2495267ilj.1.1704282499922; Wed, 03 Jan
 2024 03:48:19 -0800 (PST)
Date: Wed, 03 Jan 2024 03:48:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000014174060e09316e@google.com>
Subject: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
From: syzbot <syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, fengwei.yin@intel.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab0b3e6ef50d Add linux-next specific files for 20240102
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17be3e09e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a14a6350374945f9
dashboard link: https://syzkaller.appspot.com/bug?extid=50ef73537bbc393a25bb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e2256ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b57db5e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4e6376fe5764/disk-ab0b3e6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7cb9ecbaf001/vmlinux-ab0b3e6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c1a9a6d424f/bzImage-ab0b3e6e.xz

The issue was bisected to:

commit 68f0320824fa59c5429cbc811e6c46e7a30ea32c
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Dec 20 22:44:31 2023 +0000

    mm/rmap: convert folio_add_file_rmap_range() into folio_add_file_rmap_[pte|ptes|pmd]()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b9e1b1e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b9e1b1e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b9e1b1e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com
Fixes: 68f0320824fa ("mm/rmap: convert folio_add_file_rmap_range() into folio_add_file_rmap_[pte|ptes|pmd]()")

 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
 vm_area_alloc+0x1f/0x220 kernel/fork.c:465
 mmap_region+0x3ae/0x2a90 mm/mmap.c:2804
 do_mmap+0x890/0xef0 mm/mmap.c:1379
 vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
 ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5059 at include/linux/rmap.h:202 __folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
Modules linked in:
CPU: 1 PID: 5059 Comm: syz-executor115 Not tainted 6.7.0-rc8-next-20240102-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:__folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
Code: 41 83 e4 01 44 89 e6 e8 79 bc b7 ff 45 84 e4 0f 85 08 fc ff ff e8 3b c1 b7 ff 48 c7 c6 e0 b5 d9 8a 48 89 df e8 5c 12 f7 ff 90 <0f> 0b 90 e9 eb fb ff ff e8 1e c1 b7 ff be 01 00 00 00 48 89 df e8
RSP: 0018:ffffc900038df978 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea00008cde00 RCX: ffffffff81687419
RDX: ffff88807becbb80 RSI: ffffffff81d06104 RDI: 0000000000000000
RBP: ffffea00008cde00 R08: 0000000000000000 R09: fffffbfff1e75f6a
R10: ffffffff8f3afb57 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555556508380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c0 CR3: 0000000079000000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __folio_add_rmap mm/rmap.c:1167 [inline]
 __folio_add_file_rmap mm/rmap.c:1452 [inline]
 folio_add_file_rmap_ptes+0x8e/0x2c0 mm/rmap.c:1478
 insert_page_into_pte_locked.isra.0+0x34d/0x960 mm/memory.c:1874
 insert_page mm/memory.c:1900 [inline]
 vm_insert_page+0x62c/0x8c0 mm/memory.c:2053
 packet_mmap+0x314/0x570 net/packet/af_packet.c:4594
 call_mmap include/linux/fs.h:2090 [inline]
 mmap_region+0x745/0x2a90 mm/mmap.c:2819
 do_mmap+0x890/0xef0 mm/mmap.c:1379
 vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
 ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7ff89df16329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcbc3eb618 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffcbc3eb7f8 RCX: 00007ff89df16329
RDX: 0000000000000000 RSI: 0000000001000000 RDI: 0000000020568000
RBP: 00007ff89df89610 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcbc3eb7e8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

