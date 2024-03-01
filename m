Return-Path: <linux-kernel+bounces-89029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433E86E9A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5528B1C238DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5CB3B282;
	Fri,  1 Mar 2024 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D44hhj8z"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501418646
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321604; cv=none; b=h588ObdsTWSXFjC7OPAycI0lxfgY93xIhlAkaRUFTXn4NUpXsV809O3hzuoX6DvUN+1IyWXUvOcqRcPh7HEx4TrutBmAfNljzRmTRqhIcFX6l8WOAt71Vh+FlbGQXoaqZYYYF5XBcfY02xCn9COXBUrACfm+XBcdi/ZBsEMio58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321604; c=relaxed/simple;
	bh=XTFuknoUuPcp9/oYoIaNvUMyaRQoWoDN4bAvT5zMykg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/xkQUVcH5Y98nt1ZkAFF2QW3GYsd8M6zFLDCcz1uELuLFkaBZm4Fd4zSGSjhzEFZMMLZy+gGfLh2ZeHckR8W1V39moXVEfgtlixC9DPHd7ItSffHPn7UdCinC9E5W/onE3mo8rlv/JSvs9YMReKZ3wa6pBDJp9cKd15EipyTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D44hhj8z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso3690157a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709321601; x=1709926401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfVmzkkW0SO5rGs/RCaiwFTIf6vb/6LRct9FefOPUc4=;
        b=D44hhj8z5/RAljKixdUGp3g5K+yzt8ZhHIm7/Qdvis0DL3oJ5yj/YYhrWYKTnNeZU/
         sNAFSjUv8XiX8JPvfBXJ5bF9b6B0Ej1kLjLVIkL7rmnAchK5+qMS2+IqECvvmQhId9bw
         25D7BGfXIrjY4sQtMOHiupjBixqI7BKmdjMYkd+42jXMzOCTRk29VSKmYuWVnJwftNmF
         OxNtM1VVju+14xiOSqFzhgqnH3uqvHiOfk4M+Fu568nY2Y6kDOhUZZ9dy+OtDPOp7JO8
         MMPrN6y7mH0rSvzwXJzkmStRJKhkViEARC4q/TfnL7XIN++n1cqPBhTYs1MDy+zJkIto
         6Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321601; x=1709926401;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfVmzkkW0SO5rGs/RCaiwFTIf6vb/6LRct9FefOPUc4=;
        b=eqnh//mzdszU7HvrR/P/J7DGdQDBKbkycdtuseC9GJ98onGF/RxmXd/hGDzw33fIAm
         DpjHFUk8yumSKHrxxa/rknCaIsAssjrpPrbKacJp++PKS5MCjUbkvNcFWs/Ne69XVN/H
         etm/dDsa7IfkMGmie83fPxIgRKKo+fAE3lXklZPzaYQdySY6efolAAwzvTqUUeFQ3sBN
         ish5F+MCtkPsk1Pq3miNrYpSVvdXWhD9arLomBj3ydaxhYjCSGWKdEFNWv8Aj81RVzSo
         0HLxNv01plj7J+a01+TJUpRT9f9RahcAomzi1B/J1YPvH6AfYA0L9n9lQVoCWpaDlzjN
         IJFA==
X-Forwarded-Encrypted: i=1; AJvYcCU41d4S2tGytKz/zugIGDW+1MfRB/V/3HGXFnfFY7vZ2LO45JbmNtGHWorb1u9Hy9ZZ4oVMrm2a/9L+EYQsL4O6E03ofcY5sSkXN7s2
X-Gm-Message-State: AOJu0Yy7mPmqEhwsDWT/uX87l7bI9JlQ4u+WeD+HmGtgSV60eJCnJQeX
	gjy87tXPIJjjwg43KeSb5kRIYvsTQbi6VsjU0BPvZ+sS4mu/6rqiyLnoguPK0nY=
X-Google-Smtp-Source: AGHT+IHL/7W01t2ZC17BSXkhtHuGhFsgLjLRWIJCMSmpag3u6JF5C+aWz4hR6jT48H1ZxV2FtACNEQ==
X-Received: by 2002:a50:c88c:0:b0:565:f90c:1263 with SMTP id d12-20020a50c88c000000b00565f90c1263mr1899623edh.9.1709321601115;
        Fri, 01 Mar 2024 11:33:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id es14-20020a056402380e00b00566d9c8e6cesm686484edb.21.2024.03.01.11.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 11:33:20 -0800 (PST)
Message-ID: <81e42a64-03c5-4372-914d-9f2df517dcf7@linaro.org>
Date: Fri, 1 Mar 2024 20:33:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: imx-pata: Convert to dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: dlemoal@kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240301174729.238869-1-animeshagarwal28@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240301174729.238869-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 18:47, Animesh Agarwal wrote:
> Convert the imx-pata bindings to DT schema.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../devicetree/bindings/ata/imx-pata.txt      | 16 ---------
>  .../devicetree/bindings/ata/imx-pata.yaml     | 34 +++++++++++++++++++

Filename like compatible, so fsl,imx27-pata.yaml

>  2 files changed, 34 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/imx-pata.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/imx-pata.txt b/Documentation/devicetree/bindings/ata/imx-pata.txt
> deleted file mode 100644
> index f1172f00188a..000000000000
> --- a/Documentation/devicetree/bindings/ata/imx-pata.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -* Freescale i.MX PATA Controller
> -
> -Required properties:
> -- compatible: "fsl,imx27-pata"
> -- reg: Address range of the PATA Controller
> -- interrupts: The interrupt of the PATA Controller
> -- clocks: the clocks for the PATA Controller
> -
> -Example:
> -
> -	pata: pata@83fe0000 {
> -		compatible = "fsl,imx51-pata", "fsl,imx27-pata";
> -		reg = <0x83fe0000 0x4000>;
> -		interrupts = <70>;
> -		clocks = <&clks 161>;
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/imx-pata.yaml b/Documentation/devicetree/bindings/ata/imx-pata.yaml
> new file mode 100644
> index 000000000000..78a562587fb5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/imx-pata.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/imx-pata.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX PATA Controller
> +
> +maintainers:
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
> +
> +properties:
> +  compatible: 
> +    enum:
> +      - fsl,imx27

What are you documenting here?

> +  reg:
> +    maxItems: 1

Blank line

> +  interrupts:
> +    items:
> +      - description: PATA Controller interrupts

Blank line... just open example-schema or any other recent bindings
which were reviewed. Don't create entirely different style, but learn
from recent code.

> +  clocks:
> +    items:
> +      - description: PATA Controller clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pata: pata@83fe0000 {
> +        compatible = "fsl,imx51-pata", "fsl,imx27-pata";

And now please tell me how does it make sense with respect to your
compatible in this binding?

> +        reg = <0x83fe0000 0x4000>;
> +        interrupts = <70>;
> +        clocks = <&clks 161>;
> +    };

Best regards,
Krzysztof


