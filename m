Return-Path: <linux-kernel+bounces-122690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC64788FB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645FDB2657C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CEE54745;
	Thu, 28 Mar 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2mHAKvg"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF658286AD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618232; cv=none; b=k4EteMC1bcVk4cISuvhYNPy8ycMacWN9MxxzzLBOgQAojAsXeiND7wE94p045cz4pOp0eN8Ld03hQYv1UZZ1y+cccLHDSCmt9JDqVv9Tb4Az36J6Pbn8D//qR0m0RK9EoBRP6ZTKuAQvzKi97qr4ynZ8Ulj2sfas19UcMvyhW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618232; c=relaxed/simple;
	bh=VKWm4uTo8irKKgcUZgBcqCGSUyd80eLZPc4Kyu53nXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJpUEkgmuggyTm3Dgu75n2kLfobPywfaodIjeV93ngKn2p+TjVjPYj+JXSfwe8f9xaSYVyy3KQu6kDpTjLYj4SW7YYLI/Dy0kOIeC7631JMwCZ6rbohET1ctpVt8+HWnJwKikX7DFCWn2bjoR8KOd/8s13OgP+/ZNIQo9aFG7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2mHAKvg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ed4d8e9edso476315f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711618229; x=1712223029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kiCNfFZh0nkvi1SPgsZIulG33GHq+ALEc35b2BSjdd8=;
        b=p2mHAKvgA1eeoMkjxRx9Mr3pPTQ3OAzs80MjxBynBDsiZmOfKi3Ms9wSD+OlEPTS4D
         wxPC+pWKQUtit3ZSRypy1z/ZQ5DbSfiI8hcpRYYveIMkxM7VBBtIP3tptMflZWTgI4zk
         Hu7zOeOZH42QWhmu3OlxGQY4PNJ9Uqi8oMBeGml1jEQYBBAyC9APmHbRfhxCQsrkUWIz
         Xsm1/fIcmS8loD/FbeFbGrsHhDMmZrGRWj/iUuwesW1M2xxXmhDCzMnr4elm7kP4CGA3
         BEBxfARKr0SmEzjBJjkPsO9xjkpkbjGTDpguRHiNCIeO8AL31s8r31O9sYYbFigEAVfh
         GgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618229; x=1712223029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiCNfFZh0nkvi1SPgsZIulG33GHq+ALEc35b2BSjdd8=;
        b=MQWJlzfsJsFDIjdxVa6bErbseK+TZssn2aqsJS+9LfIz26dQX90HiDq0gQoTbTt1tE
         8RMzJit+I6AcRQUUCuV0hvIy+S1kAvHcXG/IR3df7TOTST4vwEAT/iKEC9QR35bKR/QB
         o/6jMwiXL3D7efZSiItbetqx22oC1e1rSsXNSyVUQ3o8+ypOx5Tkb+hIChNnkWZuQNvo
         FAi6JrYFR3sKIfkSqZ9XFAYfnLVggOjSDSTJy4aa+4FwtIvXOBbilHFNyJsoKgVb/qDI
         6mShMuO+8VQ49pdPMsWPvsjptGRPz9PPbOPzqBfhjJOWZy5p5cy9VgHZN8wbr2ta1eJk
         xFAg==
X-Forwarded-Encrypted: i=1; AJvYcCX5AB7mSBkYmp663Gz34hbactcL64vpmuE5lf30CsZ5OiM9DwekNOw/2cp569Dnpiz8wH9OqHJkc0P2+7e7hF5M6Ds4HjohAopyfbZh
X-Gm-Message-State: AOJu0YykL62hvwMhNdrGaLRJHEe2dclDkseJIoiOiCumvlTiaUNO/3wH
	vk88Snm3dCRyX1PetkZtob+DqCvPuZepIZ7GbfGBQkBFELlwucQjUtqBU/n+2viLygLuogRjFfv
	3
X-Google-Smtp-Source: AGHT+IGNmIsLG4rtYVAIDr3d69lyAr7e+sdkXQvqqE8ACJYDaH8wRMfa04CF/vm+rEubbsyo5Io4HQ==
X-Received: by 2002:a05:6000:18c5:b0:33e:d86e:c020 with SMTP id w5-20020a05600018c500b0033ed86ec020mr1320546wrq.35.1711618229353;
        Thu, 28 Mar 2024 02:30:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b00341e2738eb4sm1248823wrb.95.2024.03.28.02.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:30:28 -0700 (PDT)
Message-ID: <d7fcd15a-8fca-4652-aa63-e01113ef8325@linaro.org>
Date: Thu, 28 Mar 2024 10:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: hsi: omap-ssi: convert to YAML
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
 <20240327-hsi-dt-binding-v2-3-110fab4c32ae@collabora.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240327-hsi-dt-binding-v2-3-110fab4c32ae@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 20:11, Sebastian Reichel wrote:
> Convert the legacy txt binding to modern YAML.
> There are a couple of semantic changes:
>  - hsi-port@<addr> and ssi-port@<addr> node name
>    changed to port@<addr>
>  - ti,hwmods was marked as deprecated. This is supposed to go away
>    once OMAP3 gets the same treatment as OMAP4.
>  - changed ti,cawake-gpio to ti,cawake-gpios
>  - describe peripheral requirements for the port node
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
..

> +
> +  interrupt-names:
> +    const: gdd_mpu
> +
> +  ti,hwmods:
> +    const: ssi
> +    deprecated: true
> +
> +patternProperties:
> +  "port@[0-9a-f]+":

Missing ^ and $.

> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - ti,omap3-ssi-port
> +          - ti,omap4-hsi-port
> +
> +      reg:
> +        items:
> +          - description: TX registers
> +          - description: RX registers
> +
> +      reg-names:
> +        items:
> +          - const: tx
> +          - const: rx
> +
> +      interrupts:
> +        items:
> +          - description: MPU interrupt 0
> +          - description: MPU interrupt 1
> +        minItems: 1
> +
> +      ti,ssi-cawake-gpios:
> +        description: GPIO signifying CAWAKE events
> +        maxItems: 1
> +
> +    patternProperties:
> +      "^(modem|mcu)$":
> +        type: object

additionalProperties: true
(I think I mentioned it last time)

> +        $ref: /schemas/hsi/hsi-client.yaml#
> +
> +    required:
> +      - compatible
> +      - reg
> +      - reg-names
> +      - interrupts
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ranges
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names

Rest looks good, thanks. With these two changes:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


