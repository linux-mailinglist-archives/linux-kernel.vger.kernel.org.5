Return-Path: <linux-kernel+bounces-75236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBAA85E503
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5582843EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1D184FDF;
	Wed, 21 Feb 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpTetLSO"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF384A45
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538184; cv=none; b=TqFKTJEmdQKYhWGoRQgc7a8W9525UsNdjmLHHYREOOe+JvrFlEFju1r2Gc0ohBoey+QJhsIqd0NnuyzBVAITZgcNYpr4Ahyrb//5+uPzDj2QyEDsbkCr/I/6LpnWpC9xoTc6VdqzRuDFOT9Rc23Xj+Z8Nhi/+FCmpw0MsGTWSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538184; c=relaxed/simple;
	bh=BVFBq8MbvqfaIxtlUennLRCVo9CZPL/TUigQ6CV2aZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rH9dA7xsAfKQ2Q1plYspfEnIPP21FgAGtIweeWmzYYtWu9qbGvAAlr803g6cgXvsgrfYkYnFsv86NvAKyG4JkkH2d2aXw3J9wf+7NOug19ubUvVV6K43WGVJ29r74T6Mr+po4VqCio0j46rSwTCK7oh2u5YvbXdvuPk2f6Ifya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PpTetLSO; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so1377682a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708538179; x=1709142979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=it/RVOfJK4MjxrALV/dDH3SHkP5fEcXIOdKDJod6bwg=;
        b=PpTetLSOkvJvzbUgo7YABJIGoDL0eqEBVZ/64PwD9QaSovxw8cYNI2WSJOdR64S9Bm
         xNYCZPwkAFm2I2nN+Aw5AQ6yBUAebcB7AwypfqPg01YzfIR9+RHAkVRlZPOB/+WieTNi
         Zhdtq55BSmPvm2J3L3FzyFlFZNkZw73D4oD9kTeX/0+1gj88X2mmjxkEAughodEjJPPN
         zy95aig64qgaxsgha4wT4xwgnuu8zxmZTzVkucWYEp0H0BsZaQ2HYcJxdcnj6AHyub8Y
         6wM6W88XZWTFHF65OT2TmpITydBK7Pmpjiot3O7m9+OaOanTuo1Vy73UwzkaWvNiLYPU
         MmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538179; x=1709142979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=it/RVOfJK4MjxrALV/dDH3SHkP5fEcXIOdKDJod6bwg=;
        b=PL8o5ZCRf8s+k6Fjo4MYXDrdSXTo+zFSveQr1RT49UMEWqhHYKgCNblkhIbe1e8w2m
         vp8Z9AM5XTf80uHeUCeL7ipLLE/auanOMCvwsQ8+iyLMC89LXH+tqWA+xYRBgCL21zdA
         70c2WTGqP1ahHya60SusVQNPnrG+L5FESukG/bH1w7Au6wXjqYRMd/0n0tJwFDNnPx8c
         jlpDHUtX6oYVwMEUgYoB7EoFEiEpnAGIfCgMiAQ+0UxgLU1wcVRz+RuuXcZB3AK914da
         Vy/dwpXLsI0BPDZ3tPvRlp8cQ3jhcSTyoTyzRdh+K4CuNigeF4AdsUcPQ5c6HZpgg5+5
         7u+w==
X-Forwarded-Encrypted: i=1; AJvYcCW4jK7W6yT+lvLsXgrmLsWUj0igZ9/MSiJmux1aOAhih2t27tKvz/jqrBs9Fhs7DlfW+8P1W6FOFYoZj6G26itWU5E30xegF6drs0Fk
X-Gm-Message-State: AOJu0YyAj11Cr9NuvJulmMzxD0L5j3RkmUJTiKyLz7Bwx3QyYwhTlada
	lTYWV0OyvYxOWUsgGFONl64ZifLQpEomB6UfjRpvbz2HsEaZbcjze4xmjivf4JE=
X-Google-Smtp-Source: AGHT+IGqE47uiLD78T1yQU2qNPN6dVRDsaT5Rxu1kmz28dCgLQ7tsFftgT+1AISRebYrTKMrx/S7WA==
X-Received: by 2002:a17:906:b094:b0:a3c:a4ba:7917 with SMTP id x20-20020a170906b09400b00a3ca4ba7917mr11807476ejy.0.1708538179316;
        Wed, 21 Feb 2024 09:56:19 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id qo3-20020a170907874300b00a3e4efbfdacsm4234766ejc.225.2024.02.21.09.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 09:56:18 -0800 (PST)
Message-ID: <10f692ae-ac7a-4243-aadc-80712f781d39@linaro.org>
Date: Wed, 21 Feb 2024 17:56:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] spi: s3c64xx: switch exynos850 to new port
 config data
Content-Language: en-US
To: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, semen.protsenko@linaro.org,
 conor+dt@kernel.org
Cc: alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com,
 devicetree@vger.kernel.org
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
 <20240216070555.2483977-13-tudor.ambarus@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240216070555.2483977-13-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hey, Sam,


On 2/16/24 07:05, Tudor Ambarus wrote:
> Exynos850 has the same version of USI SPI (v2.1) as GS101.

I tested GS101 and it worked, I guess exynos850 SPI shall work too as it
uses the same SPI version, v2.1. Can you run a test on your side too see
if works? If not, Mark can drop this patch I guess. Please let us know
your preference.

Cheers,
ta

> Drop the fifo_lvl_mask and rx_lvl_offset and switch to the new port
> config data.
> 
> Backward compatibility with DT is not broken because when alises are
> set:
> - the SPI core will set the bus number according to the alias ID
> - the FIFO depth is always the same size for exynos850 (64 bytes) no
>   matter the alias ID number.
> 
> Advantages of the change:
> - drop dependency on the OF alias ID.
> - FIFO depth is inferred from the compatible. Exynos850 integrates 3 SPI
>   IPs, all with 64 bytes FIFO depths.
> - use full mask for SPI_STATUS.{RX, TX}_FIFO_LVL fields. Using partial
>   masks is misleading and can hide problems of the driver logic.
> 
> Just compiled tested.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 784786407d2e..9fcbe040cb2f 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1576,10 +1576,9 @@ static const struct s3c64xx_spi_port_config exynos5433_spi_port_config = {
>  };
>  
>  static const struct s3c64xx_spi_port_config exynos850_spi_port_config = {
> -	/* fifo_lvl_mask is deprecated. Use {rx, tx}_fifomask instead. */
> -	.fifo_lvl_mask	= { 0x7f, 0x7f, 0x7f },
> -	/* rx_lvl_offset is deprecated. Use {rx, tx}_fifomask instead. */
> -	.rx_lvl_offset	= 15,
> +	.fifo_depth	= 64,
> +	.rx_fifomask	= S3C64XX_SPI_ST_RX_FIFO_RDY_V2,
> +	.tx_fifomask	= S3C64XX_SPI_ST_TX_FIFO_RDY_V2,
>  	.tx_st_done	= 25,
>  	.clk_div	= 4,
>  	.high_speed	= true,

