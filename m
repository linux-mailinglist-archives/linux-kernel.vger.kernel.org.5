Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8624777504B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHIBYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHIBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:24:01 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35670173F;
        Tue,  8 Aug 2023 18:24:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VpMvxPu_1691544235;
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpMvxPu_1691544235)
          by smtp.aliyun-inc.com;
          Wed, 09 Aug 2023 09:23:56 +0800
Message-ID: <0ac280ab-08f1-b031-e21b-49390182f090@linux.alibaba.com>
Date:   Wed, 9 Aug 2023 09:23:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] gpio: sprd: Modify the calculation method of eic
 number
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230808033106.2174-1-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230808033106.2174-1-Wenhua.Lin@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2023 11:31 AM, Wenhua Lin wrote:
> Automatic calculation through matching nodes,
> subsequent projects can avoid modifying driver files.

Please describe the problem in detail, not only what you did.

> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c | 49 +++++++++++++++++++-----------------
>   1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 84352a6f4973..0d85d9e80848 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -50,10 +50,10 @@
>   #define SPRD_EIC_SYNC_DATA		0x1c
>   
>   /*
> - * The digital-chip EIC controller can support maximum 3 banks, and each bank
> + * The digital-chip EIC controller can support maximum 8 banks, and each bank

Can you explicit on which controller can support 8 banks in the commit 
log? And you did not change all the related comments in this file.

>    * contains 8 EICs.
>    */
> -#define SPRD_EIC_MAX_BANK		3
> +#define SPRD_EIC_MAX_BANK		8
>   #define SPRD_EIC_PER_BANK_NR		8
>   #define SPRD_EIC_DATA_MASK		GENMASK(7, 0)
>   #define SPRD_EIC_BIT(x)			((x) & (SPRD_EIC_PER_BANK_NR - 1))
> @@ -99,33 +99,32 @@ struct sprd_eic {
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

If you want to introduce a readable macro, that's fine, but it should be 
split into a separate patch.

>   static inline void __iomem *sprd_eic_offset_base(struct sprd_eic *sprd_eic,
>   						 unsigned int bank)
> @@ -583,6 +582,7 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   	struct sprd_eic *sprd_eic;
>   	struct resource *res;
>   	int ret, i;
> +	u16 num_banks = 0;
>   
>   	pdata = of_device_get_match_data(&pdev->dev);
>   	if (!pdata) {
> @@ -613,12 +613,13 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   			break;
>   
>   		sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
> +		num_banks++;
>   		if (IS_ERR(sprd_eic->base[i]))
>   			return PTR_ERR(sprd_eic->base[i]);
>   	}
>   
>   	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
> -	sprd_eic->chip.ngpio = pdata->num_eics;
> +	sprd_eic->chip.ngpio = num_banks * SPRD_EIC_PER_BANK_NR;

This change looks good to me, and this seems a software bug in the 
original driver. So I think this change should be moved into a separate 
patch with a suitable Fixes tag.

>   	sprd_eic->chip.base = -1;
>   	sprd_eic->chip.parent = &pdev->dev;
>   	sprd_eic->chip.direction_input = sprd_eic_direction_input;
> @@ -630,10 +631,12 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   		sprd_eic->chip.set = sprd_eic_set;
>   		fallthrough;
>   	case SPRD_EIC_ASYNC:
> +		fallthrough;
>   	case SPRD_EIC_SYNC:
>   		sprd_eic->chip.get = sprd_eic_get;
>   		break;
>   	case SPRD_EIC_LATCH:
> +		fallthrough;

Do not add unreated changes that you did not mentioned in the commit log.
