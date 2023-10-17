Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9157CC711
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjJQPJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjJQPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:09:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50253ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:09:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAFCC433C7;
        Tue, 17 Oct 2023 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697555355;
        bh=ylrjTPEgeCTXRLNBP7ynR5MjTIiAkIbguL3M2NwS9DQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SxMBs/ZNRNUtSFTs5IgDNLYr/hsh4MyHeROgQpVQlDSBxx4EIm71PGGUnFIiZDuND
         bqXFnBClEltN85tshZxXyeCUuW/Dh542mqjFNSDUjFtLEUn35fbP4wBxvGut80rcUC
         PyiKAdHDc3ZJx9ODZpbjBW3XbW8wWh7EAZRJY+svcOOFI3lV6/ybxbu/IKXlV0Wdfi
         dts+13KkGlxrTS1pVeHUyWq5N4G1Xq52qBIWojrmOu4GtTSPva69Hl1LQ+diPJbkj9
         a8C06SBWd8YfIdN6DUrmVOBHYunug+uuQiHdvKm//bEIxkqueDts1FqjF0BpAlogpl
         qZ8Ygcqq5jFYQ==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     michael@walle.cc, pratyush@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: Re: [PATCH v4 2/2] mtd: spi-nor: micron-st: use SFDP table for
 mt25qu512a
In-Reply-To: <20231017074711.12167-2-tudor.ambarus@linaro.org> (Tudor
        Ambarus's message of "Tue, 17 Oct 2023 10:47:11 +0300")
References: <20231017074711.12167-1-tudor.ambarus@linaro.org>
        <20231017074711.12167-2-tudor.ambarus@linaro.org>
Date:   Tue, 17 Oct 2023 17:09:13 +0200
Message-ID: <mafs0lec1mgkm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17 2023, Tudor Ambarus wrote:

> From: Mamta Shukla <mamta.shukla@leica-geosystems.com>
>
[...]
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 756391c906e5..8920547c12bf 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -180,6 +180,18 @@ static const struct flash_info micron_nor_parts[] = {
>  	},
>  };
>  
> +static int mt25qu512a_post_bfpt_fixup(struct spi_nor *nor,
> +				      const struct sfdp_parameter_header *bfpt_header,
> +				      const struct sfdp_bfpt *bfpt)
> +{
> +	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
> +	return 0;
> +}
> +
> +static struct spi_nor_fixups mt25qu512a_fixups = {
> +	.post_bfpt = mt25qu512a_post_bfpt_fixup,
> +};
> +
>  static const struct flash_info st_nor_parts[] = {
>  	{
>  		.name = "m25p05-nonjedec",
> @@ -407,10 +419,8 @@ static const struct flash_info st_nor_parts[] = {
>  		.name = "mt25qu512a",
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
>  			 SPI_NOR_BP3_SR_BIT6,
> -		.size = SZ_64M,
> -		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> -		.fixup_flags = SPI_NOR_4B_OPCODES,

Hmm, I have missed some recent developments in SPI NOR and I was
confused why you did not add a PARSE_SFDP flag. But now I understand
that you just need to drop the .size parameter and it will automatically
use SFDP. So LGTM.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>  		.mfr_flags = USE_FSR,
> +		.fixups = &mt25qu512a_fixups,
>  	}, {
>  		.id = SNOR_ID(0x20, 0xbb, 0x20),
>  		.name = "n25q512a",

-- 
Regards,
Pratyush Yadav
