Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE097F644F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjKWQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:44:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0606310E9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:44:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08106C433CA;
        Thu, 23 Nov 2023 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700757856;
        bh=ImzGxZz1+Yd4REFJZFfP68zE0RJ1ASyKw9Dfn46Maeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBV3OZSTJqqlNvEf9jzb2k5QPIVDS9Cs8eEQptrt7GUDdhm55g4HJVfxT3jAyRD7/
         onfX3wRrayYUJ/LabVoFD9KpSr+05r3BmB3cqZRUV5BGozw9spXtwOJcWp5x9E7ADt
         /+f9XCSsnWzNVJbRAhRXruo4S442qNLuNt3HW1fxOZAL+lb47k7UPD6tj9cSBd99aa
         A3aqRCFO2b4sSxV5Dn7zMwe82l3IvcyCaAbLiqAu1aOrDZPwgMxOhdfU1LfkFUqvCC
         55u84UNwDsFH2qCqo/fqrV1GLruPpdcyt0mtVPu9wiC2Pv+1TLj34cdv8H/iweCk+3
         zvNAfAIRc5WCg==
Date:   Thu, 23 Nov 2023 16:44:10 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v4 09/11] leds: aw200xx: add support for aw20108 device
Message-ID: <20231123164410.GH1354538@google.com>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
 <20231121202835.28152-10-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121202835.28152-10-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Dmitry Rokosov wrote:

> From: George Stark <gnstark@salutedevices.com>
> 
> Add support for Awinic aw20108 device from the same LED drivers family.
> New device supports 108 LEDs using a matrix of 12x9 outputs.
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/leds/Kconfig        | 14 +++++++++-----
>  drivers/leds/leds-aw200xx.c | 10 +++++++++-
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6046dfeca16f..a879628e985c 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -95,14 +95,18 @@ config LEDS_ARIEL
>  	  Say Y to if your machine is a Dell Wyse 3020 thin client.
>  
>  config LEDS_AW200XX
> -	tristate "LED support for Awinic AW20036/AW20054/AW20072"
> +	tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
>  	depends on LEDS_CLASS
>  	depends on I2C
>  	help
> -	  This option enables support for the AW20036/AW20054/AW20072 LED driver.
> -	  It is a 3x12/6x9/6x12 matrix LED driver programmed via
> -	  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> -	  3 pattern controllers for auto breathing or group dimming control.
> +	  This option enables support for Awinic AW200XX LED controller.

"for ..." THE or AN.

Or put an 's' at the end of "controller".

> +	  It is a matrix LED driver programmed via an I2C interface. Devices have
> +	  a set of individually controlled leds and support 3 pattern controllers

LEDs

> +	  for auto breathing or group dimming control. Supported devices:
> +	    - AW20036 (3x12) 36 LEDs
> +	    - AW20054 (6x9)  54 LEDs
> +	    - AW20072 (6x12) 72 LEDs
> +	    - AW20108 (9x12) 108 LEDs
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-aw200xx.
> diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> index c48aa11fd411..4b5036360887 100644
> --- a/drivers/leds/leds-aw200xx.c
> +++ b/drivers/leds/leds-aw200xx.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Awinic AW20036/AW20054/AW20072 LED driver
> + * Awinic AW20036/AW20054/AW20072/AW20108 LED driver
>   *
>   * Copyright (c) 2023, SberDevices. All Rights Reserved.
>   *
> @@ -620,10 +620,17 @@ static const struct aw200xx_chipdef aw20072_cdef = {
>  	.display_size_columns = 12,
>  };
>  
> +static const struct aw200xx_chipdef aw20108_cdef = {
> +	.channels = 108,
> +	.display_size_rows_max = 9,
> +	.display_size_columns = 12,
> +};
> +
>  static const struct i2c_device_id aw200xx_id[] = {
>  	{ "aw20036" },
>  	{ "aw20054" },
>  	{ "aw20072" },
> +	{ "aw20108" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, aw200xx_id);
> @@ -632,6 +639,7 @@ static const struct of_device_id aw200xx_match_table[] = {
>  	{ .compatible = "awinic,aw20036", .data = &aw20036_cdef, },
>  	{ .compatible = "awinic,aw20054", .data = &aw20054_cdef, },
>  	{ .compatible = "awinic,aw20072", .data = &aw20072_cdef, },
> +	{ .compatible = "awinic,aw20108", .data = &aw20108_cdef, },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, aw200xx_match_table);
> -- 
> 2.36.0
> 

-- 
Lee Jones [李琼斯]
