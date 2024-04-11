Return-Path: <linux-kernel+bounces-140710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CAC8A180B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C43284E60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53471400B;
	Thu, 11 Apr 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JovcYbm0"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417F5EAF0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847765; cv=none; b=f9Mu2xppDZuI4oUtJReORGguFLvPQ7+F5RiFwuvzyDCod8b52ttsToSvKUiCFsVseg7HaqLvAPRKRKYmAh5Is0Vwr1bNDd5Yj390O+qPGUf4GTE6f9YKp71Y5qUO7aqxyHeCA9UylAv0E5/t9dAXNp6uxSNHph4GjcycNIF4/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847765; c=relaxed/simple;
	bh=NphbnHJFtQ5GRPLYu0u8kTxQqcMxBP2fPxvXnPieduA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlKW39dBWq5NY9KFp0oEV8Gs4gIowDTe6ByWiC8k6ymqSR7h1ASxt4BieyLjsbiPTBiqCJuXPUrwm/QoPs24WZb0P7NSC7jolgnxH6lH8zxjPyS67ZmuuZIilOU6lcBIfyCAPinQ+CRj24m0jRBmkVpI7OI0iVLQ3S63lAuWeEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JovcYbm0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so9788344a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712847762; x=1713452562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+P23aEc6D4AK3QieQ0wss35fFJtf/ttLJisvoFqgu+g=;
        b=JovcYbm07B1eaf75IkhvWy/dVFqYJmoFSnOlxBR4tvauKYbd9x0wdMD9JlrtdNs1G6
         iVjRXdiRW96RF822Ed+YEOFBS8Gqy0sZpIgTvX3DU4JiDUVFfrGkflZ3JqQAttOvNvVw
         K4LmHFuR79ptIUw6dbhURm4aRf7ryPUyYb7ATmUEWKokW653n2xxQnEkrHNL00cmn0kp
         RxBp4ckifqjUCKE02f0Fax6sQBlafIxHaj1N/zBMkjE4b14J/6/KYLUwrb2JTotHnGeA
         9CfGULDYCfVvyx9IRQUvBGuPiwKxvh0qRNswJZhx/PS6lrC8WtrI7du8aXxYxbwRFGCX
         88IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712847762; x=1713452562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P23aEc6D4AK3QieQ0wss35fFJtf/ttLJisvoFqgu+g=;
        b=h5lCR4S4iurmeBYmFWHXYZ/sDU/qeICpRjuzFEGbnJnfxbBiH1oXQNkHY4qpkzLqta
         5vKHi+J/N8XlLO8BZzl4WQ4mZjWzr+diOwRCSz0HyDaEdgecJP1s/ud60rAUbVNLiAm6
         56r8Nuicz72q0pyOc270lF9miPbUblvLy4TcwNAgbPuNhJ0KFITi9rPI/cvaihoHAAzL
         /wuSQsPnLQH9XW+1Mu/4Fy4zr+2AGcEPPfqWF9Qa2VFfzm+d5KqaFJhwhkSCzP0yY0zA
         IakSQ0Wi0eU8MQu/c9ILF1zdSmObLqQbJTPCHHwcznot656/hXedAs961nggFohcCMtd
         bmew==
X-Forwarded-Encrypted: i=1; AJvYcCXKoG4KINC16cB2TFik8U7BsDUgPuFbUMZ2WoVTszSrR7nYWj/15bPsBWnKNCxqBbnIUWUSgDFaTfpN4s4uTvj/1iQGBdEjajMzkX1L
X-Gm-Message-State: AOJu0Yw4vjF9AvklD0gUZmcfKEkgLvetRzJFJqbpfhE6QrqaaHGEUYRK
	11eAKTmN6XLvf6Aho3Zz4nVfLREwQQraB6Grb5hNarFTd2Ld2wJqg39Yhscoor8=
