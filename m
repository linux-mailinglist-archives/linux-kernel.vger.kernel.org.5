Return-Path: <linux-kernel+bounces-152735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191C8AC39A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC893281C61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC817BD6;
	Mon, 22 Apr 2024 05:23:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76F1759F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763386; cv=none; b=AKTlKbmTnMdK3PuSbCj+PHjXqKJ6LqRUnE1uPysfRppVcIzwrckEWKWB+TW2aQ20RD7/wexaGtobV5TA5FrpCMW1TgmNMIg9aOc1QnO6rWLFlM8nwIehy0rERRYSMPTPNiu2WsY0h3knhtGlwxcBL4GDbNY9dJWvdLX4UTOfxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763386; c=relaxed/simple;
	bh=HWsvL9K3QmDhUu5pkZNIBP6ppeksDVaGOYp25K/IF+g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TnVg+h0X3iDMpEHE0qFwuM2X8koYpMf6NLcmqZDSXSpZBzIujcz6n9BSzD0tLQ2k+m70pS5J3O2iEFrEgmpIY1pUPnZ2Xkj62hrkM7siuvLFEFz7rtkvmeKJrr3eNBp4KnCzGBSmlNPg8F/GmIT1KAH+18oH2daIZfzaSVGN7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso580780739f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763383; x=1714368183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeBoYdpULXY90jBen4Zv0r8EJ4Gu0osULAnjpvQ0DCg=;
        b=FSjywj0p67pGyInifoNfp4RttrKsDF/SFDgOJhRsCPXkDnAq1PZOjbKxc8lQQOnHnC
         jwp6e8CzGXvKzdVeTaNmDpsYKjIwuq3VnbkakSk5d2Ni8OKjCpN8ZJ/pXhXu+vV1G9EO
         bvd5FogAOwmS048zHRwTWIeWBHoTdVZJObGp6J8R3QBr2BIfBloaxABOaKBNSZDRrMGZ
         i9KZ79TSugEY+4+F4wsAee8bwoIppH4BA2T9ex3kq7/kuz/hvfxGKCV8b/3Qukm8kvmH
         FTF470NHO8IK6U4+kDSWbeSeHA9snf3A7sGdip3NvUG2CDQWUa1UUl1cF6Imw3OSOpt2
         t/9A==
X-Forwarded-Encrypted: i=1; AJvYcCUATFBPbZV5o44/ff28ajebf8l47CaxcgFX1xSONttHlpeoP7fKjYi/0wnO8cwz7iiySQpBKkWPOsJrHQnQErTfs3yylGNcwK8syMV4
X-Gm-Message-State: AOJu0Yyu9KkShz9unl7WcXy9t42XEyipVuuq7SvTTTAiiFqF7F03pm/J
	Pmxx6V05O9GBr/yFQI8BTMMLsIlrXysOCuMEqJojCO0FyawUTtTiwgFBfzf436V1UzNdbkoBQmG
	u1DRqPiS5sImHe+SVeBNdURM8vG58ccMkCPUzfgJgCxkNnQlKqc9Jhso=
X-Google-Smtp-Source: AGHT+IFG2BZSpPwiqnR6sh9xEbV6UaKeI+n7SeCgeza3pxj+juVjJOSH9exuwkcUTvOEobomuvz4J8MYC5gf2cBjf16axbL/2DAL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:861c:b0:485:5afc:d453 with SMTP id
 iu28-20020a056638861c00b004855afcd453mr11953jab.2.1713763383520; Sun, 21 Apr
 2024 22:23:03 -0700 (PDT)
Date: Sun, 21 Apr 2024 22:23:03 -0700
In-Reply-To: <20240422051024.137484-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b43da80616a8a127@google.com>
Subject: Re: [syzbot] [jffs2?] [nilfs?] KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass
From: syzbot <syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in jffs2_garbage_collect_pass

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:587 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
Read of size 8 at addr ffff888061ba6130 by task jffs2_gcd_mtd0/5501

CPU: 0 PID: 5501 Comm: jffs2_gcd_mtd0 Not tainted 6.9.0-rc5-syzkaller-ged30a4a51bb1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
 jffs2_garbage_collect_pass+0xae/0x2120 fs/jffs2/gc.c:134
 jffs2_garbage_collect_thread+0x651/0x6e0 fs/jffs2/background.c:155
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5495:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 jffs2_init_fs_context+0x4f/0xc0 fs/jffs2/super.c:313
 alloc_fs_context+0x68a/0x800 fs/fs_context.c:318
 do_new_mount+0x160/0xb40 fs/namespace.c:3331
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5428:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x153/0x3a0 mm/slub.c:4390
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888061ba6000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 304 bytes inside of
 freed 4096-byte region [ffff888061ba6000, ffff888061ba7000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x61ba0
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015042140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015042140 dead000000000122 0000000000000000
head: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea000186e801 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5494, tgid -833224093 (syz-executor.0), ts 5495, free_ts 89333775363
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x2e5/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x255/0x500 security/tomoyo/file.c:771
 security_file_open+0x69/0x570 security/security.c:2961
 do_dentry_open+0x327/0x15a0 fs/open.c:942
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
page last free pid 5445 tgid 5445 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __slab_free+0x31b/0x3d0 mm/slub.c:4192
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x174/0x340 mm/slub.c:3852
 getname_flags+0xbd/0x4f0 fs/namei.c:139
 getname fs/namei.c:218 [inline]
 __do_sys_rename fs/namei.c:5084 [inline]
 __se_sys_rename fs/namei.c:5082 [inline]
 __x64_sys_rename+0x5f/0xa0 fs/namei.c:5082
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888061ba6000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888061ba6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888061ba6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888061ba6180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888061ba6200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         ed30a4a5 Linux 6.9-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133bb3ab180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab247b9c410b3012
dashboard link: https://syzkaller.appspot.com/bug?extid=e84662c5f30b8c401437
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

