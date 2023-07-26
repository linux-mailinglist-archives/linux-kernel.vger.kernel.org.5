Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C8B7635AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGZLyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjGZLyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:54:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F061188;
        Wed, 26 Jul 2023 04:54:42 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qOd63-0005Ck-Pc; Wed, 26 Jul 2023 13:54:27 +0200
Date:   Wed, 26 Jul 2023 13:54:27 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Alexey Romanov <AVRomanov@sberdevices.ru>
Cc:     "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "olivia@selenic.com" <olivia@selenic.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/3] drivers: rng: add check status bit feature
Message-ID: <20230726115427.aigzl2wjgc6ccyt6@viti.kaiser.cx>
References: <20230725141252.98848-1-avromanov@sberdevices.ru>
 <20230725141252.98848-2-avromanov@sberdevices.ru>
 <20230725195901.n2klvgz7outqaatk@viti.kaiser.cx>
 <20230726075243.f37sjcurmog3eunh@cab-wsm-0029881>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726075243.f37sjcurmog3eunh@cab-wsm-0029881>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

Alexey Romanov (AVRomanov@sberdevices.ru) wrote:

> > > +static int meson_rng_wait_status(void __iomem *cfg_addr, int bit)
> > > +{
> > > +	u32 status;
> > > +	u32 cnt = 0;
> > > +
> > > +	do {
> > > +		status = readl_relaxed(cfg_addr) & BIT(bit);
> > > +		cpu_relax();
> > > +	} while (status && (cnt++ < RETRY_CNT));
> > > +

> > Could you use readl_relaxed_poll_timeout here instead of open coding the
> > loop?

> At first I also thought about this API. But later I came to the
> conclusion that it is inappropriate here:

> 1. We can't call rng_read from an atomic context.

Agreed. A hwrng read function may sleep (an example for this is
exynos_trng_do_read). But this doesn't prevent us from using
readl_relaxed_poll_timeout.

> 2. RNG for me looks like a very lightweight primitive to me that 
> should work quiclky.

> But, now I looked again at the API and realized that we can use
> readl_relaxed_poll_timeout_atomic() instead of
> readl_relaxed_poll_timeout(). What do you think?

Ok, if you know that your rng hardware won't need much time to set the
bit that you're checking, you may use readl_relaxed_poll_timeout_atomic.

stm32_rtc_set_alarm does something similar.

Best regards,
Martin
