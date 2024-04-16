Return-Path: <linux-kernel+bounces-146045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220958A5F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4395282ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF315C0;
	Tue, 16 Apr 2024 00:44:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334817C9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228244; cv=none; b=RtOdfPlfgbLXEpg0fJ8oSQ/RYTrcaNt93luQ4hhZcIxnSwMqA9JAxWWGK0lh7lSBPGE0aOGR7r96SS7jAcr+4R95f8Hba2ZEDWhaN0yLSOufXHR7/nHJr6fkHe0fOANlqBfIKY/T+B0swVqY2IE3aPosU9XmO/yVfCo4tPKgqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228244; c=relaxed/simple;
	bh=wgIMy3KyG0+HGHC7PNyzANhYXFUzJlzuV5IL1sMvj84=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uJaX2HYHZBz1TAkWmQ8RQZrR7JUvoaQnj7K5hG0Mv+G9CLbQM0DJDxGzHqC4QuJthop8nfhg/HpE99xRzvegCelPr3ny6DrP3cD19vVRXdqdJ5K3jtcH2u7CtyOnf+JSDJ1U+tqzAZkMkfPukRPyIZL7x9AfZfyq3RyKKw+ww/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d676654767so440841839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713228242; x=1713833042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0NaY3DQEWixVduVR8eqcoXDozbng/MXJM+a2S6+VZs=;
        b=oGSs2ldjyzQqiu58Lkngq9Y3pdQakBNWlUbsUqyUVKwp8GHTRE76rdGIOcYq+Ie27P
         NSCiE3Pfu8fQ4Na4TiB5H4cURMDkq0NxAy4KCN+KrJXz9sxnDCmnqXrn3eAqjSoOa/Qa
         FZZ9wc9r0LUEHZCNL8nT2DuxUrGUbssKsjPI9e8KJiero1lPaZ0fMSDPA57rX1NhDOUX
         HIi/WBFzgMPBZhrqDBb8V+ZctkIQuuc7/pAk8CGR3iwxtkdEIq6zQDW7m2tvm55hNAYQ
         IY2Wfw5d4/xUh92XjoaJcKgkpJUtdJkmfWoj9fcu+veaOOQ/cWXrPAd8wPgnBCtjFKh0
         N/jw==
X-Forwarded-Encrypted: i=1; AJvYcCV9mSQNvv6Vt5YJb+abmYfoDBnksrICo+xujVfsjck04/VcT5xrjm7K3emvzJ24SJ4hLAHyUCMOV62kYx8F/2I7gINbqjTDFldiiJY1
X-Gm-Message-State: AOJu0YznkKDQ4f6ZgUirQC2bZMIths3XHdIdF0cGcCG70BgbevtDvPdH
	I+6n4nL+eqO2qCqD4T4qM9CnrOOYhneKCx36jywUftKvLsJ7yxum25dFZ1dfVHZ++f28QN1wQqs
	MiH5byZtj/KCKdQi2x0fEo3T/EhBX93adafBuKiixJz/6YiBS05p3fMc=
X-Google-Smtp-Source: AGHT+IGkJghLNwCMAvxjM6dLJ7/DTH80oDh6QtRbqyy4HVh9imJa6on09IJ2w0a8JZHECW/zwKBuvmD6J+CaRFwTjjfqlqr7i/sg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:260a:b0:482:eac1:fece with SMTP id
 m10-20020a056638260a00b00482eac1fecemr645850jat.4.1713228242082; Mon, 15 Apr
 2024 17:44:02 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:44:02 -0700
