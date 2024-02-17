Return-Path: <linux-kernel+bounces-69661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9392858CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 03:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CD2B21885
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2A17BB9;
	Sat, 17 Feb 2024 02:09:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79C3D71
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708135761; cv=none; b=p4FK/GnareazI3e2eUupoDxnYtG5Va1hD+6bfZq4wk7YubqhfeJOtWNG9IgvxaGCt/U9sxSbYCzID/bkx+JL6cCd8+/oxD+v0DVeJgdVbPBGca697X1zp0mpnadxj2sQx8ldYvO7r5e7JIKM/PuoZt0H/mtmA1T5C4k08deyFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708135761; c=relaxed/simple;
	bh=QtquFQdRB/kUzGFodL1973tJCHOhhs4hMASNU8c43Mc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bIuTtpdsINoyich/8SfZagAnrvS/0RFgdTQ9m7qAJodr2EnldFNBY0O5N7T3NEdDCxEJ/kpPF9XTkWwNu+/TXVofjKdxiYpt58yhAFoPq+w/BM4bfBG2YDxcCBOIR93FLxV/x3IWYZSNhOgb6547bndQnH0vyKfiC1VjBAK8zgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c72d53aa6cso15881139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708135759; x=1708740559;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfSoxgg0SzCvZrrk7LsmWyp4xPMSwiNajhdR6dfURRE=;
        b=cWFg1MIYvZsWFW7yiF2M9wwjv7HhzIqTeHtMMcDxk1xBlrilkPrCpxUVIvXIihBsqx
         XJXN0a6crg84pajwJqTNMXNpG8G3lhQX9ZfUQsWT5ObnuyecDFJRN14rGULPdMx/ytWo
         +GFhDeFmyb092GLHVAHngr/gwj2Xliwl6Ts62hpRxd2UbCxr7O7a9xaRTQKAaa0he/Dl
         KGyxbQ8fPE/LZG5nK4RJ1v1cg9a2VZT+ufuvm05kqAM2mXhNsp7MmGCSmgNg9rpGgnLh
         M2bMUyulnbiYEU3uBHm5KY/6RW6V8mo8CBHpjEg/fb1SLMVocRabCzOqND/mchVDsE3R
         LJjw==
X-Forwarded-Encrypted: i=1; AJvYcCUvBVlvBBXRrCBMxHFvNW+rTFpZ36t/MoMZuPOucudoU9nrPL+LGmR9ZbGvxqBKeg7LssqQUCCCP8SN9bqvqw3z+VZV8PL3x6XhxETY
X-Gm-Message-State: AOJu0Ywa6h3oZc69NzTJv7Gd765rQDCC0ukHyUGwZLwef37lMlLaa++S
	4rnFMpHsMTmmLcTfkCeYb/0Rvc1zLd3yogS9AMA4uM5dYLZtSPcL3L97wpqoQFLaNBVfxtb9Q/D
	vjaRNq3BWib2f5ohB/15OJXJUQWUcvJN5eNuEHiRMC/HSVJ8UT//93w0=
X-Google-Smtp-Source: AGHT+IFRPTvVmBOEaepHOYrAUUHRkHPBQeC4nyDCB2KhXF6tYopS81Q1quqHXKWcmw4yMpC9vRN7TON1yeVQhptkz+FQhZ9Vb2Wk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4129:b0:474:7ab:86d5 with SMTP id
 ay41-20020a056638412900b0047407ab86d5mr50415jab.3.1708135759090; Fri, 16 Feb
 2024 18:09:19 -0800 (PST)
Date: Fri, 16 Feb 2024 18:09:19 -0800
In-Reply-To: <000000000000e69b5a06093287ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026188206118a5952@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in
 hci_conn_drop (2)
