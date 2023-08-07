Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18C77268E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjHGNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjHGNvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:51:23 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517E6E79
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:51:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0600240007;
        Mon,  7 Aug 2023 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691416279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktn/E2TMTobEbahcoWB8iS3oHsRaWzFkcZKnVtcZ+lQ=;
        b=C8NUcX7sbrIT1NfME3Ih4AIey2goRXwF08YG5a+jPwaMFI0qu3W2JT3Mze1+rOtd8fCImG
        pVcSvpdqhKuc6aiN3hGrV/EaCI6wJHxZoGIPTawPcgAKkRcaMrV+/DKWLzz5kCRfqprM6u
        Uc4IW2aXiEkGrnbgNmTc26OrTl9xJtA8oVNXQc5+JQnitSo9wrIGja5dcE9YcQ85XvFXtX
        47nQlqPufc3RG+YqKv/+P8958vfLF2kHfpOsLYXMdgoFTJyXJ4x1Lt9KbX99Yj8bn0XyXk
        K62lHHs1VogU1MUmBSsIKNCCiEuTDSF3vjcpR7i09nfmQThQdbanGLPyUWBuqA==
Date:   Mon, 7 Aug 2023 15:51:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 08/41] mtd: spi-nor: default .n_banks to 1
Message-ID: <20230807155117.704f4401@xps-13>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-8-3d3d5bef4ba4@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
        <20230807-mtd-flash-info-db-rework-v1-8-3d3d5bef4ba4@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

mwalle@kernel.org wrote on Mon, 07 Aug 2023 15:21:02 +0200:

> If .n_banks is not set in the flash_info database, the default value
> should be 1. This way, we don't have to always set the .n_banks
> parameter in flash_info.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c   | 3 +--
>  drivers/mtd/spi-nor/core.h   | 8 ++++----
>  drivers/mtd/spi-nor/xilinx.c | 1 -
>  3 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ea94fb0da1e5..015152ba8973 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2016,7 +2016,6 @@ static const struct spi_nor_manufacturer *manufactu=
rers[] =3D {
> =20
>  static const struct flash_info spi_nor_generic_flash =3D {
>  	.name =3D "spi-nor-generic",
> -	.n_banks =3D 1,
>  	.parse_sfdp =3D true,
>  };
> =20
> @@ -2996,7 +2995,7 @@ static void spi_nor_init_default_params(struct spi_=
nor *nor)
>  	params->size =3D info->size;
>  	params->bank_size =3D params->size;
>  	params->page_size =3D info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
> -	params->n_banks =3D info->n_banks;
> +	params->n_banks =3D info->n_banks ?: SPI_NOR_DEFAULT_N_BANKS;

Same here, I'm not against ternary operators at all, but the=20

	? /* nothing */ : <something>

form is strange.

> =20
>  	if (!(info->flags & SPI_NOR_NO_FR)) {
>  		/* Default to Fast Read for DT and non-DT platform devices. */
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index fe1ce232a6c8..c90445e186c0 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -15,6 +15,7 @@
>   * have the page size defined within their SFDP tables.
>   */
>  #define SPI_NOR_DEFAULT_PAGE_SIZE 256
> +#define SPI_NOR_DEFAULT_N_BANKS 1
> =20
>  /* Standard SPI NOR flash operations. */
>  #define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
> @@ -453,7 +454,7 @@ struct spi_nor_fixups {
>   * @size:           the size of the flash in bytes.
>   * @sector_size:    the size listed here is what works with SPINOR_OP_SE=
, which
>   *                  isn't necessarily called a "sector" by the vendor.
> - * @n_banks:        the number of banks.
> + * @n_banks:        (optional) the number of banks. Defaults to 1.
>   * @page_size:      (optional) the flash's page size. Defaults to 256.
>   * @addr_nbytes:    number of address bytes to send.
>   *
> @@ -570,7 +571,7 @@ struct flash_info {
>  /* Used when the "_ext_id" is two bytes at most */
>  #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
>  	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
> -	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
> +	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
> =20
>  #define INFOB(_jedec_id, _ext_id, _sector_size, _n_sectors, _n_banks)	\
>  	SPI_NOR_ID((_jedec_id), (_ext_id)),				\
> @@ -578,13 +579,12 @@ struct flash_info {
> =20
>  #define INFO6(_jedec_id, _ext_id, _sector_size, _n_sectors)		\
>  	SPI_NOR_ID6((_jedec_id), (_ext_id)),				\
> -	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 1),
> +	SPI_NOR_GEOMETRY((_sector_size), (_n_sectors), 0),
> =20
>  #define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_nbytes)	\
>  		.size =3D (_sector_size) * (_n_sectors),			\
>  		.sector_size =3D (_sector_size),				\
>  		.page_size =3D (_page_size),				\
> -		.n_banks =3D 1,						\
>  		.addr_nbytes =3D (_addr_nbytes),				\
>  		.flags =3D SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
> =20
> diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
> index 284e2e4970ab..8d4539e32dfe 100644
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ b/drivers/mtd/spi-nor/xilinx.c
> @@ -26,7 +26,6 @@
>  		.size =3D 8 * (_page_size) * (_n_sectors),		\
>  		.sector_size =3D (8 * (_page_size)),			\
>  		.page_size =3D (_page_size),				\
> -		.n_banks =3D 1,						\
>  		.flags =3D SPI_NOR_NO_FR
> =20
>  /* Xilinx S3AN share MFR with Atmel SPI NOR */
>=20

But otherwise

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l
