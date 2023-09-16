Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7530C7A3136
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbjIPPsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIPPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:47:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FDCCE3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 08:47:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6142C433C8;
        Sat, 16 Sep 2023 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694879263;
        bh=9yoeSuSu4c9avKuB9jsu8jsIQJYt6cBB3MWv0m0Z7y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qe8Sc6HLO2iQZ9PjqYe1yCCRQ1tpnCuR3MCfNQEU9aSMLnwJM9Hhl0/bONQXIPfd5
         WmLJsJ/tiCNRjsOKIFJrc2i9jLeX7G5SS1WMXuDoyRed0jMGkLFprFwDmwk4uSNBo5
         z6ceK18Ahw1+EMw+kgrsL+y+BNFk92hEn94HOTDhhQuHSpCT7W4z6fjg14rH6BVQ86
         yY2MiMDmDCOpc183NEO2j4DrbMiLlKzbh1njf4KTt+Ghvfo1kClALhuvrvFFubX7Gy
         8BQRvSt3QIWMEg4BoyZh+DRbmRrMUX95NQa6vByR7Blu7bKb6cIEV6V/g44xjWsCfk
         WKOnp3JIalObg==
Date:   Sat, 16 Sep 2023 17:47:37 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com,
        johannes@sipsolutions.net,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] net: stmmac: fix incorrect rxq|txq_stats reference
Message-ID: <20230916154737.GG1125562@kernel.org>
References: <20230915005316.592-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230915005316.592-1-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:53:16AM +0800, Jisheng Zhang wrote:
> commit 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics
> where necessary") caused one regression as found by Uwe, the backtrace
> looks like:
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc1-00449-g133466c3bbe1-dirty #21
> Hardware name: STM32 (Device Tree Support)
>  unwind_backtrace from show_stack+0x18/0x1c
>  show_stack from dump_stack_lvl+0x60/0x90
>  dump_stack_lvl from register_lock_class+0x98c/0x99c
>  register_lock_class from __lock_acquire+0x74/0x293c
>  __lock_acquire from lock_acquire+0x134/0x398
>  lock_acquire from stmmac_get_stats64+0x2ac/0x2fc
>  stmmac_get_stats64 from dev_get_stats+0x44/0x130
>  dev_get_stats from rtnl_fill_stats+0x38/0x120
>  rtnl_fill_stats from rtnl_fill_ifinfo+0x834/0x17f4
>  rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xc0/0x144
>  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x50/0x88
>  rtmsg_ifinfo from __dev_notify_flags+0xc0/0xec
>  __dev_notify_flags from dev_change_flags+0x50/0x5c
>  dev_change_flags from ip_auto_config+0x2f4/0x1260
>  ip_auto_config from do_one_initcall+0x70/0x35c
>  do_one_initcall from kernel_init_freeable+0x2ac/0x308
>  kernel_init_freeable from kernel_init+0x1c/0x138
>  kernel_init from ret_from_fork+0x14/0x2c
> 
> The reason is the rxq|txq_stats structures are not what expected
> because stmmac_open() -> __stmmac_open() the structure is overwritten
> by "memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));"
> This causes the well initialized syncp member of rxq|txq_stats is
> overwritten unexpectedly as pointed out by Johannes and Uwe.
> 
> Fix this issue by moving rxq|txq_stats back to stmmac_extra_stats. For
> SMP cache friendly, we also mark stmmac_txq_stats and stmmac_rxq_stats
> as ____cacheline_aligned_in_smp.
> 
> Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Hi Jisheng Zhang,

as a fix for Networking code this should be based targeted at the net tree.

  Subject: [PATCH net] ...

Unfortunately it doesn't apply cleanly against net.
Please consider rebasing and reposting.

-- 
pw-bot: changes-requested
