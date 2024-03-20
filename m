Return-Path: <linux-kernel+bounces-108853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FAB8810EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C40828597D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D3C3D964;
	Wed, 20 Mar 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8u1z5T4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F223F9DB;
	Wed, 20 Mar 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934061; cv=none; b=o+0MyPqP7cHmrN9uKn73PjbmyrCnPIYk9IDJJvclevwaP9bB7e0HksVpOalX8PYoHyu7Xokw0j5ZKV3qKONE+ao85oEAgUAC64DT2PVNWZwTHtYbTh4Rmp3q5xNxxrUhXmKJKWKKSQ9RydJDz7YaMMkflx913BPqv4bEHu6ZjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934061; c=relaxed/simple;
	bh=24h+MIfRY/KsaZFqjkYbnXHK6NrsHnvsqtBEUv2IzR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWwcWKAWdIPm4djAgW+A6mIi97zVod4x++XkcpuS5DRy5WCRBotS26pRY/vDqeF8KdzfMTeFwr1eDejg44YgxVV76PWvVsjV0cBGyU0TQYI2E+HgDh7lO5c1HIXx+hzwogzgsr6HBd2HUzRIITLbj2gcEuPXqurxbE7DPeev/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8u1z5T4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A3BC433C7;
	Wed, 20 Mar 2024 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934060;
	bh=24h+MIfRY/KsaZFqjkYbnXHK6NrsHnvsqtBEUv2IzR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8u1z5T4tyBpScEFUmqxszQfQEJ5iZSPZaxB8EXkpPICI/K1U6tjR12dTcWDZVK8f
	 a8+spv41/QIroiwe7Zy8tfwBosBvMm4Vz/ffckO56Na0Ao9weL7eNYOZNXdbZh0non
	 iubLEAKD1rQwEXyjFeIPDNzZ45RIleGIWq24ENqTZSH83jr6r3VGdXAz2S6NsH8bL/
	 XcB2Qbv9ZDQgYkZ6yt8ob0fw1r7JuxFOhSn/A+oXEuksWgszwPz8wluTuGRz+bInZL
	 hlbEd1PmBrL7GFnJj6XRHHqIhVKcVbfhfIxdfK/kqqCLYdH3N51bdlMNMpd6HMXR+Q
	 nJHhYbmmqDHbw==
Date: Wed, 20 Mar 2024 11:27:36 +0000
From: Simon Horman <horms@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, u.kleine-koenig@pengutronix.de, leon@kernel.org,
	asmaa@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] mlxbf_gige: call request_irq() after NAPI
 initialized
Message-ID: <20240320112736.GS185808@kernel.org>
References: <20240319181732.12878-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319181732.12878-1-davthompson@nvidia.com>

