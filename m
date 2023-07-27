Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86CE765948
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjG0Qx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjG0Qx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:53:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55D7B9E;
        Thu, 27 Jul 2023 09:53:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C2AD75;
        Thu, 27 Jul 2023 09:54:38 -0700 (PDT)
Received: from [10.32.102.67] (e110479.arm.com [10.32.102.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02A833F5A1;
        Thu, 27 Jul 2023 09:53:52 -0700 (PDT)
Message-ID: <23f220fd-918e-0e3a-764c-14d11fdf8f4f@arm.com>
Date:   Thu, 27 Jul 2023 17:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC][PATCH] rtc: sunxi: use external 32k oscillator if provided
Content-Language: en-US
To:     Mans Rullgard <mans@mansr.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230727150156.29691-1-mans@mansr.com>
From:   Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20230727150156.29691-1-mans@mansr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mans,

On 27/07/2023 16:01, Mans Rullgard wrote:
> Set the OSC32K_SRC_SEL bit in the LOSC control register if a clock is
> specified in the devicetree.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> The newer sun6i rtc driver is a proper clk provider with parent
> selection.  Doing the same thing in this driver would be difficult
> while staying compatible with existing devicetrees.  For that reason,
> this simpler approach seems reasonable.
> ---
>   drivers/rtc/rtc-sunxi.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
> index 5d019e3a835a..4f1053eab778 100644
> --- a/drivers/rtc/rtc-sunxi.c
> +++ b/drivers/rtc/rtc-sunxi.c
> @@ -5,6 +5,7 @@
>    * Copyright (c) 2013, Carlo Caione <carlo.caione@gmail.com>
>    */
>   
> +#include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/fs.h>
> @@ -21,8 +22,10 @@
>   #include <linux/types.h>
>   
>   #define SUNXI_LOSC_CTRL				0x0000
> +#define SUNXI_LOSC_CTRL_KEY			(0x16aa << 16)
>   #define SUNXI_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
>   #define SUNXI_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
> +#define SUNXI_LOSC_CTRL_OSC32K_SRC_SEL		BIT(0)
>   
>   #define SUNXI_RTC_YMD				0x0004
>   
> @@ -422,6 +425,7 @@ MODULE_DEVICE_TABLE(of, sunxi_rtc_dt_ids);
>   static int sunxi_rtc_probe(struct platform_device *pdev)
>   {
>   	struct sunxi_rtc_dev *chip;
> +	struct clk *extclk;
>   	int ret;
>   
>   	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> @@ -455,6 +459,14 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> +	/* use external oscillator if present */
> +	extclk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(extclk))
> +		return PTR_ERR(extclk);
> +	if (extclk)
> +		writel(SUNXI_LOSC_CTRL_KEY | SUNXI_LOSC_CTRL_OSC32K_SRC_SEL,
> +		       chip->base + SUNXI_LOSC_CTRL);

This should be a read-modify-write operation, since we don't want to 
disturb other bits in this register.

In general this looks OK to me, but would need to be documented in the 
bindings docs, to allow an optional clocks property.

Cheers,
Andre

> +
>   	/* clear the alarm count value */
>   	writel(0, chip->base + SUNXI_ALRM_DHMS);
>   
