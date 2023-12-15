Return-Path: <linux-kernel+bounces-1325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D243814D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280D81F24A96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE893EA6F;
	Fri, 15 Dec 2023 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Pu1eDoGc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3333DBAE;
	Fri, 15 Dec 2023 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GkrSkZ4cg3Fb4+AcZws22YYhtObtizpPpGeGf6TSkHs=; b=Pu1eDoGcEGpANRPpsmLpyEamso
	s2uEZTH6ZIA87YxFlXP3/1hlKbfaQOK86OvbLxv7RDvhVP+QOYOw9tMQTNGnG6voSYUtxaxKp+J+P
	EPV/OAu3BGRAMWubs9CqHtRZoWKJH01DCLeaSWSJHOqpg9H81If8KAbDOtu5DSsFVJke73HSJ1Ghn
	1EMRriiQ0N1bd4DGY4ZaXSn0H5fVuxLd7S6q357jOq0fiaNItRgSI4sIh8JOzXwmmOjqTiEDto/qC
	retP5mgATikU6kuY7wrVEtxmm8sQRDOqxTG7k+XW1H8gcFegYVbqW5ApPufxLGuGgNKsWhwbNvkAX
	Nd/NqNlw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46006)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rEBJ9-0002v6-1N;
	Fri, 15 Dec 2023 16:45:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rEBJ7-0003mZ-3R; Fri, 15 Dec 2023 16:45:01 +0000
Date: Fri, 15 Dec 2023 16:45:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: skip LED triggers on PHYs on SFP modules
Message-ID: <ZXyCjfW79jPqd1G6@shell.armlinux.org.uk>
References: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102a9dce38bdf00215735d04cd4704458273ad9c.1702339354.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 12, 2023 at 12:05:35AM +0000, Daniel Golle wrote:
> -> #3 (&sfp->sm_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x88/0x7a0
>        mutex_lock_nested+0x20/0x28
>        cleanup_module+0x2ae0/0x3120 [sfp]
>        sfp_register_bus+0x5c/0x9c
>        sfp_register_socket+0x48/0xd4
>        cleanup_module+0x271c/0x3120 [sfp]
>        platform_probe+0x64/0xb8
>        really_probe+0x17c/0x3c0
>        __driver_probe_device+0x78/0x164
>        driver_probe_device+0x3c/0xd4
>        __driver_attach+0xec/0x1f0
>        bus_for_each_dev+0x60/0xa0
>        driver_attach+0x20/0x28
>        bus_add_driver+0x108/0x208
>        driver_register+0x5c/0x118
>        __platform_driver_register+0x24/0x2c
>        init_module+0x28/0xa7c [sfp]
>        do_one_initcall+0x70/0x2ec
>        do_init_module+0x54/0x1e4
>        load_module+0x1b78/0x1c8c
>        __do_sys_init_module+0x1bc/0x2cc
>        __arm64_sys_init_module+0x18/0x20
>        invoke_syscall.constprop.0+0x4c/0xdc
>        do_el0_svc+0x3c/0xbc
>        el0_svc+0x34/0x80
>        el0t_64_sync_handler+0xf8/0x124
>        el0t_64_sync+0x150/0x154

I suspect these backtraces aren't all that reliable, and look like they
are generated by walking through the stack and logging anything that
seems to be pointing into the text segment, which is rubbish for ARM32
and probably ARM64 as well.

We can see that this backtrace is a pile of lies because there is _no_
_way_ that sfp's cleanup_module() could ever be called while its
init_module() function is running.

In any case, I think this path is irrelevant.

> -> #2 (rtnl_mutex){+.+.}-{3:3}:
>        __mutex_lock+0x88/0x7a0
>        mutex_lock_nested+0x20/0x28
>        rtnl_lock+0x18/0x20
>        set_device_name+0x30/0x130
>        netdev_trig_activate+0x13c/0x1ac
>        led_trigger_set+0x118/0x234
>        led_trigger_write+0x104/0x17c
>        sysfs_kf_bin_write+0x64/0x80
>        kernfs_fop_write_iter+0x128/0x1b4
>        vfs_write+0x178/0x2a4
>        ksys_write+0x58/0xd4
>        __arm64_sys_write+0x18/0x20
>        invoke_syscall.constprop.0+0x4c/0xdc
>        do_el0_svc+0x3c/0xbc
>        el0_svc+0x34/0x80
>        el0t_64_sync_handler+0xf8/0x124
>        el0t_64_sync+0x150/0x154

This is one of the paths that matters. A userspace write is occuring
to the netdev trigger module. This path takes the following locks
(most recent first):

	rtnl_lock()
	trigger_lock (write)
	triggers_list_lock (read)

> -> #0 (triggers_list_lock){++++}-{3:3}:
>        __lock_acquire+0x12a0/0x2014
>        lock_acquire+0x100/0x2ac
>        down_write+0x4c/0x13c
>        led_trigger_register+0x4c/0x1a8
>        phy_led_triggers_register+0x9c/0x214
>        phy_attach_direct+0x154/0x36c
>        phylink_attach_phy+0x30/0x60
>        phylink_sfp_connect_phy+0x140/0x510
>        sfp_add_phy+0x34/0x50
>        init_module+0x15c/0xa7c [sfp]
>        cleanup_module+0x1d94/0x3120 [sfp]
>        cleanup_module+0x2bb4/0x3120 [sfp]
>        process_one_work+0x1f8/0x4ec
>        worker_thread+0x1e8/0x3d8
>        kthread+0x104/0x110
>        ret_from_fork+0x10/0x20

This path I suspect (but hard to see, we've got that cleanup_module
and init_module crud there again which is utter trash, sfp_add_phy
is not called from any of the functions previously listed)...
Manually going through the code instead, the locking order will be:

	triggers_list_lock (write)
	sm_mutex
	rtnl

I'm not sure that the lockdep report is accurate, as it seems to be
blaming the deadlock via three locks (triggers_list_lock --> rtnl_mutex
--> &sfp->sm_mutex) but I can't find a path where sm_mutex would be
involved (except the immediate above.)

It looks to me like the problem is in part caused by calling
phy_led_triggers_register() while holding the rtnl lock. Holding the
rtnl lock is fundamental to being able to safely remove and add PHY
devices to netdevs while they are up and running.

The other part that causes the problem is a write to a netdev trigger
that causes it to activate takes the rtnl and triggers_list_lock in
the opposite order.

I don't currently see a solution to this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

