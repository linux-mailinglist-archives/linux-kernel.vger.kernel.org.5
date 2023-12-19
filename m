Return-Path: <linux-kernel+bounces-5146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1875818714
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71E41C23589
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91030171A2;
	Tue, 19 Dec 2023 12:09:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA39168BD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35facd4238bso36266375ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702987744; x=1703592544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=apc/xCbqmtlCwbr3H5Didv1+QQ3sVtVHxI6ljm2xYvg=;
        b=NscWhPNnAWjR+Tc0C053TK23gP/Jkwgw3Cl8XAAGt0/5m8NB10TE/OMLmFTLQccys4
         pPkNvfdB1fG0+LjeH9AanT4FQ4V7B+FEp5g3vBXqTwoc/G0cMCfPspoQXBorJChpM2FX
         KyZiiw7+3hoOvBDXv8/IpyN6CHACKbJjLpOqgCdSmgZhBb/3xiEESjs/TbUlvFN3j/IG
         TccmT5ogRko4q2mSSCH7dDpV2aU4SKwRRxXkIARafAPXLSERg9LMDpu/Y2Y2/kcVJpUQ
         3zmmSKspKLg5bkFlNrcjawOgd0LPAFZER4JXQkYMdVWdKu/cGMrgjuQIoTqvL87IukvL
         estw==
X-Gm-Message-State: AOJu0Yxkf/i4MJYtRWbsl00sZA1oFUN678qRf0tJq3u7jCALE8em7eGd
	uANNpUS6btvSLaLDctOX+AznvsgzP4ITtvPwkjthN5QRw86G
X-Google-Smtp-Source: AGHT+IERGOe2qiwr3RJOAxfbnFGvs+eOucs1l8EBF7BEZ+xIWab9PsbadMroeTmxtuJlzQZmvNyczLJfRj47rnp/FcQHnGavl1uG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e2:b0:35f:989c:a876 with SMTP id
 q2-20020a056e0220e200b0035f989ca876mr867073ilv.1.1702987744649; Tue, 19 Dec
 2023 04:09:04 -0800 (PST)
Date: Tue, 19 Dec 2023 04:09:04 -0800
In-Reply-To: <tencent_049D8DFF92105DAADDA1995ECFAE0DC82507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093ab2d060cdbbbe2@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in arc4_crypt

"syz-executor.0" (5497) uses obsolete ecb(arc4) skcipher
ivs: ffff8880296a9ae0, v: 0, s: 0, ri: 0000000000000010, wi: 0000000000000000, crypto_lskcipher_crypt_sg
==================================================================
BUG: KASAN: slab-out-of-bounds in arc4_crypt+0x31c/0x4e0 lib/crypto/arc4.c:46
Read of size 4 at addr ffff8880296a9ee0 by task syz-executor.0/5497

CPU: 1 PID: 5497 Comm: syz-executor.0 Not tainted 6.7.0-rc5-next-20231215-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 arc4_crypt+0x31c/0x4e0 lib/crypto/arc4.c:46
 crypto_arc4_crypt+0x61/0x70 crypto/arc4.c:37
 crypto_lskcipher_crypt_sg+0x398/0x600 crypto/lskcipher.c:235
 crypto_skcipher_decrypt+0xda/0x160 crypto/skcipher.c:693
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0xc2b/0x1040 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1066
 ____sys_recvmsg+0x21f/0x5c0 net/socket.c:2801
 ___sys_recvmsg+0x115/0x1a0 net/socket.c:2843
 __sys_recvmsg+0x114/0x1e0 net/socket.c:2873
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f029aa7cba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f029b7d40c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007f029ab9bf80 RCX: 00007f029aa7cba9
RDX: 0000000000000000 RSI: 00000000200005c0 RDI: 0000000000000004
RBP: 00007f029aac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f029ab9bf80 R15: 00007fff19420af8
 </TASK>

