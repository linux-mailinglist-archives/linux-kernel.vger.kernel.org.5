Return-Path: <linux-kernel+bounces-87065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D486CEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645A6284984
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A838A75818;
	Thu, 29 Feb 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1RbyrHc"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671097580C;
	Thu, 29 Feb 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223599; cv=none; b=RsZTVygOzW9HCDf5acah1JnFFIvVEyFpDXdbHeWomWhyTExuAIQ9X9Ru5Jy9CksXGo9qNPCJ2EZQxf6sKDbKtqF+mcoUcS8npeFEZBZvTm1ADO2aUeu7LjLQg0LBzgcNqKKHriCrJ6dUo+6c0aCi7p4vLE4n41G3XOez+26aDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223599; c=relaxed/simple;
	bh=OYnaEB7igBlvrmSlezUCoGljUmbeasl6fjQmS0Cxzto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dooZKyYkcb7LqnndtvZoC+2tZTruVUUmmUrhuHd1KRj6v4lQASTUIsYi0pCPsIctRNdowRcOS97HvdHkw0mOfdygEvTaLNEnRD4IOFGqa8AS+uUbHZYcjqpPT2Gh2B5E7djwBCVMPCZiXbpZSgmmvCAF/S4rmvZhiKR2ZHgymbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1RbyrHc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so1769385a12.3;
        Thu, 29 Feb 2024 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709223596; x=1709828396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZDaiCfMZbNphQohAhx94MVQqcgltEp5N10EltKHmZ8=;
        b=g1RbyrHci+U6YrDfY72b9W9iCn4CKAb9WkyoiHEWlwVjfDlKaS1TxK0NEMAennh4Ax
         nfEfq/m7Yhx3EcD1pjPd0kuZhc5leQTtZAOwifSbZikNoTgd8SkiyOld7JlBvchDQPFd
         9vJVcujrnU+IgzEi5CFWmcdy1AZ6tWns+Siy4IDrEXVZaXwyUdn/e5i3vEl/DgIQkyM4
         VW8wFc5ZWoLZClJFvqIeeIOpRi2wBxcU8oOGt03F8e85YTTcBrTNRtk1vihp8bDw7nK/
         CNg7lsIZvLyOzpsXExMDjJeeG4cz5syDe6v2957xBcPOopml0WISYxIaKSFn/7ycbxv5
         SCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223596; x=1709828396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZDaiCfMZbNphQohAhx94MVQqcgltEp5N10EltKHmZ8=;
        b=dH7ukR2lFxVjf7N699Hkm6+zT4Jhiq96JVCe71TfdqhPaSb67S6YTSmsgdNKGWVuEm
         urujgXAEq/b5tS1pqTT72TY6bdOf3ESdYtO4L3iIgjx7aeFhCwFVY9uW+oInvCeD/+zb
         8vJmDbhYnpAVcTm3kjyQDJzu7IpNtCMUB4fWwu+QrVSgnXZx2kEWzO/8LSTjLKbeTdjp
         +1tGXOzxZsO+p8o/tL5YfGhXBXf0LhcjLkOwl4jI0M2ZBybOpEuNpUOfTD3DS9e3A6q8
         9OhwswxgUyrViMdgjMQxVJIxaSGiI9GGXVuF04h6uv/6Q/0dNoZtt+N9S9gfLfSz+PVN
         PARA==
X-Forwarded-Encrypted: i=1; AJvYcCVpji8Gg7TYlpKDi/+dWBC0KWWgFtgPeZvysMvGq1k9zC7WIqkIy7ExdrzYCyhVcnMMUO+jHl6/aCXuK6uUMcWE+8BPjGrXGyF5dDaEvsNMJtCFT263sLbB4TrcAS8qXzcaamhIENX3J2yNCDxgT5uKkzJ60LvhcsBeESyGiYE5acQeJA==
X-Gm-Message-State: AOJu0YyEl/bgBhD4qumzoLl8oSiFwPwzfxGZpDguy5gGfNlRcjN25Z6M
	QfXBC+KPUN9GTiJlVzMBPYPQKUbJS+5pQXG+qsa5e2HsSGmT66DL
X-Google-Smtp-Source: AGHT+IEomlkfZUbYwkcNE2XMqbAJ09R6DSu9zehMV6C8LqRFxsQPnda13UABVByHBev/l1yJ5Pt3GA==
X-Received: by 2002:aa7:d6da:0:b0:564:7921:37c3 with SMTP id x26-20020aa7d6da000000b00564792137c3mr1711565edr.19.1709223595484;
        Thu, 29 Feb 2024 08:19:55 -0800 (PST)
Received: from [10.76.84.172] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w20-20020a50fa94000000b005668c6837ecsm730561edr.32.2024.02.29.08.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:19:55 -0800 (PST)
Message-ID: <0f1486de-785a-4c27-a0f9-98dfc94362d5@gmail.com>
Date: Thu, 29 Feb 2024 18:19:53 +0200
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
 <43840914-cb4a-4758-9691-0ebd8fb97681@gmail.com>
 <8ad18b06-7ff1-4463-8ba0-d7a7d54e5b65@linaro.org>
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <8ad18b06-7ff1-4463-8ba0-d7a7d54e5b65@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 18:00, Krzysztof Kozlowski wrote:
> On 29/02/2024 16:08, Ceclan, Dumitru wrote:
>> On 29/02/2024 16:49, Krzysztof Kozlowski wrote:
>>> On 28/02/2024 14:54, Dumitru Ceclan wrote:
>>>> Add support for: AD7172-2, AD7175-8, AD7177-2.
>>>> AD7172-4 does not feature an internal reference, check for external
>>>>  reference presence.
>>
>> ...
>>
>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>>
>>> There is no such file in next-20240229.
>>>
>>
>> It's not yet accepted
>> https://lore.kernel.org/all/20240228110622.25114-1-mitrutzceclan@gmail.com/
> 
> And how can we know this? You must clearly document dependencies.
> 
> This also means the patch cannot be directly applied and cannot be
> tested by toolset.

Understood, sorry.

> 
> Did you test this particular patch?
> 

Yes


