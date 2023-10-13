Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175B67C7C36
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjJMDfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMDfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:35:43 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D473B7;
        Thu, 12 Oct 2023 20:35:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vu0mA1C_1697168137;
Received: from 30.97.48.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vu0mA1C_1697168137)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 11:35:38 +0800
Message-ID: <e1d3f57c-774a-840d-f811-1b91cc40079a@linux.alibaba.com>
Date:   Fri, 13 Oct 2023 11:35:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] leds: sc27xx: Move mutex_init() down
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-leds@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231013022010.854367-1-chunyan.zhang@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231013022010.854367-1-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 10:20 AM, Chunyan Zhang wrote:
> Move the mutex_init() to avoid redundant mutex_destroy() calls after
> that for each time the probe fails.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
> Rebased onto linux-next.
> 
> V3: Move the mutex_init() before sc27xx_led_register(), in case it maybe
> used right after led registerd.
> 
> V2: Move the mutex_init() to the end of .probe() instead of adding mutex_destroy().
> ---
>   drivers/leds/leds-sc27xx-bltc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> index af1f00a2f328..f04db793e8d6 100644
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
> @@ -323,6 +320,8 @@ static int sc27xx_led_probe(struct platform_device *pdev)
>   		priv->leds[reg].active = true;
>   	}
>   
> +	mutex_init(&priv->lock);
> +
>   	err = sc27xx_led_register(dev, priv);
>   	if (err)
>   		mutex_destroy(&priv->lock);
