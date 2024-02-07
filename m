Return-Path: <linux-kernel+bounces-56094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AF84C5DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77EE1C21F71
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60EE200BD;
	Wed,  7 Feb 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec1P0rwr"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F10200AC;
	Wed,  7 Feb 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292679; cv=none; b=XmAEhSKCFIpqDt7kFufv/prvE3YDqwAZUXWKDgEPTsw8FUSRIZ2BkPuAlB5ex+8nhb+A6+SDq+Hxt5iAuo1JeoWuP/bndcP8XflxsqgQ5S4QalIzBDhKSrl2hIPKxDOP7yCIZgETqe9FYujgErPJfxTkggqJYHrHoIBGqwKTrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292679; c=relaxed/simple;
	bh=rjWBgcSirSxeB63xKQnjPtAD1NzTaKfcIDTiS95daPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAJ25jSpiUHHacT6HZFWM5KqxAExBQbZnN2ss9KzNRrEAufIERz1BaiNputfnQ0YrxF4CbwaQXI5BaLy1czI0l3RiFDscUgKkYvOuin6tzo6T34uu/QjEpa5gtVaZ6D9E4GPYXF80eejJajP9KytWWFSlWpJJ4kscveEqJE+jfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec1P0rwr; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51142b5b76dso523175e87.2;
        Tue, 06 Feb 2024 23:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707292676; x=1707897476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faw62muK8rMq99LhU7XEIx44p0VAUyI8BL+QRChVvwA=;
        b=Ec1P0rwr9lDiiDKc27yzxxzqsjJfEJ95zvePusTi2xPTaJ/e2v4WhKT8uWet+0pZ2w
         +dvv62TqzXRTo/xRB0b/d6HUSHPYtcfTz+h8x7DCXW60QVa4L2u3TiV8nqEoJks+jQF9
         P9NhpqiE4nhJ0VkuzLb+3JT0DIYAzKdEk0iiP+Vb6vjJgGOSnTAYqOt8shOlBK5JtZNs
         R//DdjtFwWGVEqYNzaEFo3K82qNwGWREsdQRy4s64/UUgKtLAy7U8aZCQepVU+rJzvb5
         p/uoA5/jiWxlfUd8BYr7rpKx3McMbROKv2ch/rRfTgwNLlIFBaBZAjk6eMoNdVBLkme8
         geBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292676; x=1707897476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faw62muK8rMq99LhU7XEIx44p0VAUyI8BL+QRChVvwA=;
        b=N3TSJIMAqpz8PofcJGO32jLYA/bgMIIALGz6P06WHzwH89Kw8JgOsWe//WY2z17cyO
         ZAooLL4Q6Uj1xvYOBDmUyTc4TgoysPNP/e0fEXpJbRmrnuEdth8k73euKJKnIkYDYRvm
         AI3kNkTI3sRdX6LpvftgbrLrf411Xjdb3nfgEx2ajYVzVZcR/NWJmwNXDYVrPmTtoq4Y
         dq4AHnGNFMkU2HAKgoNxm+0HLltGCksFjIYUie21g43twbJmabJ5oUrZmRWxXTJ3S4BG
         L+UHvi+V3v92tc2k5qzYfluc1FxqgDTmFEY8aWXt2j2RtH8cAK0etMSLNQBxn0Ldtg7Q
         DQxA==
X-Gm-Message-State: AOJu0YywrzDTBaTKYZH41ypWR4vsIP7+as4SNwIATgQ9MDNIXdpY/srX
	z0YQ2yZM6kVaIx7MTBYXY4cIMfM2F37fNzknEUi8K16F831ILEi8
