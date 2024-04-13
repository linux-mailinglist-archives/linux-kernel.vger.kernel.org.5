Return-Path: <linux-kernel+bounces-143637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A18A3BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566E6282EBC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D705208B6;
	Sat, 13 Apr 2024 08:53:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD3366
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712998408; cv=none; b=L2a+2jhlgvL2DTO5rnMpWDdJMTodAn63rwW7CojvnQDJkVIMAQddQP/MPePzlhEWF3zjq5GAlWkU+x3Fu/SeZSr4v11gL9XqmyI3bSlwprJ/NFoq+RKM6Le8Bo+BveNK/JCTYjwXMQ0hi1K4/LZVsmiQsp9qwYqfrxtKFMTe4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712998408; c=relaxed/simple;
	bh=q1f+qIenTjU87HvgrTci/0lO/OmQUYZp0C3XI44taKU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ntNMdVvePMHSOqJFYKVvMv6YgrEiGBRzgjWSXfPhDOd5RIsA97nrLvpd2COm8hBDv2D2Ge+AXL3Ro/Bb3mJDYavPApXfgw4LxaIutWqfoRzMqanvmbbaoHvZJGXVz7p8Lp+XebzoN9fZj/CutRRA2g8fn6MWVMUBhYGfYx5MCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a25ad3ac4so18047765ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 01:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712998405; x=1713603205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWUTFpUC6BmICZ9mi19Jleu67VjpzL72heJuzJK4nhM=;
        b=g28t9dyQWgApkmAB1b6PDDaYSbDd4NemOxh5iKX6iNEtWa3nyRYa3wUfmyHM/Sh3bO
         oAZ+k9mwtwjSTTNa4xsFtnA82ODAhSOdJ24hIxWPkEAKiwaFOXRWYcuWa8PPOD9/0vm2
         GvKKXGsfneL8TlUEP5Dj2i83FP0NtvlkaKKK32qME1ev1pFTq/xTr14NBtgpMQJclauG
         xctdhNzcuwZvEbZUyMEw4V4uO3uOkZiIdJjOy5OdS+xG8Qu1rZfs6EJitOXA7U/DXV9a
         v3Pj8NmAUlUm2FdvtptxYZQo+fOKkKCqfihddNsiIN0h2QdsUMOKJsKAdwgjw646bmDj
         P3qw==
X-Forwarded-Encrypted: i=1; AJvYcCXF1xGQIqmI+K+hW8EThbplkVWCih96BiSXhQVAzk+jR8GNUFq8gYPlCXkzRj41qUEpZYKZInMPsdEUuuJIQJOMb7mQPnW7gTkl9lpk
X-Gm-Message-State: AOJu0YzgYyP0I7Jo3dJDaQ+ZHhN53aM7fD4bOpyhtMGHY0uSJOlxD0bd
	KE0Cmo4e70/wDVYlb8xsK1LyTFcwzKwsTKF+kMUUJI0pWzGI46exKt/b7EgVjMzrYdWz0+J/bNR
	Iv9fUIJT0jC6kSJaca2dzimlS3KP4fkeWU1A5m2k3Q6ddT2cMiRtlMVw=
X-Google-Smtp-Source: AGHT+IEGBowWjKOjUooEKDb1b8oNk5hXHh9OD1BRWNtS6omSxghUG49uJIUymKgtNbzHP+tnyUH67jxgH5ftGYYPPz1u9QNx9fAK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d11:b0:36a:3ee8:b9f9 with SMTP id
 i17-20020a056e021d1100b0036a3ee8b9f9mr396626ila.2.1712998405474; Sat, 13 Apr
 2024 01:53:25 -0700 (PDT)
Date: Sat, 13 Apr 2024 01:53:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000759c060615f685b3@google.com>
Subject: [syzbot] [arm?] BUG: unable to handle kernel paging request in trans_pgd_create_copy
From: syzbot <syzbot+2d1f5a94167d430a3bd7@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c71fdf02a95 Merge tag 'drm-fixes-2024-04-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13400033180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b59c588989b5f9a
dashboard link: https://syzkaller.appspot.com/bug?extid=2d1f5a94167d430a3bd7
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a303d3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128de44d180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-2c71fdf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/627c4a5b3fcb/vmlinux-2c71fdf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39628cd13511/Image-2c71fdf0.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d1f5a94167d430a3bd7@syzkaller.appspotmail.com

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
CPU: 1 PID: 3174 Comm: syz-executor195 Not tainted 6.9.0-rc3-syzkaller-00023-g2c71fdf02a95 #0
Hardware name: linux,dummy-virt (DT)
pstate: 81400009 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : copy_pud arch/arm64/mm/trans_pgd.c:127 [inline]
pc : copy_p4d arch/arm64/mm/trans_pgd.c:169 [inline]
pc : copy_page_tables arch/arm64/mm/trans_pgd.c:188 [inline]
pc : trans_pgd_create_copy+0x164/0x864 arch/arm64/mm/trans_pgd.c:215
lr : trans_alloc arch/arm64/mm/trans_pgd.c:31 [inline]
lr : trans_pgd_create_copy+0x2c/0x864 arch/arm64/mm/trans_pgd.c:208
sp : ffff8000893b3c30
x29: ffff8000893b3c30 x28: f9f00000058e9200 x27: fff0000000000000
x26: fff1000000000000 x25: fff0008000000000 x24: fff0000000000000
x23: ffff800000000000 x22: ffffffffc0000000 x21: fff000007fdff000
x20: ffff8000893b3d68 x19: ffffffffc0000000 x18: 0000000000000001
x17: ffff800080171268 x16: ffff800080170f48 x15: ffff80008016f800
x14: 0000000000000002 x13: 0000000000000000 x12: 0000000000072170
x11: 000000000003cd0d x10: 0000000000000001 x9 : 0000000000000000
x8 : f1f0000007ef9000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 1000000000000000
x2 : 00000000bfdff000 x1 : fff0ffffffffffff x0 : 18000000bfdfe003
Call trace:
 copy_p4d arch/arm64/mm/trans_pgd.c:167 [inline]
 copy_page_tables arch/arm64/mm/trans_pgd.c:188 [inline]
 trans_pgd_create_copy+0x164/0x864 arch/arm64/mm/trans_pgd.c:215
 machine_kexec_post_load+0xa4/0x2c0 arch/arm64/kernel/machine_kexec.c:135
 do_kexec_load+0x28c/0x2e4 kernel/kexec.c:162
 __do_sys_kexec_load kernel/kexec.c:261 [inline]
 __se_sys_kexec_load kernel/kexec.c:242 [inline]
 __arm64_sys_kexec_load+0x9c/0xe8 kernel/kexec.c:242
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: eb01001f f94002a0 54fff9a2 b4002380 (f94002c0) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	eb01001f 	cmp	x0, x1
   4:	f94002a0 	ldr	x0, [x21]
   8:	54fff9a2 	b.cs	0xffffffffffffff3c  // b.hs, b.nlast
   c:	b4002380 	cbz	x0, 0x47c
* 10:	f94002c0 	ldr	x0, [x22] <-- trapping instruction


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

