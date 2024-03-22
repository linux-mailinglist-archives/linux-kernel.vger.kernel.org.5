Return-Path: <linux-kernel+bounces-112010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FE88741C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F390C1C21DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF97F7CB;
	Fri, 22 Mar 2024 20:10:34 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664D87EEE4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711138233; cv=none; b=Udgw5kla0je5Un8V4KYFXkVTSYn13j0TZs03JhkTkyANLUgBQesjn9AaHQWNEgMJ4PfT3bixPWUcP1fFnifWnBwfkTZnXg3Jt0ZQbnnCcIpRRfka5Jb9UnIdwqKWOSgb26C0dzh1KENCqyYTyyvDg5pZY86prV7fJ2XZy1qsh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711138233; c=relaxed/simple;
	bh=ZZF3lz2hvDKHAiAl4GvzMrL9PpKc3sCFsscb1dHSxB8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vFR3fhiwBIKK3kCOhkwC3TBPCLJI8xoqbDlNve1o8Aa4bYtzXrM+PBdhXNm0w7h/m/ZQfvTC12tJgm/EZN4vgLG0nCrGdKe9RNs0lsBYvZAArTeQ4O/QMg4gOISGzI+eTPxm7UL+wuu9IzZdKBSnSdFSjh4tOzybps/Cu2Mxg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cb806fc9f7so276283139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711138230; x=1711743030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJZKhm3iGQpj6Qg7Xni9eufppJ/iKT5OqyqNscKTmNU=;
        b=c99I0qUPdhSJ2JLbC468Y0bDk5zqat+XGUIZcwWDQR151WT0VZg0yj2mtjUgoYY9dZ
         VpqQeW/qrjjZ3bL9yTiULOAni+WsE5+TfY/on8rzOJ1n06rOv59GkoM9zvZUHP9SLkLS
         1szAd9j5K+XrDXNlyphhyEQkFjCIPAWQfM+bmaeBSfwSmHcoyLDZELkk29ExAkOJh+6W
         MQqWcGflMfuYNhomPldwCoiZyE+IbNHClCAhQ7h71d0/yX2gvEPzLB7Ns5iyuu2cdBZi
         B2nzmiYLCcEaJyDl3wdJHsR8fmDBakTUG/f0VSXF+rPIl47l2zPrez/BPOx0ssvISL/I
         GKJg==
X-Forwarded-Encrypted: i=1; AJvYcCUJOAuKYJCnSwJxYU3t++OH4wmWbJGC62TEHzW0Mws+O1sY2ouMeeHEpIo48bqkuus/Eox3KyS+mP+cXZgh9DipLa6DfHp8p3UnfiQD
X-Gm-Message-State: AOJu0YxZGzr0f8zNsQP7el5sWjnu63vAjfjqQcrboMwqlBPa0O5FCHTf
	jIilsBMT7xlzhAle8XbEsOVyT4mN06sWGMj454d/wIBJcgqNhowULFBDNRoYpw4f66BeoK31L/3
	v4Cm/MXPQfbppZEYZaLG2KL95HD+VLiovCG/qkkAGrGi1vtBPcKbB2UA=
X-Google-Smtp-Source: AGHT+IEvl+lBmy1FPeGEeAQigFD/iR1zoqhIBZ1AxO7HWnMpUrl6A7k10nwFjHrrsGcZz0ckKCfnmNtSQmzaeuaO2wdAMGWWHkEr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8906:b0:474:7952:8ab6 with SMTP id
 jc6-20020a056638890600b0047479528ab6mr13659jab.5.1711138230594; Fri, 22 Mar
 2024 13:10:30 -0700 (PDT)
Date: Fri, 22 Mar 2024 13:10:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000657ecd0614456af8@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    61387b8dcf1d Merge tag 'for-6.9/dm-vdo' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11effbd1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6aea81bc9ff5e99
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b972a52930fa/disk-61387b8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caa2592898b6/vmlinux-61387b8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4187257afcc5/bzImage-61387b8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __ethtool_get_link_ksettings+0x186/0x190 net/ethtool/ioctl.c:441
Read of size 8 at addr ffff888021f46308 by task kworker/0:4/5169

