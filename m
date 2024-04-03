Return-Path: <linux-kernel+bounces-129373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEB88969A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09841F2857D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFF16DD0D;
	Wed,  3 Apr 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXRsKGZC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528454675
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134521; cv=none; b=ssqQQExmZ+9d6DcY1GrTw1pdWd7wbtj63OFAiy2LDpSU75zl+QJTNsXXnNdOqHf9tK3oCwbC4CNN5EV4ZJ5goJdnOks+Si5BLsSH4ulcFsOsnrGnuKhkCe/rwFD3VoNvNZM3eLAWg/1+UudYcsRkNIJqGpjm9J2dJxHaPXQ1III=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134521; c=relaxed/simple;
	bh=iWQKuuTYcNCRmR8DiLEz9UM18ar1MP+qCIom0wHLRDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=je3+OuuZEal6kJmGu+DHpgSOsd8VVlAbFXmYda/Stmid1zFwgvT5RAFFcF824kJXMV0vUEXYhno4OGIbY2HNgO/LxtBeRiMhz2O2zIRe7nvMDyKsR2uN1xsC7jjfOOLHOhTgcwUxsrd+Zotfxnj6DRzsl+s7dqlHCLHfQ8MJ1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXRsKGZC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712134518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GAQ2gVc8UDvD7kVmOgGRLauGuxhEAR8tQtr2zB879yI=;
	b=bXRsKGZCP3TRz6V1FAswEtNUHrE/e8YA0zxcstctuH9QNC1QCXhB6Z/k9VdFVTUTa0xh06
	Oskcm5OJxsXbkRgxYgxNaW4nEY1eCn7IRrVpihKp8trS0Co8ONLY48Ecd8O6UEVZEK61Fr
	LHxY9FLLZmmnSWXWekZyqBE65yiX1bo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-vmgYHSavOOWMI7c0iYGiuQ-1; Wed, 03 Apr 2024 04:55:17 -0400
X-MC-Unique: vmgYHSavOOWMI7c0iYGiuQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4155db7b58cso16847195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712134516; x=1712739316;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAQ2gVc8UDvD7kVmOgGRLauGuxhEAR8tQtr2zB879yI=;
        b=E8Bvbh2N6xqfMWLGIWeUQIZsHfU3aK1g4VAy8xSASqQen0wBpz59+2x0uf8XZIFAgF
         g56UrKCZRZn9wN7FA/JYxx17I2QbVAjYnko6IiFWBDl0xf80ren4br1hkh6Wox3x00Ay
         CmJnPSxvNI+XwnaDwYpCGvUp2jyUmwvFwig8iGqqFhabOYpHajekq/vdMsmG+mLuxDJR
         837Mt0Ju6gDxRXDufk9cvjWoX0nAbGTKPqfzG9Qh0nTB+OQeHCovcZ0WYHQj56sk/8JU
         vxjjzAvRF6p6kVHr99ggSPJ69Aslhhbo5uMmlo75xTV0tTmDXhqjcCne8KnahiVXJvVQ
         dr3A==
X-Forwarded-Encrypted: i=1; AJvYcCUSswvYgnxMR5HZ/jjjQpkoNnlVvLcbFlAGPHmBDHQONG4Tkou6WPjCcWV3oEtPxb+9oP/81AF8/D2NKPh9EMBtoZs2dCiBp+me8Ck8
X-Gm-Message-State: AOJu0YzQOh5VcbhyA2Ng+vG6b+JI+7VWpU26TuJlq6esALVQn1d9S+jo
	fL8Fo28jud+29H7nYeNPlLfnSZNDUcjVcSqW6PFbyKMpOnxHU2XsFOiSaHzXif5QqK2/3Rffj04
	mvd3zQhIDD0Jb7g35tysTX72Jk0edsy5cKssxGTqx6Eoja3GgVgMezi0rqzLluw==
