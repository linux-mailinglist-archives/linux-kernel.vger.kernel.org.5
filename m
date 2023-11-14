Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38067EB2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjKNOxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjKNOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:52:55 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B61B5;
        Tue, 14 Nov 2023 06:52:43 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45da94f4b90so2449356137.3;
        Tue, 14 Nov 2023 06:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699973562; x=1700578362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIQbkwE4qYiMmkgrrvrC/vRWElOWAUQTAZF8XUTl38o=;
        b=YO2lJABLXhI9ES562p/w5irK8OIZx27RJYMoADNqLgD2rcUCzpHZIIfDYpqsizyQwy
         351CiuJ866I+tqrKvOlc7UQnC0zhhtojjOGXWRyHw9Um95xkLziwEzk5doDvg0CSwGYh
         VR3R4g+UggljBnQ9dNqgSDDUjPrAkfDKzWFpBPznZMq/5wgXWDy6zRotsBzvMtsLonuw
         9EvgbE5D8LPBNwucKHisrosKzL/gcCSyvfByolHl3fFPdWzUcPlkTuwZJPwfvY0Qx7Ze
         7T8lzMdQ2Il8+A4RPkJJQAI2FxtaiS5NnPzi7ZgTrG1vSVCnlw9NNEF96tnhL8Mx1xjF
         lm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699973562; x=1700578362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIQbkwE4qYiMmkgrrvrC/vRWElOWAUQTAZF8XUTl38o=;
        b=faQHfH8ivXiR7SY6gxcrSL1o38OeC4CpuJc1pwx1dSmlgTeOBLfnz8GGtgaptQr5IG
         ITwuwyB+sIFyUAJFAkmKi3T77+vp5M96noMDzbvC00X2I5ZoS4GuXezW4UIIdMStzCy7
         UhL5iFPwwj6DEb88IjeCEYms+Yw7pgKoSXEPAxM9gtg/VLjC54FEN0L19RLcWeQ6zSb8
         5c3YzD5m+1CGHzrgphCKUD/ql3hGKjaD2NPNkbTfDCVNeWBNVmLDScP9MMHV3aXxfjeh
         Q9Y61Bf8v+2YH+AApMJwSuXj4L2ehJQJEsuzAZ7My5lbqbWCV25/2pY0138sU5R+p/yx
         Z5gg==
X-Gm-Message-State: AOJu0YzW2fHMFdkuS7oBaR/o43u4UCgKmf64YaYTTAtVqBzUdf8sXrsu
        dVIi9dIdCHZ7QT0rp68b6ct3KgfWTqY=
X-Google-Smtp-Source: AGHT+IHAT5eAXs0OaMM9X2ywWIX9bE+jyDw4UB13bEFULtdfpf3ZE2T5zvAD66+57RF8WEXQFMTqwQ==
X-Received: by 2002:a67:cc16:0:b0:45f:8b65:28e2 with SMTP id q22-20020a67cc16000000b0045f8b6528e2mr8060279vsl.32.1699973562333;
        Tue, 14 Nov 2023 06:52:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c4-20020a05621401c400b006754772bfd4sm2944138qvt.21.2023.11.14.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:52:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Nov 2023 06:52:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: (aspeed-pwm-tacho) Fix -Wstringop-overflow
 warning in aspeed_create_fan_tach_channel()
Message-ID: <6a28c219-b047-411b-ab43-02fc8f1824db@roeck-us.net>
References: <ZVJ7JBFoULzY3VGx@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVJ7JBFoULzY3VGx@work>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:38:12PM -0600, Gustavo A. R. Silva wrote:
> Based on the documentation below, the maximum number of Fan tach
> channels is 16:
> 
> Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt:45:
>  45 - aspeed,fan-tach-ch : should specify the Fan tach input channel.
>  46                 integer value in the range 0 through 15, with 0 indicating
>  47                 Fan tach channel 0 and 15 indicating Fan tach channel 15.
>  48                 At least one Fan tach input channel is required.
> 
> However, the compiler doesn't know that, and legitimaly warns about a potential
> overwrite in array `u8 fan_tach_ch_source[16]` in `struct aspeed_pwm_tacho_data`,
> in case `index` takes a value outside the boundaries of the array:
> 

All that doesn't warrant introducing checkpatch warnings.

