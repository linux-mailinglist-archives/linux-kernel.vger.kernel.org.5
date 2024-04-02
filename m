Return-Path: <linux-kernel+bounces-127400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50209894AD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D187283627
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F0A18050;
	Tue,  2 Apr 2024 05:19:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170F17BC9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712035168; cv=none; b=Tdcc3773is7vrRF2h0TELWdxjcMiSFb+LJmNIj3HZeQXzMBD1sx6gQUmsFfjTgSHTwJ9NMhVCGme41PnEatMyA1KhiYegcTWe8Xqhy8XeBz1TmZE3fZcPOmWPuNDnIN+jJscFrT+2HYgqWbnRvKV4LMst8LwqnkiSnI0XovhwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712035168; c=relaxed/simple;
	bh=ltBcefWB5lZ2hKU8isJ+zF+0nJIEVyijbIRuYf2f+B8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mcIWkiIV49NyO367kyl6vR1C/j85MOODjcsTS5LOOfvpH98RRO7Z6j3ps0bvYSlsjbMkzdj+FiyhXMi5JdNEVA/jdhm5R78deNU31G1gjTGSPzLnN2f+/QOXP1fgmDegPJwMxYVvoXiuvM0adO1pBcYWRWZJOTHnzNPL2K8SLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso385905039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 22:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712035166; x=1712639966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYVVXxXxwvwLBoFTWIsBcqq+uv4/UNSrobzSgSgvS04=;
        b=ig1AsH4g8wF3kT9UGWFJW1Buw7xp3kxch4f28zlhMOHdEAr0BMJVnb4Y8lthfDH1R9
         sE4Yw9Pgrv04e9A11RMfopi5of7pW7jPbjJOwYoPd3SmKp20QYwoCUuPDYA4KWKYI6iX
         3yINkvz11VRzBzv6x0zmWt22pPcNGyXrzvI9k5ZC1qOeWkkW4Sk4SkU43yTiGTqlgFYJ
         nFk6bpe2ZwO9SOBCqZME8icqmIfW9vhGr5nnDJ2htZkr4cuvN1QgfmXYBYQmENN0Pk+x
         GahIrWbk+1cDBP+AY9w2puW2e1PkDfd91qYmK1LvQSkpGRPzWhHNm9dD1RrXu/76XNig
         0WZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdfCc9HG/QQVjWACn/deszlFauWLfzr9lfhOTaWwJryjL0ehs+k7CSi7lLGBfu0uoUygUC+3W/5hnlGL1jT0pwbPDZG/oxmlwhcHp6
X-Gm-Message-State: AOJu0YwtrtqcNF5NMN03htQEQawjyE6JB9OH04YrrW5bzF/YxOMpDFkc
	l8qY113WzcnrPk73CWdyCOmlwHvnwO9ohvvcPpJK5hfbaK56VW5xri+2lmRCZcwWzEimCozVIe2
	UPTTELQR8CWjavzl1Y2q5H7TccZParCl4OUjBfHMVFm3ofrl9e6R6hpQ=
X-Google-Smtp-Source: AGHT+IHLQYkgWrBAbHKxWaZCU4/H+RHRbGyYps2YbpiYUvStM7h5dddUvZdb0bL0WVbotDYYteytcoeK7GMxNzJrIMJtjQYJ2WSX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3790:b0:47f:9ab:1fa6 with SMTP id
 w16-20020a056638379000b0047f09ab1fa6mr54666jal.3.1712035166000; Mon, 01 Apr
 2024 22:19:26 -0700 (PDT)
Date: Mon, 01 Apr 2024 22:19:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9a8d80615163f2a@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in
 copy_from_kernel_nofault (2)
