Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD876B1BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjHAK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjHAK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:26:26 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213871706;
        Tue,  1 Aug 2023 03:24:04 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C9AFC0003;
        Tue,  1 Aug 2023 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690885443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rh049SisoIWliG3uyLlXHzxD5wRc/J6bqr8r19ynpGo=;
        b=f9mqi/1Oxj+4XOaIlU22+7chRim64bLbHC89dhnq9NrYZHmPLGlNes8J8KY24lP6ZgYAlD
        eD6x5iT8jEr2zsXSVJJPvtYx5/BCSTIVTF4upPsbtDnfanTrKZzsr/NZcmTGpMMRPsbiwu
        MfI8n7wdawYwlc8X3XOv1bqEp5cuwBk81jBVGgET6qkiT/ubH6LAoCaSPNevEy1yMF9GlQ
        BgQ3xYH3kfMmnr/GZ5pgzGZmS4ZwoDWBx5Za0/Ne59WHOdLeHgCl4tpOQtBywFMYlG7Rki
        nuJbeHCb5FilfHYhV0dpg93ttgFZRXaEugYAZsyN24ghg5tiOBCl9ltTL4+hNA==
Date:   Tue, 1 Aug 2023 12:23:59 +0200
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
Subject: Re: [PATCH v2 10/28] soc: fsl: cpm1: qmc: Introduce
 qmc_chan_setup_tsa*
Message-ID: <20230801122359.6b22784c@bootlin.com>
In-Reply-To: <252d6a49-4a97-4ecc-844e-f23bda55debf@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-11-herve.codina@bootlin.com>
        <252d6a49-4a97-4ecc-844e-f23bda55debf@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 11:36:43 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static inline void qmc_clrsetbits16(void __iomem *addr, u16 clr, u16 set)
> > +{
> > +	qmc_write16(addr, (qmc_read16(addr) & ~clr) | set);
> > +}
> > +  
> 
> Please don't use inline in .c files. Let the compiler decide.
> 
>        Andrew

Ok, I will remove the inline in the next iteration.
I will also remove the inline of all other similar functions (probably a
separate patch in the series).

Regards,
Hervé
