Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1CA800274
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377286AbjLAEKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAEKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:10:08 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060D3170D;
        Thu, 30 Nov 2023 20:10:15 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d80245b6easo78576a34.0;
        Thu, 30 Nov 2023 20:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403814; x=1702008614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeJ0c3RUv4jjb0SvVuSw/xpR4wIt1CuAtS9Ij1Uy17Q=;
        b=Pq9/VB/gmUX35F2GRj19k6tp7FzNjgauWrDOd0JUH9n1/kOIa09sKEOotJvPziD4Tn
         oI41gJoLyD7ymM742kd+Sw+2K/PzQWS2mpQ3OGT6Etr3+FZiRNDFNN0cWVYaNo/sUPlS
         EUDiNIm4vw88XW1OjjGmkLF8+MjEkL3XkY2lBXTALZLPUuCVztDYm5fJJfLRT0Ynz/Rg
         0MjdGz4wgkwADCd+OYqJ2u0fwG0P3ZFPir5p4nz0g6SSQQo/u3+fMogrTXOK+lWu3EDq
         BtlCnIJfbbz6qqvpYRbvAgqKR2zUfh0+Zmu/4o3nkUvguYjEeJfSe/A6bJFhMTd7uv7X
         Vb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403814; x=1702008614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeJ0c3RUv4jjb0SvVuSw/xpR4wIt1CuAtS9Ij1Uy17Q=;
        b=v0ij+pFPH1HMMddU67sndFmq8UCUDFcnOTErttzv0gcT4DdnMo8+6zppXxA9BZDn1v
         wKLJ17bnvXJh04FXrPanUvSsoJpvBQdd0hirwFjtt4ljLnK/85P6xoLV0GovJS/Mrjl0
         c49qA4RWJwC7gy1Ae60Ga2dSb5FskWPuapEBbwu9jIfo3VXX4J8X6DxyaRd4C78yEeD9
         6SdowNstrDldHmyrsJM03UNoghwNCKaSotCtC7poN4QiOVgK33kUGEnkb9fEGZNAkgAk
         gP3UB3qDas3NgkWAomZPBHPbE4hdbk7hpNMguRVeDRImPQ2dMZbxP21soLsYdGFXKSoe
         T7iQ==
X-Gm-Message-State: AOJu0YxC3t3r+5T/XtV7iVv1eSSbLXfdiYeWnmUiiCX4LpU+GdCoZgMy
        yYFaYW8UgFywwn3OE0z5ckLgz8HoiAk=
X-Google-Smtp-Source: AGHT+IFzI/GDsnTWzVIINXcxcorMSxvP9rns1sSnOPzCujv+o9fCRshalaUqFwWdTR2kudsbpkBwwg==
X-Received: by 2002:a9d:7d8c:0:b0:6d6:480c:e7dc with SMTP id j12-20020a9d7d8c000000b006d6480ce7dcmr1541593otn.36.1701403814261;
        Thu, 30 Nov 2023 20:10:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t6-20020a9d66c6000000b006d855e2c56csm377036otm.31.2023.11.30.20.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:10:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Nov 2023 20:10:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 2/3] hwmon: tmp513: Simplify with dev_err_probe()
Message-ID: <1ef66c53-d9ba-4fca-8462-b670f029f5de@roeck-us.net>
References: <20231128180654.395692-1-andriy.shevchenko@linux.intel.com>
 <20231128180654.395692-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128180654.395692-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:06:03PM +0200, Andy Shevchenko wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, but ...

> ---
>  drivers/hwmon/tmp513.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
> index 849a8c3e1020..6e01800404fc 100644
> --- a/drivers/hwmon/tmp513.c
> +++ b/drivers/hwmon/tmp513.c
> @@ -630,9 +630,9 @@ static int tmp51x_vbus_range_to_reg(struct device *dev,
>  	} else if (data->vbus_range_uvolt == TMP51X_VBUS_RANGE_16V) {
>  		data->shunt_config &= ~TMP51X_BUS_VOLTAGE_MASK;
>  	} else {
> -		dev_err(dev, "ti,bus-range-microvolt is invalid: %u\n",
> -			data->vbus_range_uvolt);
> -		return -EINVAL;
> +		return dev_err_probe(dev, -EINVAL,
> +				     "ti,bus-range-microvolt is invalid: %u\n",
> +				     data->vbus_range_uvolt);
>  	}
>  	return 0;
>  }
> @@ -648,8 +648,8 @@ static int tmp51x_pga_gain_to_reg(struct device *dev, struct tmp51x_data *data)
>  	} else if (data->pga_gain == 1) {
>  		data->shunt_config |= CURRENT_SENSE_VOLTAGE_40_MASK;
>  	} else {
> -		dev_err(dev, "ti,pga-gain is invalid: %u\n", data->pga_gain);
> -		return -EINVAL;
> +		return dev_err_probe(dev, -EINVAL,
> +				     "ti,pga-gain is invalid: %u\n", data->pga_gain);
>  	}
>  	return 0;
>  }
> @@ -679,9 +679,9 @@ static int tmp51x_read_properties(struct device *dev, struct tmp51x_data *data)
>  
>  	// Check if shunt value is compatible with pga-gain
>  	if (data->shunt_uohms > data->pga_gain * 40 * 1000 * 1000) {
> -		dev_err(dev, "shunt-resistor: %u too big for pga_gain: %u\n",
> -			data->shunt_uohms, data->pga_gain);
> -		return -EINVAL;
> +		return dev_err_probe(dev, -EINVAL,
> +				     "shunt-resistor: %u too big for pga_gain: %u\n",
> +				     data->shunt_uohms, data->pga_gain);
>  	}
>  
>  	return 0;
> @@ -721,22 +721,16 @@ static int tmp51x_probe(struct i2c_client *client)
>  	data->max_channels = (uintptr_t)i2c_get_match_data(client);
>  
>  	ret = tmp51x_configure(dev, data);
> -	if (ret < 0) {
> -		dev_err(dev, "error configuring the device: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "error configuring the device\n");
>  
>  	data->regmap = devm_regmap_init_i2c(client, &tmp51x_regmap_config);
> -	if (IS_ERR(data->regmap)) {
> -		dev_err(dev, "failed to allocate register map\n");
> -		return PTR_ERR(data->regmap);
> -	}
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "failed to allocate register map\n");

That line length was getting too long. Please consider running checkpatch
on your patches.

Guenter
