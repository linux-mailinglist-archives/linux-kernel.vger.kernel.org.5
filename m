Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940CA772681
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjHGNtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjHGNtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:49:21 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582D1BE8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:49:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E5AD4000F;
        Mon,  7 Aug 2023 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691416148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RmG+l8qINODDTiGG771G1Op/k2KxmtMEP1AeQ5xc374=;
        b=eDlXHeO6wXBcjU04Ckj6VJ4rPbcVnhqkgnvved/CP4kfyJngFRbbRMNq0lTkfD3Q+7vdi5
        GUZYu2a2EtH1KjjV5UInu1wpTrDP/Y2LZK3yGYvyzMH+DUDv+dzfw+jWrklmm1iF6L+TuP
        n7v0/5PoNSInUlPYfOOZYF/IQ08zihAso0P8yEJgD+xlFXzod+jWlgXP4NeG6JBoXBM+ul
        k+0tPg/eDwlbrn+hoo1Mw+f5riXo9X2HRDRjdemTruQlkw2u0ccd8sJLN1r4lkIc8BtoU1
        IkD32bgSNPviG/h4ezh2XsRmA3oBzNwxZ/8I0eEr6EmCqbNwCCNk45qR9hWHcA==
Date:   Mon, 7 Aug 2023 15:49:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 07/41] mtd: spi-nor: store .n_banks in struct
 spi_nor_flash_parameter
Message-ID: <20230807154906.45aefc2c@xps-13>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-7-3d3d5bef4ba4@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
        <20230807-mtd-flash-info-db-rework-v1-7-3d3d5bef4ba4@kernel.org>
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

mwalle@kernel.org wrote on Mon, 07 Aug 2023 15:21:01 +0200:

> First, fixups might want to replace the n_banks parameter, thus we need
> it in the (writable) parameter struct. Secondly, this way we can have a
> default in the core and just skip setting the n_banks in the flash_info
> database. Most of the flashes doesn't have more than one bank.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/mtd/spi-nor/core.c | 7 ++++---
>  drivers/mtd/spi-nor/core.h | 2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 138bc1e0a67c..ea94fb0da1e5 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2861,7 +2861,7 @@ static void spi_nor_init_flags(struct spi_nor *nor)
>  	if (flags & NO_CHIP_ERASE)
>  		nor->flags |=3D SNOR_F_NO_OP_CHIP_ERASE;
> =20
> -	if (flags & SPI_NOR_RWW && nor->info->n_banks > 1 &&
> +	if (flags & SPI_NOR_RWW && nor->params->n_banks > 1 &&
>  	    !nor->controller_ops)
>  		nor->flags |=3D SNOR_F_RWW;
>  }
> @@ -2925,8 +2925,8 @@ static int spi_nor_late_init_params(struct spi_nor =
*nor)
>  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
>  		spi_nor_init_default_locking_ops(nor);
> =20
> -	if (nor->info->n_banks > 1)
> -		params->bank_size =3D div64_u64(params->size, nor->info->n_banks);
> +	if (params->n_banks > 1)
> +		params->bank_size =3D div64_u64(params->size, params->n_banks);
> =20
>  	return 0;
>  }
> @@ -2996,6 +2996,7 @@ static void spi_nor_init_default_params(struct spi_=
nor *nor)
>  	params->size =3D info->size;
>  	params->bank_size =3D params->size;
>  	params->page_size =3D info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
> +	params->n_banks =3D info->n_banks;
> =20
>  	if (!(info->flags & SPI_NOR_NO_FR)) {
>  		/* Default to Fast Read for DT and non-DT platform devices. */
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 25bc18197614..fe1ce232a6c8 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -358,6 +358,7 @@ struct spi_nor_otp {
>   *			in octal DTR mode.
>   * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
>   *			command in octal DTR mode.
> + * @n_banks:		the number of banks.

just "number of banks" would make it, but that's nitpicking.

>   * @n_dice:		number of dice in the flash memory.
>   * @vreg_offset:	volatile register offset for each die.
>   * @hwcaps:		describes the read and page program hardware
> @@ -394,6 +395,7 @@ struct spi_nor_flash_parameter {
>  	u8				addr_mode_nbytes;
>  	u8				rdsr_dummy;
>  	u8				rdsr_addr_nbytes;
> +	u8				n_banks;
>  	u8				n_dice;
>  	u32				*vreg_offset;
> =20
>=20

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miqu=C3=A8l
