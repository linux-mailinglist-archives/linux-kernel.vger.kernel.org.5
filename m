Return-Path: <linux-kernel+bounces-31126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7383295A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 545D51F24FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7AE4F1EF;
	Fri, 19 Jan 2024 12:07:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7B4EB50
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705666026; cv=none; b=Ewt/DlmDOgdJXZDBSs4b3F0s+Ixz8fexfXzPBz5r+vkVWDyQ8VrZ7M29fLWUwXXvavDNC61Jq/+T1GctUyP8dpnGOnJjBqxlf9q1mUbc9unPvwOKFTgQdZLZCXAfWoeIgBHqFZk+AtbhX0p50jJ3i0Cmqz6IdSy6RuwDsM21cxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705666026; c=relaxed/simple;
	bh=tmd5mZR1ZCIkmdnkG76q4Ufua5t2VjZtTUNZA7tujcs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LJij5U+rTwv5b9EyG5lShedIIJ2GvV1Wu2TntQCS5Cgt8C2+8BCjLkvAfmQ5JQrwxi6pqE+0nAweb+Br9AD5tIlCQVjzQyUaDIGbGVr0MXeLVfSUny/Hc8QLXg2da1XJG1Do4lwssWFH91MJUUmfkQi6qwA+GuhWg0aGzBd7CHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bbb3de4dcbso99640239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705666024; x=1706270824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmjL8it3vaVyxB9k8RYv05dOTZ1QGE+xOhdnzh/v3Bg=;
        b=NW1AftIFyg8wiAZkS2e31/CagDUu034F2OotYIHf2o4qYhj8TtGOk2VATouNqI0yKt
         XhFI0bwzpPTRj9DSg6fyDVFI8QCUF272eBtH/Ry0biqQCGZh7pMuJ/xgMqwhs9qdLlHW
         wQszHEFjf8heJ+oZ9ONWb2wdGz0VB6/PA7QP/HXfQc7Rdeol4v2s8IwFXTmzzEw4Bg92
         81PULJUmwDZiDdLU8Xma3ZIsThiDIXZ1d3fWYhc1dloAwENuWHdjtmhoaE0ez3ORrajO
         3ZfmobuJq5W4+gjMX3tY9lvsDTmy8X7ffm88gKRMmvmA0pUITyCwA+j86nJ8IPZpzkDl
         qTPg==
X-Gm-Message-State: AOJu0YymdDayj2psyIByQGrYVpcIGUbsU4EqxQXmLUTFXEIWZ4yrzf8b
	1rgbieixXn02qIX7NsqX3HK6zjb+LL8vGsBt/NAKh00D6JPtImYOyiHOGaft75icXqPmQdQP6AW
	PgTTsHICeWEdZvk/+illrwwiLoBOYXhKfXBfIXtP5TkS710Xr7lFbE9g=
X-Google-Smtp-Source: AGHT+IHDmFYt++YhXJ1nz605+EsfMbqi5iZvYHBQU/zSMlscOx9RkeVNxYHaKIIJCgRySUnkRSC70GQCKGQfXfSjis9IbqAksODA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:361:966c:8504 with SMTP id
 14-20020a056e0216ce00b00361966c8504mr366663ilx.6.1705666024097; Fri, 19 Jan
 2024 04:07:04 -0800 (PST)
Date: Fri, 19 Jan 2024 04:07:04 -0800
In-Reply-To: <20240119114735.2106-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078d073060f4b51e7@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in ipip_tunnel_xmit

==================================================================
BUG: KASAN: use-after-free in ipip_tunnel_xmit+0x580/0x610 net/ipv4/ipip.c:284
Read of size 1 at addr ffff88812130000e by task syz-executor.0/5530

CPU: 2 PID: 5530 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-g9d1694dc91ce-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 ipip_tunnel_xmit+0x580/0x610 net/ipv4/ipip.c:284
 __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
 netdev_start_xmit include/linux/netdevice.h:5003 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x137/0x6d0 net/core/dev.c:3563
 __dev_queue_xmit+0x7b6/0x3ed0 net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 neigh_connected_output+0x426/0x5d0 net/core/neighbour.c:1592
 neigh_output include/net/neighbour.h:542 [inline]
 ip_finish_output2+0x82d/0x2540 net/ipv4/ip_output.c:235
 __ip_finish_output net/ipv4/ip_output.c:313 [inline]
 __ip_finish_output+0x38b/0x650 net/ipv4/ip_output.c:295
 ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_mc_output+0x1dd/0x6a0 net/ipv4/ip_output.c:420
 dst_output include/net/dst.h:451 [inline]
 ip_local_out+0xaf/0x1a0 net/ipv4/ip_output.c:129
 iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:88
 ip_tunnel_xmit+0x1e2d/0x34c0 net/ipv4/ip_tunnel.c:837
 ipgre_xmit+0x49b/0x980 net/ipv4/ip_gre.c:665
 __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
 netdev_start_xmit include/linux/netdevice.h:5003 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x137/0x6d0 net/core/dev.c:3563
 __dev_queue_xmit+0x7b6/0x3ed0 net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 __bpf_tx_skb net/core/filter.c:2135 [inline]
 __bpf_redirect_no_mac net/core/filter.c:2169 [inline]
 __bpf_redirect+0x745/0xf90 net/core/filter.c:2192
 ____bpf_clone_redirect net/core/filter.c:2463 [inline]
 bpf_clone_redirect+0x2b2/0x420 net/core/filter.c:2435
 ___bpf_prog_run+0x3e44/0xabc0 kernel/bpf/core.c:1986
 __bpf_prog_run512+0xb7/0xf0 kernel/bpf/core.c:2227
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x3d3/0x9c0 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0xb75/0x1dd0 net/bpf/test_run.c:1056
 bpf_prog_test_run kernel/bpf/syscall.c:4107 [inline]
 __sys_bpf+0x11bf/0x4a00 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f886727cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8867f380c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f886739bf80 RCX: 00007f886727cce9
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007f88672c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f886739bf80 R15: 00007fff1deea708
 </TASK>

The buggy address belongs to the physical page:
page:ffffea000484c000 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x121300
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000000 ffffea000484c008 ffffea000484c008 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff8881212fff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8881212fff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888121300000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff888121300080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888121300100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         9d1694dc Merge tag 'for-6.8/block-2024-01-18' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=126c4f1be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70f4213b9a7b4f3a
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148fbdc7e80000


