Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B597C9559
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjJNQS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:18:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D625A2;
        Sat, 14 Oct 2023 09:18:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB93C433C7;
        Sat, 14 Oct 2023 16:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697300332;
        bh=rcHe2IojBHzrFe/8C4CXM2Y34afpD5jZN4BNeTTGPSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W11XEmFFSK0FSzKN3yrJEz3qYTacjYsL3JhaN6VQTF9mZFldTjlqSR6aoK1lti0w1
         MbJOPOpp+q29FZjYdEG/yl3VkUnQT9Tix6HA+DDLnR4K8+Lft+7FkcmbOW3jOiHQTZ
         WqP96eL7yigHTCNDOielAkp1WdcApJvCLCUp3SI2MOmFWvNEXzhafV8dL4s73rQqlY
         1Jz0TmAozrjQ10YVd9x1PagUkyf1LQpQwprGjCsD40n3F/vkD9gOf0DSrjXHqNdEDJ
         LZjJzFgHvMR6d9IA9EIr0mRWowuEkKf3A5watNXbKAH2jb/+TfxdkoVrisehlS7tVx
         EfRrx5CbuYgGA==
Date:   Sat, 14 Oct 2023 17:19:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Use device_get_match_data()
Message-ID: <20231014171906.42459f40@jic23-huawei>
In-Reply-To: <20231006224440.442864-1-robh@kernel.org>
References: <20231006224440.442864-1-robh@kernel.org>
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

On Fri,  6 Oct 2023 17:44:39 -0500
Rob Herring <robh@kernel.org> wrote:

> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out first as testing
to let 0-day see if it can find any issues that we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc-core.c | 11 +++--------
>  drivers/iio/adc/twl6030-gpadc.c  | 10 ++++------
>  drivers/iio/dac/stm32-dac-core.c |  9 ++++-----
>  3 files changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index c19506b0aac8..616dd729666a 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -17,10 +17,11 @@
>  #include <linux/irqdomain.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -708,8 +709,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	struct stm32_adc_priv *priv;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = pdev->dev.of_node;
> -	const struct of_device_id *of_id;
> -
>  	struct resource *res;
>  	u32 max_rate;
>  	int ret;
> @@ -722,11 +721,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, &priv->common);
>  
> -	of_id = of_match_device(dev->driver->of_match_table, dev);
> -	if (!of_id)
> -		return -ENODEV;
> -
> -	priv->cfg = (const struct stm32_adc_priv_cfg *)of_id->data;
> +	priv->cfg = device_get_match_data(dev);
>  	priv->nb_adc_max = priv->cfg->num_adcs;
>  	spin_lock_init(&priv->common.lock);
>  
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index 224e9cb5e147..78bf55438b2c 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -16,9 +16,10 @@
>   */
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_platform.h>
> +#include <linux/property.h>
>  #include <linux/mfd/twl.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -879,17 +880,14 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct twl6030_gpadc_data *gpadc;
>  	const struct twl6030_gpadc_platform_data *pdata;
> -	const struct of_device_id *match;
>  	struct iio_dev *indio_dev;
>  	int irq;
>  	int ret;
>  
> -	match = of_match_device(of_twl6030_match_tbl, dev);
> -	if (!match)
> +	pdata = device_get_match_data(&pdev->dev);
> +	if (!pdata)
>  		return -EINVAL;
>  
> -	pdata = match->data;
> -
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*gpadc));
>  	if (!indio_dev)
>  		return -ENOMEM;
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> index 15abe048729e..e150ac729154 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -9,9 +9,12 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  
> @@ -94,16 +97,12 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	struct reset_control *rst;
>  	int ret;
>  
> -	if (!dev->of_node)
> -		return -ENODEV;
> -
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  	platform_set_drvdata(pdev, &priv->common);
>  
> -	cfg = (const struct stm32_dac_cfg *)
> -		of_match_device(dev->driver->of_match_table, dev)->data;
> +	cfg = device_get_match_data(dev);
>  
>  	mmio = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mmio))

