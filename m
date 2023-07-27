Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E03765B69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjG0Sfg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jul 2023 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG0Sfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:35:34 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28A2719;
        Thu, 27 Jul 2023 11:35:33 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 2CD0515360;
        Thu, 27 Jul 2023 19:35:28 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id B46A5221D92; Thu, 27 Jul 2023 19:35:27 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] rtc: sunxi: use external 32k oscillator if provided
References: <20230727150156.29691-1-mans@mansr.com>
        <23f220fd-918e-0e3a-764c-14d11fdf8f4f@arm.com>
Date:   Thu, 27 Jul 2023 19:35:27 +0100
In-Reply-To: <23f220fd-918e-0e3a-764c-14d11fdf8f4f@arm.com> (Andre Przywara's
        message of "Thu, 27 Jul 2023 17:53:47 +0100")
Message-ID: <yw1x8rb1xkwg.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Przywara <andre.przywara@arm.com> writes:

> Hi Mans,
>
> On 27/07/2023 16:01, Mans Rullgard wrote:
>> Set the OSC32K_SRC_SEL bit in the LOSC control register if a clock is
>> specified in the devicetree.
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>> The newer sun6i rtc driver is a proper clk provider with parent
>> selection.  Doing the same thing in this driver would be difficult
>> while staying compatible with existing devicetrees.  For that reason,
>> this simpler approach seems reasonable.
>> ---
>>   drivers/rtc/rtc-sunxi.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>> diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
>> index 5d019e3a835a..4f1053eab778 100644
>> --- a/drivers/rtc/rtc-sunxi.c
>> +++ b/drivers/rtc/rtc-sunxi.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (c) 2013, Carlo Caione <carlo.caione@gmail.com>
>>    */
>>   +#include <linux/clk.h>
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/fs.h>
>> @@ -21,8 +22,10 @@
>>   #include <linux/types.h>
>>     #define SUNXI_LOSC_CTRL				0x0000
>> +#define SUNXI_LOSC_CTRL_KEY			(0x16aa << 16)
>>   #define SUNXI_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
>>   #define SUNXI_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
>> +#define SUNXI_LOSC_CTRL_OSC32K_SRC_SEL		BIT(0)
>>     #define SUNXI_RTC_YMD				0x0004
>>   @@ -422,6 +425,7 @@ MODULE_DEVICE_TABLE(of, sunxi_rtc_dt_ids);
>>   static int sunxi_rtc_probe(struct platform_device *pdev)
>>   {
>>   	struct sunxi_rtc_dev *chip;
>> +	struct clk *extclk;
>>   	int ret;
>>     	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> @@ -455,6 +459,14 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
>>   		return -ENODEV;
>>   	}
>>   +	/* use external oscillator if present */
>> +	extclk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
>> +	if (IS_ERR(extclk))
>> +		return PTR_ERR(extclk);
>> +	if (extclk)
>> +		writel(SUNXI_LOSC_CTRL_KEY | SUNXI_LOSC_CTRL_OSC32K_SRC_SEL,
>> +		       chip->base + SUNXI_LOSC_CTRL);
>
> This should be a read-modify-write operation, since we don't want to disturb
> other bits in this register.

Good point.  I guess it's best to leave everything untouched if the
clock isn't specified, just in case someone has a bootloader that sets
this bit.

> In general this looks OK to me, but would need to be documented in the
> bindings docs, to allow an optional clocks property.

Sure, I'll make a patch for that as well.

-- 
Måns Rullgård
