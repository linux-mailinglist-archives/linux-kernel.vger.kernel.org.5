Return-Path: <linux-kernel+bounces-131100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2B89831B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CC928C8B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003046BFBB;
	Thu,  4 Apr 2024 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXDqwrzZ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B45B208
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218960; cv=none; b=cyfEgR0tlpTS7ewsNHvbG2bBQkhtKUpERvtYTA86qnnc83f/PGdGU0LMEKr6UKfVbmvojfIec6X5YGmLKURy5XD2x1hNdHGk7H3Z7mv+MiEr2F+dOMHRIes91vtjMO6OEuEjyaRDJTigc5BmF8HA5RW3VPfhQKIJD0ERV4yQivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218960; c=relaxed/simple;
	bh=kLekTgK51/r1sqVehirZ/air4AufNHnTxia8xfkb/+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUeLQs48nhMQXZH4inNyb7SMaxab7cCqsFMjBFKbOY5rQq0bwbrQ+q0cqn8PTKwZLhCe0X5hwYDNWMXNReDj3HFxLFvPRpb0qF63jvC/QCRc0ww1X0Q/f8AJdl9seuiXtd1qNMbIxYLc3t0WsEUZqPw5ZIRV4xgjiyONQQHtjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXDqwrzZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso879516a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712218956; x=1712823756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k/cXtGay1SI65avew/G0uaOFb7xUGQaVzPwzbwy7NxI=;
        b=fXDqwrzZQYY5TzfR2qaxqX4JvnTW5SD/dNMQD4sZnEEpUGDsdX0/UhouuQc/TwrzqO
         sMScedR3t8gZ8pEOsxjcHK1QuLm6HELjzjo76ZyTkTZxJOzoyLffv9NtWMXuV5S6A00x
         Lf4cYdq9pvAC3xe0mjLuzL0M6ZzztvqCSPyLOOXm2x3p8pamZD47bY1dI4eWVwPxxyJk
         dsm+ECItnhX0aXsucJwKeaDl4xnD5JEyn2Z9bB1J+8Vw+MgRgh6l/5CXjmH9oHUTFtO2
         6JuDBdhB4uCSEGv1s40w/sgREdSmoXQy8Fhk6CDXIp5wBZ35arXkme11N1Fj9lIKMwyA
         cVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218956; x=1712823756;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/cXtGay1SI65avew/G0uaOFb7xUGQaVzPwzbwy7NxI=;
        b=S1Al+giZ84a0m0dM1LEnSx/zamyXTbxfuHdfLr3BhuSr3aJ+rZVuUix5p9yyhmDsQF
         9ywxz31rCRlROtTNhFbme24wzX5CtAFkf9iAL/rJ7tR/xymYKbMdcnkkZUujlRSTgOpb
         rhBIqOjKKY/37PMfQiV8kMPl4aA3QTFGr+BdULzUztJlyO4mhxAKnpxmcOXyxTEriurW
         wJ6K+r5W0Xb7eaec0878D4vwGaXPFg9C0xsf95Q+CZtK4FbEPCX41DtT3SE3QnkSV3A7
         LR4alYhUxLZGYc5/ehSHZreyy3lXoPTXRpr8ByI2xy5YUELn5PLk0AUQWbjl2KO82jle
         aP4w==
X-Forwarded-Encrypted: i=1; AJvYcCXhLPYDPRgZXthwDlreVN2aFlV/NJaYnOkxGsRGokucVdSKi+G4tQLJqxpv50kHUNxQy8uiU+uHJYajryaH7xgQOXo5KJNC8DJruycB
X-Gm-Message-State: AOJu0Yz/ubBzs0oXtNTm/hHz0sRe7CxyYjGnW7drEbSnWdpV7DD8jNNY
	vyW5AsqUd72bMpAgPj1JVLhbtOXum9o3MgJSL1vIIKR1K8zC8hbks6hgMTMXi24=
X-Google-Smtp-Source: AGHT+IE7fdBtqZdr9n6gEQqkZlKXIXE8WOy361QrMMoxAL4AZ/RrHX0sFZT5pxcAdX5m4n+u9wvtyg==
X-Received: by 2002:a50:9b1c:0:b0:56d:ece8:a5e8 with SMTP id o28-20020a509b1c000000b0056dece8a5e8mr1254028edi.14.1712218956619;
        Thu, 04 Apr 2024 01:22:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h13-20020a0564020e0d00b0056de7bee45bsm2989461edh.18.2024.04.04.01.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 01:22:36 -0700 (PDT)
Message-ID: <d7fc172f-68f8-4689-a69e-e45b2392b43e@linaro.org>
Date: Thu, 4 Apr 2024 10:22:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Add Synopsys DesignWare HDMI RX Controller
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 shawn.wen@rock-chips.com, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm@lists.infradead.org
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
 <3049149.687JKscXgg@diego> <c790c8ba-a9bd-4820-8084-1294e5e523d9@linaro.org>
 <28071718.gRfpFWEtPU@diego>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <28071718.gRfpFWEtPU@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/04/2024 10:19, Heiko Stübner wrote:
> Am Donnerstag, 4. April 2024, 08:15:50 CEST schrieb Krzysztof Kozlowski:
>> On 04/04/2024 00:48, Heiko Stübner wrote:
>>> Am Mittwoch, 3. April 2024, 13:24:05 CEST schrieb Krzysztof Kozlowski:
>>>> On 03/04/2024 13:20, Shreeya Patel wrote:
>>>>> On Wednesday, April 03, 2024 15:51 IST, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>>> On 03/04/2024 11:24, Shreeya Patel wrote:
>>>>>>> On Thursday, March 28, 2024 04:20 IST, Shreeya Patel <shreeya.patel@collabora.com> wrote:
>>>>>>>
>>>>>>>> This series implements support for the Synopsys DesignWare
>>>>>>>> HDMI RX Controller, being compliant with standard HDMI 1.4b
>>>>>>>> and HDMI 2.0.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Mauro and Hans,
>>>>>>>
>>>>>>> I haven't received any reviews so far. Hence, this is just a gentle reminder to review this patch series.
>>>>>>
>>>>>> Why did you put clk changes here? These go via different subsystem. That
>>>>>> might be one of obstacles for your patchset.
>>>>>>
>>>>>
>>>>> I added clock changes in this patch series because HDMIRX driver depends on it.
>>>>> I thought it is wrong to send the driver patches which don't even compile?
>>>>
>>>> Hm, why HDMIRX driver depends on clock? How? This sounds really wrong.
>>>> Please get it reviewed internally first.
>>>
>>> For the change in question, the clock controller on the soc also handles
>>> the reset controls (hence its name CRU, clock-and-reset-unit) .
>>>
>>> There are at least 660 reset lines in the unit and it seems the hdmi-rx one
>>> was overlooked on the initial submission, hence patches 1+2 add the
>>> reset-line.
>>>
>>> Of course, here only the "arm64: dts:" patch depends on the clock
>>> change, is it references the new reset-id.
>>
>> Wait, that's expected, but it is not what was written. Claim was HDMIRX
>> driver depends *build time* ("don't even compile").
> 
> Trying to do a full build (kernel + dts) will fail, because the the
> device-tree patch references the newly added reset-id .
> 
> So you end up with a dtc error. Same with the binding.

Which is quite expected, nothing special, most patchsets have exactly
the same dependency. It's not a HDMIRX driver dependency. It's DTS and
clock provider on the binding header, not clock consumer.

We solved it many times and different SoC subsystems have their own
guidelines. Putting here media is not the right approach and not justified.

Best regards,
Krzysztof


