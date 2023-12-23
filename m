Return-Path: <linux-kernel+bounces-10409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8623E81D40D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322CB2835C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC17D2E3;
	Sat, 23 Dec 2023 12:49:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EFD28B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc6d9af8bso29205915ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 04:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703335758; x=1703940558;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jPlsN7Ml/+XR4qokePSVPYK/NjAAU4vFSo45xfBkHM=;
        b=KlxB0Xgtn5SuG1GtyFQaLc6GHf3n8FjPPEEAX0h46agMotZyreKUdfq1fKiTjaXqih
         9+66YRLzWjXVHGTgkI7giK1bvGBKIrvOV3fEgEhaY92oNxZUGumBEftoRpI0feu4KzIb
         PSOLUAm2tx1qkttZ/+0d9ewRh/l6wKOzKfUooQundONj4jLFxlbM3V8CfusaQC4IAn2x
         ikLbzBgQ4WpAkEggTv5lsmPloVK9J5YY+1bEwfgS94NjFvemZ60PgrdsvY+qkQWQOTbf
         bo+JdQHlRGynxtqUc7G1uKHrgS5ZPUlsZX8EilEXbMehpQoWj0IdKZCelXDg/hsK2l20
         aDmA==
X-Gm-Message-State: AOJu0YzW1lo/is4K+gZ2YHKW/5bIWQokQjzuGB7vNG9k3g77pZj6j+fL
	DnOiSL5sTBb7IHbV2fDT2tYIk5rcsXKum8GRz9vf5pVIZwDl
X-Google-Smtp-Source: AGHT+IGKjtDVv/BwNjkyahYD1ta4x0QVryvLbcYlokVC/ReU3y+mA3PBbk7B3gA+dsjpbiDflxKoXE4BFahG5lO+JqFcrt4j7CMo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174c:b0:35f:c187:ea04 with SMTP id
 y12-20020a056e02174c00b0035fc187ea04mr354022ill.3.1703335758089; Sat, 23 Dec
 2023 04:49:18 -0800 (PST)
Date: Sat, 23 Dec 2023 04:49:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb54de060d2cc266@google.com>
Subject: [syzbot] [riscv?] kernel panic: Kernel stack overflow (2)
From: syzbot <syzbot+5c1ebfe49c5e8e998e75@syzkaller.appspotmail.com>
To: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b5c14361d61 riscv: Fix set_direct_map_default_noflush() t..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=16d5ffd6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5c1ede998d7cef2
dashboard link: https://syzkaller.appspot.com/bug?extid=5c1ebfe49c5e8e998e75
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-3b5c1436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11e6a4fa8d50/vmlinux-3b5c1436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6570c8642590/Image-3b5c1436.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c1ebfe49c5e8e998e75@syzkaller.appspotmail.com

 s11: ff60000008bd0a9c t3 : ff20000002078140 t4 : ffffffff80159674
 t5 : 1fe400000040f028 t6 : ff6000000f44c1b8
status: 0000000200000100 badaddr: ff20000002077f60 cause: 000000000000000f
Kernel panic - not syncing: Kernel stack overflow
CPU: 1 PID: 5612 Comm: kworker/1:4 Not tainted 6.7.0-rc1-syzkaller-g3b5c14361d61 #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: usb_hub_wq hub_event
Call Trace:
[<ffffffff8000c1e6>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:121
[<ffffffff836ee406>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:127
[<ffffffff8372f66a>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff8372f66a>] dump_stack_lvl+0xe8/0x154 lib/dump_stack.c:106
[<ffffffff8372f6f2>] dump_stack+0x1c/0x24 lib/dump_stack.c:113
[<ffffffff836eef04>] panic+0x2ae/0x67a kernel/panic.c:344
[<ffffffff8000be62>] walk_stackframe+0x0/0x2f2 arch/riscv/kernel/traps.c:412
[<ffffffff8015a3b2>] mark_usage kernel/locking/lockdep.c:4586 [inline]
[<ffffffff8015a3b2>] __lock_acquire+0xd3e/0x310a kernel/locking/lockdep.c:5090
SMP: stopping secondary CPUs
Rebooting in 86400 seconds..


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

