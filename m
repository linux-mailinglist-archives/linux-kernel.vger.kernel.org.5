Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB957E64E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjKIIHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjKIIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:07:07 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC202D4F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:07:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2331150353;
        Thu,  9 Nov 2023 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1699517222; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=R+Cskg0Zlf2z6oSgOHmCw4RtbIi3Vlboh4OLjWOc198=;
        b=BCCljUJq/AJBA5kbkykFWado6JzsjJtD6qn7ZxFQCTvcTJqYwODjBGzZnSi/jrFW0pVbS8
        Q+cCZz09QrZtTbvcPgAtyWvY34kbu+a55iEQS7c50++aKNwnViBYw1krzaeZVnU+Od/RZZ
        jTT0u/+8k8lor6m1Q/a17LCXSHG9uHcJR/d/NKwAJF8sK/ZBvpBp3KeJ2QDfluUIYDQz5v
        ine+4f1DCG19wklwz37nhnkJ35RKdQN9qlnS2NZ0IKXeepK22gLQyTTjXVWZjlhT1QmGFz
        0IMdLTHuLMC/+M4pMf8mN9Cb+lU49x4nzNHh8mV+Hu+vFwbDF4OtOPfdu9X20w==
Message-ID: <5a82e3b96c94b45821707eb5d392384e1a026c2e.camel@lexina.in>
Subject: Re: [PATCH v1] mtd: rawnand: meson: handle OOB buffer according OOB
 layout
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 Nov 2023 11:06:58 +0300
In-Reply-To: <20231109053953.3863664-1-avkrasnov@salutedevices.com>
References: <20231109053953.3863664-1-avkrasnov@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, 2023-11-09 at 08:39 +0300, Arseniy Krasnov wrote:
> In case of MTD_OPS_AUTO_OOB mode, MTD/NAND layer fills/reads OOB buffer
> according current OOB layout so we need to follow it in the driver.
>=20
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 561d46d860b7..0d4d358152d7 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -510,7 +510,7 @@ static void meson_nfc_set_user_byte(struct nand_chip =
*nand, u8 *oob_buf)
>  	__le64 *info;
>  	int i, count;
> =20
> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (2 + na=
nd->ecc.bytes)) {
>  		info =3D &meson_chip->info_buf[i];
>  		*info |=3D oob_buf[count];
>  		*info |=3D oob_buf[count + 1] << 8;
Seems something wrong with your logic here.
I think this code should most likely look like this:

for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D nand->ecc.b=
ytes) {
    info =3D &meson_chip->info_buf[i];
    *info |=3D oob_buf[count];
    if (nand->ecc.bytes > 1)
      *info |=3D oob_buf[count + 1] << 8;
}


> @@ -523,7 +523,7 @@ static void meson_nfc_get_user_byte(struct nand_chip =
*nand, u8 *oob_buf)
>  	__le64 *info;
>  	int i, count;
> =20
> -	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D 2) {
> +	for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D (2 + na=
nd->ecc.bytes)) {
>  		info =3D &meson_chip->info_buf[i];
>  		oob_buf[count] =3D *info;
>  		oob_buf[count + 1] =3D *info >> 8;
And there:

for (i =3D 0, count =3D 0; i < nand->ecc.steps; i++, count +=3D nand->ecc.b=
ytes) {
    info =3D &meson_chip->info_buf[i];
    oob_buf[count] =3D *info;
    if (nand->ecc.bytes > 1)
        oob_buf[count + 1] =3D *info >> 8;
}


This is more similar to the behavior of similar functions in the proprietar=
y U-Boot.

--
Viacheslav Bocharov

