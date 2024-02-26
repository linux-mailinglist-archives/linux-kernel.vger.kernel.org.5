Return-Path: <linux-kernel+bounces-81076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4C2866FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B391F25063
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FE45FBBF;
	Mon, 26 Feb 2024 09:41:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2025FB9C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940487; cv=none; b=C8nkSGNrDiyp5EtkHy5KN9Kwtd3HBgKOzWPySc9ZWoYCCpZk9+BBIK3ZeaEKHZwvTMfr0Z3DW+xqXSWj10wfyMEnIqnqW66IKHENXtDVWTzX8+/fhBW74GhniDKgT0ivKbKQk9xHddOi7qGsl1kITxsuHfYTlrTlQQarOgOJomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940487; c=relaxed/simple;
	bh=SkROI4veAh4zi2XehyzLkmSpODJfIKlisIoWr9w7LJs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=RRVjblioXZacaSrOjpwqkEp57cAZfqQsFep6vDQ26CnoEHu2BKCVEyK2Ce/CtmUc4W5a1ADhd3tS0uwL+3T3mbLWiWSMbbHwp+U8NMHuAWGCH+tNfFO1Pjx0UHhnRgmtks3lpbRO3AiORbgkMVPGpRSy8GCzl4Ga+G6+aXrZGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3653311926bso19313925ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940485; x=1709545285;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkROI4veAh4zi2XehyzLkmSpODJfIKlisIoWr9w7LJs=;
        b=XzJRjCNGAXzomSO7o8Slu+KITn8Fps0OL8YPHf69LWrTnspTJFIkGFO9a8GC7HF5kC
         ev0w9gIKO5I9Xv+Do+c8auOQ3JKS49HQs36RxjPcf4OtDou2oOfzyQMLWqo8dXwP5rei
         ph7g3Cl7jPVo21Ipl4DRXJCpc4vd+KdAoBD08BXnVkIaEc6rWOnI28f59y5mhP970DY1
         sdbzIHTCET+3PqLfM0tJG911uceE4yc91s/+oOzjOfEXZlgON9ikFD9QBdaqYJ8beeUU
         lfZrc4ZcThUHHXBoo1fRjBWTEEUiZ+5pwVuK+h+JWEf6vC/E0M0NLE1cMT+W1Px78xfF
         sPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfoiAJcAbhTuF2ER12Gkz5r7hJJ3gKBjF6feMqsaXW5nP96XmU6hMV3IkpzZOMiBL2Mpwi7n45jull8rYpM/IUKy0vlTu9ZT6cUs4z
X-Gm-Message-State: AOJu0YzCMPqfDW9ueSJG6gU8fdSl+jDU1VaaMtwB0BuA9pgNqsO/3tF3
	J8ZkOa9z7sAdBuSZx0t4U1r769BvQCgHR2YNKJuMYjEEl4hXXf/nug96sGjtImi9J9A8DjEWeZi
	DBR/Dutw2XBaAaMp0uDFrpy6D/A5E9oTlLvhb9ZctIiTl5Lz3026w2uo=
X-Google-Smtp-Source: AGHT+IE+RoLt5k2JULI6X9GFGSFEMdQXhvm51DH3fD6JnGX7qWXk0/4qq3TNwjG/8rhkq6b+hRB/4Uui4k2jTH6MCgPGFGga8iT0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c563:0:b0:365:88b:3fba with SMTP id
 b3-20020a92c563000000b00365088b3fbamr344677ilj.1.1708940484825; Mon, 26 Feb
 2024 01:41:24 -0800 (PST)
Date: Mon, 26 Feb 2024 01:41:24 -0800
In-Reply-To: <eafaa9d3-9766-4bdc-8088-dc035a4b8004@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a5b76061245b619@google.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in rdma_resolve_route
From: syzbot <syzbot+a2e2735f09ebb9d95bd1@syzkaller.appspotmail.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca, leon@kernel.org, yanjun.zhu@linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test: https://github.com/zhuyj/linux.git linux_6.8_rc4_rdma_cm

This crash does not have a reproducer. I cannot test it.

