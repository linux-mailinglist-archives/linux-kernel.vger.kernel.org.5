Return-Path: <linux-kernel+bounces-107508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D619A87FD77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5601F22ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863287F469;
	Tue, 19 Mar 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z822HIin"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E77F48D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850885; cv=none; b=czJDxh4UEUdiD0Hizi0Ol2pIKIBJCyRtitMmMukSvKL1jmY1uil/oDvzfK1wbxmXv5zc0EBox4LXFjlUAfd5oH0dsnT2ufYwaIBvYVVNXfEVn/hIPUiEnWYIFHwnVTZlYs3FJzWK3bHBxxKvKY2f8MfYt/bmFBjMpTHWC/eU49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850885; c=relaxed/simple;
	bh=27rUfD7MEkKL14gEk9IYOPASgdy/NR3DmqlPtc7soRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcYvuO4I1z9jN2XlUZcMfxXmzuSMEPEagOLX640nabIFXPOiHLqeTb5LOIKfXiuK1AtiRbmr61VJMd2WBjaQvTWwlAqe8O6QccfjrggpKmiy7MTAdpzV479iy90vWMvleAhWQjw9p8CHfv40J7K88aHGQ/eVOTcyGww7HflrcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z822HIin; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46aaf6081fso382638566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710850882; x=1711455682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cpmdw5XpaoCdxhyeSiy9tIIx/KXvYC3XE2r05d3ZaTE=;
        b=z822HIinrcFoGOuuiOyWnphzPX3/2/EvUOAOCvGPLeeuUIPAs2A6SSOwEFuIZ/Im2w
         L37c0vt4TZH4DG/nn12tqyx+w0YTlzXRd1K8otwzAEOKdkfzPmrzqSV4Yged714oEMPm
         z6Wx0Mph5DkVHowKi2ejsnDUyhZxLolQwZN28fPCK91mXLg7jB40X8y+5nFvghV5xE76
         HlOSb2207FKhhQp5pP+AvP6v6pbFApKMxidyzssarruG4T+b6BXbwoXLeoUxqC4aMl9z
         +tXThoDGMNeIBDeAU5RzGjwuvufK47aL6blKbn4TDNyzU/rfXVxP6rH1KWN0L9k7Ddx8
         aXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710850882; x=1711455682;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpmdw5XpaoCdxhyeSiy9tIIx/KXvYC3XE2r05d3ZaTE=;
        b=JYFt6QIcsk9zLIrKB5USxyBYMYQNPq4nhjEJqYFOAlvjN8QYkDpxUjyJW+0fBMOHdW
         bOhwEgE5vObGSXiZSMQOAEgvsouZJpG67pgBiVTuFT07FsEn+DkSNTfCyxntcpUq1Rb0
         McqOXOONmsGrlNDhVnjPKS4v/VW/tYrslA9vSLQIJUcHIjucB0GGT6OzInRabSw2xlKn
         eM+VBaGi/f0jmCGlLhOKx84t7T3REVaOhP/FoeTTJUWBtvoctq+EFm55Gai87Z2G6+AE
         JoPmfQ7Khu5MW9tXCAN+5Dq4NyMDsw9rvBPe2sXvaFfajX3Fb2SJPz/Ty8MDikTYBE0u
         yIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnD8QuToFJYoNkNVU91VRPZOeAzNijyhsK3hravz4XNl1jtC0D9hXRhaeZAaJm4rXcb2hrxhTbZ7UIaASf40W9OsGb7Ln9mzI8x2SZ
X-Gm-Message-State: AOJu0Yw3VXScAvmXfy7z9nHXPYW7hUUL/RpyT8qs5Nc+qqoeDxSYBXsd
	OqDQpNOk9qunFLHcBckIWOgxm48OPSZFtXbL9BLhZiHnoKEQX0WPyHWXnsNZZYU=
X-Google-Smtp-Source: AGHT+IGJWHELpCKZT/Ag+J7FKpx0IjsLI+DzsH9QFPIYshPca0SwbyJp9P8zi3nolpFX0cq2bvNAhw==
X-Received: by 2002:a17:906:c30f:b0:a46:a662:e56f with SMTP id s15-20020a170906c30f00b00a46a662e56fmr1700440ejz.38.1710850882197;
        Tue, 19 Mar 2024 05:21:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906199100b00a46a49d661fsm3918912ejd.210.2024.03.19.05.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 05:21:21 -0700 (PDT)
Message-ID: <89d459dd-cc8c-4780-a56a-809e24343e69@linaro.org>
Date: Tue, 19 Mar 2024 13:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: media: Add bindings for
 raspberrypi,rp1-cfe
To: Naushir Patuck <naush@raspberrypi.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com>
 <eb854c43-1e92-4c19-bfd3-1bde94924319@linaro.org>
 <f97faeb9-8a6b-47c6-9317-daca88257802@ideasonboard.com>
 <30430e0e-70de-4831-97ad-974e350a2e54@ideasonboard.com>
 <5ca1d005-1beb-47ec-943a-9358ae3c6704@linaro.org>
 <CAEmqJPp7uGYe993L+ujth2mfRy66s8-S9FNxPY7vwkrboDq9yg@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAEmqJPp7uGYe993L+ujth2mfRy66s8-S9FNxPY7vwkrboDq9yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 13:06, Naushir Patuck wrote:
> Hi,
> 
> On Tue, 19 Mar 2024 at 09:32, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 19/03/2024 08:00, Tomi Valkeinen wrote:
>>> On 19/03/2024 08:48, Tomi Valkeinen wrote:
>>>> On 19/03/2024 08:23, Krzysztof Kozlowski wrote:
>>>>> On 18/03/2024 16:49, Tomi Valkeinen wrote:
>>>>>> Add DT bindings for raspberrypi,rp1-cfe.
>>>>>>
>>>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>>>>> ---
>>>>>>   .../bindings/media/raspberrypi,rp1-cfe.yaml        | 103
>>>>>> +++++++++++++++++++++
>>>>>>   1 file changed, 103 insertions(+)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
>>>>>> b/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..7b2beeaaab0e
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
>>>>>> @@ -0,0 +1,103 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/media/raspberrypi,rp1-cfe.yaml#
>>>>>
>>>>> Use compatible as filename.
>>>>
>>>> Ah, indeed. I changed the compatible quite late, adding the "rpi5" as
>>>> versioning, and missed changing the file name.
>>>>
>>>> I'll rename.
>>>
>>> Actually, maybe it's better to have two compatibles,
>>> "raspberrypi,rp1-cfe" as the generic one, and "raspberrypi,rpi5-rp1-cfe"
>>> (or something similar) for RaspberryPi 5.
>>>
>>> And I'm not sure if the "rp1" part is relevant there, would
>>> "raspberrypi,cfe" be just as fine? Naush?
>>
>> See writing bindings. Compatibles should be SoC specific. In some cases
>> generic fallbacks make sense, in some note. But don't just choose
>> "generic fallback" because you want. Provide rationale.
> 
> If the compatible is SoC specific, I suppose "raspberrypi,rp1-cfe"
> would be the correct string.

Sure, but then please think what if rp1 is on Rpi6, called exactly the
same (rp1), with some minor differences? Could it be? I don't know, you
are upstreaming this stuff. Just be also sure you read writing bindings
document.

Best regards,
Krzysztof