> drivers/hwmon/aspeed-pwm-tacho.c:
> 179 struct aspeed_pwm_tacho_data {
> ...
> 184         bool fan_tach_present[16];
> ...
> 193         u8 fan_tach_ch_source[16];
> ...
> 196 };
> 
> In function ‘aspeed_create_fan_tach_channel’,
>     inlined from ‘aspeed_create_fan’ at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
>     inlined from ‘aspeed_pwm_tacho_probe’ at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
> drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>   751 |                 priv->fan_tach_ch_source[index] = pwm_source;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> drivers/hwmon/aspeed-pwm-tacho.c: In function ‘aspeed_pwm_tacho_probe’:
> drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object ‘fan_tach_ch_source’ of size 16
>   193 |         u8 fan_tach_ch_source[16];
>       |            ^~~~~~~~~~~~~~~~~~
> 
> Fix this by sanity checking `index` before using it to index arrays of
> size 16 elements in `struct aspeed_pwm_tacho_data`. Also, and just for
> completeness, add a `pr_err()` message to display in the unlikely case
> `0 > index >= 16`.
> 
> This is probably the last remaining -Wstringop-overflow issue in the
> kernel, and this patch helps with the ongoing efforts to enable such
> compiler option globally.
> 

I am sorry, but this description almost completely misses the point.
The real issue is that the values in aspeed,fan-tach-ch are not range
checked, which can cause real problems if is elements are set to values
larger than 15. This is a real problem and has nothing to do with string
overflows.

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 997df4b40509..092a81916325 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -166,6 +166,8 @@
>  
>  #define MAX_CDEV_NAME_LEN 16
>  
> +#define MAX_ASPEED_FAN_TACH_CHANNELS 16
> +
>  struct aspeed_cooling_device {
>  	char name[16];
>  	struct aspeed_pwm_tacho_data *priv;
> @@ -181,7 +183,7 @@ struct aspeed_pwm_tacho_data {
>  	struct reset_control *rst;
>  	unsigned long clk_freq;
>  	bool pwm_present[8];
> -	bool fan_tach_present[16];
> +	bool fan_tach_present[MAX_ASPEED_FAN_TACH_CHANNELS];
>  	u8 type_pwm_clock_unit[3];
>  	u8 type_pwm_clock_division_h[3];
>  	u8 type_pwm_clock_division_l[3];
> @@ -190,7 +192,7 @@ struct aspeed_pwm_tacho_data {
>  	u16 type_fan_tach_unit[3];
>  	u8 pwm_port_type[8];
>  	u8 pwm_port_fan_ctrl[8];
> -	u8 fan_tach_ch_source[16];
> +	u8 fan_tach_ch_source[MAX_ASPEED_FAN_TACH_CHANNELS];
>  	struct aspeed_cooling_device *cdev[8];
>  	const struct attribute_group *groups[3];
>  };
> @@ -746,10 +748,14 @@ static void aspeed_create_fan_tach_channel(struct aspeed_pwm_tacho_data *priv,
>  
>  	for (val = 0; val < count; val++) {
>  		index = fan_tach_ch[val];
> -		aspeed_set_fan_tach_ch_enable(priv->regmap, index, true);
> -		priv->fan_tach_present[index] = true;
> -		priv->fan_tach_ch_source[index] = pwm_source;
> -		aspeed_set_fan_tach_ch_source(priv->regmap, index, pwm_source);
> +		if (index < MAX_ASPEED_FAN_TACH_CHANNELS) {
> +			aspeed_set_fan_tach_ch_enable(priv->regmap, index, true);
> +			priv->fan_tach_present[index] = true;
> +			priv->fan_tach_ch_source[index] = pwm_source;
> +			aspeed_set_fan_tach_ch_source(priv->regmap, index, pwm_source);
> +		} else {
> +			pr_err("Invalid Fan Tach input channel %u\n.", index);

This should use dev_err() (and, yes, that means dev needs to be passed
as argument), and the function should return -EINVAL if this is
encountered. Also, error handling should come first.

		if (index >= MAX_ASPEED_FAN_TACH_CHANNELS) {
			dev_err(dev, "Invalid Fan Tach input channel %u\n.", index);
			return -EINVAL;
		}

Thanks,
Guenter