On Tue, Mar 19, 2024 at 02:17:32PM -0400, David Thompson wrote:
> The mlxbf_gige driver encounters a NULL pointer exception in
> mlxbf_gige_open() when kdump is enabled.  The sequence to reproduce
> the exception is as follows:
> a) enable kdump
> b) trigger kdump via "echo c > /proc/sysrq-trigger"
> c) kdump kernel executes
> d) kdump kernel loads mlxbf_gige module
> e) the mlxbf_gige module runs its open() as the
>    the "oob_net0" interface is brought up
> f) mlxbf_gige module will experience an exception
>    during its open(), something like:
> 
>      Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>      Mem abort info:
>        ESR = 0x0000000086000004
>        EC = 0x21: IABT (current EL), IL = 32 bits
>        SET = 0, FnV = 0
>        EA = 0, S1PTW = 0
>        FSC = 0x04: level 0 translation fault
>      user pgtable: 4k pages, 48-bit VAs, pgdp=00000000e29a4000
>      [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>      Internal error: Oops: 0000000086000004 [#1] SMP
>      CPU: 0 PID: 812 Comm: NetworkManager Tainted: G           OE     5.15.0-1035-bluefield #37-Ubuntu
>      Hardware name: https://www.mellanox.com BlueField-3 SmartNIC Main Card/BlueField-3 SmartNIC Main Card, BIOS 4.6.0.13024 Jan 19 2024
>      pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>      pc : 0x0
>      lr : __napi_poll+0x40/0x230
>      sp : ffff800008003e00
>      x29: ffff800008003e00 x28: 0000000000000000 x27: 00000000ffffffff
>      x26: ffff000066027238 x25: ffff00007cedec00 x24: ffff800008003ec8
>      x23: 000000000000012c x22: ffff800008003eb7 x21: 0000000000000000
>      x20: 0000000000000001 x19: ffff000066027238 x18: 0000000000000000
>      x17: ffff578fcb450000 x16: ffffa870b083c7c0 x15: 0000aaab010441d0
>      x14: 0000000000000001 x13: 00726f7272655f65 x12: 6769675f6662786c
>      x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa870b0842398
>      x8 : 0000000000000004 x7 : fe5a48b9069706ea x6 : 17fdb11fc84ae0d2
>      x5 : d94a82549d594f35 x4 : 0000000000000000 x3 : 0000000000400100
>      x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000066027238
>      Call trace:
>       0x0
>       net_rx_action+0x178/0x360
>       __do_softirq+0x15c/0x428
>       __irq_exit_rcu+0xac/0xec
>       irq_exit+0x18/0x2c
>       handle_domain_irq+0x6c/0xa0
>       gic_handle_irq+0xec/0x1b0
>       call_on_irq_stack+0x20/0x2c
>       do_interrupt_handler+0x5c/0x70
>       el1_interrupt+0x30/0x50
>       el1h_64_irq_handler+0x18/0x2c
>       el1h_64_irq+0x7c/0x80
>       __setup_irq+0x4c0/0x950
>       request_threaded_irq+0xf4/0x1bc
>       mlxbf_gige_request_irqs+0x68/0x110 [mlxbf_gige]
>       mlxbf_gige_open+0x5c/0x170 [mlxbf_gige]
>       __dev_open+0x100/0x220
>       __dev_change_flags+0x16c/0x1f0
>       dev_change_flags+0x2c/0x70
>       do_setlink+0x220/0xa40
>       __rtnl_newlink+0x56c/0x8a0
>       rtnl_newlink+0x58/0x84
>       rtnetlink_rcv_msg+0x138/0x3c4
>       netlink_rcv_skb+0x64/0x130
>       rtnetlink_rcv+0x20/0x30
>       netlink_unicast+0x2ec/0x360
>       netlink_sendmsg+0x278/0x490
>       __sock_sendmsg+0x5c/0x6c
>       ____sys_sendmsg+0x290/0x2d4
>       ___sys_sendmsg+0x84/0xd0
>       __sys_sendmsg+0x70/0xd0
>       __arm64_sys_sendmsg+0x2c/0x40
>       invoke_syscall+0x78/0x100
>       el0_svc_common.constprop.0+0x54/0x184
>       do_el0_svc+0x30/0xac
>       el0_svc+0x48/0x160
>       el0t_64_sync_handler+0xa4/0x12c
>       el0t_64_sync+0x1a4/0x1a8
>      Code: bad PC value
>      ---[ end trace 7d1c3f3bf9d81885 ]---
>      Kernel panic - not syncing: Oops: Fatal exception in interrupt
>      Kernel Offset: 0x2870a7a00000 from 0xffff800008000000
>      PHYS_OFFSET: 0x80000000
>      CPU features: 0x0,000005c1,a3332a5a
>      Memory Limit: none
>      ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
> 
> The exception happens because there is a pending RX interrupt before the
> call to request_irq(RX IRQ) executes.  Then, the RX IRQ handler fires
> immediately after this request_irq() completes. The RX IRQ handler runs
> "napi_schedule()" before NAPI is fully initialized via "netif_napi_add()"
> and "napi_enable()", both which happen later in the open() logic.
> 
> The logic in mlxbf_gige_open() has been re-ordered so that the
> request_irq() calls execute after NAPI is fully initialized.
> 
> Also, the logic in mlxbf_gige_open() was missing a call to phy_stop()
> in the error path, so that has been added.
> 
> Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
> v2
> - re-worded commit message and subject for clarity
> - updated commit message to mention that phy_stop() was added
>   to the error path in mlxbf_gige_open()

Thanks,

this patch looks good to me and appears to addresses the review provided by
others of v1.

Reviewed-by: Simon Horman <horms@kernel.org>