From: syzbot <syzbot+186522670e6722692d86@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    317c7bc0ef03 Merge tag 'mmc-v6.9-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1060bd41180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43f1e0cbdb852271
dashboard link: https://syzkaller.appspot.com/bug?extid=186522670e6722692d86
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15751129180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10136341180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-317c7bc0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49458dc4ddf2/vmlinux-317c7bc0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/031f516e5544/zImage-317c7bc0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+186522670e6722692d86@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel paging request at virtual address ffffffe9 when write
[ffffffe9] *pgd=80000080007003, *pmd=deffd003, *pte=00000000
Internal error: Oops: a07 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 3001 Comm: syz-executor291 Not tainted 6.9.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at copy_from_kernel_nofault mm/maccess.c:38 [inline]
PC is at copy_from_kernel_nofault+0xb8/0x12c mm/maccess.c:24
LR is at copy_from_kernel_nofault+0x24/0x12c mm/maccess.c:31
pc : [<804361f0>]    lr : [<8043615c>]    psr: a0000013
sp : df96dc90  ip : df96dc90  fp : df96dcac
r10: 00000000  r9 : df96dd40  r8 : ffffffe9
r7 : 83d33c00  r6 : 00000005  r5 : ffffffe9  r4 : ffffffe9
r3 : fffffff2  r2 : 00000000  r1 : 00000005  r0 : 00000001
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 8434d080  DAC: 00000000
Register r0 information: non-paged memory
Register r1 information: non-paged memory
Register r2 information: NULL pointer
Register r3 information: non-paged memory
Register r4 information: non-paged memory
Register r5 information: non-paged memory
Register r6 information: non-paged memory
Register r7 information: slab task_struct start 83d33c00 pointer offset 0 size 3072
Register r8 information: non-paged memory
Register r9 information: 2-page vmalloc region starting at 0xdf96c000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Register r10 information: NULL pointer
Register r11 information: 2-page vmalloc region starting at 0xdf96c000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Register r12 information: 2-page vmalloc region starting at 0xdf96c000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Process syz-executor291 (pid: 3001, stack limit = 0xdf96c000)
Stack: (0xdf96dc90 to 0xdf96e000)
dc80:                                     df96ddb8 ffffffe9 00000005 ffffffff
dca0: df96dccc df96dcb0 8037c428 80436144 df96ddb8 00000000 8037c40c ffffffff
dcc0: df96dd64 df96dcd0 7f011aa0 8037c418 ffffffe9 df96dd40 802ff648 81182b54
dce0: df96dd64 df96dd30 35702575 00000000 828c0a94 40000013 00000000 00000000
dd00: df96dcf0 00000000 df96dd74 df96dd18 df96dd2c df96dd20 81182b64 81898a78
dd20: df96dd64 df96dd30 802ff648 81182b54 ffffffe9 df96dd40 00000005 00000000
dd40: df96ddb8 00000000 df969000 842879c0 df969030 df96de30 df96ddfc df96dd68
dd60: 8149c734 7f011a00 804d0184 8089c164 00000000 83d33c00 804b4cdc 804d0124
dd80: 8260ca3c df96de30 00000001 df96de2c 80468494 00000000 df96ddb8 00000000
dda0: 00000001 00000000 19df2b20 00000014 00000000 00000000 df969000 00000000
ddc0: 00000000 00000000 84497800 f655f23e df96ddfc 842879c0 00000000 df96dec0
dde0: 83f79c00 84497800 00000000 0000000e df96de64 df96de00 8149d6a0 8149c5d0
de00: df96de30 00000000 00000000 df96de98 20000080 00000000 df969000 00000000
de20: 828ffe80 82fe0000 8051cdd4 00000000 00000000 f655f23e 80395130 df969000
de40: 00000028 df96de98 0000000a 20000080 00000028 00000000 df96df8c df96de68
de60: 8039c858 8149d388 81c66394 84342c0c fcd9275f 00a00000 20000000 83d33c00
de80: df96dee0 df96dfb0 df96dea4 df96de98 8089c348 df96dee0 20000080 00000000
dea0: 83d33c00 df96ded0 00000008 00000000 00000008 80426e10 df96deec df96dec8
dec0: 00000003 02000000 0000000e 00000055 20000140 00000000 20000380 00000000
dee0: 00000000 04000000 00000000 00000000 00000000 00000000 00000000 00000000
df00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
df20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
df40: 00000000 00000000 00000000 00000000 00000000 00000000 20000000 f655f23e
df60: 80216078 ffffffff 00000000 0008e050 00000182 80200288 83d33c00 00000182
df80: df96dfa4 df96df90 8039dd98 8039b934 20000080 00000000 00000000 df96dfa8
dfa0: 80200060 8039dd78 ffffffff 00000000 0000000a 20000080 00000028 00000000
dfc0: ffffffff 00000000 0008e050 00000182 20000100 00000000 00000001 00003a97
dfe0: 7ec66c70 7ec66c60 00010748 0002e890 00000010 0000000a 00000000 00000000
Call trace: 
[<80436138>] (copy_from_kernel_nofault) from [<8037c428>] (bpf_probe_read_kernel_common include/linux/bpf.h:2909 [inline])
[<80436138>] (copy_from_kernel_nofault) from [<8037c428>] (____bpf_probe_read_kernel kernel/trace/bpf_trace.c:240 [inline])
[<80436138>] (copy_from_kernel_nofault) from [<8037c428>] (bpf_probe_read_kernel+0x1c/0x44 kernel/trace/bpf_trace.c:237)
 r7:ffffffff r6:00000005 r5:ffffffe9 r4:df96ddb8
