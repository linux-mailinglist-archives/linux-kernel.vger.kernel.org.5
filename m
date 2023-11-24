Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451F87F6F19
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjKXJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:06:56 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8641BD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:07:01 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1DF50240013;
        Fri, 24 Nov 2023 09:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700816820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcaWZO0Dkmbqcz5MfADesr8jRHXPKhmFcuSLiJu9N6c=;
        b=OxWvtk/PaHumDm4DrHkspMlPL9mIMLBuTz4yXJb5tYm/lJVB/J3hTg1v00iw0ZgEPpeLeq
        0uRC5uy7xD5LueyouRR6+Er3w04yEgkLq5XZoEsFmy6oebOB/45j/tj237CsroX4aXNqKE
        ftiQvBgxZlbh3l8wsYFwFdMs+x6dhO7nSwPy/5SOgYvBJIsb1lF3exerDASnSOi9fCpIa3
        4vONdWZP717ZLGgAQpSh1K+bV4dSF1rgmVKxJzEUwDdbBG2fFFXJ5+9HKEqOJcfnZ4gnxb
        wAB0yZar5TpeAXH8yhRZnJXNKV52DEZ3hYSVBjZ7fJRN+P4FGaqOOy/MEUPrHA==
Date:   Fri, 24 Nov 2023 10:06:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Viacheslav Bocharov <adeep@lexina.in>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: rawnand: meson: handle OOB buffer according OOB
 layout
Message-ID: <20231124100657.245d258f@xps-13>
In-Reply-To: <ab3f6734-357c-9937-2e21-a935850d3af8@salutedevices.com>
References: <20231109053953.3863664-1-avkrasnov@salutedevices.com>
        <5a82e3b96c94b45821707eb5d392384e1a026c2e.camel@lexina.in>
        <98c5a6ef-3865-9254-0af7-2d041a64d368@salutedevices.com>
        <ab3f6734-357c-9937-2e21-a935850d3af8@salutedevices.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

avkrasnov@salutedevices.com wrote on Fri, 24 Nov 2023 10:50:54 +0300:

> Hello all, 2 weeks from 9.11, please ping

I'm waiting for Viacheslav.

>=20
> Thanks, Arseniy
>=20
>=20
> On 09.11.2023 12:09, Arseniy Krasnov wrote:
> > Hello, thanks for review!
> >=20
> > On 09.11.2023 11:06, Viacheslav Bocharov wrote: =20
> >> Hi!
> >>
> >> On Thu, 2023-11-09 at 08:39 +0300, Arseniy Krasnov wrote: =20
> >>> In case of MTD_OPS_AUTO_OOB mode, MTD/NAND layer fills/reads OOB buff=
er
> >>> according current OOB layout so we need to follow it in the driver.
> >>>
> >>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >>> ---
> >>>  drivers/mtd/nand/raw/meson_nand.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw=
/meson_nand.c
> >>> index 561d46d860b7..0d4d358152d7 100644
> >>> --- a/drivers/mtd/nand/raw/meson_nand.c
> >>> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >>> @@ -510,7 +510,7 @@ static void meson_nfc_set_user_byte(struct nand_c=
hip *nand, u8 *oob_buf)
> >>>  	__le64 *info;
> >>>  	int i, count;
> >>> =20
> >>> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> >>> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (2 =
+ nand->ecc.bytes)) {
> >>>  		info =3D &meson_chip->info_buf[i];
> >>>  		*info |=3D oob_buf[count];
> >>>  		*info |=3D oob_buf[count + 1] << 8; =20
> >> Seems something wrong with your logic here.
> >> I think this code should most likely look like this:
> >>
> >> for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D nand->=
ecc.bytes) {
> >>     info =3D &meson_chip->info_buf[i];
> >>     *info |=3D oob_buf[count];
> >>     if (nand->ecc.bytes > 1)
> >>       *info |=3D oob_buf[count + 1] << 8;
> >> } =20
> >=20
> > For 64 bytes OOB and 512 bytes ECC this driver reports free areas as:
> >=20
> > AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> > AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> > AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> > AA AA BB BB BB BB BB BB BB BB BB BB BB BB BB BB
> >=20
> > where AA is free byte(user byte), BB - ECC codes. So to access user byt=
es
> > we need bytes 0,1,16,17,32,33,48,49. nand->ecc.bytes =3D=3D 14, so 'cou=
nt' is
> > increased at 16 every iteration, so i guess this is correct.
> >=20
> > WDYT?
> >=20
> > Thanks, Arseniy
> >  =20
> >>
> >> =20
> >>> @@ -523,7 +523,7 @@ static void meson_nfc_get_user_byte(struct nand_c=
hip *nand, u8 *oob_buf)
> >>>  	__le64 *info;
> >>>  	int i, count;
> >>> =20
> >>> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> >>> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (2 =
+ nand->ecc.bytes)) {
> >>>  		info =3D &meson_chip->info_buf[i];
> >>>  		oob_buf[count] =3D *info;
> >>>  		oob_buf[count + 1] =3D *info >> 8; =20
> >> And there:
> >>
> >> for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D nand->=
ecc.bytes) {
> >>     info =3D &meson_chip->info_buf[i];
> >>     oob_buf[count] =3D *info;
> >>     if (nand->ecc.bytes > 1)
> >>         oob_buf[count + 1] =3D *info >> 8;
> >> }
> >>
> >>
> >> This is more similar to the behavior of similar functions in the propr=
ietary U-Boot.
> >>
> >> --
> >> Viacheslav Bocharov
> >> =20


Thanks,
Miqu=C3=A8l