X-Google-Smtp-Source: AGHT+IGpo6GeSO3qvzPad2RXF4wEMof+Qy/1jy29kQFwn4tlvG5SFE0oakht0ocIv1pl2Hh6oQQIKQ==
X-Received: by 2002:a50:d605:0:b0:56d:fc9f:cca0 with SMTP id x5-20020a50d605000000b0056dfc9fcca0mr18004edi.41.1712847762590;
        Thu, 11 Apr 2024 08:02:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ds2-20020a0564021cc200b0056febfc5395sm497978edb.58.2024.04.11.08.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:02:42 -0700 (PDT)
Message-ID: <8c5ba2cc-b3c1-44df-99f2-a9146e8685f7@linaro.org>
Date: Thu, 11 Apr 2024 17:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] dt-bindings: clock: mobileye,eyeq5-clk: add EyeQ6L
 and EyeQ6H
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-2-335e496d7be3@bootlin.com>
 <29ece6c8-ddf4-4dcd-b5b4-1cad8bc858d3@linaro.org>
 <D0HCAV6APTSD.WKGPESJ29D8A@bootlin.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <D0HCAV6APTSD.WKGPESJ29D8A@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 15:49, Théo Lebrun wrote:
>>> +    then:
>>> +      properties:
>>> +        reg:
>>> +          minItems: 2
>>> +          maxItems: 2
>>> +        reg-names:
>>> +          minItems: 2
>>> +          maxItems: 2
>>
>> So any name is now valid? Like "yellow-pony"?
> 
> I do not understand what implies this. Below "items: enum: [...]"
> ensures only two allowed values. dtbs_check agrees:
> 
> ⟩ git diff
> diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
>            b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> index 8d4f65ec912d..5031eb8b4270 100644
> --- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> +++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> @@ -126,7 +126,7 @@ reset: reset-controller@e00000 {
>                         clocks: clock-controller@e0002c {
>                                 compatible = "mobileye,eyeq5-clk";
>                                 reg = <0x02c 0x50>, <0x11c 0x04>;
> -                               reg-names = "plls", "ospi";
> +                               reg-names = "plls", "yellow-pony";
>                                 #clock-cells = <1>;
>                                 clocks = <&xtal>;
>                                 clock-names = "ref";
> 
> ⟩ make dtbs_check DT_SCHEMA_FILES=mobileye DT_CHECKER_FLAGS=-m
>   UPD     include/config/kernel.release
>   DTC_CHK arch/mips/boot/dts/mobileye/eyeq5-epm5.dtb
> arch/mips/boot/dts/mobileye/eyeq5-epm5.dtb: system-controller@e00000:
>   clock-controller@e0002c:reg-names:1:
>   'yellow-pony' is not one of ['plls', 'ospi']
>   from schema $id:
>     http://devicetree.org/schemas/soc/mobileye/mobileye,eyeq5-olb.yaml#

Ah, so you defined the items but made them an random order? No, please
keep same syntax which is what we always recommend anyway:

https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L132

..

>>> +
>>> +  # Some compatibles provide a single clock; they do not take a clock cell.
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - mobileye,eyeq6h-central-clk
>>> +            - mobileye,eyeq6h-west-clk
>>> +            - mobileye,eyeq6h-east-clk
>>> +            - mobileye,eyeq6h-ddr0-clk
>>> +            - mobileye,eyeq6h-ddr1-clk
>>> +    then:
>>> +      properties:
>>> +        "#clock-cells":
>>> +          const: 0
>>
>> Wait, so you define device-per-clock? That's a terrible idea. We also
>> discussed it many times and it was rejected many times.
>>
>> You have one device, not 5.
> 
> Each region must be a syscon to make its various registers accessible to
> drivers that'll need it. Following that, I have a hard time seeing what
> would be the DT structure of 7 OLB system-controllers but a single
> clock node?

I assumed all these are in one syscon. Lack of DTS (example is quite
limited, which is expected) does not help. Please link full DTS so we
can see what you want to achieve.

Best regards,
Krzysztof


