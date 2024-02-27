Return-Path: <linux-kernel+bounces-83485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37D869A26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC02D1F22CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBEE145337;
	Tue, 27 Feb 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k4mz6vlW"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCDE1420B3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047121; cv=none; b=XQfNuXPJ+GT8Ww5+ogT5e5v0ZIkTsaWhk4V/snBXi5C2yNGlSPsvLRHrqXUA89Zjv/IdWkiuJMVp2L+aF8VwDha0EWbTTsi5yo/MVW6RiZucp0KxXNkVVEVSJtVPiqz4LYX7uoHr53XcrF8S5uNnxWOLR5Re6ZEOT8iHB8Iq9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047121; c=relaxed/simple;
	bh=QlIBhT9SjPcv+nOLgdktMUfy88alkJYEWz1rlWTKDjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCP7+kxzVjRZPVn1uRB1w2FWxNPiUUKposT2RI/XwnShm9cUTbXPcaP1DxQO19Z597Vk/jIVkq5P7T66huZA4PfaOV4sKm4EEIAhHvHV+Hw4QYc+6cGW6Rb9JVO8e0woiowXM5nP2X5XXpRL0Be1Ipl3+GEK16mTuoUmeFjLvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k4mz6vlW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6902947c507so2836026d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709047117; x=1709651917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgeSwdzfejtZ7gerQ3YAwA0BCpS4Ld6TiTQUNC32GpI=;
        b=k4mz6vlWu3JS8iabSsK2rnaam1eX5rMnuiODcOsCGTyLuWWTL4ScCceoCjyY3htG3X
         DT0LFt1BFFNctk73XJOa8d7tRmjZKIvox2A+1C1B40wzeFvL1dZyiZgYvESBlJyqt3QU
         Afm8dHx3wKo0cjK69zYXzZAwQQMiCeQj9dKQsQcDu61J+bVPTpk5ZacJVte6Au20gZTr
         u0qrK+gUWtMIUpo4Zvt2oOk8bqcXUcukwF34+b8t8/lqMZVU9atPDVA5YqO6PE7v59yX
         tf3ScQ2xlD9TKHFal9quUpqxH7LQcrRaTUwvUN4Ziyxku8bnjIHqZifK6SKZnEZ5SvWG
         qO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047117; x=1709651917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgeSwdzfejtZ7gerQ3YAwA0BCpS4Ld6TiTQUNC32GpI=;
        b=BUXHel8jkxR0q7vnDUg9rjCrEDrvSkXU67jjaeH+cfEXL81qMRBGpl9WZn96S3Lzi6
         CrOsEiQSjN68zXQZVaqfUhY6lXyWt/PeC/PlGTv6tY1XnwiMOvwl6Ywvoyjnja646Nim
         MzAYLMsx392pB0aCV/M5t9IGIRUK2FdodFw4xBuBTfLqSIvXgNlqrZGkSiqek1bmXJfG
         YYIr9irRmQ/ykjip8bPwxPrVTronQd0DRFZ1ExbwiTl8qyLjdiaK5I+OMF/J9zjnmeB0
         8UdCiCiAWQPzO6dWDfwIuI6YTj1Whjc0V7Ieiz4PiXlYvM8NdfpLT6nlwqWRwsXlcqHi
         5EcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwaNhsUj1Jcrx6rCygDvdIuZHMwb+bG0fDrSpNGLWgiIg+4Yzw3k/+swVRl1C0IUUXOJvpPhuRqXAuAlA0uOXAbvlBLMSrJ1q00BNC
X-Gm-Message-State: AOJu0Ywspl2xFzWEGF9d/mHOx3LCjPwYHSGyqyGr9Y1xzQZ4DcBNJvNC
	cAPWREj1UufG6t6eSl5fqkdJ4j57CZaY7gc1Lt0TgHcYgwQhTDG++Yuxq4WtBus=
X-Google-Smtp-Source: AGHT+IGCOPu8LzF13tl9Z5c0o4yQmsOPurtebB8rpDPdng5maYtZftIJX0pkpHN6dXZAiJKRZsdFWA==
X-Received: by 2002:a0c:971a:0:b0:68f:ef9b:44aa with SMTP id k26-20020a0c971a000000b0068fef9b44aamr2191669qvd.27.1709047117308;
        Tue, 27 Feb 2024 07:18:37 -0800 (PST)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id pf10-20020a056214498a00b0068f914ac80bsm2104905qvb.50.2024.02.27.07.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 07:18:37 -0800 (PST)
Message-ID: <eeb3329b-0558-4237-8343-4e11f65a6a35@baylibre.com>
Date: Tue, 27 Feb 2024 16:18:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] ASoC: dt-bindings: mediatek,mt8365-afe: Add audio
 afe document
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-1-4fa1cea1667f@baylibre.com>
 <ce5f71a9-1b5f-4724-89db-dae2f64e8008@linaro.org>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <ce5f71a9-1b5f-4724-89db-dae2f64e8008@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/02/2024 10:01, Krzysztof Kozlowski wrote:
