Return-Path: <linux-kernel+bounces-86895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88FB86CC65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709291F23071
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD611386C9;
	Thu, 29 Feb 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGyMcpmD"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4167D07B;
	Thu, 29 Feb 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219327; cv=none; b=UYBAp3DpxwJYKWnNQJ0pKAk+Hdt8BpLh6vq+6gCfKhaS+FRzmegdGJztJcssXZ9E1r1+gfG/zRbMAqlOpIhk0T5kXMwesTY7AS/pqH5TaLlIvRlCUdLxKLJ2jRjlRgmqJGWXk+2/JzMP0f14Ad6B0HfJF0rBIuBi/ytmNtXn+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219327; c=relaxed/simple;
	bh=V1/mVULec3D2TuKr6FwSt3WXTRYRxDLupbI2ynb8Dkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKfTCbIIcuSv6c6Yxj/W952S0xcfPSiJgTce4xYEOglerWyJ3CNvZq9MJJN67cZ01/nPCJPUDmgxF8m9oqJy04SI6m5phOE4Vrl6Cx/idF8f1R4yKSxZ6bl4z1YcJHUEufkRmCLIr/udk2lo4XdqOTnkzwKXE7ump7/Tvywhn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGyMcpmD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6900f479e3cso9066216d6.0;
        Thu, 29 Feb 2024 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709219324; x=1709824124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3Ojycqfi/juYUEyhNIkICtIQx3xZlmKoWCEZ50D4iM=;
        b=gGyMcpmDUcy0OMvlTAyoihKrew7iPCM7U2K/f1phePFOVPyfCbcyIVKw3fr9AyCN5I
         AX12XXpl6RKAcU0eih7XPX6pHTwcwxpHMO+Z2j2u8bD8GXV4dm2ICn7iYie4EkTclbEj
         30cNpd0ozVd76rT+c3sCBGQuTJawRVWDDhK8I3DgqKUc7FHjHxThGd8ZWx3NcLEaYouK
         HPYxfSNzByPpxU6QXo1Vl8f/dnkdeJ8JcYpR9gF7aRh0gucqrCCaqTLroSmgRu5wrZpM
         DJj5kQorgBz+gAwLotCmqCe2b7NRZPGk5k2hSZUJ9pOJ7JZzVuHnkATTY2/5ZRJRjPIN
         MXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219324; x=1709824124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3Ojycqfi/juYUEyhNIkICtIQx3xZlmKoWCEZ50D4iM=;
        b=rJQFNzProa18oxkPOOcnu4ngche7kop5cMcyjoSGnh0qxkQmDUZPrpPwOKgFDHJFJf
         Cc+E9SzfIWGgohTLwM/yqSNYKn9CNkuHkyNrmz9re1kEyk/+rbqOD1GwIQBtXGCfBnjo
         OMeBXhaEIw0IZSKAJLI8Oe22MhAxNvUzHaMMZ7V700iGTc7shwPJKAffTP+N05yME/8k
         n0iZ/YqAcUhirCWqnHX16+LTtB9fLrMUfMcL9Ozmm4kO+PoS31Jdi8vfjPX6TRqxS8s2
         rnWafbnZq86zYfAKlOncAYd1E8XpoXj3qpu7YQJ6Nakbwv05xakTIgFjqz5eYYJdEP2f
         u30Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYEG0nQAE14iym8qjWb/9FY/kypVSBAsgLHO4iCwlu4uQJXIF02Fx2C6I9JpfHF/yWSccykbA87YnZX273SO09QJGamYS+VpDsZjiSY46cpw9cRygjul3jisjy/joFKVh127msCGQTgtPBcBC0/hIP0RnjYaMaVnAo2aAPVLMlGJt33w==
X-Gm-Message-State: AOJu0YxNbSf943IQIiwYJqYO64M2y9AJrHfWYVusu1dnyndWWXyjp8CR
	4TDTGbQVcmnJTxGFpvcoZxV9AAcnC5pIbxnOi4U9TcNi5ZBNCe3H
X-Google-Smtp-Source: AGHT+IGn0CwDlu22gvGSQQr+QUiovh1K7yL0y1Vz6ZELZ5jswvLl41ZKQZSSqUBVlCKL6G7OFppzow==
X-Received: by 2002:a0c:e34c:0:b0:68f:b9c0:9bcf with SMTP id a12-20020a0ce34c000000b0068fb9c09bcfmr2784872qvm.50.1709219324412;
        Thu, 29 Feb 2024 07:08:44 -0800 (PST)
Received: from [10.76.84.172] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id bt4-20020ad455c4000000b0069051255b1bsm111981qvb.77.2024.02.29.07.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:08:44 -0800 (PST)
Message-ID: <43840914-cb4a-4758-9691-0ebd8fb97681@gmail.com>
Date: Thu, 29 Feb 2024 17:08:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: ad7173: add support for
 additional models
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240228135532.30761-1-mitrutzceclan@gmail.com>
 <20240228135532.30761-2-mitrutzceclan@gmail.com>
 <9f3e461a-0b79-470f-b599-bba45cda006a@linaro.org>
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <9f3e461a-0b79-470f-b599-bba45cda006a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 16:49, Krzysztof Kozlowski wrote:
> On 28/02/2024 14:54, Dumitru Ceclan wrote:
>> Add support for: AD7172-2, AD7175-8, AD7177-2.
>> AD7172-4 does not feature an internal reference, check for external
>>  reference presence.

..

>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> 
> There is no such file in next-20240229.
> 

It's not yet accepted
https://lore.kernel.org/all/20240228110622.25114-1-mitrutzceclan@gmail.com/

..

>> +  # Model ad7172-4 does not support internal reference
>> +  #  mandatory to have an external reference
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: adi,ad7172-4
>> +    then:
>> +      patternProperties:
>> +        "^channel@[0-9a-f]$":
>> +          properties:
>> +            adi,reference-select:
>> +              enum:
>> +                - vref
>> +                - vref2
>> +                - avdd
>> +          required:
>> +            - adi,reference-select
> 
> Are you defining properties here? I cannot verify because this file does
> not exist in next.
> 

No, just constraining reference-select to be required and exclude
"refout-avss".

> 
> 
> Best regards,
> Krzysztof
> 


