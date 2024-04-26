Return-Path: <linux-kernel+bounces-160309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C98B3BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324E41C23954
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0EE149C4B;
	Fri, 26 Apr 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy4Ip7jz"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DCC18C1F;
	Fri, 26 Apr 2024 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145866; cv=none; b=P9eaipX2/nI1saqlRTMuI9GGSTpC6TZR51QMcK27dxmZRf2ZnnWIktXM8ydDZN5a4cZ6gXg4hdfRAgD6fkQIWgKr/0Lc/sGi/3pXdrEVFLElF8IzJu64wB1XCypl5aAG00NIOcEEqZOD23asDQFjy6AxXDbH4alAXhoCGs0DBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145866; c=relaxed/simple;
	bh=Rck3V7A+RmzHoKveKNNk6Uc4pHjWyyyyaJfC/10inZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/slYgDpoaLXgqlopv3EAx1jPqLhFFfcGzj5vbERIfscMEVSUTMXmeYRj/gLUrQETwn6JeUz2u3U3qfY0HKcA0q+tY4105s3NvobaH4AcobNnbA+URRPCspani788BNb5qVKuoTllp2JeTtZU0z76Vyt9a6IAIbXBbmE5xuY4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy4Ip7jz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so4171695e9.1;
        Fri, 26 Apr 2024 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145863; x=1714750663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fnllMvw5rV4aVeEqjprC/GqDGLK/jA5NIktH0d4s7A=;
        b=gy4Ip7jz77e1Y6+0q7kz7y02BBvpkh4TUXUN4eEoB9d/dPX2qGbD3DGY6Aa6830U/k
         IaRqgZE7u8AaRNlSCi490ZOwGoDsHBQOFZ9HPCNwrWFOJotAN8MgcXAup0vUDzRoG5sp
         1L4dYwODrTWR+my9HoHF775qx4DSMpD92aeNUpXKVwgmSucQPao9ClnlSqHjZUi31Qcm
         ZfzeFNH3jdUHo3d9SmW2BMEvn0gOaBwN6xtNVErhOCljnw4nGuHloqXIadD5AnovKKm5
         Zknh3lt6E/nJNo7o9ZtU4PyDzhyFTdwM+wf27fMRWlTpZEO4y7IhRR+ZzsTSA7wEuv/x
         6JDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145863; x=1714750663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fnllMvw5rV4aVeEqjprC/GqDGLK/jA5NIktH0d4s7A=;
        b=chI2jZ7mF6k2GkCuGrLyyLE5M9XJL9Nh+6P964qPnKhml68oYvs6Pue4tSDFOP/aoo
         23ZR1dyKfwW+L1IukUgnqydMIZl4WSpqPUPiJemYr0NRz6EInGu61ABncWoK+FHTCuyf
         jVKm7kwLzsuQk0G6lQz34TUPs6n8Fap7/gIQgOKiZbuA4Fl3gxQXGNcxXRSkcrfv7xCq
         DKpy+pTgg2CUvsuT2DGx/HiIe7KTwOxlfRX1rBD1DrogE4qxJ1d3LjUXnpDJE/gGcJ8u
         wG5FH8Ulb+c7IdCiAxpWMP+2zBXeZnnFNyI6z0GrBS0NlfEH9d+DWgbx5pZGsrmti6gs
         f3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFhTIvlvGCPiXmppQpTQ3FTCKe1VN5tYEZ6waLbANVDttc9E/N7BmMRmXlIRzpZOKjDTSMCOEU9Z+eMWVhvNjcBZ/RD8gmq+YU5kfJedVZhFKiYQ0HfKwnjYYHQ25Po4GMneM15RJGjg==
X-Gm-Message-State: AOJu0YwJ8fbAf+y7mS+0RI87LhhyV2YLOejwVIV+34XntYDTGl0SZWkA
	mN2fm/pTat9hv+DGJeAYMCscWS3+p9wvpjvIF/P0gfUDq816bpmh
X-Google-Smtp-Source: AGHT+IF86aCF2y03zjD72DabiUs318EzT1BZ/WTa9OJV2HjgTF93fx7CNQA08TDph3S28W4TYeipuA==
X-Received: by 2002:a05:600c:1988:b0:41a:7ab1:fd98 with SMTP id t8-20020a05600c198800b0041a7ab1fd98mr2473420wmq.21.1714145863392;
        Fri, 26 Apr 2024 08:37:43 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c475100b004162d06768bsm35189838wmo.21.2024.04.26.08.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:37:43 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>
Subject:
 Re: [PATCH v1 1/1] leds: sun50i-a100: Use match_string() helper to simplify
 the code
Date: Fri, 26 Apr 2024 17:37:42 +0200
Message-ID: <3557566.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <20240426152515.872917-1-andriy.shevchenko@linux.intel.com>
References: <20240426152515.872917-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne petek, 26. april 2024 ob 17:25:15 GMT +2 je Andy Shevchenko napisal(a):
> match_string() returns the array index of a matching string.
> Use it instead of the open-coded implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/leds/leds-sun50i-a100.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/leds/leds-sun50i-a100.c b/drivers/leds/leds-sun50i-a100.c
> index 62d21c3a3575..119eff9471f0 100644
> --- a/drivers/leds/leds-sun50i-a100.c
> +++ b/drivers/leds/leds-sun50i-a100.c
> @@ -252,18 +252,16 @@ static int sun50i_a100_ledc_parse_format(struct device *dev,
>  					 struct sun50i_a100_ledc *priv)
>  {
>  	const char *format = "grb";
> -	u32 i;
> +	int i;
>  
>  	device_property_read_string(dev, "allwinner,pixel-format", &format);
>  
> -	for (i = 0; i < ARRAY_SIZE(sun50i_a100_ledc_formats); i++) {
> -		if (!strcmp(format, sun50i_a100_ledc_formats[i])) {
> -			priv->format = i;
> -			return 0;
> -		}
> -	}
> +	i = match_string(sun50i_a100_ledc_formats, ARRAY_SIZE(sun50i_a100_ledc_formats), format);
> +	if (i < 0)
> +		return dev_err_probe(dev, i, "Bad pixel format '%s'\n", format);

I know that old code used dev_err_probe() without reason, but could you change
it to ordinary dev_err()? dev_err_probe() is useful only when return code could
be -EPROBE_DEFER. This is clearly not the case here.

Best regards,
Jernej

>  
> -	return dev_err_probe(dev, -EINVAL, "Bad pixel format '%s'\n", format);
> +	priv->format = i;
> +	return 0;
>  }
>  
>  static void sun50i_a100_ledc_set_format(struct sun50i_a100_ledc *priv)
> 





