Return-Path: <linux-kernel+bounces-144759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE18A4A57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0901B25793
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85B374F5;
	Mon, 15 Apr 2024 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtkS3/f6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4492D022;
	Mon, 15 Apr 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169739; cv=none; b=LctAxbDg9urmLaTLrAZ8LuqsS1kCIPWkNHpItANcrNc3MuC0f0hH+mmQ94Ro6zEv6kPQGwV4JdfI1IgY9Nz+yodsrgCDpeONuIi5KzJAuNA5CgBIjYhUH2MYTzslzNhHQy+kXQfzsewKUL2NDhrDTAm9zPS1upBx/zBsBgmS2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169739; c=relaxed/simple;
	bh=QPCH8pvDeCCkjQyDPsw0zPk7mzXPjI7CrC2fv1CC2rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EowbrCoTy06b8Vrw9WfUOhNgVDpfOKRnEgC41TB+xxKS+etcCpU11vseJfCV9m91wy3z6nJ5vQ28poNuL5Npyg6CuS/Eyggc2Kve9ciUl5vshg7nVLSfQl1o98JNfyRPXK8zbLe9k4qgHKNbendhn61voz9aaOb8e+Q8y52sRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtkS3/f6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so33481581fa.0;
        Mon, 15 Apr 2024 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713169736; x=1713774536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DteUBQheQifq+7BN4COm2xS4eoeVr4VB9kK9ci0lcbY=;
        b=XtkS3/f6C0YAN/bimgHv9Sf0pIo1Ehp7+t0mY2RpawNbJomDQg5Gmk/iNJ3BrgQWZN
         Mdlt2P76fElHjuctyqucFVU+s+ryLvHkyUDANhoH+fhKCshpH9n8104kRbGIqQ+Ag22A
         hAgmx0cAk5UDDAaY9cf7iEpPVefFrqqie6yPR9p2T6Q0hvj9d87qrrOhRhreSw8jxmN5
         WL/sCmzsC+CgGSFxy9/qX8hv0qh8Ex7qKUIdQhIIbH1sYXt++Aul9158RGGx3CELLPdU
         Idb+KVIgeqP1DYhZ3v3GEB8X5HtQngk9r6+M4DVghoyrQxDkXKhQ+XNLTpmP9WlyqwI2
         hq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169736; x=1713774536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DteUBQheQifq+7BN4COm2xS4eoeVr4VB9kK9ci0lcbY=;
        b=vt176NP/42iciKnY5f0w98dv/8kCMxTc4ZtQ9NX+wH0qPS5HC29q8u+A6e+Wt4+Inq
         2C3U6Wbs+ArAp+hHe9zEg0RrFKdq9qVu2OkouJmadp5zNyazyNeV8wmmvhFOYQySvUVH
         Sc9mFw+cvCQZpmLEy+LWv43EChCVcntYiYjmUQJQLhuG4IFahEkPVpvhSwfSgLvpbQ0w
         Bc3IF/W02SPQ3P+Inw6+iqKqBAj2PTb2AOgQEsKZATRXzPI4WMGQyefyXzk3Vme8m2J8
         yOJZM/PTrD2IW90X/1vRsxMMr1iEZ0msW8jCxQFC5chjaZG8eTUrjCZHn2dIgBe5Ehdc
         TqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIBSJEQipm2VdISS2htYZCiaEdF/N2sod5o8B/eNimw8oI+h03oSu3xozy7FzX7qI4RAm4UxpLZ5CzObFpoTXh01yjwhDv4iYnE5bzPs8YhHx9ULpG9yLam5Sok0+vM9WF8v8yvWYaVomuGmUQjmhLABGFxeWGV7sAevZ8ts2EB4XzeRBSpV+V
X-Gm-Message-State: AOJu0YxljPXXPEw3AbzrwYoIhmD/ospaaVTnNBt1RIhs7vHfUKbf8ghF
	hMxhssDdcLK+ZvOtZ4sViZr3UVi6j4CxdTMNfQKBINI2uObmWuKI
X-Google-Smtp-Source: AGHT+IFHi1Akx9QfNS+pJPw3+jOsIavo82rP27l+lMa4ETeyDwhQOc6MMhek1QvN4H8U6HC7EjjMGg==
X-Received: by 2002:a05:651c:170c:b0:2d9:fa96:1634 with SMTP id be12-20020a05651c170c00b002d9fa961634mr4925792ljb.25.1713169736128;
        Mon, 15 Apr 2024 01:28:56 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e9187000000b002d4932b7a94sm1180804ljg.140.2024.04.15.01.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 01:28:55 -0700 (PDT)
Message-ID: <7541fb24-894a-439e-8f9a-b18f04e06afe@gmail.com>
Date: Mon, 15 Apr 2024 11:28:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/6] dt-bindings: mfd: bd96801 PMIC core
Content-Language: en-US, en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Fabio Aiuto <fabio.aiuto@engicam.com>
References: <cover.1712920132.git.mazziesaccount@gmail.com>
 <ea49494429528cf8e60fa984ae1f523ddacd850c.1712920132.git.mazziesaccount@gmail.com>
 <b5eeaf10-e011-452b-840a-176c4f62cac4@linaro.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b5eeaf10-e011-452b-840a-176c4f62cac4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/24 00:33, Krzysztof Kozlowski wrote:
> On 12/04/2024 13:21, Matti Vaittinen wrote:
>> ROHM BD96801 is a highly configurable automotive grade PMIC. Introduce
>> DT bindings for the BD96801 core.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>> RFCv1 => RFCv2:
>>    - Document rohm,hw-timeout-ms
>>    - Document rohm,wdg-action
>> ---
>>   .../bindings/mfd/rohm,bd96801-pmic.yaml       | 171 ++++++++++++++++++
>>   1 file changed, 171 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml

..

> 
> Missing allOf and $ref to watchdog.yaml

Huh. The watchdog.yaml contains:

select:
   properties:
     $nodename:
       pattern: "^watchdog(@.*|-([0-9]|[1-9][0-9]+))?$"

properties:
   $nodename:
     pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"


This means the watchdog _must_ have own sub-node inside the PMIC node, 
right?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


