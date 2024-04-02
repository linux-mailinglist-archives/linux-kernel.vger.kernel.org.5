Return-Path: <linux-kernel+bounces-128432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D80895ABB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665091C24838
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F8D15AAC5;
	Tue,  2 Apr 2024 17:32:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9015A49F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079149; cv=none; b=CPJphthJOX/G2MMBmhbWBYSnZjjsQ6DEgF0zU/n1MRg1ztNhLo9eBk1mYZxdFcisnaE6C2c7C2ukt4KwxLDgS0/hSNTud+03OBlQhE4wdOahKWbxyDkw1Zi8RPBn1M8ud2RggYiHDOVTPdyZfSkF8mITferQwX6SwRmLC6DXVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079149; c=relaxed/simple;
	bh=q/6YtVjplylYpUMVuiPYhdKe+wu36h9NP63edaIh/tQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jILa7aAL+jTogBLKBR2FK5+YM9KJiMMR1wQqBRl2dsOuGkLGW5NrOi2K1m5L7JmjxjdSQAvEYCEi2Tuqy0R4nfzsmxjj6CiaToIiNdjzxf6peNxbuzJmlC/3ztE+8+AwygYQYZ6omADwfk0IkS4jFzlU26OCBQufIur207uyU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d096c4d663so597277939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079147; x=1712683947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SY9IQN3JgrkzwyVxDMeEwfCmWGF4TEr/b6KUrVvOYo=;
        b=YzkdpYudoiSL0MeKLu92hqZOGAE0Yr05prKcwfaQXtk4SVXmBP/HUYjKrtt8ELSZzV
         Bz6bFTLYVDYoA9E1yDTsbJxQkqcX7vv4z7l6eEkDA6iY4TInCmzsl3N5nFozHoWSraXQ
         /VJwgyPwfm9dZVhAihhWce2cplx8COI/YCFtpifTcjxygauurHpM/ETA+MNFU8dgFQ6R
         X15EdhNn/jzZ15p5LEHi5rAQRvkx+ksTQLwgMCbFRZ121Z/0pp/BosrwUVz/k2Y5y48I
         ClJhgexSmhXtGzWnjqpsDFLKGwAzC0LxPEYqpFU+A6VNTp1qr/gU4k+gb1i3MdOob0C1
         xGkg==
X-Forwarded-Encrypted: i=1; AJvYcCV9JIX3unzmS2Tg8m+IIdKTDFiB+nBwQhQEbU6RzO6WqxtDe+l6DaJAkabUH0ZOvJChnmLH4Xyec95KJbiqJRA0HkHEOisfDz1irQl4
X-Gm-Message-State: AOJu0YzxkmnTf6bsgZccAKOhezxzsdsj3m0GWDcavizsB+TzIrH1Qcah
	l6DoeLmunsRiFJ1r76d08lSUDKlHNUPg4X0Ch3Ytg/5ozfgunuSgaQcRVFeFE+MKmEzP4c9nwRf
	/0XZxDMJveOctHL3Fb63xAaDU6lFgBwUNoemALvtlwAhcTIi5B1tr9jU=
X-Google-Smtp-Source: AGHT+IHM5KGInL/Vqe3sg2WIOULTaCdYKaXbbtlFCXtlp8wFl18jx2lfWQD+So7vv3M7dXzDZCrELU6brHvjkQIpSXap00PdCQK6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c09:b0:7cc:3370:b84f with SMTP id
 ik9-20020a0566026c0900b007cc3370b84fmr324166iob.4.1712079147245; Tue, 02 Apr
 2024 10:32:27 -0700 (PDT)
Date: Tue, 02 Apr 2024 10:32:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000662a630615207d87@google.com>
Subject: [syzbot] [mm?] WARNING: bad unlock balance in madvise_cold_or_pageout_pte_range
From: syzbot <syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=155b7db1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
dashboard link: https://syzkaller.appspot.com/bug?extid=c641706ad4e9688cccdf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
-------------------------------------
syz-executor.4/9211 is trying to release lock (ptlock_ptr(ptdesc)) at:
[<ffffffff81f01c0f>] spin_unlock include/linux/spinlock.h:391 [inline]
[<ffffffff81f01c0f>] madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor.4/9211:
 #0: ffff888067e40b18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
 #0: ffff888067e40b18 (&mm->mmap_lock){++++}-{3:3}, at: do_madvise+0x481/0x44a0 mm/madvise.c:1429

