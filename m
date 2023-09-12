Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1279CF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjILLD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjILLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:02:54 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9731717;
        Tue, 12 Sep 2023 04:02:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VrwdiHG_1694516551;
Received: from 30.97.48.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VrwdiHG_1694516551)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 19:02:31 +0800
Message-ID: <5877cd0d-7a39-806a-e8f8-ef0c3c22dae3@linux.alibaba.com>
Date:   Tue, 12 Sep 2023 19:02:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFT PATCH 1/3] gpio: eic-sprd: unregister from the irq notifier
 on remove()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230912094519.22769-1-brgl@bgdev.pl>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230912094519.22769-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 5:45 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This is a tristate module, it can be unloaded. We need to cleanup properly
> and unregister from the interrupt notifier on driver detach.
> 
> Fixes: b32415652a4d ("gpio: eic-sprd: use atomic notifiers to notify all chips about irqs")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/gpio/gpio-eic-sprd.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 21a1afe358d6..9b2f9ccf8d77 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -580,6 +580,14 @@ static const struct irq_chip sprd_eic_irq = {
>   	.flags		= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
>   	GPIOCHIP_IRQ_RESOURCE_HELPERS,
>   };
> +
> +static void sprd_eic_unregister_notifier(void *data)
> +{
> +	struct notifier_block *nb = data;
> +
> +	atomic_notifier_chain_unregister(&sprd_eic_irq_notifier, nb);
> +}
> +
>   static int sprd_eic_probe(struct platform_device *pdev)
>   {
>   	const struct sprd_eic_variant_data *pdata;
> @@ -658,8 +666,15 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	}
>   
>   	sprd_eic->irq_nb.notifier_call = sprd_eic_irq_notify;
> -	return atomic_notifier_chain_register(&sprd_eic_irq_notifier,
> -					      &sprd_eic->irq_nb);
> +	ret = atomic_notifier_chain_register(&sprd_eic_irq_notifier,
> +					     &sprd_eic->irq_nb);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register with the interrupt notifier");
> +
> +	return devm_add_action_or_reset(&pdev->dev,
> +					sprd_eic_unregister_notifier,
> +					&sprd_eic->irq_nb);
>   }
>   
>   static const struct of_device_id sprd_eic_of_match[] = {
