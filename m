Return-Path: <linux-kernel+bounces-83025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F3B868D71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E224B28E6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492501386A9;
	Tue, 27 Feb 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qt3Mvm6X"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA8138498
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029417; cv=none; b=sSoI91vt+Vqgk4o2wgt+WLM/Pw19Pw8JkQbB0cKNCNuIlsQBbygcxkO0oRXXOy/dH2GBH398oiMIPalOv22MNPMltchnNDd6ynAY8OSuybdf+GIJUqD0ZH7mHEhOb7AQWolmxhByDiebx9aupCiBgekZGCgV7uFzJ5BLe+fcHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029417; c=relaxed/simple;
	bh=5u+d29M3CDX3NbLVvd9IU8TbBtjbvakMQDSEITp/s8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMpT+5GEjOqLxQbf8XAtXkCW1VklpO+bECLAAtQyI4bJ3r8B1HRCVLdTIbEYGvSuVftpUc2eyVJGjjmxlAEaTFT4jGp0jTo+dUhrFGGWIu5vZ6FKBFZMmu4WkKD3EMXydaCe8LCsf+2S8rSEjTnjLP3lZ5v1Sbu/zo08plhoySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qt3Mvm6X; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3657c437835so7666815ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709029414; x=1709634214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRDnUl47SBcmf8gVz+t2ubWEYD6TUCpoZIdH8z+nNoU=;
        b=Qt3Mvm6X4sSgNwsf+HUsxufJ4dYMHtUASZzeTM9O7nXQ14f2hmWORYXN/63OihxAua
         Ew8xXWn4+iR8ESMNw2X9j5C1r4QR5XynpNe740qIjOtJc5HjcRzqDNRkY8ACnjRAQW4p
         AEcgo57K4CCal/VbCwgAFnE40aA8G3pfkMwjnIJdvnqgi3H1Hqwcmm3Dzd4TuqpLuarh
         K1YFjDOdaIi5LIMizyBz1PH/Yz95xbxsGdLqNa8u536ZO9/mAGZ4mrL+B1vOluv/U0yj
         c4X3typK/rF6Sq2l3XlNOXZ1zMzguzFyxgo/7q/klm2obm0KF6ziBbRfbMNb8tbk/Xoy
         HT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709029414; x=1709634214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRDnUl47SBcmf8gVz+t2ubWEYD6TUCpoZIdH8z+nNoU=;
        b=rFlv4o5tiNhz28zma9N98Y5iPSXcfHVwgDGokbpYydTeCxIjpetHY9FYak2t0FWYxo
         9h7mPnLZ+843s3bfinc93tvAgQaih+pTh25gtTxg0ibQmCLDWvZ4mis0ZVU3M38OSk3m
         Kb64+NRulQP4+X/z0CQs6P0WS7CkuCmk5/gDaYDeC+e5S74ttdXrPxgU2AuHvtg2u5E0
         X/Y3WpzGSGpPfyDyHGP4A1oMEq75m32woYIM4wEf/5gvIzYUCmEi8fe3vE10LzWTYjPO
         9NipLujF/D5ICDwCtUivW0EiS/9QX0aICGheEA6yB+osY0JDZmAcPGZ18j8JS0+r178o
         DHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Sl5oqx2OAvetfhloZzSPfXTByEd69e/f1FyJOH0iTWj3mfQgc1H7Kc73RJnBhA1bshe6rF3zKbKtMPXQ47sU3pFihjOdfepJQx52
X-Gm-Message-State: AOJu0YyzpdQ11//GLxpb/VpvmX9izvTxXfXJmNHguOpZrVROURvC2viL
	7ASSe4vgnzROOu+AjYvdZ//nlfcyvFQroPe0Zj0gdkDj8ngaqePtQeaxmyDtgec=
X-Google-Smtp-Source: AGHT+IFlwjkngqWStTBwNfi9zv2j3kwATePJOcv87F/BtVt3qeg8VtNnjQ+1xDPzFY8KBNxxoIwTKw==
X-Received: by 2002:a05:6e02:e10:b0:365:1b7c:670 with SMTP id a16-20020a056e020e1000b003651b7c0670mr7885060ilk.8.1709029414201;
        Tue, 27 Feb 2024 02:23:34 -0800 (PST)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p6-20020a92c606000000b003642dacafa5sm2063105ilm.29.2024.02.27.02.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:23:33 -0800 (PST)
Message-ID: <92b9e9ac-6265-4611-888d-ba74bb871be5@baylibre.com>
Date: Tue, 27 Feb 2024 11:23:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] ASoC: dt-bindings: mediatek,mt8365-mt6357: Add
 audio sound card document
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 Flora Fu <flora.fu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-2-4fa1cea1667f@baylibre.com>
 <e15fdb18-d4de-495f-b90b-ba0e787cbef4@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <e15fdb18-d4de-495f-b90b-ba0e787cbef4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/02/2024 16:30, AngeloGioacchino Del Regno wrote:
> Il 26/02/24 15:01, Alexandre Mergnat ha scritto:
>> Add soundcard bindings for the MT8365 SoC with the MT6357 audio codec.
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   .../bindings/sound/mediatek,mt8365-mt6357.yaml     | 127 
>> +++++++++++++++++++++
>>   1 file changed, 127 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml 
>> b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
>> new file mode 100644
>> index 000000000000..f469611ec6b6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8365-mt6357.yaml
>> @@ -0,0 +1,127 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/mediatek,mt8365-mt6357.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek MT8365 sound card with MT6357 sound codec.
>> +
>> +maintainers:
>> +  - Alexandre Mergnat <amergnat@baylibre.com>
>> +
>> +description:
>> +  This binding describes the MT8365 sound card.
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,mt8365-mt6357
>> +
>> +  mediatek,hp-pull-down:
>> +    description:
>> +      Earphone driver positive output stage short to the
>> +      audio reference ground.
>> +      Default value is false.
>> +    type: boolean
>> +
>> +  mediatek,micbias0-microvolt:
>> +    description: |
> 
> description: Selects MIC Bias 0 output voltage
> 
>> +      Selects MIC Bias 0 output voltage.
>> +      [1.7v, 1.8v, 1.9v, 2.0v, 2.1v, 2.5v, 2.6v, 2.7v]
>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> 
> No, you don't say 0 1 2 3 4 to a property that says "microvolt", that's 
> simply
> wrong.
> 
> mediatek,micbias0-microvolt = <2100000>;
> 
> ...so you want a binding that says
> enum: [ 1700000, 1800000, this, that, 2700000]
> 

Is it correct if I put "description: Selects MIC Bias 0 output voltage 
index" ?

>> +
>> +  mediatek,micbias1-microvolt:
>> +    description: |
>> +      Selects MIC Bias 1 output voltage.
>> +      [1.7v, 1.8v, 1.9v, 2.0v, 2.1v, 2.5v, 2.6v, 2.7v]
>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> 
> same here.
> 
>> +
>> +  mediatek,platform:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: The phandle of MT8365 ASoC platform.
>> +
>> +  pinctrl-names:
>> +    minItems: 1
>> +    items:
>> +      - const: aud_default
>> +      - const: aud_dmic
>> +      - const: aud_miso_off
>> +      - const: aud_miso_on
>> +      - const: aud_mosi_off
>> +      - const: aud_mosi_on
>> +
>> +  vaud28-supply:
>> +    description:
>> +      2.8 volt supply for the audio codec
>> +
>> +patternProperties:
>> +  "^dai-link-[0-9]+$":
>> +    type: object
>> +    description:
>> +      Container for dai-link level properties and CODEC sub-nodes.
>> +
>> +    properties:
>> +      codec:
>> +        type: object
>> +        description: Holds subnode which indicates codec dai.
>> +
>> +        properties:
>> +          sound-dai:
>> +            maxItems: 1
>> +            description: phandle of the codec DAI
>> +
>> +        additionalProperties: false
>> +
>> +      link-name:
>> +        description:
>> +          This property corresponds to the name of the BE dai-link to 
>> which
>> +          we are going to update parameters in this node.
>> +        items:
>> +          const: 2ND I2S BE
>> +
>> +      sound-dai:
>> +        maxItems: 1
>> +        description: phandle of the CPU DAI
>> +
>> +    additionalProperties: false
>> +
>> +    required:
>> +      - link-name
>> +      - sound-dai
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - mediatek,platform
>> +  - pinctrl-names
>> +  - vaud28-supply
>> +
>> +examples:
>> +  - |
>> +    sound {
>> +        compatible = "mediatek,mt8365-mt6357";
>> +        mediatek,platform = <&afe>;
> 
> Please:
> 
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

Is it about the wrong pinctrl-names tab alignment ?
Also, 2ND I2S BE => 2ND_I2S_BE ?
Otherwise, I don't get it sorry.

> 
> Regards,
> Angelo
> 
>> +        pinctrl-names = "aud_default",
>> +            "aud_dmic",
>> +            "aud_miso_off",
>> +            "aud_miso_on",
>> +            "aud_mosi_off",
>> +            "aud_mosi_on";
>> +        pinctrl-0 = <&aud_default_pins>;
>> +        pinctrl-1 = <&aud_dmic_pins>;
>> +        pinctrl-2 = <&aud_miso_off_pins>;
>> +        pinctrl-3 = <&aud_miso_on_pins>;
>> +        pinctrl-4 = <&aud_mosi_off_pins>;
>> +        pinctrl-5 = <&aud_mosi_on_pins>;
>> +        vaud28-supply = <&mt6357_vaud28_reg>;
>> +
>> +        /* hdmi interface */
>> +        dai-link-0 {
>> +            sound-dai = <&afe>;
>> +            link-name = "2ND I2S BE";
>> +
>> +            codec {
>> +                sound-dai = <&it66121hdmitx>;
>> +            };
>> +        };
>> +    };
>>
> 

-- 
Regards,
Alexandre

