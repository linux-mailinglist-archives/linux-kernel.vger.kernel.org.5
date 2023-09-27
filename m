Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD85D7B00EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjI0Jtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjI0JtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:49:17 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F2910FD;
        Wed, 27 Sep 2023 02:49:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VszxC8b_1695808144;
Received: from 30.97.48.70(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VszxC8b_1695808144)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 17:49:05 +0800
Message-ID: <99dc2f99-cb03-bec8-b538-3ad21750adff@linux.alibaba.com>
Date:   Wed, 27 Sep 2023 17:49:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 1/2] gpio: pmic-eic-sprd: Two-dimensional arrays
 maintain pmic eic
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230921122527.15261-1-Wenhua.Lin@unisoc.com>
 <20230921122527.15261-2-Wenhua.Lin@unisoc.com>
 <9dd68b0e-e36a-b87c-e66d-586f2442da6c@linux.alibaba.com>
 <CAAfSe-tDFJtq77zw2vHsHAvrwXSy4KFwAEPnVJ6fP8e4PgRF6A@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAAfSe-tDFJtq77zw2vHsHAvrwXSy4KFwAEPnVJ6fP8e4PgRF6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 5:24 PM, Chunyan Zhang wrote:
> On Wed, 27 Sept 2023 at 17:04, Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 9/21/2023 8:25 PM, Wenhua Lin wrote:
>>> A bank PMIC EIC contains 16 EICs, and the operating registers
>>> are BIT0-BIT15, such as BIT0 of the register operated by EIC0.
>>> Using the one-dimensional array reg[CACHE_NR_REGS] for maintenance
>>> will cause the configuration of other EICs to be affected when
>>> operating a certain EIC. In order to solve this problem, the register
>>> operation bits of each PMIC EIC are maintained through the two-dimensional
>>> array reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS] to avoid mutual interference.
>>
>> LGTM. And this also deserves a Fixes tag.
> 
> Do we really need a two-dimensional array to save 16-bit value?

I also considering this, but after more thinking, I think this patch is 
a simple fix.

Now I realized the problem is that, if we use one array to cache a bank 
of EICs' status, the pmic_eic->reg[] array can contain incorrect 
configuration for other EICs in the same bank.

Yes, we can have another fix, for example, setting the pmic_eic->reg[] 
to some invalid values (maybe -1) in sprd_pmic_eic_bus_sync_unlock() 
after setting one EIC. Thus when setting another EIC, we can validate if 
the cached reg is a valid value, if not, we do not need to set the 
register. But like I said above, this seems more complicated.

>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>>> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
>>> ---
>>>    drivers/gpio/gpio-pmic-eic-sprd.c | 21 +++++++++++----------
>>>    1 file changed, 11 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
>>> index c3e4d90f6b18..442968bb2490 100644
>>> --- a/drivers/gpio/gpio-pmic-eic-sprd.c
>>> +++ b/drivers/gpio/gpio-pmic-eic-sprd.c
>>> @@ -57,7 +57,7 @@ struct sprd_pmic_eic {
>>>        struct gpio_chip chip;
>>>        struct regmap *map;
>>>        u32 offset;
>>> -     u8 reg[CACHE_NR_REGS];
>>> +     u8 reg[SPRD_PMIC_EIC_NR][CACHE_NR_REGS];
>>>        struct mutex buslock;
>>>        int irq;
>>>    };
>>> @@ -151,8 +151,8 @@ static void sprd_pmic_eic_irq_mask(struct irq_data *data)
>>>        struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
>>>        u32 offset = irqd_to_hwirq(data);
>>>
>>> -     pmic_eic->reg[REG_IE] = 0;
>>> -     pmic_eic->reg[REG_TRIG] = 0;
>>> +     pmic_eic->reg[offset][REG_IE] = 0;
>>> +     pmic_eic->reg[offset][REG_TRIG] = 0;
>>>
>>>        gpiochip_disable_irq(chip, offset);
>>>    }
>>> @@ -165,8 +165,8 @@ static void sprd_pmic_eic_irq_unmask(struct irq_data *data)
>>>
>>>        gpiochip_enable_irq(chip, offset);
>>>
>>> -     pmic_eic->reg[REG_IE] = 1;
>>> -     pmic_eic->reg[REG_TRIG] = 1;
>>> +     pmic_eic->reg[offset][REG_IE] = 1;
>>> +     pmic_eic->reg[offset][REG_TRIG] = 1;
>>>    }
>>>
>>>    static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
>>> @@ -174,13 +174,14 @@ static int sprd_pmic_eic_irq_set_type(struct irq_data *data,
>>>    {
>>>        struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
>>>        struct sprd_pmic_eic *pmic_eic = gpiochip_get_data(chip);
>>> +     u32 offset = irqd_to_hwirq(data);
>>>
>>>        switch (flow_type) {
>>>        case IRQ_TYPE_LEVEL_HIGH:
>>> -             pmic_eic->reg[REG_IEV] = 1;
>>> +             pmic_eic->reg[offset][REG_IEV] = 1;
>>>                break;
>>>        case IRQ_TYPE_LEVEL_LOW:
>>> -             pmic_eic->reg[REG_IEV] = 0;
>>> +             pmic_eic->reg[offset][REG_IEV] = 0;
>>>                break;
>>>        case IRQ_TYPE_EDGE_RISING:
>>>        case IRQ_TYPE_EDGE_FALLING:
>>> @@ -222,15 +223,15 @@ static void sprd_pmic_eic_bus_sync_unlock(struct irq_data *data)
>>>                        sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV, 1);
>>>        } else {
>>>                sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IEV,
>>> -                                  pmic_eic->reg[REG_IEV]);
>>> +                                  pmic_eic->reg[offset][REG_IEV]);
>>>        }
>>>
>>>        /* Set irq unmask */
>>>        sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_IE,
>>> -                          pmic_eic->reg[REG_IE]);
>>> +                          pmic_eic->reg[offset][REG_IE]);
>>>        /* Generate trigger start pulse for debounce EIC */
>>>        sprd_pmic_eic_update(chip, offset, SPRD_PMIC_EIC_TRIG,
>>> -                          pmic_eic->reg[REG_TRIG]);
>>> +                          pmic_eic->reg[offset][REG_TRIG]);
>>>
>>>        mutex_unlock(&pmic_eic->buslock);
>>>    }
