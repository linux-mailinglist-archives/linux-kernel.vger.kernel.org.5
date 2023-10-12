Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA97C6942
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjJLJQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjJLJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:16:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A247C6;
        Thu, 12 Oct 2023 02:16:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B6CC433C8;
        Thu, 12 Oct 2023 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697102167;
        bh=rDqxFRbS36X3wzsamcQt8JNV0Zh3cEeJ9KK8OwPwL34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNjZKIc5WgmZe4aHX0ioCqxU8rNxJtEyXsV/NZV4DN1RQmMfka5uyhlwEN23tcH++
         DvtKsUTvf7WeFX3gNM1jbai6tEHBjnC5WSe2vcOXwRPCOr/b3FDfIqkksap9giSoRE
         s8ZzFR5TYZlPEuO1PVfS7muBmugpP9L/kNepxckOC+FZKkDaQYAX7KH91EBMeTI6/s
         cOt0rlsvEc2dWib0IjTUpxU5qDN83i+LfJoPcELEhqTUqqP8em/P6cOZzwjZysp72F
         Mt43kC/Rt6W2p/tbfJTbbQItBjW7uSYSQrZQVQgzrbmBZfgEjZfdQY7p/p90selCLE
         8WvC5QG/YiH4w==
Date:   Thu, 12 Oct 2023 10:16:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2] leds: sc27xx: Move mutex_init() to the end of
 probe
Message-ID: <20231012091602.GD8314@google.com>
References: <20231012034735.804157-1-chunyan.zhang@unisoc.com>
 <6110db84-546d-fc5c-f241-7923d673bbd5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6110db84-546d-fc5c-f241-7923d673bbd5@linux.alibaba.com>
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
> On 10/12/2023 11:47 AM, Chunyan Zhang wrote:
> > Move the mutex_init() to avoid redundant mutex_destroy() calls after
> > that for each time the probe fails.
> > 
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> > Rebased onto linux-next.
> > 
> > V2:
> > - Move the mutex_init() to the end of .probe() instead of adding
> > mutex_destroy() according to Lee's comments.
> > ---
> >   drivers/leds/leds-sc27xx-bltc.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> > index af1f00a2f328..ef57e57ecf07 100644
> > --- a/drivers/leds/leds-sc27xx-bltc.c
> > +++ b/drivers/leds/leds-sc27xx-bltc.c
> > @@ -296,7 +296,6 @@ static int sc27xx_led_probe(struct platform_device *pdev)
> >   		return -ENOMEM;
> >   	platform_set_drvdata(pdev, priv);
> > -	mutex_init(&priv->lock);
> >   	priv->base = base;
> >   	priv->regmap = dev_get_regmap(dev->parent, NULL);
> >   	if (!priv->regmap) {
> > @@ -309,13 +308,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
> >   		err = of_property_read_u32(child, "reg", &reg);
> >   		if (err) {
> >   			of_node_put(child);
> > -			mutex_destroy(&priv->lock);
> >   			return err;
> >   		}
> >   		if (reg >= SC27XX_LEDS_MAX || priv->leds[reg].active) {
> >   			of_node_put(child);
> > -			mutex_destroy(&priv->lock);
> >   			return -EINVAL;
> >   		}
> > @@ -325,9 +322,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
> >   	err = sc27xx_led_register(dev, priv);
> >   	if (err)
> > -		mutex_destroy(&priv->lock);
> > +		return err;
> > -	return err;
> > +	mutex_init(&priv->lock);
> 
> I think it is better to prepare all the required resources before
> registering the led device, what I mean is moving mutex_init() before
> calling sc27xx_led_register().

Is the mutex used before this point?

If not, I don't see any reason to initialise it sooner.

-- 
Lee Jones [李琼斯]
