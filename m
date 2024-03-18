Return-Path: <linux-kernel+bounces-106410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F1087EE40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D471C21BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773C55E6F;
	Mon, 18 Mar 2024 16:58:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8654BED
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781103; cv=none; b=YBKrgt74dLlYR9HHbVa7aPvh6mMMa9sGxveuzWDhk7vu4Vtzhs/ycCydJS5kAhVwxo1zHz+NxKBwR1oqVBAzIMzjwbdzQyqp5wn33PYuKW/6iGJSlUQnnt4BWAPSHx/8ho1c3Mzx2vXpXGe7wI8niIdMIIJV8+ySNpB7UE87zGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781103; c=relaxed/simple;
	bh=UEnQQGwAnvQwXJXfkcII7uO1ulFA/1c6kGYeE9rHceI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s8nULLYKwdsjXdw0ruW+tJ8S940iMoFIa9beiRfhTCHN2ejSMJ3lzgZti9KfQMAcaGXDFkg9xxe5DFZ+yjFV+94BG3lqzPQDjxXVCXMR0LKWJZNEKR0KhdPnYZdEGDvbDssjSGW1FT6HCsSEX0TdYKdnCGvsbR/vQaiVzRjv/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbdcfcd458so363976639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781100; x=1711385900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QLmQWQJxnmhASwQJUaOzaBwTpLNQlm1tFC3bbIqh4M=;
        b=r7BbecmtU/bs+FaA9/zEifuC5Re9ya4iMvcn9SisViAauV8A1EyC3t9zyBvD7YN3ZW
         0MT9xNKXDO+eu3C+KGRTX30rNlXWjdaj6dAyY/vWQ5OR3CWpzs0aipv3QJZzL8FJGNZI
         V+wAzARhWnB2vBuIZp7TMHDbrhHOBEgTWjgQ8kKWQJSXCN9FEttG+qJ72s9t5Lkwck0W
         q4K8e1RMf7rpJ0ITZTeMcsyKhE0cBrAvHLCUm9MIuS/cTQjDpGdzFw89+vr52+XoYCB+
         wVml74fGxgNfaxNo6nRx05RWEsGcILm72z4ZigYNdkne/nBfFEdOilqmydpkaRfcsM/8
         OGaA==
X-Forwarded-Encrypted: i=1; AJvYcCXoaV8B8re/NFv4n+KiRpbbS+ripULlcsYWVPACN3ezGUsIrUxyaLX/fyejZLYTcHq+aCHQQCjrgeoZNetSjJw1NYHFaQLeJ+74ikqb
X-Gm-Message-State: AOJu0YzDsRoCsrk2cjGARSLTk/TxjCeKhdu/uwA0mviI6F44BJ8p2HiF
	O8qcv+fwV4d8BYmOPed28NO5d6MLrhzAcpEaNRuhosJ4zjNaBCo1SA9O00o/tjGLxSt9YNFBV6V
	NebAo0PQkWPuLOkSsAEMvEwjggyMk9sU4/tr1upl5xYLspbYFX7HBBMs=
X-Google-Smtp-Source: AGHT+IH51YNJJQZLatfbGRnRzfO+glQNw68ijJRguzA1cRTQmo2n81Igeu5+7zAzeROF0oTeyKr6wIsxMnd/YyEeH6QbG8BQBofC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:349e:b0:476:fa0b:c9b9 with SMTP id
 t30-20020a056638349e00b00476fa0bc9b9mr911252jal.4.1710781099647; Mon, 18 Mar
 2024 09:58:19 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:58:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbb3d80613f243a6@google.com>
