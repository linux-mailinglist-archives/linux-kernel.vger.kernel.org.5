Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D8476EB27
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjHCNt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjHCNtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:49:11 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF21702;
        Thu,  3 Aug 2023 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ld2noSdra5BNqMzE0bPZuYFJMJpb2EpiNnt7IK1QEFM=; b=X9izG5Cxk+OQmeNZ56PEzFQbiR
        6asrc0JJAS/e11bzA0YKNYjLlB+8uBv44sWgZ7Xrt6qSPogLugLYOrMQhZb+KuGmEUB1BPNPLx8Ll
        +bWy0jBEZbL0BZOURkXgk8wkivLpKWrIYW5UwXLrBvwrSceXa2gtC/hzy8oummCTOQf0=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:50276 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRY0L-00085F-He; Thu, 03 Aug 2023 09:04:39 -0400
Date:   Thu, 3 Aug 2023 09:04:36 -0400
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
Message-Id: <20230803090436.ca7ebefaa63054f30cf10f89@hugovil.com>
In-Reply-To: <2023080336-unsalted-dropout-d8f6@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-2-hugo@hugovil.com>
        <2023073148-marshy-extenuate-2d45@gregkh>
        <20230801131655.80bd8f97f018dda6155d65f6@hugovil.com>
        <2023080336-unsalted-dropout-d8f6@gregkh>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 01/10] serial: sc16is7xx: fix broken port 0 uart init
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 09:54:37 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Aug 01, 2023 at 01:16:55PM -0400, Hugo Villeneuve wrote:
> > On Mon, 31 Jul 2023 17:52:26 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >=20
> > > On Tue, Jul 25, 2023 at 10:23:33AM -0400, Hugo Villeneuve wrote:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > >=20
> > > > The sc16is7xx_config_rs485() function is called only for the second
> > > > port (index 1, channel B), causing initialization problems for the
> > > > first port.
> > > >=20
> > > > For the sc16is7xx driver, port->membase and port->mapbase are not s=
et,
> > > > and their default values are 0. And we set port->iobase to the devi=
ce
> > > > index. This means that when the first device is registered using the
> > > > uart_add_one_port() function, the following values will be in the p=
ort
> > > > structure:
> > > >     port->membase =3D 0
> > > >     port->mapbase =3D 0
> > > >     port->iobase  =3D 0
> > > >=20
> > > > Therefore, the function uart_configure_port() in serial_core.c will
> > > > exit early because of the following check:
> > > > 	/*
> > > > 	 * If there isn't a port here, don't do anything further.
> > > > 	 */
> > > > 	if (!port->iobase && !port->mapbase && !port->membase)
> > > > 		return;
> > > >=20
> > > > Typically, I2C and SPI drivers do not set port->membase and
> > > > port->mapbase.
> > > >=20
> > > > The max310x driver sets port->membase to ~0 (all ones). By
> > > > implementing the same change in this driver, uart_configure_port() =
is
> > > > now correctly executed for all ports.
> > > >=20
> > > > Fixes: dfeae619d781 ("serial: sc16is7xx")
> > >=20
> > > That commit is in a very old 3.x release.
> > >=20
> > > > Cc: <stable@vger.kernel.org> # 6.1.x
> > >=20
> > > But you say this should only go to 6.1.y?  Why?  What is wrong with t=
he
> > > older kernels?
> >=20
> > Hi Greg,
> > I have read (and reread a couple of times)
> > Documentation/process/stable-kernel-rules.rst to try to understand how
> > to format the tags, but unfortunately it doesn't contain "Everything
> > you ever wanted to know about Linux -stable releases" as the title
> > claims :)
> >=20
> > In particular, it doesn't explain or advise which older version we
> > should target, that is why since I was not sure I specified 6.1.y
> > because I could test it properly, but not v3.x.
>=20
> If you think this fixes an issue back to 3.x, then just leave it at
> that, there's no need to have to test all of these.  If when I apply the
> patch to the stable trees, and it does not go back to all of the
> active versions specified by Fixes: then you will get an email saying
> so and can handle it then if you want to.
>=20
> > Maybe it would be best to simply drop for now all the "Cc:
> > <stable@vger.kernel.org>" tags for this series, and following Option 2,
> > I send an email to stable@vger.kernel.org once the patches have been
> > merged to Linus' tree?
>=20
> That will just mean more work for both of us, leave it as is, just drop
> the "# 6.1.x" portion please.
>=20
> > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > > > ---
> > > >  drivers/tty/serial/sc16is7xx.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc=
16is7xx.c
> > > > index 2e7e7c409cf2..8ae2afc76a9b 100644
> > > > --- a/drivers/tty/serial/sc16is7xx.c
> > > > +++ b/drivers/tty/serial/sc16is7xx.c
> > > > @@ -1436,6 +1436,7 @@ static int sc16is7xx_probe(struct device *dev,
> > > >  		s->p[i].port.fifosize	=3D SC16IS7XX_FIFO_SIZE;
> > > >  		s->p[i].port.flags	=3D UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> > > >  		s->p[i].port.iobase	=3D i;
> > > > +		s->p[i].port.membase	=3D (void __iomem *)~0;
> > >=20
> > > That's a magic value, some comment should be added here to explain why
> > > setting all bits is ok.  Why does this work exactly?  You only say th=
at
> > > the max310x driver does this, but not why it does this at all.
> >=20
> > I do not understand, because my commit log message is quite long
> > and, it seems to me, well documenting why this works the way it
> > does when calling uart_configure_port() in serial_core.c?
> >=20
> > I say that the max310x driver also does this, because there is also no
> > comment in the max310x driver for using the (void __iomem *)~0;
> > construct. I also located the original commit message for the max310x
> > driver but no comments were usefull there also.
> >=20
> > So, what about adding this comment:
> >=20
> > /*
> >  * Use all ones as membase to make sure uart_configure_port() in
> >  * serial_core.c does not abort for SPI/I2C devices where the
> >  * membase address is not applicable.
> >  */
> >  s->p[i].port.membase	=3D (void __iomem *)~0;
>=20
> Yes, that would be good, thank you.
>=20
> > If wou want, I could also add the same comment to the max310 driver?
>=20
> Yes please.

Hi Greg,
I will send a separate patch specifically for this.

Thank you, Hugo.
