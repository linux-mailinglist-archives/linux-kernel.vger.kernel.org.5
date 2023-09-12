Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0EC79C970
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjILINo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjILINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:13:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0A610D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:13:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6430DC433C8;
        Tue, 12 Sep 2023 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694506414;
        bh=jHqmw/CsOsU8hNk9mweTs2csj+HphLKzucu7Buu5sxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzJh6b1zv9eNjzwLoDxfeKqgfhaC2zPqE2YVgwpS+EPLXhMOTYpnm8uaZb15XZGYy
         HORZ/er9UZFVIyZxqyJN7CIXpJ6teIaDntYJnBa558fKiciv79efmyZbGsLw9nFFBK
         l6E183fn0AKqvW6k2Xxj06yRLFnK7Dnn5gmye4V/uR26B1brbLIX2jqJS9HgPlJltQ
         Tn4usyNqeEnB/Bh4xnEA7cZcVeVlFKlikAyQ1gs0ldpA9hU/VwEyJ+T+OH9Lw7FoqE
         r1HNnUJXPQATydpGf2xkLlC5W15/SyeQnpuLHFLBTKbYArVN2oBzP+G+j0yUAVV3iB
         xsX9fT8xv7Rlg==
Date:   Tue, 12 Sep 2023 16:01:35 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [REGRESSION] [PATCH net-next v5 2/2] net: stmmac: use per-queue
 64 bit statistics where necessary
Message-ID: <ZQAa3277GC4c9W1D@xhacker>
References: <20230717160630.1892-1-jszhang@kernel.org>
 <20230717160630.1892-3-jszhang@kernel.org>
 <20230911171102.cwieugrpthm7ywbm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911171102.cwieugrpthm7ywbm@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 07:11:02PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> this patch became commit 133466c3bbe171f826294161db203f7670bb30c8 and is
> part of v6.6-rc1.
> 
> On my arm/stm32mp157 based machine using NFS root this commit makes the
> following appear in the kernel log:
> 
> 	INFO: trying to register non-static key.
> 	The code is fine but needs lockdep annotation, or maybe
> 	you didn't initialize this object before use?
> 	turning off the locking correctness validator.
> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc1-00449-g133466c3bbe1-dirty #21
> 	Hardware name: STM32 (Device Tree Support)
> 	 unwind_backtrace from show_stack+0x18/0x1c
> 	 show_stack from dump_stack_lvl+0x60/0x90
> 	 dump_stack_lvl from register_lock_class+0x98c/0x99c
> 	 register_lock_class from __lock_acquire+0x74/0x293c
> 	 __lock_acquire from lock_acquire+0x134/0x398
> 	 lock_acquire from stmmac_get_stats64+0x2ac/0x2fc
> 	 stmmac_get_stats64 from dev_get_stats+0x44/0x130
> 	 dev_get_stats from rtnl_fill_stats+0x38/0x120
> 	 rtnl_fill_stats from rtnl_fill_ifinfo+0x834/0x17f4
> 	 rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xc0/0x144
> 	 rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x50/0x88
> 	 rtmsg_ifinfo from __dev_notify_flags+0xc0/0xec
> 	 __dev_notify_flags from dev_change_flags+0x50/0x5c
> 	 dev_change_flags from ip_auto_config+0x2f4/0x1260
> 	 ip_auto_config from do_one_initcall+0x70/0x35c
> 	 do_one_initcall from kernel_init_freeable+0x2ac/0x308
> 	 kernel_init_freeable from kernel_init+0x1c/0x138
> 	 kernel_init from ret_from_fork+0x14/0x2c
> 	Exception stack(0xe0815fb0 to 0xe0815ff8)
> 	5fa0:                                     00000000 00000000 00000000 00000000
> 	5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 	5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 	dwc2 49000000.usb-otg: new device is high-speed
> 
> I didn't try understand this problem, it's too close to quitting time
> :-)

Thanks for the bug report, I'm checking the code.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


