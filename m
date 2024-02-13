Return-Path: <linux-kernel+bounces-63677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0708185331E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599AEB247B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA958206;
	Tue, 13 Feb 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmNP62gd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42957330;
	Tue, 13 Feb 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834550; cv=none; b=p0nSb1nATi2vKTIerHprgpGwPRrcy6fVdjXWduQk99J4Xi4PjRJeSjJ58QtR5ro02gqEHECQy9aCg8IgkcB8LBhzRig8exEga7hFFZsQ/AcGEH11pnR9u+rB+AEdKySwhLlT6lX5lH8zY9Z+dnlMi3tHzZ5IzQPY+8fsHxe6rbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834550; c=relaxed/simple;
	bh=bkxQHEEvFbJVsjwqQM0FXCG10bjF+SKVlqu1iHkdggg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DACIewhqRKQqJ75ENM8DjftCV9tebN6cCkck6Pf4B6EWi3ldRyKD+cf7s7PFuU8slbE8mIFUVvGOaFycYmK01aJrUiQKxDt+PmdXeOihEGTY4yNFQBRW1Z3WWxo8bgQ3E9VLUX5cRPZcdJdLG91vRhV664KRwpldKdgMEOKQYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmNP62gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F2CC433C7;
	Tue, 13 Feb 2024 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707834550;
	bh=bkxQHEEvFbJVsjwqQM0FXCG10bjF+SKVlqu1iHkdggg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmNP62gdX/gNhzr6q2LEJ0XLcrhwXDNa8SLDDN9hkMLKe4JcZG8+1IKae8zT1ts9R
	 pfTtF2wFF1rL3dHRXUqcEsDbTlPBGFiEjKqEzQTB1EPri1s6+wPT2UBAHuM8Eb+hCO
	 KpHOVFq5ZaW4vdmdMxfEwY5f86maAHGLlFzNq3stSzpZM2+349pPqDZrknKZl6Ktgf
	 LQemuoTfISC1nPMe6utRRe5mxVCXq3/jtPrryPt0/xhtiW3IXSdu0vFT3AfHPqjE2K
	 2LbVaD0mlvOjJ8Uu/TpiebnSmmMpD0LN5mb4dq0ns7IuCKS5xH20HJr3vk7a9pWGpa
	 Fz7QM/sET4+sQ==
Date: Tue, 13 Feb 2024 22:16:08 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Petr Tesarik <petr@tesarici.cz>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	Marc Haber <mh+netdev@zugschlus.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit statistics
 counters
Message-ID: <Zct5qJcZw0YKx54r@xhacker>
References: <20240203190927.19669-1-petr@tesarici.cz>
 <ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>

