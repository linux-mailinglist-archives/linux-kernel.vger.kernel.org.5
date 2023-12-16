Return-Path: <linux-kernel+bounces-2089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246C8157BB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2A1B23F35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170EA13FEE;
	Sat, 16 Dec 2023 05:20:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FB13FF1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b3d54a346dso160693139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702704022; x=1703308822;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DBLfijeIhGmwG8adRxot1wLG0R8KQJHQblZTAg4zFIc=;
        b=wjRfy+Pqx9o1ORwm8r+fUq8KX9nWVgr0r/UhnDjepoWKsaBSU9Gz5jxzUYfUe04Wip
         4H/UH7SQch/dNmjtjV2/rG1GMsNeiFpcoe7BP8Yd7okJ6dzcmPqSb66oUSc5+xmc4671
         xBxp1yPtKENrsITpAwgUmDNTIH9DmUdcBYHzdjU80iF6eY0l5MOEMbfbcDtCk1Wso74o
         Ndy1nV0803wEJALYa/yJZYYASu6tN5IIeHp8+LrgHn4wfLXj4RSI32bt/3WoyueVA2xj
         BDCtTKDh8sSOzaDH3zd+QFETNln+BLgsHUXMA/ILwHZKNQoq4wFSF0LIEq3/WrA4/AY+
         btKg==
X-Gm-Message-State: AOJu0Yx4qL1TQte9oNRRvFDo+hHYVk4obnNYv4MRa6rK5iI4bzUgIqqs
	m/YPRbQqVTiy3pEPcBqHg+WgqVIaJc/YQrvQNa6ABX44YVLn
X-Google-Smtp-Source: AGHT+IHiTSTIf7TWvaxNt5iafBSG8TIt7aI/u5ZIlbcF3dQcSvKatfLUXN3Nzjsu7sZFRVa34UQTgPJ7feJz4QVvUOHSc/Dmrqrd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:33a4:b0:469:667:9437 with SMTP id
 h36-20020a05663833a400b0046906679437mr524784jav.6.1702704022555; Fri, 15 Dec
 2023 21:20:22 -0800 (PST)
Date: Fri, 15 Dec 2023 21:20:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c14cd060c99ac12@google.com>
Subject: [syzbot] [block?] general protection fault in bio_first_folio
From: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    abb240f7a2bd Add linux-next specific files for 20231212
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1673c8aee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc2485c21b49ddc4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b23309d5788a79d3eea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11627092e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13274512e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/795a3560ea0e/disk-abb240f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17a88d6802ed/vmlinux-abb240f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bfcdd0049f21/bzImage-abb240f7.xz

The issue was bisected to:

commit 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Aug 14 14:41:00 2023 +0000

    block: Remove special-casing of compound pages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152f8a8ee80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=172f8a8ee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=132f8a8ee80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com
Fixes: 1b151e2435fc ("block: Remove special-casing of compound pages")

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 5059 Comm: syz-executor696 Not tainted 6.7.0-rc5-next-20231212-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
RIP: 0010:bio_first_folio+0xcb/0x5c0 include/linux/bio.h:289
Code: 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 76 04 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6d 00 49 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 49 04 00 00 4d 8b 7d 08 31 ff 4d 89 fc 41 83 e4
RSP: 0018:ffffc900039ef448 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffc900039ef4e8 RCX: ffffffff8444f4bd
RDX: 0000000000000001 RSI: ffffffff8444f4cb RDI: 0000000000000008
RBP: ffff88801dad0888 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88801dad0800
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801dad0800
FS:  0000555556ace380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007c5b7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bio_release_pages+0x9d/0x4b0 block/bio.c:1150
 bio_release_pages include/linux/bio.h:508 [inline]
 bio_map_user_iov+0x8ee/0xa60 block/blk-map.c:347
 blk_rq_map_user_iov+0x6a5/0x1840 block/blk-map.c:663
 blk_rq_map_user block/blk-map.c:690 [inline]
 blk_rq_map_user_io+0x202/0x230 block/blk-map.c:723
 sg_io+0x537/0xd70 drivers/scsi/scsi_ioctl.c:456
 scsi_cdrom_send_packet+0x276/0x640 drivers/scsi/scsi_ioctl.c:820
 scsi_ioctl+0x146/0x1840 drivers/scsi/scsi_ioctl.c:903
 sg_ioctl+0xb7b/0x2760 drivers/scsi/sg.c:1163
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f9970983229
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda6357b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffda6357d68 RCX: 00007f9970983229
RDX: 0000000020000000 RSI: 0000000000005393 RDI: 0000000000000004
RBP: 00007f99709f6610 R08: 00007ffda6357d68 R09: 00007ffda6357d68
R10: 002367732f766564 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffda6357d58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
RIP: 0010:bio_first_folio+0xcb/0x5c0 include/linux/bio.h:289
Code: 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85 76 04 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6d 00 49 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 49 04 00 00 4d 8b 7d 08 31 ff 4d 89 fc 41 83 e4
RSP: 0018:ffffc900039ef448 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffc900039ef4e8 RCX: ffffffff8444f4bd
RDX: 0000000000000001 RSI: ffffffff8444f4cb RDI: 0000000000000008
RBP: ffff88801dad0888 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88801dad0800
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801dad0800
FS:  0000555556ace380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000007c5b7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 ea             	mov    %rbp,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 76 04 00 00    	jne    0x487
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	4c 8b 6d 00          	mov    0x0(%rbp),%r13
  1f:	49 8d 7d 08          	lea    0x8(%r13),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 49 04 00 00    	jne    0x47d
  34:	4d 8b 7d 08          	mov    0x8(%r13),%r15
  38:	31 ff                	xor    %edi,%edi
  3a:	4d 89 fc             	mov    %r15,%r12
  3d:	41                   	rex.B
  3e:	83                   	.byte 0x83
  3f:	e4                   	.byte 0xe4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

