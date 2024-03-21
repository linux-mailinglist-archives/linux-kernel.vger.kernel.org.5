Return-Path: <linux-kernel+bounces-109825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E455885629
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313291C2107C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099482C6BB;
	Thu, 21 Mar 2024 09:01:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE42A1C6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011691; cv=none; b=sbUkPBt9w3RXok2+5eVjkO8Fn5zmjMfXQBjPNXpsi/QeIhX5wXPLaP2HDt/YCVGGqnP7pWhcQ9kOILbq35f+QEp9JnYEY3jGQLcvZm+eS9HZdZWfWGTTX90UqgsH5l4o9+ue+zDrD/Ct9vUn0Vnkmc3BorTBaJfqW4oRd2rBbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011691; c=relaxed/simple;
	bh=aJp7DaV7jRzFqufddhmY6Dx2TD36CE9LdX/BvH2E+Bg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oqB2fKgeMo2bDxqGJtnIG8l92EWcg2uoLLZkCMBeTJqlUoQZoDVYE5hu85FsNc807MIrZjxjv13ALAk0/HkxrARbuGZ5ImLGS3vp9pWUMyYCN2okvdAfIEdaCWzPG8NFEQLpMKzRg/n7SYXkAnRESZ86SYu9NzkDP8j5DYCfnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so64322939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711011688; x=1711616488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXa4wMYO35yK/VQUQb5kvTdZt/Xd0JFSHTIPtEHzLGA=;
        b=D78aK7dpU9/UmUv5teefD8rRlV1XSxmk4SoVIQo5ThCKFyU8t3TGgyqJcr0pdeChZV
         jwoeokfGvt1YEhEjv3RinPO2GceVadn33LI0w/TBeqLsmpMlqaXMmhTloB5UvNaJZxC/
         De5RpcUz/aZvobRMeQjTB0Izw0s/WUN3J9Wdev95i+vjewI3RDUUlMRjlyLfZ3SB12si
         5BDxReI/kQzXHKrHTdxhpNhhXrLBn+qdmpOt5PV4cLwTjgFYdX2WLuL/9/LUHqo/Fvc/
         qUlkzeYYxRVV/bBzywb45dHaMqP4j6UoSPUucmGC5qR+l4FnIRbqZ2xBA8buWlxdU9hG
         qNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdXBOyLRADwECf6ohQt+pRM6fzTQhq4gcXxc4G+T4H9asNGeOEXmjdZyPZggFWv6QCMCCI1oJhFqU2NUqLw8aMwkYXH1Uz8gdKIPm7
X-Gm-Message-State: AOJu0YyfRH5AzUAmV4QWqLrg8SyBGS1qvrT2I16MUH+7Q8Bxni+rWawW
	qrI6nv+wv0TewEwEe7/Gv/vbgQE4WeexIE1MTU31EBxT1HJ+IOwAmdzHc9aUQ0YnN9h/pPAPyBZ
	h/sjMOqFIoBG75rQ9xAPfhfvMmikdTiPGCJCtba7IhgZvs2diolafGwA=
X-Google-Smtp-Source: AGHT+IFAjdp/wJiQgmF0O0cahmECF1P6pmV1SQSLcJhszwtP9RIJPSOZ42+5qxTEETEn++kjJX1dkPDvsB6afqtO1QYKZ6UkCrHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1604:b0:7c8:264d:5e98 with SMTP id
 x4-20020a056602160400b007c8264d5e98mr143476iow.0.1711011688101; Thu, 21 Mar
 2024 02:01:28 -0700 (PDT)
Date: Thu, 21 Mar 2024 02:01:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0481f061427f37b@google.com>
Subject: [syzbot] [trace?] [bpf?] KASAN: slab-use-after-free Read in bpf_trace_run4
From: syzbot <syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    520fad2e3206 selftests/bpf: scale benchmark counting by us..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121c0679180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=62d8b26793e8a2bd0516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13dc4231180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1705d185180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4eef3506c5ce/disk-520fad2e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24d60ebe76cc/vmlinux-520fad2e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f883e706550/bzImage-520fad2e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62d8b26793e8a2bd0516@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2376 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run4+0x143/0x580 kernel/trace/bpf_trace.c:2433
Read of size 8 at addr ffff8880238ba918 by task sshd/5076

