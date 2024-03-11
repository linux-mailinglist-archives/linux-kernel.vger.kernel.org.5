Return-Path: <linux-kernel+bounces-98477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369AC877A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5561281286
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E055DB65E;
	Mon, 11 Mar 2024 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MpP94/mV"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DBAD31
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135187; cv=none; b=WhLE4XpFL4eBVS+xRKJmhwkVXMPlDvpHdE2bdEQPiTYobwgLeFOWC70xFxh4iPzTAdvf7ns7rBPlILOP0OvdSatJOlRvzA/Z1bSyTsz/zpeEbmyoeFsi622pHXcz4A7A3aVLYiknW3FdU+1cavSrT59fuY24VR/pcRzWG/2WiFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135187; c=relaxed/simple;
	bh=3j3nQTPIQgZmg6idrQtrVJE8ty71JiVFYrY1M4EVvWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AoTjkaCQXKGgC+sRtiKOE66XdyzHTPEfLc9e2PkojMqcUyWLvUNkKfnymUfbhtbheu7JH4ajLr0R4jYfViJKgliz4XG8E7/ZhWBfs7ctuGkdkdujD1U0Ip/wbYE8rOgvQVAFljXE7J4HGU6FQFrle7uFq04+On1b9kc1Ts03DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MpP94/mV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e39226efso3807539e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710135183; x=1710739983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHbnC+Lc+LUPq49FUf6LJd/f3BeJuZ1d1Rd9dT+IFJ8=;
        b=MpP94/mV5dIETmUF4pXLN3Lm0l21emjkW42EMwpNDAin1RFUN9tBuXOTJMwFqMK6CX
         935bVRaFcOh92wPbQ3oFZIIXOW1erMaVwLlXBG++MkHazYzxXS96Sm3iG4F13uz5H0n4
         Jd35Xo7YgVshe3I/gx8kSVWTvnq15DWd1U351eJFGfnFU49zcQEyIsOK2w4/ZHNKRp6a
         wn+EKh5JKi/XRwKQdQk0ZTTQvG4zhVn7MP68Vjjg+9ixsME4vtGt1QrddGfLHktiOoCn
         HWueWdYxeZWQalqRcRcsZ70QCUaZk9N02dHsexj1sIAMBGnq/oROsrUpven9LUYUs+Xp
         Jaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710135183; x=1710739983;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHbnC+Lc+LUPq49FUf6LJd/f3BeJuZ1d1Rd9dT+IFJ8=;
        b=BMcXUF0xr0yWpxeglsgys4NXiX5zOtefIS2EIHPVOVYMRsGrHyYin3YumsaCtIgRgS
         3ojXzBK4lflH6FnCoYtrU+vgPzUQ3/Fn0ib3ME26S1ATz0mxjMdAQ2446aFQ5z3zG0CG
         ki/uVvlmZSIlnWsHWLC7EwDh12OokMJDDTjEtw3RRUQTDr2ET0zfM2SZZT+jhSJMaHFa
         8QEo5X2E/VfAWZllHaKVuSqx4wXSqFTPbN0xpRztstOX6WgggiANOrn0gS3Lusy79ydZ
         LSQdYKdK6PRyCbphIwjmr3+oFpvz+BLJZMRlWId0X3pagTLYG3qp/SMfIU/vZ405fCu/
         ASEg==
X-Forwarded-Encrypted: i=1; AJvYcCUtiHkR56INYFJvVlQGy3IPS5ktukjdo7uo05dSWa9a+1lR1Q5mBj4r7M94cXk0YcZFRquhZHE9hVTM2QjF5gElhCdhJfM299jlmPLl
X-Gm-Message-State: AOJu0YyxIrxy05H3jrdldnmOpyFrjIHPQSCi0LGzIxgVHNNf0MAZR18E
	WbgjSD7BEbRLIkWOPoL3fuZeJbiCXbLHAF5g0IAvH5fv8xdAANgPCRP9cTQkC1Y=
X-Google-Smtp-Source: AGHT+IHKHznMTZ58B3IQYLr5W4/d7ASDqFveZHeyayDkPSbuNMpZeKsob78akyJEO8Ad+NXS7lVhIQ==
X-Received: by 2002:a05:6512:3188:b0:513:a7c4:f6e9 with SMTP id i8-20020a056512318800b00513a7c4f6e9mr1660381lfe.11.1710135183248;
        Sun, 10 Mar 2024 22:33:03 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b00412c1d51a0dsm7705109wmb.45.2024.03.10.22.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 22:33:02 -0700 (PDT)
Message-ID: <72901ead-400f-416d-a3f6-7fb06fd23786@tuxon.dev>
Date: Mon, 11 Mar 2024 07:32:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/39] dt-bindings: clk: at91: add sam9x7
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172732.672645-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172732.672645-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

s/dt-bindings: clk: at91/dt-bindings: clocks: at91sam9x5-sckc

or

s/dt-bindings: clk: at91/dt-bindings: clocks:  atmel,at91sam9x5-sckc

in patch title

On 23.02.2024 19:27, Varshini Rajendran wrote:
> Add bindings for SAM9X7's slow clock controller.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v4:
> - Added sam9x7 compatible as an enum with sama7g5 compatible as per the
>   review comment
> ---
>  .../devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> index 7be29877e6d2..ab81f0b55ad5 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91sam9x5-sckc.yaml
> @@ -18,7 +18,9 @@ properties:
>            - atmel,sama5d4-sckc
>            - microchip,sam9x60-sckc
>        - items:
> -          - const: microchip,sama7g5-sckc
> +          - enum:
> +              - microchip,sama7g5-sckc
> +              - microchip,sam9x7-sckc

Alphanumerically sorted?

>            - const: microchip,sam9x60-sckc
>  
>    reg:

