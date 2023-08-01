Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2DB76B219
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjHAKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjHAKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:44:07 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBFF1;
        Tue,  1 Aug 2023 03:44:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC711C000B;
        Tue,  1 Aug 2023 10:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690886645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEKysH7Y2t6RfT3AfGBp54HWpVEF5LkKbUS/QMB1QqY=;
        b=ZDFUSJCbj6fA75RKgaU5KyPEubtFY3VzZOU8PdM1aCEbn6YSr+BqKTYpbhrc46wMcH0s0L
        xbOm3AV2jxN5pU9+f/y8A9D3ioPgJhEd+sVK5My40QUl79HhUIbpj8Z6FNyH6QoT4nLscV
        NdL3KC+I6mGLCCwmwgWymKieJnjUTwOHTLIXhRkwbL6P451XEVX4DF5rLwP5jH755aRr5A
        FyunbjnU1zJ4gkeAKrjHmbUWqnP/x6TUa+mZakYm+Nj1ODX7z5jLVFZXmNjXbfvfW8mk1Z
        CpC9vyGyEVAFqeoF0/BJLsYkRWxGBKUslX0/qHv6q48CI5T1qUFNPHFyVl0vlQ==
Date:   Tue, 1 Aug 2023 12:44:01 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 23/28] net: wan: framer: Add support for the Lantiq
 PEF2256 framer
Message-ID: <20230801124401.3883d16c@bootlin.com>
In-Reply-To: <4adae593-c428-4910-882e-7247727cf501@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-24-herve.codina@bootlin.com>
        <4adae593-c428-4910-882e-7247727cf501@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 12:22:39 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static inline u8 pef2256_read8(struct pef2256 *pef2256, int offset)
> > +{
> > +	int val;
> > +
> > +	regmap_read(pef2256->regmap, offset, &val);
> > +	return val;
> > +}
> > +
> > +static inline void pef2256_write8(struct pef2256 *pef2256, int offset, u8 val)
> > +{
> > +	regmap_write(pef2256->regmap, offset, val);
> > +}  
> 
> More cases of inline functions in .C files. Please let the compiler
> decide.

Will be changed.

> 
> > +static void pef2256_isr_default_handler(struct pef2256 *pef2256, u8 nbr, u8 isr)
> > +{
> > +	dev_warn(pef2256->dev, "ISR%u: 0x%02x not handled\n", nbr, isr);
> > +}  
> 
> Should this be rate limited? It is going to be very noise if it gets
> called once per frame time.

This function should not be called.
It is wired on some interrupts and these interrupts should not be triggered.
It they fired, something was wrong.

I would prefer to keep this dev_warn() to keep the user informed about the
problem.

Regards,
Hervé


-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
