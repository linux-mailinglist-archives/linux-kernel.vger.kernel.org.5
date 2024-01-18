Return-Path: <linux-kernel+bounces-30095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF5831928
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819502821DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934724B46;
	Thu, 18 Jan 2024 12:31:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5402C9D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581064; cv=none; b=occfaMrGEu7ZEFGEMOlo0kmbCTbv/jhB1Xe/ixsUu+7uAtrEM3fjVp68KGqG1Xc9w92xQJqFK5F99/mIUpIbDIHWLggRbxORExK2bheupEwSsGbuJ2wE+E7BpFQa61nZNcSk+yUh8OdcqzwKQGZRHJJ4LWvxxU6ogW4sZJBn2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581064; c=relaxed/simple;
	bh=reAtL7XwHcdueQmTSkgVRnbDBP0lYYGMrldVYshLclc=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=b2tquhFWYdAYilsQg2EOSSnBPrhdMUWdLMrGVFbqcH0PfHkmKncY+GpQubv4tvsvSK5QDrycjfDCV1BJ6Pe02ryFPD7MjiTjBUh4VYN3rS9zvoVA7QlC2mtTMh1w2DceeQ3uyNMbqvvVjFr5OpuG4q5wtOScG2KF3Oos9wplda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf178281a5so596432939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 04:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705581062; x=1706185862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pj9Oq6GWIzl5j7t7Q507Gc+ERddqn8CPnAvVAPzcCo=;
        b=RpYHAMKihuOE3OOSXgivwySjkf/b9yrCcAPOgi4UPM4vspzFKo2Dbj+Jk7au0cPdri
         oi20dXurupzwJy5lz3plK7bD9K5QYj2hAGzIV+r5X0VuwznYlwBPm3fotxcuheToYUeD
         jKpTNkdqnmY8K/5HUCPl+x5uQjIstEmHyngqNnA7FSlPcy7lesIAn3iNcS6hy68XlamN
         RI2T1NXFrMYo1AvjiOKO9IAKgZtNk+uOQRBw+gAEldNeMkEnzWpEsjdl0t/ofi3e9Of6
         HaHt2WzBSgcbyCdd9XmyHQn6z4BR0jWEAwB1OQ7Sun4tuXHJI8hirJ+9YfeZodEobE2h
         tjZg==
X-Gm-Message-State: AOJu0YxB9NypEs6FX8rgvtOY2A0iBMpO27p60r63oPCKgPq9Pvtp/32g
	Jb5IF3qXpceyV+57CwRGsU8CO3kVoTBCV3EA+bBui7ih60RKmIOMQ6zHkVriBVQLK7jY9qx/txs
	DaT684lJKvwoqJrQaovX1UKJ7JszfJARnWCg7utmzlHmCM27Omhb7yt8=
X-Google-Smtp-Source: AGHT+IGxu+PYbh7IGa9z4t4YhE28bpfmy6avaOOKnEjG/JVMdnAoT7/SqexTBvS2P36oSTDALHvFpfgOAVI00FwXMUOuhDhpuV72
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f09:b0:7bf:2a07:d67f with SMTP id
 q9-20020a0566022f0900b007bf2a07d67fmr49514iow.2.1705581062721; Thu, 18 Jan
 2024 04:31:02 -0800 (PST)
Date: Thu, 18 Jan 2024 04:31:02 -0800
In-Reply-To: <20240118120812.1575-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000611559060f3789c3@google.com>
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
Read of size 1 at addr ffff88813dcc000e by task syz-executor.0/5486

CPU: 2 PID: 5486 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-g296455ade1fd-dirty #0
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
 __bpf_redirect_no_mac net/core/filter.c:2168 [inline]
 __bpf_redirect+0x71b/0xf10 net/core/filter.c:2191
 ____bpf_clone_redirect net/core/filter.c:2451 [inline]
 bpf_clone_redirect+0xbe/0x110 net/core/filter.c:2434
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
RIP: 0033:0x7f839287cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f83935280c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f839299bf80 RCX: 00007f839287cce9
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007f83928c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f839299bf80 R15: 00007fffb21981d8
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0004f73000 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13dcc0
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000000 ffffea0004f73008 ffffea0004f73008 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88813dcbff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813dcbff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88813dcc0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff88813dcc0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813dcc0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         296455ad Merge tag 'char-misc-6.8-rc1' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12325163e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5a3077efcfd8745
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d07b83e80000


