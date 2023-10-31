Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFA7DCF79
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjJaOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjJaOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:30:38 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A857FDA;
        Tue, 31 Oct 2023 07:30:35 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E39C240003;
        Tue, 31 Oct 2023 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698762634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjOGE62KGqyY3N71na39yHJ0YOnyX5TL/3wHgzUTP/8=;
        b=NoLpvVHH3MSIfsCf0iOpECRB4omBKIBVCnSXPLUg1MEmEOESPXlRDmbqIBVNoLBS3/5MTn
        tIP5CDC0mWLjCd8f3OhiAZ9jFZvUAYFjRk/xzE59IPH/TvGXfeNv833u+wzOXZpSh3607t
        0tDzfGDEbG5lEN0QDhwgICpWXIMwuLhPaSWJAAPVVggzovzV13jaeSCxliAoEVVjMUQAfn
        iD2WGpkEHToB6YhJO3eOm6gq4Jpe+Z2qZp/+JOE+hRNHKBNSCl8xzdWxyZ1g0Ahg8FMjNW
        qRVtjGGvuaI4vMnMolWqmehXwo/pf5pifD5BFcnqofTUmzz7jKEtZx75/GQnqg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 31 Oct 2023 15:30:32 +0100
Message-Id: <CWMP3FX78B9O.9GVKCAH3OFGZ@tleb-bootlin-xps13-01>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
Cc:     "Hugo Villeneuve" <hugo@hugovil.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.15.2
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
 <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
 <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
 <ZUDS5UpWlo+DUZc4@shell.armlinux.org.uk>
 <CWMKPFZ9LOVD.2756QU9AP6U3W@tleb-bootlin-xps13-01>
 <ZUDjhpQKgUgqVeBh@shell.armlinux.org.uk>
 <CWMNJ47MO8E6.7CXJRZ181PXJ@tleb-bootlin-xps13-01>
 <ZUEJjdfk/vmH8XTR@shell.armlinux.org.uk>
In-Reply-To: <ZUEJjdfk/vmH8XTR@shell.armlinux.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue Oct 31, 2023 at 3:05 PM CET, Russell King (Oracle) wrote:
> On Tue, Oct 31, 2023 at 02:51:45PM +0100, Th=C3=A9o Lebrun wrote:
> > On Tue Oct 31, 2023 at 12:22 PM CET, Russell King (Oracle) wrote:
> > > On Tue, Oct 31, 2023 at 12:04:11PM +0100, Th=C3=A9o Lebrun wrote:
> > > > On Tue Oct 31, 2023 at 11:11 AM CET, Russell King (Oracle) wrote:
> > > > > There is no point in supporting 5 or 6 bits for console usage. Th=
ink
> > > > > about it. What values are going to be sent over the console? It'l=
l be
> > > > > ASCII, which requires at _least_ 7-bit. 6-bit would turn alpha
> > > > > characters into control characters, punctuation and numbers. 5-bi=
t
> > > > > would be all control characters.
> > > > >
> > > > > So there's no point trying to do anything with 5 or 6 bits per by=
te,
> > > > > and I decided we might as well take that as an error (or maybe a
> > > > > case that the hardware has not been setup) and default to 8 bits =
per
> > > > > byte.
> > > >=20
> > > > I see your point. Two things come to mind:
> > > >=20
> > > >  - I added this parsing of 5/6 bits to be symmetrical with
> > > >    pl011_set_termios that handles 5/6 properly. Should pl011_set_te=
rmios
> > > >    be modified then?
> > >
> > > Why should it? Note that I said above about _console_ usage which is
> > > what you were referring to - the early code that sets up the console
> > > by either reading the current settings (so that we can transparently
> > > use the UART when its handed over already setup by a boot loader).
> > >
> > > This is completely different to what happens once the kernel is runni=
ng.
> > > Userspace might very well have a reason to set 5 or 6 bits if it want=
s
> > > to communicate with a device that uses those sizes.
> > >
> > > However, such a device won't be a console for the reasons I outlined
> > > above (it will truncate the ASCII characters turning console messages
> > > into garbage.)
> >=20
> > I'm not sure I get it. (1) We assume it is a console so it's ASCII so n=
o
> > reason to set to 5 or 6 bits per word. But (2) there might be a reason
> > to set the UART to 5 or 6 bits, the userspace decides.
>
> Precisely.
>
> > How do the two interact? Say we boot to Linux, userspace configures to =
6
> > bits because reasons and we reset. At second probe we see a config of 6
> > bits per word but assume that can't be logical, even though it is.
>
> I think you're conflating "serial console" with "serial port". A
> "serial port" can support multiple different formats, and in this case,
> such as 5, 6, 7, and 8 bits. 5 and 6 bits are likely to be a specialised
> application which uses a binary protocol, not ASCII.
>
> A "serial console" is one application of a "serial port" and a "serial
> console" is used to send ASCII characters, not a binary protocol.

That was all clear in my mind; I was missing the following bit:

> Sorry, but no, we don't assume every serial port is a serial console.
> Unless something has changed since I was involved with the serial
> layer, **we only read the parameters from a serial port _if_ and only
> if that port is being used as a serial console.**

Thank you for the time you took; I'll get rid of the patch and send a V2
fixing nits for other patches.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
