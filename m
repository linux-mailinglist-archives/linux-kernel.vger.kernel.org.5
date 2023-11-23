Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC99A7F5D59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjKWLFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344982AbjKWLFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:05:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB0D5C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:05:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E19CC433C8;
        Thu, 23 Nov 2023 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737542;
        bh=yqetw7zosrQdLVs1wXRaQ09UgUlARXEo96Fo2p9Et0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLVP+wUGQg/KxAZFdxBrNZT5f8T7HhXpezp0CWAGFwL50Y5dvr2mz9b+x4oiB5oDu
         4XPPiMay8e8kIOFCWpwEukgKOfjFhGpuhZObam4eMbAWXgcHw8tknT6FOsVzwVaQIe
         11RcPm1vthHATIY/h5oI8d4CeaGEgc4WcRVRJ+8XNHWXe2P94KYktC3G4kCF6KD8D0
         /OZ6wy/ulEXVI5sSh/tPegkqsVcGcQ0QBS/T9Llf5zLp3oW+Z92xpYKC9CRZQtRnTn
         OGPgsRlZFDfUPtcQvC0gUuf1/e+5JuFyw4eKMGdY4XJaqLpm6aVE3yBAYndEInJVZC
         jnoQ4Od1T9o9g==
Date:   Thu, 23 Nov 2023 11:05:38 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 2/4] leds: trigger: gpio: Convert to use kstrtox()
Message-ID: <20231123110538.GA1243364@google.com>
References: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
 <20231103195310.948327-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103195310.948327-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Nov 2023, Andy Shevchenko wrote:

> sscanf() is a heavy one and moreover requires additional boundary checks.
> Convert driver to use kstrtou8() in gpio_trig_inverted_store().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/leds/trigger/ledtrig-gpio.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
> index d91ae7fde3cf..8a30f9228186 100644
> --- a/drivers/leds/trigger/ledtrig-gpio.c
> +++ b/drivers/leds/trigger/ledtrig-gpio.c
> @@ -53,14 +53,12 @@ static ssize_t gpio_trig_brightness_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t n)
>  {
>  	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
> -	unsigned desired_brightness;
> +	u8 desired_brightness;
>  	int ret;
>  
> -	ret = sscanf(buf, "%u", &desired_brightness);
> -	if (ret < 1 || desired_brightness > 255) {
> -		dev_err(dev, "invalid value\n");
> -		return -EINVAL;
> -	}
> +	ret = kstrtou8(buf, 10, &desired_brightness);

Where does 10 come from?

> +	if (ret)
> +		return ret;
>  
>  	gpio_data->desired_brightness = desired_brightness;
>  
> -- 
> 2.40.0.1.gaa8946217a0b
> 

-- 
Lee Jones [李琼斯]
