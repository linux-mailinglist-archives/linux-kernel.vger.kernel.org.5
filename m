Return-Path: <linux-kernel+bounces-137041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D5B89DB82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB5B1F22CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64512F5A6;
	Tue,  9 Apr 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LCMZ5gW+"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC512F58C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671253; cv=none; b=P66T6DcpSbbbPcfqEYkbZuT80dHoWqESaVEMiHihmunZmTiJlZuNcPP7PWKKK2quoeBoO8s8eUQcKvdmRVfs92tqu5edIrrVV5nLGr6E8KgonCeYaQ4ts+MSVJWRCTmL4GNCvCFWCeIcyMsNf8SBeSL8zz0V1lvR9DkVz0lTgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671253; c=relaxed/simple;
	bh=n/FORSGD0TRTANAToNcgVGllG3FAFtUbZNICoT69fl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INAlV87BMYeZg6QWqbEAuYV2pMNs6yrIDcApscfVHf3vvO3PtLzAXGtLgb3HECQA5LSXBlpTOZQnpEJe0scYapO1WfQknIlMyaSSGlnSjcdjJXmIhJmnXdMQxa9roJCOsDxdaCtbL7oVSaxkjcCwPOMrP9V2aRWs/c2hLry4E/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LCMZ5gW+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4169d794358so6713245e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712671250; x=1713276050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6XY9gemEnKQZfGkDJK75MYVrheD1n1AVfYd5ZmSr3os=;
        b=LCMZ5gW+sk1n0PSq5W+MroN/UmZbv/RpYNeEIWEeRlDrSirnSECuWteqN9d072zSkI
         0jcwrkCb25EOCasYCekDtgc+oqvPKzaM+IOIxzCKTUSAgbkl25zUDFBOVXARKqV4LqOT
         ck3Mz1zPHiysw4TXHA06WhGwnqHdzzDFQCEscIokl/G01niVcmPkL06cfqQc7y5iGJ+o
         wQk3/KTrtukyH7WL8vZFu+v+fYfqmls0reGVZaegYgOk+o2x/zDdZEi+UONDANloJM4W
         iL5nL7yuYq2ln5fNzbRW+EssGVwH+uUPnFVJpInzYIcCnbGMinCxqmMp3brktFVlplzj
         NQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712671250; x=1713276050;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XY9gemEnKQZfGkDJK75MYVrheD1n1AVfYd5ZmSr3os=;
        b=EIJZ91Qrc4V9hBSjca0qPYat7HcguVyBpIif52ujLKNom/3kf0lcbD9z15kUsIgREx
         Op38Ul0MZuC7ng4OBIWiyPj/FyWCZ+OhYsSUbCmD9vDjiDzAFTbVKTBctlPPPodvX1Os
         ZtUqPP4TsyJ2LkaEqDEIOxw1oNnPFj/FxWQ4CRBtyGjGyOCa/J1f611wqMpnwJmXHFgj
         HXZ0Imb2wtGZ8KI+IhBXi6tJa3SWSGvkDwRygjbw3HfztYL5KekhlSuq0WDqSn7oOAKP
         FjEOJSBZgsa223t1tXVdqGIU/3dh0lJ54nboOihkzr+37le59aa7SfcGNUI9R49REisD
         Xw5w==
X-Forwarded-Encrypted: i=1; AJvYcCWpIO4oTwTFE7aBBLTjgT+jYQwzy7sMRUZfaaO4jc9/9bn36pkSCOdAIYeaha3Wz5bJ1wtnC3hvEkWMjLEjBx58/Ol7slaxlHTAxzjC
X-Gm-Message-State: AOJu0YxBD1jaAEpSiAvHcPkj+b01SgsK0LIcvIveTRbEUcqZKJBX++hU
	/tBDlhbKvmVX8a1ZFisysZoBnD0tGRGDso5gqtU89XTvMcPmPuX3idqAcwBaGq8=
X-Google-Smtp-Source: AGHT+IGlFsNH05uCK+fbodwNpF/BH1Rgvdob2lMI9FViPbIBrYDefgMlLM4xPEmC3bN1HA3QS/eQgA==
X-Received: by 2002:a05:600c:154b:b0:416:9c95:b712 with SMTP id f11-20020a05600c154b00b004169c95b712mr1832422wmg.20.1712671249933;
        Tue, 09 Apr 2024 07:00:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b0041663450a4asm8879318wmq.45.2024.04.09.07.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 07:00:49 -0700 (PDT)
Message-ID: <5e80dc7b-e848-46d5-879b-b72c1ac6ba97@linaro.org>
Date: Tue, 9 Apr 2024 16:00:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] ARM: dts: aspeed: greatlakes: correct Mellanox
 multi-host property
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
References: <20240405064624.18997-1-krzysztof.kozlowski@linaro.org>
 <171266958251.1032405.3082451019333889181.robh@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <171266958251.1032405.3082451019333889181.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 15:38, Rob Herring wrote:
> 
> On Fri, 05 Apr 2024 08:46:20 +0200, Krzysztof Kozlowski wrote:
>> "mlx,multi-host" is using incorrect vendor prefix and is not documented.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes in v2:
>> 1. None
>> ---
>>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ampere-mtmitchell.dtb aspeed/aspeed-bmc-facebook-greatlakes.dtb aspeed/aspeed-bmc-facebook-harma.dtb aspeed/aspeed-bmc-facebook-yosemite4.dtb aspeed/aspeed-bmc-facebook-yosemitev2.dtb' for 20240405064624.18997-1-krzysztof.kozlowski@linaro.org:
> 
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e690000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'mellanox,multi-host' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
> 

Just FYI
These warnings are expected and not a result of my patches.


Best regards,
Krzysztof