Subject: [syzbot] [mm?] kernel BUG in sg_init_one
From: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13043abe180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19bb57c23dffc38e
dashboard link: https://syzkaller.appspot.com/bug?extid=adbc983a1588b7805de3
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1706d231180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ba7959180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/vmlinux-e5eb28f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7539441b4add/zImage-e5eb28f6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/scatterlist.h:187!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 2997 Comm: syz-executor198 Not tainted 6.8.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at sg_set_buf include/linux/scatterlist.h:187 [inline]
PC is at sg_init_one+0x9c/0xa8 lib/scatterlist.c:143
LR is at sg_init_table+0x2c/0x40 lib/scatterlist.c:128
pc : [<807e1748>]    lr : [<807dfb3c>]    psr: 80000113
sp : df955c38  ip : df955c70  fp : df955c54
r10: 00000000  r9 : ffefd004  r8 : ff7e7f14
r7 : 00000751  r6 : df955c58  r5 : 844847d0  r4 : ffefd004
r3 : df000000  r2 : ffffffd8  r1 : 00000000  r0 : df955c58
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 8446ed00  DAC: fffffffd
Register r0 information: 2-page vmalloc region starting at 0xdf954000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Register r1 information: NULL pointer
Register r2 information: non-paged memory
Register r3 information: non-paged memory
Register r4 information: non-paged memory
Register r5 information: slab vmap_area start 844847d0 pointer offset 0 size 40
Register r6 information: 2-page vmalloc region starting at 0xdf954000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Register r7 information: non-paged memory
Register r8 information: 0-page vmalloc region starting at 0xff7d8000 allocated at pcpu_get_vm_areas+0x0/0x12c8 mm/vmalloc.c:3064
Register r9 information: non-paged memory
Register r10 information: NULL pointer
Register r11 information: 2-page vmalloc region starting at 0xdf954000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Register r12 information: 2-page vmalloc region starting at 0xdf954000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Process syz-executor198 (pid: 2997, stack limit = 0xdf954000)
Stack: (0xdf955c38 to 0xdf956000)
5c20:                                                       ff7e7ef4 844847d0
5c40: def6d08c 83471c80 df955cb4 df955c58 804c1824 807e16b8 00000002 00000000
5c60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5c80: 00000000 00000000 00000001 cc78d8d0 844847d0 00000001 def6d08c 8446eb84
5ca0: 8446eb80 8446eb80 df955cdc df955cb8 804c4468 804c1774 def6d08c 00000001
5cc0: df955d4c 00000000 835e6c00 844ac800 df955d2c df955ce0 804b9644 804c4318
5ce0: 804bab68 802e2238 00000000 00000000 00100cca 00000000 00000000 cc78d8d0
5d00: 00000102 00000001 00100cca 00000000 00000000 df955d4b 00000007 00000000
5d20: df955da4 df955d30 804bb064 804b95a8 df955d4b 00000000 00000100 def6d08c
5d40: 00000001 00000001 01955d6c 00000000 00000000 00000000 00000000 00000000
5d60: 00000001 00000000 df955d68 df955d68 8185c338 cc78d8d0 00000406 00000001
5d80: 00000000 00000001 84476480 00100cca 00000000 df955eb8 df955e1c df955da8
5da0: 804bb3b8 804baeac 00000000 cc78d8d0 00000001 df955eb8 00000000 00000000
5dc0: df955df4 df955dd0 8042c648 8042c49c df955eb8 8260cac8 84476480 7eb0d000
5de0: 844ac800 00000000 df955e1c cc78d8d0 804ba838 df955eb8 00000000 00000001
5e00: 84476480 844ac800 00000000 00000040 df955e7c df955e20 8047cde0 804bb35c
5e20: 80491ed4 80477794 df955eec 835e6c00 00000000 00000000 7eb0d000 842b3900
5e40: df955e7c df955e50 844ac800 80491e5c fe4d5003 00000254 835e6c00 7eb0d000
5e60: 84476480 7eb0d000 842b3900 00000040 df955f2c df955e80 8047e6c4 8047cbec
5e80: 842b3940 ffffffff df955ef0 7eb0d9b4 81c64fd4 8376240c 842b3940 7eaed000
5ea0: 7eb0dfff 8376240c 00000000 ffffffff df955eb8 df955fb0 84476480 00000cc0
5ec0: 0007efff 7eb0d000 7eb0d000 00000a54 845a4fa8 8446ed08 00000180 00000000
5ee0: 00000000 00000000 00000000 defbbe08 00000000 00000000 df955f2c cc78d8d0
5f00: 8047dd80 df955fb0 7eb0d9b4 00000254 00000207 7eb0d000 842b3900 00000007
5f20: df955f74 df955f30 80215d28 8047e2f8 835e6c00 00000109 df955fac df955f48
5f40: 8020bbe8 835e6c00 80306e18 8261d0e0 00000207 7eb0d9b4 df955fb0 80215be0
5f60: 00000000 7eb0da7c df955fac df955f78 80216170 80215bec 00000000 cc78d8d0
5f80: 00000000 cc78d8d0 00000000 00066bd4 00000010 ffffffff 835e6c00 824a9044
5fa0: 00000000 df955fb0 80200e3c 80216144 00000000 00000000 22d5f800 0008d158
5fc0: 00000000 7eb0d9a4 00000000 00000109 00000000 00000000 7eb0da7c 7eb0da3c
5fe0: 00000000 7eb0d9a0 00000001 00066bd4 00000010 ffffffff 00000000 00000000
Backtrace: 
[<807e16ac>] (sg_init_one) from [<804c1824>] (zswap_decompress+0xbc/0x208 mm/zswap.c:1089)
 r7:83471c80 r6:def6d08c r5:844847d0 r4:ff7e7ef4
