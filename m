Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542F2770109
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHDNQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHDNP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:15:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB011B;
        Fri,  4 Aug 2023 06:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2860F61FF8;
        Fri,  4 Aug 2023 13:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F31C433C8;
        Fri,  4 Aug 2023 13:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691154860;
        bh=JRE8h+VxG5Sd0jsKXzMVWXS7hQJqeXSQ/aS/ksekctE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kiXa8ellOolgBX83CbkFAS4DexJZLm4NO9bEkXxWKDp2PRndVu92Fl8me2/AuA2iW
         kAyX6ZYB8BHKmENnZohPpK8n/tItrWyZz3yDJt3zsoPqQBM4J+b+jI7prCAVlroolS
         eC+syGFi33IAs2OJ/bVkE2Lueby6EfFjTC8uOsl8=
Date:   Fri, 4 Aug 2023 15:14:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v9 04/10] serial: sc16is7xx: refactor GPIO controller
 registration
Message-ID: <2023080415-kinetic-repurpose-030a@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-5-hugo@hugovil.com>
 <2023073118-mousiness-sandlot-6258@gregkh>
 <20230803121449.bcf74899e062ca39dfb073a3@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803121449.bcf74899e062ca39dfb073a3@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:14:49PM -0400, Hugo Villeneuve wrote:
> On Mon, 31 Jul 2023 17:55:42 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jul 25, 2023 at 10:23:36AM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > In preparation for upcoming patch "fix regression with GPIO
> > > configuration". To facilitate review and make code more modular.
> > 
> > I would much rather the issue be fixed _before_ the code is refactored,
> > unless it is impossible to fix it without the refactor?
> 
> Hi Greg,
> normally I would agree, but the refactor in this case helps a lot to
> address some issues raised by you and Andy in V7 of this series.
> 
> Maybe I could merge it with the actual patch "fix regression with GPIO
> configuration"?

Sure.

> > > Cc: <stable@vger.kernel.org> # 6.1.x
> > 
> > What commit id does this fix?
> 
> It doesn't fix anything, but I tought that I needed this tag since
> this patch is a prerequisite for the next patch in the series, which
> would be applied to stable kernels. I will remove this tag (assuming
> the patch stays as it is, depending on your answer to the above
> question).
> 
>  
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > ---
> > >  drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++--------------
> > >  1 file changed, 24 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > > index 32d43d00a583..5b0aeef9d534 100644
> > > --- a/drivers/tty/serial/sc16is7xx.c
> > > +++ b/drivers/tty/serial/sc16is7xx.c
> > > @@ -332,6 +332,7 @@ struct sc16is7xx_one {
> > >  
> > >  struct sc16is7xx_port {
> > >  	const struct sc16is7xx_devtype	*devtype;
> > > +	struct device			*dev;
> > 
> > Why is this pointer needed?
> > 
> > Why is it grabbed and yet the reference count is never incremented?  Who
> > owns the reference count and when will it go away?
> > 
> > And what device is this?  The parent?  Current device?  What type of
> > device is it?  And why is it needed?
> > 
> > Using "raw" devices is almost never something a driver should do, they
> > are only passed into functions by the driver core, but then the driver
> > should instantly turn them into the "real" structure.
> 
> We already discussed that a lot in previous versions (v7)... I am
> trying my best to modify the code to address your concerns, but I am
> not fully understanding what you mean about raw devices, and you didn't
> answer some of my previous questions/interrogations in v7 about that.

I don't have time to answer all questions, sorry.

Please help review submitted patches to reduce my load and allow me to
answer other stuff :)

> So, in the new function that I
> need to implement, sc16is7xx_setup_gpio_chip(), I absolutely need to use
> a raw device to read a device tree property and to set
> s->gpio.parent:
> 
>     count = device_property_count_u32(dev, ...
>     ...
>     s->gpio.parent = dev;
> 
> Do we agree on that?

Yes, but what type of parent is that?

> Then, how do I pass this raw device to the 
> device_property_count_u32() function and to the s->gpio.parent
> assignment?
> 
> Should I modify sc16is7xx_setup_gpio_chip() like so:
> 
>     static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
>     {
> 	struct device *dev = &s->p[0].port.dev;
> 
>         count = device_property_count_u32(dev, ...
>         ...
>         s->gpio.parent = dev;

Again, what is the real type of that parent?  It's a port, right, so
pass in the port to this function and then do the "take the struct
device of the port" at that point in time.

thanks,

greg k-h
