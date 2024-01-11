Return-Path: <linux-kernel+bounces-23524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5453182ADFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DB81F21FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A39156C1;
	Thu, 11 Jan 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF29rmyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF05154A7;
	Thu, 11 Jan 2024 11:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D7FC433C7;
	Thu, 11 Jan 2024 11:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704974095;
	bh=934xArPcwgrcbeYIYP8olwl4AlYU/6VK7iCMUI4GrJA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rF29rmyBB3DG5FrT7E2binUe0NCiLD7n+KO+a/T4PTfsPL1/y5yI14cT15P6BLKX+
	 V/F1uDhuLz/QROCKHypGHZqMenRCNkUBLxmLstL1kmDnmGwINOTc2kFKv7SUItENaZ
	 qKK3pVxJDuqavlrBE3uBAk9CQ+qYws66BXh8q1reMjXDiUoOXBljRQ9kVv/TQYf3Iq
	 tLYRuLf1YiqmLPj3yuFuJIJxExpJ8fO7qkhrg6ct9fkUeCOk0F5Ff4gBdPhut0I+cR
	 2WiNil53zfV2KeG4uAZY4jYApHZS7qEtuUnFOG2LjE9SKRWVD1msMZ8AapmJ0FfBEa
	 kaldrHcWKP0ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 49015CE045D; Thu, 11 Jan 2024 03:54:55 -0800 (PST)
Date: Thu, 11 Jan 2024 03:54:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, quic_neeraju@quicinc.com, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Fix WARN_ON_ONCE() in the
 rcu_nocb_bypass_lock()
Message-ID: <06bb8028-a1be-431c-9bff-265777d64e27@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240110081128.18683-1-qiang.zhang1211@gmail.com>
 <CALm+0cXQF0nS6HD5iZ1RhbWo0rg8adwvcHrsS8W04K1MxY51bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cXQF0nS6HD5iZ1RhbWo0rg8adwvcHrsS8W04K1MxY51bA@mail.gmail.com>

On Wed, Jan 10, 2024 at 04:36:46PM +0800, Z qiang wrote:
> >
> > For the kernels built with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y and
> > CONFIG_RCU_LAZY=y, here are the following scenarios that will trigger
> > WARN_ON_ONCE() in the rcu_nocb_bypass_lock() and rcu_nocb_wait_contended().
> >
> >         CPU2                                               CPU11
> > kthread
> > rcu_nocb_cb_kthread                                       ksys_write
> > rcu_do_batch                                              vfs_write
> > rcu_torture_timer_cb                                      proc_sys_write
> > __kmem_cache_free                                         proc_sys_call_handler
> > kmemleak_free                                             drop_caches_sysctl_handler
> > delete_object_full                                        drop_slab
> > __delete_object                                           shrink_slab
> > put_object                                                lazy_rcu_shrink_scan
> > call_rcu                                                  rcu_nocb_flush_bypass
> > __call_rcu_commn                                            rcu_nocb_bypass_lock
> >                                                             raw_spin_trylock(&rdp->nocb_bypass_lock) fail
> >                                                             atomic_inc(&rdp->nocb_lock_contended);
> > rcu_nocb_wait_contended                                     WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
> >  WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))                                          |
> >                             |_ _ _ _ _ _ _ _ _ _same rdp and rdp->cpu != 11_ _ _ _ _ _ _ _ _ __|
> >
> > This commit therefore use the rcu_nocb_try_flush_bypass() instead of
> > rcu_nocb_flush_bypass() in lazy_rcu_shrink_scan(), if the nocb_bypass
> > queue is being flushed, the rcu_nocb_try_flush_bypass will return directly.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Just to make sure I understand, the "echo" command called out below
will trigger the two-CPU scenario called out above in kernels built with
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y and CONFIG_RCU_LAZY=y, correct?

If so, good catch!

Any objections to this patch?  Or to put it another way, is there a
better fix via adjusting lazy RCU?

							Thanx, Paul

