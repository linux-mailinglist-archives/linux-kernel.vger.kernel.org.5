Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2BA7D8523
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345327AbjJZOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjJZOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:42 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09661AA;
        Thu, 26 Oct 2023 07:48:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a84204e7aeso7539427b3.0;
        Thu, 26 Oct 2023 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698331720; x=1698936520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSDX+BdSMVWh1l8Isu6QYqyAP7slLBrrW6u7owXfVjE=;
        b=U6cuCtqKqDX+VIjCwVOiX9f++cApI6LNupUfPzuAGCdS/jm9I8C9O2YU4Mhqm4a2WH
         RnJEfmI0v4+mJ9jn6wHNLGMJUNOHYOfAVVu0UFUALSkGptiHFhL4gvJCiPRSsDj5vWnd
         Dkyrlgp1fqu0tzndZPXCjujMpeDq6HCzclC2h1wli5N9ofcpzaAEMNSUnc4AwhjY1Z5N
         widoqappFWaIlVvTB24g6qzohSIuJoshmvWZs+fPAOWeVYoLu2jnQS+YYuNNhGKJCBbn
         HmOTj6GoNYbcyOzL5DGWwqhLsFyxQ9nMD6YZ2k9oCrtTngjIPVWL+Z6jjhV6p5RroOVs
         KMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331720; x=1698936520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSDX+BdSMVWh1l8Isu6QYqyAP7slLBrrW6u7owXfVjE=;
        b=dg5ZaQEFN+dRRN7zwZgpL4wArTTr+ZjaQtkwXRh+OpwPMZMIviEbrHRW8dCkJAjZ3D
         tGTRNnS27ifQXrvZmASKy4Hp7/V3lexP8QqRlMUQQSvWh78/WMXP7PJ7ufYUJSWP5XII
         maDW9KbBn/K9Og+TWLX/jHoIcKfr44x2e6NF6qUYC2hXLgi3HqQWImTkgzJHtJsvueBT
         zMM8nnaEEHWxUJra4IGChkVcOCAGagPEnQ/055ABPlivwNHrKkduyy7nMIPGWZvlvAo+
         mPy1XSWIbuYVP1D7wtm/b6qbOyWtCzF2ewezxkOlr+PhWsvPTuMcEUwmHraMrje6jvad
         n+ow==
X-Gm-Message-State: AOJu0YyVwEZEKhrxbbfPmIpG4NfoGqWhLuVQqzhZxBMlV1+JEHA5rIDI
        US0LvSM8ssEQTtIW0U+sXuU=
X-Google-Smtp-Source: AGHT+IF1OoaoNzlVGhA9F+49qkBW5al0SKgEJ58oOccdqD1KCOaAk1TGB7CedKNLIuSaLBuTZOMuYA==
X-Received: by 2002:a0d:d082:0:b0:5a7:bc0e:193e with SMTP id s124-20020a0dd082000000b005a7bc0e193emr22915013ywd.18.1698331719802;
        Thu, 26 Oct 2023 07:48:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9-20020a817909000000b00577269ba9e9sm61672ywc.86.2023.10.26.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:48:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 26 Oct 2023 07:48:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Richard Leitner <richard.leitner@linux.dev>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: ina238: add ina237 support
Message-ID: <0cdb53e9-6651-4201-b110-e788ff8a036e@roeck-us.net>
References: <20231026-ina237-v2-0-dec44811a3c9@linux.dev>
 <20231026-ina237-v2-1-dec44811a3c9@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231026-ina237-v2-1-dec44811a3c9@linux.dev>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:08:49AM +0200, Richard Leitner wrote:
> The INA237 "85-V, 16-Bit, Precision Power Monitor With I2C Interface" is
> basically the same as INA328. Therefore add a corresponding compatible
> to the driver.
> 
> According to the datasheet the main difference is the current and power
> monitoring accuracy:
> 
> +------------------------+---------------+---------------+
> |                        | INA238        | INA237        |
> +------------------------+---------------+---------------+
> | Offset voltage         | +/- 5µV       | +/- 50µV      |
> | Offset drift           | +/- 0.02µV/°C | +/- 0.02µV/°C |
> | Gain error             | +/- 0.1%      | +/- 0.3%      |
> | Gain error drift       | +/- 25ppm/°C  | +/- 50ppm/°C  |
> | Common mode rejection  | 140dB         | 120dB         |
> | Power accuracy         | 0.7%          | 1.6%          |
> +------------------------+---------------+---------------+
> 
> As well as the missing DEVICE_ID register at 0x3F, which is currently
> not in use by the driver.
> 
> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina238.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
> index f519c22d3907..ca9f5d2c811b 100644
> --- a/drivers/hwmon/ina238.c
> +++ b/drivers/hwmon/ina238.c
> @@ -33,7 +33,7 @@
>  #define INA238_BUS_UNDER_VOLTAGE	0xf
>  #define INA238_TEMP_LIMIT		0x10
>  #define INA238_POWER_LIMIT		0x11
> -#define INA238_DEVICE_ID		0x3f
> +#define INA238_DEVICE_ID		0x3f /* not available on INA237 */
>  
>  #define INA238_CONFIG_ADCRANGE		BIT(4)
>  
> @@ -622,6 +622,7 @@ static const struct i2c_device_id ina238_id[] = {
>  MODULE_DEVICE_TABLE(i2c, ina238_id);
>  
>  static const struct of_device_id __maybe_unused ina238_of_match[] = {
> +	{ .compatible = "ti,ina237" },
>  	{ .compatible = "ti,ina238" },
>  	{ },
>  };
