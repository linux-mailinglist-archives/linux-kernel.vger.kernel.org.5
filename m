Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F249179C9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjILI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjILI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:28:36 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF4B9;
        Tue, 12 Sep 2023 01:28:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vrw91XB_1694507309;
Received: from 30.97.48.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vrw91XB_1694507309)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 16:28:29 +0800
Message-ID: <50b7293c-8c4d-0162-2810-a74d59e7d03e@linux.alibaba.com>
Date:   Tue, 12 Sep 2023 16:28:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 2/6] pinctrl: sprd: Fix the incorrect mask and shift
 definition
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
 <20230908055146.18347-3-Linhua.xu@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230908055146.18347-3-Linhua.xu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 1:51 PM, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> Pull-up and pull-down are mutually exclusive. When setting one of them,
> the bit of the other needs to be clear. Now, there are cases where pull-up
> and pull-down are set at the same time in the code, thus fix them.
> 
> Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
> ---
>   drivers/pinctrl/sprd/pinctrl-sprd.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
> index 25fb9ce9ad78..5b9126b2cde2 100644
> --- a/drivers/pinctrl/sprd/pinctrl-sprd.c
> +++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
> @@ -58,21 +58,21 @@
>   #define DRIVE_STRENGTH_SHIFT		19
>   
>   #define SLEEP_PULL_DOWN			BIT(2)
> -#define SLEEP_PULL_DOWN_MASK		0x1
> +#define SLEEP_PULL_DOWN_MASK		GENMASK(1, 0)
>   #define SLEEP_PULL_DOWN_SHIFT		2
>   
>   #define PULL_DOWN			BIT(6)
> -#define PULL_DOWN_MASK			0x1
> +#define PULL_DOWN_MASK			(GENMASK(1, 0) | BIT(6))
>   #define PULL_DOWN_SHIFT			6
>   
>   #define SLEEP_PULL_UP			BIT(3)
> -#define SLEEP_PULL_UP_MASK		0x1
> -#define SLEEP_PULL_UP_SHIFT		3
> +#define SLEEP_PULL_UP_MASK		GENMASK(1, 0)
> +#define SLEEP_PULL_UP_SHIFT		2
>   
>   #define PULL_UP_4_7K			(BIT(12) | BIT(7))
>   #define PULL_UP_20K			BIT(7)
> -#define PULL_UP_MASK			0x21
> -#define PULL_UP_SHIFT			7
> +#define PULL_UP_MASK			(GENMASK(1, 0) | BIT(6))
> +#define PULL_UP_SHIFT			6

This change looks weird, BIT(6) is for PULL_DOWN. So I am curious these 
changes are backward compatibility?

Now I can not access the SPRD Spec, Chunyan, can you help to confirm 
these changes? Thanks.

>   
>   #define INPUT_SCHMITT			BIT(11)
>   #define INPUT_SCHMITT_MASK		0x1
