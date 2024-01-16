Return-Path: <linux-kernel+bounces-27222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C761782EC63
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373111F222DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999017598;
	Tue, 16 Jan 2024 09:57:20 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00615AF7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35ff7c81f4aso91472765ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705399038; x=1706003838;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIQ1H8XFIGhOeVs72txcLATNzxwG63gY9YTuviyIhV4=;
        b=WVhdg3hGC/KLlwZEzjd9HyRU+WCfrFhS+QFbdzGh+bxmrhiZAOvn5zXQxDZPBy4P3h
         bTvkNAMngKZ88wwuEGzai0Vi0IdTpRf+1w000dU0YNGpYzJ36jNm8Va+iz3jqpHRBlmQ
         x23gUmV5MK3xtQQwfVATTzkfE/q1cvZdDBi/bnXJCYuKUPGCIge4aYG+3buxuBBTXZq2
         l35POibUTT8KgzTyvHqcxgAid7nP6C0eFC4nCqUZin52dv9sREKUj41hK30tTjgRIiWk
         1F071VorFQNnKi6qvHvz1X77kfM25z6PADadTV/+YbAq5cH4dk4XImpa0GTCYFAFfyT4
         rGtA==
X-Gm-Message-State: AOJu0Yz3EBGhTW/Fxhw+xjEqjuNUgglFKRLhsVk82bMkpJhj3pbo6dTI
	TVm2GtkXD2fJn1tSPKvrrRN0JQWGOVW6UyYwf26lHhBH4N1J
X-Google-Smtp-Source: AGHT+IEB17ZpVF92Ai/oAD23Ju2qgLEQRDNt62m896t/qyX8HEG1WVlBHvhogwAOIEeIS2Kx/BGzacte4/btCE9qHQKpdQDbNfIX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:360:5cc5:8ded with SMTP id
 g12-20020a056e021e0c00b003605cc58dedmr1017180ila.3.1705399037975; Tue, 16 Jan
 2024 01:57:17 -0800 (PST)
Date: Tue, 16 Jan 2024 01:57:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbe2f2060f0d2781@google.com>
Subject: [syzbot] [block?] BUG: unable to handle kernel NULL pointer
 dereference in __bio_release_pages
From: syzbot <syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17957913e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9603f9823d535d97
dashboard link: https://syzkaller.appspot.com/bug?extid=004c1e0fced2b4bc3dcc
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13529733e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166850dde80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74cc52d4cc15/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2da7e6a234c/Image-052d5343.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000001
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000001] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3139 Comm: syz-executor303 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: linux,dummy-virt (DT)
pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:247 [inline]
pc : bio_first_folio include/linux/bio.h:289 [inline]
pc : __bio_release_pages+0x100/0x73c block/bio.c:1153
lr : bio_release_pages include/linux/bio.h:508 [inline]
lr : blkdev_bio_end_io+0x2a0/0x3f0 block/fops.c:157
sp : ffff800089a375e0
x29: ffff800089a375e0 x28: 1fffe0000162e879 x27: ffff00000b1743c0
x26: ffff00000b1743c8 x25: 000000000000000a x24: 1fffe000015a9e12
x23: ffff00000ad4f094 x22: ffff00000f496600 x21: 1fffe0000162e87a
x20: 0000000000000004 x19: 0000000000000000 x18: ffff00000b174432
x17: ffff00000b174438 x16: ffff00000f948008 x15: 1fffe0000162e886
x14: ffff00000b1743d4 x13: 00000000f1f1f1f1 x12: ffff6000015a9e13
x11: 1fffe000015a9e12 x10: ffff6000015a9e12 x9 : dfff800000000000
x8 : ffff00000b1743d4 x7 : 0000000041b58ab3 x6 : 1ffff00011346ed0
x5 : ffff700011346ed0 x4 : 00000000f1f1f1f1 x3 : 000000000000f1f1
x2 : 0000000000000001 x1 : dfff800000000000 x0 : 0000000000000008
Call trace:
 _compound_head include/linux/page-flags.h:247 [inline]
 bio_first_folio include/linux/bio.h:289 [inline]
 __bio_release_pages+0x100/0x73c block/bio.c:1153
 bio_release_pages include/linux/bio.h:508 [inline]
 blkdev_bio_end_io+0x2a0/0x3f0 block/fops.c:157
 bio_endio+0x4a4/0x618 block/bio.c:1608
 __blkdev_direct_IO block/fops.c:213 [inline]
 blkdev_direct_IO.part.0+0xf08/0x13c0 block/fops.c:379
 blkdev_direct_IO block/fops.c:370 [inline]
 blkdev_direct_write block/fops.c:648 [inline]
 blkdev_write_iter+0x430/0x91c block/fops.c:706
 call_write_iter include/linux/fs.h:2085 [inline]
 do_iter_readv_writev+0x194/0x298 fs/read_write.c:741
 vfs_writev+0x244/0x684 fs/read_write.c:971
 do_pwritev+0x15c/0x1e0 fs/read_write.c:1072
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __arm64_sys_pwritev2+0xac/0x120 fs/read_write.c:1122
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:51
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x58/0x140 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: d2d00001 f2fbffe1 91002260 d343fc02 (38e16841) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d2d00001 	mov	x1, #0x800000000000        	// #140737488355328
   4:	f2fbffe1 	movk	x1, #0xdfff, lsl #48
   8:	91002260 	add	x0, x19, #0x8
   c:	d343fc02 	lsr	x2, x0, #3
* 10:	38e16841 	ldrsb	w1, [x2, x1] <-- trapping instruction


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

