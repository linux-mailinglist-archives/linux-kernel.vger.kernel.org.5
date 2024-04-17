Return-Path: <linux-kernel+bounces-148605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433B48A84FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D32FB25912
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E71411E0;
	Wed, 17 Apr 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnsCEG7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C491411D6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361159; cv=none; b=kmK4OMwXb/8u1seEzldpTyDAyqJlTNMpWSXofESDQlr8HJmH0PZlO0I0RaL6rRnYlH35eEPj7yutbKzLuHFQovVpMyyqIkV11kGn+Su2Rf6/XHiNu46nkxnkSv42WI/7YS9dui3b/NnjineZM0fpQ1TMJIpXWRM4VMCh7X5rr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361159; c=relaxed/simple;
	bh=kAGKWwtoNDjk7HSM51GJieuaIFloBqHwAmZZJVJk9bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YpB+2yv0uSVZglTb/kY43DKnutL4pe39EoqIacSabNLerlPv2dj+BfBPmywaNvArTwDsXswkQyyo4kNWc2p7WzVgz02WRmHHgAdnl2fCGANgEWXN9sonXdMuOwdtz2HVS8+oaHY6qGBEfzL8A5qXUMqwBlVwH0CLxrONN6V7ev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnsCEG7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD6C072AA;
	Wed, 17 Apr 2024 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713361159;
	bh=kAGKWwtoNDjk7HSM51GJieuaIFloBqHwAmZZJVJk9bw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YnsCEG7Pfo0YoG0nzsYFviiIuEAIOA6YuthUd8BdGqZaHQ5vzeAVtzA2Hu/Xw/Oga
	 n9DDPkvWHHW+Q8Fg9bkShSNTVbp2PeyktQF56TnKndgwrGZ2Td0VDnIZt7DBSuLdBL
	 WFHGBuHHQHFqTDRMYXbQZByPD//YoFYpf9WDXquTLdThuIG18gRRgsGxQTrCmS+4dM
	 SmPE8RJTGx2ADtjnMXjR90DWymomhgJFQhWKqQ95mT8vZzopGBaeMpxuRy94i5KPA+
	 yeH4ganCTxvFMmi4CcYS/zaVc+mzh8noVc57Qmu00550MGb7ofBqrHR/YuxgRetpe5
	 /nWS8TnIFp7gw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v1 3/6] mtd: spi-nor: get rid of SPI_NOR_NO_FR
In-Reply-To: <20240412134405.381832-4-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 12 Apr 2024 15:44:02 +0200")
References: <20240412134405.381832-1-mwalle@kernel.org>
	<20240412134405.381832-4-mwalle@kernel.org>
Date: Wed, 17 Apr 2024 15:39:16 +0200
Message-ID: <mafs0sezk6rcr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Michael,

On Fri, Apr 12 2024, Michael Walle wrote:

> The evervision FRAM devices are the only user of the NO_FR flag. Drop
> the global flag and instead use a manufacturer fixup for the evervision
> flashes to drop the fast read support.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> Please note, that the fast read opcode will still be set in
> spi_nor_init_default_params(), but the selection of the read opcodes
> just depends on the mask.

Since that is the case now, might as well drop the

    if (params->hwcaps.mask & SNOR_HWCAPS_READ_FAST)

in spi_nor_init_default_params().

