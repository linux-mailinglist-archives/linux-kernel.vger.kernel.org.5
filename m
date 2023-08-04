Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C67702C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjHDOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjHDOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:16:05 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19CFCC;
        Fri,  4 Aug 2023 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8D9wvMmM4uErK9JyEcOB+SxkS6AC4dhGokfj5lAmhyc=; b=ZtMcnNaDV6LEE37QwuycSaH7UJ
        5TN/6a4XwiCz5/lN+eKxRdHYFFNuzR8l592trQ/7Ta/vMLd1owpDny+VhA9VU6StVFHH13GS435c/
        yhdvrQOl9p6FkrAhHVyR8av7v+FTrmax0waq166YHpRfBLDbzQXVH2r0EKCxfwwWp/Wo=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:56768 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRvat-0007Ge-Qs; Fri, 04 Aug 2023 10:15:56 -0400
Date:   Fri, 4 Aug 2023 10:15:54 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230804101554.c63202df93481bd5728bd3f1@hugovil.com>
In-Reply-To: <2023080415-kinetic-repurpose-030a@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-5-hugo@hugovil.com>
        <2023073118-mousiness-sandlot-6258@gregkh>
        <20230803121449.bcf74899e062ca39dfb073a3@hugovil.com>
        <2023080415-kinetic-repurpose-030a@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 04/10] serial: sc16is7xx: refactor GPIO controller
 registration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 15:14:18 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Aug 03, 2023 at 12:14:49PM -0400, Hugo Villeneuve wrote:
> > On Mon, 31 Jul 2023 17:55:42 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Tue, Jul 25, 2023 at 10:23:36AM -0400, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > In preparation for upcoming patch "fix regression with GPIO
> > > > configuration". To facilitate review and make code more modular.
> > > 
> > > I would much rather the issue be fixed _before_ the code is refactored,
> > > unless it is impossible to fix it without the refactor?
> > 
> > Hi Greg,
> > normally I would agree, but the refactor in this case helps a lot to
> > address some issues raised by you and Andy in V7 of this series.
> > 
> > Maybe I could merge it with the actual patch "fix regression with GPIO
> > configuration"?
> 
> Sure.

Hi Greg,
will do.

 
> > > > Cc: <stable@vger.kernel.org> # 6.1.x
> > > 
> > > What commit id does this fix?
> > 
> > It doesn't fix anything, but I tought that I needed this tag since
> > this patch is a prerequisite for the next patch in the series, which
> > would be applied to stable kernels. I will remove this tag (assuming
> > the patch stays as it is, depending on your answer to the above
> > question).
> > 
> >  
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > > ---
> > > >  drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++--------------
> > > >  1 file changed, 24 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > > > index 32d43d00a583..5b0aeef9d534 100644
> > > > --- a/drivers/tty/serial/sc16is7xx.c
> > > > +++ b/drivers/tty/serial/sc16is7xx.c
> > > > @@ -332,6 +332,7 @@ struct sc16is7xx_one {
> > > >  
> > > >  struct sc16is7xx_port {
> > > >  	const struct sc16is7xx_devtype	*devtype;
> > > > +	struct device			*dev;
> > > 
> > > Why is this pointer needed?
> > > 
> > > Why is it grabbed and yet the reference count is never incremented?  Who
> > > owns the reference count and when will it go away?
> > > 
> > > And what device is this?  The parent?  Current device?  What type of
> > > device is it?  And why is it needed?
> > > 
> > > Using "raw" devices is almost never something a driver should do, they
> > > are only passed into functions by the driver core, but then the driver
> > > should instantly turn them into the "real" structure.
> > 
> > We already discussed that a lot in previous versions (v7)... I am
> > trying my best to modify the code to address your concerns, but I am
> > not fully understanding what you mean about raw devices, and you didn't
> > answer some of my previous questions/interrogations in v7 about that.
> 
> I don't have time to answer all questions, sorry.
> 
> Please help review submitted patches to reduce my load and allow me to
> answer other stuff :)

Ok.


> > So, in the new function that I
> > need to implement, sc16is7xx_setup_gpio_chip(), I absolutely need to use
> > a raw device to read a device tree property and to set
> > s->gpio.parent:
> > 
> >     count = device_property_count_u32(dev, ...
> >     ...
> >     s->gpio.parent = dev;
> > 
> > Do we agree on that?
> 
> Yes, but what type of parent is that?

I am confused by your question. I do not understand why the type of
parent matters... And what do you call the parent: s, s->gpio or
s->gpio.parent?

For me, the way I understand it, the only question that matters is how I
can extract the raw device structure pointer from maybe "struct
sc16is7xx_port" or some other structure, and then use it in my
new function...

I should not have put "s->gpio.parent = dev" in the example, I think it
just complexifies things. Lets start over with a more simple example and
only:

    count = device_property_count_u32(dev, ...


> > Then, how do I pass this raw device to the 
> > device_property_count_u32() function and to the s->gpio.parent
> > assignment?
> > 
> > Should I modify sc16is7xx_setup_gpio_chip() like so:
> > 
> >     static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
> >     {
> > 	struct device *dev = &s->p[0].port.dev;
> > 
> >         count = device_property_count_u32(dev, ...
> >         ...
> >         s->gpio.parent = dev;
> 
> Again, what is the real type of that parent?  It's a port, right, so
> pass in the port to this function and then do the "take the struct
> device of the port" at that point in time.

With the simplified example, is the following ok:

static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
{
    struct device *dev = &s->p[0].port.dev;

    count = device_property_count_u32(dev, ...
    ...
}

If not, please indicate how you would do it with an actual example...

Thank you,
Hugo.