stack backtrace:
CPU: 0 PID: 9211 Comm: syz-executor.4 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5194
 __lock_release kernel/locking/lockdep.c:5431 [inline]
 lock_release+0x599/0x9f0 kernel/locking/lockdep.c:5774
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x16/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0xba1/0x1810 mm/pagewalk.c:293
 __walk_page_range+0x132/0x720 mm/pagewalk.c:395
 walk_page_range+0x58f/0x7c0 mm/pagewalk.c:521
 madvise_cold_page_range mm/madvise.c:562 [inline]
 madvise_cold mm/madvise.c:584 [inline]
 madvise_vma_behavior mm/madvise.c:1028 [inline]
 madvise_walk_vmas mm/madvise.c:1256 [inline]
 do_madvise+0x1e7b/0x44a0 mm/madvise.c:1442
 __do_sys_madvise mm/madvise.c:1457 [inline]
 __se_sys_madvise mm/madvise.c:1455 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1455
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7ff60947dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff60a1b50c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007ff6095abf80 RCX: 00007ff60947dda9
RDX: 0000000000000014 RSI: 0000000000600000 RDI: 0000000020000000
RBP: 00007ff6094ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff6095abf80 R15: 00007fffacd4bc68
 </TASK>
------------[ cut here ]------------
pvqspinlock: lock 0xffff88802ed23120 has corrupted value 0x0!
WARNING: CPU: 1 PID: 9211 at kernel/locking/qspinlock_paravirt.h:510 __pv_queued_spin_unlock_slowpath+0x241/0x2f0 kernel/locking/qspinlock_paravirt.h:508
Modules linked in:
CPU: 1 PID: 9211 Comm: syz-executor.4 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__pv_queued_spin_unlock_slowpath+0x241/0x2f0 kernel/locking/qspinlock_paravirt.h:508
Code: 65 47 6e f6 4c 89 f0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 9f 00 00 00 41 8b 16 48 c7 c7 c0 26 cb 8b 4c 89 f6 e8 90 f3 cb f5 90 <0f> 0b 90 90 eb 8d 44 89 f1 80 e1 07 38 c1 0f 8c 26 ff ff ff 4c 89
RSP: 0018:ffffc9000e477238 EFLAGS: 00010246
RAX: 5e9807e53cfb4f00 RBX: dffffc0000000000 RCX: 0000000000040000
RDX: ffffc9000b3b8000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: dffffc0000000000 R08: ffffffff81580192 R09: fffffbfff1c39b10
R10: dffffc0000000000 R11: fffffbfff1c39b10 R12: 1ffff11005da4626
R13: ffff88802ed23130 R14: ffff88802ed23120 R15: ffff88802ed23120
FS:  00007ff60a1b56c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fea8ecdaab3 CR3: 000000005d0fe000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
 .slowpath+0x9/0x16
 pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:589 [inline]
 queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
 do_raw_spin_unlock+0x13c/0x8b0 kernel/locking/spinlock_debug.c:142
 __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
 walk_pmd_range mm/pagewalk.c:143 [inline]
 walk_pud_range mm/pagewalk.c:221 [inline]
 walk_p4d_range mm/pagewalk.c:256 [inline]
 walk_pgd_range+0xba1/0x1810 mm/pagewalk.c:293
 __walk_page_range+0x132/0x720 mm/pagewalk.c:395
 walk_page_range+0x58f/0x7c0 mm/pagewalk.c:521
 madvise_cold_page_range mm/madvise.c:562 [inline]
 madvise_cold mm/madvise.c:584 [inline]
 madvise_vma_behavior mm/madvise.c:1028 [inline]
 madvise_walk_vmas mm/madvise.c:1256 [inline]
 do_madvise+0x1e7b/0x44a0 mm/madvise.c:1442
 __do_sys_madvise mm/madvise.c:1457 [inline]
 __se_sys_madvise mm/madvise.c:1455 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1455
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7ff60947dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff60a1b50c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007ff6095abf80 RCX: 00007ff60947dda9
RDX: 0000000000000014 RSI: 0000000000600000 RDI: 0000000020000000
RBP: 00007ff6094ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff6095abf80 R15: 00007fffacd4bc68
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

