Return-Path: <linux-kernel+bounces-29584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64383106E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522B11F23654
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B543BECA;
	Thu, 18 Jan 2024 00:18:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CB39E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537087; cv=none; b=OKcyGboAyDMWwMUShqeWRzRfE5WKj5YWUSsVoWoEByuF6FSdouUAfl623tEB86w1sPxvC3wcMJhhH9F3xNHYhXkVhpAFz0C6oy8GpowunFTQjXOmSPkUqsdA+TyXdnfEojeXYADa6BOaAm/JsGCEwL+mHYX/co4sFpoxN0alvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537087; c=relaxed/simple;
	bh=WSj9P0II9z+6oBLAwD+ZhIcalYR8w6In1pVUOnyQiSM=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=jNfpUh8GWyPChFwYUj/mVkqOKG9hbiwJl5y2qtRcsAUzTmrIAO4SROGc+J+cWcqciPbk84/nkFvcg8GSLw7yj66LFuBoMPKJ0SMtu8USJdDL9sUMWBZg2nH+SZDWv/mC0CLgypMZwuNmXb1sbW1l8/NPo1+Z6r5Tmg1v3ZrJdh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf4698825eso267884639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705537084; x=1706141884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qLmTRPvsMPfNyZ9iUdzWoocKWGYJHp0vSIZjtVLank=;
        b=BewWjbE2ghp8L1dYq0cQXZvKDcTqw5A+enrBlt2k7gpeerOeeWbeiabGLW9F4IpsaE
         Pq3cUrIwCY8bw8eI4pc2iKFaR9WRWi3jSxOqWlvXvIcom9QIXMXh5A8W8dKwmbhKJRw/
         SX4yoCIhZ16NcqXglLN/1m7DPocJW891K8A/69kLPCaaujHDa0Df6YuIBLJxzfh+5i/V
         BkVKBVVDJ4IeSBsr/ESQs4c62741XRIpjeTCnhoP+62h0G0+46ch0QXTp6cPXJjGtGMm
         zb2N+B1YLF6rG6dFMHh+9DHpSCpcDzUPbpuTuQXYSnjc4mAQvpe8acO9I83l6lvwDPy+
         G+yQ==
X-Gm-Message-State: AOJu0YyIvRkNMePY+twE1TfwjfMDYMLNp5BpcNn44YdqDd4+UtW8uvB2
	Y/vLcwEi0Lujaw1XGnidYH8TEqDLa4Xiu2AZAnIWowoW0VkVBVUcuurNytm+VqRvXWP9eg+Y9CB
	Fu33YBnxgyYm6WzQoNOh16MuDW9k9Yfnn3NOqrz2sAo816a1KIB1g0KQ=
X-Google-Smtp-Source: AGHT+IEqSvjhcbV70OZ3wAhAt2mdk+xL/neDSrwnlUXU2m5SLnuO6n9+pjJfDjCBYLTcvZ78EZKlc0Wxi7uOmv0jc9hCoHVykCF7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d87:b0:35f:8652:5ce8 with SMTP id
 h7-20020a056e021d8700b0035f86525ce8mr11312ila.4.1705537084801; Wed, 17 Jan
 2024 16:18:04 -0800 (PST)
Date: Wed, 17 Jan 2024 16:18:04 -0800
In-Reply-To: <20240117234304.1250-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001749b1060f2d4cba@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in nf_ct_get_tuple

==================================================================
BUG: KASAN: use-after-free in nf_ct_get_tuple+0x773/0x790 net/netfilter/nf_conntrack_core.c:301
Read of size 4 at addr ffff88813de50006 by task syz-executor.0/5493

CPU: 1 PID: 5493 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-gd8e6ba025f5e-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 nf_ct_get_tuple+0x773/0x790 net/netfilter/nf_conntrack_core.c:301
 resolve_normal_ct net/netfilter/nf_conntrack_core.c:1824 [inline]
 nf_conntrack_in+0x48f/0x1850 net/netfilter/nf_conntrack_core.c:1998
 ipv4_conntrack_local+0x160/0x260 net/netfilter/nf_conntrack_proto.c:229
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xbb/0x1f0 net/netfilter/core.c:626
 nf_hook+0x386/0x6c0 include/linux/netfilter.h:269
 __ip_local_out+0x33b/0x640 net/ipv4/ip_output.c:118
 ip_local_out+0x2a/0x1a0 net/ipv4/ip_output.c:127
 iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1daa/0x33b0 net/ipv4/ip_tunnel.c:831
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
 __bpf_redirect_no_mac net/core/filter.c:2165 [inline]
 __bpf_redirect+0x6f1/0xf10 net/core/filter.c:2188
 ____bpf_clone_redirect net/core/filter.c:2459 [inline]
 bpf_clone_redirect+0x2b2/0x420 net/core/filter.c:2431
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
RIP: 0033:0x7f178307cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1783e5b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f178319bf80 RCX: 00007f178307cce9
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007f17830c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f178319bf80 R15: 00007ffc443b33a8
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0004f79400 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13de50
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000000 ffffea0004f79408 ffffea0004f79408 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88813de4ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813de4ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88813de50000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88813de50080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813de50100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         d8e6ba02 Merge tag 'thermal-6.8-rc1-2' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12911a0be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58b05ac7ce94e73a
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101a3dcde80000


