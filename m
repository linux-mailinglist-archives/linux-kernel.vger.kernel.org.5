Return-Path: <linux-kernel+bounces-152756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19098AC3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008EF1C219B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130781862F;
	Mon, 22 Apr 2024 05:46:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13D18042
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764766; cv=none; b=ZPFJ2WZ4E0x+/2M9G0K82/cvOSU1vNfYaKqqoAaIPBIfUuIBNCS2KO0ce3vkwF+gD0ZGGNteeCqy672nDP5nCFpnhVCqNTI2Fsjd2VuIlEFYdcR+1A1zBUamp60cYY9bQhOJtccGPOGa/Tsg/q7DQi9nAthNEu28W9rQ3HmHtRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764766; c=relaxed/simple;
	bh=F9d+TdUPFkPrTlxQDYRDCb3NWeS+INLn1xESLxdwl5Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LJZcDS2UbpQZQaNmBnxfzDeW/56wxVhwVESeQ4oxO0EDfAqQFyUi5cUKxgp73jOuXC8LDg1icoqiVjzmiXaPGpAYX46M84kdgsmrkHcoYSqkEyS0IaatyDFzxYvi+YnrDLu6mrJ/2Hy2ab4xTMURJB2+SF1dSopi7EufiyDOdTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d9913d3174so539243439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 22:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713764764; x=1714369564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5sdK9Y32udnN17YPaxiDqb9wH9LQCNdaPnP5TfALSQ=;
        b=dk/ICGYV4w+xixM4hY/Jzw9+cHq63n/ni1w+Vt4JzlBsIM6V1/Elm5nqWs31BoW3BS
         Ip4JM1RSFdwHJH+4DEvW6cxpyvPUCG9stsgGG+5ap1VZVoxmmYZliRgXey55/xdk91Pf
         YZYNmfV3NwKp/daAY8HuE+XgY685v3jg0k6dmy6QPaZszNurisr4ZPUUsnX5rBwQROD2
         JYtHbKOwyu7Ac5lOGcZLBJFnO3UR1Ruz3iQQDYg7Q1uTetRB5vVlGV7iFFXgWFdGnLHI
         rv9UY7yZ7IVBIARkvY5TUKdijh7gqeKWdQerd229JmlZtShYURMqOpQf6WNP0A9JtQzw
         hdbg==
X-Forwarded-Encrypted: i=1; AJvYcCUePIRreEwgzIbNW9bnBoRzucXUooofoSogJ7nGKFmRHrgcYJxbU1nipTjLFmKspHokveWN21MfmZvF5U1qHMn3eJtkRDB3XAPW/mkU
X-Gm-Message-State: AOJu0YwdkWn7/c0S0PcagqnvCZlOGCFVO2OfhIn/efOa0c3ZKQZZCSvS
	dLoU8vwZ7IS/LAWxCiesTO5TRNqi/FrNpK+Y2TemS8+oG3UZnig0kBpQWCI68bUwND03ZyUgqOB
	GoouVcmNRtru7j0yOypr6ODnF5wzkdElz4MsFzi2d40pfSCaf02bLXjc=
X-Google-Smtp-Source: AGHT+IFg6MjZHLMOt19ULiMRvkkiZ2rL76vYaf+HUI4U1pXrtgon4wX+ouHxzbtJfA6r/UnubzWW93sTJkYGXRTwlejA4RMGQon0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2711:b0:485:42cd:bd3c with SMTP id
 m17-20020a056638271100b0048542cdbd3cmr127554jav.3.1713764764087; Sun, 21 Apr
 2024 22:46:04 -0700 (PDT)
Date: Sun, 21 Apr 2024 22:46:04 -0700
In-Reply-To: <20240422052911.140041-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe08b20616a8f32c@google.com>
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
Read of size 8 at addr ffff88802f3a8130 by task jffs2_gcd_mtd0/5495

CPU: 0 PID: 5495 Comm: jffs2_gcd_mtd0 Not tainted 6.9.0-rc5-syzkaller-ged30a4a51bb1-dirty #0
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

Allocated by task 5492:
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

The buggy address belongs to the object at ffff88802f3a8000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 304 bytes inside of
 freed 4096-byte region [ffff88802f3a8000, ffff88802f3a9000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2f3a8
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015042140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015042140 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea0000bcea01 ffffea0000bcea48 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4825, tgid 890569257 (dhcpcd), ts 4825, free_ts 35233298414
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
 kmalloc_trace+0x269/0x360 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_find_next_domain+0x15b/0x1cf0 security/tomoyo/domain.c:714
 tomoyo_bprm_check_security+0x115/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x65/0x90 security/security.c:1191
 search_binary_handler fs/exec.c:1766 [inline]
 exec_binprm fs/exec.c:1820 [inline]
 bprm_execve+0xa56/0x17c0 fs/exec.c:1872
 do_execveat_common+0x553/0x700 fs/exec.c:1979
 do_execve fs/exec.c:2053 [inline]
 __do_sys_execve fs/exec.c:2129 [inline]
 __se_sys_execve fs/exec.c:2124 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2124
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4743 tgid 4743 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2437 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2906
 put_cpu_partial+0x17c/0x250 mm/slub.c:2981
 __slab_free+0x2ea/0x3d0 mm/slub.c:4151
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x194/0x380 mm/slub.c:3888
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1313 [inline]
 nlmsg_new include/net/netlink.h:1010 [inline]
 netlink_ack+0x399/0x12b0 net/netlink/af_netlink.c:2496
 netlink_rcv_skb+0x262/0x430 net/netlink/af_netlink.c:2565
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745

Memory state around the buggy address:
 ffff88802f3a8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802f3a8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802f3a8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88802f3a8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802f3a8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         ed30a4a5 Linux 6.9-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11efdc80980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab247b9c410b3012
dashboard link: https://syzkaller.appspot.com/bug?extid=e84662c5f30b8c401437
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d3fb1b180000


