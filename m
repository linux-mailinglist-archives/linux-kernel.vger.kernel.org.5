Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D956C771D18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjHGJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHGJ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:26:59 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488A6E70;
        Mon,  7 Aug 2023 02:26:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VpEBqMJ_1691400412;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpEBqMJ_1691400412)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 17:26:53 +0800
Message-ID: <ef866767-b95a-8288-4a09-d29fd2717d0a@linux.alibaba.com>
Date:   Mon, 7 Aug 2023 17:26:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] gpio: sprd: Two-dimensional arrays maintain pmic eic
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230807091801.17988-1-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230807091801.17988-1-Wenhua.Lin@unisoc.com>
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



On 8/7/2023 5:18 PM, Wenhua Lin wrote:
> Maintain the registers of each pmic eic through a Two-dimensional
> array to avoid mutual interference.
> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>

NAK. See below.

> ---
>   drivers/gpio/gpio-pmic-eic-sprd.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
> index c3e4d90f6b18..8d67d130cbcf 100644
> --- a/drivers/gpio/gpio-pmic-eic-sprd.c
> +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
> @@ -57,7 +57,7 @@ struct sprd_pmic_eic {
>   	struct gpio_chip chip;
>   	struct regmap *map;
>   	u32 offset;
> -	u8 reg[CACHE_NR_REGS];
> +	u8 reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS];

We have recorded the offset, no need two-dimensional array unless you 
have other strong reasons.

>   	struct mutex buslock;
>   	int irq;
>   };
> @@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *data)
>   	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
>   	u32 offset = irqd_to_hwirq(data);
>   
> -	pmic_eic->reg[REG_IE] = 0;
> -	pmic_eic->reg[REG_TRIG] = 0;
> +	pmic_eic->reg[offset][REG_IE] = 0;
> +	pmic_eic->reg[offset][REG_TRIG] = 0;
>   
>   	gpiochip_disable_irq(chip, offset);
>   }
> @@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
>   
>   	gpiochip_enable_irq(chip, offset);
>   
> -	pmic_eic->reg[REG_IE] = 1;
> -	pmic_eic->reg[REG_TRIG] = 1;
> +	pmic_eic->reg[offset][REG_IE] = 1;
> +	pmic_eic->reg[offset][REG_TRIG] = 1;
>   }
>   
>   static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
> @@ -174,13 +174,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
>   {
>   	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
>   	struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
> +	u32 offset = irqd_to_hwirq(data);
>   
>   	switch (flow_type) {
>   	case IRQ_TYPE_LEVEL_HIGH:
> -		pmic_eic->reg[REG_IEV] = 1;
> +		pmic_eic->reg[offset][REG_IEV] = 1;
>   		break;
>   	case IRQ_TYPE_LEVEL_LOW:
> -		pmic_eic->reg[REG_IEV] = 0;
> +		pmic_eic->reg[offset][REG_IEV] = 0;
>   		break;
>   	case IRQ_TYPE_EDGE_RISING:
>   	case IRQ_TYPE_EDGE_FALLING:
> @@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
>   			sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
>   	} else {
>   		sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
> -				     pmic_eic->reg[REG_IEV]);
> +				     pmic_eic->reg[offset][REG_IEV]);
>   	}
>   
>   	/* Set irq unmask */
>   	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
> -			     pmic_eic->reg[REG_IE]);
> +			     pmic_eic->reg[offset][REG_IE]);
>   	/* Generate trigger start pulse for debounce EIC */
>   	sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG,
> -			     pmic_eic->reg[REG_TRIG]);
> +			     pmic_eic->reg[offset][REG_TRIG]);
>   
>   	mutex_unlock(&pmic_eic->buslock);
>   }
> @@ -335,6 +336,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
>   
>   	ret = devm_request_threaded_irq(&pdev->dev, pmic_eic->irq, NULL,
>   					sprd_pmic_eic_irq_handler,
> +					IRQF_TRIGGER_LOW |

Why? you did not explain this in the commit log.

>   					IRQF_ONESHOT | IRQF_NO_SUSPEND,
>   					dev_name(&pdev->dev), pmic_eic);
>   	if (ret) {
> @@ -352,6 +354,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
>   	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
>   	pmic_eic->chip.set = sprd_pmic_eic_set;
>   	pmic_eic->chip.get = sprd_pmic_eic_get;
> +	pmic_eic->chip.can_sleep = true;

Ditto. Why?

Please DO NOT squash different fixes into one patch.
