Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80680EE58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376443AbjLLOFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376427AbjLLOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:05:48 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02DFD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:05:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BFF8E0002;
        Tue, 12 Dec 2023 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702389952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VgCEu9GpjqJrf+SumYZk2dGW/A3Nbxfr4XJ0APRxZs=;
        b=BQnsfRN2Q+kLg7bzZvez/qL4QLdRn+pFSg8c1FZ/YF2OVoSyOJAj1R6rwt0uDPArfPQ3vV
        6wdhNvf3KCjEprppYqoafwkNdoW9n8zC5mkOJ4TruaZba/r3rWnjcary3RAVnMeqrwGHf2
        tfRDonIUwsxe0kJXcaeSsZjgLkEPIZ2/EcZ4THs/4O+YwD7pB0ouWUpBm7Bp+h0TN3teAq
        xA6Ylq/MDwHbsgTawPYFosctRZgN0KQoQFMoRG1wloIzW/QPSq33RUetApKQRLloBfti8+
        qiTksBELzNZlWb7dslWsuonqffvdoh05NNtouedFOAgHf3Q5fPTJQRZv1sDHlQ==
Date:   Tue, 12 Dec 2023 15:05:45 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Johan Jonker <jbx6244@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v6 20/40] mtd: rawnand: add support for ts72xx
Message-ID: <20231212150545.61806147@xps-13>
In-Reply-To: <29970d694d155dee0c76612f453eaa06a929e2c1.camel@maquefel.me>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
        <20231212-ep93xx-v6-20-c307b8ac9aa8@maquefel.me>
        <2023121220-shine-caviar-68dc@gregkh>
        <29970d694d155dee0c76612f453eaa06a929e2c1.camel@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

nikita.shubin@maquefel.me wrote on Tue, 12 Dec 2023 11:35:48 +0300:

> Hello Greg!
>=20
> On Tue, 2023-12-12 at 09:30 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 12, 2023 at 11:20:37AM +0300, Nikita Shubin via B4 Relay
> > wrote: =20
> > > From: Nikita Shubin <nikita.shubin@maquefel.me>
> > >=20
> > > Technologic Systems has it's own nand controller implementation in
> > > CPLD.
> > >=20
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > ---
> > > =C2=A0drivers/mtd/nand/raw/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> > > =C2=A0drivers/mtd/nand/raw/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/mtd/nand/raw/technologic-nand-controller.c | 220
> > > +++++++++++++++++++++
> > > =C2=A03 files changed, 228 insertions(+)
> > >=20
> > > diff --git a/drivers/mtd/nand/raw/Kconfig
> > > b/drivers/mtd/nand/raw/Kconfig
> > > index cbf8ae85e1ae..3937c10dea1c 100644
> > > --- a/drivers/mtd/nand/raw/Kconfig
> > > +++ b/drivers/mtd/nand/raw/Kconfig
> > > @@ -449,6 +449,13 @@ config MTD_NAND_RENESAS
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enables suppor=
t for the NAND controller found on Renesas
> > > R-Car
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Gen3 and RZ/N1=
 SoC families.
> > > =C2=A0
> > > +config MTD_NAND_TS72XX
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "ts72xx NAND cont=
roller"
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on ARCH_EP93XX && =
HAS_IOMEM
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enables support for=
 NAND controller on ts72xx SBCs.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is a legacy dr=
iver based on gen_nand. =20
> >=20
> > Why is a new "legacy driver" being written these days?=C2=A0 Why not do=
 it
> > properly? =20
>=20
> Sorry, my bad, description is a leftover from older description (when i
> was allowed to submit a legacy one).
>=20
> The driver is mostly new, shiny and approved by Miquel:
>=20
> https://lore.kernel.org/lkml/20231004103911.2aa65354@xps-13/
>=20
> The KConfig description should be fixed.

Indeed, later submissions carried a brand new implementation which no
longer leverages any legacy hook. The Kconfig description is wrong,
good catch.

Thanks,
Miqu=C3=A8l