On Sun, Feb 11, 2024 at 08:30:21PM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Sat, Feb 03, 2024 at 08:09:27PM +0100, Petr Tesarik wrote:
> > As explained by a comment in <linux/u64_stats_sync.h>, write side of struct
> > u64_stats_sync must ensure mutual exclusion, or one seqcount update could
> > be lost on 32-bit platforms, thus blocking readers forever. Such lockups
> > have been observed in real world after stmmac_xmit() on one CPU raced with
> > stmmac_napi_poll_tx() on another CPU.
> > 
> > To fix the issue without introducing a new lock, split the statics into
> > three parts:
> > 
> > 1. fields updated only under the tx queue lock,
> > 2. fields updated only during NAPI poll,
> > 3. fields updated only from interrupt context,
> > 
> > Updates to fields in the first two groups are already serialized through
> > other locks. It is sufficient to split the existing struct u64_stats_sync
> > so that each group has its own.
> > 
> > Note that tx_set_ic_bit is updated from both contexts. Split this counter
> > so that each context gets its own, and calculate their sum to get the total
> > value in stmmac_get_ethtool_stats().
> > 
> > For the third group, multiple interrupts may be processed by different CPUs
> > at the same time, but interrupts on the same CPU will not nest. Move fields
> > from this group to a newly created per-cpu struct stmmac_pcpu_stats.
> > 
> > Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
> > Link: https://lore.kernel.org/netdev/Za173PhviYg-1qIn@torres.zugschlus.de/t/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> 
> This patch results in a lockdep splat. Backtrace and bisect results attached.
> 
> Guenter
> 
> ---
> [   33.736728] ================================
> [   33.736805] WARNING: inconsistent lock state
> [   33.736953] 6.8.0-rc4 #1 Tainted: G                 N
> [   33.737080] --------------------------------
> [   33.737155] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> [   33.737309] kworker/0:2/39 [HC1[1]:SC0[2]:HE0:SE0] takes:
> [   33.737459] ef792074 (&syncp->seq#2){?...}-{0:0}, at: sun8i_dwmac_dma_interrupt+0x9c/0x28c
> [   33.738206] {HARDIRQ-ON-W} state was registered at:
> [   33.738318]   lock_acquire+0x11c/0x368
> [   33.738431]   __u64_stats_update_begin+0x104/0x1ac
> [   33.738525]   stmmac_xmit+0x4d0/0xc58

interesting lockdep splat...
stmmac_xmit() operates on txq_stats->q_syncp, while the
sun8i_dwmac_dma_interrupt() operates on pcpu's priv->xstats.pcpu_stats
they are different syncp. so how does lockdep splat happen.

> [   33.738605]   dev_hard_start_xmit+0xc4/0x2a0
> [   33.738689]   sch_direct_xmit+0xf8/0x30c
> [   33.738763]   __dev_queue_xmit+0x400/0xcc4
> [   33.738831]   ip6_finish_output2+0x254/0xafc
> [   33.738903]   mld_sendpack+0x260/0x5b0
> [   33.738969]   mld_ifc_work+0x274/0x588
> [   33.739032]   process_one_work+0x230/0x604
> [   33.739101]   worker_thread+0x1dc/0x494
> [   33.739165]   kthread+0x100/0x120
> [   33.739225]   ret_from_fork+0x14/0x28
> [   33.739302] irq event stamp: 3553
> [   33.739371] hardirqs last  enabled at (3552): [<c03e884c>] __call_rcu_common.constprop.0+0x1a4/0x6b4
> [   33.739515] hardirqs last disabled at (3553): [<c0300bd4>] __irq_svc+0x54/0xb8
> [   33.739638] softirqs last  enabled at (3542): [<c1254a60>] neigh_resolve_output+0x1fc/0x254
> [   33.739795] softirqs last disabled at (3546): [<c1243798>] __dev_queue_xmit+0x48/0xcc4
> [   33.739919]
> [   33.739919] other info that might help us debug this:
> [   33.740021]  Possible unsafe locking scenario:
> [   33.740021]
> [   33.740111]        CPU0
> [   33.740158]        ----
> [   33.740204]   lock(&syncp->seq#2);
> [   33.740314]   <Interrupt>
> [   33.740363]     lock(&syncp->seq#2);
> [   33.740511]
> [   33.740511]  *** DEADLOCK ***
> [   33.740511]
> [   33.740665] 8 locks held by kworker/0:2/39:
> [   33.740761]  #0: c4bfb2a8 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_work+0x168/0x604
> [   33.741025]  #1: f0909f20 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x168/0x604
> [   33.741230]  #2: c328baac (&idev->mc_lock){+.+.}-{3:3}, at: mld_ifc_work+0x24/0x588
> [   33.741387]  #3: c2191488 (rcu_read_lock){....}-{1:2}, at: mld_sendpack+0x0/0x5b0
> [   33.741553]  #4: c2191488 (rcu_read_lock){....}-{1:2}, at: ip6_finish_output2+0x174/0xafc
> [   33.741716]  #5: c219149c (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x48/0xcc4
> [   33.741877]  #6: c4d3a974 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x334/0xcc4
> [   33.742070]  #7: c49e5050 (_xmit_ETHER#2){+...}-{2:2}, at: sch_direct_xmit+0x158/0x30c
> [   33.742250]
> [   33.742250] stack backtrace:
> [   33.742426] CPU: 0 PID: 39 Comm: kworker/0:2 Tainted: G                 N 6.8.0-rc4 #1
> [   33.742578] Hardware name: Allwinner sun8i Family
> [   33.742776] Workqueue: mld mld_ifc_work
> [   33.742998]  unwind_backtrace from show_stack+0x10/0x14
> [   33.743119]  show_stack from dump_stack_lvl+0x68/0x90
> [   33.743232]  dump_stack_lvl from mark_lock.part.0+0xbd8/0x12d8
> [   33.743345]  mark_lock.part.0 from __lock_acquire+0xad4/0x224c
> [   33.743458]  __lock_acquire from lock_acquire+0x11c/0x368
> [   33.743564]  lock_acquire from __u64_stats_update_begin+0x104/0x1ac
> [   33.743683]  __u64_stats_update_begin from sun8i_dwmac_dma_interrupt+0x9c/0x28c
> [   33.743805]  sun8i_dwmac_dma_interrupt from stmmac_napi_check+0x40/0x1c8
> [   33.743917]  stmmac_napi_check from stmmac_interrupt+0xa4/0x154
> [   33.744020]  stmmac_interrupt from __handle_irq_event_percpu+0xcc/0x2ec
> [   33.744134]  __handle_irq_event_percpu from handle_irq_event+0x38/0x80
> [   33.744243]  handle_irq_event from handle_fasteoi_irq+0x9c/0x1c4
> [   33.744346]  handle_fasteoi_irq from generic_handle_domain_irq+0x28/0x38
> [   33.744459]  generic_handle_domain_irq from gic_handle_irq+0x98/0xcc
> [   33.744567]  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
> [   33.744673]  generic_handle_arch_irq from call_with_stack+0x18/0x20
> [   33.744831]  call_with_stack from __irq_svc+0x9c/0xb8
> [   33.745018] Exception stack(0xf0909c00 to 0xf0909c48)
> [   33.745221] 9c00: f0ab0000 c49e506c 0000005a 00000000 c0000006 f0ab0014 0000005a c0f5da68
> [   33.745387] 9c20: c35bd810 c4b50000 c4b50000 c365d300 00000000 f0909c50 c0f70a70 c0f70a74
> [   33.745574] 9c40: 60000013 ffffffff
> [   33.745668]  __irq_svc from sun8i_dwmac_enable_dma_transmission+0x20/0x24
> [   33.745809]  sun8i_dwmac_enable_dma_transmission from stmmac_xmit+0x790/0xc58
> [   33.745975]  stmmac_xmit from dev_hard_start_xmit+0xc4/0x2a0
> [   33.746100]  dev_hard_start_xmit from sch_direct_xmit+0xf8/0x30c
> [   33.746220]  sch_direct_xmit from __dev_queue_xmit+0x400/0xcc4
> [   33.746350]  __dev_queue_xmit from ip6_finish_output2+0x254/0xafc
> [   33.746462]  ip6_finish_output2 from mld_sendpack+0x260/0x5b0
> [   33.746568]  mld_sendpack from mld_ifc_work+0x274/0x588
> [   33.746670]  mld_ifc_work from process_one_work+0x230/0x604
> [   33.746793]  process_one_work from worker_thread+0x1dc/0x494
> [   33.746906]  worker_thread from kthread+0x100/0x120
> [   33.746994]  kthread from ret_from_fork+0x14/0x28
> [   33.747076] Exception stack(0xf0909fb0 to 0xf0909ff8)
> [   33.747165] 9fa0:                                     00000000 00000000 00000000 00000000
> [   33.747303] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [   33.747433] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> ---
> # bad: [841c35169323cd833294798e58b9bf63fa4fa1de] Linux 6.8-rc4
> # good: [54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478] Linux 6.8-rc3
> git bisect start 'HEAD' 'v6.8-rc3'
> # bad: [c76b766ec50d3d43e2dacea53a733b285f4b730d] Merge tag 'drm-fixes-2024-02-09' of git://anongit.freedesktop.org/drm/drm
> git bisect bad c76b766ec50d3d43e2dacea53a733b285f4b730d
> # bad: [63e4b9d693e0f8c28359c7ea81e1ee510864c37b] Merge tag 'nf-24-02-08' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
> git bisect bad 63e4b9d693e0f8c28359c7ea81e1ee510864c37b
> # bad: [75428f537d7cae33c7e4dd726144074f78622c09] net: intel: fix old compiler regressions
> git bisect bad 75428f537d7cae33c7e4dd726144074f78622c09
> # good: [1a1c13303ff6d64e6f718dc8aa614e580ca8d9b4] nfp: flower: prevent re-adding mac index for bonded port
> git bisect good 1a1c13303ff6d64e6f718dc8aa614e580ca8d9b4
> # good: [3871aa01e1a779d866fa9dfdd5a836f342f4eb87] tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()
> git bisect good 3871aa01e1a779d866fa9dfdd5a836f342f4eb87
> # good: [58086721b7781c3e35b19c9b78c8f5a791070ba3] devlink: avoid potential loop in devlink_rel_nested_in_notify_work()
> git bisect good 58086721b7781c3e35b19c9b78c8f5a791070ba3
> # bad: [38cc3c6dcc09dc3a1800b5ec22aef643ca11eab8] net: stmmac: protect updates of 64-bit statistics counters
> git bisect bad 38cc3c6dcc09dc3a1800b5ec22aef643ca11eab8
> # good: [cb88cb53badb8aeb3955ad6ce80b07b598e310b8] ppp_async: limit MRU to 64K
> git bisect good cb88cb53badb8aeb3955ad6ce80b07b598e310b8
> # first bad commit: [38cc3c6dcc09dc3a1800b5ec22aef643ca11eab8] net: stmmac: protect updates of 64-bit statistics counters