> On 26/02/2024 15:01, Alexandre Mergnat wrote:
>> Add MT8365 audio front-end bindings
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   .../bindings/sound/mediatek,mt8365-afe.yaml        | 164 +++++++++++++++++++++
>>   1 file changed, 164 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml
>> new file mode 100644
>> index 000000000000..1d7eb2532ad2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml
>> @@ -0,0 +1,164 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/mediatek,mt8365-afe.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek AFE PCM controller for MT8365
>> +
>> +maintainers:
>> +  - Alexandre Mergnat <amergnat@baylibre.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,mt8365-afe-pcm
>> +
>> +  reg:
>> +    maxItems: 2
> 
> You must describe the items.

Actually, I've took downstream code that I'm not able to explain because 
the second reg isn't on my MTK documentation.
So I've remove the second reg and passed all functional tests 
successfully. Then I will remove the extra reg for v2.

> 
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  mediatek,topckgen:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: The phandle of the mediatek topckgen controller
> 
> What for? Don't repeat the property name. Say something useful.

got it

> 
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +  clocks:
>> +    items:
>> +      - description: 26M clock
>> +      - description: mux for audio clock
>> +      - description: audio i2s0 mck
>> +      - description: audio i2s1 mck
>> +      - description: audio i2s2 mck
>> +      - description: audio i2s3 mck
>> +      - description: engen 1 clock
>> +      - description: engen 2 clock
>> +      - description: audio 1 clock
>> +      - description: audio 2 clock
>> +      - description: mux for i2s0
>> +      - description: mux for i2s1
>> +      - description: mux for i2s2
>> +      - description: mux for i2s3
>> +
>> +  clock-names:
>> +    items:
>> +      - const: top_clk26m_clk
>> +      - const: top_audio_sel
>> +      - const: audio_i2s0_m
>> +      - const: audio_i2s1_m
>> +      - const: audio_i2s2_m
>> +      - const: audio_i2s3_m
>> +      - const: engen1
>> +      - const: engen2
>> +      - const: aud1
>> +      - const: aud2
>> +      - const: i2s0_m_sel
>> +      - const: i2s1_m_sel
>> +      - const: i2s2_m_sel
>> +      - const: i2s3_m_sel
>> +
>> +  mediatek,i2s-shared-clock:
> 
> Why do you need this property? Linux (and other systems) handle sharing
> clocks properly.

Indeed, not needed. It was used by the downstream code driver but I 
remove it for v2.

> 
>> +    description:
>> +      i2s modules can share the same external clock pin.
>> +      If this property is not present the clock mode is separrate.
> 
> Typo
> 
>> +    type: boolean
>> +
>> +  mediatek,dmic-iir-on:
>> +    description:
>> +      Boolean which specifies whether the DMIC IIR is enabled.
>> +      If this property is not present the IIR is disabled.
> 
> "is enabled" or "enable it"?
> 
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

I will rephrase:

True to enable the Infinite Impulse Response (IIR) filter
on the digital microphone inputs.

> 
>> +    type: boolean
>> +
>> +  mediatek,dmic-irr-mode:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Selects stop band of IIR DC-removal filter.
>> +      0 = Software programmable custom coeff loaded by the driver.
> 
> Bindings are for hardware, not drivers. Why is this a property of board DTS?

Actually this is a hardware feature. Mode 1 t 5 are predefined filters. 
Mode 0, the HW will read some "coef filter registers" to setup the 
custom filter. the "coef filter regs" are written by the driver. 
Currently the coef values are hardcoded in the driver.

> 
>> +      1 = 5Hz if 48KHz mode.
>> +      2 = 10Hz if 48KHz mode.
>> +      3 = 25Hz if 48KHz mode.
>> +      4 = 50Hz if 48KHz mode.
>> +      5 = 65Hz if 48KHz mode.
> 
> Use proper unit suffixes - hz.
> 
> 
>> +    enum:
>> +      - 0
>> +      - 1
>> +      - 2
>> +      - 3
>> +      - 4
>> +      - 5
>> +
>> +  mediatek,dmic-two-wire-mode:
>> +    description:
>> +      Boolean which turns on digital microphone for two wire mode.
>> +      If this property is not present the two wire mode is disabled.
> 
> This looks like hardware property, but the naming looks like SW. Again
> you instruct what driver should do. Standard disclaimer:
> 
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc.

Actually this is a hardware feature. This is ALL I have to describe the 
HW behavior from the datasheet:
"
bit name: ul_dmic_two_wire_ctl
Turns on digital microphone for two wire mode.
0: Turn off
1: Turn on
"

On the board schematic, SoC and DMIC and linked by 3 pins:
- clk
- data0
- data1

IMHO, "two-wire-mode" means the HW use 2 pins for data, and the SoC must 
be aware of that by reading the register value written by the driver, 
using the value found in the DTS.

I don't get why you think it wouldn't be hardware behavior.

Rephrase description:
"True to enable the two wire mode of the digital microphone"
Is it better ?

About the property name, "mediatek,dmic-two-wire-ctl" sound better for you ?

> 
> 
>> +    type: boolean
>> +
>> +
> 
> Just one blank line.
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - power-domains
>> +  - mediatek,topckgen
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/power/mediatek,mt8365-power.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        afe@11220000 {
> 
> What is AFE?

Audio Front End, this is the same name used for other MTK SoC, to be 
consistent.

Cook a new patch serie to change "afe" by "audio-controller" for all MTK 
SoC would be great.

> 
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
>> +            compatible = "mediatek,mt8365-afe-pcm";
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Regards,
Alexandre