Allocated by task 78:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slub.c:3817 [inline]
 slab_alloc_node mm/slub.c:3864 [inline]
 kmem_cache_alloc_lru+0x142/0x6f0 mm/slub.c:3883
 __d_alloc+0x32/0xac0 fs/dcache.c:1769
 d_alloc+0x4e/0x220 fs/dcache.c:1849
 d_alloc_parallel+0xe9/0x12d0 fs/dcache.c:2638
 __lookup_slow+0x194/0x450 fs/namei.c:1678
 lookup_one_len+0x17d/0x1b0 fs/namei.c:2755
 start_creating.part.0+0x12f/0x3a0 fs/debugfs/inode.c:382
 start_creating fs/debugfs/inode.c:355 [inline]
 __debugfs_create_file+0xa5/0x620 fs/debugfs/inode.c:427
 minstrel_ht_add_sta_debugfs+0x2f/0x50 net/mac80211/rc80211_minstrel_ht_debugfs.c:332
 rate_control_add_sta_debugfs net/mac80211/rate.h:60 [inline]
 sta_info_insert_finish net/mac80211/sta_info.c:879 [inline]
 sta_info_insert_rcu+0xe3e/0x1ab0 net/mac80211/sta_info.c:944
 ieee80211_ibss_finish_sta+0x21c/0x3a0 net/mac80211/ibss.c:575
 ieee80211_ibss_add_sta+0x3a8/0x730 net/mac80211/ibss.c:631
 ieee80211_update_sta_info net/mac80211/ibss.c:1005 [inline]
 ieee80211_rx_bss_info net/mac80211/ibss.c:1096 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1577 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x28b7/0x3140 net/mac80211/ibss.c:1604
 ieee80211_iface_process_skb net/mac80211/iface.c:1589 [inline]
 ieee80211_iface_work+0xa67/0xda0 net/mac80211/iface.c:1643
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:437
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 ____kasan_kmalloc mm/kasan/common.c:375 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:384
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slub.c:3985 [inline]
 __kmalloc_node_track_caller+0x220/0x470 mm/slub.c:4005
 kmemdup+0x29/0x60 mm/util.c:131
 kmemdup include/linux/fortify-string.h:761 [inline]
 ip6t_register_table+0x1d0/0x420 net/ipv6/netfilter/ip6_tables.c:1768
 ip6table_security_table_init+0x40/0x60 net/ipv6/netfilter/ip6table_security.c:45
 xt_find_table_lock+0x2cf/0x4e0 net/netfilter/x_tables.c:1259
 xt_request_find_table_lock+0x28/0xf0 net/netfilter/x_tables.c:1284
 get_info+0x1a1/0x7c0 net/ipv4/netfilter/ip_tables.c:963
 do_ip6t_get_ctl+0x16a/0xae0 net/ipv6/netfilter/ip6_tables.c:1660
 nf_getsockopt+0x76/0xe0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x1f9/0x2b0 net/ipv6/ipv6_sockglue.c:1488
 tcp_getsockopt+0x97/0xf0 net/ipv4/tcp.c:4361
 do_sock_getsockopt+0x2e1/0x6c0 net/socket.c:2371
 __sys_getsockopt+0x1a1/0x270 net/socket.c:2400
 __do_sys_getsockopt net/socket.c:2410 [inline]
 __se_sys_getsockopt net/socket.c:2407 [inline]
 __x64_sys_getsockopt+0xbd/0x150 net/socket.c:2407
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xc2/0xd0 mm/kasan/generic.c:517
 __call_rcu_common.constprop.0+0x9a/0x7b0 kernel/rcu/tree.c:2689
 call_rcu_hurry include/linux/rcupdate.h:114 [inline]
 dst_release net/core/dst.c:167 [inline]
 dst_release+0x1b5/0x1e0 net/core/dst.c:164
 refdst_drop include/net/dst.h:263 [inline]
 skb_dst_drop include/net/dst.h:275 [inline]
 skb_release_head_state+0x254/0x2b0 net/core/skbuff.c:1041
 skb_release_all net/core/skbuff.c:1056 [inline]
 kfree_skb_add_bulk net/core/skbuff.c:1129 [inline]
 kfree_skb_list_reason+0x17b/0x4c0 net/core/skbuff.c:1151
 __dev_xmit_skb net/core/dev.c:3840 [inline]
 __dev_queue_xmit+0x255b/0x3d40 net/core/dev.c:4311
 dev_queue_xmit include/linux/netdevice.h:3165 [inline]
 neigh_resolve_output net/core/neighbour.c:1563 [inline]
 neigh_resolve_output+0x584/0x8f0 net/core/neighbour.c:1543
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0x673/0x1820 net/ipv6/ip6_output.c:137
 __ip6_finish_output net/ipv6/ip6_output.c:211 [inline]
 ip6_finish_output+0x3c7/0xf70 net/ipv6/ip6_output.c:222
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x1e2/0x530 net/ipv6/ip6_output.c:243
 dst_output include/net/dst.h:451 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xa13/0x18f0 net/ipv6/ndisc.c:509
 ndisc_send_rs+0x133/0x6a0 net/ipv6/ndisc.c:719
 addrconf_dad_completed+0x486/0x1030 net/ipv6/addrconf.c:4303
 addrconf_dad_begin net/ipv6/addrconf.c:4068 [inline]
 addrconf_dad_work+0xd5c/0x14b0 net/ipv6/addrconf.c:4170
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff8880296a9800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 1024 bytes to the right of
 allocated 736-byte region [ffff8880296a9800, ffff8880296a9ae0)