CPU: 0 PID: 5169 Comm: kworker/0:4 Not tainted 6.8.0-syzkaller-05562-g61387b8dcf1d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: infiniband ib_cache_event_task
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __ethtool_get_link_ksettings+0x186/0x190 net/ethtool/ioctl.c:441
 __ethtool_get_link_ksettings+0xf5/0x190 net/ethtool/ioctl.c:445
 ib_get_eth_speed+0x123/0xb50 drivers/infiniband/core/verbs.c:1984
 siw_query_port+0x3c/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:179
 iw_query_port drivers/infiniband/core/device.c:2049 [inline]
 ib_query_port drivers/infiniband/core/device.c:2090 [inline]
 ib_query_port+0x3d5/0x8a0 drivers/infiniband/core/device.c:2082
 ib_cache_update.part.0+0xdc/0xa30 drivers/infiniband/core/cache.c:1498
 ib_cache_update drivers/infiniband/core/cache.c:1572 [inline]
 ib_cache_event_task+0x1c2/0x290 drivers/infiniband/core/cache.c:1572
 process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 10125:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node+0x226/0x480 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0x9d/0x1a0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 kvzalloc include/linux/slab.h:774 [inline]
 alloc_netdev_mqs+0xb3/0x12b0 net/core/dev.c:10840
 rtnl_create_link+0xc88/0xfa0 net/core/rtnetlink.c:3358
 rtnl_newlink_create net/core/rtnetlink.c:3484 [inline]
 __rtnl_newlink+0x10ae/0x1960 net/core/rtnetlink.c:3714
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3727
 rtnetlink_rcv_msg+0x3ca/0xe60 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0x16e/0x440 net/netlink/af_netlink.c:2559
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x545/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x482/0x4e0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 61:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x129/0x370 mm/slub.c:4390
 kvfree+0x47/0x50 mm/util.c:680
 device_release+0xa4/0x240 drivers/base/core.c:2499
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fd/0x5b0 lib/kobject.c:737
 netdev_run_todo+0x7d1/0x1260 net/core/dev.c:10591
 default_device_exit_batch+0x860/0xae0 net/core/dev.c:11632
 ops_exit_list+0x12b/0x180 net/core/net_namespace.c:175
 cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:637
 process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff888021f46000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 776 bytes inside of
 freed 4096-byte region [ffff888021f46000, ffff888021f47000)

The buggy address belongs to the physical page:
page:ffffea000087d000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21f40
head:ffffea000087d000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880636ce481
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff88801504f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff8880636ce481
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 10125, tgid 10125 (syz-executor.2), ts 404185927295, free_ts 404019420685
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22b/0x2410 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:3986
 kmemdup+0x29/0x60 mm/util.c:131
 kmemdup include/linux/fortify-string.h:738 [inline]
 __devinet_sysctl_register+0xbc/0x360 net/ipv4/devinet.c:2577
 devinet_sysctl_register net/ipv4/devinet.c:2629 [inline]
 devinet_sysctl_register+0x17b/0x200 net/ipv4/devinet.c:2619
 inetdev_init+0x28b/0x580 net/ipv4/devinet.c:286
 inetdev_event+0xd23/0x19b0 net/ipv4/devinet.c:1560
 notifier_call_chain+0xbc/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1950
 call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
 call_netdevice_notifiers net/core/dev.c:2002 [inline]
 register_netdevice+0x15f5/0x1ca0 net/core/dev.c:10307
 virt_wifi_newlink+0x3ed/0x970 drivers/net/wireless/virtual/virt_wifi.c:553
page last free pid 10234 tgid 10232 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 __put_partials+0x14c/0x170 mm/slub.c:2906
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x177/0x340 mm/slub.c:3888
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:658
 alloc_skb_fclone include/linux/skbuff.h:1368 [inline]
 tipc_buf_acquire+0x26/0xe0 net/tipc/msg.c:72
 tipc_msg_build+0x10c/0x1120 net/tipc/msg.c:386
 tipc_sendmcast+0x79e/0xb70 net/tipc/socket.c:881
 __tipc_sendmsg+0x1317/0x1940 net/tipc/socket.c:1469
 tipc_sendmsg+0x4f/0x70 net/tipc/socket.c:1403
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab8/0xc90 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
 __sys_sendmmsg+0x1a1/0x450 net/socket.c:2724

Memory state around the buggy address:
 ffff888021f46200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021f46280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888021f46300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888021f46380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021f46400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
==================================================================
BUG: KASAN: slab-use-after-free in __ethtool_get_link_ksettings+0x165/0x190 net/ethtool/ioctl.c:445
Read of size 8 at addr ffff888021f46308 by task kworker/0:4/5169

