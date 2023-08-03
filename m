Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2046276E262
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjHCIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjHCICz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65754524F;
        Thu,  3 Aug 2023 00:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11EC617F2;
        Thu,  3 Aug 2023 07:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC0EC433C8;
        Thu,  3 Aug 2023 07:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691049280;
        bh=m+eJRCyqdgjnVwAMt8/xLp9WklfLtqb5lfJD69P90as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBaRjhBZi2InmSC1/Sn9RIA2R/5Ad+bfBSJSY1gIdhveK09+5vSbXI5AuVE3EKiQF
         GK7T/ii+UdX7SIHit2OhuCe1BrdjsVC5TPrNUb+/yo8STqzqvdoylyeBuwf/7f38Fr
         I6jajHttVaZkd1R3vNMtu2reol0AcqpR3uIo0FVU=
Date:   Thu, 3 Aug 2023 09:54:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v9 01/10] serial: sc16is7xx: fix broken port 0 uart init
Message-ID: <2023080336-unsalted-dropout-d8f6@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-2-hugo@hugovil.com>
 <2023073148-marshy-extenuate-2d45@gregkh>
 <20230801131655.80bd8f97f018dda6155d65f6@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801131655.80bd8f97f018dda6155d65f6@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:16:55PM -0400, Hugo Villeneuve wrote:
> On Mon, 31 Jul 2023 17:52:26 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jul 25, 2023 at 10:23:33AM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > The sc16is7xx_config_rs485() function is called only for the second
> > > port (index 1, channel B), causing initialization problems for the
> > > first port.
> > > 
> > > For the sc16is7xx driver, port->membase and port->mapbase are not set,
> > > and their default values are 0. And we set port->iobase to the device
> > > index. This means that when the first device is registered using the
> > > uart_add_one_port() function, the following values will be in the port
> > > structure:
> > >     port->membase = 0
> > >     port->mapbase = 0
> > >     port->iobase  = 0
> > > 
> > > Therefore, the function uart_configure_port() in serial_core.c will
> > > exit early because of the following check:
> > > 	/*
> > > 	 * If there isn't a port here, don't do anything further.
> > > 	 */
> > > 	if (!port->iobase && !port->mapbase && !port->membase)
> > > 		return;
> > > 
> > > Typically, I2C and SPI drivers do not set port->membase and
> > > port->mapbase.
> > > 
> > > The max310x driver sets port->membase to ~0 (all ones). By
> > > implementing the same change in this driver, uart_configure_port() is
> > > now correctly executed for all ports.
> > > 
> > > Fixes: dfeae619d781 ("serial: sc16is7xx")
> > 
> > That commit is in a very old 3.x release.
> > 
> > > Cc: <stable@vger.kernel.org> # 6.1.x
> > 
> > But you say this should only go to 6.1.y?  Why?  What is wrong with the
> > older kernels?
> 
> Hi Greg,
> I have read (and reread a couple of times)
> Documentation/process/stable-kernel-rules.rst to try to understand how
> to format the tags, but unfortunately it doesn't contain "Everything
> you ever wanted to know about Linux -stable releases" as the title
> claims :)
> 
> In particular, it doesn't explain or advise which older version we
> should target, that is why since I was not sure I specified 6.1.y
> because I could test it properly, but not v3.x.

If you think this fixes an issue back to 3.x, then just leave it at
that, there's no need to have to test all of these.  If when I apply the
patch to the stable trees, and it does not go back to all of the
active versions specified by Fixes: then you will get an email saying
so and can handle it then if you want to.

> Maybe it would be best to simply drop for now all the "Cc:
> <stable@vger.kernel.org>" tags for this series, and following Option 2,
> I send an email to stable@vger.kernel.org once the patches have been
> merged to Linus' tree?

That will just mean more work for both of us, leave it as is, just drop
the "# 6.1.x" portion please.

> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > ---
> > >  drivers/tty/serial/sc16is7xx.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > > index 2e7e7c409cf2..8ae2afc76a9b 100644
> > > --- a/drivers/tty/serial/sc16is7xx.c
> > > +++ b/drivers/tty/serial/sc16is7xx.c
> > > @@ -1436,6 +1436,7 @@ static int sc16is7xx_probe(struct device *dev,
> > >  		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
> > >  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> > >  		s->p[i].port.iobase	= i;
> > > +		s->p[i].port.membase	= (void __iomem *)~0;
> > 
> > That's a magic value, some comment should be added here to explain why
> > setting all bits is ok.  Why does this work exactly?  You only say that
> > the max310x driver does this, but not why it does this at all.
> 
> I do not understand, because my commit log message is quite long
> and, it seems to me, well documenting why this works the way it
> does when calling uart_configure_port() in serial_core.c?
> 
> I say that the max310x driver also does this, because there is also no
> comment in the max310x driver for using the (void __iomem *)~0;
> construct. I also located the original commit message for the max310x
> driver but no comments were usefull there also.
> 
> So, what about adding this comment:
> 
> /*
>  * Use all ones as membase to make sure uart_configure_port() in
>  * serial_core.c does not abort for SPI/I2C devices where the
>  * membase address is not applicable.
>  */
>  s->p[i].port.membase	= (void __iomem *)~0;

Yes, that would be good, thank you.

> If wou want, I could also add the same comment to the max310 driver?

Yes please.

thanks,

greg k-h
