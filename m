Return-Path: <linux-kernel+bounces-132505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844708995FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117111F22D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8852D03C;
	Fri,  5 Apr 2024 06:55:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C028DAB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300128; cv=none; b=TIgT0SiY8hrWATQnjix/3I78lFQ7ben2bkaes4d6RmlTE/vppmxzEigD4I655Mt4FXRxshslh0/mJ/cZXtgpX+XuwY4ymxRzJ9pEwoW2CIXw2GYbhwoDws+T50fYduKS6l951ZDxVplOJCY5TqQdtvQ4lahnG7iWIE4lmaGlw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300128; c=relaxed/simple;
	bh=e78tKgv3BstXDrMcwvGnF8ZdaCgneNK+UMS5ucdmOYQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t0FVhLWMon4bUbmqosV2ShzGw7kN3LgvSAyGerecIroQwXbLXo3n79ZJvPixPxKXDBYB80MzUn31EtATYZd789wQopQls3OYG1m37w1t77ow7507olh25h0o4Un+NvFapoYxL+02NZkaAUGv22Ab9YfEeMnCQmdsbW6mrzDyPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so193828239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300125; x=1712904925;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZuoOMkIddIxcCuLMNOg09YDXxxR2pBIVhNHkuy40PU=;
        b=O8Mn+dy8Yi+4SsxRPfmjgNT4JjcqyEgVA4c999pOa4DRct77CERIeSG7GpXEbjHw1D
         VoQMZsiltCnN/LQ6aEuDDgJHtRPFoLcLbZ7cNbaNGiz3dfqR8k2htsOJgzVpPb2gcqtV
         wJwQpoGZweSZDyI9Xn0jdfmWPb/qpvOUz2mkrk6VnQNbxf7vAT1ZMnRWbdswtxrHrG2K
         iDR4pwdHdGWs6Flx1fL5mkAfpDo7gvc7uhJsD/BdqFhNOu6Ko2xQTlhKnudrC9bu8j0u
         bedM9yNYMFVCVJQwv+MxP0KGxCCArRYIy8BivKw3eNzGaocQQ6Elo4T0r4RE20KdQpmh
         mViA==
X-Forwarded-Encrypted: i=1; AJvYcCWExmzCDIxbGYRRTmpxApVntiqIKA7SL0i2iWIMnB77CLjTBLGqhhi5d73aYUlCGxFqb2CT3C1Bjp10XKZ12g+Qz+5HdEYwLTs0AiWF
X-Gm-Message-State: AOJu0Yy1KLH1Ejt+pKF2F4eVt+XKaXYfrV14awh4aL6Qgs0bfcNbVwoJ
	ex2xzS+j0Mx4u6NozKw/VLAcDZfx0SN3MzaI0deSkcwUgRPvP/VgD5k5S7ammZtqe1WUwzMA7/r
	GE8z7oS4m/4bka0YCjAMnp/z3DPTHnFfxCQ7zy7MfsB8AcJan9p9nxP8=
X-Google-Smtp-Source: AGHT+IF1UaxHswGz64oCwaDVvqzmgMbNKh+bTLIgS6cZJp6+a1VrLr9Yf2rbhhobSfwsq3kR1A+hmbkRdiMAe7EN9LHiRqpTYWes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:36a:1132:8bc5 with SMTP id
 e4-20020a056e020b2400b0036a11328bc5mr8130ilu.3.1712300125429; Thu, 04 Apr
 2024 23:55:25 -0700 (PDT)
Date: Thu, 04 Apr 2024 23:55:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9b20e061553f06e@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in rfcomm_sock_setsockopt
From: syzbot <syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=176e2415180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=d4ecae01a53fd9b42e7d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118f9af9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a0ad29180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
BUG: KASAN: slab-out-of-bounds in rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
Read of size 4 at addr ffff8880209a8bc3 by task syz-executor632/5064

CPU: 0 PID: 5064 Comm: syz-executor632 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 copy_from_sockptr include/linux/sockptr.h:55 [inline]
 rfcomm_sock_setsockopt_old net/bluetooth/rfcomm/sock.c:632 [inline]
 rfcomm_sock_setsockopt+0x893/0xa70 net/bluetooth/rfcomm/sock.c:673
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f36ff898dc9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe010c2208 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f36ff898dc9
RDX: 0000000000000003 RSI: 0000000000000012 RDI: 0000000000000006
RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000000000000
R10: 00000000200000c0 R11: 0000000000000246 R12: 0000555567399338
R13: 000000000000000e R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5064:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc+0x233/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1869
 do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff8880209a8bc0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes to the right of
 allocated 2-byte region [ffff8880209a8bc0, ffff8880209a8bc2)

The buggy address belongs to the physical page:
page:ffffea0000826a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x209a8
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41280 ffffea000081fb80 dead000000000002
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 9917548498, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
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
 kmalloc_array include/linux/slab.h:665 [inline]
 kcalloc include/linux/slab.h:696 [inline]
 group_cpus_evenly+0x294/0x5f0 lib/group_cpus.c:365
 blk_mq_map_queues+0x4c/0x3e0 block/blk-mq-cpumap.c:23
 blk_mq_alloc_tag_set+0x7ac/0xf40 block/blk-mq.c:4521
 nbd_dev_add+0x367/0xc80 drivers/block/nbd.c:1831
 nbd_init+0x224/0x2e0 drivers/block/nbd.c:2593
 do_one_initcall+0x238/0x830 init/main.c:1241
 do_initcall_level+0x157/0x210 init/main.c:1303
 do_initcalls+0x3f/0x80 init/main.c:1319
 kernel_init_freeable+0x435/0x5d0 init/main.c:1550
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880209a8a80: 06 fc fc fc 06 fc fc fc 06 fc fc fc 07 fc fc fc
 ffff8880209a8b00: fa fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
>ffff8880209a8b80: fa fc fc fc fa fc fc fc 02 fc fc fc fa fc fc fc
                                           ^
 ffff8880209a8c00: 00 fc fc fc 00 fc fc fc 00 fc fc fc 05 fc fc fc
 ffff8880209a8c80: 05 fc fc fc 05 fc fc fc fa fc fc fc 00 fc fc fc
==================================================================


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