>
> That is also something I want to fix soon: the opcodes can always
> be set and the drivers/SFDP will only set the mask. Opcodes then can be
> switched between 3b and 4b ones if necessary.
> ---
>  drivers/mtd/spi-nor/core.c     | 12 +++++-------
>  drivers/mtd/spi-nor/core.h     |  2 --
>  drivers/mtd/spi-nor/everspin.c | 19 +++++++++++++++----
>  3 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index fb76e0522665..65e6531ada0a 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2952,14 +2952,12 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>  	params->page_size = info->page_size ?: SPI_NOR_DEFAULT_PAGE_SIZE;
>  	params->n_banks = info->n_banks ?: SPI_NOR_DEFAULT_N_BANKS;
>  
> -	if (!(info->flags & SPI_NOR_NO_FR)) {
> -		/* Default to Fast Read for DT and non-DT platform devices. */
> -		params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
> +	/* Default to Fast Read for DT and non-DT platform devices. */
> +	params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
>  
> -		/* Mask out Fast Read if not requested at DT instantiation. */
> -		if (np && !of_property_read_bool(np, "m25p,fast-read"))
> -			params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
> -	}
> +	/* Mask out Fast Read if not requested at DT instantiation. */
> +	if (np && !of_property_read_bool(np, "m25p,fast-read"))
> +		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;

Nit: move this above where SNOR_CMD_READ_FAST is set up.

Also, I think this is a bit clearer:

	/* Default to Fast Read for non-DT and enable it if requested by DT. */
	if (!np || of_property_read_bool(np, "m25p,fast-read"))
		params->hwcaps.mask |= SNOR_HWCAPS_READ_FAST;

>  
>  	/* (Fast) Read settings. */
>  	params->hwcaps.mask |= SNOR_HWCAPS_READ;
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 072c69b0d06c..9aa7d6399c8a 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -479,7 +479,6 @@ struct spi_nor_id {
>   *                            Usually these will power-up in a write-protected
>   *                            state.
>   *   SPI_NOR_NO_ERASE:        no erase command needed.
> - *   SPI_NOR_NO_FR:           can't do fastread.
>   *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
>   *   SPI_NOR_RWW:             flash supports reads while write.
>   *
> @@ -528,7 +527,6 @@ struct flash_info {
>  #define SPI_NOR_BP3_SR_BIT6		BIT(4)
>  #define SPI_NOR_SWP_IS_VOLATILE		BIT(5)
>  #define SPI_NOR_NO_ERASE		BIT(6)
> -#define SPI_NOR_NO_FR			BIT(7)
>  #define SPI_NOR_QUAD_PP			BIT(8)
>  #define SPI_NOR_RWW			BIT(9)

Move the other bits up since the slot is now free.

>  
> diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
> index 5f321e24ae7d..0720a61947e7 100644
> --- a/drivers/mtd/spi-nor/everspin.c
> +++ b/drivers/mtd/spi-nor/everspin.c
> @@ -14,28 +14,39 @@ static const struct flash_info everspin_nor_parts[] = {
>  		.size = SZ_16K,
>  		.sector_size = SZ_16K,
>  		.addr_nbytes = 2,
> -		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +		.flags = SPI_NOR_NO_ERASE,
>  	}, {
>  		.name = "mr25h256",
>  		.size = SZ_32K,
>  		.sector_size = SZ_32K,
>  		.addr_nbytes = 2,
> -		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +		.flags = SPI_NOR_NO_ERASE,
>  	}, {
>  		.name = "mr25h10",
>  		.size = SZ_128K,
>  		.sector_size = SZ_128K,
> -		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +		.flags = SPI_NOR_NO_ERASE,
>  	}, {
>  		.name = "mr25h40",
>  		.size = SZ_512K,
>  		.sector_size = SZ_512K,
> -		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
> +		.flags = SPI_NOR_NO_ERASE,
>  	}
>  };
>  
> +static void evervision_nor_default_init(struct spi_nor *nor)
> +{
> +	/* Everspin FRAMs don't support the fast read opcode. */
> +	nor->params->hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
> +}
> +
> +static const struct spi_nor_fixups evervision_nor_fixups = {
> +	.default_init = evervision_nor_default_init,
> +};
> +
>  const struct spi_nor_manufacturer spi_nor_everspin = {
>  	.name = "everspin",
>  	.parts = everspin_nor_parts,
>  	.nparts = ARRAY_SIZE(everspin_nor_parts),
> +	.fixups = &evervision_nor_fixups,
>  };

-- 
Regards,
Pratyush Yadav

