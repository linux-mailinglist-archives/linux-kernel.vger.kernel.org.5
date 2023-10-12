Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783EA7C671C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377801AbjJLH3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJLH3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:29:36 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE72F90;
        Thu, 12 Oct 2023 00:29:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VtzY4pG_1697095769;
Received: from 30.97.48.41(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VtzY4pG_1697095769)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 15:29:30 +0800
Message-ID: <6110db84-546d-fc5c-f241-7923d673bbd5@linux.alibaba.com>
Date:   Thu, 12 Oct 2023 15:29:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH V2] leds: sc27xx: Move mutex_init() to the end of
 probe
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-leds@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231012034735.804157-1-chunyan.zhang@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231012034735.804157-1-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2023 11:47 AM, Chunyan Zhang wrote:
> Move the mutex_init() to avoid redundant mutex_destroy() calls after
> that for each time the probe fails.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> Rebased onto linux-next.
> 
> V2:
> - Move the mutex_init() to the end of .probe() instead of adding
> mutex_destroy() according to Lee's comments.
> ---
>   drivers/leds/leds-sc27xx-bltc.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> index af1f00a2f328..ef57e57ecf07 100644
> --- a/drivers/leds/leds-sc27xx-bltc.c
> +++ b/drivers/leds/leds-sc27xx-bltc.c
> @@ -296,7 +296,6 @@ static int sc27xx_led_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	platform_set_drvdata(pdev, priv);
> -	mutex_init(&priv->lock);
>   	priv->base = base;
>   	priv->regmap = dev_get_regmap(dev->parent, NULL);
>   	if (!priv->regmap) {
> @@ -309,13 +308,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
>   		err = of_property_read_u32(child, "reg", &reg);
>   		if (err) {
>   			of_node_put(child);
> -			mutex_destroy(&priv->lock);
>   			return err;
>   		}
>   
>   		if (reg >= SC27XX_LEDS_MAX || priv->leds[reg].active) {
>   			of_node_put(child);
> -			mutex_destroy(&priv->lock);
>   			return -EINVAL;
>   		}
>   
> @@ -325,9 +322,11 @@ static int sc27xx_led_probe(struct platform_device *pdev)
>   
>   	err = sc27xx_led_register(dev, priv);
>   	if (err)
> -		mutex_destroy(&priv->lock);
> +		return err;
>   
> -	return err;
> +	mutex_init(&priv->lock);

I think it is better to prepare all the required resources before 
registering the led device, what I mean is moving mutex_init() before 
calling sc27xx_led_register().
