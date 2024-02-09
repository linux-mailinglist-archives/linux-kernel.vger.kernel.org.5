Return-Path: <linux-kernel+bounces-59496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D275484F7F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98E41C21FBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1575B6F07C;
	Fri,  9 Feb 2024 14:57:21 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26936DCE7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490640; cv=none; b=kEYPSStUcqjptjcyIKd23pQ/JOuAGbBb7EKXXIz2Shzuiqg/p7uqKahuac0b7ZqCVxkqxhWCj9JsZl0DfyQW1vhswaey1/vUZTDpaKa8K/k/FeG3ZeXWcv6DiYV4b0n1FpB6r8qZ/yenaFBLzAs2k8jCnjC89NnEEi8rglacc6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490640; c=relaxed/simple;
	bh=1GkUptlAGWiFzmVyFPJnkTLCBRWyXZKVXwJz1OpOL+w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xpi7XUKfXhEiRPJ5oUQJIIVDDFRrFvEofPbp1hsadPyCZzoVAHBzDIvnDz42bYuePS/wifpfepHKymPJnpFrIcezSY5KiXDFKCmjYWat5i8SqiR3tLIHfD015xpmwX3WqoRz/cyr1815+oSRaOyc7k2gzKXyDs4xf+cXZ54vhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363e8f7ab20so5051365ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 06:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490638; x=1708095438;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7Puv2RhPnFRFU7g/xtnaNvGInJRzTflHLAZrr7bSvY=;
        b=d9irBBa0UtF1Rl1EqQy8ry7UCrxAuyZOeC1heaEgUdq2VHODXitguh+mUvpyPYYiXB
         a2K2b0Rwtb+j32I6/1bqqXC5LUzf+WSAp7fPZvRL44XpJNXDOyaNsp2sbrmUnm/WohCX
         J2mlWXGVuUWhmHivuRextO66tCwPIieFwlsG6i6WBobW9MiocUmCEjqT/r+J6O/l5w0n
         YmAQorDnnNiB1KLqXChd27bWC4LvRZKz9SJa6ah4OFS97Rai5xHVJA+mvTaTuaBPOe1q
         zOeTRCCnBD7neJg8dy1+98Eb5H0xqHUu/PR6kCyuM677FCHm2zNR7mo7Wbtp4MUXF+Zk
         rtFg==
X-Gm-Message-State: AOJu0YzNZx+E9SW3tFxQiUPbFUHrgB8EHs7vGBWspj5UXBpEZpHoR+IH
	YB7mwBxRL6BIfXxa1ILF7BYnKgPPUIvGmlky6ulC1jzcU7zNL9/caor0S/Ha2ceS2gSS1y7UsBS
	8CTKlzcikjpIx+1C6LMs9ktziSSyWPFLDgQTeCvbb1jnkaBGmha1tcX4=
X-Google-Smtp-Source: AGHT+IFNBCVh1gKLKcUcrGT1ZHGiHMQU0Q/sfIWkI0Sx6XESTM8aYVjsMRLWQJyswJlKG/r+J5S+CCw7WVGl5vuChWu4xIP38aKv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c263:0:b0:363:cdfb:7fd1 with SMTP id
 h3-20020a92c263000000b00363cdfb7fd1mr110124ild.1.1707490637906; Fri, 09 Feb
 2024 06:57:17 -0800 (PST)
Date: Fri, 09 Feb 2024 06:57:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee09930610f42470@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in __unix_gc
From: syzbot <syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7689879d14e ethtool: do not use rtnl in ethnl_default_dum..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1195b6e0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac1116e4986e7570
dashboard link: https://syzkaller.appspot.com/bug?extid=5a630f8ca0120ab43f55
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121d9b5c180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165f9cec180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c5b791d72e1e/disk-e7689879.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/472cf2131e7b/vmlinux-e7689879.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1e5a4b33244/bzImage-e7689879.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __unix_gc+0xe0f/0xf70
Read of size 8 at addr ffff8880237e3640 by task kworker/u4:4/59

CPU: 0 PID: 59 Comm: kworker/u4:4 Not tainted 6.8.0-rc3-syzkaller-00766-ge7689879d14e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound __unix_gc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 __unix_gc+0xe0f/0xf70
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 5076:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:314 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x16f/0x340 mm/slub.c:3867
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2073
 sk_alloc+0x38/0x370 net/core/sock.c:2132
 unix_create1+0xb4/0x7f0
 unix_create+0x14e/0x200 net/unix/af_unix.c:1047
 __sock_create+0x48f/0x920 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socketpair+0x33d/0x720 net/socket.c:1773
 __do_sys_socketpair net/socket.c:1822 [inline]
 __se_sys_socketpair net/socket.c:1819 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 23:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
 __kasan_slab_free+0x34/0x70 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
 sk_prot_free net/core/sock.c:2113 [inline]
 __sk_destruct+0x470/0x5f0 net/core/sock.c:2207
 sock_put include/net/sock.h:1961 [inline]
 unix_release_sock+0x903/0xd20 net/unix/af_unix.c:649
 unix_release+0x91/0xc0 net/unix/af_unix.c:1062
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x429/0x8a0 fs/file_table.c:376
 delayed_fput+0x59/0x80 fs/file_table.c:399
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff8880237e3000
 which belongs to the cache UNIX-STREAM of size 1920
The buggy address is located 1600 bytes inside of
 freed 1920-byte region [ffff8880237e3000, ffff8880237e3780)

The buggy address belongs to the physical page:
page:ffffea00008df800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x237e0
head:ffffea00008df800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff8880183aa280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5069, tgid 5069 (sftp-server), ts 69550911589, free_ts 69532294849
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmem_cache_alloc+0x24d/0x340 mm/slub.c:3867
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2073
 sk_alloc+0x38/0x370 net/core/sock.c:2132
 unix_create1+0xb4/0x7f0
 unix_stream_connect+0x348/0x1110 net/unix/af_unix.c:1511
 __sys_connect_file net/socket.c:2048 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2072
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
page last free pid 5069 tgid 5069 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 discard_slab mm/slub.c:2453 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2922
 put_cpu_partial+0x17b/0x250 mm/slub.c:2997
 __slab_free+0x302/0x410 mm/slub.c:4166
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x6d/0xd0 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x16f/0x340 mm/slub.c:3867
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:465
 mmap_region+0xbd8/0x1fa0 mm/mmap.c:2806
 do_mmap+0x7ae/0xe60 mm/mmap.c:1379
 vm_mmap_pgoff+0x1e2/0x420 mm/util.c:556
 ksys_mmap_pgoff+0x503/0x6e0 mm/mmap.c:1425
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff8880237e3500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880237e3580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880237e3600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880237e3680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880237e3700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

