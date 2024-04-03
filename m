Return-Path: <linux-kernel+bounces-129488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27299896B86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DA428EDEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC951350EC;
	Wed,  3 Apr 2024 10:04:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F171350FA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138653; cv=none; b=U9wIPQeYOT+6Owhr1kteCev+YsuSy2A9XEqwEQuvS0ou6+veIBEm+C+ADRCu+IeDhpaZkSZ3F25HfXDRJOMt9oduLeRsEb177riGe4WTe3rojfFd6MqhfOl1klUVEE3VHZ5E8pLLGKxDmSmy7hbTFUreuDQ2U9uCbuG2tTU9D+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138653; c=relaxed/simple;
	bh=fg4cBZWr29JljcaZvNUlXt9KZ3HDndyTOZj3xMQCzIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pzqOXOhTlEPW29628DvlnHazWQXPCHYlti1xneaauf0yOEJ/fXS3ZlFI01rF8CjZA5M/Pev8v8yi9sVrb0B7Uz/7WinmYlPWwaQU/tjnEAMDMFIt/Xsq7+x0cPDvO6p6jasrLaBXfI2AgwUUjPW7mxwwbu1gfICxBIxi6hTGMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86BA7FEC;
	Wed,  3 Apr 2024 03:04:41 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E9E23F64C;
	Wed,  3 Apr 2024 03:04:09 -0700 (PDT)
Message-ID: <538f3e85-2eb9-48f5-ba4e-172d39bf0c6b@arm.com>
Date: Wed, 3 Apr 2024 11:04:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in
 madvise_cold_or_pageout_pte_range
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 syzbot <syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000662a630615207d87@google.com>
 <579d5127-c763-4001-9625-4563a9316ac3@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <579d5127-c763-4001-9625-4563a9316ac3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/04/2024 09:55, David Hildenbrand wrote:
> On 02.04.24 19:32, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=155b7db1180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c641706ad4e9688cccdf
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian)
>> 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image:
>> https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
>> vmlinux:
>> https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
>> kernel image:
>> https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com
>>
>> =====================================
>> WARNING: bad unlock balance detected!
>> 6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
>> -------------------------------------
>> syz-executor.4/9211 is trying to release lock (ptlock_ptr(ptdesc)) at:
>> [<ffffffff81f01c0f>] spin_unlock include/linux/spinlock.h:391 [inline]
>> [<ffffffff81f01c0f>] madvise_cold_or_pageout_pte_range+0x170f/0x3990
>> mm/madvise.c:480
>> but there are no more locks to release!
>>
>> other info that might help us debug this:
>> 1 lock held by syz-executor.4/9211:
>>   #0: ffff888067e40b18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock
>> include/linux/mmap_lock.h:144 [inline]
>>   #0: ffff888067e40b18 (&mm->mmap_lock){++++}-{3:3}, at:
>> do_madvise+0x481/0x44a0 mm/madvise.c:1429
>>
>> stack backtrace:
>> CPU: 0 PID: 9211 Comm: syz-executor.4 Not tainted
>> 6.9.0-rc2-next-20240402-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
>> 03/27/2024
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:88 [inline]
>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>>   print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5194
>>   __lock_release kernel/locking/lockdep.c:5431 [inline]
>>   lock_release+0x599/0x9f0 kernel/locking/lockdep.c:5774
>>   __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
>>   _raw_spin_unlock+0x16/0x50 kernel/locking/spinlock.c:186
>>   spin_unlock include/linux/spinlock.h:391 [inline]
>>   madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
>>   walk_pmd_range mm/pagewalk.c:143 [inline]
>>   walk_pud_range mm/pagewalk.c:221 [inline]
>>   walk_p4d_range mm/pagewalk.c:256 [inline]
>>   walk_pgd_range+0xba1/0x1810 mm/pagewalk.c:293
>>   __walk_page_range+0x132/0x720 mm/pagewalk.c:395
>>   walk_page_range+0x58f/0x7c0 mm/pagewalk.c:521
>>   madvise_cold_page_range mm/madvise.c:562 [inline]
>>   madvise_cold mm/madvise.c:584 [inline]
>>   madvise_vma_behavior mm/madvise.c:1028 [inline]
>>   madvise_walk_vmas mm/madvise.c:1256 [inline]
>>   do_madvise+0x1e7b/0x44a0 mm/madvise.c:1442
>>   __do_sys_madvise mm/madvise.c:1457 [inline]
>>   __se_sys_madvise mm/madvise.c:1455 [inline]
>>   __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1455
>>   do_syscall_64+0xfb/0x240
>>   entry_SYSCALL_64_after_hwframe+0x72/0x7a
>> RIP: 0033:0x7ff60947dda9
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48
>> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73
>> 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ff60a1b50c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
>> RAX: ffffffffffffffda RBX: 00007ff6095abf80 RCX: 00007ff60947dda9
>> RDX: 0000000000000014 RSI: 0000000000600000 RDI: 0000000020000000
>> RBP: 00007ff6094ca47a R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 000000000000000b R14: 00007ff6095abf80 R15: 00007fffacd4bc68
>>   </TASK>
>> ------------[ cut here ]------------
>> pvqspinlock: lock 0xffff88802ed23120 has corrupted value 0x0!
>> WARNING: CPU: 1 PID: 9211 at kernel/locking/qspinlock_paravirt.h:510
>> __pv_queued_spin_unlock_slowpath+0x241/0x2f0
>> kernel/locking/qspinlock_paravirt.h:508
>> Modules linked in:
>> CPU: 1 PID: 9211 Comm: syz-executor.4 Not tainted
>> 6.9.0-rc2-next-20240402-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
>> 03/27/2024
>> RIP: 0010:__pv_queued_spin_unlock_slowpath+0x241/0x2f0
>> kernel/locking/qspinlock_paravirt.h:508
>> Code: 65 47 6e f6 4c 89 f0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 9f 00 00 00 41
>> 8b 16 48 c7 c7 c0 26 cb 8b 4c 89 f6 e8 90 f3 cb f5 90 <0f> 0b 90 90 eb 8d 44
>> 89 f1 80 e1 07 38 c1 0f 8c 26 ff ff ff 4c 89
>> RSP: 0018:ffffc9000e477238 EFLAGS: 00010246
>> RAX: 5e9807e53cfb4f00 RBX: dffffc0000000000 RCX: 0000000000040000
>> RDX: ffffc9000b3b8000 RSI: 000000000003ffff RDI: 0000000000040000
>> RBP: dffffc0000000000 R08: ffffffff81580192 R09: fffffbfff1c39b10
>> R10: dffffc0000000000 R11: fffffbfff1c39b10 R12: 1ffff11005da4626
>> R13: ffff88802ed23130 R14: ffff88802ed23120 R15: ffff88802ed23120
>> FS:  00007ff60a1b56c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fea8ecdaab3 CR3: 000000005d0fe000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
>>   .slowpath+0x9/0x16
>>   pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:589 [inline]
>>   queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
>>   do_raw_spin_unlock+0x13c/0x8b0 kernel/locking/spinlock_debug.c:142
>>   __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
>>   _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:186
>>   spin_unlock include/linux/spinlock.h:391 [inline]
>>   madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
>>   walk_pmd_range mm/pagewalk.c:143 [inline]
>>   walk_pud_range mm/pagewalk.c:221 [inline]
>>   walk_p4d_range mm/pagewalk.c:256 [inline]
>>   walk_pgd_range+0xba1/0x1810 mm/pagewalk.c:293
>>   __walk_page_range+0x132/0x720 mm/pagewalk.c:395
>>   walk_page_range+0x58f/0x7c0 mm/pagewalk.c:521
>>   madvise_cold_page_range mm/madvise.c:562 [inline]
>>   madvise_cold mm/madvise.c:584 [inline]
>>   madvise_vma_behavior mm/madvise.c:1028 [inline]
>>   madvise_walk_vmas mm/madvise.c:1256 [inline]
>>   do_madvise+0x1e7b/0x44a0 mm/madvise.c:1442
>>   __do_sys_madvise mm/madvise.c:1457 [inline]
>>   __se_sys_madvise mm/madvise.c:1455 [inline]
>>   __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1455
>>   do_syscall_64+0xfb/0x240
>>   entry_SYSCALL_64_after_hwframe+0x72/0x7a
>> RIP: 0033:0x7ff60947dda9
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48
>> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73
>> 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ff60a1b50c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
>> RAX: ffffffffffffffda RBX: 00007ff6095abf80 RCX: 00007ff60947dda9
>> RDX: 0000000000000014 RSI: 0000000000600000 RDI: 0000000020000000
>> RBP: 00007ff6094ca47a R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 000000000000000b R14: 00007ff6095abf80 R15: 00007fffacd4bc68
>>   </TASK>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>>
> 
> I'd suspect:
> 
> commit 38456b4a3c609b205d5fdc6ef5347824a83fd818
> Author: Ryan Roberts <ryan.roberts@arm.com>
> Date:   Wed Mar 27 14:45:37 2024 +0000
> 
>     mm: madvise: avoid split during MADV_PAGEOUT and MADV_COLD
> 
> but I don't immediately see the issue. CCing Ryan.

Yes I believe this is the same issue that Barry reported [1]. I have a fix that
will be in my v6 of the swap-out series (hopefully today). I've already asked
Andrew to remove my v5 series from mm-unstable.

Sorry about this!

[1] https://lore.kernel.org/linux-mm/cbef3584-d3a7-4843-899e-3c1bb5430984@arm.com/