In-Reply-To: <661dc810.050a0220.c9289.5241@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9efeb06162c0898@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in __kmap_local_page_prot
From: syzbot <syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com>
To: andrew.kanner@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in __kmap_local_page_prot

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[00000000] *pgd=84743003, *pmd=fe6cd003
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 3935 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at page_zonenum include/linux/mmzone.h:1100 [inline]
PC is at __kmap_local_page_prot+0xc/0x74 mm/highmem.c:573
LR is at kmap_local_page include/linux/highmem-internal.h:73 [inline]
LR is at copy_page_to_iter+0xf8/0x184 lib/iov_iter.c:360
pc : [<80479ea8>]    lr : [<807e997c>]    psr: 60000013
sp : df9f5ca0  ip : df9f5cb0  fp : df9f5cac
r10: 00000018  r9 : 8285a4e8  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 8489a400
r3 : 00c00000  r2 : 0000071f  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 848db4c0  DAC: fffffffd
Register r0 information: NULL pointer
Register r1 information: NULL pointer
Register r2 information: non-paged memory
Register r3 information: non-paged memory
Register r4 information: slab kmalloc-1k start 8489a400 pointer offset 0 size 1024
Register r5 information: NULL pointer
Register r6 information: NULL pointer
Register r7 information: NULL pointer
Register r8 information: NULL pointer
Register r9 information: non-slab/vmalloc memory
Register r10 information: non-paged memory
Register r11 information: 2-page vmalloc region starting at 0xdf9f4000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Register r12 information: 2-page vmalloc region starting at 0xdf9f4000 allocated at kernel_clone+0xac/0x3cc kernel/fork.c:2796
Process syz-executor.0 (pid: 3935, stack limit = 0xdf9f4000)
Stack: (0xdf9f5ca0 to 0xdf9f6000)
5ca0: df9f5ce4 df9f5cb0 807e997c 80479ea8 df9f5cd4 df9f5f48 8024c880 8489a400
5cc0: 8489a400 00000000 00000000 00000000 000000d4 00000018 df9f5d34 df9f5ce8
5ce0: 814333f4 807e9890 00000000 6ddd6be4 83fffc00 83fffcd0 83dea700 83fffcd8
5d00: df9f5f48 00000000 df9f5d8c 83dea700 000000d4 83fffc00 8410b000 00000000
5d20: 00000000 00000000 df9f5da4 df9f5d38 816560a8 81433310 00000000 00000000
5d40: 00000000 00000000 00000000 00000000 83dea788 83fffcec 83dea934 df9f5f38
5d60: 00000000 6ddd6be4 818c33d0 821a9848 00000000 6ddd6be4 df9f5f38 81655f58
5d80: df9f5f38 83372780 00000000 00000000 00000000 df9f5df4 df9f5dc4 df9f5da8
5da0: 81655124 81655f64 00000000 00000000 00000000 816550ec df9f5de4 df9f5dc8
5dc0: 813a29d4 816550f8 df9f5f38 83372780 200001c0 00000000 df9f5ea4 df9f5de8
5de0: 813a2bd4 813a2990 00000000 00000000 00000001 00000000 00000000 00000000
5e00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5e20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5e40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5e60: 00000000 00000000 00000000 00000000 00000000 6ddd6be4 00000000 00000000
5e80: df9f5f38 200001c0 00000000 83372780 8410b000 00000129 df9f5f24 df9f5ea8
5ea0: 813a5b18 813a2b50 00000000 00000000 00000008 00000000 00000000 20000280
5ec0: 000000d4 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5ee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 6ddd6be4
5f00: df9f5f24 83372780 00000000 200001c0 00000000 80200288 df9f5fa4 df9f5f28
5f20: 813a6294 813a5a9c 00000000 df9f5f38 00000001 fffffff7 df9f5df4 00000000
5f40: 00000000 00000000 00000000 00000000 20000280 000000d4 00000001 00000000
5f60: 00000000 00000001 00000000 00000000 00000000 00000000 00000000 00000000
5f80: 8020ca6c 6ddd6be4 00000000 00000000 0014c2c8 00000129 00000000 df9f5fa8
5fa0: 80200060 813a622c 00000000 00000000 00000003 200001c0 00000000 00000000
5fc0: 00000000 00000000 0014c2c8 00000129 7ee5432e 7ee5432f 003d0f00 76b1d0fc
5fe0: 76b1cf08 76b1cef8 000168a0 00050c70 60000010 00000003 00000000 00000000
Call trace: 
[<80479e9c>] (__kmap_local_page_prot) from [<807e997c>] (kmap_local_page include/linux/highmem-internal.h:73 [inline])
[<80479e9c>] (__kmap_local_page_prot) from [<807e997c>] (copy_page_to_iter+0xf8/0x184 lib/iov_iter.c:360)
[<807e9884>] (copy_page_to_iter) from [<814333f4>] (sk_msg_recvmsg+0xf0/0x3cc net/core/skmsg.c:437)
 r10:00000018 r9:000000d4 r8:00000000 r7:00000000 r6:00000000 r5:8489a400
 r4:8489a400
[<81433304>] (sk_msg_recvmsg) from [<816560a8>] (unix_bpf_recvmsg net/unix/unix_bpf.c:73 [inline])
[<81433304>] (sk_msg_recvmsg) from [<816560a8>] (unix_bpf_recvmsg+0x150/0x444 net/unix/unix_bpf.c:50)
 r10:00000000 r9:00000000 r8:00000000 r7:8410b000 r6:83fffc00 r5:000000d4
 r4:83dea700
[<81655f58>] (unix_bpf_recvmsg) from [<81655124>] (unix_dgram_recvmsg+0x38/0x4c net/unix/af_unix.c:2529)
 r10:df9f5df4 r9:00000000 r8:00000000 r7:00000000 r6:83372780 r5:df9f5f38
 r4:81655f58
[<816550ec>] (unix_dgram_recvmsg) from [<813a29d4>] (sock_recvmsg_nosec net/socket.c:1046 [inline])
[<816550ec>] (unix_dgram_recvmsg) from [<813a29d4>] (sock_recvmsg+0x50/0x78 net/socket.c:1068)
 r4:816550ec
[<813a2984>] (sock_recvmsg) from [<813a2bd4>] (____sys_recvmsg+0x90/0x158 net/socket.c:2803)
 r7:00000000 r6:200001c0 r5:83372780 r4:df9f5f38
[<813a2b44>] (____sys_recvmsg) from [<813a5b18>] (___sys_recvmsg+0x88/0xbc net/socket.c:2845)
 r10:00000129 r9:8410b000 r8:83372780 r7:00000000 r6:200001c0 r5:df9f5f38
 r4:00000000
[<813a5a90>] (___sys_recvmsg) from [<813a6294>] (__sys_recvmsg net/socket.c:2875 [inline])
[<813a5a90>] (___sys_recvmsg) from [<813a6294>] (__do_sys_recvmsg net/socket.c:2885 [inline])
[<813a5a90>] (___sys_recvmsg) from [<813a6294>] (sys_recvmsg+0x74/0xb8 net/socket.c:2882)
 r8:80200288 r7:00000000 r6:200001c0 r5:00000000 r4:83372780
[<813a6220>] (sys_recvmsg) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xdf9f5fa8 to 0xdf9f5ff0)
5fa0:                   00000000 00000000 00000003 200001c0 00000000 00000000
5fc0: 00000000 00000000 0014c2c8 00000129 7ee5432e 7ee5432f 003d0f00 76b1d0fc
5fe0: 76b1cf08 76b1cef8 000168a0 00050c70
 r7:00000129 r6:0014c2c8 r5:00000000 r4:00000000
Code: eaffffe8 e1a0c00d e92dd800 e24cb004 (e5901000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	eaffffe8 	b	0xffffffa8
   4:	e1a0c00d 	mov	ip, sp
   8:	e92dd800 	push	{fp, ip, lr, pc}
   c:	e24cb004 	sub	fp, ip, #4
* 10:	e5901000 	ldr	r1, [r0] <-- trapping instruction


Tested on:

commit:         96fca68c Merge tag 'nfsd-6.9-3' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1250f567180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=121101cdbf9c4dc2
dashboard link: https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Note: no patches were applied.

