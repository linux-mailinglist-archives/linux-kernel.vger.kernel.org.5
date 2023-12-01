Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6A800275
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377273AbjLAEMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjLAEMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:12:53 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B16E1716;
        Thu, 30 Nov 2023 20:12:58 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2f4a5ccebso64912b6e.3;
        Thu, 30 Nov 2023 20:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403977; x=1702008777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+DXWDIQ3qhI+UlY7b1G8hCKnQvk1vPVwzZNzUId0ohQ=;
        b=FzoWflA7JTWUQUWtGCiobdv7Vdzmt40mVtHzZxsWix5Zu00v7O110FxZcYpvMi1We2
         9xdLsUyVLY4qC1QxVjjmkR05DTUtFiJ8/uiOJaJxrjff+ytm6ghKGz7H86+hX67b9NTU
         sT+1FsW8IQhqkNyg1YbTJAPp2duFhP0mFNld4j/iBtehLrl3cgCHDkHDQliLWaEn5uz9
         gwIEjbVw/X8Eh8Rr/1gqprgBVa/zg1NOQBXv5GKlChsciX4+sZlpQ1R4QRhG9bH2Lt8D
         rkYd8RBvpsi9b02FRPw1JiIrB2dk/CGyS+F7Be4h+RIHKuiYSbR4YSpTBPzO0ZmapfZe
         zAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403977; x=1702008777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DXWDIQ3qhI+UlY7b1G8hCKnQvk1vPVwzZNzUId0ohQ=;
        b=HX+dEsBNOXZLAqiYPctmFuZ58fjyv7gu6PF0lYYkh/mvBYxxWtgTk6T0c5171nK1KU
         SITbRloQ2YbwgovtdIHFv0vp112sPoooqaDzXHa1mzlRjNLc2QUFYU2Vn1xpiexhVJfP
         E+gIpbuUdJIiFEKCHgG+bVHdkF0BR/rPZ6ELoLxF5Vil/R1sEjaMAHO96+MgdsF2xE7V
         CV27diIqfqmmS7fXuPSYrRn/UEjT0/XzjSwDYgZcFPXSdsASI96Zaj1ZGA3BNK5y37gN
         ArKqn8U6caxInNT6qz0KCI0ee74fB2f41DMe3o7N4f5lRolCTAUb1d54bw7PglXEDuKY
         gTLQ==
X-Gm-Message-State: AOJu0YzZirte13cQyqH1veFOTRvEsjdaaCyH6OZ8xdhxs+VHu5Y2NwI6
        1uEOwJUAxD88sFXfosmcn/B4fJKn6L8=
X-Google-Smtp-Source: AGHT+IGTpktDZifedzjnpzgtVKOTwr9JSEXl9SgPVLZPRG2lTpKtRkVvFHU90AR7dBk7Pw+5PFL2dg==
X-Received: by 2002:a05:6870:c10f:b0:1fa:de51:f90c with SMTP id f15-20020a056870c10f00b001fade51f90cmr2404817oad.15.1701403977621;
        Thu, 30 Nov 2023 20:12:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r3-20020a05683001c300b006cd099bb052sm374157ota.1.2023.11.30.20.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:12:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 30 Nov 2023 20:12:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (acpi_power_meter) Fix 4.29 MW bug
Message-ID: <b56e07aa-526c-4cf1-9e39-474aac78a844@roeck-us.net>
References: <20231124182747.13956-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124182747.13956-1-W_Armin@gmx.de>
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

On Fri, Nov 24, 2023 at 07:27:47PM +0100, Armin Wolf wrote:
> The ACPI specification says:
> 
> "If an error occurs while obtaining the meter reading or if the value
> is not available then an Integer with all bits set is returned"
> 
> Since the "integer" is 32 bits in case of the ACPI power meter,
> userspace will get a power reading of 2^32 * 1000 miliwatts (~4.29 MW)
> in case of such an error. This was discovered due to a lm_sensors
> bugreport (https://github.com/lm-sensors/lm-sensors/issues/460).
> Fix this by returning -ENODATA instead.
> 
> Tested-by: <urbinek@gmail.com>
> Fixes: de584afa5e18 ("hwmon driver for ACPI 4.0 power meters")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/acpi_power_meter.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> --
> 2.39.2
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 8db740214ffd..703666b95bf4 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -31,6 +31,7 @@
>  #define POWER_METER_CAN_NOTIFY	(1 << 3)
>  #define POWER_METER_IS_BATTERY	(1 << 8)
>  #define UNKNOWN_HYSTERESIS	0xFFFFFFFF
> +#define UNKNOWN_POWER		0xFFFFFFFF
> 
>  #define METER_NOTIFY_CONFIG	0x80
>  #define METER_NOTIFY_TRIP	0x81
> @@ -348,6 +349,9 @@ static ssize_t show_power(struct device *dev,
>  	update_meter(resource);
>  	mutex_unlock(&resource->lock);
> 
> +	if (resource->power == UNKNOWN_POWER)
> +		return -ENODATA;
> +
>  	return sprintf(buf, "%llu\n", resource->power * 1000);
>  }
