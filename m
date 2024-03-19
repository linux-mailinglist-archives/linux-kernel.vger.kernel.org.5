Return-Path: <linux-kernel+bounces-108227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3DB880813
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612D91C2252E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1145EE67;
	Tue, 19 Mar 2024 23:13:19 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CBB4F889
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889999; cv=none; b=Dmd64y3x6FrgDieCyd0ce5xN9ji5L/W+iV03U0uaU3RmAt0Xqu/ZSZQWqwCnXYqgVN4MbIUEoYqhitPif/p+/2LWFimoVqOR1o/yjJsDol+b7MU+EDQh/NqJz0tkKdK35cNesDsyiguoXqbBkBc47UtuY2DbAAzLPvtnOnlqPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889999; c=relaxed/simple;
	bh=ywBYzBrkUhBsN9VB1sz/IcoiP+lgQFciVYNoPMWclOU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PN/zRrc7ILuWrkkJdF0BjFFXWj/ARYf3pjryfG7KHzo8FnQti6OGozhSjlulNlXC/S4UVt+aA3nq3vvqU+7vB+hJnVHNWVu0GHrr4ZA/8volaR6GhI6ILo0FV5t+EFcSzBecMIvAlk1q9SkrUlWUEGoPA236B40jwTxzMS+5hGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc0370e9b0so433031039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889996; x=1711494796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNwq2yvmuLqPxZhfo+md7mufJiXYN4G9OrLBY7Pb9kE=;
        b=N10ASma6HOft66BRzPL8VgM5mThlm4IKCumG6Jhn2nBW1wqaJVhfv2dC9bEsY1WtEZ
         lrDNU63QBcv+HkoiREcWOp5XKOi6+xn5mn1HDbcqUqBBGHJmDoypONR20QjdXRcEyMfE
         LsqG7QX6V+jN7p4Hyz1uoodmgt5as9eictTD7bFXze91Ej4RqzBJ7Rpvz3tIyTffHDpJ
         z5hkuyBrNEcERI7Hr5UPOofh0UH5cVM3MGwMTYa0CV50Of5JreSZQ0R80caTIZmTwygu
         i3Fl2qf/8Dm0AlzRouRl/xw0czxPRVTnLmp61PV+/vV21dBHwRckUhgd5tTMZu0PWYLx
         3/qg==
X-Forwarded-Encrypted: i=1; AJvYcCVryenmSrji6TCtin42vPpDIKalpSMCDXyNylpCklmBKulU/0TkLai0eyPgI1/d7MEfK6/u4EGAQ8i+Vrpwq369Qe/rq9RiLR2bveyO
X-Gm-Message-State: AOJu0YxINc6kCpL5OFZeUt63gaY4v5UM2emNcSaNR3H1NiCNJOi/6GGK
	B8Mg8tdQbLvy3G10Z45Xy49SQV1rwN/YFqymDpsTT+ac40Tyw0WmE66vy6zeTRqSj1xm9bJlgtL
	8xZh80UARp2HTNRbKm1TwFQh0FLlQoihlcu0BL6Wj7BRFruESFW9GFLs=
X-Google-Smtp-Source: AGHT+IHtJF3RCy7b6rMglGfuOs7QYrk3r4tjEkafAIQ5+oM8e0YxazwW93+EplzfZl002uGHQgTcqOf5ElnQTZEapTEFwy4Z986t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2043:b0:476:e7e9:7528 with SMTP id
 t3-20020a056638204300b00476e7e97528mr205980jaj.4.1710889996694; Tue, 19 Mar
 2024 16:13:16 -0700 (PDT)
Date: Tue, 19 Mar 2024 16:13:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080c82706140b9e5d@google.com>
Subject: [syzbot] [mm?] upstream test error: WARNING: refcount bug in __reset_page_owner
From: syzbot <syzbot+ed0599ef4b473503bc7f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b3603fcb79b1 Merge tag 'dlm-6.9' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1592fc6e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31004b74814b38f5
dashboard link: https://syzkaller.appspot.com/bug?extid=ed0599ef4b473503bc7f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b3603fcb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca4b48e6ac47/vmlinux-b3603fcb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8132c089f924/bzImage-b3603fcb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed0599ef4b473503bc7f@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 0 PID: 5185 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Modules linked in:
CPU: 0 PID: 5185 Comm: syz-fuzzer Not tainted 6.8.0-syzkaller-11567-gb3603fcb79b1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Code: 8b e8 67 58 d5 fc 90 0f 0b 90 90 e9 c3 fe ff ff e8 f8 7f 12 fd c6 05 f2 f0 0c 0b 01 90 48 c7 c7 40 a6 6e 8b e8 44 58 d5 fc 90 <0f> 0b 90 90 e9 a0 fe ff ff 48 89 ef e8 c2 f2 6e fd e9 44 fe ff ff
RSP: 0018:ffffc90003eaf570 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8150eb39
RDX: ffff8880202a0000 RSI: ffffffff8150eb46 RDI: 0000000000000001
RBP: ffff88801e884acc R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88801e884acc
R13: 0000000000000000 R14: 00000000015601ea R15: ffff88801587b4d8
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000955000 CR3: 000000000d57a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 dec_stack_record_count mm/page_owner.c:215 [inline]
 __reset_page_owner+0x2ea/0x370 mm/page_owner.c:253
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_folios+0x256/0xad0 mm/page_alloc.c:2536
 folios_put_refs+0x49c/0x750 mm/swap.c:1034
 free_pages_and_swap_cache+0x25b/0x4b0 mm/swap_state.c:329
 __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
 exit_mmap+0x3da/0xb90 mm/mmap.c:3280
 __mmput+0x12a/0x4d0 kernel/fork.c:1345
 mmput+0x62/0x70 kernel/fork.c:1367
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x999/0x2c10 kernel/exit.c:865
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 get_signal+0x25c3/0x2670 kernel/signal.c:2911
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x14a/0x2a0 kernel/entry/common.c:212
 do_syscall_64+0xe2/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x46dfbd
Code: Unable to access opcode bytes at 0x46df93.
RSP: 002b:00007ffe04a96580 EFLAGS: 00000206 ORIG_RAX: 0000000000000023
RAX: 0000000000000000 RBX: 000000c000040198 RCX: 000000000046dfbd
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffe04a96580
RBP: 00007ffe04a96590 R08: 0000000000000000 R09: 000000000000000a
R10: a0761d6478bd642f R11: 0000000000000206 R12: 000000c000040000
R13: 0000000000000002 R14: 0000000002419dc0 R15: 0000000000000000
 </TASK>


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

