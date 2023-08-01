Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751D176BAF2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHARRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjHARRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:17:13 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98FB2100;
        Tue,  1 Aug 2023 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n2VmzUQFn6cFV/kGZ1sLa3YSYX+PxGH4bL1ntE15zIw=; b=GahSqfs+RS7g361NfzoHIiEII1
        hjeOwpOjVBcqZoVkfjmYCAEVWMU0CYy2PYO7V6rlgWFSlbp4jrGUgBm2cdRurYU4/atjXY7gLoD38
        ykiEsnQEcSwvkk9oY67DTuuOZkMRJU1hNik4B1ExjKcOve6pp+V0MdE3Bn7GijKoyekE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:39594 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qQszR-0000xr-4b; Tue, 01 Aug 2023 13:16:58 -0400
Date:   Tue, 1 Aug 2023 13:16:55 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Ilpo =?ISO-8859-1?Q?J?= =?ISO-8859-1?Q?=E4rvinen?= 
        <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230801131655.80bd8f97f018dda6155d65f6@hugovil.com>
In-Reply-To: <2023073148-marshy-extenuate-2d45@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-2-hugo@hugovil.com>
        <2023073148-marshy-extenuate-2d45@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 01/10] serial: sc16is7xx: fix broken port 0 uart init
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:52:26 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 25, 2023 at 10:23:33AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > The sc16is7xx_config_rs485() function is called only for the second
> > port (index 1, channel B), causing initialization problems for the
> > first port.
> >=20
> > For the sc16is7xx driver, port->membase and port->mapbase are not set,
> > and their default values are 0. And we set port->iobase to the device
> > index. This means that when the first device is registered using the
> > uart_add_one_port() function, the following values will be in the port
> > structure:
> >     port->membase =3D 0
> >     port->mapbase =3D 0
> >     port->iobase  =3D 0
> >=20
> > Therefore, the function uart_configure_port() in serial_core.c will
> > exit early because of the following check:
> > 	/*
> > 	 * If there isn't a port here, don't do anything further.
> > 	 */
> > 	if (!port->iobase && !port->mapbase && !port->membase)
> > 		return;
> >=20
> > Typically, I2C and SPI drivers do not set port->membase and
> > port->mapbase.
> >=20
> > The max310x driver sets port->membase to ~0 (all ones). By
> > implementing the same change in this driver, uart_configure_port() is
> > now correctly executed for all ports.
> >=20
> > Fixes: dfeae619d781 ("serial: sc16is7xx")
>=20
> That commit is in a very old 3.x release.
>=20
> > Cc: <stable@vger.kernel.org> # 6.1.x
>=20
> But you say this should only go to 6.1.y?  Why?  What is wrong with the
> older kernels?

Hi Greg,
I have read (and reread a couple of times)
Documentation/process/stable-kernel-rules.rst to try to understand how
to format the tags, but unfortunately it doesn't contain "Everything
you ever wanted to know about Linux -stable releases" as the title
claims :)

In particular, it doesn't explain or advise which older version we
should target, that is why since I was not sure I specified 6.1.y
because I could test it properly, but not v3.x.

Maybe it would be best to simply drop for now all the "Cc:
<stable@vger.kernel.org>" tags for this series, and following Option 2,
I send an email to stable@vger.kernel.org once the patches have been
merged to Linus' tree?


> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index 2e7e7c409cf2..8ae2afc76a9b 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1436,6 +1436,7 @@ static int sc16is7xx_probe(struct device *dev,
> >  		s->p[i].port.fifosize	=3D SC16IS7XX_FIFO_SIZE;
> >  		s->p[i].port.flags	=3D UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> >  		s->p[i].port.iobase	=3D i;
> > +		s->p[i].port.membase	=3D (void __iomem *)~0;
>=20
> That's a magic value, some comment should be added here to explain why
> setting all bits is ok.  Why does this work exactly?  You only say that
> the max310x driver does this, but not why it does this at all.

I do not understand, because my commit log message is quite long
and, it seems to me, well documenting why this works the way it
does when calling uart_configure_port() in serial_core.c?

I say that the max310x driver also does this, because there is also no
comment in the max310x driver for using the (void __iomem *)~0;
construct. I also located the original commit message for the max310x
driver but no comments were usefull there also.

So, what about adding this comment:

/*
 * Use all ones as membase to make sure uart_configure_port() in
 * serial_core.c does not abort for SPI/I2C devices where the
 * membase address is not applicable.
 */
 s->p[i].port.membase	=3D (void __iomem *)~0;


Also, keep in mind that in the original discussion about that patch,
there was the following comment from Ilpo J=E4rvinen:

------
This changelog was really well describing the problem! :-)
Yeah, some other solution should be devised. Maybe we should add
another .iotype for thse kind of devices. But I'm fine with this for
this fix. After editing the changelog, feel free to add:
Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
------

If wou want, I could also add the same comment to the max310 driver?

Hugo.