CPU: 1 PID: 5076 Comm: sshd Not tainted 6.8.0-syzkaller-05233-g520fad2e3206 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __bpf_trace_run kernel/trace/bpf_trace.c:2376 [inline]
 bpf_trace_run4+0x143/0x580 kernel/trace/bpf_trace.c:2433
 __traceiter_mm_page_alloc+0x3a/0x60 include/trace/events/kmem.h:177
 trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
 __alloc_pages+0x657/0x680 mm/page_alloc.c:4591
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd1b/0x13e0 mm/slub.c:3540
 __kmem_cache_alloc_bulk mm/slub.c:4574 [inline]
 kmem_cache_alloc_bulk+0x22e/0x790 mm/slub.c:4648
 napi_skb_cache_get+0x166/0x230 net/core/skbuff.c:348
 __napi_build_skb net/core/skbuff.c:527 [inline]
 __napi_alloc_skb+0x217/0x540 net/core/skbuff.c:846
 napi_alloc_skb include/linux/skbuff.h:3363 [inline]
 page_to_skb+0x275/0x9b0 drivers/net/virtio_net.c:569
 receive_mergeable drivers/net/virtio_net.c:1683 [inline]
 receive_buf+0x3b3/0x3890 drivers/net/virtio_net.c:1804
 virtnet_receive drivers/net/virtio_net.c:2110 [inline]
 virtnet_poll+0x720/0x18f0 drivers/net/virtio_net.c:2203
 __napi_poll+0xcb/0x490 net/core/dev.c:6632
 napi_poll net/core/dev.c:6701 [inline]
 net_rx_action+0x7bb/0x1090 net/core/dev.c:6813
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:247
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:kasan_check_range+0x1b7/0x290 mm/kasan/generic.c:189
Code: f5 4d 01 fb 48 8d 5d 07 48 85 ed 48 0f 49 dd 48 83 e3 f8 48 29 dd 74 12 41 80 3b 00 0f 85 a6 00 00 00 49 ff c3 48 ff cd 75 ee <5b> 41 5c 41 5e 41 5f 5d c3 cc cc cc cc 40 84 ed 75 5f f7 c5 00 ff
RSP: 0018:ffffc900039ff950 EFLAGS: 00000256
RAX: ffffffff845bbe01 RBX: 1ffff9200073ff40 RCX: ffffffff845bbe35
RDX: 0000000000000001 RSI: 0000000000000030 RDI: ffffc900039ffa00
RBP: 0000000000000000 R08: ffffc900039ffa2f R09: 1ffff9200073ff45
R10: dffffc0000000000 R11: fffff5200073ff46 R12: 1ffff9200073ff3c
R13: dffffc0000000000 R14: dffffc0000000001 R15: fffff5200073ff46
 __asan_memset+0x23/0x50 mm/kasan/shadow.c:84
 tomoyo_socket_sendmsg_permission+0x95/0x420 security/tomoyo/network.c:761
 security_socket_sendmsg+0x75/0xb0 security/security.c:4501
 __sock_sendmsg+0x49/0x270 net/socket.c:742
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 call_write_iter include/linux/fs.h:2108 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa84/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f2e91716bf2
Code: 89 c7 48 89 44 24 08 e8 7b 34 fa ff 48 8b 44 24 08 48 83 c4 28 c3 c3 64 8b 04 25 18 00 00 00 85 c0 75 20 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 6f 48 8b 15 07 a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffee57321e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000000000f4 RCX: 00007f2e91716bf2
RDX: 00000000000000f4 RSI: 000055731dc092b0 RDI: 0000000000000004
RBP: 000055731dbfe220 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000557315f9caa4
R13: 000000000000004b R14: 0000557315f9d3e8 R15: 00007ffee5732258
 </TASK>

Allocated by task 5110:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d9/0x360 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3816
 bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3863
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5673
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5110:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x14a/0x380 mm/slub.c:4409
 bpf_link_release+0x3b/0x50 kernel/bpf/syscall.c:3071
 __fput+0x429/0x8a0 fs/file_table.c:423
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff8880238ba900
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff8880238ba900, ffff8880238ba980)

The buggy address belongs to the physical page:
page:ffffea00008e2e80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x238ba
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c418c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5108, tgid 5108 (syz-executor305), ts 75475805562, free_ts 75472097179
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd1b/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmalloc_trace+0x267/0x360 mm/slub.c:4007
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3816
 bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3863
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5673
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 5110 tgid 5110 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 skb_free_frag include/linux/skbuff.h:3341 [inline]
 skb_free_head net/core/skbuff.c:1106 [inline]
 skb_release_data+0x640/0x870 net/core/skbuff.c:1136
 skb_release_all net/core/skbuff.c:1202 [inline]
 __kfree_skb+0x57/0x70 net/core/skbuff.c:1216
 tcp_rcv_established+0x107e/0x1fd0 net/ipv4/tcp_input.c:6080
 tcp_v4_do_rcv+0x8da/0xb90 net/ipv4/tcp_ipv4.c:1906
 tcp_v4_rcv+0x2e59/0x3780 net/ipv4/tcp_ipv4.c:2332
 ip_protocol_deliver_rcu+0x225/0x430 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x33f/0x5f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 ip_local_deliver net/ipv4/ip_input.c:254 [inline]
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish+0x3be/0x4f0 net/ipv4/ip_input.c:580
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x75d/0xab0 net/ipv4/ip_input.c:639
 ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5581 [inline]
 __netif_receive_skb_list_core+0x95a/0x980 net/core/dev.c:5629
 __netif_receive_skb_list net/core/dev.c:5681 [inline]
 netif_receive_skb_list_internal+0xa62/0xe70 net/core/dev.c:5773
 gro_normal_list include/net/gro.h:438 [inline]
 napi_complete_done+0x310/0x8e0 net/core/dev.c:6113

Memory state around the buggy address:
 ffff8880238ba800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880238ba880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880238ba900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880238ba980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880238baa00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	4d 01 fb             	add    %r15,%r11
   4:	48 8d 5d 07          	lea    0x7(%rbp),%rbx
   8:	48 85 ed             	test   %rbp,%rbp
   b:	48 0f 49 dd          	cmovns %rbp,%rbx
   f:	48 83 e3 f8          	and    $0xfffffffffffffff8,%rbx
  13:	48 29 dd             	sub    %rbx,%rbp
  16:	74 12                	je     0x2a
  18:	41 80 3b 00          	cmpb   $0x0,(%r11)
  1c:	0f 85 a6 00 00 00    	jne    0xc8
  22:	49 ff c3             	inc    %r11
  25:	48 ff cd             	dec    %rbp
  28:	75 ee                	jne    0x18
* 2a:	5b                   	pop    %rbx <-- trapping instruction
  2b:	41 5c                	pop    %r12
  2d:	41 5e                	pop    %r14
  2f:	41 5f                	pop    %r15
  31:	5d                   	pop    %rbp
  32:	c3                   	ret
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	40 84 ed             	test   %bpl,%bpl
  3a:	75 5f                	jne    0x9b
  3c:	f7                   	.byte 0xf7
  3d:	c5                   	.byte 0xc5
  3e:	00 ff                	add    %bh,%bh


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

