Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FEF75DDB3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGVRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVRNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB7BE67;
        Sat, 22 Jul 2023 10:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3795B60BA4;
        Sat, 22 Jul 2023 17:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C996C433C8;
        Sat, 22 Jul 2023 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690046030;
        bh=WBUDQNvPcAAQ33CTwyobl5vG7ksUY6lE1tb9THb+/rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RINvGBcssY7x7S//6mp28SyHWEuOMCmaftZ6UiNsNaFjjH4Qr9N/d9I7QxjBNgNMx
         rmHDtKJBSpGILR+eL4QTpv1bOCupqz5SObFkyMBK6uxYx/qgdW562WeaFXlhs6DRO+
         Kl8sXlmKDGtAUPzU5OB+MI6lsu34mpnyw42rQZOkQbeR5cZ1Ls3CaR+ide00vC9xPP
         tfSu8L4o5qEN1a3sEXPoSJp9w36gpu8nTdG/Pnfq0lAeV0omBibBMiSWgdjjiQr22w
         vdXAuk17aLFUeOZeV9sG2dHsMhZVIDPFhEx6myBXime4+OxI/fiF91emVY2hyI0rKL
         FrxIAjM3dSUFQ==
Date:   Sat, 22 Jul 2023 18:13:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 1/2] iio: adc: meson: fix core clock enable/disable
 moment
Message-ID: <20230722181345.44a79b6d@jic23-huawei>
In-Reply-To: <20230721102413.255726-2-gnstark@sberdevices.ru>
References: <20230721102413.255726-1-gnstark@sberdevices.ru>
        <20230721102413.255726-2-gnstark@sberdevices.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 13:23:08 +0300
George Stark <gnstark@sberdevices.ru> wrote:

> Enable core clock at probe stage and disable it at remove stage.
> Core clock is responsible for turning on/off the entire SoC module so
> it should be on before the first module register is touched and be off
> at very last moment.
> 
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> Signed-off-by: George Stark <gnstark@sberdevices.ru>
Applied to the fixes-togreg branch of iio.git and marked for stable.

The 2nd patch will have to wait as it's not a fix.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/meson_saradc.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 2ee12f3ad312..8397a5347f32 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1055,12 +1055,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>  		goto err_vref;
>  	}
>  
> -	ret = clk_prepare_enable(priv->core_clk);
> -	if (ret) {
> -		dev_err(dev, "failed to enable core clk\n");
> -		goto err_core_clk;
> -	}
> -
>  	regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
>  			   MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
> @@ -1087,8 +1081,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
>  			   MESON_SAR_ADC_REG3_ADC_EN, 0);
>  	meson_sar_adc_set_bandgap(indio_dev, false);
> -	clk_disable_unprepare(priv->core_clk);
> -err_core_clk:
>  	regulator_disable(priv->vref);
>  err_vref:
>  	meson_sar_adc_unlock(indio_dev);
> @@ -1116,8 +1108,6 @@ static void meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
>  
>  	meson_sar_adc_set_bandgap(indio_dev, false);
>  
> -	clk_disable_unprepare(priv->core_clk);
> -
>  	regulator_disable(priv->vref);
>  
>  	if (!ret)
> @@ -1379,7 +1369,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->clkin))
>  		return dev_err_probe(dev, PTR_ERR(priv->clkin), "failed to get clkin\n");
>  
> -	priv->core_clk = devm_clk_get(dev, "core");
> +	priv->core_clk = devm_clk_get_enabled(dev, "core");
>  	if (IS_ERR(priv->core_clk))
>  		return dev_err_probe(dev, PTR_ERR(priv->core_clk), "failed to get core clk\n");
>  
> @@ -1462,15 +1452,26 @@ static int meson_sar_adc_remove(struct platform_device *pdev)
>  static int meson_sar_adc_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  
>  	meson_sar_adc_hw_disable(indio_dev);
>  
> +	clk_disable_unprepare(priv->core_clk);
> +
>  	return 0;
>  }
>  
>  static int meson_sar_adc_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->core_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable core clk\n");
> +		return ret;
> +	}
>  
>  	return meson_sar_adc_hw_enable(indio_dev);
>  }

