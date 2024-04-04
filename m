Return-Path: <linux-kernel+bounces-131906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A75898D76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7FE1C2680B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33B12FF89;
	Thu,  4 Apr 2024 17:47:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBADF848A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252846; cv=none; b=ZmDoiCLnUXnYFkM7uzKQrCJ9Q0/L2pqxaSk+IdsS2IkPfQixip6+aP2jivqxJ6IyDnVlkCwonN+IfeXyThySV+sOInJKdXxN9tcCTqsIk2gixZenUZi4DWTb0cLGHffk8avNdL6QHI+g5lAV96dQ7vJ4wSuXjEBCvrpfXHgG8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252846; c=relaxed/simple;
	bh=ciopjTYGsTameDJETzORRo18IR2vwNp0sVx/PhgrwQY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j+MKoI6xt/+G4y6ZECsAfr42UI3+qmzUyWXdgVKEeKYTwWLk+3z9rSGPMjHHor5WDp0NBq9OhiIBOXtmo4zlm88Jy+ZAE072nDOv6YAPERmHrB7nLnVQGrQyOQbOJxqqEcP8doaLKsO0P5KT0PipBcVG27fWLgg1g+7TXk0CG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc74ea8606so143250939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252844; x=1712857644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhIjZkKevS3bM6Kzj85eIYUfYbzUCU3QtFpz+KimF2s=;
        b=b08xnbXqy2M47TQ7WZnruTpCvrnOyMlDJubgFXmEfBRMquDCn0NIripSoUTetjq0hK
         NfIfTEEdyBKK+3PTZmb5nKGZO/ccjcKKXqT/wJZ57e6EHaxWZ5oUJejz1n3JNFDJTue7
         WpGQP012gS8b8r9nvGNpbTZLlh4mxZPZSKd9RrddufeVG5MDQ9wjRMsRk8+nlFKmVmZI
         sZ2H594mLSFemgOwznCLjHwhsXs6g29lLyHNrzYkO5E0IDJNwr+CmK7ZG++Wcr4qseJC
         pneIWmb/leefVSUZzzKYYf/8qxhIrqEuvnJZ2ooDvK5lRxUvDosAuNjZhi5JA3/pyR6n
         mnEg==
X-Forwarded-Encrypted: i=1; AJvYcCWxa8lC+6xu2dqZPJzxLRoPbM+1sIX9qZvgut/Eabg3m5Z5cI4KICvR8lpo6SF5Az6PFANXRfGgCCtzFaArTPfPuX/BWwKTGRRjauiG
X-Gm-Message-State: AOJu0YxA/+Eq51S5RNJNO7WivA4JQsYi9WRT9Ta7Q5TQ8ixRiSKW32Pk
	EI+5DIG8nP7uF1XWCCpTDilTgoH/Vk9aDbVunrxgmruwKDpB28YW7VusDri2RI8Xm5UBY+I6EIa
	dW/eB1u8LO/vNq5tB56Pu19oKCbou1tJYGNvwsA8AhrXoCyLs3WazeB4=
X-Google-Smtp-Source: AGHT+IFJ0y2Hq8Jhtaeb8LOPDgi0h2AeWOvpifTa3L2PIQBGx0665+21rYA5Jg3tQ5sITpylEY7gkEew11+KlS0dkLqgKpR1KN7o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:891c:b0:47e:da4f:e1ae with SMTP id
 jc28-20020a056638891c00b0047eda4fe1aemr16208jab.5.1712252843993; Thu, 04 Apr
 2024 10:47:23 -0700 (PDT)
Date: Thu, 04 Apr 2024 10:47:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000883a10061548ee4f@google.com>
Subject: [syzbot] [kernel?] WARNING in __schedule
From: syzbot <syzbot+c48ecd0315ab6fc75bd0@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    712e14250dd2 Merge tag 'xfs-6.9-fixes-1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140b9dd9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=c48ecd0315ab6fc75bd0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-712e1425.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5cf01799ded6/vmlinux-712e1425.xz
kernel image: https://storage.googleapis.com/syzbot-assets/689df0e91974/bzImage-712e1425.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c48ecd0315ab6fc75bd0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 0 at kernel/softirq.c:362 __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
================================
WARNING: inconsistent lock state
Modules linked in:
6.9.0-rc1-syzkaller-00355-g712e14250dd2 #0 Not tainted
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.9.0-rc1-syzkaller-00355-g712e14250dd2 #0
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
swapper/1/0 [HC0[0]:SC0[0]:HE0:SE1] takes:
RIP: 0010:__local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
ffff88806b13ea58
Code: 00 e8 61 6f 0b 00 e8 0c b7 42 00 fb 65 8b 05 fc 02 b2 7e 85 c0 74 52 5b 5d c3 cc cc cc cc 65 8b 05 be b3 b0 7e 85 c0 75 9e 90 <0f> 0b 90 eb 98 e8 13 b5 42 00 eb 99 48 89 ef e8 a9 f4 19 00 eb a2
 (&rq->__lock
RSP: 0018:ffffc900001878e0 EFLAGS: 00010046){?.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
------------[ cut here ]------------
WARNING: CPU: 3 PID: 0 at arch/x86/mm/tlb.c:515 switch_mm_irqs_off+0x890/0xbc0 arch/x86/mm/tlb.c:515
Modules linked in:
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.9.0-rc1-syzkaller-00355-g712e14250dd2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:switch_mm_irqs_off+0x890/0xbc0 arch/x86/mm/tlb.c:515
Code: ff 44 8d 6b 02 48 63 d3 49 8d 8e 18 06 00 00 4d 63 ed 49 c1 e5 04 4d 8d 8d 80 d8 03 00 49 81 c5 88 d8 03 00 e9 75 fd ff ff 90 <0f> 0b 90 e9 e3 f7 ff ff 90 0f 0b 90 e8 df f5 ff ff e9 20 f8 ff ff
RSP: 0018:ffffc90000197be8 EFLAGS: 00010202
RAX: 0000000000000282 RBX: ffff888017eb0000 RCX: ffff888015479300
RDX: 1ffff11002a8f33a RSI: ffffffff8b8f47e0 RDI: ffffffff8b8f4820
RBP: ffffffff8dd38440 R08: 0000000000000000 R09: ffffed1002a8f279
R10: ffff8880154793cb R11: 0000000000000000 R12: ffff88806b33f500
R13: ffff888043848000 R14: ffff888015479300 R15: ffff88806b33ea40
FS:  0000000000000000(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2db29000 CR3: 000000000d97a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5393 [inline]
 __schedule+0xd2b/0x5d00 kernel/sched/core.c:6746
 schedule_idle+0x59/0x90 kernel/sched/core.c:6864
 do_idle+0x287/0x3f0 kernel/sched/idle.c:360
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x148
 </TASK>


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

