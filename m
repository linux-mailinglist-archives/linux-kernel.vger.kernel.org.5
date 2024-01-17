Return-Path: <linux-kernel+bounces-28847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F38303B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBEB1C213EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C851C6A8;
	Wed, 17 Jan 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vv//fV6J"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2652214019
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487675; cv=none; b=KmquE4rT5Jd4gbuRtAZd8f4X1Pr1agn+Ia68GQSFJLjnkFEwJUW8vtkJmNrwpR6p0lWkBCH5JdzMku4cYkU55zylvSFHTJ/X0M1sGcsr9ptyuHnXtjS0BG3JfvbNd1KeQVuarkGd/kYoORyDzaTWAZZBxMhuxqqTEf6gHS1L4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487675; c=relaxed/simple;
	bh=Q0Q64oaZyHdJChVRsCmip6LpTcScnkNPpVHJ40Mrypc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=lZqw1xMb/4ypKCKjoo6ZS747cxxpE0kBm7u/wh4u8SjabcbrZnVJ7y/+q3qNbPcSVAviQiUi1UCP6BQrYrRA+7kidLCcmQcHtnn6qLu57kLNhK0b7KpIR/W/4RI95Ls+BN8jGRIv19XxzY07Dtubh6OqoVlsVq2EhEj4u1KMKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vv//fV6J; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-559b6786561so1579197a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705487672; x=1706092472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GGLBVGU4Yylzq9JDhA1QprTUMZUU0Y+oGnERBsElLk=;
        b=vv//fV6JGceE7dmu1GoSBUZOeswGW1sDnMaLEb5wvAmYnIavw1STqFjQHJlTUeFXAm
         ncG256yURKEEHktMGSomQtinDCioNeZNkcHuPRMdVqrf/aaTRROFbKKk1Y/RdoCM1fe6
         cfPhxHVp/R/c+Mp57+bVBHgMfDoDj4nDvCKvgpuAzDxXOCISq953o5bppvJCdSgICLiL
         JmOXlBEBkfppcu4/5vxwcz4p4vyB6IiFYR5/3mZ8XlBXWGxPBXwiMSjsps12wqtjuJkW
         uwzKoSplU7+IgvA3xR9XdcBIXXidLqJU7A+bN5jbvsZlylaTy01blauhUQVIUwZZkcqq
         o++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705487672; x=1706092472;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GGLBVGU4Yylzq9JDhA1QprTUMZUU0Y+oGnERBsElLk=;
        b=h6Mtfqr9sTUEe6yKCveK8FUDRSNz/8+Zkh5dGigya5y1C9DLhu6zWjw+ZFDEGZp3/r
         WmBVWM57dQwNvhCZ+ORJYiXbobHYZyEtfRgktsQRz22285KOLDrhFIsBe8UtyORN5Onq
         ZvuZy4mhdjxQVc/rc6jQb6hIRVmPvVJPYk2X950J51Lcxyv1CKXqEgHo+E/UvHrgGByS
         dE0S9nf3m7+MlLD7A8V4Rp+iy86wdVjgnbNssWw6fLfDtHWZehpKCd3i4oKAVdAVeznx
         nZ7/U2IfNNvLYm5NyBgGCs1ogOdF8KH8otXDHtTNZa5r9MigAf30rYy78+cEraxnMJ0a
         Xilg==
X-Gm-Message-State: AOJu0Yw4UUDdHEECpY8rG209xCxoReuMp6XKi+FnhLluKXdeFIPvb4u+
	dRniGfFEjxheIyDdMXQXjp5KCCZBan9z5g==
X-Google-Smtp-Source: AGHT+IH717qKkfDNUHKkIIc7kCwtWbV2Q50Qmu9iJq/3pxDBScMHRNNqRyoa9pjaLRqcyb60wSVuvQ==
X-Received: by 2002:aa7:cf04:0:b0:554:3ba8:f804 with SMTP id a4-20020aa7cf04000000b005543ba8f804mr3937221edy.28.1705487672368;
        Wed, 17 Jan 2024 02:34:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id p25-20020a05640210d900b0055746f354d8sm5530161edu.56.2024.01.17.02.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 02:34:31 -0800 (PST)
Message-ID: <28fd561a-7c13-48dc-9995-230dc758f257@linaro.org>
Date: Wed, 17 Jan 2024 11:34:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: PCI: ti,j721e-pci-*: Fix check for
 num-lanes
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, afd@ti.com, srk@ti.com
References: <20240117102526.557006-1-s-vadapalli@ti.com>
 <20240117102526.557006-2-s-vadapalli@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240117102526.557006-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 11:25, Siddharth Vadapalli wrote:
> The existing implementation for validating the "num-lanes" property
> based on the compatible(s) doesn't enforce it. Fix it by updating the
> checks to handle both single-compatible and multi-compatible cases.
> 
> Fixes: b3ba0f6e82cb ("dt-bindings: PCI: ti,j721e-pci-*: Add checks for num-lanes")
> Fixes: adc14d44d7cb ("dt-bindings: PCI: ti,j721e-pci-*: Add j784s4-pci-* compatible strings")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 26 ++++++++++++++-----
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 26 ++++++++++++++-----
>  2 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> index 97f2579ea908..278e0892f8ac 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> @@ -68,8 +68,9 @@ allOf:
>    - if:
>        properties:
>          compatible:

Missing contains:, instead of your change.

> -          enum:
> -            - ti,am64-pcie-ep
> +          items:
> +            - const: ti,am64-pcie-ep
> +            - const: ti,j721e-pcie-ep

>      then:
>        properties:
>          num-lanes:
> @@ -78,9 +79,9 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          enum:
> -            - ti,j7200-pcie-ep
> -            - ti,j721e-pcie-ep
> +          items:
> +            - const: ti,j7200-pcie-ep
> +            - const: ti,j721e-pcie-ep

"Ditto

>      then:
>        properties:
>          num-lanes:
> @@ -90,8 +91,19 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          enum:
> -            - ti,j784s4-pcie-ep
> +          items:
> +            - const: ti,j721e-pcie-ep
> +    then:
> +      properties:
> +        num-lanes:
> +          minimum: 1
> +          maximum: 4
> +
> +  - if:
> +      properties:
> +        compatible:
> +          items:
> +            - const: ti,j784s4-pcie-ep

Why? Previous code was correct.


Best regards,
Krzysztof


