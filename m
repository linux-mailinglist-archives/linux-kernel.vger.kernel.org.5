Return-Path: <linux-kernel+bounces-30604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637D883219A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D808F1F2378B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A2C1DA4B;
	Thu, 18 Jan 2024 22:34:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A651DA33
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617247; cv=none; b=TLLvptToNmDAm+XbxmYfAoSLs+DNSR7wcHQGo9SDFpATi1qrJqViS+iAN51JJR8CIOUdjHzWF+8WB+Wi+OsU/AW+9Ht3XJ0ZRao4DjPv0gPlFgGKy/Q/HfIm9GfZ5aFqUE6kHL8oM9OnuILXBjMQZpwZZvDE5IcrYjMKKMaz8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617247; c=relaxed/simple;
	bh=7vVyNLBSHmEPzfI2Z1r5DKJEezEwISo/pkRXNf+VS68=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gtqnc221R0BGgWHEj2T/QHnsJTZXCa2DMs5u1QTVobw5nGJqiyHC5652zCKQ1Jux5h9Q0yFNllQErZZU9kmDifeAWhvkOhxefDy8P+x7RMyoWyFuPY8eFh+bzz0RKJP82G2KI2hrL8PO52LtqA+umXozPq1Kc3m7TAwyRyRhNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bc32b2225aso11311439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705617245; x=1706222045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8w1FFPmLJY+yBZLofMTIRD0IJPmMEQ4UsLviiwsC/3Q=;
        b=qqAw0yll9KTMDB8jdbFdD+dBm/ZdSkxRQfW0x8sDZurIBxq69jTY7/f5hJcw3NplWg
         OHwYWsDBl+n5A2xxGauZdmh3IxoAU06gokr/S+N67RVnP1NAMvD6p17CoAHrl54FPJVz
         zJ6tRQzcJdUj49AWP/P4MLCkeTajoicEoZjfsjWMU98s0AXaF2YJhTzBcEzX3IGrr05s
         hdF1u7OrPV9ybpNmusLMzeadGARFwPTkax0KvcwxQh7ThcLO97u5viEpiPl/IZzcP0aD
         cvKb0tLesyiGa/fKtlOQ2/gVj/8700qCT+J8hi/hbb8rZTZhHxxVaTfrtQsvwfihIvOK
         O0uQ==
X-Gm-Message-State: AOJu0Yw7hw7qKay47w+sDBjvnhHoIBIuHwQmRkDUxzGeyIe4AxxslsLI
	f62LkT+LqQyXNfI/d/Kio7C8MdN1jsunkTVMIPmUVj8nlffbORmyLTme8u2WeYz0PR9becVQHy7
	zTo2zNfAml0cnZ0PvB51PhJRZYS0Ogh1CtGaoeU25z2sKe7ujji7iK6g=
X-Google-Smtp-Source: AGHT+IFPTauYys6E5RccEV43R8BYxdpOpJGxQNOgwWVNnVdyVF5WeXJoKocmvjpG9soTybUpSPSkHkSCVhnbcGp1OArXTGEuISA8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:cb43:0:b0:7be:e323:46ad with SMTP id
 h3-20020a5ecb43000000b007bee32346admr681iok.2.1705617245254; Thu, 18 Jan 2024
 14:34:05 -0800 (PST)
Date: Thu, 18 Jan 2024 14:34:05 -0800
In-Reply-To: <20240118221554.1749-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006b968060f3ff654@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in __skb_flow_dissect

==================================================================
BUG: KASAN: use-after-free in __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
Read of size 1 at addr ffff88813c90000e by task syz-executor.0/5479

CPU: 0 PID: 5479 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-gb0d326da462e-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
 skb_flow_dissect_flow_keys include/linux/skbuff.h:1524 [inline]
 ___skb_get_hash net/core/flow_dissector.c:1791 [inline]
 __skb_get_hash+0xc7/0x540 net/core/flow_dissector.c:1856
 skb_get_hash include/linux/skbuff.h:1566 [inline]
 ip_tunnel_xmit+0x1843/0x33b0 net/ipv4/ip_tunnel.c:748
 ipip_tunnel_xmit+0x3cc/0x4e0 net/ipv4/ipip.c:308
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
 iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1daa/0x33b0 net/ipv4/ip_tunnel.c:831
 ipgre_xmit+0x49b/0x980 net/ipv4/ip_gre.c:665
 __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
 netdev_start_xmit include/linux/netdevice.h:5003 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x137/0x6d0 net/core/dev.c:3563
 __dev_queue_xmit+0x7b6/0x3ed0 net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 __bpf_tx_skb net/core/filter.c:2135 [inline]
 __bpf_redirect_no_mac net/core/filter.c:2154 [inline]
 __bpf_redirect+0x797/0xad0 net/core/filter.c:2177
 ____bpf_clone_redirect net/core/filter.c:2448 [inline]
 bpf_clone_redirect+0x2b2/0x420 net/core/filter.c:2420
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
RIP: 0033:0x7f1f1107cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1f11d050c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f1f1119bf80 RCX: 00007f1f1107cce9
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007f1f110c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f1f1119bf80 R15: 00007ffc4749ef18
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0004f24000 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13c900
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000000 ffffea0004f24008 ffffea0004f24008 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88813c8fff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813c8fff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88813c900000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff88813c900080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813c900100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         b0d326da Merge tag 'sched-urgent-2024-01-18' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1031cb63e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a5b728734a30ba3
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13167e57e80000


