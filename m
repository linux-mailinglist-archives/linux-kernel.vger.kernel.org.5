Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85279CBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjILJae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjILJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:30:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE18AA;
        Tue, 12 Sep 2023 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=66b1dQizWW+fC+qmJ4SM+GQt1e88uQ9iq/5zT3+gwsg=;
        t=1694511029; x=1695720629; b=VoDvG1EvU00rHRt+YnhGzMFmb2Y11gXcqsejiqev8loU+dv
        nLr2b94EH9jKDpEbXKBwsafqRKDFLbBsxbKo3HvlXsB7dv9jeUUeygnnQfWeDywO0xCedoLh6wIxw
        CWYdNy4Ctq9v3Xmidi44qke8GDWK9OD+2TQBog+nUkEDxmFfZaE3CRi+rB3i4DNnXYSonz7Zn78YT
        DoVoBnmVNxTW7uKV4fC38Vd3TbDqJXEdrlA33SBf+0D1dhM6XOb7ikxUrnxQBNbvFzBDw3a3b2hMK
        Ldo0FSMvfUQOa/SeFn9ocUIFl30vYF/EvhgnbwaksfVWQ+RlTCWqVAZMCBeRq0zw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qfzit-00CWw1-1f;
        Tue, 12 Sep 2023 11:30:19 +0200
Message-ID: <2fcc9fb0e40ceff8ea4ae55cca3ce0aff75a20ca.camel@sipsolutions.net>
Subject: Re: [REGRESSION] [PATCH net-next v5 2/2] net: stmmac: use per-queue
 64 bit statistics where necessary
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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
Date:   Tue, 12 Sep 2023 11:30:14 +0200
In-Reply-To: <20230912092411.pprnpvrbxwz77x6a@pengutronix.de>
References: <20230717160630.1892-1-jszhang@kernel.org>
         <20230717160630.1892-3-jszhang@kernel.org>
         <20230911171102.cwieugrpthm7ywbm@pengutronix.de> <ZQAa3277GC4c9W1D@xhacker>
         <99695befef06b025de2c457ea5f861aa81a0883c.camel@pengutronix.de>
         <20230912092411.pprnpvrbxwz77x6a@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-12 at 11:24 +0200, Uwe Kleine-K=C3=B6nig wrote:
> >=20
> > The newly added "struct u64_stats_sync syncp" uses a seqlock
> > internally, which is broken into multiple words on 32bit machines, and
> > needs to be initialized properly. You need to call u64_stats_init on
> > syncp before first usage.
>=20
> This is done. The problematic thing is that in stmmac_open() ->
> __stmmac_open() the syncp initialized before is overwritten by
>=20
> 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
>=20
> Do I need to point out that this is ugly?

I think it also leaks the (lockdep) state since it reinits the syncp
(and a lot of other state) doing this. This is also called when the MTU
changes.

Also, I couldn't convince myself that it's even race-free? Even if it
is, it's not really obvious, IMHO.

So it seems to me that really this needs to be split into data that
actually should be reinitialized, and data that shouldn't, or just not
use memcpy() here but copy only the relevant state?

But anyway, I have no skin in this game - just reviewing this because I
was trying to help out Uwe.

johannes