[<804c1768>] (zswap_decompress) from [<804c4468>] (zswap_load+0x15c/0x198 mm/zswap.c:1637)
 r9:8446eb80 r8:8446eb80 r7:8446eb84 r6:def6d08c r5:00000001 r4:844847d0
[<804c430c>] (zswap_load) from [<804b9644>] (swap_read_folio+0xa8/0x498 mm/page_io.c:518)
 r9:844ac800 r8:835e6c00 r7:00000000 r6:df955d4c r5:00000001 r4:def6d08c
[<804b959c>] (swap_read_folio) from [<804bb064>] (swap_cluster_readahead+0x1c4/0x34c mm/swap_state.c:684)
 r10:00000000 r9:00000007 r8:df955d4b r7:00000000 r6:00000000 r5:00100cca
 r4:00000001
[<804baea0>] (swap_cluster_readahead) from [<804bb3b8>] (swapin_readahead+0x68/0x4a8 mm/swap_state.c:904)
 r10:df955eb8 r9:00000000 r8:00100cca r7:84476480 r6:00000001 r5:00000000
 r4:00000001
[<804bb350>] (swapin_readahead) from [<8047cde0>] (do_swap_page+0x200/0xcc4 mm/memory.c:4046)
 r10:00000040 r9:00000000 r8:844ac800 r7:84476480 r6:00000001 r5:00000000
 r4:df955eb8
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_pte_fault mm/memory.c:5301 [inline])
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (__handle_mm_fault mm/memory.c:5439 [inline])
[<8047cbe0>] (do_swap_page) from [<8047e6c4>] (handle_mm_fault+0x3d8/0x12b8 mm/memory.c:5604)
 r10:00000040 r9:842b3900 r8:7eb0d000 r7:84476480 r6:7eb0d000 r5:835e6c00
 r4:00000254
[<8047e2ec>] (handle_mm_fault) from [<80215d28>] (do_page_fault+0x148/0x3a8 arch/arm/mm/fault.c:326)
 r10:00000007 r9:842b3900 r8:7eb0d000 r7:00000207 r6:00000254 r5:7eb0d9b4
 r4:df955fb0
[<80215be0>] (do_page_fault) from [<80216170>] (do_DataAbort+0x38/0xa8 arch/arm/mm/fault.c:558)
 r10:7eb0da7c r9:00000000 r8:80215be0 r7:df955fb0 r6:7eb0d9b4 r5:00000207
 r4:8261d0e0
[<80216138>] (do_DataAbort) from [<80200e3c>] (__dabt_usr+0x5c/0x60 arch/arm/kernel/entry-armv.S:427)
Exception stack(0xdf955fb0 to 0xdf955ff8)
5fa0:                                     00000000 00000000 22d5f800 0008d158
5fc0: 00000000 7eb0d9a4 00000000 00000109 00000000 00000000 7eb0da7c 7eb0da3c
5fe0: 00000000 7eb0d9a0 00000001 00066bd4 00000010 ffffffff
 r8:824a9044 r7:835e6c00 r6:ffffffff r5:00000010 r4:00066bd4
Code: 1a000004 e1822003 e8860094 e89da8f0 (e7f001f2) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	1a000004 	bne	0x18
   4:	e1822003 	orr	r2, r2, r3
   8:	e8860094 	stm	r6, {r2, r4, r7}
   c:	e89da8f0 	ldm	sp, {r4, r5, r6, r7, fp, sp, pc}
* 10:	e7f001f2 	udf	#18 <-- trapping instruction


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