X-Received: by 2002:a05:600c:154b:b0:415:4457:3f8b with SMTP id f11-20020a05600c154b00b0041544573f8bmr11942309wmg.25.1712134515900;
        Wed, 03 Apr 2024 01:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEThRrnTG5bcOn0QNLlX4yZqnr6G1YJOwbJ/I4qtw7qO/E2j8svwwt4eabosu1N3tN9IDabhg==
X-Received: by 2002:a05:600c:154b:b0:415:4457:3f8b with SMTP id f11-20020a05600c154b00b0041544573f8bmr11942290wmg.25.1712134515433;
        Wed, 03 Apr 2024 01:55:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:3100:2d28:e0b7:1254:b2f6? (p200300cbc73b31002d28e0b71254b2f6.dip0.t-ipconnect.de. [2003:cb:c73b:3100:2d28:e0b7:1254:b2f6])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b00414807ef8dfsm21034990wms.5.2024.04.03.01.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:55:14 -0700 (PDT)
Message-ID: <579d5127-c763-4001-9625-4563a9316ac3@redhat.com>
Date: Wed, 3 Apr 2024 10:55:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in
 madvise_cold_or_pageout_pte_range
To: syzbot <syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000662a630615207d87@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Cc: Ryan Roberts <ryan.roberts@arm.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <000000000000662a630615207d87@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.24 19:32, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=155b7db1180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=c641706ad4e9688cccdf
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c641706ad4e9688cccdf@syzkaller.appspotmail.com
> 
> =====================================
> WARNING: bad unlock balance detected!
> 6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
> -------------------------------------
> syz-executor.4/9211 is trying to release lock (ptlock_ptr(ptdesc)) at:
> [<ffffffff81f01c0f>] spin_unlock include/linux/spinlock.h:391 [inline]
> [<ffffffff81f01c0f>] madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
> but there are no more locks to release!
> 
> other info that might help us debug this:
> 1 lock held by syz-executor.4/9211:
>   #0: ffff888067e40b18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
>   #0: ffff888067e40b18 (&mm->mmap_lock){++++}-{3:3}, at: do_madvise+0x481/0x44a0 mm/madvise.c:1429
> 
> stack backtrace:
> CPU: 0 PID: 9211 Comm: syz-executor.4 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   print_unlock_imbalance_bug+0x256/0x2c0 kernel/locking/lockdep.c:5194
>   __lock_release kernel/locking/lockdep.c:5431 [inline]
>   lock_release+0x599/0x9f0 kernel/locking/lockdep.c:5774
>   __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
>   _raw_spin_unlock+0x16/0x50 kernel/locking/spinlock.c:186
>   spin_unlock include/linux/spinlock.h:391 [inline]
>   madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
>   walk_pmd_range mm/pagewalk.c:143 [inline]
>   walk_pud_range mm/pagewalk.c:221 [inline]
>   walk_p4d_range mm/pagewalk.c:256 [inline]
>   walk_pgd_range+0xba1/0x1810 mm/pagewalk.c:293
>   __walk_page_range+0x132/0x720 mm/pagewalk.c:395
>   walk_page_range+0x58f/0x7c0 mm/pagewalk.c:521
>   madvise_cold_page_range mm/madvise.c:562 [inline]
>   madvise_cold mm/madvise.c:584 [inline]
>   madvise_vma_behavior mm/madvise.c:1028 [inline]
>   madvise_walk_vmas mm/madvise.c:1256 [inline]
>   do_madvise+0x1e7b/0x44a0 mm/madvise.c:1442
>   __do_sys_madvise mm/madvise.c:1457 [inline]
>   __se_sys_madvise mm/madvise.c:1455 [inline]
>   __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1455
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x72/0x7a
> RIP: 0033:0x7ff60947dda9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff60a1b50c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007ff6095abf80 RCX: 00007ff60947dda9
> RDX: 0000000000000014 RSI: 0000000000600000 RDI: 0000000020000000
> RBP: 00007ff6094ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007ff6095abf80 R15: 00007fffacd4bc68
>   </TASK>
> ------------[ cut here ]------------
> pvqspinlock: lock 0xffff88802ed23120 has corrupted value 0x0!
> WARNING: CPU: 1 PID: 9211 at kernel/locking/qspinlock_paravirt.h:510 __pv_queued_spin_unlock_slowpath+0x241/0x2f0 kernel/locking/qspinlock_paravirt.h:508
> Modules linked in:
> CPU: 1 PID: 9211 Comm: syz-executor.4 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:__pv_queued_spin_unlock_slowpath+0x241/0x2f0 kernel/locking/qspinlock_paravirt.h:508
> Code: 65 47 6e f6 4c 89 f0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 9f 00 00 00 41 8b 16 48 c7 c7 c0 26 cb 8b 4c 89 f6 e8 90 f3 cb f5 90 <0f> 0b 90 90 eb 8d 44 89 f1 80 e1 07 38 c1 0f 8c 26 ff ff ff 4c 89
> RSP: 0018:ffffc9000e477238 EFLAGS: 00010246
> RAX: 5e9807e53cfb4f00 RBX: dffffc0000000000 RCX: 0000000000040000
> RDX: ffffc9000b3b8000 RSI: 000000000003ffff RDI: 0000000000040000
> RBP: dffffc0000000000 R08: ffffffff81580192 R09: fffffbfff1c39b10
> R10: dffffc0000000000 R11: fffffbfff1c39b10 R12: 1ffff11005da4626
> R13: ffff88802ed23130 R14: ffff88802ed23120 R15: ffff88802ed23120
> FS:  00007ff60a1b56c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fea8ecdaab3 CR3: 000000005d0fe000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
>   .slowpath+0x9/0x16
>   pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:589 [inline]
>   queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
>   do_raw_spin_unlock+0x13c/0x8b0 kernel/locking/spinlock_debug.c:142
>   __raw_spin_unlock include/linux/spinlock_api_smp.h:142 [inline]
>   _raw_spin_unlock+0x1e/0x50 kernel/locking/spinlock.c:186
>   spin_unlock include/linux/spinlock.h:391 [inline]
>   madvise_cold_or_pageout_pte_range+0x170f/0x3990 mm/madvise.c:480
>   walk_pmd_range mm/pagewalk.c:143 [inline]
>   walk_pud_range mm/pagewalk.c:221 [inline]
>   walk_p4d_range mm/pagewalk.c:256 [inline]
>   walk_pgd_range+0xba1/0x1810 mm/pagewalk.c:293
>   __walk_page_range+0x132/0x720 mm/pagewalk.c:395
>   walk_page_range+0x58f/0x7c0 mm/pagewalk.c:521
>   madvise_cold_page_range mm/madvise.c:562 [inline]
>   madvise_cold mm/madvise.c:584 [inline]
>   madvise_vma_behavior mm/madvise.c:1028 [inline]
>   madvise_walk_vmas mm/madvise.c:1256 [inline]
>   do_madvise+0x1e7b/0x44a0 mm/madvise.c:1442
>   __do_sys_madvise mm/madvise.c:1457 [inline]
>   __se_sys_madvise mm/madvise.c:1455 [inline]
>   __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1455
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x72/0x7a
> RIP: 0033:0x7ff60947dda9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff60a1b50c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007ff6095abf80 RCX: 00007ff60947dda9
> RDX: 0000000000000014 RSI: 0000000000600000 RDI: 0000000020000000
> RBP: 00007ff6094ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007ff6095abf80 R15: 00007fffacd4bc68
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

I'd suspect:

commit 38456b4a3c609b205d5fdc6ef5347824a83fd818
Author: Ryan Roberts <ryan.roberts@arm.com>
Date:   Wed Mar 27 14:45:37 2024 +0000

     mm: madvise: avoid split during MADV_PAGEOUT and MADV_COLD

but I don't immediately see the issue. CCing Ryan.

-- 
Cheers,

David / dhildenb


