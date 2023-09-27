Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8838D7AFFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjI0JYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjI0JYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:24:34 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB192;
        Wed, 27 Sep 2023 02:24:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vszx4j5_1695806669;
Received: from 30.97.48.70(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vszx4j5_1695806669)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 17:24:30 +0800
Message-ID: <07a9e3c1-0ed4-6f30-81c9-4eabcc11a18b@linux.alibaba.com>
Date:   Wed, 27 Sep 2023 17:24:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 3/4] gpio: sprd: Modify the calculation method of eic
 number
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
 <20230921090027.11136-4-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230921090027.11136-4-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2023 5:00 PM, Wenhua Lin wrote:
> When the soc changes, the corresponding gpio-eic-sprd.c
> code needs to be modified, and the corresponding
> Document must also be modified, which is quite troublesome.
> To avoid modifying the driver file, the number of EICs
> is automatically calculated by matching dts nodes.
> 
> Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")

This is not a bugfix and you still use an incorrect Fixes tag.

> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c | 43 ++++++++++++++++++------------------
>   1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 96f1c7fd3988..e85addbdf8aa 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -100,33 +100,32 @@ struct sprd_eic {
>   
>   struct sprd_eic_variant_data {
>   	enum sprd_eic_type type;
> -	u32 num_eics;
>   };
>   
> +#define SPRD_EIC_VAR_DATA(soc_name)				\
> +static const struct sprd_eic_variant_data soc_name##_eic_dbnc_data = {	\
> +	.type = SPRD_EIC_DEBOUNCE,					\
> +};									\
> +									\
> +static const struct sprd_eic_variant_data soc_name##_eic_latch_data = {	\
> +	.type = SPRD_EIC_LATCH,						\
> +};									\
> +									\
> +static const struct sprd_eic_variant_data soc_name##_eic_async_data = {	\
> +	.type = SPRD_EIC_ASYNC,						\
> +};									\
> +									\
> +static const struct sprd_eic_variant_data soc_name##_eic_sync_data = {	\
> +	.type = SPRD_EIC_SYNC,						\
> +}
> +
> +SPRD_EIC_VAR_DATA(sc9860);
> +
>   static const char *sprd_eic_label_name[SPRD_EIC_MAX] = {
>   	"eic-debounce", "eic-latch", "eic-async",
>   	"eic-sync",
>   };
>   
> -static const struct sprd_eic_variant_data sc9860_eic_dbnc_data = {
> -	.type = SPRD_EIC_DEBOUNCE,
> -	.num_eics = 8,
> -};
> -
> -static const struct sprd_eic_variant_data sc9860_eic_latch_data = {
> -	.type = SPRD_EIC_LATCH,
> -	.num_eics = 8,
> -};
> -
> -static const struct sprd_eic_variant_data sc9860_eic_async_data = {
> -	.type = SPRD_EIC_ASYNC,
> -	.num_eics = 8,
> -};
> -
> -static const struct sprd_eic_variant_data sc9860_eic_sync_data = {
> -	.type = SPRD_EIC_SYNC,
> -	.num_eics = 8,
> -};
>   
>   static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd_eic,
>   						 unsigned int bank)
> @@ -595,6 +594,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	struct sprd_eic *sprd_eic;
>   	struct resource *res;
>   	int ret, i;
> +	u16 num_banks = 0;
>   
>   	pdata = of_device_get_match_data(&pdev->dev);
>   	if (!pdata) {
> @@ -625,12 +625,13 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   			break;
>   
>   		sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
> +		num_banks++;

Please move this after the validation of the sprd_eic->base.

>   		if (IS_ERR(sprd_eic->base[i]))
>   			return PTR_ERR(sprd_eic->base[i]);
>   	}
>   
>   	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
> -	sprd_eic->chip.ngpio = pdata->num_eics;
> +	sprd_eic->chip.ngpio = num_banks * SPRD_EIC_PER_BANK_NR;
>   	sprd_eic->chip.base = -1;
>   	sprd_eic->chip.parent = &pdev->dev;
>   	sprd_eic->chip.direction_input = sprd_eic_direction_input;
