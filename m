Return-Path: <linux-kernel+bounces-29547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292983100D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A630B2718D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DEC2556A;
	Wed, 17 Jan 2024 23:16:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D321A12
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705533366; cv=none; b=L7yz4luCE3XeZJbCxAM/IeuY6GMj4Ar1yWMkWyru8lScx0z9ogZb6JAVqm53P9jYOtCQlG5X+QTRLdRUnzzNonj/NDTVpiRzZkNntkiJn5BSFBpvtn4DklHWBNuQiR/IDs7rz+hF1/iQ7zL/OwyxLByOawhI44pIsK/9XsisEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705533366; c=relaxed/simple;
	bh=MXgXSUSRkj5FTtY22ALwSoieYFZMVnOdU7O9Eh/hZqc=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=VAVaPNjce4v01gG3IK+3iCWVgacMACMTApgyUAeqKdGoC1OX2Zkr49BO4QAPhdE+3eFwt8qMYhP08oJ8fECor6ZjDzsyWXqwN8t0Ygh3s3cbQZ+/WzRkF87D1O3hfPxfk3XSK8UpD6fLCldta3Thk7qG4H5FRpgwXpMEhyvjITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf5fe1ca9fso12172039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705533364; x=1706138164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xli7BjuAbrH3jzik/v5HfAex5k/DpyybqIgMJzgK8EU=;
        b=nVTavbExKm2A3DJ/R/fO4zQpL3ss/6+GPAAtC44Ybvs+dJzwVHOtRfRoLGAjFfnPUP
         RJuLDxxHyg7YAo5aDWtB+JvJJr0es5yBvuivzWVxoGpl1xPNbFeOJnORo0AKJdXE3RfS
         N60tOA2Z/6rHq+iU1P9AKJ0s4XGYvrwQosK7CFlKaIBx0GoptNfrNNy68Rua5IXkEbdW
         rwi5vIWnyEp5zfooH0jY99O0hHtPT6EFjVgCPVvVIVWGtKDXs9v7RKXsEzn0U2mBvkUH
         Dok8CcH1f4uZoRApOb3c/Orf49D9XrKgNa+aSBFXz1hQP2BZUGYjvnJJZQ49H0/rjiuq
         Kk0w==
X-Gm-Message-State: AOJu0YyHArOUjCOQV55mh7LlsWzfoeqb+C6UOrr6TuDt5cZkXf6tXoPH
	GaD5ly7Xwn3UgRfd7lPJGeBzcZHxmQ2W6aWwa3zCIAj6U9OEKcDRbUzkazFdVsMYOH3hPTtlyoI
	myC8MC9WjXRSeHWYZ73Ju+ITYP1+dIFFyc6Yjns0ihGwdo5zYwiI/Kx4=
X-Google-Smtp-Source: AGHT+IGS2gCu38m7wf+cmclweqPOF2orcH3pn1AqggQdX/i9N7N2CpbsfK2i8W6kV+wr6EOgVmHhl7XJZ4oexrG5Et7dWP99/NYe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1515:b0:46e:5018:7945 with SMTP id
 b21-20020a056638151500b0046e50187945mr895jat.3.1705533364334; Wed, 17 Jan
 2024 15:16:04 -0800 (PST)
Date: Wed, 17 Jan 2024 15:16:04 -0800
In-Reply-To: <20240117225112.1186-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005573a1060f2c6e09@google.com>
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in get_l4proto

==================================================================
BUG: KASAN: use-after-free in ipv4_get_l4proto net/netfilter/nf_conntrack_core.c:358 [inline]
BUG: KASAN: use-after-free in get_l4proto+0x3f6/0x520 net/netfilter/nf_conntrack_core.c:407
Read of size 2 at addr ffff88813d890000 by task syz-executor.0/5489

CPU: 0 PID: 5489 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-g82fd5ee9d8a5-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 ipv4_get_l4proto net/netfilter/nf_conntrack_core.c:358 [inline]
 get_l4proto+0x3f6/0x520 net/netfilter/nf_conntrack_core.c:407
 nf_conntrack_in+0x1e3/0x1850 net/netfilter/nf_conntrack_core.c:1977
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
RIP: 0033:0x7fe1ad67cce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe1ae3d80c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fe1ad79bf80 RCX: 00007fe1ad67cce9
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00007fe1ad6c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe1ad79bf80 R15: 00007ffdca27b398
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0004f62400 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x13d890
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000000 ffffea0004f62408 ffffea0004f62408 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88813d88ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813d88ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88813d890000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88813d890080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88813d890100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         82fd5ee9 Merge tag 'for-linus-6.8-rc1-tag' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15b35ba3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9cd0a945c0f757a8
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16dc3a57e80000