From: syzbot <syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com>
To: hdanton@sina.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, luiz.dentz@gmail.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2c3b09aac00d Add linux-next specific files for 20240214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10316ac2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=176d2dcbf8ba7017
dashboard link: https://syzkaller.appspot.com/bug?extid=1683f76f1b20b826de67
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1765258a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c27a58180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac51042b61c6/disk-2c3b09aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/012344301c35/vmlinux-2c3b09aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cba3c3e5cd7c/bzImage-2c3b09aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1683f76f1b20b826de67@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop+0x34/0x2c0 include/net/bluetooth/hci_core.h:1574
Write of size 4 at addr ffff8880781d6010 by task syz-executor409/22560

CPU: 0 PID: 22560 Comm: syz-executor409 Not tainted 6.8.0-rc4-next-20240214-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
 hci_conn_drop+0x34/0x2c0 include/net/bluetooth/hci_core.h:1574
 __sco_sock_close+0x37b/0x570 net/bluetooth/sco.c:445
 sco_sock_close net/bluetooth/sco.c:470 [inline]
 sco_sock_release+0xb3/0x320 net/bluetooth/sco.c:1247
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x429/0x8a0 fs/file_table.c:411
 __do_sys_close fs/open.c:1557 [inline]
 __se_sys_close fs/open.c:1542 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1542
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f53a414802a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 f3 64 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 53 65 02 00 8b 44 24
RSP: 002b:00007ffcd1d20920 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f53a414802a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000003 R08: 00007ffcd1d209c4 R09: 00007ffcd1d209c4
R10: 0000000000000000 R11: 0000000000000293 R12: 0000555557478370
R13: 0000000000000011 R14: 00007ffcd1d20968 R15: 00007ffcd1d209c0
 </TASK>

Allocated by task 22560:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d9/0x360 mm/slub.c:4013
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 hci_conn_add+0xc7/0x13a0 net/bluetooth/hci_conn.c:914
 hci_conn_add_unset net/bluetooth/hci_conn.c:1016 [inline]
 hci_connect_sco+0xc9/0x350 net/bluetooth/hci_conn.c:1701
 sco_connect net/bluetooth/sco.c:266 [inline]
 sco_sock_connect+0x2fc/0x990 net/bluetooth/sco.c:592
 __sys_connect_file net/socket.c:2048 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2072
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5084:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:586
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2122 [inline]
 slab_free mm/slub.c:4296 [inline]
 kfree+0x14a/0x380 mm/slub.c:4406
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 hci_conn_cleanup net/bluetooth/hci_conn.c:176 [inline]
 hci_conn_del+0x8f0/0xc70 net/bluetooth/hci_conn.c:1126
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5361
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:306
 process_one_work kernel/workqueue.c:3146 [inline]
 process_scheduled_works+0x9d7/0x1730 kernel/workqueue.c:3226
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3307
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff8880781d6000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff8880781d6000, ffff8880781d7000)

The buggy address belongs to the physical page:
page:ffffea0001e07400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x781d0
head:ffffea0001e07400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888014c42140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4486, tgid 4486 (mount), ts 16228925553, free_ts 14928891043
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x6a0 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2191
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3541
 __slab_alloc mm/slub.c:3626 [inline]
 __slab_alloc_node mm/slub.c:3679 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 kmalloc_trace+0x267/0x360 mm/slub.c:4008
 kmalloc include/linux/slab.h:590 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x1ca/0x2050 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x38a/0x11f0 security/tomoyo/common.c:2089
 tomoyo_audit_mount_log security/tomoyo/mount.c:32 [inline]
 tomoyo_mount_acl security/tomoyo/mount.c:166 [inline]
 tomoyo_mount_permission+0x792/0xb80 security/tomoyo/mount.c:237
 security_sb_mount+0x8f/0xd0 security/security.c:1459
 path_mount+0xb9/0xfb0 fs/namespace.c:3621
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6532
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x238/0x830 init/main.c:1233
 do_initcall_level+0x157/0x210 init/main.c:1295
 do_initcalls+0x3f/0x80 init/main.c:1311
 kernel_init_freeable+0x435/0x5d0 init/main.c:1543
 kernel_init+0x1d/0x2b0 init/main.c:1432
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff8880781d5f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880781d5f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880781d6000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8880781d6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880781d6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

