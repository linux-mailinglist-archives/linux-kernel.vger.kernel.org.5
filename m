Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EECF78422A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjHVNgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjHVNgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:36:02 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5367C184
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:36:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBDAF1C0002;
        Tue, 22 Aug 2023 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692711358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQhC2oeF//IEqu7mwmb78usJ0wdWGcj8FRhKl534ndU=;
        b=Urgs5+raZ7GIN9HmsjJ2XCsMNojvcMCf0zDI1kG9e4FobGW3GfRpRPFYKx5Uf7eDl7f7k4
        IyWIyB9D1JHAKC2jCk6/8W4gFeYp44woXXxY/xt26hpExAhySy8kqD34CWaHeYJYnZ8VDu
        uIBZRIOSHnWFnpVFwBVlMetYMvYdN5SjKltLiyh9OF/rlyVHk8sa3t7iha6wrQ3znbkF/Y
        1mhqkSvYQTviWAU5MnhLvqh7v/LpKBzsbWU8hNLBfG6r+avveXgdnNWPc9kUwMGqfPHmkR
        49COpekj/f2nf7NPV5h5bNuGsXEeWEU5yWfRUG8JWvEyS0bv9Kk06MeRPpB+JA==
Date:   Tue, 22 Aug 2023 15:35:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 2/2] mtd: spinand: micron: fixing the offset for OOB
Message-ID: <20230822153556.630e65b9@xps-13>
In-Reply-To: <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
References: <20230822122534.872646-1-mmkurbanov@sberdevices.ru>
        <20230822122534.872646-3-mmkurbanov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

mmkurbanov@sberdevices.ru wrote on Tue, 22 Aug 2023 15:25:34 +0300:

> The first 4 bytes are reserved for bad block data.

Are you sure about that? I've never seen 4-bytes BBM.

> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>  drivers/mtd/nand/spi/micron.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 12601bc4227a..64b41c7c9cce 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -57,6 +57,20 @@ static SPINAND_OP_VARIANTS(x1_write_cache_variants,
>  static SPINAND_OP_VARIANTS(x1_update_cache_variants,
>  			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
> =20
> +/*
> + * OOB spare area map (128 and 256 bytes)
> + *
> + *           +-----+-----------------+-------------------+--------------=
-------+
> + *           | BBM |     Non ECC     |   ECC protected   |      ECC Area=
       |
> + *           |     | protected Area  |       Area        |              =
       |
> + * ----------+-----+-----------------+-------------------+--------------=
-------+
> + *  oobsize  | 0:3 | 4:31 (28 bytes) | 32:63 (32 bytes)  | 64:127 (64 by=
tes)   |
> + * 128 bytes |     |                 |                   |              =
       |
> + * ----------+-----+-----------------+-------------------+--------------=
-------+
> + *  oobsize  | 0:3 | 4:63 (60 bytes) | 64:127 (64 bytes) | 127:255 (128 =
bytes) |
> + * 256 bytes |     |                 |                   |              =
       |
> + * ----------+-----+-----------------+-------------------+--------------=
-------+
> + */
>  static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
>  {
> @@ -75,9 +89,9 @@ static int micron_8_ooblayout_free(struct mtd_info *mtd=
, int section,
>  	if (section)
>  		return -ERANGE;
> =20
> -	/* Reserve 2 bytes for the BBM. */
> -	region->offset =3D 2;
> -	region->length =3D (mtd->oobsize / 2) - 2;
> +	/* Reserve 4 bytes for the BBM. */
> +	region->offset =3D 4;
> +	region->length =3D (mtd->oobsize / 2) - 4;
> =20
>  	return 0;
>  }


Thanks,
Miqu=C3=A8l
