Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910B87D98DD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbjJ0MrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbjJ0Mq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:46:56 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D85BF;
        Fri, 27 Oct 2023 05:46:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFAB9FF817;
        Fri, 27 Oct 2023 12:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698410810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3i63HftU+feakpu2BbYrMpadCqw476CUSoNNflnjczs=;
        b=Crp+0TgT9AZ1xSSTbR1i6qOed1on2FZ3Sp6FJ3KKPOnvR5j9tmpc1LInwvo08UTB+Unajn
        fuFi3vMO33TwsFIotyIcIuqwgxhdGMU0oNXOfzrcR19sexSB8juvp6UHgvieEiOrgpihqT
        r+h1VaU/IJhnKThVkmmzw/v4VKc3lC1P6YWEppZ6r6PMBOoyizuX35nN/HvYrGkJZ99aqO
        ovHzrUKE3Slodp+l06IC2YKTodHd4iyKe5DOch8hRGhc4h0J0McWB0Pznlil8EVEQfr18e
        iQn4XlaYCmOm6eG4g08Z27EJQudn/mbuOQHx8XXzQADnK89EzuA0ztK/3J6JFA==
Date:   Fri, 27 Oct 2023 14:46:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Stoll, Eberhard" <eberhard.stoll@kontron.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eberhard Stoll <estl@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Schrempf, Frieder" <frieder.schrempf@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/4] spi: Add parameter for clock to rx delay
Message-ID: <20231027144646.577210ff@xps-13>
In-Reply-To: <DB9PR10MB8246A77EE4E7140E845D82FAF1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
References: <20231026152316.2729575-1-estl@gmx.net>
        <20231026152316.2729575-2-estl@gmx.net>
        <20231027005643.4b95f17e@xps-13>
        <DB9PR10MB82468A8BD333B12D3FCB3C43F1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
        <ZTujIs2O+GYKIPlU@smile.fi.intel.com>
        <DB9PR10MB8246A77EE4E7140E845D82FAF1DCA@DB9PR10MB8246.EURPRD10.PROD.OUTLOOK.COM>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eberhard,

eberhard.stoll@kontron.de wrote on Fri, 27 Oct 2023 12:41:23 +0000:

> Hello,
>=20
> > > > Can you be more specific? I am wondering how big the need is. =20
> > >
> > > In our case it's a QSPI NAND chip (Winbond W25N02KV). This device
> > > can operate at 104MHz SPI clock. But it also has a tCLQV value of 7ns.
> > > The tCLQV value limits the SPI clock speed for this device to 2x7ns
> > > (if it is not adjustable in the SPI controller) which is approximately
> > > 70MHz.
> > >
> > > Without the ability to set the tCLQV value, the SPI clock has to be
> > > limited to 70MHz in device tree for this bus.
> > >
> > > In our case the Winbond W25N02KV chip is a replacement of an
> > > older chip. The older chip can operate at 104MHz and does not
> > > have the tCLQV restrictions as this new one.
> > > The new chip is mostly is better than the data sheet and meet the
> > > timing requirements for 104MHz. But on higher temperatures
> > > devices fail.
> > >
> > > In device tree QSPI NAND chips are configured by a compatible
> > > property of 'spi-nand'. The mtd layer detects the real device
> > > and fetches the properties of this device from the appropriate
> > > driver.
> > >
> > > So for our case (boards containing the old and new chip) we well
> > > have to reduce the SPI clock for the entire QSPI bus to 70MHz, even
> > > for the elder chips which can operate well also with 104MHz. =20
> >=20
> > So, to me sounds like device tree source issue. I.e. you need to provide
> > different DT(b)s depending on the platform (and how it should be).
> > The cleanest solution (as I see not the first time people I trying quir=
ks like
> > this to be part of the subsystems / drivers) is to make DT core (OF) to=
 have
> > conditionals or boot-time modifications allowed. =20
>=20
> We don't talk about device tree modifications on boot time!
>=20
> Currently the SPI NAND chips are not fully configured in the device
> tree data. Today a QSPI NAND is represented by an abstract 'compatible' e=
ntry
> of 'spi-nand' in device tree. Which can be seen as something like a 'spi-=
nand'
> bus with autodetection of the connected chips.
>=20
> Therefore there is no way to reference a QSPI NAND chip directly, it's
> auto-detected by the framework. There is also currently no possibility to
> set the tCLQV parameter for a single SPI CS line.
>=20
> Some parameters for the SPI NAND chips are already provided only by
> the fitting chip driver (e.g. flash layout, banks, variants of the command
> set of the device, ...). With this patchset it's now possible to provide =
also
> the tCLQV data for this chip.
>=20
> IMHO a autodetect system does not make much sense if you have to provide
> parts of the chip configuration also in device tree. The framework should
> detect the chip and fetch the operation parameters either from the chip
> itself or from a chip driver which provides the required configuration se=
ttings.

Yes, if the information is discoverable, we should propagate it to the
spi layer so that the relevant action is taken, from the most desirable
to the less desirable:
- adapting the sampling point
- lowering the bus frequency
- refusing the probe if none of these solutions are possible

Can you update your patchset with this in mind?

Thanks,
Miqu=C3=A8l
