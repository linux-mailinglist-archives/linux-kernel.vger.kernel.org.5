Return-Path: <linux-kernel+bounces-64901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FFD854476
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E998F1F2459E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102AABA29;
	Wed, 14 Feb 2024 08:58:26 +0000 (UTC)
Received: from smtp2-kfki.kfki.hu (smtp2-kfki.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A879C0;
	Wed, 14 Feb 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901105; cv=none; b=aAT8pSzdl767TYnzFBhMcd1c0FKrfrCCx77iF84EjIWKAzYeSq9Iikk1qswrrZNDX7QwDwiMbrV6NK/XyoxqDvwClaO28bqG8t/uT4pBOeHFCbTm8C0txigVkC17vb2bU5JzT7Fpd+0HLGIV30eMlla3xgxPnKbVu63V2pTlKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901105; c=relaxed/simple;
	bh=uaqZUg8mZx1t6VSWIkjz1N51L+Li3egJ+H+n1pJ1lmw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OnmXc9M8z42fvsBtrSyy9b9QCsK/KmUFdxpfXKMysUHvhco9EC+UygE9Vnl8Tu6XfHo4opL7v1IKNzd9ygLihXyUuOA+nqd9gOGVpCb+s/wWL9azLbe+N81Ur788o1ClBIgE+Sbpe6F+zt0J6yA/xZVN0o/K24rRWNx1yjD8DCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=148.6.0.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4F61CCC02CF;
	Wed, 14 Feb 2024 09:58:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
	by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Wed, 14 Feb 2024 09:58:10 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp2.kfki.hu (Postfix) with ESMTP id C6C2FCC02CD;
	Wed, 14 Feb 2024 09:58:09 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id 78020343167; Wed, 14 Feb 2024 09:58:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id 76565343166;
	Wed, 14 Feb 2024 09:58:09 +0100 (CET)
Date: Wed, 14 Feb 2024 09:58:09 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@netfilter.org>
To: coreteam@netfilter.org
cc: David Miller <davem@davemloft.net>, edumazet@google.com, 
    Florian Westphal <fw@strlen.de>, kuba@kernel.org, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
    netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
    Pablo Neira Ayuso <pablo@netfilter.org>, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
In-Reply-To: <000000000000d42dae0611477922@google.com>
Message-ID: <b1d20932-19c1-6cc7-2203-eff38953ad5a@netfilter.org>
References: <000000000000d42dae0611477922@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

It seems this is an old bug uncovered now: the bitmap type of sets still
use del_timer_sync() to cancel the garbage collecors. However
del_timer_sync() does not prevent rearming, which is triggered by syzbot.
The proper way to solve the issue is a one-liner:

diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index cb48a2b9cb9f..60f5e29ac8fd 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -294,7 +294,7 @@ mtype_cancel_gc(struct ip_set *set)
        struct mtype *map = set->data;

        if (SET_WITH_TIMEOUT(set))
-               del_timer_sync(&map->gc);
+               timer_shutdown_sync(&map->gc);
 }

 static const struct ip_set_type_variant mtype = {

(There are no other set types in ipset where del_timer_sync() is used.)

I'll need time for testing then if it fixes the bug, then I'll submit the 
patch.

Best regards,
Jozsef

On Tue, 13 Feb 2024, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f735966ee23c Merge branches 'for-next/reorg-va-space' and ..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=168b6592180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d47605a39da2cf06
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebbab3e04c88fa141e6b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1000ede0180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a6ba2180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bdea2316c4db/disk-f735966e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75ba7806a91c/vmlinux-f735966e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/208f119d45ed/Image-f735966e.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object: 00000000310f7442 object type: timer_list hint: bitmap_port_gc+0x0/0x4dc net/netfilter/ipset/ip_set_bitmap_port.c:282
> WARNING: CPU: 1 PID: 6165 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
> WARNING: CPU: 1 PID: 6165 at lib/debugobjects.c:517 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
> WARNING: CPU: 1 PID: 6165 at lib/debugobjects.c:517 debug_check_no_obj_freed+0x398/0x47c lib/debugobjects.c:1019
> Modules linked in:
> CPU: 1 PID: 6165 Comm: syz-executor468 Not tainted 6.8.0-rc3-syzkaller-gf735966ee23c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : debug_print_object lib/debugobjects.c:514 [inline]
> pc : __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
> pc : debug_check_no_obj_freed+0x398/0x47c lib/debugobjects.c:1019
> lr : debug_print_object lib/debugobjects.c:514 [inline]
> lr : __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
> lr : debug_check_no_obj_freed+0x398/0x47c lib/debugobjects.c:1019
> sp : ffff800097886950
> x29: ffff800097886990 x28: 0000000000000000 x27: ffff80008aeec3c0
> x26: ffff0000d051c718 x25: dfff800000000000 x24: 0000000000000000
> x23: ffff80009365bb10 x22: ffff0000d051c000 x21: 0000000000000000
> x20: ffff8000894dfe30 x19: ffff0000d051c700 x18: ffff800097885e20
> x17: 626f203234343766 x16: ffff80008aca1180 x15: 0000000000000001
> x14: 1ffff00012f10c44 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000002 x10: 0000000000ff0100 x9 : f70d4eacec590700
> x8 : f70d4eacec590700 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff800097886238 x4 : ffff80008ed517e0 x3 : ffff80008036df60
> x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
> Call trace:
>  debug_print_object lib/debugobjects.c:514 [inline]
>  __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
>  debug_check_no_obj_freed+0x398/0x47c lib/debugobjects.c:1019
>  slab_free_hook mm/slub.c:2093 [inline]
>  slab_free mm/slub.c:4299 [inline]
>  kfree+0x114/0x3cc mm/slub.c:4409
>  kvfree+0x40/0x50 mm/util.c:663
>  ip_set_free+0x28/0x7c net/netfilter/ipset/ip_set_core.c:264
>  bitmap_port_destroy+0xe4/0x324 net/netfilter/ipset/ip_set_bitmap_gen.h:66
>  ip_set_create+0x904/0xf48 net/netfilter/ipset/ip_set_core.c:1157
>  nfnetlink_rcv_msg+0xa78/0xf80 net/netfilter/nfnetlink.c:302
>  netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2543
>  nfnetlink_rcv+0x21c/0x1ed0 net/netfilter/nfnetlink.c:659
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x26c/0x33c net/socket.c:2667
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
>  el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> irq event stamp: 524
> hardirqs last  enabled at (523): [<ffff80008035f104>] __up_console_sem kernel/printk/printk.c:341 [inline]
> hardirqs last  enabled at (523): [<ffff80008035f104>] __console_unlock kernel/printk/printk.c:2706 [inline]
> hardirqs last  enabled at (523): [<ffff80008035f104>] console_unlock+0x17c/0x3d4 kernel/printk/printk.c:3038
> hardirqs last disabled at (524): [<ffff80008ad60eac>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
> softirqs last  enabled at (518): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
> softirqs last  enabled at (518): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
> softirqs last disabled at (507): [<ffff80008002ab48>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
> 

-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary

