Return-Path: <linux-kernel+bounces-72903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D58585BA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1FCB23F75
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF29664DF;
	Tue, 20 Feb 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bv74XP7c"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAE664B6;
	Tue, 20 Feb 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428312; cv=none; b=MzI5PYChNrYmD6TLZgeV4OYBLOw+/UMU0IE940bEBKnoi8xX5X99IfAOVu8hJTA81SY8qynI+0FLs4ydW8wIoJX9f/DV0uLGwKHk1/KYUO5tgQT6sAFzm5pHwSoAPakmJNgUPE/kmuRL5qQ2iSfq0mDwunqD6tHBqQ9CP7LEEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428312; c=relaxed/simple;
	bh=Qef5zR9DD0pWV9mmgDrABJ5aM2SgvsE5CkAUKzwETas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbTQE+xIkdYdSnkvRh+NS/C0Kj0zVcD1XC+Ly6kj1FeHe4GIhtAFotEp7Qr58xiBflNoOA1HVcetM4zSZlzeu3plIosAXugwJlZyek6eVo8Rg1sarGjPj5W0pGx/nf8YC0Ks8Ze29SzxtvQSDWVyZJePu+NTkZVYkUbddK2rkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bv74XP7c; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5645efb2942so3905163a12.1;
        Tue, 20 Feb 2024 03:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708428308; x=1709033108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxDjqCDFPq7eOMPwPmbnpfEUfnNCy3lfoA1kp9cT9L8=;
        b=Bv74XP7cWgbprLtuAshr4ZdFCiDnjJEVlxiLKgp5DwtmWlKM/ugwsMwZQx5/HyrlIm
         IYyEXTCuTroVnwlEsFnSkfoWZ5mP28D9YBQGbzy2dYJGgAe227TwJ8kX16tYY3RRwADi
         6Q+UrpAxgBbMjh7fVfLhAcEwKR+42sWdwpGa2tbzFDfusmtDR/xZ3pZA8BBQ+TGCbIEN
         X4o5DmmlyUMz7QAV/yncGUK5NyzodfygGYgc+7cg42Iaab64Si+YXC5V+FwwKdQylvs+
         fNmS3mrW4HtO0fal5Rp7NBq7817go2zwUKV7NAPDyM1Zg/ob//ARAol5n9XJfm+wPyWx
         D9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708428308; x=1709033108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxDjqCDFPq7eOMPwPmbnpfEUfnNCy3lfoA1kp9cT9L8=;
        b=AsLFapbOsN07QW0P6jURiXtZmPmjquYG+IsKHoPKOmjzaEIYKgwMQvpLs4SSOstKNa
         UvsL86XBq4KLDfzKXMcQ5ZmY73qegS9EptsGCEQcbmzsOQjQ7Lui8zfpoD3leAem/EeP
         Ex2u5PjnYr8oGy/4PFW7/2RHeviq7hcSURzTwtf9zYIFF0VqZPTgPX0Ox3Btc60P4PsW
         AjmGKGOWCspn7Ak4z8owruaByK9UroHxccjye47RPRbtY9VLZxQ+xZ11Bn86GUt2Rwmm
         FBjU/RQuTnNqWHhfm2AD2ZhQwCDu3h7k5vk390IMOP6+3UAMv2nLWJA8OZbhT9E4Geok
         CbtA==
X-Forwarded-Encrypted: i=1; AJvYcCV+zW2YtzxJZaxvlKmwsWIj55tLbjmnh6mc5YHbeAO1SSW2qwIHmKtzKRBsJz2t8I7XKnKpDjFGA9TvVm6DoxpyXlSGGu3nsukJ2ds/qjd3CX4Qv8eNsQyBudy4kO9amIaSe9ek2jYotXrOuaL6ZRXETSADrYd6En6oLH0KbIXSgZ1VwpSRD2Rb4/4b1Yrl7WFnpYgEHc2scj4FQUBbdAw=
X-Gm-Message-State: AOJu0YwcVZH7EAKjYIidKBaBbufVVBr/hKhsc8tnUS78hI5zweabiuoW
	5JS0eBYA5npqHL7HW0YxArD2yswPLaBOrdJV6zC1oW7zYKB7XM85
X-Google-Smtp-Source: AGHT+IGexDIdRflMxl1rXB5LbCLGRtGw1tfgK9Jvc2wNTJ4RBCdKz1jc7usLDMjAAQp08iRFKLMRzA==
X-Received: by 2002:aa7:c896:0:b0:564:21fd:270e with SMTP id p22-20020aa7c896000000b0056421fd270emr7809883eds.14.1708428308215;
        Tue, 20 Feb 2024 03:25:08 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm3815361edi.59.2024.02.20.03.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 03:25:07 -0800 (PST)
Message-ID: <3bc2c1c6-726a-4751-ae81-4d8336619025@gmail.com>
Date: Tue, 20 Feb 2024 13:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/3] iio: adc: ad7173: add AD7173 driver
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 David Lechner <dlechner@baylibre.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
 <20240220094344.17556-3-mitrutzceclan@gmail.com>
 <6af326b1bf24faea652b4549ff5db24b96ee80c5.camel@gmail.com>
Content-Language: en-US
From: Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <6af326b1bf24faea652b4549ff5db24b96ee80c5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/20/24 12:38, Nuno Sá wrote:
> On Tue, 2024-02-20 at 11:43 +0200, Dumitru Ceclan wrote:

..

> 
>> +};
>>
>> +	indio_dev->name = st->info->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &ad7173_info;
>> +
>> +	spi->mode = SPI_MODE_3;
>> +
> 
> I don't think we need the above. We should just enforce it to SPI_CPOL| SPI_CPHA in
> the bindings [2].
>
> [2]: https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml#L45

Rob Herring V1:

"""
> +  required:
> +    - compatible
> +    - reg
> +    - interrupts
> +    - spi-cpol
> +    - spi-cpha

If the device(s) are not configurable, then you shouldn't need these 2
properties. The driver can hardcode the correct setting.
"""

ref:
https://lore.kernel.org/linux-iio/20230810205107.GA1136590-robh@kernel.org/


