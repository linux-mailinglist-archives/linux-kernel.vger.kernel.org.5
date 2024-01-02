Return-Path: <linux-kernel+bounces-14275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F82821AAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8311F2258D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E2DDC9;
	Tue,  2 Jan 2024 11:09:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D4DDB6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7fac89006so1191963839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704193761; x=1704798561;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdZj6yifa6uX0fql0fA/jPgYGjbw5MkhykL8POItTpk=;
        b=oAhSWLqLYBNSKTnV2giL6Z4VS2XKdR7DtxSVW/bxXYd+qAMoP6S7Vkty8kzQ94xQkk
         91+6RVRXaNxIKCsehpfvGm/ysAaf7lFSQubf9ivJeYcFmMZ393EHdQ/1NdnbDiTzNsyh
         CMTke5n/Ly/kMuHr+3KSdKoLpliJ7+rDYdqYGC7VODML07/6OGSSfJNk5uJnCrlqsFuk
         78ywzCE14jmxqM6kd5OYZaK22SOcGzWU34bWEBTIyGCwqn53Wla+4iEVvOxDAciBTif5
         IBbVbxcl29jq9QAYPG8jSJVhbOHpZ+pk5kyIiWmXfmm6rATCfydYBgKIomGB8clqu0ba
         Q9/g==
X-Gm-Message-State: AOJu0YyAqWwtGKV7dBDUTeSQp1q8PZkRVFQY0jds/rBQQJ7FtvNWbDGF
	LdYmnTqEuMHjJVTpEVV1p4Nl6BvIumDCGVzkSNfAo0Q3uEb5
X-Google-Smtp-Source: AGHT+IG8L2eX2uBJI3bkLcG72iIX8ZMmeA0txPgx0coGSxGSY09ojRI0Q0HYAjVBvvuFtQivefc+Tab+ERilANRBx7fgi6ugYv2s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:35f:f683:f76b with SMTP id
 s5-20020a056e021a0500b0035ff683f76bmr2360900ild.3.1704193761359; Tue, 02 Jan
 2024 03:09:21 -0800 (PST)
Date: Tue, 02 Jan 2024 03:09:21 -0800
In-Reply-To: <000000000000997dac0606e7a57c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c63c9a060df487df@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in __kmap_local_page_prot
From: syzbot <syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101fdde9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1d9baf5d2241e14
dashboard link: https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a75c19e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1507d95ee80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5dcc5fecebbd/vmlinux-610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac6cb620d377/zImage-610a9b8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[00000000] *pgd=843b7003, *pmd=fe1bc003
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 2985 Comm: syz-executor305 Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at page_zonenum include/linux/mmzone.h:1109 [inline]
PC is at __kmap_local_page_prot+0xc/0x74 mm/highmem.c:573
LR is at kmap_local_page include/linux/highmem-internal.h:73 [inline]
LR is at copy_page_to_iter+0xf8/0x184 lib/iov_iter.c:379
pc : [<8046aab0>]    lr : [<807e0b68>]    psr: 60000013
sp : df959c20  ip : df959c30  fp : df959c2c
r10: 00000018  r9 : 828574e8  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 8455ec00
r3 : 00c00000  r2 : 0000071f  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 8433f6c0  DAC: fffffffd
Register r0 information: NULL pointer
Register r1 information: NULL pointer
Register r2 information: non-paged memory
Register r3 information: non-paged memory
Register r4 information: slab kmalloc-1k start 8455ec00 pointer offset 0 size 1024
Register r5 information: NULL pointer
Register r6 information: NULL pointer
Register r7 information: NULL pointer
Register r8 information: NULL pointer
Register r9 information: non-slab/vmalloc memory
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xdf958000 allocated at kernel_clone+0xac/0x41c kernel/fork.c:2907
Register r12 information: 2-page vmalloc region starting at 0xdf958000 allocated at kernel_clone+0xac/0x41c kernel/fork.c:2907
Process syz-executor305 (pid: 2985, stack limit = 0xdf958000)
Stack: (0xdf959c20 to 0xdf95a000)
9c20: df959c64 df959c30 807e0b68 8046aab0 df959c54 df959ef0 8024c5d8 8455ec00
9c40: 8455ec00 00000000 00000000 00000000 00000041 00000018 df959cb4 df959c68
9c60: 813da83c 807e0a7c 00000000 8423cd40 83a75600 83a756d0 83eaf300 83a756d8
9c80: df959ef0 00000000 806d5054 83eaf300 00000041 83a75600 82e96000 00000000
9ca0: 00000000 00000000 df959d24 df959cb8 815f77dc 813da758 00000000 df959ee0
9cc0: 00000000 00000000 00000000 00000000 83eaf3a8 83a756ec 83eaf53c df959ee0
9ce0: df959ee0 830a6780 00000000 00000000 00000000 97d26d6f df959d24 815f768c
9d00: 830a6780 20000d60 815f6ae4 00000000 00000000 df959d54 df959d44 df959d28
9d20: 815f6b1c 815f7698 00000000 830a6780 20000d40 df959ee0 df959e04 df959d48
9d40: 8134fd4c 815f6af0 00000000 00000000 00000001 00000000 00000000 00000000
9d60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9dc0: 00000000 00000000 00000000 00000000 00000000 97d26d6f 00000000 00000000
9de0: df959ee0 20000d60 00000000 830a6780 82e96000 00000002 df959e84 df959e08
9e00: 81352bdc 8134fc24 00000000 00000001 00000000 00000000 00000000 20000500
9e20: 00000041 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 97d26d6f
9e60: df959e84 df959ec0 20000d60 00000001 00000000 00000000 df959f5c df959e88
9e80: 81352d04 81352b60 00000001 df959e98 8089202c 830a6780 00000000 00000000
9ea0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9ec0: 00000000 00000000 0002eb00 00000000 00000000 00000000 2f2e0001 656c6966
9ee0: df959d54 00000000 00000000 00000000 00000000 00000000 20000500 00000041
9f00: 00000001 00000000 00000000 00000001 00000000 00000000 00000000 00000000
9f20: 00000000 00000000 00000176 97d26d6f 82e96000 00000003 20000d40 00000000
9f40: 00000000 00000002 82e96000 0000016d df959fa4 df959f60 813536d4 81352c1c
9f60: 00000000 ffffffff 00000000 00000000 00000000 00000000 82e96000 97d26d6f
9f80: df959fa4 00000000 00000000 0008e060 0000016d 80200288 00000000 df959fa8
9fa0: 80200060 8135361c 00000000 00000000 00000003 20000d40 00000002 00000000
9fc0: 00000000 00000000 0008e060 0000016d 0007107c 00000000 00000001 20000100
9fe0: 7ebf3c70 7ebf3c60 0001094c 0002eb00 00000010 00000003 00000000 00000000
Backtrace: 
[<8046aaa4>] (__kmap_local_page_prot) from [<807e0b68>] (kmap_local_page include/linux/highmem-internal.h:73 [inline])
[<8046aaa4>] (__kmap_local_page_prot) from [<807e0b68>] (copy_page_to_iter+0xf8/0x184 lib/iov_iter.c:379)
[<807e0a70>] (copy_page_to_iter) from [<813da83c>] (sk_msg_recvmsg+0xf0/0x3cc net/core/skmsg.c:437)
 r10:00000018 r9:00000041 r8:00000000 r7:00000000 r6:00000000 r5:8455ec00
 r4:8455ec00
