Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B0F7B4F52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjJBJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjJBJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:45:09 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82084BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:45:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58CD2240012;
        Mon,  2 Oct 2023 09:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696239905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iRukAf2u3WRWfmx+HCNdHblYYcJv+Zb9WqDcKGDdaw4=;
        b=PvJ/8QH0yMf/nAAi/XQOuBdImhyM8dVHnNnXFqU/UP5EOA9fWJLKNXiQpTxQ+MchTq3Nkc
        Fe7m9lruD32WCFl8t6ooHSDChiU5QrcLP+R5Py6hBvlYz96ImWssErOzw3Di7bogHvdM+h
        73bjsOoxGOgrs6sPs1y+pXaEsHSdAu9K359Wquy9D2fDUKinDi6RSziy+oBI5FOI8KRTDL
        R7C9jumlUnHGZp50TnXfQfi42KCYCaOMsUvl4XPVEJR7iGLBwrTtmA76SFCE5X5ePTw9I8
        IZtGUF1y1alpQePBAz2Q5m4wr1x3JntnqKEHI/LyyN441us2ZYrxwIYSdzJmpA==
Date:   Mon, 2 Oct 2023 11:44:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] mtd: spinand: add support for FORESEE F35SQA002G
Message-ID: <20231002114450.4ce69141@xps-13>
In-Reply-To: <20230929144934.192649-1-mmkurbanov@salutedevices.com>
References: <20230929144934.192649-1-mmkurbanov@salutedevices.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

mmkurbanov@salutedevices.com wrote on Fri, 29 Sep 2023 17:49:34 +0300:

> Add support for FORESEE F35SQA002G SPI NAND.
> Datasheet:
>   https://www.longsys.com/uploads/LM-00006FORESEEF35SQA002GDatasheet_1650=
183701.pdf
>=20
> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> ---
>  drivers/mtd/nand/spi/Makefile  |   2 +-
>  drivers/mtd/nand/spi/core.c    |   1 +
>  drivers/mtd/nand/spi/foresee.c | 101 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |   1 +
>  4 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/foresee.c
>=20
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index cd8b66bf7740..19cc77288ebb 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs :=3D core.o alliancememory.o ato.o esmt.o gigadevice.o macr=
onix.o
> +spinand-objs :=3D core.o alliancememory.o ato.o esmt.o foresee.o gigadev=
ice.o macronix.o
>  spinand-objs +=3D micron.o paragon.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 393ff37f0d23..849ccfedbc72 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -940,6 +940,7 @@ static const struct spinand_manufacturer *spinand_man=
ufacturers[] =3D {
>  	&alliancememory_spinand_manufacturer,
>  	&ato_spinand_manufacturer,
>  	&esmt_c8_spinand_manufacturer,
> +	&foresee_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/forese=
e.c
> new file mode 100644
> index 000000000000..55d4ff1f091a
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/foresee.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + *
> + * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_FORESEE		0xCD
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int f35sqa002g_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				    struct mtd_oob_region *region)
> +{
> +	return -ERANGE;
> +}
> +
> +static int f35sqa002g_ooblayout_free(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *region)
> +{
> +	/* XXX: It is not possible to partially write to this OOB area, as both
> +	 * the main and OOB areas are protected by ECC. The user needs to
> +	 * program both the main area and OOB area at one programming time,
> +	 * so that the ECC parity code can be calculated properly.
> +	 */

Is this comment really needed? I believe it could be dropped, unless
you are really experiencing strange subpage write attempts?

> +
> +	if (section)
> +		return -ERANGE;
> +
> +	/* Reserve 2 bytes for the BBM. */
> +	region->offset =3D 2;
> +	region->length =3D 62;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops f35sqa002g_ooblayout =3D {
> +	.ecc =3D f35sqa002g_ooblayout_ecc,
> +	.free =3D f35sqa002g_ooblayout_free,
> +};
> +
> +static int f35sqa002g_ecc_get_status(struct spinand_device *spinand, u8 =
status)
> +{
> +	struct nand_device *nand =3D spinand_to_nand(spinand);
> +
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		return nanddev_get_ecc_conf(nand)->strength;
> +
> +	default:
> +		break;
> +	}
> +
> +	/* More than 1-bit error was detected in one or more sectors and
> +	 * cannot be corrected.
> +	 */
> +	return -EBADMSG;
> +}
> +
> +static const struct spinand_info foresee_spinand_table[] =3D {
> +	SPINAND_INFO("F35SQA002G",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x72, 0x72),
> +		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
> +				     f35sqa002g_ecc_get_status)),
> +};
> +
> +static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops =
=3D {
> +};
> +
> +const struct spinand_manufacturer foresee_spinand_manufacturer =3D {
> +	.id =3D SPINAND_MFR_FORESEE,
> +	.name =3D "FORESEE",
> +	.chips =3D foresee_spinand_table,
> +	.nchips =3D ARRAY_SIZE(foresee_spinand_table),
> +	.ops =3D &foresee_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 3e285c09d16d..badb4c1ac079 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -263,6 +263,7 @@ struct spinand_manufacturer {
>  extern const struct spinand_manufacturer alliancememory_spinand_manufact=
urer;
>  extern const struct spinand_manufacturer ato_spinand_manufacturer;
>  extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
> +extern const struct spinand_manufacturer foresee_spinand_manufacturer;
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;

Otherwise looks good.

Thanks,
Miqu=C3=A8l
