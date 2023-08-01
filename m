Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245BC76B050
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjHAKF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjHAKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:05:23 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A425C92;
        Tue,  1 Aug 2023 03:05:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DE551C0012;
        Tue,  1 Aug 2023 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690884315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSVB+HORSFsnXDmjVg67aSWP2rANROm59byfAHhHD0Y=;
        b=H3+g77sXqmhMiUD9cLYfYWHOIVyYaAAYK3S6orraq++QkO4KEPeDisG+ZrlTgTA5FpWvKu
        69gaGhOPX+b8Lggqcv5DbCT0WtLbny4lOhHNeGu2Ndjj3nIYbC3SzM5ixLuleezrP3/GYL
        5wvk9vgnF24HM+baeEJ3BmpWjahI4i5fge3JTVMe9EmMLUTtwb/ZAliplzCM5qZU13rsEO
        7vUl/ArcrY7p6p8npXU92BVujGKBPxxWvqIuZHuk99NXtqsfCLiewRCtG+M4ycbXPoFd5/
        22qw57nzEewvcaWgfHT2vgGimy6CmMvgiMnA62C50o4su4myL978d2bjQcLMjQ==
Date:   Tue, 1 Aug 2023 12:05:10 +0200
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
Subject: Re: [PATCH v2 08/28] soc: fsl: cpm1: qmc: Introduce available
 timeslots masks
Message-ID: <20230801120510.1ac862de@bootlin.com>
In-Reply-To: <dd34fa03-0b34-44a4-9e70-9d9a69f95403@lunn.ch>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-9-herve.codina@bootlin.com>
        <dd34fa03-0b34-44a4-9e70-9d9a69f95403@lunn.ch>
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

On Tue, 1 Aug 2023 11:33:39 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Jul 26, 2023 at 05:02:04PM +0200, Herve Codina wrote:
> > Available timeslots masks define timeslots available for the related
> > channel. These timeslots are defined by the QMC binding.
> > 
> > Timeslots used are initialized to available timeslots but can be a
> > subset of available timeslots.
> > This prepares the dynamic timeslots management (ie. changing timeslots
> > at runtime).
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/soc/fsl/qe/qmc.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> > index 2d2a9d88ba6c..21ad7e79e7bd 100644
> > --- a/drivers/soc/fsl/qe/qmc.c
> > +++ b/drivers/soc/fsl/qe/qmc.c
> > @@ -177,7 +177,9 @@ struct qmc_chan {
> >  	struct qmc *qmc;
> >  	void __iomem *s_param;
> >  	enum qmc_mode mode;
> > +	u64	tx_ts_mask_avail;
> >  	u64	tx_ts_mask;
> > +	u64	rx_ts_mask_avail;
> >  	u64	rx_ts_mask;  
> 
> Is this for E1? So there is a maximum of 32 slots? A u32 would be
> sufficient i think?
> 

The QMC can use up to 64 slots. So masks related to the QMC are on 64bits.
These masks are not specific to the E1 framer but really related to the QMC
capabilities.

Regards,
Hervé
