Return-Path: <linux-kernel+bounces-44520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381284232F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEE11F26AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205CC67736;
	Tue, 30 Jan 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AEleoigv"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97266B49
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614484; cv=none; b=mhirIjGVbZHvRhO8/Ozj+EXfqVFvXh2y2m1BLTc1H3W61iu6ZdVrSZkL7pJpC7NvegeJgXilYmu4sT+JKKYVJqOA+jey4uzGoNPju8gMy8Gc1HXl+u+HLAQSLTCh9CKD3IdrpSK1s/sIbcXRYk0HTv18ge7i8xwFvqeH/ZW8SAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614484; c=relaxed/simple;
	bh=x2iA5tLVddlwd6djOQ2McrZw5rCOgQFldGfLEpJ46qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=abRbIKIjmJmTyqE/7zGBy6qSA+fv/1hL6bsWw9hRGvZwLATE19aAzb4D1EUZY2kWGrzIT+hMOnvB0zs15ndKy2Kv57T/CyFROHKdIskcOcMjzQX34Cgn5dFql3ilMqLZkdPm2Zu3GAS/OndrxINhZuYk3XDi9BSjbI82jx8Ghug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AEleoigv; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c945dbf3-aa59-0515-72e8-fef815a02b4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706614478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlRfnSMqOvhV+BAgFr8AU/OvJG8/tFH2Xkf3J/HgD5U=;
	b=AEleoigvZylC5iMtnDISwpvJkun6asvmifCl8LrqeLcH0IRWHv1+uOCXValgjmzgJBW0Vx
	9vRnJbma61zfl6vN5PzoyoTFWO5S3frTqccTiQlBRHZcaR0EF2GSriDxuRxn1KqDXKAhOs
	Qm12+NCJlhIPm49NVY6XCQq/3C0hRwI=
Date: Tue, 30 Jan 2024 19:34:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [mm?] kernel BUG in validate_mm (3)
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
 syzbot <syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <20240129152251.mf52xjxf54umijwy@revolver>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20240129152251.mf52xjxf54umijwy@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/1/29 23:22, Liam R. Howlett wrote:
> Yajun,
>
>
> * syzbot <syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com> [240129 06:15]:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    596764183be8 Add linux-next specific files for 20240129
>> git tree:       linux-next
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=142042f3e80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=584144ad19f381aa
>> dashboard link: https://syzkaller.appspot.com/bug?extid=39a72b995ba73633c1a7
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11844ba7e80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bd01efe80000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/b647c038857b/disk-59676418.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/729e26c3ac55/vmlinux-59676418.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/15aa5e287059/bzImage-59676418.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+39a72b995ba73633c1a7@syzkaller.appspotmail.com
>>
>> arg_start 7fffd9277efb arg_end 7fffd9277f14 env_start 7fffd9277f14 env_end 7fffd9277fdf
>> binfmt ffffffff8d9c5c00 flags 80007fd
>> ioctx_table 0000000000000000
>> owner ffff88802c0cda00 exe_file ffff88801ff60500
>> notifier_subscriptions 0000000000000000
>> numa_next_scan 0 numa_scan_offset 0 numa_scan_seq 0
>> tlb_flush_pending 0
>> def_flags: 0x0()
>> ------------[ cut here ]------------
>> kernel BUG at mm/mmap.c:328!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>> CPU: 1 PID: 5058 Comm: syz-executor310 Not tainted 6.8.0-rc1-next-20240129-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>> RIP: 0010:validate_mm+0x3f3/0x4b0 mm/mmap.c:328
>> Code: 0f 84 a4 fd ff ff e9 47 ff ff ff e8 77 91 b9 ff 44 89 f2 89 de 48 c7 c7 e0 af 19 8b e8 56 69 9b ff 4c 89 ff e8 ce c4 fa ff 90 <0f> 0b e8 56 91 b9 ff 0f b6 15 1f dd b1 0d 31 ff 89 d6 88 14 24 e8
>> RSP: 0018:ffffc900035df958 EFLAGS: 00010282
>> RAX: 000000000000032a RBX: 000000000000000d RCX: ffffffff816e2f59
>> RDX: 0000000000000000 RSI: ffffffff816eb7e6 RDI: 0000000000000005
>> RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000080000000 R11: 0000000000000001 R12: 00007fffd92ff000
>> R13: 0000000000000000 R14: 000000000000000e R15: ffff88802c6b8000
>> FS:  0000555557046380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f10ada208a0 CR3: 000000007b434000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   vma_merge+0x16a9/0x3d70 mm/mmap.c:1033
>>   vma_merge_new_vma mm/mmap.c:2465 [inline]
>>   mmap_region+0x206b/0x2760 mm/mmap.c:2841
>>   do_mmap+0x8ae/0xf10 mm/mmap.c:1380
>>   vm_mmap_pgoff+0x1ab/0x3c0 mm/util.c:573
>>   ksys_mmap_pgoff+0x425/0x5b0 mm/mmap.c:1426
>>   __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>   __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>   __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> I just tested the reproducer against linux-next with and without your
> patch [1], and confirmed that is the cause of this validation failure.
>
> The validation code is seeing an extra vma in the tree compared to the
> vma count:
>
> [   57.065418] mmap: map_count 24 vma iterator 25
>
> There is a C reproducer from the bot.  Can you please have a look to
> figure out what is missing?

It shoud be like this:

                                    ******
                      PPPPP             NNNNN

But it was treated as:

                                    ******
                      PPPPPCCCCCNNNNN


I haven't found something that should be added to the check yet. I'll 
continue tomorrow.

>
> It would really help if you had that complicated if statement expanded
> with comments:
>
> if (prev == curr ||      /* ??? */
>      addr != curr->vm_start.......
>
>
> Thanks,
> Liam
>
> [1]. https://lore.kernel.org/linux-mm/20240125034922.1004671-3-yajun.deng@linux.dev/

