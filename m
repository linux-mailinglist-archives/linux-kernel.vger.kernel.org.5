Return-Path: <linux-kernel+bounces-63502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0032F85307B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D117B22BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB453E485;
	Tue, 13 Feb 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEkBD8MJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9742062
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827235; cv=none; b=F/PyRhrwmVbg25jg/BjzGfac2IGavSEg8NLMxziuedRECycUBCTNRw8SpKhqsIwHhVluAK9OQr1SQktNMJ+oiYXdZveALIzlZBvBkYFlPRCrm5MepMBqPXVow0J256mOT0NnXJ0xxiiDE2WvYszgDJh0G24yHoI1IlmM3KWm+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827235; c=relaxed/simple;
	bh=bjkIq7wl2eARH0U8/btgn3LpomiEBzfaWXOPIvCdCoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLFhmbfhleqJmpvMBEQUXNqaQPVbFnffxcFXD4CyCb0Q1b5t8zruwpkeBbBA9E9YRZH8pn1jtz+pqjOFRzih26g63SWpcHyIE7bJqdU1OaR3ps8WhWhrEhhvDheAo9/d72VorxBcuzV8RMD4cJH737a6SZPaHL4+/Ei6ibukwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DEkBD8MJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so30019645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 04:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707827232; x=1708432032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpJhCN3vLprOIm3zRckJyvjcGrROFXwHZaUhtOClizQ=;
        b=DEkBD8MJGnrpwCWEZZhqNq/I2bsqk5CyNLcAG93bpz7v4RK71su56nkCZTQnPcRjMw
         OpbAQsBokv37fNxVsRPkCkKSooywX6JvDea3VxX1HuOJyWfI8VJ5OpBoJ95Q5wLTsJz2
         6s7riQ6OPeqxQdVLai9kD7Yhc9dZnYQFuacRleD/rvuQy9nXT+SuYeiv8u+lXnISo15v
         1WU1zFvR1qQAcUTFgJIg0FBl/76QzaRiL39goo5uRrgJ+TGv3honXxqxQhMXUVofHXgl
         bcLu3uAjxoFNB7lQ7ROEsUVZUyqJWgkjmThet6uEZ8XYPPKkPDVMbSFh9ywmLPSvS/4b
         Nm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707827232; x=1708432032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpJhCN3vLprOIm3zRckJyvjcGrROFXwHZaUhtOClizQ=;
        b=BjVj3lsGNMIuRQ0Si8Kdb+fFL7DEG2lrB/WGO6baokQX/WvlfEskecOrrXjd8FAyPv
         nQVhQCRTFfvRSnpugp6QzlLANods4/qNNnvJ5vtdCwMXnZXP66LBnbZDxmLxsn3WLKqF
         q1KWJGuF4rAEhpZqxHnHVfbhiUjriKB5lePZwvLfcyfGdOra7F4UO00LYYtq7uqXqhOS
         W86xdNYSVlGzn4z7k78X+NjpX9UN/Vm4BmQJzoL97haoxUKR70JAqAeiy/321wLEAnXj
         BLQA6CJFq43uiOgtOrJZnbEvpNtaHSsCBT8dHsN9Srd8pGzzVZDGHZ1r/1gNlwb1wHyT
         ZjWg==
X-Gm-Message-State: AOJu0YwQQWsYVtjS28eLNeR7VU89DxwlsOkl2/FLmJgG2JyUwh9sIcgc
	4SoJQICHudPTuOZRPUh456kvTzGqiq9RiFBrak4TO+2mJxPOCzhNXcoFd9xRV8A=
X-Google-Smtp-Source: AGHT+IGPVB4ptEvsrAiJNsOWx16hApPdpcjJQGekjp7k1HntHmt8ChpOga3AFIaSuNUg46knazs+wg==
X-Received: by 2002:a05:600c:4586:b0:410:8a3d:d29a with SMTP id r6-20020a05600c458600b004108a3dd29amr2166620wmo.8.1707827232301;
        Tue, 13 Feb 2024 04:27:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsv7dauGY5RSvde5gKIxepZNyMZNp8cNF06wuqbNHPXQCHpfx1boOvWAq65mzzOfkuXqKbpFiqCMUad2wbpaE68aplr78UBmvz7TkWgfE8lU0anZ/CCnWwG0731eYwDNnbIn5ZFbsBRVKM0wQGzu6Uhg6XZVzKXAnrHYGJOq/YU72RiNttICkl+vcyopKsGxTvDNujo6X64ZwENYdgZPLKeVgm9AHUOwNvQX/0A+exEivJSZRt2+BjjljJIFlCwXpNsCrESjhOyK2ZzsjeAg/9jjWup0/Prol8mQgJSfQNS2wYJmIjqkOMHov1YnycR+ANWoPRevX6OWjV+JA0xiw9dXJ1yciCYaoNDGgIg1DwtbcgIVYdqN4coGXUfkbmjrTB52B2GCchtY1nZOFdP4TWWnu+wm77T0rPcz2M68z3ckY5k7vG+jl8ezLsCGcZ0IdtDEmiEwzH82lavQXiSqTtWLN8WATQ8jUEliNwJS2Z120P1vXP7El4j+T/YuEyhHSRFQcJ/SPGsbZuMSWYMA==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id bh23-20020a05600c3d1700b00411b9d04b17sm1862441wmb.43.2024.02.13.04.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 04:27:11 -0800 (PST)
Message-ID: <eaf37a1e-58e2-4cc7-85f9-8cb81537b3b9@linaro.org>
Date: Tue, 13 Feb 2024 13:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] dt-bindings: soc: imx: fsl,imx-anatop: add
 binding
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-6-sre@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240213010347.1075251-6-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 02:00, Sebastian Reichel wrote:
> Add missing binding for i.MX anatop syscon.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../bindings/soc/imx/fsl,imx-anatop.yaml      | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
> new file mode 100644
> index 000000000000..5a59e3470510
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-anatop.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/fsl,imx-anatop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ANATOP register
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx6sl-anatop
> +              - fsl,imx6sll-anatop
> +              - fsl,imx6sx-anatop
> +              - fsl,imx6ul-anatop
> +              - fsl,imx7d-anatop
> +          - const: fsl,imx6q-anatop
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: fsl,imx6q-anatop
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Temperature sensor event
> +      - description: Brown-out event on either of the support regulators
> +      - description: Brown-out event on either the core, gpu or soc regulators
> +
> +  tempmon:
> +    type: object
> +    unevaluatedProperties: false
> +    $ref: /schemas/thermal/imx-thermal.yaml

So you just ignored my comment? I did not receive any response from you
on this.

Best regards,
Krzysztof


