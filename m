Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0177ACA1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjIXOur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIXOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:50:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08113FC;
        Sun, 24 Sep 2023 07:50:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC351C433C8;
        Sun, 24 Sep 2023 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695567039;
        bh=PA4HpJZ/oM4RsAfWDJNFj966iei9Is4OvBg8CiMxIrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dbx1lwT7m8TFgbEUbh0Fsnu2wvoR2AuxgNOMNEKhXWSrvpM2bKoXBATVzpnuPxIsw
         puNDNe/sZxU5sVsgk8aDSXS8Ocdy5huNObC6XzMgamPUzltP85qtRhy8A7Ju96+uQt
         H10yyzZfJ1c0Esy6RpYG4B6ZpuNKWfVXVxK5QXRNQX8LR8O6beglAut29btsPQEvLs
         fvq3FZxZ7rUyv7LhZvxzpdy8JDbba1s6wPpkjIpYQ8FrlGxn+RSMHK9SxKp/N2ngLz
         D3cNY4aYLVGOLswwZHwi/ETJ719iF3YzjncPNwLu+0I3fDPkaq9qjVPor30C5Dsrv7
         a0qFqETOy5Wew==
Date:   Sun, 24 Sep 2023 15:50:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: Correct reference voltage
Message-ID: <20230924155019.1675a37d@jic23-huawei>
In-Reply-To: <20230923225827.75681-1-alisadariana@gmail.com>
References: <20230923225827.75681-1-alisadariana@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023 01:58:27 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisadariana@gmail.com>
> 
> The avdd and the reference voltage are two different sources but the
> reference voltage was assigned according to the avdd supply.
> 
> Add vref regulator structure and set the reference voltage according to
> the vref supply from the devicetree.
> 
> In case vref supply is missing, reference voltage is set according to
> the avdd supply for compatibility with old devicetrees.
> 
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> Cc: stable@vger.kernel.org

Looks good but I'd prefer dev_err_probe() for the error messages.
Obviously that wasn't true for the existing one but as we are touching the
code good to clean it up.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 69d1103b9508..c414fed60dd3 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -177,6 +177,7 @@ struct ad7192_chip_info {
>  struct ad7192_state {
>  	const struct ad7192_chip_info	*chip_info;
>  	struct regulator		*avdd;
> +	struct regulator		*vref;
>  	struct clk			*mclk;
>  	u16				int_vref_mv;
>  	u32				fclk;
> @@ -1008,10 +1009,32 @@ static int ad7192_probe(struct spi_device *spi)
>  	if (ret)
>  		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
>  
> -	ret = regulator_get_voltage(st->avdd);
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "Device tree error, reference voltage undefined\n");
> -		return ret;
> +	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (IS_ERR(st->vref)) {
> +		if (PTR_ERR(st->vref) != -ENODEV)
> +			return PTR_ERR(st->vref);
> +
> +		ret = regulator_get_voltage(st->avdd);
> +		if (ret < 0) {
> +			dev_err(&spi->dev, "Device tree error, AVdd voltage undefined\n");
dev_err_probe()

> +			return ret;
> +		}
> +	} else {
> +		ret = regulator_enable(st->vref);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
dev_err_probe()
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(st->vref);
> +		if (ret < 0) {
> +			dev_err(&spi->dev, "Device tree error, Vref voltage undefined\n");
dev_err_probe()

> +			return ret;
> +		}
>  	}
>  	st->int_vref_mv = ret / 1000;
>  

