Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBA76EF36
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjHCQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjHCQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:15:01 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A790173F;
        Thu,  3 Aug 2023 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jswo9qlkLWf5K8IR24e3YaIGIMYkx7BIxRpgj01F1y4=; b=b0YMXBIZNHNd2NlA9Sq6UijP6q
        xNsOJWNRwER7BHYGzpnNYEgrDxujdGM6Vtvox2fOsTOj3cbmUnkC7qnhAyPjMXaLnk7iCusRLHbHA
        MEETnVICaTosKitKi+rKN13b1NwU3k1eQ2lJb0E5ksANth0rMcDBG0laQUVaQav+4vHs=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:47720 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRayQ-0001ok-55; Thu, 03 Aug 2023 12:14:50 -0400
Date:   Thu, 3 Aug 2023 12:14:49 -0400
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
Message-Id: <20230803121449.bcf74899e062ca39dfb073a3@hugovil.com>
In-Reply-To: <2023073118-mousiness-sandlot-6258@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-5-hugo@hugovil.com>
        <2023073118-mousiness-sandlot-6258@gregkh>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 04/10] serial: sc16is7xx: refactor GPIO controller
 registration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:55:42 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 25, 2023 at 10:23:36AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > In preparation for upcoming patch "fix regression with GPIO
> > configuration". To facilitate review and make code more modular.
> 
> I would much rather the issue be fixed _before_ the code is refactored,
> unless it is impossible to fix it without the refactor?

Hi Greg,
normally I would agree, but the refactor in this case helps a lot to
address some issues raised by you and Andy in V7 of this series.

Maybe I could merge it with the actual patch "fix regression with GPIO
configuration"?


> > Cc: <stable@vger.kernel.org> # 6.1.x
> 
> What commit id does this fix?

It doesn't fix anything, but I tought that I needed this tag since
this patch is a prerequisite for the next patch in the series, which
would be applied to stable kernels. I will remove this tag (assuming
the patch stays as it is, depending on your answer to the above
question).

 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 40 ++++++++++++++++++++--------------
> >  1 file changed, 24 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 32d43d00a583..5b0aeef9d534 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -332,6 +332,7 @@ struct sc16is7xx_one {
> >  
> >  struct sc16is7xx_port {
> >  	const struct sc16is7xx_devtype	*devtype;
> > +	struct device			*dev;
> 
> Why is this pointer needed?
> 
> Why is it grabbed and yet the reference count is never incremented?  Who
> owns the reference count and when will it go away?
> 
> And what device is this?  The parent?  Current device?  What type of
> device is it?  And why is it needed?
> 
> Using "raw" devices is almost never something a driver should do, they
> are only passed into functions by the driver core, but then the driver
> should instantly turn them into the "real" structure.

We already discussed that a lot in previous versions (v7)... I am
trying my best to modify the code to address your concerns, but I am
not fully understanding what you mean about raw devices, and you didn't
answer some of my previous questions/interrogations in v7 about that.

So, in the new function that I
need to implement, sc16is7xx_setup_gpio_chip(), I absolutely need to use
a raw device to read a device tree property and to set
s->gpio.parent:

    count = device_property_count_u32(dev, ...
    ...
    s->gpio.parent = dev;

Do we agree on that?

Then, how do I pass this raw device to the 
device_property_count_u32() function and to the s->gpio.parent
assignment?

Should I modify sc16is7xx_setup_gpio_chip() like so:

    static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
    {
	struct device *dev = &s->p[0].port.dev;

        count = device_property_count_u32(dev, ...
        ...
        s->gpio.parent = dev;

?

If not, can you show me how you would like to do it to avoid me trying
to guess?

Thank you,
Hugo.
