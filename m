Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11BA79EB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbjIMOqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbjIMOqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:46:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC398
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:46:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE9FC433C8;
        Wed, 13 Sep 2023 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694616406;
        bh=MEPRVLhq94lkOpBYdxRoPzKxMTXOzT6mLYuQo0C5GYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGLkwU9FWN+uir2AxMWDTeonZoJko3bsyCrAoEwRogRsrKE3tdrx4B9pi8+bKr/rN
         YNmj1snrt3z/3uMq8t3XLwRcIdtFeEX4usIBazutl44jkrrsnbzmUi+o/KlszxGhTW
         kQ/3EbY9WMqXrWE+yQ0jghLPZaWW+prreEFa455H+PLcHo/nLRU9nYtgaZo3JnKrPj
         vFqlFKnCj6MRw+R8ApLZnFn10v9011Amq+LnEVzCYWDd8jZUbGtwzr5m5NpxvdL84/
         3VKpgZuZL8GyrJ1R2wgmk36jUw1EttiwIhx9Ix80TmVPWYzmiShvDIdhGPcyxDKqwd
         tx3968REAuSrA==
Date:   Wed, 13 Sep 2023 22:34:42 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jose Abreu <joabreu@synopsys.com>, kernel@pengutronix.de,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-sunxi@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [REGRESSION] [PATCH net-next v5 2/2] net: stmmac: use per-queue
 64 bit statistics where necessary
Message-ID: <ZQHIgmcnCNoZwtwu@xhacker>
References: <20230717160630.1892-1-jszhang@kernel.org>
 <20230717160630.1892-3-jszhang@kernel.org>
 <20230911171102.cwieugrpthm7ywbm@pengutronix.de>
 <ZQAa3277GC4c9W1D@xhacker>
 <99695befef06b025de2c457ea5f861aa81a0883c.camel@pengutronix.de>
 <20230912092411.pprnpvrbxwz77x6a@pengutronix.de>
 <2fcc9fb0e40ceff8ea4ae55cca3ce0aff75a20ca.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fcc9fb0e40ceff8ea4ae55cca3ce0aff75a20ca.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:30:14AM +0200, Johannes Berg wrote:
> On Tue, 2023-09-12 at 11:24 +0200, Uwe Kleine-König wrote:
> > > 
> > > The newly added "struct u64_stats_sync syncp" uses a seqlock
> > > internally, which is broken into multiple words on 32bit machines, and
> > > needs to be initialized properly. You need to call u64_stats_init on
> > > syncp before first usage.
> > 
> > This is done. The problematic thing is that in stmmac_open() ->
> > __stmmac_open() the syncp initialized before is overwritten by
> > 
> > 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));

Thank Johannes and Uwe for pointing out the issue.

> > 
> > Do I need to point out that this is ugly?
> 
> I think it also leaks the (lockdep) state since it reinits the syncp
> (and a lot of other state) doing this. This is also called when the MTU
> changes.
> 
> Also, I couldn't convince myself that it's even race-free? Even if it
> is, it's not really obvious, IMHO.
> 
> So it seems to me that really this needs to be split into data that
> actually should be reinitialized, and data that shouldn't, or just not
> use memcpy() here but copy only the relevant state?

Since we are in rc1, I need to fix the bug with as small changes as
possible. so another solution could be: replace rx/tx stats structure
with pointers, then setup pointers in the new allocated dma_conf with
the old one as current code did for dma_tx_size/dma_rx_size in
stmmac_setup_dma_desc():

dma_conf->dma_tx_size = priv->dma_conf.dma_tx_size

Is it acceptable?

Thanks

> 
> But anyway, I have no skin in this game - just reviewing this because I
> was trying to help out Uwe.
> 
> johannes
