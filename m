Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F17F14F8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjKTNyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjKTNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:54:08 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D6A126;
        Mon, 20 Nov 2023 05:53:21 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11D731BF211;
        Mon, 20 Nov 2023 13:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700488400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBP5SEZ8e/heB3zUSBMQAlAbFxbFwRsOqsSWGhUKau4=;
        b=CEd0dS2x4graR9O7oHTHHQP+korRq84mVAOxufTY4KIloqv230PxRAQzbXhl1L+CcWKjwS
        jqjNpSUGpq2Fov+6LklflCXvhz7b0pOB24daWTPZYg/DLlSwfxlLt4UVFa53sgn91Ajmbh
        SRjLQWaNWaP8DDKl7ff48C/qv+co/3/HJQX0/kZ9ucczQns/foDB8JW9o401ySgEHQC5fm
        m4BGHAkbt0Q+IODgTrJi/A5cMC+KkEXLeo57TNyn5G7t2F/NVIRlMBxioi2y09DuJN+M2a
        oOpPi7nEknfsx2pYdBVctkB7mVqWbzVFp0w9tmMcLpCcctPm0mbIgO91LlTcbQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 20 Nov 2023 14:53:19 +0100
Subject: Re: [PATCH v3 6/6] tty: serial: amba-pl011: factor QDF2400 SoC
 erratum 44 out of probe
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "linux-serial" <linux-serial@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
To:     =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Message-Id: <CX3OTU62O1C4.1XI8WONTYYFU1@tleb-bootlin-xps13-01>
X-Mailer: aerc 0.15.2
References: <20231120-mbly-uart-v3-0-07ae35979f1f@bootlin.com>
 <20231120-mbly-uart-v3-6-07ae35979f1f@bootlin.com>
 <5c10e247-3fe-7455-a13-fde4c3cb0b4@linux.intel.com>
In-Reply-To: <5c10e247-3fe-7455-a13-fde4c3cb0b4@linux.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon Nov 20, 2023 at 10:55 AM CET, Ilpo J=C3=A4rvinen wrote:
> On Mon, 20 Nov 2023, Th=C3=A9o Lebrun wrote:
>
> > On this platform, different vendor data is used. That requires a
> > compile-time check as we access (1) a global boolean & (2) our local
> > vendor data. Both symbols are accessible only when
> > CONFIG_ACPI_SPCR_TABLE is enabled.
> >=20
> > Factor the vendor data overriding to a separate function that is empty
> > when CONFIG_ACPI_SPCR_TABLE is not defined.
> >=20
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  drivers/tty/serial/amba-pl011.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
> > index 4185d6fd243b..e08a32eb0ed1 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2874,6 +2874,22 @@ static int pl011_resume(struct device *dev)
> > =20
> >  static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume=
);
> > =20
> > +#ifdef CONFIG_ACPI_SPCR_TABLE
> > +static void qpdf2400_erratum44_workaround(struct device *dev,
> > +					  struct uart_amba_port *uap)
> > +{
> > +	if (qdf2400_e44_present)
>
> This should be !qdf2400_e44_present.

Completely right! I reversed the if-logic to see how it looked & I
forgot negating the condition when going back to the current shape.
I've got the fix ready for a v4. You've got some good eyes, thanks.

I'll wait a bit to see if there are any other review & avoid spamming
the maintainers.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
