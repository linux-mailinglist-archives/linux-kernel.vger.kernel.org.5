Return-Path: <linux-kernel+bounces-147185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB358A70B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59991286479
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ABD133297;
	Tue, 16 Apr 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EB8iPRfD"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10600131730
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282872; cv=none; b=oazVf2UYHL/Xve/GgQYmU5+y1q0VhAkzCD3T7+HX5KGwDdPs9+N+ajTk8o6upkrkNZsA6sFiWsiew3QZOhQXTs8H++ZUQKx1AqDIHtFt5TaLzzZIfCKpgKcW5wiHd3KSx1wVoZniHMREW5b3Ig5lxiTFYqCfFffEYNcLbHL8UzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282872; c=relaxed/simple;
	bh=NBX22NzAV2D33/9WevgMcwY9UIk9hlcXx60fYqEoTf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rdds9EASwmanYI9tHfsDN6ujFsxCulOm08go6VBIkkQmTwvuj1btDoFbWknneAgR5q/15PkBAs0CKyEsHdwfms9sXJpVxVUwGApRGFRPXJBdEddkFzfdfCrx7JyKnypPvvZlijg6G9+Q32xJcDisq2GD9dLTVNx+RX/zQtLD+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EB8iPRfD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e5c7d087e1so29362595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713282870; x=1713887670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I3CbqEVdCbWeZaOCjzLjzDTuSiZuxL3hZ8odrscUk2Q=;
        b=EB8iPRfDwRIp0ive8VqaEkpG/vryjbLOdMmFKIPU4pDW29jbCMRdHq49Bb7MQBKsUO
         aCbdPtWsG4yIV4WXSC+enqF8ZDNk7QxUCz6VjDAc6ExqB/EaxSIzWileq2bPy2MZ68CG
         boS1nB3XMOSkTtiu/F/8Bm8xO1oXWxEyyLDAeroHVa4Zh+9QDfgDTmkIKcYM4J+xr4UL
         k8vXSRnYa9Fdp3e5D01PDDYvbhHr6kIEvJyss6RyCKOL9rqzhKYhPqP6igAXC+Gd9uUv
         /C1kiX2IkIkmFCqsmQvDCVrHcrBftvUqkDD5BIh9YUvqNSQ7pDypra9zhvOHlSoLvsSZ
         R11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282870; x=1713887670;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3CbqEVdCbWeZaOCjzLjzDTuSiZuxL3hZ8odrscUk2Q=;
        b=gdIPXKK5Kwo91F8L5LYuVa3b0l6nDimorX9thEegC1/hcYB3pe/1sQePjfuYnNASvf
         bvq2YC7zUB72c0u5ZtsEkiBtfsD6SLitEcQQsaEQ5BeazW93XbRb+93jSCzdkpXAs95y
         YdooB5/K01FScsfsTekdRDDEJCD1loANiGeRMBTbpyfb9Ua6x6NSTGSg5f4q077w8vnK
         0Mr/kFDvuU/SA3SINlySHa1yZhULm5lLkU7iqtS5papiBAgfdXh0LqA7uOgQOORM3ULH
         1rHtSi/e2sb5UjHWm+FvGIGlT4tt5oxjiu3RZpZLjTzKqnFu8mXz9J/MAEOoW+Xm9YP7
         laXw==
X-Forwarded-Encrypted: i=1; AJvYcCWO00ckFxlcrkjbh0PQmxd583jiYwDptDLRa6Cochww907KqGoNdDRST6I0EgGYwiPuCEQcwBiKOZw/sCKEO85STQQmMrygbKpCTESf
X-Gm-Message-State: AOJu0YyVxgmPvcUm8HcG0Y8vX79SRkvjlDzeeGIWQGG/FIQ8X9/k4Uhu
	kYXejiKyCi7EJXB8T9dee638iK9nbtFy+gIrgFVFhfzG6ikUpzkn9TnBcLscSac=
X-Google-Smtp-Source: AGHT+IF84lscKCKBm2lowk+hN2Zdtfz4iAdfwocwbawEyeIb+vu86YJ348uVkLyfaajJ3OZlMUKxgQ==
X-Received: by 2002:a17:902:fc44:b0:1e1:1d5:f857 with SMTP id me4-20020a170902fc4400b001e101d5f857mr13761677plb.34.1713282870357;
        Tue, 16 Apr 2024 08:54:30 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.155])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902e54d00b001dc01efaec2sm9939360plf.168.2024.04.16.08.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 08:54:29 -0700 (PDT)
Message-ID: <1f94ee56-7f8e-453b-ab86-f640b298d81c@linaro.org>
Date: Mon, 15 Apr 2024 17:24:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: power: Extend battery chemistry with
 capacitor
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b2a893bc-f00b-47cf-ae07-b37ec1bace22@emailsignatures365.codetwo.com>
 <20240415081305.316107-1-mike.looijmans@topic.nl>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240415081305.316107-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 10:13, Mike Looijmans wrote:
> Another technology to store energy is a (super)capacitor.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
> index 491488e7b970..a22c97dfad88 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> @@ -44,6 +44,7 @@ properties:
>        - const: lithium-ion-polymer
>        - const: lithium-ion-iron-phosphate
>        - const: lithium-ion-manganese-oxide
> +      - const: capacitor

Please keep some sort of order... everyone insists on adding to the end
of the lists...

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


