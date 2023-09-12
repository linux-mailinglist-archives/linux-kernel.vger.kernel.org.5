Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1073C79C9BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjILIWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjILIWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:22:03 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE491705;
        Tue, 12 Sep 2023 01:21:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vrw2he2_1694506914;
Received: from 30.97.48.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vrw2he2_1694506914)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 16:21:55 +0800
Message-ID: <06791ae0-a4fb-d230-da0c-ced84d8ebe93@linux.alibaba.com>
Date:   Tue, 12 Sep 2023 16:22:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 3/6] pinctrl: sprd: Modify pull-up parameters
To:     Linhua Xu <Linhua.xu@unisoc.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <20230908055146.18347-4-Linhua.xu@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230908055146.18347-4-Linhua.xu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 1:51 PM, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> For UNISOC pin controller, there are three different configurations of
> pull-up drive current. Modify the 20K pull-up resistor configuration and
> add the 1.8K pull-up resistor configuration.
> 
> Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>

Please add a Fixes tag.

> ---
>   drivers/pinctrl/sprd/pinctrl-sprd.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
> index 5b9126b2cde2..6c75e6b8d2ca 100644
> --- a/drivers/pinctrl/sprd/pinctrl-sprd.c
> +++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
> @@ -69,7 +69,8 @@
>   #define SLEEP_PULL_UP_MASK		GENMASK(1, 0)
>   #define SLEEP_PULL_UP_SHIFT		2
>   
> -#define PULL_UP_4_7K			(BIT(12) | BIT(7))
> +#define PULL_UP_1_8K			(BIT(12) | BIT(7))
> +#define PULL_UP_4_7K			BIT(12)
>   #define PULL_UP_20K			BIT(7)
>   #define PULL_UP_MASK			(GENMASK(1, 0) | BIT(6))
>   #define PULL_UP_SHIFT			6
> @@ -499,7 +500,7 @@ static int sprd_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin_id,
>   			break;
>   		case PIN_CONFIG_BIAS_DISABLE:
>   			if ((reg & (SLEEP_PULL_DOWN | SLEEP_PULL_UP)) ||
> -			    (reg & (PULL_DOWN | PULL_UP_4_7K | PULL_UP_20K)))
> +			    (reg & (PULL_DOWN | PULL_UP_1_8K)))

The math logic is correct, but the code is not readable now. Since we 
should mask all PULL UP configration, but the code only mask 'PULL_UP_1_8K'.

So changing to below will be more clear:
(reg & (PULL_DOWN | PULL_UP_4_7K | PULL_UP_20K | PULL_UP_1_8K)

>   				return -EINVAL;
>   
>   			arg = 1;
> @@ -701,6 +702,8 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
>   						val |= PULL_UP_20K;
>   					else if (arg == 4700)
>   						val |= PULL_UP_4_7K;
> +					else if (arg == 1800)
> +						val |= PULL_UP_1_8K;
>   
>   					mask = PULL_UP_MASK;
>   					shift = PULL_UP_SHIFT;
> @@ -712,8 +715,7 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
>   					mask = SLEEP_PULL_DOWN | SLEEP_PULL_UP;
>   				} else {
>   					val = shift = 0;
> -					mask = PULL_DOWN | PULL_UP_20K |
> -						PULL_UP_4_7K;
> +					mask = PULL_DOWN | PULL_UP_1_8K;

ditto.

>   				}
>   				break;
>   			case PIN_CONFIG_SLEEP_HARDWARE_STATE:
