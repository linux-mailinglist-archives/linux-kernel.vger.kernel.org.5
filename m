Return-Path: <linux-kernel+bounces-47742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B123984523E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42C91C24C87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45C515959B;
	Thu,  1 Feb 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFDA/0gi"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05A1586FB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773940; cv=none; b=h8LYqlv1eQ6Rr5bENLVJoGIbZZdTGnBMrEdpqbwioavEDB0SUXvp16Q+fIYN5AXmI1zeJwAR78ZG2Nf7qVaDtRYFuKXMzrJcDsBKj/i+wmwGFpMV+PlEp1brN7EKyZ9NWTRNEA98LCOb44PeBW4sr0laAt3uP/RIxax3U+BrIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773940; c=relaxed/simple;
	bh=YTaHQlTBHQOHwhY5YplZoM9YSUIMQ8fq0DUhbgTJbXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQ9aj6+jsMobUuzkHc1jonqj/IzwToFturTFhr+uqhIBWrx/HqsEFI/LyAE/SoPcVk5t8QJNVG1uNckirhf/E11JLtd/6c6o05ZOq96mvuYuOk/CXIL9My6+htreBWLxD8ffSX+h/kYOANx+IEdjDmP4dDopZLL+SMv5LNWzBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFDA/0gi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3122b70439so71712066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706773936; x=1707378736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+yW4466Fwq+cPFvacTC0lLupL3F38F7nvhDsV2cdxk=;
        b=YFDA/0gi68oGHgYuXXKrVCEC5qaMtHuiI8+M0PfoIRI4VU4qufEZAuN0CN92FVuWe6
         bnEQmIQfRoUc5VL0jKGevJ0lPOTs931hBtyuNOEHfhIoJG8d3M4zZgupbkIRPFQnb3md
         l5b/myqemiZBevA8BI+g2C22O0rgTRXhskXXwoswI+1tuV8Ia+WlGcbEZ00Ku3Pyd2zr
         EbymvLQuC2fNyiW0xYbkZQNcfsBUHAEg1TZ3sDdyqzH1JYLVMbv/nOm5fV3rbwd1lVky
         lgGORNT1YPsFFp0UjPH9/zIycT7kAq9CGogTUS4J0R8MzcFV4HEHVFVN6aLs9jYQmtJ9
         OkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706773936; x=1707378736;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+yW4466Fwq+cPFvacTC0lLupL3F38F7nvhDsV2cdxk=;
        b=WxkEZFHYbmmHbLsYK0AYn1t+dHwH+0LoXbDxN1hGZs0HVWTFO1lmCzg8GiOu1KkoMa
         4OAs5f7/gwVJLc5rJkmHG4yDQieeF9uZToQ7vqtmqCptGwRNNHbK+/vtvB5lc1dDoYjN
         L8mO1ZKMWxqKFsp8mJ8rRWhea27hqylskHkJdAQUWqM7FgWChwIShDlBo2twQBD405lQ
         mnsgncjM6GcDC7aq43kkXND2l3Cxt564Auk0kqaFIecXNccC/E8jEU2T58hxEjtV8ynP
         01KpoVV1BT2m/NAmAkoSb3p43/UujdcLe4yfXo68z5F2AkFOQnHkoa3Y3MXRKJl12KOp
         fxaw==
X-Gm-Message-State: AOJu0YwyiY9K5/lMeqTzm8dpDNJoesHdsgCv+ocXWtI/x2S/FN2jaDZT
	1kj4mWozYS+k8d02NVokYxxl7BWuztLaj22vzRAgwZMwL1cGVUpRM17ki2yUhDs=
X-Google-Smtp-Source: AGHT+IFbWTR86WqUgqwatj4MXgXcuJ0sNgzrXhgTaUI2W5j1uDLlG/GaAl7yVm94rcPn4ZjjCUV7gA==
X-Received: by 2002:a17:906:1d10:b0:a34:aa8b:6cb2 with SMTP id n16-20020a1709061d1000b00a34aa8b6cb2mr2477368ejh.18.1706773936366;
        Wed, 31 Jan 2024 23:52:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVQy1bOAdmsmWU5/v5/sR/B6Pvc3+se5GKIMb9aecPV5ldLWJGgEJHXG8cvptp/XsBWzDcyeNX0YyYZ/tokm9HtUi/1pwgxTioEfHuPHTlSYzowawsjgNIggCrSciTamYKGVCgiNKNAm/VMxjY6Ccl9M29wmpBrB68h/YVNEMogkJS1imqM+ftRC/IuX7sLYhKBJ9X2T6H1JbUaKK/TWXfT9sWT8Ft0fGn4/l60GmPQfcpVgcARrlyyHQLT7ZbGfXey0dkXn0HhtACmXBFQGS17OMN4YOmr7PPdWrnjUv0A2cwfB/0q1+Ks/7HJOmd9m2KSiu7PhTUuFuGjAdpN116YUOXE/jHfGVHkbOlxCUViEbn4
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b00a3667f53691sm1517095ejc.86.2024.01.31.23.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 23:52:15 -0800 (PST)
Message-ID: <c67ebf90-cb40-4595-8015-45d2a86f6c7d@linaro.org>
Date: Thu, 1 Feb 2024 08:52:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: Add MPQ8785 voltage regulator device
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Charles Hsu <ythsu0511@gmail.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
 Delphine_CC_Chiu@wiwynn.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240131055526.2700452-1-ythsu0511@gmail.com>
 <20240131055526.2700452-2-ythsu0511@gmail.com>
 <20240131-eraser-given-8381a44f41a4@spud>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131-eraser-given-8381a44f41a4@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 16:41, Conor Dooley wrote:
> On Wed, Jan 31, 2024 at 01:55:26PM +0800, Charles Hsu wrote:
>> Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.
>>
>> Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 79dcd92c4a43..088b23ed2ae6 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -129,6 +129,8 @@ properties:
>>            - mps,mp2975
>>              # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
>>            - mps,mp5990
>> +            # Monolithic Power Systems Inc. synchronous step-down converter mpq8785
>> +          - mps,mpq8785
> 
> q sorts before 2, otherwise
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

I will sort the file and my patch should go via Rob's tree, I guess, so
maybe this one could go as well?

Best regards,
Krzysztof


