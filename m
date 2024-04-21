Return-Path: <linux-kernel+bounces-152613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC168AC12D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1140F1C20809
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58943169;
	Sun, 21 Apr 2024 20:16:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF91C280
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713730587; cv=none; b=ifV3/Gj0d0E0sVeXLdSXHBJ/bxI12adi/OlhLu13GI5Yr+8aAmmlwRLiCOUjEfg5w0ltBMgyhXkiNGSkxmGDDG0sQ0QxF3+0C5wycwOAtPFC5JIvqFH5WVuSUP48rp3RanbtVSFOvFeT40S/g+ZZbr9fPPl1qorTipgVnTpnhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713730587; c=relaxed/simple;
	bh=IAMzr3jkf0anKfnmv4d+Iu5diI38hrPTzyhhBjGfgic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BH0sfKAJts8Q/6U3iaKAbBMFAyQOMQW8X3U1vgPL1jBjzDzkD3t+2n0k26tqo4u1hTj8dQ5fW0LdpF2Ea18SxIL5sHX7Qmu1IVhp2ggrfy21X2MN2ajRWVW3uJzCMO+lh3vOpGDsN9Ho2EusWDhVGCWCvryGQ0kyvcow6Sr5HsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dac7122659so21712839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 13:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713730585; x=1714335385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fd5CZmxUkwDmaWGHFeI5GNOvFM9wfzD6ylZzOmzqm2M=;
        b=v3HhPa37tymbmU6VGEr5K4T4O/3bIR0W0/T3o8OEvmIMjtqDHqn6Xl1KGk8hBRcSfM
         ec8wYeDXlvMW3piAcYZxD/NOLh6qMHILQ3sFFJ9GVkiBp0t2uJi3yToOkfar/gBbXOo5
         Qx7a+3aDgBV7uHEP0Ru5QJ/e9oLSBuenYUqMaOhRXYc40hq0eYtal3N+1iLsRnK10rQz
         f2EZgqxv+cz4MCars2LTp3DTw4xi9UkfKtO/wXSSPQkl3P+bo0TKqd1CYVN2LyddodE5
         se+L+kGjbJu9EXG8ny5qyirCwTvu7VSZW/8899T6GrcvLx5CxxCQqKm7AAuUq/i5kHDi
         GiDA==
X-Forwarded-Encrypted: i=1; AJvYcCXC9885ef6GBk8rGSCKOHyZA0CA2K5TJK0/E9+iYpRXL25WSNj3n31agy7jP2de6ymNi6b23ko35Fx1UeFzs0wdqhpzZn0MSDySwDC/
X-Gm-Message-State: AOJu0YwuYLrDYNVO1bMM+y1JvOc4XNy6v3dm03RKjUpgDP+7tl63Gwe6
	hlVKzQ+zNYH5BH2IrS/CgDlgxjcyHK74rfcK7HCTfBnMc1iUhWKLvPTKp6HqB3GC12N3U8ICETL
	o3gyAY3lHntcNz72T09c19UeV2iGXOblGyO49JwCoTIinZqdLMOvahVc=
X-Google-Smtp-Source: AGHT+IFw5TV0LG6fE4Fi/9Ce6C5oop9BiaNMExfF1Mby6t849bjg9jJB3eHESjDpYvs+F0YlMfIlUTqRs5pkdhPyyV/V4199nz03
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:874f:0:b0:7c8:264d:5e98 with SMTP id
 k15-20020a5d874f000000b007c8264d5e98mr149484iol.0.1713730585507; Sun, 21 Apr
 2024 13:16:25 -0700 (PDT)
Date: Sun, 21 Apr 2024 13:16:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca4df20616a0fe16@google.com>
Subject: [syzbot] [mm?] WARNING in __page_table_check_ptes_set
From: syzbot <syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4eab35893071 Add linux-next specific files for 20240417
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1727a61b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27920e47287645ff
dashboard link: https://syzkaller.appspot.com/bug?extid=d8426b591c36b21c750e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156da22d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163dfec7180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9f7d6c097fb4/disk-4eab3589.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/287b16352982/vmlinux-4eab3589.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23839c65c573/bzImage-4eab3589.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8426b591c36b21c750e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5084 at mm/page_table_check.c:199 __page_table_check_pte mm/page_table_check.c:199 [inline]
WARNING: CPU: 0 PID: 5084 at mm/page_table_check.c:199 __page_table_check_ptes_set+0x1db/0x420 mm/page_table_check.c:213
Modules linked in:
CPU: 0 PID: 5084 Comm: syz-executor382 Not tainted 6.9.0-rc4-next-20240417-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__page_table_check_pte mm/page_table_check.c:199 [inline]
RIP: 0010:__page_table_check_ptes_set+0x1db/0x420 mm/page_table_check.c:213
Code: 48 8b 7c 24 40 48 c7 c6 80 19 46 8e e8 ee df 8e ff 41 83 fc 1d 74 18 41 83 fc 1a 75 1d e8 5d da 8e ff eb 10 e8 56 da 8e ff 90 <0f> 0b 90 eb 10 e8 4b da 8e ff 90 0f 0b 90 eb 05 e8 40 da 8e ff 48
RSP: 0018:ffffc9000366f740 EFLAGS: 00010293
RAX: ffffffff8207833a RBX: ffffc9000366f7c0 RCX: ffff888022af3c00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc9000366f830 R08: ffffffff820782af R09: 1ffffd40000a6a10
R10: dffffc0000000000 R11: fffff940000a6a11 R12: 0000000000000000
R13: 0000000014d42c67 R14: 0000000000000001 R15: 0000000000000000
FS:  0000555567f79380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000078cb0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
 set_ptes include/linux/pgtable.h:267 [inline]
 __ptep_modify_prot_commit include/linux/pgtable.h:1269 [inline]
 ptep_modify_prot_commit include/linux/pgtable.h:1302 [inline]
 change_pte_range mm/mprotect.c:194 [inline]
 change_pmd_range mm/mprotect.c:424 [inline]
 change_pud_range mm/mprotect.c:457 [inline]
 change_p4d_range mm/mprotect.c:480 [inline]
 change_protection_range mm/mprotect.c:508 [inline]
 change_protection+0x2770/0x3cc0 mm/mprotect.c:542
 mprotect_fixup+0x740/0xa90 mm/mprotect.c:655
 do_mprotect_pkey+0x90d/0xe00 mm/mprotect.c:820
 __do_sys_mprotect mm/mprotect.c:841 [inline]
 __se_sys_mprotect mm/mprotect.c:838 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:838
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f45514bf429
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe52191598 EFLAGS: 00000246 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007ffe52191768 RCX: 00007f45514bf429
RDX: 000000000000000f RSI: 0000000000004000 RDI: 0000000020ffc000
RBP: 00007f4551532610 R08: 00007ffe52191768 R09: 00007ffe52191768
R10: 00007ffe52191768 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe52191758 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