CPU: 0 PID: 5169 Comm: kworker/0:4 Tainted: G    B              6.8.0-syzkaller-05562-g61387b8dcf1d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: infiniband ib_cache_event_task
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __ethtool_get_link_ksettings+0x165/0x190 net/ethtool/ioctl.c:445
 __ethtool_get_link_ksettings+0xf5/0x190 net/ethtool/ioctl.c:445
 ib_get_eth_speed+0x123/0xb50 drivers/infiniband/core/verbs.c:1984
 siw_query_port+0x3c/0x3e0 drivers/infiniband/sw/siw/siw_verbs.c:179
 iw_query_port drivers/infiniband/core/device.c:2049 [inline]
 ib_query_port drivers/infiniband/core/device.c:2090 [inline]
 ib_query_port+0x3d5/0x8a0 drivers/infiniband/core/device.c:2082
 ib_cache_update.part.0+0xdc/0xa30 drivers/infiniband/core/cache.c:1498
 ib_cache_update drivers/infiniband/core/cache.c:1572 [inline]
 ib_cache_event_task+0x1c2/0x290 drivers/infiniband/core/cache.c:1572
 process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 10125:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node+0x226/0x480 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0x9d/0x1a0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 kvzalloc include/linux/slab.h:774 [inline]
 alloc_netdev_mqs+0xb3/0x12b0 net/core/dev.c:10840
 rtnl_create_link+0xc88/0xfa0 net/core/rtnetlink.c:3358
 rtnl_newlink_create net/core/rtnetlink.c:3484 [inline]
 __rtnl_newlink+0x10ae/0x1960 net/core/rtnetlink.c:3714
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3727
 rtnetlink_rcv_msg+0x3ca/0xe60 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0x16e/0x440 net/netlink/af_netlink.c:2559
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x545/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x482/0x4e0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 61:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x129/0x370 mm/slub.c:4390
 kvfree+0x47/0x50 mm/util.c:680
 device_release+0xa4/0x240 drivers/base/core.c:2499
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fd/0x5b0 lib/kobject.c:737
 netdev_run_todo+0x7d1/0x1260 net/core/dev.c:10591
 default_device_exit_batch+0x860/0xae0 net/core/dev.c:11632
 ops_exit_list+0x12b/0x180 net/core/net_namespace.c:175
 cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:637
 process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff888021f46000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 776 bytes inside of
 freed 4096-byte region [ffff888021f46000, ffff888021f47000)

The buggy address belongs to the physical page:
page:ffffea000087d000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21f40
head:ffffea000087d000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880636ce481
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff88801504f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff8880636ce481
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 10125, tgid 10125 (syz-executor.2), ts 404185927295, free_ts 404019420685
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22b/0x2410 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:3986
 kmemdup+0x29/0x60 mm/util.c:131
 kmemdup include/linux/fortify-string.h:738 [inline]
 __devinet_sysctl_register+0xbc/0x360 net/ipv4/devinet.c:2577
 devinet_sysctl_register net/ipv4/devinet.c:2629 [inline]
 devinet_sysctl_register+0x17b/0x200 net/ipv4/devinet.c:2619
 inetdev_init+0x28b/0x580 net/ipv4/devinet.c:286
 inetdev_event+0xd23/0x19b0 net/ipv4/devinet.c:1560
 notifier_call_chain+0xbc/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1950
 call_netdevice_notifiers_extack net/core/dev.c:1988 [inline]
 call_netdevice_notifiers net/core/dev.c:2002 [inline]
 register_netdevice+0x15f5/0x1ca0 net/core/dev.c:10307
 virt_wifi_newlink+0x3ed/0x970 drivers/net/wireless/virtual/virt_wifi.c:553
page last free pid 10234 tgid 10232 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 __put_partials+0x14c/0x170 mm/slub.c:2906
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x177/0x340 mm/slub.c:3888
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:658
 alloc_skb_fclone include/linux/skbuff.h:1368 [inline]
 tipc_buf_acquire+0x26/0xe0 net/tipc/msg.c:72
 tipc_msg_build+0x10c/0x1120 net/tipc/msg.c:386
 tipc_sendmcast+0x79e/0xb70 net/tipc/socket.c:881
 __tipc_sendmsg+0x1317/0x1940 net/tipc/socket.c:1469
 tipc_sendmsg+0x4f/0x70 net/tipc/socket.c:1403
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab8/0xc90 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2638
 __sys_sendmmsg+0x1a1/0x450 net/socket.c:2724

Memory state around the buggy address:
 ffff888021f46200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021f46280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888021f46300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888021f46380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021f46400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

