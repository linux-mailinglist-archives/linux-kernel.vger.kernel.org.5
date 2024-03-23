Return-Path: <linux-kernel+bounces-112485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C78C887A6D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186F01C20AE6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1959161;
	Sat, 23 Mar 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UazFPNk9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECB1A38FC;
	Sat, 23 Mar 2024 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711228684; cv=none; b=U3eogo6jZSqsGH2+0ApBtfs96EvuuEwqPA4TKUP3IWdW3kq1rqoBYrqryoPAji2dp4GAWul+qWwPobY7NovNqDOFZ+8/EFdRRvUE6gzxBW41M3bWJ6DUfM84b3YxnPHsKJTMZDXAT2yxyEkMJLNDwN5K3C5eyzsHSxDpC++ik3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711228684; c=relaxed/simple;
	bh=3IR6+azhCfPyr1SvRmZLmSOsS1saIo/5ABkALBwv9Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI7/qehPWeg07kEih+Ao6IMtyDRyN5tDXdSJzsuTwfd29gP9FmTmDtT0VbSNykIophhnQ4q7+Boabqy31F9PtbUF9puGZwYKEkDIpG75t4aE44nfuBRV6kxgZ6x1WdKMb1nNUymYmCdH5NvDUkH22Er31Zf90QJyFJ5kY307/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UazFPNk9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41480df2ce0so5740005e9.3;
        Sat, 23 Mar 2024 14:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711228681; x=1711833481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jrmFxwvHn+1SRq6v+CJ783Vy+oA3qLS0/S9njDH5R0=;
        b=UazFPNk9ESo3CRgW1H9eQwayQ6/ZBWTeYqyYxQduNQhVayzZcU/ielXP607KBrsiZq
         JvvmAJvbg6/QAUrjbWQawlSoQy3nrhuSFEmrsmFtdHYt/OJv+EPRLYuJRurcuZOZjzSA
         5g4s1NrpnZa6nZlABSjzPuxSB00TWfmgcjO+Pl89NZT+HnIYs3IfO1iPxcLArZ2fRID1
         AGsOA454l6i1B0jk1B50S7BOfLtO5u5ShrvG9sMXH/Wo2rKWcGFLIflG1c9Fb3oae55e
         SJBXjkIKclJJeUWWZ93VxnTYKhql6TS7aHJuud8lKwPP+XsMpB1PvWNqLXXi7oE7+UEe
         okrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711228681; x=1711833481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jrmFxwvHn+1SRq6v+CJ783Vy+oA3qLS0/S9njDH5R0=;
        b=qseD/uCF6i0KBnr+TU/hanEKhlft7nVmFvgP6IXRAkqsojOZsMl7mvfHGfewFx1D+b
         CewqqLcj3FDamUUlYWGZs9DY2K3wJV3tk9+3Gk0ciCPTRZvdrGAeVMRU63Z16GCVNBJa
         ogIewqUHUxwtq2q1kgTg9fSPJ1wyOE/YxnyyfkzGECPqa1ejlCA0NttFKYY6VObUDS0V
         C4K1YO+RxILs3i2sgYPUXeuwiEH6a9lx2SUZB9fbBuPqAhoJyA128M++rPOVyyO5AtT2
         JsaxcXIQXldl0IkQoxmYyF1C4wVBFsMAPKMJOune4AKmUPGXogaxULGHn9fu+dfmOyQF
         J8lg==
X-Forwarded-Encrypted: i=1; AJvYcCUkDrfaNG5CXy+5pfFTThiP1bKzXZAfkU1H6MnEpxRQTfWYGuXvDrWJWVlH5o5qAh5pP18TfzjoLlCrkfrYMi68QJ8t0PvIgHVbhzu6VxQNabvV+XN6MDRSwFsflzwvfYpAk+SilvJBIaJe77NISJ2iZEI2bmkkbgu5dgS3DQyMowfFPRs=
X-Gm-Message-State: AOJu0YzGkAUsJtaXJcBx57CbmNwZ2RpXriXSwsyPD3BpA9BtRLkZm4JI
	zHRghBPGJjzprvS4lNZ2voCPOL/qAkDTVenFlD8wlTbeprHxReQ=
X-Google-Smtp-Source: AGHT+IHAU5vY0etGgtJzkwrqVnlIHq+OT7B0xJ8ln/HDYHEfgXRUTbvf8Bsh0WGUNXkLlj/OuFG+Hg==
X-Received: by 2002:a05:600c:a43:b0:412:d68c:8229 with SMTP id c3-20020a05600c0a4300b00412d68c8229mr2670298wmq.39.1711228680572;
        Sat, 23 Mar 2024 14:18:00 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:9d72:900:89e2:b7c1? ([2a02:810b:f40:4600:9d72:900:89e2:b7c1])
        by smtp.gmail.com with ESMTPSA id fm17-20020a05600c0c1100b0041485a9d633sm968604wmb.25.2024.03.23.14.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 14:18:00 -0700 (PDT)
Message-ID: <5bfed075-0228-44d9-84a0-2adba47b86e4@gmail.com>
Date: Sat, 23 Mar 2024 22:17:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: Add rk816 binding
Content-Language: en-US, de-DE
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Chris Zhong <zyw@rock-chips.com>,
 Zhang Qing <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
References: <20240323132757.141861-2-knaerzche@gmail.com>
 <20240323132757.141861-4-knaerzche@gmail.com>
 <368eb339-4f0f-4471-9367-9263caa3fab7@linaro.org>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <368eb339-4f0f-4471-9367-9263caa3fab7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 23.03.24 um 15:32 schrieb Krzysztof Kozlowski:
> On 23/03/2024 14:27, Alex Bee wrote:
>> Add DT binding document for Rockchip's RK816 PMIC
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>
>> +  regulators:
>> +    type: object
>> +    patternProperties:
>> +      '^(boost|dcdc[1-4]|ldo[1-6]|otg-switch)$':
>> +        type: object
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        unevaluatedProperties: false
> This is good.
>
>> +    unevaluatedProperties: false
> I missed it last time, apologies. This (second) unevaluated should be
> "additionalProperties: false" instead.
Alright. Since there are no driver changes required for this change, I'll
give the other maintainers some time to review and fix it alongside in v4.

Alex

> With this fixed:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> Best regards,
> Krzysztof
>

