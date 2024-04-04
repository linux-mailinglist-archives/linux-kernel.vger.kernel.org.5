Return-Path: <linux-kernel+bounces-131266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A174C898578
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8941C21B36
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ED48062B;
	Thu,  4 Apr 2024 10:56:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800127FBB1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228187; cv=none; b=I/hclVosrejlRGtiBWPqBNWE+GxV4P8rvFvL1PGEw26cr5y5qJNdgHMvbFtuYTtuSuChrn0Cy6/APzxcslrTzNgndmUzevW0ogy+GmlXp+SVePfbpKBclsRVtw2bhmFjrKQ01kO3XJRXHVRlXxG7KKT2Vcey41JPN4AbqZZVUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228187; c=relaxed/simple;
	bh=301O9vgG95N9TiexCWI2o99BVnuUY+dJx84qdcDLP2s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XgwP1eecsYf0MmPA9R/GK6QFSHm6J1RB/jQtoHuLQcGWV8umdQM53eD7NAdMMBW/t30Cnhfx0LByAeFiMB2ysI6rF+T7g7PJcwifN+2Aki3cQmVl+ZQvvQF/InuzRGKDKQDM6ropf1CTJbha1wvcsEwIG6eraLpYi8TeXByFwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-369f8cb9818so5012245ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 03:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228184; x=1712832984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYpek9BoJPzKH+SPDXrSodfODP6NdfrQUMHv+6rUDwc=;
        b=xO5+mEii/tJ7cm1eCeaYBFzH/9GZuyeA3O09Tj3J3s/ZYmgUFcvgwpjtSiNScxflIJ
         YxEQGkLjL2rdDUKrCDOfmsOHdxeZ9mlVckcWW6eulKW/nlggj8N2TpY0p2IXZNo3t4EB
         AIke0uONtHkt/IjF5A2B9n/2t9nTAh17ODIV0MeGuL99dX1Zq6f70ScWKou59Kt60NDs
         5JBEjnySvG8bCPDL3sY+USmam5+k5MtwxLYIujtaiaiMwicIlfPYggem9M2tFTBQPHbi
         sw8x/W3SqEaxBK23LWsvMiQF4PamgbutWGkS9NuYJjCOgG1ZjlaLj+BzOtiPg42xB3t8
         Oz9g==
X-Forwarded-Encrypted: i=1; AJvYcCW0299RCaq0ZJvw/l6Zc601Yib3nIbLKKq7zN3mP1uohr4DyOsW3xuYonJw4AFc9Wg/xjUAbU3SBqo6C5A9GTpx8xwKI138gYNJQeYh
X-Gm-Message-State: AOJu0YxiK3uOILp3brI36JkFNIvJClO7viog93OKpLX1a4uCBSq88wxA
	JX07Ax129xC2Av2DPe8l7JCgPsUIrffQB31SBt6OOpXX7nzPuDtYpz8YsA6EQlrgbk4Sk4/llnb
	e6Tsk21c32S0H8hvQ1QhxEeP9pavLBlA0n+mn8cGecvP165GIclRdvOc=
X-Google-Smtp-Source: AGHT+IEe6dNQEfdg5ryyn3c83j5DQi2XkbCquNM1PvbFB16XeLJ4Zp80no1rnvHgz7F+aPwvyaQgC8rfNNrO32DBy/i+NmBlnV+w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d12:b0:369:b997:7342 with SMTP id
 i18-20020a056e021d1200b00369b9977342mr114511ila.3.1712228184691; Thu, 04 Apr
 2024 03:56:24 -0700 (PDT)
Date: Thu, 04 Apr 2024 03:56:24 -0700
In-Reply-To: <000000000000662a630615207d87@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b92a9d0615433065@google.com>
Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in madvise_cold_or_pageout_pte_range
From: syzbot <syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    727900b675b7 Add linux-next specific files for 20240403
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11f66223180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
dashboard link: https://syzkaller.appspot.com/bug?extid=c641706ad4e9688cccdf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a62423180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13764a3d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f8fb4daa7a83/disk-727900b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2a6994aee53/vmlinux-727900b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6759e5411c39/bzImage-727900b6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.9.0-rc2-next-20240403-syzkaller #0 Not tainted
-------------------------------------
syz-executor799/5099 is trying to release lock (ptlock_ptr(ptdesc)) at:
[<ffffffff81f01f3f>] spin_unlock include/linux/spinlock.h:391 [inline]
[<ffffffff81f01f3f>] madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor799/5099:
 #0: ffff888015073a98 (&mm->mmap_lock){++++}-{3:3}
, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
, at: do_madvise+0x481/0x44a0 mm/madvise.c:1429

stack backtrace:
CPU: 1 PID: 5099 Comm: syz-executor799 Not tainted 6.9.0-rc2-next-20240403-syzkaller #0
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
RIP: 0033:0x7f3928ac2419
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3928a5c218 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f3928b4c318 RCX: 00007f3928ac2419
RDX: 0000000000000014 RSI: 00000000dfc3efff RDI: 00000000203c1000
RBP: 00007f3928b4c310 R08: 00007ffd7796b097 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3928b19064
R13: 000000080000000e R14: 000000200000007f R15: 00000000dfc3efff
 </TASK>
------------[ cut here ]------------
pvqspinlock: lock 0xffff88802ec45b40 has corrupted value 0x0!
WARNING: CPU: 1 PID: 5099 at kernel/locking/qspinlock_paravirt.h:510 __pv_queued_spin_unlock_slowpath+0x241/0x2f0 kernel/locking/qspinlock_paravirt.h:508
Modules linked in:

CPU: 1 PID: 5099 Comm: syz-executor799 Not tainted 6.9.0-rc2-next-20240403-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__pv_queued_spin_unlock_slowpath+0x241/0x2f0 kernel/locking/qspinlock_paravirt.h:508
Code: 85 0a 6e f6 4c 89 f0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 9f 00 00 00 41 8b 16 48 c7 c7 c0 26 cb 8b 4c 89 f6 e8 40 b3 cb f5 90 <0f> 0b 90 90 eb 8d 44 89 f1 80 e1 07 38 c1 0f 8c 26 ff ff ff 4c 89
RSP: 0018:ffffc9000364f238 EFLAGS: 00010246

RAX: 9a7270b7f8439200 RBX: dffffc0000000000 RCX: ffff888023139e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff81580152 R09: 1ffffffff1f526cd
R10: dffffc0000000000 R11: fffffbfff1f526ce R12: 1ffff11005d88b6a
R13: ffff88802ec45b50 R14: ffff88802ec45b40 R15: ffff88802ec45b40
FS:  00007f3928a5c6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561c1eec8018 CR3: 00000000213dc000 CR4: 00000000003506f0
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


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

