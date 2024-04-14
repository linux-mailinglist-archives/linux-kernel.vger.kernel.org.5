Return-Path: <linux-kernel+bounces-143946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13098A3FF6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A849C1C210AB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7FB168B8;
	Sun, 14 Apr 2024 02:59:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DFE2F32
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063570; cv=none; b=p/VIaZhO0S5TDQHdiMtClZ6ozA6OsoMNh/NAsk0f3H5q+ScbjTOqK6JRL1rh8EjfE5jSbsgfyf86VIOqjYfiSckqVlgkVt15qw9TY2oVO/69vcGsqukHcfXYtrM/2eoKWOgw4E+Wh6gRr9VhDOpqvjSQ7dZUJ+MQkaSOqL7PQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063570; c=relaxed/simple;
	bh=AE7ZJWNXV/MCO3rMxYd72/2rSEf9+jhoUWyebNuWQPo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P+sR16bujJHDdqn7bsW/GCppYuYVLFLIhCLAppuAM3nkyMBHQdueoclw0+DduMlZU0w7EuZ0WqpELUG/sBCyK905Um6RlU4AnxYwVnlBLaY7r+6fEbZ2sA3PT7gE+bcFGorUaySYReEtaYRHzVJ0hlOi48GHtIxCzd7beYcIe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b0566ab2cso24345485ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713063568; x=1713668368;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRv9ZZeoeVf2AJQDvrlgVkO/WDGkCJbxVjuTsvBx0zI=;
        b=ttTEoCwUoXMjq7svY6uoYKuxnWFwKFNsxUe7bR973/wdwF6gW+BpBMRwb2BUn/qFoh
         aFGqZowVm7HP2QrlVdHF8OgzTSsj2fgno8iLnZp3S8w6TTLJkk5Z6wnInBbQdm0xSzl8
         ENJSNFBWCXGKhMdV506eUnZ+xmRF4+NbPOl6R84IOfIUsbW7NgltpDUJChTnZ7wzigyA
         Rdvnxzw2TazLrcFxDeZfotW8Y5l8qLQEGT9Ce5NVKn3ftaVJpq40ctZsUZaQvHQojEHP
         kFE/4Slmt/NiixauDm2mroLkwiAOrJctLwoKXOPRypQap2LhONSiMyyVy7OUTV0Kgpxa
         Ooqw==
X-Forwarded-Encrypted: i=1; AJvYcCX/73v1urVlRgiCXIrVoReRWsrfpi/eEJWSBYNnp9/R4bb2QuTUkbSvbgRLctChjNrb+mJJfFv8+r+K04z6nAjVmfs6+R/aqnNGVIx/
X-Gm-Message-State: AOJu0YwQJsTKVgZlc34HroQxaI895cFlKOMY2+2IVmkuvE32G0lhclwa
	0pdVdeV+WDt9TMXz9P42vtqkV8SnnWvaGTv0kkzv7giE9kBarIL60dlPaEHyFhjWSAuRkoz54xs
	U4Se/cFkTu+MeEG4ySXZWKmIaHLwIXGfxBf9IJ6B0GS6bNaj107Lj/vo=
X-Google-Smtp-Source: AGHT+IEKXLwWPB9AQtKr/tF9WSBGHkclIh0Cz3oJefQJGKhBhSQFTLZkeYCPJDEhKHWf8metHFtvjnJuoFQ0Z37LvqJNEjYkA/v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2195:b0:369:f7ca:a359 with SMTP id
 j21-20020a056e02219500b00369f7caa359mr544147ila.0.1713063567936; Sat, 13 Apr
 2024 19:59:27 -0700 (PDT)
Date: Sat, 13 Apr 2024 19:59:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071dfbd061605b1bd@google.com>
Subject: [syzbot] [arm?] BUG: unable to handle kernel paging request in huge_pte_alloc
From: syzbot <syzbot+8b093786303cd0c2041d@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c71fdf02a95 Merge tag 'drm-fixes-2024-04-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b397ad180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b59c588989b5f9a
dashboard link: https://syzkaller.appspot.com/bug?extid=8b093786303cd0c2041d
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f55d29180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a32e75180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-2c71fdf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/627c4a5b3fcb/vmlinux-2c71fdf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39628cd13511/Image-2c71fdf0.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b093786303cd0c2041d@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address ffffffffc0000000
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
swapper pgtable: 4k pages, 52-bit VAs, pgdp=00000000425f4000
[ffffffffc0000000] pgd=1000000042ac9003, p4d=00000000429e0003, pud=00000000429e1003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3176 Comm: syz-executor300 Not tainted 6.9.0-rc3-syzkaller-00023-g2c71fdf02a95 #0
Hardware name: linux,dummy-virt (DT)
pstate: 01400009 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : pud_alloc include/linux/mm.h:2819 [inline]
pc : huge_pte_alloc+0xd4/0x358 arch/arm64/mm/hugetlbpage.c:280
lr : copy_hugetlb_page_range+0x108/0x924 mm/hugetlb.c:5423
sp : ffff8000890e3810
x29: ffff8000890e3810 x28: ffff80008283c358 x27: fcf0000005e14980
x26: 0000000000000000 x25: fbf0000005e15300 x24: f8f0000006360780
x23: f8f0000006360780 x22: fcf0000005e14980 x21: 0000000021000000
x20: 0000000020400000 x19: ffffffffc0000000 x18: ffff8000890e3ba8
x17: 0000000000000000 x16: 1ede000000c4c181 x15: 0000000000000001
x14: ffffffffffffffff x13: 0000000000000000 x12: ffff8000890e3ac8
x11: 0000000020400000 x10: ffff8000890e3ba8 x9 : 0000000020400000
x8 : 0000000000000000 x7 : 0000000000000102 x6 : 0000000040000000
x5 : 0000000000000000 x4 : ffffffffc0000000 x3 : 0000000000200000
x2 : f3f0000005f34f80 x1 : 0000000000000000 x0 : 0000000040000000
Call trace:
 p4d_offset_lockless arch/arm64/include/asm/pgtable.h:965 [inline]
 p4d_offset arch/arm64/include/asm/pgtable.h:971 [inline]
 huge_pte_alloc+0xd4/0x358 arch/arm64/mm/hugetlbpage.c:279
 copy_hugetlb_page_range+0x108/0x924 mm/hugetlb.c:5423
 copy_page_range+0x1a0c/0x1a58 mm/memory.c:1355
 dup_mmap kernel/fork.c:747 [inline]
 dup_mm kernel/fork.c:1687 [inline]
 copy_mm+0x62c/0x7ac kernel/fork.c:1736
 copy_process+0xc30/0x1484 kernel/fork.c:2389
 kernel_clone+0x64/0x360 kernel/fork.c:2796
 __do_sys_clone+0x70/0xa8 kernel/fork.c:2939
 __se_sys_clone kernel/fork.c:2907 [inline]
 __arm64_sys_clone+0x20/0x2c kernel/fork.c:2907
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: aa010084 cb000084 b24c2c84 8b130c93 (f9400260) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa010084 	orr	x4, x4, x1
   4:	cb000084 	sub	x4, x4, x0
   8:	b24c2c84 	orr	x4, x4, #0xfff0000000000000
   c:	8b130c93 	add	x19, x4, x19, lsl #3
* 10:	f9400260 	ldr	x0, [x19] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

