Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F979CA29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjILIhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjILIhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:37:32 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2DCB9;
        Tue, 12 Sep 2023 01:37:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VrwBLdc_1694507844;
Received: from 30.97.48.71(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VrwBLdc_1694507844)
          by smtp.aliyun-inc.com;
          Tue, 12 Sep 2023 16:37:25 +0800
Message-ID: <c714149e-9a54-40c1-fd55-bf2297eebe17@linux.alibaba.com>
Date:   Tue, 12 Sep 2023 16:37:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 5/6] pinctrl: sprd: Increase the range of register
 values
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
 <20230908055146.18347-6-Linhua.xu@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230908055146.18347-6-Linhua.xu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 1:51 PM, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> As the UNISOC pin controller version iterates, more registers are required
> to meet new functional requirements. Thus modify them.
> 
> Signed-off-by: Linhua Xu <Linhua.Xu@unisoc.com>
> ---
>   drivers/pinctrl/sprd/pinctrl-sprd.h | 30 +++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.h b/drivers/pinctrl/sprd/pinctrl-sprd.h
> index a696f81ce663..5357874186fd 100644
> --- a/drivers/pinctrl/sprd/pinctrl-sprd.h
> +++ b/drivers/pinctrl/sprd/pinctrl-sprd.h
> @@ -7,30 +7,32 @@
>   #ifndef __PINCTRL_SPRD_H__
>   #define __PINCTRL_SPRD_H__
>   
> +#include <linux/bits.h>
> +
>   struct platform_device;
>   
> -#define NUM_OFFSET	(20)
> -#define TYPE_OFFSET	(16)
> -#define BIT_OFFSET	(8)
> -#define WIDTH_OFFSET	(4)
> +#define NUM_OFFSET	22
> +#define TYPE_OFFSET	18
> +#define BIT_OFFSET	10
> +#define WIDTH_OFFSET	6
>   
>   #define SPRD_PIN_INFO(num, type, offset, width, reg)	\
> -		(((num) & 0xFFF) << NUM_OFFSET |	\
> -		 ((type) & 0xF) << TYPE_OFFSET |	\
> -		 ((offset) & 0xFF) << BIT_OFFSET |	\
> -		 ((width) & 0xF) << WIDTH_OFFSET |	\
> -		 ((reg) & 0xF))
> +		(((num) & GENMASK(10, 0)) << NUM_OFFSET |	\
> +		 ((type) & GENMASK(3, 0)) << TYPE_OFFSET |	\
> +		 ((offset) & GENMASK(7, 0)) << BIT_OFFSET |	\
> +		 ((width) & GENMASK(3, 0)) << WIDTH_OFFSET |	\
> +		 ((reg) & GENMASK(5, 0)))

Can you define some readable macro for the mask bits?

>   
>   #define SPRD_PINCTRL_PIN(pin)	SPRD_PINCTRL_PIN_DATA(pin, #pin)
>   
>   #define SPRD_PINCTRL_PIN_DATA(a, b)				\
>   	{							\
>   		.name = b,					\
> -		.num = (((a) >> NUM_OFFSET) & 0xfff),		\
> -		.type = (((a) >> TYPE_OFFSET) & 0xf),		\
> -		.bit_offset = (((a) >> BIT_OFFSET) & 0xff),	\
> -		.bit_width = ((a) >> WIDTH_OFFSET & 0xf),	\
> -		.reg = ((a) & 0xf)				\
> +		.num = (((a) & GENMASK(31, 22)) >> NUM_OFFSET),	\
> +		.type = (((a) & GENMASK(21, 18)) >> TYPE_OFFSET),	\
> +		.bit_offset = (((a) & GENMASK(17, 10)) >> BIT_OFFSET),	\
> +		.bit_width = (((a) & GENMASK(9, 6)) >> WIDTH_OFFSET),	\
> +		.reg = ((a) & GENMASK(5, 0))				\

Please keep the same logic operation as before, and you can reuse the 
readable macros if you defined.

>   	}
>   
>   enum pin_type {
