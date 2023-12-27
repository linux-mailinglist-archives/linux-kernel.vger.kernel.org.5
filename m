Return-Path: <linux-kernel+bounces-12092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211EF81EFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC48C1F2154D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79D84597C;
	Wed, 27 Dec 2023 15:50:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A545957
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35f8dc26895so52219365ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 07:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703692221; x=1704297021;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uUPSmPqV0Xj8Wy07LQhMT+hl7jtNI5As8Dd5xFHbAc=;
        b=HckOKlqHNIJz5+EWmHPiwIBiuBgAkK7WUNzlu4M1+Vs39MEpohkOaF+LjpMZGHkIZn
         OT4cp2U5Co/Gua7l9hQmSlizf20okI0ENu6mOgAt+6cfgz15Ow8ylJUHBDfNiOuH816U
         UdTnl/HA4Vxtk/dy7Qa7QGCQDTVTgmbewnSsgbVyXKCW4nQ6qN5vdPAXXNx7OYQfuxSm
         3jWA+hZB2tCElg07bGkdH4UM+C4I5SfcIx2iMP4Z2CgYojcV2LBS8wtMDY0QiZN1wwR+
         6Vgc/i0Qz4886+BMrfpNCW9hQ3xIURgMdzpgvrNan57MnJMgZXA78sjZX9oer3WS86ef
         x5JA==
X-Gm-Message-State: AOJu0YyN5tCp0sTD/TB4PwTijqTiAArxbzn3pV7IDSp1rFNMy8ael/tq
	fkWqVPE2JdnajNkGWX4fhEQdqJ5ziln53gYZgAxQukRzyvNn
X-Google-Smtp-Source: AGHT+IHHmHU+RMG+iwnO5KB9C9n/zDDokCrbZQtl56syoN1YRxRBiUEZADb+66tKbMKapqVE23jl+B9XM+Cnwn4yjnsxxHChjZep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d06:b0:35f:e976:32b1 with SMTP id
 db6-20020a056e023d0600b0035fe97632b1mr880050ilb.0.1703692221244; Wed, 27 Dec
 2023 07:50:21 -0800 (PST)
Date: Wed, 27 Dec 2023 07:50:21 -0800
In-Reply-To: <0000000000006d415806048a9aee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a76dc2060d7fc157@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
From: syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10dc0065e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c29fe98c88e5c7ae
dashboard link: https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1217a445e80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44afd70ba00e/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2812e972b4b2/Image-fbafc3e6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com

netdevsim netdevsim1 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
Mem abort info:
  ESR = 0x0000000097d88004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  Access size = 8 byte(s)
  SSE = 0, SRT = 24
  SF = 1, AR = 0
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000045d88000
[0000000000000008] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000097d88004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3148 Comm: syz-executor.1 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: linux,dummy-virt (DT)
pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : list_add_tail include/linux/list.h:183 [inline]
pc : list_lru_add+0xa4/0x188 mm/list_lru.c:129
lr : list_lru_from_memcg_idx mm/list_lru.c:56 [inline]
lr : list_lru_from_memcg_idx mm/list_lru.c:53 [inline]
lr : list_lru_from_kmem mm/list_lru.c:78 [inline]
lr : list_lru_add+0x16c/0x188 mm/list_lru.c:128
sp : ffff800082c23ce0
x29: ffff800082c23ce0 x28: f7ff0000034f2f40 x27: 0000000000000000
x26: 0000000000000000 x25: faff000004d30000 x24: f0ff000005702340
x23: 0000000000000000 x22: 0000000000000000 x21: f8ff000005e0ac58
x20: f0ff000005702340 x19: f4ff000005b05d40 x18: 0000000000000001
x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000803180f8
x14: 0000000000000000 x13: 000000000000039c x12: 0000000000005800
x11: 0000000000000040 x10: 000000000000002e x9 : 0000000000000001
x8 : ffff800082c23af8 x7 : 00000000001fffff x6 : 0000000055555556
x5 : f1ff000002c38b00 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 list_lru_from_kmem mm/list_lru.c:68 [inline]
 list_lru_add+0xa4/0x188 mm/list_lru.c:128
 d_lru_add+0x98/0x14c fs/dcache.c:431
 retain_dentry fs/dcache.c:685 [inline]
 dput+0x194/0x31c fs/dcache.c:908
 done_path_create fs/namei.c:3925 [inline]
 do_mkdirat+0x90/0x16c fs/namei.c:4132
 __do_sys_mkdirat fs/namei.c:4144 [inline]
 __se_sys_mkdirat fs/namei.c:4142 [inline]
 __arm64_sys_mkdirat+0x50/0x7c fs/namei.c:4142
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:155
 el0_svc+0x34/0xd8 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:595
Code: 8b160316 d2800019 910022d6 aa1603fa (f94006d8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b160316 	add	x22, x24, x22
   4:	d2800019 	mov	x25, #0x0                   	// #0
   8:	910022d6 	add	x22, x22, #0x8
   c:	aa1603fa 	mov	x26, x22
* 10:	f94006d8 	ldr	x24, [x22, #8] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

