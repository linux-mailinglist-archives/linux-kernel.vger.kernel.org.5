Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C879CD24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjILKGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjILKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:06:19 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4E82D59;
        Tue, 12 Sep 2023 03:05:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VrwXrmS_1694513141;
Received: from 30.97.48.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VrwXrmS_1694513141)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 18:05:42 +0800
Message-ID: <80d7b0ad-026d-6ba9-7c1f-7f0c3b5af588@linux.alibaba.com>
Date:   Tue, 12 Sep 2023 18:05:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFT PATCH 3/3] gpio: eic-sprd: use
 devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230912094519.22769-1-brgl@bgdev.pl>
 <20230912094519.22769-3-brgl@bgdev.pl>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230912094519.22769-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 5:45 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Make two calls into one by using devm_platform_ioremap_resource().
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Please don't do this. See the previous commit: 
4ed7d7dd4890bb8120a3e77c16191a695fdfcc5a ("Revert "gpio: eic-sprd: Use 
devm_platform_ioremap_resource()"")

> ---
>   drivers/gpio/gpio-eic-sprd.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index be7f2fa5aa7b..1e548e4e4cb8 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -594,7 +594,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct gpio_irq_chip *irq;
>   	struct sprd_eic *sprd_eic;
> -	struct resource *res;
>   	int ret, i;
>   
>   	pdata = of_device_get_match_data(dev);
> @@ -621,11 +620,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   		 * have one bank EIC, thus base[1] and base[2] can be
>   		 * optional.
>   		 */
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -		if (!res)
> -			break;
> -
> -		sprd_eic->base[i] = devm_ioremap_resource(dev, res);
> +		sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, i);
>   		if (IS_ERR(sprd_eic->base[i]))
>   			return PTR_ERR(sprd_eic->base[i]);
>   	}
