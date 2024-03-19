Return-Path: <linux-kernel+bounces-107597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12B87FEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA041C22B32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680080605;
	Tue, 19 Mar 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ls1rnrpO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D92B9A3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855465; cv=none; b=b/yhQYGPfLB5fe33kPyCMt1FlpVRTwCCYh0nnVRmUBs9lQfeaK5NHqJKdKcB80b5tBYSjnjS8zrBI0pgRujl4BL/IFO51dOzjRyi/iyzB8Z8vyggkHo10/dFxECjqGU+zzSHC3ZzA2Zkhb/ZS6wTa2dRCcQN7BPiLTmYWRFtlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855465; c=relaxed/simple;
	bh=yxSEtuBfdpbpKHKVHOVy+FXKOGJJkC920dCB3ggyEJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=kAIzu/IQrQmf+1FDWCWYAbZD5G3jhk1YEwX/uo+cgQvYzWSuqcK7C5lvDsIb7VxTSsjy7PHmlVe+VY1awsS5IuBJGko+sk6U8rkMPUT0U51PO0HWXurGDCDGbPoDBTXnb/ZFLlYQKa5uzFvf0E3zk+RfUCVOiJFErjaNOW9o3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ls1rnrpO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710855462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MxyCFGL3dUv8t3voy9dtj3Mc7a5BEmbjD+n1Sw8W14Q=;
	b=Ls1rnrpOKM4WV4HgXX4bccuMvDIi3bWFY9dY8CPUwczmUK9rhfcWwn/Q/C2XjHlSCHcg+0
	tYsOKdx/Xw7yhbk9lrpggua5cP6Qu7uv31yZoQ9LISEUUx3/3FrJwKzK0wb92Q2h2NvjdI
	7d45LbcAMzTHRenMVapUl1vgdPgBqYc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-ggdZ2c77OYeAOstgSDJgDQ-1; Tue, 19 Mar 2024 09:37:40 -0400
X-MC-Unique: ggdZ2c77OYeAOstgSDJgDQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ec6c43a9cso4316839f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855459; x=1711460259;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
         :from:references:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxyCFGL3dUv8t3voy9dtj3Mc7a5BEmbjD+n1Sw8W14Q=;
        b=tHXyNdcIta/pr3m0KfrRM3z0wBIgSlpSBufP0qjP1LMRASVQqmO1WLkmV8R5zwynGP
         PcMsJGCGSz1BBnAXkTzjDaPwFVTKdUKaHVdYl87e1XVReyRT8OmsamSmGdzn8mlaBVVW
         oayXFgkbXFI3L4GZ13GuoznMpLESUVyiF5SWAA5lQdNyP/FXiIYgX5/52pJzVVdm4RUB
         uMQMiPZaeqtC8rqGw5obKaHp7Dm5OQdcrWY2oi5ofR8GMF17vvhE/QxLry9o+Qi+CO43
         rXo/yxMK0w9D2pUhHCSumeoJ8vX96VYjPIvMth0/iOz8nbfNB7TulvSqMaYFKgZjNpr7
         1CCA==
X-Forwarded-Encrypted: i=1; AJvYcCWVpx2o/rKsEbV37J7WwkpjOQtzEMHI3tCd2teAFkk+RCOtOUQXIFn4G2PluvIEm6x4hitkIfWcOglQNTfHgvFJeWM3GsdkcxvbrlCo
X-Gm-Message-State: AOJu0YykvKFtQuYKnMUlaZqBDnApcIxoc7jcFkndrqfnSVZdexebXC0y
	ew0ixlE+hvF+hxr4qN8IFFl5a2IyMT6Cn/AOLKHQmK3W9WeSFHor/kOoLg4afdxQwSVIba1PllR
	AZ8kcA7tnqo5fb4ZbL2j5B1vfzrDvOVXdEPhbhszWZmoXcSN/RJQpQU1Gdcs/AQ==
X-Received: by 2002:a05:600c:3503:b0:414:1fc:2ef3 with SMTP id h3-20020a05600c350300b0041401fc2ef3mr8698341wmq.29.1710855459089;
        Tue, 19 Mar 2024 06:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3gWTwLnaZWWcZXUby0wDJsC8Fa52Yd1ubXiOFKvZijsbRPyQjBgTVDP5+rwAX3plyGlXu+w==
X-Received: by 2002:a05:600c:3503:b0:414:1fc:2ef3 with SMTP id h3-20020a05600c350300b0041401fc2ef3mr8698318wmq.29.1710855458562;
        Tue, 19 Mar 2024 06:37:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:2200:2adc:9a8d:ae91:2e9f? (p200300cbc74122002adc9a8dae912e9f.dip0.t-ipconnect.de. [2003:cb:c741:2200:2adc:9a8d:ae91:2e9f])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b0041468f79fd5sm337110wmb.16.2024.03.19.06.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 06:37:38 -0700 (PDT)
