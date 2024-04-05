Return-Path: <linux-kernel+bounces-132510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F989960D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BD01F24D26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4497286BF;
	Fri,  5 Apr 2024 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhFLgZ/a"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA41C6A3;
	Fri,  5 Apr 2024 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300314; cv=none; b=McNU13L9Lr1NnOK1odnMkJS4dBhyYQKyifg+yEU/RqHvShXKZaFq5TUY+hU/yLerdrIHUfp74j1okuT0+NyrwSZOvFtAss4hpOItKf2cOS7/nbhws4TZIu6eSUIljLkIPB7eUIpZ7gvBZWicI7VYOLJ6FHCdrjOi0YBRRW7dOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300314; c=relaxed/simple;
	bh=Ci3ViTUUSQsXGpkF9gl5pwLXXaRw6buk8XOSpLUSyRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKsvujCsGR+96kviekhMvPMK+0GCTtPA/7rJ+uwSY6XYPmHwOUPIfwEGgld7NRP7/tA9JkFHgMLtT0c7n+xw8k2AXhcuEIJfZWtSO+9IdC7xsQU4zdp6tC41xfIJmPDJHeuQXQ1dgIGM/vzASRTDFd1G204KLcB1r519lbWr52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhFLgZ/a; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d47ce662so512324e87.1;
        Thu, 04 Apr 2024 23:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712300310; x=1712905110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAni26bugJCEh2BOclG+9LIKezQhToDUaeEnG0UC/qY=;
        b=mhFLgZ/auk6l9JTFo5rxqISvdt43Ngre7wI/4cld1LSkP78hb7Zftz6/S+g48uFWqW
         /mAdy2tH8BYSVx+nOw+ZRAqbOFLIf5h5hQ7kZ0v/sHEpuMoWXG3+Zybu543tROswyLBD
         PBURbpO93U9q6oBOwSrOnJO6ucs9eQAEx3tgIJjPKBqO7zxEP5d1aPzVsn9LFQgIwM5h
         vBw7XcgDbKZg97a8JWXbH7RUsIhLoTUeaFkzvCZUGz+E30MJuwR4V1XSIWbZBibPhBwE
         EzSEaBHoVL3AApx/FBncVdQwl0cgn8jQwNGWRYcjvZQxsRIWlqy6OVWnQ2UnLJcCIgCD
         qaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300310; x=1712905110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAni26bugJCEh2BOclG+9LIKezQhToDUaeEnG0UC/qY=;
        b=JlZpSQHpOattNSprBaze0lnPOHFDXswGA56lo+zHrRxSQsItOh+mtJmY2pyAIR7OYS
         P/tvhOJMqHwxJhXqMVu9+L3nOiBC6XleQumcsjdW+JL6yKPzSnAgmGxuohG1xxKBpFEE
         bzSGeH1vPuyJn8Z5jyI0GE8SsrDow+j0uFDhp2i5bNtlBB2p836yGgjBEjmDuzql7eMN
         k44RAguwaLPaziAt6ReLMW+4lqcMvJ53snYF9VEghlDKaPIZ0jPNxzaOfA6284Mc096+
         eDRsXMiysofikh0anUIpXOLQDmzRkgQvXIVU/WQDOyMuBcI9umlgE5mD0UYpwtMe8kd+
         k9kg==
X-Forwarded-Encrypted: i=1; AJvYcCXGBwRA8E0AKU2pWudPrLTYLyUVQKge4f+hLwM/Ij8JFCUsVmjyCDA2zoh/cn9X4ixroXFGi1B47P8eov/DNglIHE/OWDaIry74vagFZLm39lu0yt8ryrQlol3gmHB2bHp8d/VfMMEKIw==
X-Gm-Message-State: AOJu0YxyaDK6VoTY42qoc0PUxbIxwfcA55bV5hzw6tDTx+lyVw3fiQaC
	HR9kkV2hZqXUjsu2HNQuw3xMhy1zK93J0wPZLPJTLaz+CDjPwLxy
X-Google-Smtp-Source: AGHT+IEucLNAR732bCaXuwwIFFRMVMSuRXN7EX/QHEBPktDIQ3c/PD0S0nh3uqd/LBODBzDNROh8tg==
X-Received: by 2002:ac2:5b1b:0:b0:515:a9d5:aab6 with SMTP id v27-20020ac25b1b000000b00515a9d5aab6mr501555lfn.18.1712300309851;
        Thu, 04 Apr 2024 23:58:29 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id s17-20020a195e11000000b00516cef1f1casm112265lfb.181.2024.04.04.23.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 23:58:29 -0700 (PDT)
Message-ID: <63672231-0db2-435b-a638-aeda574c4745@gmail.com>
Date: Fri, 5 Apr 2024 09:58:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ROHM BD71879
Content-Language: en-US, en-GB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402193515.513713-1-andreas@kemnade.info>
 <20240402193515.513713-2-andreas@kemnade.info>
 <6420ac43-f200-459c-8c38-7cd55c64a155@linaro.org>
 <20240404123010.69454fda@aktux>
 <8f37211a-57ed-48ab-8de8-cd5a0d4c6609@linaro.org>
 <0295c8db-b01e-45e7-b44e-79d36d81cd48@gmail.com>
 <35a9399e-819a-400c-b321-099f8bc9df90@linaro.org>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <35a9399e-819a-400c-b321-099f8bc9df90@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 09:35, Krzysztof Kozlowski wrote:
> On 05/04/2024 08:01, Matti Vaittinen wrote:
>> On 4/4/24 15:04, Krzysztof Kozlowski wrote:
>>> On 04/04/2024 12:30, Andreas Kemnade wrote:
>>>> On Thu, 4 Apr 2024 08:59:54 +0200
>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>>> On 02/04/2024 21:35, Andreas Kemnade wrote:
>>>>>> As this chip was seen in several devices in the wild, add it.
>>>>>>
>>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>>>> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>> ---
>>>>>>    Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 4 +++-
>>>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>>>> index 0b62f854bf6b..e4df09e8961c 100644
>>>>>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
>>>>>> @@ -17,7 +17,9 @@ description: |
>>>>>>    

..

  Compatibility means that software can use fallback
> compatible as matching mechanism and everything will work fine or with
> reduced set of features, but still working.

Thanks to both of you Andreas and Krzysztof!

Then I'm fine with this.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


