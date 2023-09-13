Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8466C79EB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjIMOt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbjIMOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:49:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB16AB;
        Wed, 13 Sep 2023 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AKHZcby/SaXTGDFhOnska1CWWaoisj9GGC+K/yEWJ4Q=;
        t=1694616591; x=1695826191; b=kwDyAT00bHSpRwewzqF3UYKycN+H9le5OeUr0GJjzwXGNAU
        h6KBg/sh3ykqTeoF4NjxkEyCWwSpJM0OnavJ6wEaaBzcHJmCt8uaV9kVu/lqxIKJzLV3TPQuS0+Ha
        Llbc+X9sez0cSwhJb8Hm123z101sGgBtaDVXXxdUk5UZgM6lVQ6YDqOlFB/rCFmB6SMu1AhTn1sNU
        sHpW/KkYrBG3odYYgFXs3mD/fh7mOyMtRrj9CnvrtWDG8wpMOTe+j8LPBeK/NWR8yk6QoqJdXZjSg
        JgAjzXEUSYLZd+Ax56U7DW+F+SFC31a+pCQe8vZTU0Rbb0shfX59Vrbw1/FUnaPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qgRBU-00F30o-2d;
        Wed, 13 Sep 2023 16:49:41 +0200
Message-ID: <27579950c5a5f9221e7b52524cbc8de97d8b90e0.camel@sipsolutions.net>
Subject: Re: [REGRESSION] [PATCH net-next v5 2/2] net: stmmac: use per-queue
 64 bit statistics where necessary
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
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
Date:   Wed, 13 Sep 2023 16:49:39 +0200
In-Reply-To: <ZQHIgmcnCNoZwtwu@xhacker>
References: <20230717160630.1892-1-jszhang@kernel.org>
         <20230717160630.1892-3-jszhang@kernel.org>
         <20230911171102.cwieugrpthm7ywbm@pengutronix.de> <ZQAa3277GC4c9W1D@xhacker>
         <99695befef06b025de2c457ea5f861aa81a0883c.camel@pengutronix.de>
         <20230912092411.pprnpvrbxwz77x6a@pengutronix.de>
         <2fcc9fb0e40ceff8ea4ae55cca3ce0aff75a20ca.camel@sipsolutions.net>
         <ZQHIgmcnCNoZwtwu@xhacker>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 22:34 +0800, Jisheng Zhang wrote:
>=20
> Since we are in rc1, I need to fix the bug with as small changes as
> possible. so another solution could be: replace rx/tx stats structure
> with pointers, then setup pointers in the new allocated dma_conf with
> the old one as current code did for dma_tx_size/dma_rx_size in
> stmmac_setup_dma_desc():
>=20
> dma_conf->dma_tx_size =3D priv->dma_conf.dma_tx_size
>=20
> Is it acceptable?

I'm not sure who you're asking of all the people in this thread, but I
honestly don't understand much about this driver other than what I
gleaned in the few minutes looking at it with Uwe ... so I don't think
I'm able to answer that question :)


You could also just move the stats out of the structure entirely, I
guess? And perhaps even start some new structure where more things might
move in the future that shouldn't be reallocated?

I'm all for not moving things now that haven't caused problems, but I
guess doing a minimal fix just for the sake of being minimal in -rc1
wouldn't be my preference.

johannes
