Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CFE7650C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjG0KSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjG0KSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:18:44 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14210F9;
        Thu, 27 Jul 2023 03:18:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC9DF240009;
        Thu, 27 Jul 2023 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690453120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVq3Vc2yDzDKpJTcAR2jA40+zkxL5sFVNMLQL+uihyc=;
        b=LGBKo4DDE6TlLK+r5fTDq47Or6GsDCPWtkuzd8m01djTnntuS1whrhZ2QA3u0laO3aepgx
        rqvLj+Dz26tpJXrON2TF+vdJS7VEZAS6u+braSD1zItS8ACXGXCV/HJOaMNzrJensddzRn
        vLkeJfbV+0di+euOuaVZ9CDsqgncSuKL4pqV/LzInvwOK9eMrHE2IPGs6TpoFGMtc3Dz9B
        NAq27nwXNI7xm0DLU67stWHWnZaGSrDO6Ja3XiR87FCrQfmbtK1KH4XzlWa31FCWcSeyP1
        ZOqjOi2BM6kZns8uVQmjpT0xj014mQnM1O+zGWPTUXUApK/CTHrOu0cc7swVyA==
Date:   Thu, 27 Jul 2023 12:18:34 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lee Jones <lee@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v2 22/28] mfd: core: Ensure disabled devices are skiped
 without aborting
Message-ID: <20230727121834.475541d0@bootlin.com>
In-Reply-To: <20230727092209.GA8175@google.com>
References: <20230726150225.483464-1-herve.codina@bootlin.com>
        <20230726150225.483464-23-herve.codina@bootlin.com>
        <20230727092209.GA8175@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Thu, 27 Jul 2023 10:22:09 +0100
Lee Jones <lee@kernel.org> wrote:

> On Wed, 26 Jul 2023, Herve Codina wrote:
> 
> > The loop searching for a matching device based on its compatible
> > string is aborted when a matching disabled device is found.
> > This abort avoid to add devices as soon as one disabled device
> > is found.
> > 
> > Continue searching for an other device instead of aborting on the
> > first disabled one fixes the issue.
> > 
> > Fixes: 22380b65dc70 ("mfd: mfd-core: Ensure disabled devices are ignored without error")
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/mfd/mfd-core.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 0ed7c0d7784e..bcc26e64639a 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -146,6 +146,7 @@ static int mfd_add_device(struct device *parent, int id,
> >  	struct platform_device *pdev;
> >  	struct device_node *np = NULL;
> >  	struct mfd_of_node_entry *of_entry, *tmp;
> > +	bool disabled;
> >  	int ret = -ENOMEM;
> >  	int platform_id;
> >  	int r;
> > @@ -181,13 +182,13 @@ static int mfd_add_device(struct device *parent, int id,
> >  		goto fail_res;
> >  
> >  	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
> > +		disabled = false;  
> 
> This does not appear to reside in a loop.
> 
> Why not set it to false on declaration?

Indeed, I will change in the next iteration and set the value to false at
the declaration.

> 
> >  		for_each_child_of_node(parent->of_node, np) {
> >  			if (of_device_is_compatible(np, cell->of_compatible)) {
> > -				/* Ignore 'disabled' devices error free */
> > +				/* Skip 'disabled' devices */
> >  				if (!of_device_is_available(np)) {
> > -					of_node_put(np);  
> 
> Doesn't this result in a resource leak?

No because we change from 'goto fail_alias' to 'continue' and so we don't
exit from the for_each_child_of_node().
The for_each_child_of_node() calls of_get_next_child() and, in turn, calls
of_node_put().

Regards,
Hervé

> 
> > -					ret = 0;
> > -					goto fail_alias;
> > +					disabled = true;
> > +					continue;
> >  				}
> >  
> >  				ret = mfd_match_of_node_to_dev(pdev, np, cell);
> > @@ -197,10 +198,17 @@ static int mfd_add_device(struct device *parent, int id,
> >  				if (ret)
> >  					goto fail_alias;
> >  
> > -				break;
> > +				goto match;
> >  			}
> >  		}
> >  
> > +		if (disabled) {
> > +			/* Ignore 'disabled' devices error free */
> > +			ret = 0;
> > +			goto fail_alias;
> > +		}
> > +
> > +match:
> >  		if (!pdev->dev.of_node)
> >  			pr_warn("%s: Failed to locate of_node [id: %d]\n",
> >  				cell->name, platform_id);
> > -- 
> > 2.41.0
> >   
> 

