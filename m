Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7E80E65B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjLLIhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjLLIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:37:04 -0500
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF82DF5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:35:55 -0800 (PST)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1215:0:640:367b:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 2008D60E55;
        Tue, 12 Dec 2023 11:35:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id lZdPDeDm3mI0-qcIIANXy;
        Tue, 12 Dec 2023 11:35:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
        t=1702370150; bh=2R9S6QInVyV5OaAGIjzNQBpof2xW+CkJZHvkJhjTMPA=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=Jwi0lm3I8K+jy4ugTFlxO+3gwwno5KvIGe95adUOeoDMa25zx4oZRZ3iRTwZOlw4v
         REn8SQfXyiXOc4xzH4AwKJnlKW0hrtyylyxPnKtYEvBax42WG4z551B1LzhfjQgGXt
         20WD3K0pYyKDLglIl3zXmydVaoktBfJpoSqLbcjM=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <29970d694d155dee0c76612f453eaa06a929e2c1.camel@maquefel.me>
Subject: Re: [PATCH v6 20/40] mtd: rawnand: add support for ts72xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
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
Date:   Tue, 12 Dec 2023 11:35:48 +0300
In-Reply-To: <2023121220-shine-caviar-68dc@gregkh>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
         <20231212-ep93xx-v6-20-c307b8ac9aa8@maquefel.me>
         <2023121220-shine-caviar-68dc@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg!

On Tue, 2023-12-12 at 09:30 +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 12, 2023 at 11:20:37AM +0300, Nikita Shubin via B4 Relay
> wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Technologic Systems has it's own nand controller implementation in
> > CPLD.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0drivers/mtd/nand/raw/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> > =C2=A0drivers/mtd/nand/raw/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/mtd/nand/raw/technologic-nand-controller.c | 220
> > +++++++++++++++++++++
> > =C2=A03 files changed, 228 insertions(+)
> >=20
> > diff --git a/drivers/mtd/nand/raw/Kconfig
> > b/drivers/mtd/nand/raw/Kconfig
> > index cbf8ae85e1ae..3937c10dea1c 100644
> > --- a/drivers/mtd/nand/raw/Kconfig
> > +++ b/drivers/mtd/nand/raw/Kconfig
> > @@ -449,6 +449,13 @@ config MTD_NAND_RENESAS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enables support =
for the NAND controller found on Renesas
> > R-Car
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Gen3 and RZ/N1 S=
oC families.
> > =C2=A0
> > +config MTD_NAND_TS72XX
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "ts72xx NAND contro=
ller"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on ARCH_EP93XX && HA=
S_IOMEM
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Enables support for N=
AND controller on ts72xx SBCs.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is a legacy driv=
er based on gen_nand.
>=20
> Why is a new "legacy driver" being written these days?=C2=A0 Why not do i=
t
> properly?

Sorry, my bad, description is a leftover from older description (when i
was allowed to submit a legacy one).

The driver is mostly new, shiny and approved by Miquel:

https://lore.kernel.org/lkml/20231004103911.2aa65354@xps-13/

The KConfig description should be fixed.

>=20
> thanks,
>=20
> greg k-h

