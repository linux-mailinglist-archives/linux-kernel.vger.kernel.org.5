Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2079CB42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjILJOZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 05:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjILJOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:14:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B61726
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:06:48 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1qfzM4-0001U4-6D; Tue, 12 Sep 2023 11:06:46 +0200
Message-ID: <99695befef06b025de2c457ea5f861aa81a0883c.camel@pengutronix.de>
Subject: Re: [REGRESSION] [PATCH net-next v5 2/2] net: stmmac: use per-queue
 64 bit statistics where necessary
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Eric Dumazet <edumazet@google.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-sunxi@lists.linux.dev,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 12 Sep 2023 11:04:16 +0200
In-Reply-To: <ZQAa3277GC4c9W1D@xhacker>
References: <20230717160630.1892-1-jszhang@kernel.org>
         <20230717160630.1892-3-jszhang@kernel.org>
         <20230911171102.cwieugrpthm7ywbm@pengutronix.de> <ZQAa3277GC4c9W1D@xhacker>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 12.09.2023 um 16:01 +0800 schrieb Jisheng Zhang:
> On Mon, Sep 11, 2023 at 07:11:02PM +0200, Uwe Kleine-König wrote:
> > Hello,
> > 
> > this patch became commit 133466c3bbe171f826294161db203f7670bb30c8 and is
> > part of v6.6-rc1.
> > 
> > On my arm/stm32mp157 based machine using NFS root this commit makes the
> > following appear in the kernel log:
> > 
> > 	INFO: trying to register non-static key.
> > 	The code is fine but needs lockdep annotation, or maybe
> > 	you didn't initialize this object before use?
> > 	turning off the locking correctness validator.
> > 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc1-00449-g133466c3bbe1-dirty #21
> > 	Hardware name: STM32 (Device Tree Support)
> > 	 unwind_backtrace from show_stack+0x18/0x1c
> > 	 show_stack from dump_stack_lvl+0x60/0x90
> > 	 dump_stack_lvl from register_lock_class+0x98c/0x99c
> > 	 register_lock_class from __lock_acquire+0x74/0x293c
> > 	 __lock_acquire from lock_acquire+0x134/0x398
> > 	 lock_acquire from stmmac_get_stats64+0x2ac/0x2fc
> > 	 stmmac_get_stats64 from dev_get_stats+0x44/0x130
> > 	 dev_get_stats from rtnl_fill_stats+0x38/0x120
> > 	 rtnl_fill_stats from rtnl_fill_ifinfo+0x834/0x17f4
> > 	 rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xc0/0x144
> > 	 rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x50/0x88
> > 	 rtmsg_ifinfo from __dev_notify_flags+0xc0/0xec
> > 	 __dev_notify_flags from dev_change_flags+0x50/0x5c
> > 	 dev_change_flags from ip_auto_config+0x2f4/0x1260
> > 	 ip_auto_config from do_one_initcall+0x70/0x35c
> > 	 do_one_initcall from kernel_init_freeable+0x2ac/0x308
> > 	 kernel_init_freeable from kernel_init+0x1c/0x138
> > 	 kernel_init from ret_from_fork+0x14/0x2c
> > 	Exception stack(0xe0815fb0 to 0xe0815ff8)
> > 	5fa0:                                     00000000 00000000 00000000 00000000
> > 	5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 	5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > 	dwc2 49000000.usb-otg: new device is high-speed
> > 
> > I didn't try understand this problem, it's too close to quitting time
> > :-)
> 
> Thanks for the bug report, I'm checking the code.

The newly added "struct u64_stats_sync syncp" uses a seqlock
internally, which is broken into multiple words on 32bit machines, and
needs to be initialized properly. You need to call u64_stats_init on
syncp before first usage.

Regards,
Lucas

> > 
> > Best regards
> > Uwe
> > 
> > -- 
> > Pengutronix e.K.                           | Uwe Kleine-König            |
> > Industrial Linux Solutions                 | https://www.pengutronix.de/ |
> 
> 
> 