The buggy address belongs to the physical page:
page:ffffea0000a5aa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880296ac000 pfn:0x296a8
head:ffffea0000a5aa00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013041dc0 ffffea00052f8a00 0000000000000003
raw: ffff8880296ac000 000000008010000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 2871, tgid 2871 (kworker/u4:11), ts 83336024213, free_ts 79470601630
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1540
 prep_new_page mm/page_alloc.c:1547 [inline]
 get_page_from_freelist+0xa19/0x3740 mm/page_alloc.c:3355
 __alloc_pages+0x22e/0x2410 mm/page_alloc.c:4611
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:2191 [inline]
 allocate_slab mm/slub.c:2358 [inline]
 new_slab+0x283/0x3c0 mm/slub.c:2411
 ___slab_alloc+0x4ab/0x1990 mm/slub.c:3544
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3629
 __slab_alloc_node mm/slub.c:3682 [inline]
 slab_alloc_node mm/slub.c:3854 [inline]
 __do_kmalloc_node mm/slub.c:3984 [inline]
 __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:4005
 kmalloc_reserve+0xef/0x260 net/core/skbuff.c:582
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1298 [inline]
 nlmsg_new include/net/netlink.h:1010 [inline]
 inet6_rt_notify+0xf0/0x2b0 net/ipv6/route.c:6171
 fib6_del_route net/ipv6/ip6_fib.c:1999 [inline]
 fib6_del+0xfae/0x17a0 net/ipv6/ip6_fib.c:2034
 fib6_clean_node+0x41f/0x5b0 net/ipv6/ip6_fib.c:2196
 fib6_walk_continue+0x44c/0x8c0 net/ipv6/ip6_fib.c:2118
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2166
 fib6_clean_tree+0xd7/0x110 net/ipv6/ip6_fib.c:2246
page last free pid 5061 tgid 5053 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x51f/0xb10 mm/page_alloc.c:2390
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2530
 vfree+0x181/0x7a0 mm/vmalloc.c:2842
 snd_dma_free_pages+0x51/0x60 sound/core/memalloc.c:126
 do_free_pages sound/core/pcm_memory.c:93 [inline]
 do_free_pages sound/core/pcm_memory.c:88 [inline]
 snd_pcm_lib_free_pages+0x172/0x380 sound/core/pcm_memory.c:499
 do_hw_free sound/core/pcm_native.c:893 [inline]
 snd_pcm_release_substream.part.0+0x29c/0x330 sound/core/pcm_native.c:2760
 snd_pcm_release_substream+0x5b/0x70 sound/core/pcm_native.c:2754
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2413 [inline]
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2405 [inline]
 snd_pcm_oss_release+0x175/0x310 sound/core/oss/pcm_oss.c:2592
 __fput+0x270/0xbb0 fs/file_table.c:381
 __fput_sync+0x47/0x50 fs/file_table.c:466
 __do_sys_close fs/open.c:1595 [inline]
 __se_sys_close fs/open.c:1580 [inline]
 __x64_sys_close+0x86/0xf0 fs/open.c:1580
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a

Memory state around the buggy address:
 ffff8880296a9d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880296a9e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880296a9e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff8880296a9f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880296a9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=168fefc6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14276121e80000