Message-ID: <b2a158a7-e0f1-42dc-9620-1d1d511d566f@redhat.com>
Date: Tue, 19 Mar 2024 14:37:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] possible deadlock in move_pages
Content-Language: en-US
To: syzbot <syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000e97f090614006d76@google.com>
From: David Hildenbrand <david@redhat.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <000000000000e97f090614006d76@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.24 10:52, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=160dc26e180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4ffb854606e658d
> dashboard link: https://syzkaller.appspot.com/bug?extid=49056626fe41e01f2ba7
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f467b9180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173b7ac9180000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e5eb28f6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a5c7ad05d6b2/vmlinux-e5eb28f6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/531cb1917612/bzImage-e5eb28f6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.8.0-syzkaller-09791-ge5eb28f6d1af #0 Not tainted
> --------------------------------------------
> syz-executor258/5169 is trying to acquire lock:
> ffff88802a6d23d0 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_lock mm/userfaultfd.c:1447 [inline]
> ffff88802a6d23d0 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0xbab/0x4970 mm/userfaultfd.c:1583
> 
> but task is already holding lock:
> ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_lock mm/userfaultfd.c:1445 [inline]
> ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0xb6f/0x4970 mm/userfaultfd.c:1583
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&vma->vm_lock->lock);
>    lock(&vma->vm_lock->lock);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 2 locks held by syz-executor258/5169:
>   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:146 [inline]
>   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: uffd_move_lock mm/userfaultfd.c:1438 [inline]
>   #0: ffff888015086a20 (&mm->mmap_lock){++++}-{3:3}, at: move_pages+0x8df/0x4970 mm/userfaultfd.c:1583
>   #1: ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: uffd_move_lock mm/userfaultfd.c:1445 [inline]
>   #1: ffff88802a6d2580 (&vma->vm_lock->lock){++++}-{3:3}, at: move_pages+0xb6f/0x4970 mm/userfaultfd.c:1583
> 
> stack backtrace:
> CPU: 2 PID: 5169 Comm: syz-executor258 Not tainted 6.8.0-syzkaller-09791-ge5eb28f6d1af #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
>   check_deadlock kernel/locking/lockdep.c:3062 [inline]
>   validate_chain kernel/locking/lockdep.c:3856 [inline]
>   __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
>   lock_acquire kernel/locking/lockdep.c:5754 [inline]
>   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
>   down_read+0x9a/0x330 kernel/locking/rwsem.c:1526
>   uffd_move_lock mm/userfaultfd.c:1447 [inline]
>   move_pages+0xbab/0x4970 mm/userfaultfd.c:1583
>   userfaultfd_move fs/userfaultfd.c:2008 [inline]
>   userfaultfd_ioctl+0x5e1/0x60e0 fs/userfaultfd.c:2126
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:904 [inline]
>   __se_sys_ioctl fs/ioctl.c:890 [inline]
>   __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fd48da20329
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd1244f8e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffd1244fab8 RCX: 00007fd48da20329
> RDX: 00000000200000c0 RSI: 00000000c028aa05 RDI: 0000000000000003
> RBP: 00007fd48da93610 R08: 00007ffd1244fab8 R09: 00007ffd1244fab8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffd1244faa8 R14: 0000000000000001 R15: 0000000000000001
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

Possibly

commit 867a43a34ff8a38772212045262b2c9b77807ea3
Author: Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu Feb 15 10:27:56 2024 -0800

     userfaultfd: use per-vma locks in userfaultfd operations
     
     All userfaultfd operations, except write-protect, opportunistically use
     per-vma locks to lock vmas.  On failure, attempt again inside mmap_lock
     critical section.
     
     Write-protect operation requires mmap_lock as it iterates over multiple
     vmas.

and

commit 5e4c24a57b0c126686534b5b159a406c5dd02400
Author: Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu Feb 15 10:27:54 2024 -0800

     userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
     
     Increments and loads to mmap_changing are always in mmap_lock critical
     section.  This ensures that if userspace requests event notification for
     non-cooperative operations (e.g.  mremap), userfaultfd operations don't
     occur concurrently.
     
     This can be achieved by using a separate read-write semaphore in
     userfaultfd_ctx such that increments are done in write-mode and loads in
     read-mode, thereby eliminating the dependency on mmap_lock for this
     purpose.
     
     This is a preparatory step before we replace mmap_lock usage with per-vma
     locks in fill/move ioctls.

might responsible.

CCin Lokesh

-- 
Cheers,

David / dhildenb


