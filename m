Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073537AFF75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjI0JI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjI0JIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:08:55 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E153297;
        Wed, 27 Sep 2023 02:08:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VszrmVr_1695805730;
Received: from 30.97.48.70(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VszrmVr_1695805730)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 17:08:51 +0800
Message-ID: <c8b9fef7-e27c-6760-52a8-04045dcdc0ec@linux.alibaba.com>
Date:   Wed, 27 Sep 2023 17:08:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 1/4] gpio: sprd: In the sleep state, the eic debounce
 clk must be forced open
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
 <20230921090027.11136-2-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230921090027.11136-2-Wenhua.Lin@unisoc.com>
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



On 9/21/2023 5:00 PM, Wenhua Lin wrote:
> In the sleep state, Eic debounce has no clock and the clk of
> debounce needs to be forced open, so that eic can wake up normally.
> 
> Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")

Are you sure this is the right Fixes tag? This commit did not change EIC 
debounce logics.

The changes look good to me.

> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 84352a6f4973..bfa8a4c7515a 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -23,6 +23,7 @@
>   #define SPRD_EIC_DBNC_IC		0x24
>   #define SPRD_EIC_DBNC_TRIG		0x28
>   #define SPRD_EIC_DBNC_CTRL0		0x40
> +#define SPRD_EIC_DBNC_FORCE_CLK		0x8000
>   
>   #define SPRD_EIC_LATCH_INTEN		0x0
>   #define SPRD_EIC_LATCH_INTRAW		0x4
> @@ -214,6 +215,7 @@ static int sprd_eic_set_debounce(struct gpio_chip *chip, unsigned int offset,
>   	u32 value = readl_relaxed(base + reg) & ~SPRD_EIC_DBNC_MASK;
>   
>   	value |= (debounce / 1000) & SPRD_EIC_DBNC_MASK;
> +	value |= SPRD_EIC_DBNC_FORCE_CLK;
>   	writel_relaxed(value, base + reg);
>   
>   	return 0;
