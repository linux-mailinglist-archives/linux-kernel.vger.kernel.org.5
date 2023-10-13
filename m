Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D31A7C82E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjJMKUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:20:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F22AA9;
        Fri, 13 Oct 2023 03:20:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB7AC433C8;
        Fri, 13 Oct 2023 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697192404;
        bh=6ORHOHWmjImsg3NmHUcsG7SvoEhwLA+oFEammIOKG48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcuKbjunO2RjjyGYMrf987PGTMjKVzhwR2ORo7BIz6tYnENZqBafedukYHz3Rn27N
         U3cSuiB645WD2ND40VedAqDCTiXxDlCH/icjZ1ai2Q2tGqLslHgXTtb31pncWgca6/
         3svpxV1rTFrv1m1S/HC8YS86Wt6S9BSRJ2d9v1duy6ldEzAK7yEjkJrJhKY2ld616f
         Z6sM3H42CkiGQEI/QCJadEzuI0+F4ikGAgr+I30vo8SvOXP10mSp7zuni6dHrKqhp4
         o3YFYk0fC1k9URdnME1rMK61cyqmZk1qWBdGD96YwBlKwwvKsVxU88US0tNWd4toKL
         W8Po2Vnk9CX8Q==
Date:   Fri, 13 Oct 2023 11:19:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2] leds: sc27xx: Move mutex_init() to the end of
 probe
Message-ID: <20231013101959.GL8314@google.com>
References: <20231012034735.804157-1-chunyan.zhang@unisoc.com>
 <6110db84-546d-fc5c-f241-7923d673bbd5@linux.alibaba.com>
 <20231012091602.GD8314@google.com>
 <59ab760c-de22-5f62-5532-9a94427e143c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59ab760c-de22-5f62-5532-9a94427e143c@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023, Baolin Wang wrote:

> 
> 
> On 10/12/2023 5:16 PM, Lee Jones wrote:
> > On Thu, 12 Oct 2023, Baolin Wang wrote:
> > 
> > > 
> > > 
> > > On 10/12/2023 11:47 AM, Chunyan Zhang wrote:
> > > > Move the mutex_init() to avoid redundant mutex_destroy() calls after
> > > > that for each time the probe fails.
> > > > 
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > > Rebased onto linux-next.
> > > > 
> > > > V2:
> > > > - Move the mutex_init() to the end of .probe() instead of adding
> > > > mutex_destroy() according to Lee's comments.
> > > > ---
> > > >    drivers/leds/leds-sc27xx-bltc.c | 9 ++++-----
> > > >    1 file changed, 4 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> > > > index af1f00a2f328..ef57e57ecf07 100644
> > > > --- a/drivers/leds/leds-sc27xx-bltc.c
> > > > +++ b/drivers/leds/leds-sc27xx-bltc.c
> > > > @@ -296,7 +296,6 @@ static int sc27xx_led_probe(struct platform_device *pdev)
> > > >    		return -ENOMEM;
> > > >    	platform_set_drvdata(pdev, priv);
> > > > -	mutex_init(&priv->lock);
> > > >    	priv->base = base;
> > > >    	priv->regmap = dev_get_regmap(dev->parent, NULL);
> > > >    	if (!priv->regmap) {
> > > > @@ -309,13 +308,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
> > > >    		err = of_property_read_u32(child, "reg", &reg);
> > > >    		if (err) {
> > > >    			of_node_put(child);
> > > > -			mutex_destroy(&priv->lock);
> > > >    			return err;
> > > >    		}
> > > >    		if (reg >= SC27XX_LEDS_MAX || priv->leds[reg].active) {
> > > >    			of_node_put(child);
> > > > -			mutex_destroy(&priv->lock);
> > > >    			return -EINVAL;
> > > >    		}
> > > > @@ -325,9 +322,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
> > > >    	err = sc27xx_led_register(dev, priv);
> > > >    	if (err)
> > > > -		mutex_destroy(&priv->lock);
> > > > +		return err;
> > > > -	return err;
> > > > +	mutex_init(&priv->lock);
> > > 
> > > I think it is better to prepare all the required resources before
> > > registering the led device, what I mean is moving mutex_init() before
> > > calling sc27xx_led_register().
> > 
> > Is the mutex used before this point?
> > 
> > If not, I don't see any reason to initialise it sooner.
> 
> When inserting the led module, after registering the led device, users can
> set the led brightness or pattern trigger before initializing the mutex,
> which will crash the system. I know this may not be an actual scenario, but
> this patch opens a small race window, that's what I concerned.

If there's a good technical reason to move it, then we should.

-- 
Lee Jones [李琼斯]
