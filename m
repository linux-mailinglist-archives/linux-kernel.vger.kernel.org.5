Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D26772676
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjHGNsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjHGNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:48:28 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE610DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:48:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFCF31C0008;
        Mon,  7 Aug 2023 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691416075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sgpG9tc96RXAVrisVjb1ZlL6kzhbThzQ6qjQYGBJXDE=;
        b=TcK/Qaf6BTFBfmi0nKENimcG8cRbDvwZmNIJOV7uL9WiUwWXtLBDlIap8QQZ+Rxmsw9Kr8
        c9DvDaTNGJ7jYloYQCoL0KYqquyxJyb52pWB1YfJIOn7JPRxh83ijtj+WHLstyh5d1HiZb
        L4W+NJpnoCJck3F+4mBXPUMMUfr+9YoTXwTmj2Btsey8lUs2r6kMSmoeREZ5gdoU/VbSOv
        XD60PWfl0qKgZNdwAff6C/yz/fkBmhkLvACUGy5bl6l148wqdl77TYgduQITBadwR3aJKn
        jv1GCoApA6ZSDXekfzV/TLZSMuUaw/VPMyASEC3tIB+yjf271ud9aXVx/wYlCA==
Date:   Mon, 7 Aug 2023 15:47:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 06/41] mtd: spi-nor: default page_size to 256 bytes
Message-ID: <20230807154754.70e994fa@xps-13>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-6-3d3d5bef4ba4@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
        <20230807-mtd-flash-info-db-rework-v1-6-3d3d5bef4ba4@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

mwalle@kernel.org wrote on Mon, 07 Aug 2023 15:21:00 +0200:

> The INFO() macro always set the page_size to 256 bytes. Make that an
> optinal parameter. This default is a sane one for all older flashes,

optional

> newer ones will set the page size by its SFDP tables anyway.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c | 7 +------
>  drivers/mtd/spi-nor/core.h | 8 ++++++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index c504a5af4032..138bc1e0a67c 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2017,11 +2017,6 @@ static const struct spi_nor_manufacturer *manufact=
urers[] =3D {
>  static const struct flash_info spi_nor_generic_flash =3D {
>  	.name =3D "spi-nor-generic",
>  	.n_banks =3D 1,
> -	/*
> -	 * JESD216 rev A doesn't specify the page size, therefore we need a
> -	 * sane default.
> -	 */
> -	.page_size =3D 256,
>  	.parse_sfdp =3D true,
>  };
> =20
> @@ -3000,7 +2995,7 @@ static void spi_nor_init_default_params(struct spi_=
nor *nor)
>  	params->writesize =3D 1;
>  	params->size =3D info->size;
>  	params->bank_size =3D params->size;
> -	params->page_size =3D info->page_size;
> +	params->page_size =3D info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;

Would you mind clarifying this? It does not look right, while
perhaps it is. But TBH, I have no idea what params->page_size will be
after this assignment.

> =20
>  	if (!(info->flags & SPI_NOR_NO_FR)) {
>  		/* Default to Fast Read for DT and non-DT platform devices. */
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 12c35409493b..25bc18197614 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -10,6 +10,11 @@
>  #include "sfdp.h"
> =20
>  #define SPI_NOR_MAX_ID_LEN	6
> +/*
> + * 256 bytes is a sane default for most older flashes. Newer flashes will
> + * have the page size defined within their SFDP tables.
> + */
> +#define SPI_NOR_DEFAULT_PAGE_SIZE 256
> =20
>  /* Standard SPI NOR flash operations. */
>  #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
> @@ -447,7 +452,7 @@ struct spi_nor_fixups {
>   * @sector_size:    the size listed here is what works with SPINOR_OP_SE=
, which
>   *                  isn't necessarily called a "sector" by the vendor.
>   * @n_banks:        the number of banks.
> - * @page_size:      the flash's page size.
> + * @page_size:      (optional) the flash's page size. Defaults to 256.
>   * @addr_nbytes:    number of address bytes to send.
>   *
>   * @parse_sfdp:     true when flash supports SFDP tables. The false valu=
e has no
> @@ -558,7 +563,6 @@ struct flash_info {
>  #define SPI_NOR_GEOMETRY(_sector_size, _n_sectors, _n_banks)		\
>  	.size =3D (_sector_size) * (_n_sectors),				\
>  	.sector_size =3D (_sector_size),					\
> -	.page_size =3D 256,						\
>  	.n_banks =3D (_n_banks)
> =20
>  /* Used when the "_ext_id" is two bytes at most */
>=20

Otherwise, lgtm.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l
