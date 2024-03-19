Return-Path: <linux-kernel+bounces-107132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D74787F7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045F31F21D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61351C36;
	Tue, 19 Mar 2024 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSq7LqoK"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395550A83;
	Tue, 19 Mar 2024 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831674; cv=none; b=X8HnsDmZ3k5YJkLG5dpGP56kCAAN2JaIk0lvBGpX6dbsw7kMLMZ8Qt2rxUoCXMV7ukwRO3SVCtTq1rfL0SXHDBRZl7AS554QVavcAO3anQEhroQ7mvSJ+c0G5Opu9jZySYjXypwD+RGCcbqsGhN0KICwFeSBR6xr2oIJemizjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831674; c=relaxed/simple;
	bh=sN8BoodaqauJ68zryAbxJ0C8GsgzpHYXpPUW40HgJlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cb5HCzegGET22O9+RSZ4+Dd5txi1uxCXypT+VyVGR0sLdkvY4lHHgReIVGS0t39SbWQqE/7ppALn06Qqa8+RYAWhvmsQIS1o3AFEWbF+VkrtBtpEtyClyi1S4TVOUW8jyBDTdmYsNsSPwHb6CIIbO+FB5w0EnJh4S7CCi1Wb7qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSq7LqoK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56a0c0a7ebcso2209048a12.1;
        Tue, 19 Mar 2024 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710831671; x=1711436471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZOnTWy9RHjbWwjvoVyhSRxJR11wBBKA3nUrGVF4HNc=;
        b=TSq7LqoKz8S+0nIoDUCJANyMGPxc+k3aoKoW9x3Pye1D5OvMkQpTjrFR6/maWxOa2U
         zLEQxyU/wc7srCRAKpfQ085oEqStW72lgs+F63eaumwNHrCMuP3xESQpbfarcgKPBW8C
         gY8EzjIGcVZTQ3NW6oAnxqdYlLjLn6sjgib6Fm6Fdna6w5sAXoBBA1fa3DiNgna9uywy
         05B2UsUQ5c9zV8bVlObaXmMfLxH0URTAniqoOUGPV++/ntDJyhDPC4bvsm6TCS+AqjHL
         0m1O2tDjhXbeGm4Ip90CYqiHcsO3qQ5CwP6mFd/utYZ3FItpHc3Ajj/zflMuli26Vj1g
         P4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831671; x=1711436471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZOnTWy9RHjbWwjvoVyhSRxJR11wBBKA3nUrGVF4HNc=;
        b=c7p16q2+RA5x4IB58GCG6p23ncr1q03/spwechMbmlHJihEPX1zED/zMzZET2Vf3J8
         qk+nn2s6B3PMC81I86yzcMm4hqCqjceZIfohhZDRllxsjoPnArP22uA5+q/0zKIp0/Z0
         aQNQGlzvM/F+72ptWNIV1sxc1QvrdXpfIdU03LMYib2H0tVrmcjflApGFIqEVwgXf3gk
         vciCROP5aHUF2Y/3F0oV03hri/WMbRaOvgvVwS/ckfvR5/P4AVNd7pPvZiC94QofWc0y
         KWTGgpZv3+3g+BhjCNQfEkGmmpbA8dcXUJBNo9woanunQeIflsn2UTYeH+EIyBbfQZLU
         fPeg==
X-Forwarded-Encrypted: i=1; AJvYcCVrk8W3PGvmZ9f2pux3TBoJ4IbwcdnZI1Vi2jiggMli5O7bIdis3Bs1XW2vAtCiisA8BzuBb00mWFiijWvAvt3/KivtDO/SRAPSeNskxk3OYqAwj1OTl/8ef59RLEJgU+I9xsb1qMy8qQ==
X-Gm-Message-State: AOJu0Yy1bks/g9NkaK3MsrwZiI1cyCJOjAn7PWc4Y0HlkArbyHAPUU8H
	vrdH/2m4BDPH17bLBiG0nC2ZdoT05fzSVe4WvTuuBBDcJ75BA2Cn
X-Google-Smtp-Source: AGHT+IEKjUdvOW2dgHw0zuQMmiemMW5SAp18zSrs0INd37VhbEvkMXBKDvubgQjvdJa4FYRTfYe88g==
X-Received: by 2002:a17:907:c283:b0:a45:84e7:b265 with SMTP id tk3-20020a170907c28300b00a4584e7b265mr12235982ejc.7.1710831669473;
        Tue, 19 Mar 2024 00:01:09 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:5922:bab2:b36:7e61? (2a02-8389-41cf-e200-5922-bab2-0b36-7e61.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:5922:bab2:b36:7e61])
        by smtp.gmail.com with ESMTPSA id jx25-20020a170907761900b00a4661f0f1e7sm5682269ejc.205.2024.03.19.00.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 00:01:08 -0700 (PDT)
Message-ID: <beddae56-caef-4684-958b-d11ca0808055@gmail.com>
Date: Tue, 19 Mar 2024 08:01:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: hwmon: adc128d818: convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240318-adc128d818_dtschema-v1-1-d0af2caef145@gmail.com>
 <de0b32b3-348a-4d42-89cd-df2c439b8009@linaro.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <de0b32b3-348a-4d42-89cd-df2c439b8009@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 06:49, Krzysztof Kozlowski wrote:
> On 18/03/2024 21:12, Javier Carrasco wrote:
>> Convert adc128d818 bindings to dtschema to support validation.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
>> +$id: http://devicetree.org/schemas/hwmon/ti,adc128d818.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments ADC128D818 ADC System Monitor With Temperature Sensor
>> +
>> +maintainers:
>> +  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> +
>> +description: |
>> +  The ADC128D818 is a 12-Bit, 8-Channel Analog to Digital Converter (ADC)
>> +  with a temperature sensor and an I2C interface.
>> +
>> +  Datasheets:
>> +    https://www.ti.com/product/ADC128D818
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,adc128d818
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  ti,mode:
> 
> You need | to preserve the formatting.
> 

Thanks, I overlooked that. If I am not mistaken, 2 are still missing 
(ti,mode and vref-supply descriptions).

By the way, do you know why dtschema does not complain about that? If I 
place a '|' in a wrong place, it does complain, though.

> With this:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Best regards,
Javier Carrasco

