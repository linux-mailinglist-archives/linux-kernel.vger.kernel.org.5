Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFFC7B001A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjI0J2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjI0J2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:28:44 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A44ECC;
        Wed, 27 Sep 2023 02:28:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Vszxseh_1695806919;
Received: from 30.97.48.70(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vszxseh_1695806919)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 17:28:39 +0800
Message-ID: <89009348-9580-433a-05b5-1290116e7633@linux.alibaba.com>
Date:   Wed, 27 Sep 2023 17:28:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 4/4] gpio: sprd: Support 8 banks EIC controller
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
 <20230921090027.11136-5-Wenhua.Lin@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230921090027.11136-5-Wenhua.Lin@unisoc.com>
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
> In order to solve the problem of insufficient eic,
> it supports 8 banks of eic controller, each bank contains 8 eic.
> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>   drivers/gpio/gpio-eic-sprd.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index e85addbdf8aa..6bb002060c3e 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -51,10 +51,10 @@
>   #define SPRD_EIC_SYNC_DATA		0x1c
>   
>   /*
> - * The digital-chip EIC controller can support maximum 3 banks, and each bank
> + * The digital-chip EIC controller can support maximum 8 banks, and each bank
>    * contains 8 EICs.
>    */
> -#define SPRD_EIC_MAX_BANK		3
> +#define SPRD_EIC_MAX_BANK		8
>   #define SPRD_EIC_PER_BANK_NR		8
>   #define SPRD_EIC_DATA_MASK		GENMASK(7, 0)
>   #define SPRD_EIC_BIT(x)			((x) & (SPRD_EIC_PER_BANK_NR - 1))
> @@ -615,9 +615,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>   
>   	for (i = 0; i < SPRD_EIC_MAX_BANK; i++) {
>   		/*
> -		 * We can have maximum 3 banks EICs, and each EIC has
> +		 * We can have maximum 8 banks EICs, and each EIC has
>   		 * its own base address. But some platform maybe only
> -		 * have one bank EIC, thus base[1] and base[2] can be
> +		 * have one bank EIC, thus base[1] and base[7] can be

Should be "base[1] to base[7]"

>   		 * optional.
>   		 */
>   		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