[<813da74c>] (sk_msg_recvmsg) from [<815f77dc>] (unix_bpf_recvmsg net/unix/unix_bpf.c:73 [inline])
[<813da74c>] (sk_msg_recvmsg) from [<815f77dc>] (unix_bpf_recvmsg+0x150/0x444 net/unix/unix_bpf.c:50)
 r10:00000000 r9:00000000 r8:00000000 r7:82e96000 r6:83a75600 r5:00000041
 r4:83eaf300
[<815f768c>] (unix_bpf_recvmsg) from [<815f6b1c>] (unix_dgram_recvmsg+0x38/0x4c net/unix/af_unix.c:2483)
 r10:df959d54 r9:00000000 r8:00000000 r7:815f6ae4 r6:20000d60 r5:830a6780
 r4:815f768c
[<815f6ae4>] (unix_dgram_recvmsg) from [<8134fd4c>] (sock_recvmsg_nosec net/socket.c:1044 [inline])
[<815f6ae4>] (unix_dgram_recvmsg) from [<8134fd4c>] (____sys_recvmsg+0x134/0x158 net/socket.c:2801)
 r4:df959ee0
[<8134fc18>] (____sys_recvmsg) from [<81352bdc>] (___sys_recvmsg+0x88/0xbc net/socket.c:2845)
 r10:00000002 r9:82e96000 r8:830a6780 r7:00000000 r6:20000d60 r5:df959ee0
 r4:00000000
[<81352b54>] (___sys_recvmsg) from [<81352d04>] (do_recvmmsg+0xf4/0x298 net/socket.c:2939)
 r8:00000000 r7:00000000 r6:00000001 r5:20000d60 r4:df959ec0
[<81352c10>] (do_recvmmsg) from [<813536d4>] (__sys_recvmmsg net/socket.c:3018 [inline])
[<81352c10>] (do_recvmmsg) from [<813536d4>] (__do_sys_recvmmsg_time32 net/socket.c:3052 [inline])
[<81352c10>] (do_recvmmsg) from [<813536d4>] (sys_recvmmsg_time32+0xc4/0xd8 net/socket.c:3045)
 r10:0000016d r9:82e96000 r8:00000002 r7:00000000 r6:00000000 r5:20000d40
 r4:00000003
[<81353610>] (sys_recvmmsg_time32) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdf959fa8 to 0xdf959ff0)
9fa0:                   00000000 00000000 00000003 20000d40 00000002 00000000
9fc0: 00000000 00000000 0008e060 0000016d 0007107c 00000000 00000001 20000100
9fe0: 7ebf3c70 7ebf3c60 0001094c 0002eb00
 r8:80200288 r7:0000016d r6:0008e060 r5:00000000 r4:00000000
Code: eaffffe8 e1a0c00d e92dd800 e24cb004 (e5901000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	eaffffe8 	b	0xffffffa8
   4:	e1a0c00d 	mov	ip, sp
   8:	e92dd800 	push	{fp, ip, lr, pc}
   c:	e24cb004 	sub	fp, ip, #4
* 10:	e5901000 	ldr	r1, [r0] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

