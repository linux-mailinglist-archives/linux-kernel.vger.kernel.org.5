Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F7F7AD7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjIYMOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjIYMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:14:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1917DB8;
        Mon, 25 Sep 2023 05:14:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3bd829b86so45169965ad.0;
        Mon, 25 Sep 2023 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695644083; x=1696248883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxKaYhEaZx9E0vPmZbL9zU0VqnNEddPreUDBRZnG5zg=;
        b=l2hlEgENReZZuaG8snPx6a8IVoLyf30+QBylFg6gAqdyds4or+DyAZUNUbqZ0YHms9
         l2a6pbu6YvtZO9AiXgXGROxkplQ4qg1MjHLfB9uBFcaPFnvblPXcJJFEugGggmq4JoYB
         XXIUs+zyVlMKCrMUx5FM7/bbYedoq6ggItYks/TGI5k/O8myqaC1heHy1e41CzcZHesj
         0CAaiAf3FAmT8ULKkAxE7HK7hedAjZAOlfsIkvnoFa8RMocM4jJVh051xf5WCeuquAc8
         ObJbLUevqjTBqS8MmYakeJ/q5sBj4fxsi1RwkGuOPV6XlgjUPz2HMAr3wUM6zoKSGVKO
         Qu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695644083; x=1696248883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxKaYhEaZx9E0vPmZbL9zU0VqnNEddPreUDBRZnG5zg=;
        b=HjrQ98L5SppJZ6h7AYrTxhqaxMB4HuGoKcRLyG7zFCRRAKyGy8T1PfNfx6Xn2IMNEk
         6PelJFASYalhm8hPoaZBrxIsJ1u4xW367NjCD0Dumo3NkkIys1eikvC034ouHv7/NkT9
         O6FRNjj0DOvmBAciyaj84TIoSlbaNQofWRYcwYH1ApWF1p2ID14TJ2Bxs9r7XQsVCq/o
         9pykPprBZRPUJVd5pVFk0kpGZe//S/XT3Us81UDaSqYcSPJjZXy0UPTOSvMjUke8GRrB
         2XR+FjTL0UJYQ2MKFunAUqL9EIvqClhXJaiI4kGn1kegkoouxiLzJrZ2GQ16YtL2KA5t
         cdhA==
X-Gm-Message-State: AOJu0YyWTsOXX4IQT0BwrL30FtRf29prIlcazYIKBcDsD/wjTH7le2ru
        LxDiWb5bQjHRZYEedcC2U10=
X-Google-Smtp-Source: AGHT+IFyIV4IUdng/V36nA8tR9I6rFTjRM2Fsv26ngWPxBkzc3QU9DY53feis1/yTYgvbkdlhriv5Q==
X-Received: by 2002:a17:903:24d:b0:1c3:2423:8e24 with SMTP id j13-20020a170903024d00b001c324238e24mr6729850plh.8.1695644083429;
        Mon, 25 Sep 2023 05:14:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f54700b001bdcde49bc3sm8694710plf.119.2023.09.25.05.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 05:14:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Sep 2023 05:14:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers: hwmon: max31827: handle vref regulator
Message-ID: <9dbb6d44-d588-4813-aaf6-7c836bcc91ae@roeck-us.net>
References: <20230925082334.8310-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925082334.8310-1-antoniu.miclaus@analog.com>
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

On Mon, Sep 25, 2023 at 11:23:33AM +0300, Antoniu Miclaus wrote:
> Add missing implementation for the max31827 supply regulator.
> This is a hardware required property that is not handled.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - revert also the dev_err_probe output to use "vref" instead of "vdd".
>  drivers/hwmon/max31827.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index 602f4e4f81ff..2a61fb9a408a 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -427,6 +427,11 @@ static int max31827_probe(struct i2c_client *client)
>  		return dev_err_probe(dev, PTR_ERR(st->regmap),
>  				     "Failed to allocate regmap.\n");
>  
> +	err = devm_regulator_get_enable(dev, "vref");
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to enable vref regulator\n");

Please drop the "vref". "failed to enable regulator" is sufficient.

Guenter

> +
>  	err = max31827_init_client(st);
>  	if (err)
>  		return err;
> -- 
> 2.42.0
> 
