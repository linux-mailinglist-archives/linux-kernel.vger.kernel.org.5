Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B77079CD36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjILKHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjILKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:07:20 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F136710E2;
        Tue, 12 Sep 2023 03:07:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VrwN.Fm_1694513228;
Received: from 30.97.48.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VrwN.Fm_1694513228)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 18:07:09 +0800
Message-ID: <4b7c8e8a-b97f-6e1e-7c49-889fdd5b921f@linux.alibaba.com>
Date:   Tue, 12 Sep 2023 18:07:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFT PATCH 2/3] gpio: eic-sprd: use a helper variable for
 &pdev->dev
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230912094519.22769-1-brgl@bgdev.pl>
 <20230912094519.22769-2-brgl@bgdev.pl>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230912094519.22769-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 5:45 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Instead of dereferencing pdev everywhere, just store the address of the
> underlying struct device in a local variable.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/gpio/gpio-eic-sprd.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 9b2f9ccf8d77..be7f2fa5aa7b 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -591,18 +591,19 @@ static void sprd_eic_unregister_notifier(void *data)
>   static int sprd_eic_probe(struct platform_device *pdev)
>   {
>   	const struct sprd_eic_variant_data *pdata;
> +	struct device *dev = &pdev->dev;
>   	struct gpio_irq_chip *irq;
>   	struct sprd_eic *sprd_eic;
>   	struct resource *res;
>   	int ret, i;
>   
> -	pdata = of_device_get_match_data(&pdev->dev);
> +	pdata = of_device_get_match_data(dev);
>   	if (!pdata) {
> -		dev_err(&pdev->dev, "No matching driver data found.\n");
> +		dev_err(dev, "No matching driver data found.\n");
>   		return -EINVAL;
>   	}
>   
> -	sprd_eic = devm_kzalloc(&pdev->dev, sizeof(*sprd_eic), GFP_KERNEL);
> +	sprd_eic = devm_kzalloc(dev, sizeof(*sprd_eic), GFP_KERNEL);
>   	if (!sprd_eic)
>   		return -ENOMEM;
>   
> @@ -624,7 +625,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   		if (!res)
>   			break;
>   
> -		sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
> +		sprd_eic->base[i] = devm_ioremap_resource(dev, res);
>   		if (IS_ERR(sprd_eic->base[i]))
>   			return PTR_ERR(sprd_eic->base[i]);
>   	}
> @@ -632,7 +633,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
>   	sprd_eic->chip.ngpio = pdata->num_eics;
>   	sprd_eic->chip.base = -1;
> -	sprd_eic->chip.parent = &pdev->dev;
> +	sprd_eic->chip.parent = dev;
>   	sprd_eic->chip.direction_input = sprd_eic_direction_input;
>   	switch (sprd_eic->type) {
>   	case SPRD_EIC_DEBOUNCE:
> @@ -659,9 +660,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	irq->num_parents = 1;
>   	irq->parents = &sprd_eic->irq;
>   
> -	ret = devm_gpiochip_add_data(&pdev->dev, &sprd_eic->chip, sprd_eic);
> +	ret = devm_gpiochip_add_data(dev, &sprd_eic->chip, sprd_eic);
>   	if (ret < 0) {
> -		dev_err(&pdev->dev, "Could not register gpiochip %d.\n", ret);
> +		dev_err(dev, "Could not register gpiochip %d.\n", ret);
>   		return ret;
>   	}
>   
> @@ -669,11 +670,10 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	ret = atomic_notifier_chain_register(&sprd_eic_irq_notifier,
>   					     &sprd_eic->irq_nb);
>   	if (ret)
> -		return dev_err_probe(&pdev->dev, ret,
> +		return dev_err_probe(dev, ret,
>   				     "Failed to register with the interrupt notifier");
>   
> -	return devm_add_action_or_reset(&pdev->dev,
> -					sprd_eic_unregister_notifier,
> +	return devm_add_action_or_reset(dev, sprd_eic_unregister_notifier,
>   					&sprd_eic->irq_nb);
>   }
>   
