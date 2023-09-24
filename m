Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18D7ACACB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjIXQee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 12:34:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF66FC;
        Sun, 24 Sep 2023 09:34:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD60C433C7;
        Sun, 24 Sep 2023 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695573266;
        bh=iASfj17cqi8s/uASPn0k5gn6J4ssJb4sKyxilelbtR0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GntrjhnzpN/FnXQcpk2ULg2lV8xUjFCbRT4RkNjDbDXBma/QqHaNu/7uIjqlvZoni
         niHtymt/lLriBwv14b4R6YaE7DL5qh+JqlZphgug53y855hYobYaVqe65Vd0cjBikK
         uym8BceK2cW6qWapmlcU49qf4fMHATyDaRnvumeUn3pfZX/Wpwltn+de64tgZOS28U
         EQLw9GeVFkaVeECja6zUAZTJDITaPAawG4GzY9mpnpgkwT9Q4eS+1jCoUYFXW4PQ8E
         hmI5JDWMFkxKz/835ZE7haw0ydNh09J0CmjaveFIPBO+Rsm65x2Q1maqoCIopof4N2
         K6q1ueNbRWFQg==
Date:   Sun, 24 Sep 2023 17:34:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7192: Correct reference voltage
Message-ID: <20230924173418.4d83ac04@jic23-huawei>
In-Reply-To: <20230924152149.41884-1-alisadariana@gmail.com>
References: <20230924152149.41884-1-alisadariana@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023 18:21:48 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisa.roman@analog.com>
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
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
> v1 -> v2
> 	- use dev_err_probe()
> 	Link: https://lore.kernel.org/lkml/20230923225827.75681-1-alisadariana@gmail.com/
> 
>  drivers/iio/adc/ad7192.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 69d1103b9508..b64fd365f83f 100644
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
> @@ -1008,10 +1009,30 @@ static int ad7192_probe(struct spi_device *spi)
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
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Device tree error, AVdd voltage undefined\n");
> +	} else {
> +		ret = regulator_enable(st->vref);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(st->vref);
> +		if (ret < 0)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Device tree error, Vref voltage undefined\n");
>  	}
>  	st->int_vref_mv = ret / 1000;
>  