>
> =E5=9C=A8 2024/2/26 17:37, Zhu Yanjun =E5=86=99=E9=81=93:
>> =E5=9C=A8 2024/2/23 18:51, syzbot =E5=86=99=E9=81=93:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:=C2=A0=C2=A0=C2=A0 2c3b09aac00d Add linux-next specific fil=
es for 20240214
>>> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1793a064180=
000
>>> kernel config:=20
>>> https://syzkaller.appspot.com/x/.config?x=3D176d2dcbf8ba7017
>>> dashboard link:=20
>>> https://syzkaller.appspot.com/bug?extid=3Da2e2735f09ebb9d95bd1
>>> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 15.0=
6, GNU ld (GNU Binutils for=20
>>> Debian) 2.40
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image:=20
>>> https://storage.googleapis.com/syzbot-assets/ac51042b61c6/disk-2c3b09aa=
raw.xz
>>> vmlinux:=20
>>> https://storage.googleapis.com/syzbot-assets/012344301c35/vmlinux-2c3b0=
9aa.xz
>>> kernel image:=20
>>> https://storage.googleapis.com/syzbot-assets/cba3c3e5cd7c/bzImage-2c3b0=
9aa.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the=20
>>> commit:
>>> Reported-by: syzbot+a2e2735f09ebb9d95bd1@syzkaller.appspotmail.com
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> BUG: KASAN: slab-use-after-free in compare_netdev_and_ip=20
>>> drivers/infiniband/core/cma.c:473 [inline]
>>> BUG: KASAN: slab-use-after-free in cma_add_id_to_tree=20
>>> drivers/infiniband/core/cma.c:513 [inline]
>>> BUG: KASAN: slab-use-after-free in rdma_resolve_route+0x23f7/0x3150=20
>>> drivers/infiniband/core/cma.c:3379
>>> Read of size 4 at addr ffff88808dcf6184 by task syz-executor.4/11929
>>>
>>> CPU: 1 PID: 11929 Comm: syz-executor.4 Not tainted=20
>>> 6.8.0-rc4-next-20240214-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine,=20
>>> BIOS Google 01/25/2024
>>> Call Trace:
>>> =C2=A0 <TASK>
>>> =C2=A0 __dump_stack lib/dump_stack.c:88 [inline]
>>> =C2=A0 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>>> =C2=A0 print_address_description mm/kasan/report.c:377 [inline]
>>> =C2=A0 print_report+0x169/0x550 mm/kasan/report.c:488
>>> =C2=A0 kasan_report+0x143/0x180 mm/kasan/report.c:601
>>> =C2=A0 compare_netdev_and_ip drivers/infiniband/core/cma.c:473 [inline]
>>> =C2=A0 cma_add_id_to_tree drivers/infiniband/core/cma.c:513 [inline]
>>> =C2=A0 rdma_resolve_route+0x23f7/0x3150 drivers/infiniband/core/cma.c:3=
379
>>> =C2=A0 ucma_resolve_route+0x1ba/0x330 drivers/infiniband/core/ucma.c:74=
5
>>> =C2=A0 ucma_write+0x2df/0x430 drivers/infiniband/core/ucma.c:1743
>>> =C2=A0 vfs_write+0x2a4/0xcb0 fs/read_write.c:588
>>> =C2=A0 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>>> =C2=A0 do_syscall_64+0xfb/0x240
>>> =C2=A0 entry_SYSCALL_64_after_hwframe+0x6d/0x75
>>> RIP: 0033:0x7f4eae47dda9
>>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48=20
>>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>=20
>>> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007f4eaf2cd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>>> RAX: ffffffffffffffda RBX: 00007f4eae5abf80 RCX: 00007f4eae47dda9
>>> RDX: 0000000000000010 RSI: 0000000020000440 RDI: 0000000000000003
>>> RBP: 00007f4eae4ca47a R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 000000000000000b R14: 00007f4eae5abf80 R15: 00007fff93bb3dc8
>>> =C2=A0 </TASK>
>>>
>>> Allocated by task 11919:
>>> =C2=A0 kasan_save_stack mm/kasan/common.c:47 [inline]
>>> =C2=A0 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>> =C2=A0 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>>> =C2=A0 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>>> =C2=A0 kasan_kmalloc include/linux/kasan.h:211 [inline]
>>> =C2=A0 kmalloc_trace+0x1d9/0x360 mm/slub.c:4013
>>> =C2=A0 kmalloc include/linux/slab.h:590 [inline]
>>> =C2=A0 kzalloc include/linux/slab.h:711 [inline]
>>> =C2=A0 __rdma_create_id+0x65/0x590 drivers/infiniband/core/cma.c:993
>>> =C2=A0 rdma_create_user_id+0x83/0xc0 drivers/infiniband/core/cma.c:1049
>>> =C2=A0 ucma_create_id+0x2d0/0x500 drivers/infiniband/core/ucma.c:463
>>> =C2=A0 ucma_write+0x2df/0x430 drivers/infiniband/core/ucma.c:1743
>>> =C2=A0 vfs_write+0x2a4/0xcb0 fs/read_write.c:588
>>> =C2=A0 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>>> =C2=A0 do_syscall_64+0xfb/0x240
>>> =C2=A0 entry_SYSCALL_64_after_hwframe+0x6d/0x75
>>>
>>> Freed by task 11915:
>>> =C2=A0 kasan_save_stack mm/kasan/common.c:47 [inline]
>>> =C2=A0 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>> =C2=A0 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:586
>>> =C2=A0 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
>>> =C2=A0 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>>> =C2=A0 kasan_slab_free include/linux/kasan.h:184 [inline]
>>> =C2=A0 slab_free_hook mm/slub.c:2122 [inline]
>>> =C2=A0 slab_free mm/slub.c:4296 [inline]
>>> =C2=A0 kfree+0x14a/0x380 mm/slub.c:4406
>>> =C2=A0 ucma_close_id drivers/infiniband/core/ucma.c:186 [inline]
>>> =C2=A0 ucma_destroy_private_ctx+0x14e/0xc10=20
>>> drivers/infiniband/core/ucma.c:578
>>> =C2=A0 ucma_close+0xfc/0x170 drivers/infiniband/core/ucma.c:1808
>>> =C2=A0 __fput+0x429/0x8a0 fs/file_table.c:411
>>> =C2=A0 __do_sys_close fs/open.c:1557 [inline]
>>> =C2=A0 __se_sys_close fs/open.c:1542 [inline]
>>> =C2=A0 __x64_sys_close+0x7f/0x110 fs/open.c:1542
>>> =C2=A0 do_syscall_64+0xfb/0x240
>>> =C2=A0 entry_SYSCALL_64_after_hwframe+0x6d/0x75
>>>
>>> The buggy address belongs to the object at ffff88808dcf6000
>>> =C2=A0 which belongs to the cache kmalloc-2k of size 2048
>>> The buggy address is located 388 bytes inside of
>>> =C2=A0 freed 2048-byte region [ffff88808dcf6000, ffff88808dcf6800)
>>>
>>> The buggy address belongs to the physical page:
>>> page:ffffea0002373c00 refcount:1 mapcount:0 mapping:0000000000000000=20
>>> index:0x0 pfn:0x8dcf0
>>> head:ffffea0002373c00 order:3 entire_mapcount:0 nr_pages_mapped:0=20
>>> pincount:0
>>> flags: 0xfff80000000840(slab|head|node=3D0|zone=3D1|lastcpupid=3D0xfff)
>>> page_type: 0xffffffff()
>>> raw: 00fff80000000840 ffff888014c42000 dead000000000100 dead00000000012=
2
>>> raw: 0000000000000000 0000000000080008 00000001ffffffff 000000000000000=
0
>>> page dumped because: kasan: bad access detected
>>> page_owner tracks the page as allocated
>>> page last allocated via order 3, migratetype Unmovable, gfp_mask=20
>>> 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_N=
OMEMALLOC),=20
>>> pid 5149, tgid 5149 (kworker/1:4), ts 205905084555, free_ts 0
>>> =C2=A0 set_page_owner include/linux/page_owner.h:31 [inline]
>>> =C2=A0 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
>>> =C2=A0 prep_new_page mm/page_alloc.c:1540 [inline]
>>> =C2=A0 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
>>> =C2=A0 __alloc_pages+0x256/0x6a0 mm/page_alloc.c:4567
>>> =C2=A0 __alloc_pages_node include/linux/gfp.h:238 [inline]
>>> =C2=A0 alloc_pages_node include/linux/gfp.h:261 [inline]
>>> =C2=A0 alloc_slab_page+0x5f/0x160 mm/slub.c:2191
>>> =C2=A0 allocate_slab mm/slub.c:2354 [inline]
>>> =C2=A0 new_slab+0x84/0x2f0 mm/slub.c:2407
>>> =C2=A0 ___slab_alloc+0xc73/0x1260 mm/slub.c:3541
>>> =C2=A0 __slab_alloc mm/slub.c:3626 [inline]
>>> =C2=A0 __slab_alloc_node mm/slub.c:3679 [inline]
>>> =C2=A0 slab_alloc_node mm/slub.c:3851 [inline]
>>> =C2=A0 __do_kmalloc_node mm/slub.c:3981 [inline]
>>> =C2=A0 __kmalloc_node_track_caller+0x2d4/0x4e0 mm/slub.c:4002
>>> =C2=A0 kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:582
>>> =C2=A0 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:651
>>> =C2=A0 alloc_skb include/linux/skbuff.h:1296 [inline]
>>> =C2=A0 alloc_skb_with_frags+0xc3/0x780 net/core/skbuff.c:6394
>>> =C2=A0 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
>>> =C2=A0 sock_alloc_send_skb include/net/sock.h:1855 [inline]
>>> =C2=A0 mld_newpack+0x1c3/0xa90 net/ipv6/mcast.c:1746
>>> =C2=A0 add_grhead net/ipv6/mcast.c:1849 [inline]
>>> =C2=A0 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1987
>>> =C2=A0 mld_send_cr net/ipv6/mcast.c:2113 [inline]
>>> =C2=A0 mld_ifc_work+0x6bf/0xb30 net/ipv6/mcast.c:2650
>>> =C2=A0 process_one_work kernel/workqueue.c:3146 [inline]
>>> =C2=A0 process_scheduled_works+0x9d7/0x1730 kernel/workqueue.c:3226
>>> =C2=A0 worker_thread+0x86d/0xd70 kernel/workqueue.c:3307
>>> page_owner free stack trace missing
>>>
>>> Memory state around the buggy address:
>>> =C2=A0 ffff88808dcf6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
>>> =C2=A0 ffff88808dcf6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
>>>> ffff88808dcf6180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>> =C2=A0 ffff88808dcf6200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
>>> =C2=A0 ffff88808dcf6280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>
>>> If the report is already addressed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want to overwrite report's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the report is a duplicate of another one, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>