[<8037c40c>] (bpf_probe_read_kernel) from [<7f011aa0>] (bpf_prog_244768d4818575ac+0xac/0xc0)
 r7:ffffffff r6:8037c40c r5:00000000 r4:df96ddb8
[<7f0119f4>] (bpf_prog_244768d4818575ac) from [<8149c734>] (bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline])
[<7f0119f4>] (bpf_prog_244768d4818575ac) from [<8149c734>] (__bpf_prog_run include/linux/filter.h:657 [inline])
[<7f0119f4>] (bpf_prog_244768d4818575ac) from [<8149c734>] (bpf_prog_run include/linux/filter.h:664 [inline])
[<7f0119f4>] (bpf_prog_244768d4818575ac) from [<8149c734>] (bpf_test_run+0x170/0x388 net/bpf/test_run.c:425)
 r9:df96de30 r8:df969030 r7:842879c0 r6:df969000 r5:00000000 r4:df96ddb8
[<8149c5c4>] (bpf_test_run) from [<8149d6a0>] (bpf_prog_test_run_skb+0x324/0x6cc net/bpf/test_run.c:1058)
 r10:0000000e r9:00000000 r8:84497800 r7:83f79c00 r6:df96dec0 r5:00000000
 r4:842879c0
[<8149d37c>] (bpf_prog_test_run_skb) from [<8039c858>] (bpf_prog_test_run kernel/bpf/syscall.c:4240 [inline])
[<8149d37c>] (bpf_prog_test_run_skb) from [<8039c858>] (__sys_bpf+0xf30/0x1ef0 kernel/bpf/syscall.c:5649)
 r10:00000000 r9:00000028 r8:20000080 r7:0000000a r6:df96de98 r5:00000028
 r4:df969000
[<8039b928>] (__sys_bpf) from [<8039dd98>] (__do_sys_bpf kernel/bpf/syscall.c:5738 [inline])
[<8039b928>] (__sys_bpf) from [<8039dd98>] (sys_bpf+0x2c/0x48 kernel/bpf/syscall.c:5736)
 r10:00000182 r9:83d33c00 r8:80200288 r7:00000182 r6:0008e050 r5:00000000
 r4:ffffffff
[<8039dd6c>] (sys_bpf) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdf96dfa8 to 0xdf96dff0)
dfa0:                   ffffffff 00000000 0000000a 20000080 00000028 00000000
dfc0: ffffffff 00000000 0008e050 00000182 20000100 00000000 00000001 00003a97
dfe0: 7ec66c70 7ec66c60 00010748 0002e890
Code: 9a000007 e3a03000 e4942000 e3530000 (e5852000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	9a000007 	bls	0x24
   4:	e3a03000 	mov	r3, #0
   8:	e4942000 	ldr	r2, [r4], #0
   c:	e3530000 	cmp	r3, #0
* 10:	e5852000 	str	r2, [r5] <-- trapping instruction


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