> > ---
> 
> During rcutorture testing, use echo 3 > /proc/sys/vm/drop_caches will trigger:
> 
> [ 52.674359] WARNING: CPU: 11 PID: 505 at kernel/rcu/tree_nocb.h:104
> rcu_nocb_bypass_lock+0xc7/0xd0
> [ 52.674388] Modules linked in:
> [ 52.674406] CPU: 11 PID: 505 Comm: sh Not tainted 6.6.0-rt14zqiang-dirty #103
> [ 52.674422] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [ 52.674436] RIP: 0010:rcu_nocb_bypass_lock+0xc7/0xd0
> [ 52.674454] Code: 4c 89 e7 e8 4b 3d 6a 01 be 04 00 00 00 4c 89 ef e8
> ce 92 31 00 f0 ff 8b 68 02 00 00 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc
> cc 90 <0f> 0b 90 eb d1 0f 1f 40 00 90 90 0
> [ 52.674467] RSP: 0018:ffff88800af6fa68 EFLAGS: 00010093
> [ 52.674487] RAX: 0000000000000000 RBX: ffff888069e0f540 RCX: ffffffffb5c12d44
> [ 52.674497] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff888069e0fb10
> [ 52.674508] RBP: ffff88800af6fa88 R08: ffffed100d3c1ef6 R09: ffffed100d3c1ef6
> [ 52.674518] R10: ffffed100d3c1ef5 R11: ffff888069e0f7ab R12: ffff888069e0f8c0
> [ 52.674529] R13: ffff888069e0f7a8 R14: 000000000000000b R15: ffff88800af6fb90
> [ 52.674540] FS: 00007ff543132740(0000) GS:ffff88806c000000(0000)
> knlGS:0000000000000000
> [ 52.674555] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 52.674565] CR2: 000055df13465004 CR3: 00000000027f2000 CR4: 00000000001506e0
> [ 52.674576] Call Trace:
> [ 52.674583] <TASK>
> [ 52.674598] ? show_regs+0x66/0x70
> [ 52.674627] ? __warn+0xae/0x220
> [ 52.674657] ? rcu_nocb_bypass_lock+0xc7/0xd0
> [ 52.674693] ? report_bug+0x14a/0x240
> [ 52.674756] ------------[ cut here ]------------
> [ 52.674766] WARNING: CPU: 2 PID: 118 at kernel/rcu/tree_nocb.h:124
> __call_rcu_common+0xd3f/0xd80
> [ 52.674785] Modules linked in:
> [ 52.674785] ? handle_bug+0x44/0x80
> [ 52.674795] CPU: 2 PID: 118 Comm: rcuop/10 Not tainted
> 6.6.0-rt14zqiang-dirty #103
> [ 52.674806] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [ 52.674812] RIP: 0010:__call_rcu_common+0xd3f/0xd80
> [ 52.674816] ? exc_invalid_op+0x1c/0x50
> [ 52.674822] Code: 9e 02 4c 89 e2 e8 a1 46 ff ff e9 d0 fa ff ff 48 8d
> 7b 18 e8 43 5f 30 00 48 8b 7b 18 48 89 de e8 67 9a ff ff e9 69 f6 ff
> ff 90 <0f> 0b 90 f3 90 e9 17 fa ff ff 90 b
> [ 52.674832] RSP: 0018:ffff888002277af8 EFLAGS: 00010002
> [ 52.674847] RAX: 0000000000000001 RBX: ffff888069e0f540 RCX: ffffffffb5c24655
> [ 52.674848] ? asm_exc_invalid_op+0x1f/0x30
> [ 52.674857] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffff888069e0f7a8
> [ 52.674867] RBP: ffff888002277bf0 R08: ffffed100d3c1ef6 R09: ffffed100d3c1ef6
> [ 52.674877] R10: ffffed100d3c1ef5 R11: ffff888069e0f7ab R12: ffff88800bab62f8
> [ 52.674887] R13: ffff888069e0f7a8 R14: 0000000000000000 R15: ffff888069e0f918
> [ 52.674897] FS: 0000000000000000(0000) GS:ffff888069c00000(0000)
> knlGS:0000000000000000
> [ 52.674910] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 52.674920] CR2: 000055df13419911 CR3: 00000000027f2000 CR4: 00000000001506e0
> [ 52.674930] Call Trace:
> [ 52.674936] <TASK>
> [ 52.674934] ? rcu_nocb_bypass_lock+0x94/0xd0
> [ 52.674950] ? show_regs+0x66/0x70
> [ 52.674972] ? rcu_nocb_bypass_lock+0xc7/0xd0
> [ 52.674974] ? __warn+0xae/0x220
> [ 52.675002] ? __call_rcu_common+0xd3f/0xd80
> [ 52.675010] ? rcu_nocb_bypass_lock+0x94/0xd0
> [ 52.675037] ? report_bug+0x14a/0x240
> [ 52.675054] rcu_nocb_flush_bypass+0x3a/0x60
> [ 52.675094] ? handle_bug+0x44/0x80
> [ 52.675095] lazy_rcu_shrink_scan+0x12e/0x220
> [ 52.675114] ? exc_invalid_op+0x1c/0x50
> [ 52.675139] ? asm_exc_invalid_op+0x1f/0x30
> [ 52.675156] shrink_slab.constprop.116+0x2cd/0x6e0
> [ 52.675206] ? __call_rcu_common+0x775/0xd80
> [ 52.675239] ? __call_rcu_common+0xd3f/0xd80
> [ 52.675259] ? __pfx_shrink_slab.constprop.116+0x10/0x10
> [ 52.675272] ? __call_rcu_common+0x775/0xd80
> [ 52.675335] ? __pfx_drop_pagecache_sb+0x10/0x10
> [ 52.675365] ? __pfx___call_rcu_common+0x10/0x10
> [ 52.675386] ? preempt_schedule+0x7f/0xa0
> [ 52.675396] drop_slab+0x64/0x90
> [ 52.675413] ? preempt_schedule_thunk+0x1a/0x30
> [ 52.675426] drop_caches_sysctl_handler+0x82/0xe0
> [ 52.675472] call_rcu+0x17/0x20
> [ 52.675489] put_object+0x53/0x70
> [ 52.675513] __delete_object+0x73/0x90
> [ 52.675545] delete_object_full+0x1f/0x30
> [ 52.675563] kmemleak_free+0x41/0x70
> [ 52.675586] __kmem_cache_free+0x1bd/0x230
> [ 52.675598] ? rcu_torture_timer_cb+0x12/0x20
> [ 52.675623] ? rcu_do_batch+0x466/0xf50
> [ 52.675649] kfree+0x90/0x110
> [ 52.675661] ? __pfx_rcu_torture_timer_cb+0x10/0x10
> [ 52.675678] rcu_torture_timer_cb+0x12/0x20
> [ 52.675697] rcu_do_batch+0x46b/0xf50
> [ 52.675464] proc_sys_call_handler+0x247/0x310
> [ 52.675772] ? __pfx_rcu_do_batch+0x10/0x10
> [ 52.675785] ? migrate_disable+0x2a/0xf0
> [ 52.675815] ? lockdep_softirqs_off+0x13d/0x200
> [ 52.675854] ? rcu_nocb_cb_kthread+0x29c/0x880
> [ 52.675889] rcu_nocb_cb_kthread+0x2b1/0x880
> [ 52.675910] ? __pfx_proc_sys_call_handler+0x10/0x10
> [ 52.675945] ? vfs_write+0x3ea/0x7c0
> [ 52.675958] ? vfs_write+0x3ea/0x7c0
> [ 52.675959] ? __pfx_rcu_nocb_cb_kthread+0x10/0x10
> [ 52.675974] ? trace_preempt_on+0x54/0xe0
> [ 52.675990] ? __kthread_parkme+0x80/0x110
> [ 52.676015] ? preempt_count_sub+0x50/0x80
> [ 52.676031] proc_sys_write+0x17/0x20
> [ 52.676050] vfs_write+0x58b/0x7c0
> [ 52.676063] ? __kthread_parkme+0xf2/0x110
> [ 52.676111] ? __pfx_rcu_nocb_cb_kthread+0x10/0x10
> [ 52.676112] ? __pfx_vfs_write+0x10/0x10
> [ 52.676139] kthread+0x1a8/0x1f0
> [ 52.676161] ? kthread+0x107/0x1f0
> [ 52.676163] ? __might_fault+0x84/0xd0
> [ 52.676183] ? __pfx_kthread+0x10/0x10
> [ 52.676197] ? __might_fault+0xbe/0xd0
> [ 52.676213] ? __might_fault+0x84/0xd0
> [ 52.676223] ret_from_fork+0x40/0x60
> [ 52.676238] ? __pfx_kthread+0x10/0x10
> [ 52.676272] ? __fget_light+0xb8/0x120
> [ 52.676273] ret_from_fork_asm+0x1b/0x30
> [ 52.676355] ksys_write+0xd0/0x170
> [ 52.676386] ? __pfx_ksys_write+0x10/0x10
> [ 52.676418] </TASK>
> [ 52.676425] irq event stamp: 591689
> [ 52.676433] hardirqs last enabled at (591688): [<ffffffffb72b7193>]
> _raw_spin_unlock_irqrestore+0x63/0x80
> [ 52.676452] hardirqs last disabled at (591689): [<ffffffffb5c242f3>]
> __call_rcu_common+0x413/0xd80
> [ 52.676467] softirqs last enabled at (591668): [<ffffffffb5af3489>]
> __local_bh_enable_ip+0x109/0x160
> [ 52.676486] softirqs last disabled at (591672): [<ffffffffb5c1ed2d>]
> rcu_do_batch+0x5ad/0xf50
> [ 52.676488] __x64_sys_write+0x47/0x60
> [ 52.676500] ---[ end trace 0000000000000000 ]---
> root@qemux86-64:~# [ 52.676526] do_syscall_64+0x47/0x90
> [ 52.676552] entry_SYSCALL_64_after_hwframe+0x6f/0xd9
> [ 52.676566] RIP: 0033:0x7ff5432260c4
> [ 52.676583] Code: 15 59 7d 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff
> eb b7 0f 1f 00 f3 0f 1e fa 80 3d 1d 0d 0e 00 00 74 13 b8 01 00 00 00
> 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 8
> [ 52.676596] RSP: 002b:00007ffcc9614998 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000001
> [ 52.676613] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff5432260c4
> [ 52.676624] RDX: 0000000000000002 RSI: 000055df1345df40 RDI: 0000000000000001
> [ 52.676634] RBP: 000055df1345df40 R08: 000055df1345b700 R09: 0000000000000000
> [ 52.676644] R10: 00000000000001b6 R11: 0000000000000202 R12: 0000000000000001
> [ 52.676653] R13: 00007ff5431326c8 R14: 00007ffcc9614a00 R15: 000055df1345b6f8
> [ 52.676789] </TASK>
> [ 52.676796] irq event stamp: 502888
> [ 52.676804] hardirqs last enabled at (502887): [<ffffffffb72b7193>]
> _raw_spin_unlock_irqrestore+0x63/0x80
> [ 52.676823] hardirqs last disabled at (502888): [<ffffffffb5c19753>]
> lazy_rcu_shrink_scan+0x1d3/0x220
> [ 52.676838] softirqs last enabled at (54708): [<ffffffffb5af3489>]
> __local_bh_enable_ip+0x109/0x160
> [ 52.676854] softirqs last disabled at (54698): [<ffffffffb6fd861a>]
> unix_release_sock+0x26a/0x7c0
> [ 52.676888] ---[ end trace 0000000000000000 ]---
> 
> Thanks
> Zqiang
> 
> 
> >  kernel/rcu/tree_nocb.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index d82f96a66600..9b618842c324 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1381,7 +1381,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >                         rcu_nocb_unlock_irqrestore(rdp, flags);
> >                         continue;
> >                 }
> > -               WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
> > +               rcu_nocb_try_flush_bypass(rdp, jiffies);
> >                 rcu_nocb_unlock_irqrestore(rdp, flags);
> >                 wake_nocb_gp(rdp, false);
> >                 sc->nr_to_scan -= _count;
> > --
> > 2.17.1
> >

