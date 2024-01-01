Return-Path: <linux-kernel+bounces-13912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624082149C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02029281D92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9479C5;
	Mon,  1 Jan 2024 17:18:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E163C7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7baae0a27efso499092539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 09:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704129496; x=1704734296;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9cXFa/sT4NhazoGhL0aFUkvNSDfMMax6IksebCOSks=;
        b=of8tcdsMph/GSgGvMWyGVa9ZoG9PBFBxiMz7jIOCsWE+918dLCFCHEgTQQxARqKkZ4
         EJiGDTwg4cnYgy8d9FUMra3X43tsYrc2Yf26Vg3PkyR9IyZ1659tc8+8qCB8dcSt9tYt
         AxAhbIVrZ1dmb9XDgwheR0Z6B9NJpkzl8W7L5PSy/WGojtjA1kxtgaU7vmFNVZ6++fbz
         zlWbu043WFKk5jkhja5xjyFzU2aPSaygjDw+R0xVzq3GoJ6D5EXPbX8WE7Ljuc0/EnV2
         NZN1jJF80uxtKAgcY+J9wKZTRHq/NmV5HaOAf8Qm5MAP3qJR7Y71etxEB+v0FwoEx07E
         aCGg==
X-Gm-Message-State: AOJu0YwxgLLqwi02b0keMfzmBEm7kYYrNtV6Soy/1G7RyPEJLnX1RbGU
	l5u4Vs0ZBoEwnSFQBMNEfyRSFu7l6DlFTx8d83X+7GWoW4uy
X-Google-Smtp-Source: AGHT+IHDhRtiCPkXVRge+lXdk8r4A3tzBmBJonC0XwBDyCmHfc8fn8d386LwcmYgKXgnqh6z6uMywWmWPNz+md1F+0lqbGQ5opEG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:340d:b0:35f:e800:eb79 with SMTP id
 bo13-20020a056e02340d00b0035fe800eb79mr614603ilb.1.1704129496449; Mon, 01 Jan
 2024 09:18:16 -0800 (PST)
Date: Mon, 01 Jan 2024 09:18:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000498a02060de59162@google.com>
Subject: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
From: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1650e3d9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
dashboard link: https://syzkaller.appspot.com/bug?extid=bfde3bef047a81b8fde6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e61d95e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122dfc65e80000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-f5837722.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/148f0f94b7b6/vmlinux-f5837722.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d63ba20405f3/bzImage-f5837722.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
Read of size 1 at addr ffff88812fb4000e by task syz-executor183/5191

CPU: 1 PID: 5191 Comm: syz-executor183 Not tainted 6.7.0-rc7-syzkaller-00016-gf5837722ffec #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
 skb_flow_dissect_flow_keys include/linux/skbuff.h:1514 [inline]
 ___skb_get_hash net/core/flow_dissector.c:1791 [inline]
 __skb_get_hash+0xc7/0x540 net/core/flow_dissector.c:1856
 skb_get_hash include/linux/skbuff.h:1556 [inline]
 ip_tunnel_xmit+0x1855/0x33c0 net/ipv4/ip_tunnel.c:748
 ipip_tunnel_xmit+0x3cc/0x4e0 net/ipv4/ipip.c:308
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
 __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 neigh_connected_output+0x42c/0x5d0 net/core/neighbour.c:1592
 neigh_output include/net/neighbour.h:542 [inline]
 ip_finish_output2+0x833/0x2550 net/ipv4/ip_output.c:235
 __ip_finish_output net/ipv4/ip_output.c:313 [inline]
 __ip_finish_output+0x38b/0x650 net/ipv4/ip_output.c:295
 ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_mc_output+0x1dd/0x6a0 net/ipv4/ip_output.c:420
 dst_output include/net/dst.h:451 [inline]
 ip_local_out+0xaf/0x1a0 net/ipv4/ip_output.c:129
 iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbc/0x33c0 net/ipv4/ip_tunnel.c:831
 ipgre_xmit+0x4a1/0x980 net/ipv4/ip_gre.c:665
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
 __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 __bpf_tx_skb net/core/filter.c:2133 [inline]
 __bpf_redirect_no_mac net/core/filter.c:2163 [inline]
 __bpf_redirect+0x6f1/0xf10 net/core/filter.c:2186
 ____bpf_clone_redirect net/core/filter.c:2457 [inline]
 bpf_clone_redirect+0x2b2/0x420 net/core/filter.c:2429
 ___bpf_prog_run+0x3e44/0xabc0 kernel/bpf/core.c:1962
 __bpf_prog_run512+0xb7/0xf0 kernel/bpf/core.c:2203
 bpf_dispatcher_nop_func include/linux/bpf.h:1196 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x3d3/0x9c0 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0xb75/0x1dd0 net/bpf/test_run.c:1045
 bpf_prog_test_run kernel/bpf/syscall.c:4040 [inline]
 __sys_bpf+0x11bf/0x4910 kernel/bpf/syscall.c:5401
 __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5485
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8b086e9d69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff09b0b818 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8b086e9d69
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000100000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0004bed000 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12fb40
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000000 ffffea0004bed008 ffffea0004bed008 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88812fb3ff00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88812fb3ff80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88812fb40000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff88812fb40080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88812fb40100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

