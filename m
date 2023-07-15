Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876D4754A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGORVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGORVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298B32701;
        Sat, 15 Jul 2023 10:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0A9860BD6;
        Sat, 15 Jul 2023 17:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C307DC433C7;
        Sat, 15 Jul 2023 17:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689441691;
        bh=RUrOWlzcFGjuRtgyyAy08XzYxnbzO7uWRniteLSWT24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qA2RPO5t4Anir7zc9CRpjfaehTA55SBhXjsSQvouR8hOpdjmsUisdGIm5yl6f5w4b
         PVUbhtuLLy5GGNkh4xAVRR4Mo3ZPj+R9K2YgSxJbHOw9ci8dfBj5EtCUU+gybdtD6G
         OztM2Z5/KbY+006R7Bv9MbuvZ/h/Tuj7kolnnjc1bPpZCbTaSjyjJeT9RpLHIpvJxt
         me/5Cs6JmuUHsC4xg8pZb5rgTf1wDRxvhpMVGDDzQrpjaBpZQQkvGaTaOoUwgkNKph
         bApkVVGSuk1TK6+QymFDYkM1OmiYH9fQmrvqzEsYHSrHJiuYiipKBypgs1GnFrDx8E
         sKcLE+JTBAlaQ==
Date:   Sat, 15 Jul 2023 18:21:21 +0100
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
Subject: Re: [PATCH v1 1/1] iio: adc: meson: fix core clock enable/disable
 moment
Message-ID: <20230715182121.29f83d76@jic23-huawei>
In-Reply-To: <20230714190320.308320-2-gnstark@sberdevices.ru>
References: <20230714190320.308320-1-gnstark@sberdevices.ru>
        <20230714190320.308320-2-gnstark@sberdevices.ru>
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

On Fri, 14 Jul 2023 22:03:15 +0300
George Stark <gnstark@sberdevices.ru> wrote:

> Enable core clock at probe stage and disable it at remove stage.
> Core clock is responsible for turning on/off the entire SoC module so
> it should be on before the first module register is touched and be off
> at very last moment.
> 
> Signed-off-by: George Stark <gnstark@sberdevices.ru>

This sounds to me like this should perhaps have a fixes tag?

Given where it is in the new sequence you can also use
devm_clk_get_enabled() though that makes a potential backport of
the fix trickier...

I'd go with it anyway as it will make this change quite a bit simpler.

More comments inline

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index fe066c9fab83..5a5bb5cc1320 100644
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
> @@ -1420,6 +1410,12 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  			ARRAY_SIZE(meson_sar_adc_iio_channels);
>  	}
>  
> +	ret = clk_prepare_enable(priv->core_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable core clk\n");
> +		goto err;

If clk_prepare_enable() failed, then you shoudl not call clk_disable_unprepare()

> +	}
> +
>  	ret = meson_sar_adc_init(indio_dev);
>  	if (ret)
>  		goto err;
> @@ -1445,17 +1441,21 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  err_hw:
>  	meson_sar_adc_hw_disable(indio_dev);
>  err:
> +	clk_disable_unprepare(priv->core_clk);

Nothing to do with your patch, but this driver previously did some odd mixing
of direct returns and going to an empty label which definitely doesn't help
make this clear to follow.

>  	return ret;
>  }
>  
>  static int meson_sar_adc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  
>  	meson_sar_adc_hw_disable(indio_dev);
>  
> +	clk_disable_unprepare(priv->core_clk);
> +
>  	return 0;
>  }
>  

