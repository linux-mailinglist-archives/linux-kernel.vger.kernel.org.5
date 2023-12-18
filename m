Return-Path: <linux-kernel+bounces-3852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 616908173F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACE31F239FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EDA3A1D1;
	Mon, 18 Dec 2023 14:43:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1E37897
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b738d08e3bso350628939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910607; x=1703515407;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vioS6WCgWSzjQBbXNG6yDsdxh1nAycWDzruz4nPqew=;
        b=StU9KRrTnr/5zJlcn3wCHEDgvMNVwNLkrEQx+9b376i6LNAtYTGdsYezydAS3NhEhZ
         EAUeJZHU/K94OPg83SC6ieyxmTOWc6hb7WGDNtruuGVV9XQkj1YZJ1hrjDkzs1g+u8xl
         z1HY0sdX+8bp0fHLWIMjG0CjwOx2sOVMKlEdLj9MweAqJCLW5FvcdKOStPFjYEe4PiLw
         vFdDpG4kXMbUpakRuOyjiH8dQVQfHUqK/CimZbNWM99BYuEByOIxNbx41xgaU5CSzP3M
         YHOlwgVo3mqVY4wbcxoeZQZs3vdUZ1hku0fHLKWKmrW7C4JIOhaePr2bfFYs/fzajw/c
         3Y9g==
X-Gm-Message-State: AOJu0Yzd5TAQOOZphmw0RJAGMT/F0yq27jo/wb9WQOdrBIBu/i5z+vDe
	VbXhdQKWJrWqCfU8ZPTh5TS8+/+2aRyfM/rLTX4OVtf08xME
X-Google-Smtp-Source: AGHT+IFzwBzXwniMQO8Ayoe2Ty41p1GAi9lWySlAgzNKTD1ATpHx5ELRgCninBN0TMZFZD7nfsKdEmq7u0nEiLGsuTTq6HZ7XDpb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:35f:b057:d899 with SMTP id
 d10-20020a056e02214a00b0035fb057d899mr347453ilv.4.1702910606812; Mon, 18 Dec
 2023 06:43:26 -0800 (PST)
Date: Mon, 18 Dec 2023 06:43:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdad2b060cc9c542@google.com>
Subject: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in nla_find
From: syzbot <syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	keescook@chromium.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    358105ab92fc Merge branch 'tcp-dccp-refine-source-port-sel..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10b28c06e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df5e944701db1d04
dashboard link: https://syzkaller.appspot.com/bug?extid=f43a23b6e622797c7a28
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13250e06e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16331cd1e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72500aefe96d/disk-358105ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e4eb60a8a727/vmlinux-358105ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a645dff90bd/bzImage-358105ab.xz

The issue was bisected to:

commit 172db56d90d29e47e7d0d64885d5dbd92c87ec42
Author: Kees Cook <keescook@chromium.org>
Date:   Wed Dec 6 20:59:07 2023 +0000

    netlink: Return unsigned value for nla_len()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134506c6e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c506c6e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=174506c6e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com
Fixes: 172db56d90d2 ("netlink: Return unsigned value for nla_len()")

==================================================================
BUG: KASAN: slab-use-after-free in nla_ok include/net/netlink.h:1230 [inline]
BUG: KASAN: slab-use-after-free in nla_find+0x120/0x130 lib/nlattr.c:746
Read of size 2 at addr ffff88807bc42ca0 by task syz-executor426/5060

CPU: 1 PID: 5060 Comm: syz-executor426 Not tainted 6.7.0-rc5-syzkaller-01062-g358105ab92fc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 nla_ok include/net/netlink.h:1230 [inline]
 nla_find+0x120/0x130 lib/nlattr.c:746
 nla_find_nested include/net/netlink.h:1260 [inline]
 ____bpf_skb_get_nlattr_nest net/core/filter.c:209 [inline]
 bpf_skb_get_nlattr_nest+0x178/0x1f0 net/core/filter.c:192
 </TASK>

Allocated by task 4521:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc_node+0x5c/0x90 mm/slab_common.c:1014
 kmalloc_node include/linux/slab.h:620 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:617
 kvmalloc include/linux/slab.h:738 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x80b/0x1280 fs/seq_file.c:210
 kernfs_fop_read_iter+0x410/0x580 fs/kernfs/file.c:279
 call_read_iter include/linux/fs.h:2014 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4d4/0x8f0 fs/read_write.c:470
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88807bc42000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3232 bytes inside of
 freed 4096-byte region [ffff88807bc42000, ffff88807bc43000)

The buggy address belongs to the physical page:
page:ffffea0001ef1000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7bc40
head:ffffea0001ef1000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff88801304f500 ffffea0001dc3000 dead000000000002
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4525, tgid 4525 (udevd), ts 40899198633, free_ts 40892363839
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1544
 prep_new_page mm/page_alloc.c:1551 [inline]
 get_page_from_freelist+0xa28/0x3730 mm/page_alloc.c:3319
 __alloc_pages+0x22e/0x2420 mm/page_alloc.c:4575
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x283/0x3c0 mm/slub.c:2070
 ___slab_alloc+0x979/0x1500 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node+0x4c/0x90 mm/slab_common.c:1014
 kmalloc_node include/linux/slab.h:620 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:617
 kvmalloc include/linux/slab.h:738 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x80b/0x1280 fs/seq_file.c:210
 kernfs_fop_read_iter+0x410/0x580 fs/kernfs/file.c:279
 call_read_iter include/linux/fs.h:2014 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4d4/0x8f0 fs/read_write.c:470
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1144 [inline]
 free_unref_page_prepare+0x53c/0xb80 mm/page_alloc.c:2354
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2494
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:763 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x195/0x310 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node+0x4c/0x90 mm/slab_common.c:1014
 kmalloc_node include/linux/slab.h:620 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:617
 kvmalloc include/linux/slab.h:738 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x80b/0x1280 fs/seq_file.c:210
 kernfs_fop_read_iter+0x410/0x580 fs/kernfs/file.c:279
 call_read_iter include/linux/fs.h:2014 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4d4/0x8f0 fs/read_write.c:470
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff88807bc42b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807bc42c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807bc42c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88807bc42d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807bc42d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

