Return-Path: <linux-kernel+bounces-18133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F8825942
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED26F1C2355C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77423328B6;
	Fri,  5 Jan 2024 17:42:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93127321A1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36037f2de0aso14659455ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476545; x=1705081345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0J45BElnGsnlb+hcSi7W72v1ypQ+RzOOzGvT7znb7Wo=;
        b=c2j3BrvMaoLyv93+xQ0xuNT1tyYNJlPtBxFuW5JL/vgv0zN/Hbv1CI9O178bBG/PEH
         XRBZzLOkF9WWckPmtE7EuLGwKP3DFkI8tpuev9J31urI8sgaDPAuscPqzNuSgppAi45e
         fNe7/RvO1fTuHSl13vn7VKbaTbliloEncc1zqhZ4pRQJIpsLAnxrk6hvlkdLfVX7oAao
         YsX5hGhFUudbKPPLGeYuWVdfZdU8z35N5Lt1BLHzHCEX7QHcm22fJ3QtObjbls135/l+
         bpn6Wob/UAg9fV/kD+krHC7CyBMQM3Y+ecgOL8t52D+R78sL+RvGR9LiBv22BhKLYb0Y
         MSRQ==
X-Gm-Message-State: AOJu0YwaplT2y9nIwwLdWhy9B/0t2OihkD89zPp5N3IaX8Avs4U+Jlzg
	SXA3uxsDmFQuzNVcU5RzExDkM5qhMklA47XgmhcQOAn32z1l
X-Google-Smtp-Source: AGHT+IEH/62ge5L/6C4J8oC9QOFx6BxKcXIlp09EJF9yV0qlcWTkit/aTWs24gpEIzhi7h9RckuaVS5BjRb0I3sM5jODynIcvMRI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be2:b0:35f:cb88:883e with SMTP id
 y2-20020a056e021be200b0035fcb88883emr385668ilv.6.1704476545824; Fri, 05 Jan
 2024 09:42:25 -0800 (PST)
Date: Fri, 05 Jan 2024 09:42:25 -0800
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000abe28060e365f12@google.com>
Subject: Re: [syzbot] [net?] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com, 
	thomas.zeitlhofer+lkml@ze-it.at, thomas.zeitlhofer@ze-it.at, 
	wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2258c2dc850b Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f67b44480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fb7ad9185f1501
dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e23d44480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0e65a45877eb/disk-2258c2dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7617adf885a8/vmlinux-2258c2dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/43fb89ea894a/bzImage-2258c2dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810b8ea400 (size 512):
  comm "kworker/0:3", pid 4440, jiffies 4294938594 (age 1132.680s)
  hex dump (first 32 bytes):
    00 9c f8 0a 81 88 ff ff 80 29 23 86 ff ff ff ff  .........)#.....
    c0 79 79 44 81 88 ff ff 72 78 ff ff 00 00 00 00  .yyD....rx......
  backtrace:
    [<ffffffff814f9fe6>] __do_kmalloc_node mm/slab_common.c:967 [inline]
    [<ffffffff814f9fe6>] __kmalloc+0x46/0x120 mm/slab_common.c:981
    [<ffffffff83b5234f>] kmalloc include/linux/slab.h:584 [inline]
    [<ffffffff83b5234f>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83b5234f>] neigh_alloc net/core/neighbour.c:476 [inline]
    [<ffffffff83b5234f>] ___neigh_create+0xdf/0xd60 net/core/neighbour.c:661
    [<ffffffff83f9f886>] ip6_finish_output2+0x776/0x9b0 net/ipv6/ip6_output.c:125
    [<ffffffff83fa5530>] __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
    [<ffffffff83fa5530>] ip6_finish_output+0x270/0x530 net/ipv6/ip6_output.c:206
    [<ffffffff83fa5893>] NF_HOOK_COND include/linux/netfilter.h:291 [inline]
    [<ffffffff83fa5893>] ip6_output+0xa3/0x1b0 net/ipv6/ip6_output.c:227
    [<ffffffff83ff16d9>] dst_output include/net/dst.h:444 [inline]
    [<ffffffff83ff16d9>] NF_HOOK include/linux/netfilter.h:302 [inline]
    [<ffffffff83ff16d9>] NF_HOOK.constprop.0+0x49/0x110 include/linux/netfilter.h:296
    [<ffffffff83ff19c4>] mld_sendpack+0x224/0x350 net/ipv6/mcast.c:1820
    [<ffffffff83ff5403>] mld_send_cr net/ipv6/mcast.c:2121 [inline]
    [<ffffffff83ff5403>] mld_ifc_work+0x2a3/0x750 net/ipv6/mcast.c:2653
    [<ffffffff8129519a>] process_one_work+0x2ba/0x5f0 kernel/workqueue.c:2289
    [<ffffffff81295ab9>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8129fb05>] kthread+0x125/0x160 kernel/kthread.c:376
    [<ffffffff8100224f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

BUG: memory leak
unreferenced object 0xffff888109a7fa00 (size 512):
  comm "kworker/0:3", pid 4440, jiffies 4294938594 (age 1132.680s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 29 23 86 ff ff ff ff  .........)#.....
    00 79 79 44 81 88 ff ff 72 78 ff ff 00 00 00 00  .yyD....rx......
  backtrace:
    [<ffffffff814f9fe6>] __do_kmalloc_node mm/slab_common.c:967 [inline]
    [<ffffffff814f9fe6>] __kmalloc+0x46/0x120 mm/slab_common.c:981
    [<ffffffff83b5234f>] kmalloc include/linux/slab.h:584 [inline]
    [<ffffffff83b5234f>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83b5234f>] neigh_alloc net/core/neighbour.c:476 [inline]
    [<ffffffff83b5234f>] ___neigh_create+0xdf/0xd60 net/core/neighbour.c:661
    [<ffffffff83f9f886>] ip6_finish_output2+0x776/0x9b0 net/ipv6/ip6_output.c:125
    [<ffffffff83fa5530>] __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
    [<ffffffff83fa5530>] ip6_finish_output+0x270/0x530 net/ipv6/ip6_output.c:206
    [<ffffffff83fa5893>] NF_HOOK_COND include/linux/netfilter.h:291 [inline]
    [<ffffffff83fa5893>] ip6_output+0xa3/0x1b0 net/ipv6/ip6_output.c:227
    [<ffffffff83ff16d9>] dst_output include/net/dst.h:444 [inline]
    [<ffffffff83ff16d9>] NF_HOOK include/linux/netfilter.h:302 [inline]
    [<ffffffff83ff16d9>] NF_HOOK.constprop.0+0x49/0x110 include/linux/netfilter.h:296
    [<ffffffff83ff19c4>] mld_sendpack+0x224/0x350 net/ipv6/mcast.c:1820
    [<ffffffff83ff5403>] mld_send_cr net/ipv6/mcast.c:2121 [inline]
    [<ffffffff83ff5403>] mld_ifc_work+0x2a3/0x750 net/ipv6/mcast.c:2653
    [<ffffffff8129519a>] process_one_work+0x2ba/0x5f0 kernel/workqueue.c:2289
    [<ffffffff81295ab9>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2436
    [<ffffffff8129fb05>] kthread+0x125/0x160 kernel/kthread.c:376
    [<ffffffff8100224f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

BUG: memory leak
unreferenced object 0xffff88810a9fb400 (size 512):
  comm "dhcpcd", pid 4638, jiffies 4294938595 (age 1132.670s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 29 23 86 ff ff ff ff  .........)#.....
    c0 76 79 44 81 88 ff ff 73 78 ff ff 00 00 00 00  .vyD....sx......
  backtrace:
    [<ffffffff814f9fe6>] __do_kmalloc_node mm/slab_common.c:967 [inline]
    [<ffffffff814f9fe6>] __kmalloc+0x46/0x120 mm/slab_common.c:981
    [<ffffffff83b5234f>] kmalloc include/linux/slab.h:584 [inline]
    [<ffffffff83b5234f>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83b5234f>] neigh_alloc net/core/neighbour.c:476 [inline]
    [<ffffffff83b5234f>] ___neigh_create+0xdf/0xd60 net/core/neighbour.c:661
    [<ffffffff83f9f886>] ip6_finish_output2+0x776/0x9b0 net/ipv6/ip6_output.c:125
    [<ffffffff83fa5530>] __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
    [<ffffffff83fa5530>] ip6_finish_output+0x270/0x530 net/ipv6/ip6_output.c:206
    [<ffffffff83fa5893>] NF_HOOK_COND include/linux/netfilter.h:291 [inline]
    [<ffffffff83fa5893>] ip6_output+0xa3/0x1b0 net/ipv6/ip6_output.c:227
    [<ffffffff84062411>] dst_output include/net/dst.h:444 [inline]
    [<ffffffff84062411>] ip6_local_out+0x51/0x70 net/ipv6/output_core.c:155
    [<ffffffff83fa6285>] ip6_send_skb+0x25/0xc0 net/ipv6/ip6_output.c:1971
    [<ffffffff83fa6394>] ip6_push_pending_frames+0x74/0x90 net/ipv6/ip6_output.c:1991
    [<ffffffff83fec08c>] rawv6_push_pending_frames net/ipv6/raw.c:579 [inline]
    [<ffffffff83fec08c>] rawv6_sendmsg+0x16ac/0x1ba0 net/ipv6/raw.c:922
    [<ffffffff83ebe965>] inet_sendmsg+0x45/0x70 net/ipv4/af_inet.c:827
    [<ffffffff83af7116>] sock_sendmsg_nosec net/socket.c:714 [inline]
    [<ffffffff83af7116>] sock_sendmsg+0x56/0x80 net/socket.c:734
    [<ffffffff83af769d>] ____sys_sendmsg+0x38d/0x410 net/socket.c:2476
    [<ffffffff83afbfe8>] ___sys_sendmsg+0xa8/0x110 net/socket.c:2530
    [<ffffffff83afc178>] __sys_sendmsg+0x88/0x100 net/socket.c:2559
    [<ffffffff848ed5b5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848ed5b5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810a9fba00 (size 512):
  comm "dhcpcd", pid 4638, jiffies 4294938595 (age 1132.670s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 80 29 23 86 ff ff ff ff  .........)#.....
    80 77 79 44 81 88 ff ff 73 78 ff ff 00 00 00 00  .wyD....sx......
  backtrace:
    [<ffffffff814f9fe6>] __do_kmalloc_node mm/slab_common.c:967 [inline]
    [<ffffffff814f9fe6>] __kmalloc+0x46/0x120 mm/slab_common.c:981
    [<ffffffff83b5234f>] kmalloc include/linux/slab.h:584 [inline]
    [<ffffffff83b5234f>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff83b5234f>] neigh_alloc net/core/neighbour.c:476 [inline]
    [<ffffffff83b5234f>] ___neigh_create+0xdf/0xd60 net/core/neighbour.c:661
    [<ffffffff83f9f886>] ip6_finish_output2+0x776/0x9b0 net/ipv6/ip6_output.c:125
    [<ffffffff83fa5530>] __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
    [<ffffffff83fa5530>] ip6_finish_output+0x270/0x530 net/ipv6/ip6_output.c:206
    [<ffffffff83fa5893>] NF_HOOK_COND include/linux/netfilter.h:291 [inline]
    [<ffffffff83fa5893>] ip6_output+0xa3/0x1b0 net/ipv6/ip6_output.c:227
    [<ffffffff84062411>] dst_output include/net/dst.h:444 [inline]
    [<ffffffff84062411>] ip6_local_out+0x51/0x70 net/ipv6/output_core.c:155
    [<ffffffff83fa6285>] ip6_send_skb+0x25/0xc0 net/ipv6/ip6_output.c:1971
    [<ffffffff83fa6394>] ip6_push_pending_frames+0x74/0x90 net/ipv6/ip6_output.c:1991
    [<ffffffff83fec08c>] rawv6_push_pending_frames net/ipv6/raw.c:579 [inline]
    [<ffffffff83fec08c>] rawv6_sendmsg+0x16ac/0x1ba0 net/ipv6/raw.c:922
    [<ffffffff83ebe965>] inet_sendmsg+0x45/0x70 net/ipv4/af_inet.c:827
    [<ffffffff83af7116>] sock_sendmsg_nosec net/socket.c:714 [inline]
    [<ffffffff83af7116>] sock_sendmsg+0x56/0x80 net/socket.c:734
    [<ffffffff83af769d>] ____sys_sendmsg+0x38d/0x410 net/socket.c:2476
    [<ffffffff83afbfe8>] ___sys_sendmsg+0xa8/0x110 net/socket.c:2530
    [<ffffffff83afc178>] __sys_sendmsg+0x88/0x100 net/socket.c:2559
    [<ffffffff848ed5b5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff848ed5b5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

