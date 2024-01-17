Return-Path: <linux-kernel+bounces-28938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767F8304E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785031C23B74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C01DFFA;
	Wed, 17 Jan 2024 12:05:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CB1DFCF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493125; cv=none; b=T+xQXlN0DAAZ4BY0+R8D6aWzrTDVGaIFoXanJEi2oOcXs258wjb7Og0QRnsSbyxUwjLvaIzpjDAssbtIKaCHVCCW95MbvzErP0K1TE3xWmpMUkkdRV9IUKEP7YStzF73UAIFTelWxyMwBKObusyoW8LUZ8wrW1jGKUIoHZmIm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493125; c=relaxed/simple;
	bh=Htpnjpopgo+UT36jOkfOoUZI58Uin8aBBsFJbXd6D1U=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=dozvkY6TNhxRLS8jgHlWXqzrQ04KUprSCBrHd6Uqn4FG6XHS4u+YesxODtNYu+NBUliLsUi2Jr7Oq/Ni7zGpuEjyZ2KjZgBvN5HKqASBQf1rGVSR4c7X8xbl0MhCV1Y6i3L3w1NiplYTaUOEEuBjHa95v/McXruF+FawCo3R69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf55f6222cso152987239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 04:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705493123; x=1706097923;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lhNILptHbsq/4lP5rKvgZKkGfpg+tGnMSlQFHzZqi4=;
        b=r8I1WjC4GQ5C+L0rd41zeZWkvNdTKXrd8Tln00fbUnCP6FCmB/v7TC2wBEeYgQ9FLR
         UdcN099zm/lBn99m0Qp7pWFDOz4zZf7Y93IaeszXHlYHGTzh+R+aIytDLVamvcg5j8A8
         xHKb3EBMuNB3Ty+KSzHDQWen7+wEMuvdwga7Owc0GHXIzcTmUaOXtAAtNjjDgXDLwbVV
         n6TolPasunTZIH1zC+nKAs0EW2ej+BQh8U9FZ+MNuziW94Kk8PnYZzcZaKGXAoOO29bi
         tghV2oCv/nZ6xzuC7aCBLKl0DHeyX1Mde/RLJ6045hRViCeZhpGNqwE9MH6yTvriZj8U
         04bA==
X-Gm-Message-State: AOJu0Yyn3j3c0oAxd5+/bnFHrHoRIN/QgMAGSs7CwSbi0eoHVcvSeW4s
	I7Gu2JMvWmqQEyHg3sRoPkIkNfb14PjbK5X5Ff8xAXbLviEJ
X-Google-Smtp-Source: AGHT+IEiH/8+e08FEWJXRsqVD8FJRcRsRpTY/mRLhrp2FrFAeqF9faiihqEqKr15+rdY514eEn+7hQQp6GxM1SZIt5kA+WyKUE5S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130a:b0:46d:1c7:3b12 with SMTP id
 r10-20020a056638130a00b0046d01c73b12mr455316jad.5.1705493123684; Wed, 17 Jan
 2024 04:05:23 -0800 (PST)
Date: Wed, 17 Jan 2024 04:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cde441060f230f4f@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in btintel_read_version
From: syzbot <syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    943b9f0ab2cf Add linux-next specific files for 20240117
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17c60debe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12af1d067b6a6d19
dashboard link: https://syzkaller.appspot.com/bug?extid=830d9e3fa61968246abd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1151c2a3e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110f7913e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c032ce79e0f/disk-943b9f0a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/93163e287878/vmlinux-943b9f0a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/512cc2e14a4b/bzImage-943b9f0a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+830d9e3fa61968246abd@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 0 PID: 4455 Comm: kworker/u5:1 Not tainted 6.7.0-next-20240117-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: hci0 hci_power_on
RIP: 0010:btintel_read_version+0x65/0x1e0 drivers/bluetooth/btintel.c:444
Code: 08 c5 f9 48 81 fb 00 f0 ff ff 0f 87 9e 00 00 00 e8 c0 0d c5 f9 48 8d 7b 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e de 00 00 00 8b 6b 70 bf 0a 00
RSP: 0018:ffffc9000e057958 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff87c7146e
RDX: 000000000000000e RSI: ffffffff87c71480 RDI: 0000000000000070
RBP: ffffc9000e057a10 R08: 0000000000000007 R09: fffffffffffff000
R10: 0000000000000000 R11: 0000000000000003 R12: ffff888030f74000
R13: ffffc9000e0579f0 R14: ffff888030f74000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f27722fa1d0 CR3: 000000007ff6a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ag6xx_setup+0x1b0/0xc10 drivers/bluetooth/hci_ag6xx.c:169
 hci_uart_setup+0x224/0x4d0 drivers/bluetooth/hci_ldisc.c:423
 hci_dev_setup_sync net/bluetooth/hci_sync.c:4631 [inline]
 hci_dev_init_sync net/bluetooth/hci_sync.c:4699 [inline]
 hci_dev_open_sync+0x35b/0x2650 net/bluetooth/hci_sync.c:4799
 hci_dev_do_open+0x2a/0x90 net/bluetooth/hci_core.c:483
 hci_power_on+0x132/0x670 net/bluetooth/hci_core.c:1015
 process_one_work+0x8d5/0x16e0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2707 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2788
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:btintel_read_version+0x65/0x1e0 drivers/bluetooth/btintel.c:444
Code: 08 c5 f9 48 81 fb 00 f0 ff ff 0f 87 9e 00 00 00 e8 c0 0d c5 f9 48 8d 7b 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e de 00 00 00 8b 6b 70 bf 0a 00
RSP: 0018:ffffc9000e057958 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff87c7146e
RDX: 000000000000000e RSI: ffffffff87c71480 RDI: 0000000000000070
RBP: ffffc9000e057a10 R08: 0000000000000007 R09: fffffffffffff000
R10: 0000000000000000 R11: 0000000000000003 R12: ffff888030f74000
R13: ffffc9000e0579f0 R14: ffff888030f74000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f27722fa1d0 CR3: 000000007ff6a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 c5                	or     %al,%ch
   2:	f9                   	stc
   3:	48 81 fb 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rbx
   a:	0f 87 9e 00 00 00    	ja     0xae
  10:	e8 c0 0d c5 f9       	call   0xf9c50dd5
  15:	48 8d 7b 70          	lea    0x70(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e de 00 00 00    	jle    0x118
  3a:	8b 6b 70             	mov    0x70(%rbx),%ebp
  3d:	bf                   	.byte 0xbf
  3e:	0a 00                	or     (%rax),%al


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