X-Google-Smtp-Source: AGHT+IHrOG4ej7Nc8ic00cewvUn2sqV1hsMqwojBzY8/6TzL9zMPEDbPRaGu93Tp6EIf/bcp6ZT7zw==
X-Received: by 2002:ac2:42d5:0:b0:511:5b47:1fe8 with SMTP id n21-20020ac242d5000000b005115b471fe8mr3472289lfl.6.1707292676205;
        Tue, 06 Feb 2024 23:57:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCJTQDT9qidD5GSnJxXCfNIUbZHTrA3J5SEMhoGXkwZ8UHtixP6Uu2E0dmz4PJCKV0lED018lrWOuIW368bJFU2nzD5CDed1ZTSKe19z8Dczg0RB0oxZ18Tfzbw8jOsM3Vb4ps4gOqQxHxVRB2ycP8l0JoiKbzhUHUzu9kY77hcC/6ESLjmv6wB3ujRzYOM6FqR2iizc7p/MiKL8nGcQIzct0Kx7YECuXvtTQ9NaYsOxZ7IWQSOGJ0UUs/qUnnVg+iZGKxQ9qxnhKxDng2I6N/+oAD7xAqY6oz5HYas2dUWL2SvBTcPKkJUSKrP3NFocMBv1vjMJMPfX2e4ZOZ4mIxqR6h3uNnOeEUhALQJzGRZKTpfZ08hHuHVBkhqayVq00SB/lUS+4ITMiHqiFEm13zTZ25gt09zSGyk6LunSj+PVdw8u9Ovw4jIvD7iw75kK35MgkLo5fULXOjp3QV9olbvzUPtuN9c6s/lPW7tFOpXimlnGV/BItO7P8F3p3D9N1AgDPOCYl4+5jazyW5qGeUF53lIBl6lzWtfX2/BcIkjPP/p5Apwv7TNC21ji4rpHUfe/ZK1E+L/gXrM8DcgkQUMOIzkVQBh8bYZjJ5tOE=
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id n2-20020a056512310200b0051140df84fdsm96155lfb.12.2024.02.06.23.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 23:57:55 -0800 (PST)
Message-ID: <ab8d9d0a-aad4-42b7-9e24-9ae6acf7c939@gmail.com>
Date: Wed, 7 Feb 2024 09:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] mfd: rohm: convert to use maple tree register cache
Content-Language: en-US, en-GB
To: Bo Liu <liubo03@inspur.com>, lee@kernel.org, wens@csie.org,
 marek.vasut+renesas@gmail.com, support.opensource@diasemi.com,
 neil.armstrong@linaro.org, ckeepax@opensource.cirrus.com,
 rf@opensource.cirrus.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-amlogic@lists.infradead.org, patches@opensource.cirrus.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240206071314.8721-1-liubo03@inspur.com>
 <20240206071314.8721-12-liubo03@inspur.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240206071314.8721-12-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 09:13, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/mfd/rohm-bd71828.c | 4 ++--
>   drivers/mfd/rohm-bd718x7.c | 2 +-
>   drivers/mfd/rohm-bd9576.c  | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index 594718f7e8e1..2f3826c7eef4 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -197,7 +197,7 @@ static const struct regmap_config bd71815_regmap = {
>   	.val_bits = 8,
>   	.volatile_table = &bd71815_volatile_regs,
>   	.max_register = BD71815_MAX_REGISTER - 1,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   };
>   
>   static const struct regmap_config bd71828_regmap = {
> @@ -205,7 +205,7 @@ static const struct regmap_config bd71828_regmap = {
>   	.val_bits = 8,
>   	.volatile_table = &bd71828_volatile_regs,
>   	.max_register = BD71828_MAX_REGISTER,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   };
>   
>   /*
> diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
> index 4798bdf27afb..7755a4c073bf 100644
> --- a/drivers/mfd/rohm-bd718x7.c
> +++ b/drivers/mfd/rohm-bd718x7.c
> @@ -87,7 +87,7 @@ static const struct regmap_config bd718xx_regmap_config = {
>   	.val_bits = 8,
>   	.volatile_table = &volatile_regs,
>   	.max_register = BD718XX_MAX_REGISTER - 1,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   };
>   
>   static int bd718xx_init_press_duration(struct regmap *regmap,
> diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
> index bceac7016740..3a9f61961721 100644
> --- a/drivers/mfd/rohm-bd9576.c
> +++ b/drivers/mfd/rohm-bd9576.c
> @@ -62,7 +62,7 @@ static struct regmap_config bd957x_regmap = {
>   	.val_bits = 8,
>   	.volatile_table = &volatile_regs,
>   	.max_register = BD957X_MAX_REGISTER,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>   };
>   
>   static struct regmap_irq bd9576_irqs[] = {

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


