Return-Path: <linux-kernel+bounces-30875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9483255A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2E4B24663
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0E2209E;
	Fri, 19 Jan 2024 08:01:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399E208AE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651266; cv=none; b=F2JAjZfbHaCKWk4iqj4hzArcu/+e++mYGHhyVE1ohMKCqNxbu6I3HRK9sa24BynYxGxcl1B2dT6kpe2XyOoYslDhlyD3hprlQyDdkMHnGuLiK8UA6jVRz8u4GDPkUMWoGbP63AaPULO0OL8d9sRa13ZG4L0zaj7OlES9nfc7kJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651266; c=relaxed/simple;
	bh=gmnzd2KZu85QUT+8b6i+j2x3ikXOSfvm1NuUX6woWJE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aM/+6Fj7r/rkOw4syoKqRQ48+o1+vsOz/bH62AEFWqm6bBDYBSMmPDVuhAxD217X42wEU0h8rniRFeDhS1IH+2f0KXTrRRMv+hRpm5emQ25bcjRy3CkvbGSE1aU2mb5a/eKsLq1nQ5fa0gLv90XvwR11bFfw9kghCmhegHUkd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360a0a5a87dso5739455ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705651264; x=1706256064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jisrX01orjp0hdmdIXcBI7YOD8tJlZmDnwt6SgEXyQ=;
        b=pzv/2zaD53si6rEB06MplKsOt5wYevz43VFRwrQZzZRJd3pvH8n7D5NqgSaOMDLzuT
         IKMZXYtWaQaW0YyPGncJbs8b8BW18JWQAxUUuNo7JObIk3EwFG1vcCo1QTRFfZ08gLpF
         McfPVZyfdVGQbVXnIIdvfq7ZGtDzwkKGeqJfuDO1hQgYfQL+iX3XZ2zktq4PAN3jlg3w
         s9uusz0zTfn0J9Sa44b8I3WiRujOJUtkZP+oiTYZ4TceYT5CSNV0t8OqVnC6PJQeU0pc
         VNtubwB4sc1UWdGdb4NaJeKWtKkM63+LlDT+sjcNOkpeiKQmQotp+XBqgsjBywqflYE1
         ha6Q==
X-Gm-Message-State: AOJu0YwKJRO4QRisylaN0l7mRAHuBokTyZAS+2lAFaQ1V8xye8A5UPWE
	LmVLAWnJ39evcNWpoK81WRp5uF0ySfYrMMeQB21K+KfBn06LuFG/iVfO4XnM1h7ZK0ujh48krIb
	rMIcKMDGz2bDKG+cQPN0MTOEjd6v0VLmxP56mvHNxpTxqyeqbrfSo9dc=
X-Google-Smtp-Source: AGHT+IH6w3UfoGULzVDgC+8v0hD2kg32svjAU0QmcfKOUWwMK2GMI7PDjSjc5AK8+zMw9nRo/FW69yDxeTxOzHNVIDrlIG2fPHZ+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca09:0:b0:361:94d2:6ecf with SMTP id
 j9-20020a92ca09000000b0036194d26ecfmr262434ils.4.1705651264631; Fri, 19 Jan
 2024 00:01:04 -0800 (PST)
Date: Fri, 19 Jan 2024 00:01:04 -0800
In-Reply-To: <20240119073850.1878-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd3b00060f47e162@google.com>
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
Read of size 1 at addr ffff88813adc000e by task syz-executor.0/5473

CPU: 1 PID: 5473 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-g9d1694dc91ce-dirty #0
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
RIP: 0033:0x7f7be367cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7be42ef0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f7be379bf80 RCX: 00007f7be367cce9
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007f7be36c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f7be379bf80 R15: 00007ffc63da1898
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0004eb7000 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13adc0
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000000 ffffea0004eb7008 ffffea0004eb7008 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88813adbff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813adbff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88813adc0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff88813adc0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813adc0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         9d1694dc Merge tag 'for-6.8/block-2024-01-18' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14e7c2abe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70f4213b9a7b4f3a
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1351cbdbe80000


