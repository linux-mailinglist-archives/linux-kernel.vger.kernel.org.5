Return-Path: <linux-kernel+bounces-56093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC584C5DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261391F267EB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926120312;
	Wed,  7 Feb 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3F0CSXH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855CE200AA;
	Wed,  7 Feb 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292503; cv=none; b=M3XbY2etKT1JyRLirnWrcDQqhoHerHq7Rn5TWuaEF7mIw53Zf/vBstTWVvgkexqseMht3z+KKaBaZtWJ0LTBA5Zb3Y32zkgEbw+WBfdR0vqnmfLXn/y6WOk27Vg7/fFZR9F6M7OCbHHGbeh9LgS079liHdL2glNdwltknaDx8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292503; c=relaxed/simple;
	bh=plo9ffD39AflvULKtb7V+e4QpJ5YhVSIF75AQbjiprE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csRz/sY+mu3E/fJl3885+j+Hl4WQa09lJkP6BKe2aWwVJjH1FaNx4gbj92csokqO/qbzcDxBI5wYaBKZK8fXytcSD6tmVLp14Z1a/NUX2Z2Qk2Pl1+Bld+/CgxqHGa3mpneZ/iCWeiq9EECOa3LzQwhbPvvYXrT910KzNWfDUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3F0CSXH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a385fa34c66so40132766b.1;
        Tue, 06 Feb 2024 23:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707292500; x=1707897300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5siQqDPvIzVZKJKzFGz6pPdvnLjufoJPCSBU/Y3gTLQ=;
        b=E3F0CSXHZLcQ8A3/tUgeVv/kcNG2W71aBEgEesfqz5j3kvTSUYkxd79ki7IXwSFM60
         Wpv6/saGPlnO65d+D3TYJ3fT5eIQpYavwE3O9ZkUXNGb1jg29zO5IkuGrlkLgIR7l6zm
         ayGLWAVqSJFEwsEJVx60bkRhuXh/sXxcFoa1y0S12Oy0JO4L7OkbJU5n+8owPBV51vUR
         +7DA2FeSgdnVaykaPO78LeL5YRy3Qb2escLIr/XrK54Sb2HesaoeKQg7aAuaDXT6/6DK
         ZlTZRmNGDSqY/vq0sUnMx1FhA/7SIDk3Kkcg+rATeecBkBwSK8BL1sEQ9xi7MMD1lj9z
         bTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292500; x=1707897300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5siQqDPvIzVZKJKzFGz6pPdvnLjufoJPCSBU/Y3gTLQ=;
        b=owD6Bd+pAOYaYre6CkHS1RA8yod1LJXYfAeI5/eQB+hLRnKragwTbTcuhkcTdWqHow
         6QAtkmEeFrkY+ZBi3HKDcgJ6wlcdr8LRRqWiiCkr/5uqd6mH4jcH/aJYia3ThlQVGJQs
         RN/ti8+8qD+uEPXgtWo5LA60+cQbnkPkfdJcFMURdjdMbay1ivb2kLpRoEp0k7v3LM5k
         Vq2x8I3YVnuiT3ohIckdxKeS9+yHcLnjM/qvjY9iNApHzN6QlXd3O3AqXmcmsK9vLR8w
         1xZwimDEsl3PHrXrUcM+qfJSXqL2nTnTBjtfsXZGCk9aKszLx2bbqLlJ3JGThVQmP+pl
         pzHg==
X-Gm-Message-State: AOJu0YySuptoA4Xgl8E0YQNQD9LpefzLMkrm8ifYcF3IobxVU/9G5rBq
	zsGxsKenD483ZBje/jAzMTTzcIKYQ73ZsWFAwbWf8anBeDmF2OfQ
X-Google-Smtp-Source: AGHT+IGjilopHWWobuDbb4rhf8FYRAuvtIhKc0v0uJfyOtiYBgO42Q1Y0+Y8nTldOI51yZjQD6yQUA==
X-Received: by 2002:a17:906:ecac:b0:a36:8cb6:92f7 with SMTP id qh12-20020a170906ecac00b00a368cb692f7mr3008358ejb.77.1707292499559;
        Tue, 06 Feb 2024 23:54:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVu2cjRG6zO6MdctV8q8Cr2LmysVb3AReab7AY/n7DJupJ1B7/iQle9snjRmpUytzoNo1xTBrZeuRsMbvpGlxlU2KIzpeuO1bmKHOfYey09kWj78Ndh4mbK6f2jOHIE4HpN7Jdr3x03KmFBwk/6jeCsaMBSAqrZS260M2BUIKPTsuN3t/sEvGNOGO7kcfSEy425rzL2ttpuYkgWemdvsoVqT527DTCg/Rl0TrMusw+e6fvJZcswwUv4zt7mXVINphp7Pn/+7BJA182DLMCHIvkICXsGYhCEKQ/a60MN7NdTXPd/Debkp2E23DuHVbxDf9gc3V+9q8YAfXA+LVb1LKCzbzOu1m13
Received: from [192.168.100.74] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907a70d00b00a37585d5dcesm456935ejc.51.2024.02.06.23.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 23:54:59 -0800 (PST)
Message-ID: <626fe429-98b3-4319-b104-ef66e4b7afdd@gmail.com>
Date: Wed, 7 Feb 2024 08:54:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: humidity: hdc3020: add interrupt
 bindings in example
Content-Language: en-US
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Li peiyu <579lpy@gmail.com>,
 Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207074758.4138724-1-dima.fedrau@gmail.com>
 <20240207074758.4138724-3-dima.fedrau@gmail.com>
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240207074758.4138724-3-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dimitri,

On 07.02.24 08:47, Dimitri Fedrau wrote:
> Add interrupt bindings in example.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> index 7f6d0f9edc75..5b3f9670fa52 100644
> --- a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> +++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> @@ -51,5 +51,7 @@ examples:
>              compatible = "ti,hdc3021", "ti,hdc3020";
>              reg = <0x47>;
>              vdd-supply = <&vcc_3v3>;
> +            interrupt-parent = <&gpio3>;
> +            interrupts = <23 IRQ_TYPE_EDGE_RISING>;
>          };
>      };

Did you compile the example? I think this will fail because you don't
have the include for IRQ_TYPE_EDGE_RISING.

Best regards,
Javier Carrasco

