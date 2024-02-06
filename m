Return-Path: <linux-kernel+bounces-55012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA284B63E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156BB1C2435B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40568130AE8;
	Tue,  6 Feb 2024 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyeutxP8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDFF12EBD6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225773; cv=none; b=Oe0d9f5SvPqATGmGGR+xSLuGMHsVATuV0DKsaw8poQZZTOpsGVnspF/72m1/LEAY32CNodrbmTIMGrzrh6GEOQ3AcN7gvoTLlC4zQpV1zQLNWJRxPQsNOzw4aQBq06YwODTTq0zTAmisNyfmN5rslut9+to7/Vjwc2J8Y8k8+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225773; c=relaxed/simple;
	bh=3IvZBYjE2fB2w41TceIWHn/O88I/L421TuXq4/DT7Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrYbe726HajSw8QVNI3ay+nK1b9vSYa1P4TeuZ5CfcGT1735tMp3ntzgCHecYhhxBU7wahQeyHsoITDhGpGQgCtZG6YiPbJ7x0nPINMqy5qQIdOZVxO5k/OeAlvnhIYffYzlC3sMb3Psl5YADSjGJyQ06vZJEK+9asI0lVEuGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyeutxP8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso3584525e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707225770; x=1707830570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0GuEnTD9jp8tyTTjLBHTrBf5UYt7nL7qwU21gH0Pg4=;
        b=cyeutxP8Hz9nwvrF9/7Tecr/Gg7EWm/2JKrzsdNfzr2b2VMGpvxtx+WF3tjj0sNXDI
         MbdcR04btcJVlhqG/MRvg9e5YIzbOG/O0NQtwvbnc0O7RbOG95xzeb1HAwWHmS2H3iio
         fAqJKMaCjYHNmFMWG8Lf7aMaFE1ugt6CwlK4rFltwiB/9OHL8O9OzsZKntA8053GmyNw
         Z/KJsh+3g1iFhzVw9YdYtEwZ2FKtkDH6NSJJlkCryRS5fr4l67khjRICgoA/qhjbrqJF
         D4tIckInZ+8A1NlSqmGOS6BWMEWef+/ce6xiRwMNRf1CGnUakCaKM6KJlO9LRTcDyTjD
         Ycjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707225770; x=1707830570;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0GuEnTD9jp8tyTTjLBHTrBf5UYt7nL7qwU21gH0Pg4=;
        b=SP1/SF2F7Xthyq5ObCMxDKB7r/sWy1i2xkOiqagaO8m5U+KJwmlx8mGcTcZEIgul7O
         cJFAGaI0ddrPj8O7dqrx3ZhPhoI7+YUkhGsVpBMSuT2WQvxlMNcjuABPe+gSNydN/Dki
         5npB+DOEM2frp3Vu/vUHRRMWIrA12t7l+hW/YzTEVjGwxeV0DkpINr0IwtQEFwcvzQjy
         sCU4Os4gqj1666rJxrEhedyLN8XQj2bCsTAy2a3qqVZZ9WMbhIsot2C3ZSRAxKc2cQNj
         aSdcmbj8jf3hlZo0OGM/WbMZG4SuKatlM6APhWUwttwsZBSRpfRJWKTneZ2dl4VPtQ7R
         kSxg==
X-Gm-Message-State: AOJu0YxRYkux6DyrMcKa1QDGt4YXdAlW0hUnCzsWJgFqPz074yTTsTsa
	+saYruW5NHGy6CzOPzXo/xqL6caTPW1KcDKg5DkGcvVwFA1jj1ZAz51DRpwtzkY=
X-Google-Smtp-Source: AGHT+IFhGxSfa6LsovQhYU1U8E6v0fvZN2VfSmhHbHAg1eBz0PpOoccPHLqihdSm5JqNgRMZ8B1peA==
X-Received: by 2002:a05:600c:19c7:b0:40f:dd7e:4a4d with SMTP id u7-20020a05600c19c700b0040fdd7e4a4dmr2480759wmq.31.1707225769779;
        Tue, 06 Feb 2024 05:22:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTh1p70VRyaZ9GCdP87rP9NsPb6Sm3CCgoBjYJR91MDrX6xRTkqWXxyrWc8w1wrB4AZ4wwhYC0p0yESvARCcwm3tNdC41E7wmF0e8yw80muv+gz4qYAY3x4P+jWkMdDy14SD9EbEBLI1Rrr0chKL7SndtUjrToLNYzPOIXATQ5SIVw1qVqBNmIZinFu1BUkTuTfrFQE8R7MlDyqvU0rq6SCCyAo9Vvag3NJ9OUDfOeINq+AdCa7xeTtk4/GxYDIws8MyJnKdhJlHpzGkTafSB/U5RQdsQxpFzlHX1Hp73c+/8JTp3pCM7zl3qtgkCIa5zH36iNDaCbbAJJu+GTssXX18TIc+YWM+gUDx4aaKZgjiEiis8/pgwiL+7z33rIUxpd6jQmGGTmDI+8fpvopJJCx/eJSwDBbKswcZ46wDZ2UyywNwMOK4Y+uXFE1BXHJG8yBGDWWj6NiT2Kom2S5/HzHveRb676/i4jzZXO5oN2SQqCFS2eLy+RjTKyotdsuw8d91XZrx280G2Z/kvo0/EeWAWIIk5iV8u57bhDAS1+QWMirMKYWJ6nHitc+BWXi37g/toN9BL6qrhIyATvw++zkKHBW3s7S6FUSPI/OtvK6NJGTA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d5486000000b0033b421e651csm2097109wrv.37.2024.02.06.05.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:22:49 -0800 (PST)
Message-ID: <2a78bdf0-bb9b-4c1c-a4f6-2314ef43dc00@linaro.org>
Date: Tue, 6 Feb 2024 14:22:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
Content-Language: en-US
To: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Yin <peteryin.openbmc@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Lukas Wunner <lukas@wunner.de>,
 Fabio Estevam <festevam@denx.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, devicetree@vger.kernel.org
References: <20240206132111.1772867-1-frut3k7@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206132111.1772867-1-frut3k7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/02/2024 14:21, Paweł Owoc wrote:
> Add Qualcomm QCA4024 to trivial devices.
> 
> Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 79dcd92c4a43..50efbdf2a735 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -309,6 +309,8 @@ properties:
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor
>            - pulsedlight,lidar-lite-v2
> +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
> +          - qca,spidev

You keep resending the same ignoring my comments. I don't understand why.

Sorry, still NAK.

Respond to comments instead.

Best regards,
Krzysztof


