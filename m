Return-Path: <linux-kernel+bounces-156549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E128B0466
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C501C22F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD2156C78;
	Wed, 24 Apr 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m//bbYq6"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DD158A37
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947567; cv=none; b=JkqcJ9htRFaqK7Jm9d97Ps/dIi8px++BGh1Iiqpr+DnMqJd2B2b7bU4Q3vE/2rR+KiKxRN4korrCbn1vdqbMi19QUtbUp6wsNhlH2E2ZfJ1772+cVlIvRdO9aV2Xkfes2w5nZjCzvqTTW3QSbqdxUNoFIgkb5RL1B1mpZ/vqoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947567; c=relaxed/simple;
	bh=xR9byxaAebG6l/9BPavcQ6ZRngFgOvtD9K7ifUUigYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roVtOBw43CaLpHyCsW0lnWJCA3XZCq7PySqTgbXEtmEQ9pcsXUiRvpNBYyL4j/eVrcCPfxjyTvxj8gTyOU9mTDCQArD/PTz5bJRWG++pqq+7ZuHo4WCIJCMJKUJbp9k0TGIAHaPCi8ZJZI0vgPGajghSmOoRPmDg5M2I1c0gPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m//bbYq6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso28001885e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713947563; x=1714552363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt2/IRWCetn93UD+4EyUBeJAaqUzcCQnHTha+UeKn04=;
        b=m//bbYq6Diu0WN7OinqaLZybjkOW/prP6sqd8ewJxWKdfpMcKyLwOQttkBNoFeManZ
         V/kTTd5bZVZXy2vUbzcheG10bviJ8BmZr0ugy7yX632hlIPjHmfzRI1/RJd6K7Df1y9O
         LTc5ZPYDW9LDtxlOxrrQiKXsgxQC+BbsUbU5N0P2roRbyEHdqyKXASCwDZrvE4z+Yl7T
         1gKQz725APe6lR6uR1NlhV8hdZP70i+F1aeqxz5qCBBlJX/+uUH0TTCfguefNybFTkzo
         x7xegHM2RrtXP7ADCb4E2unBVQ83MfHn2ic6nd3nRc2SWgc6GOp3yUTSc3h26pIGz+k8
         DUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713947563; x=1714552363;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pt2/IRWCetn93UD+4EyUBeJAaqUzcCQnHTha+UeKn04=;
        b=Jy4B6twPgLL7irQHFCQp1TPIMD4b4TFutcWIjbVBLiVOIhqz/C7L3qHydLyb1qYRwC
         TS/1SulrzR4Two2fsQXXtuE7WLXVqFf4sPXi6bnu2wo+K6QbaslhrHuq/J+LRonLOVu/
         Efi8P9mFpHywtxAO8OHKi7f3MJb7vaQuXDLjmrcGxNLj3VPq3rJP7btzIribeePP6fkS
         NOouXA2+zFTprG+Y+Gz3fS8KJzcniafGW5bW432t59nND47uyFKmaL+0tslaqTQ1bcfn
         1OCr7X1G35MY7hAT/QZo2xj7HpPDHHhOB7DctrjH8a5IgeMUiNzdw0YVQZfmuLLfTNl3
         8TJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN4B3UXtuyYg14tGrDfNK3PD5Ryq83zXSP3zC0aioAh30UkjK7C6dgkdK3reUNe7BSc7WdunAptbyWKpXSBCzyBKpIZmU+RwWyF+Tz
X-Gm-Message-State: AOJu0Yxu7ZwLgrurdSrhPyTSbw+rIHuCSuJ8ZYCB+hbi4THK5zy003i7
	JUFVDf0V8CLZVF3v43TOUaUkzi6ejzoukZbnagiapv9fwb0WNLtVzNqdqKwd8Z4=
X-Google-Smtp-Source: AGHT+IFOA4RdfLQcLQOhmj5hYE9KaYxir5zgDAMTptNSxrgYHje90MrprIAfoJoxvY1IFlXyhsi5WA==
X-Received: by 2002:a05:600c:1d11:b0:41a:a81e:441 with SMTP id l17-20020a05600c1d1100b0041aa81e0441mr1652785wms.25.1713947563253;
        Wed, 24 Apr 2024 01:32:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c475100b004162d06768bsm26840103wmo.21.2024.04.24.01.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 01:32:42 -0700 (PDT)
Message-ID: <ca7797c8-c341-479b-bcba-8a41f830c391@linaro.org>
Date: Wed, 24 Apr 2024 10:32:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: HID: i2c-hid: elan: add Elan eKTH5015M
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-3-johan+linaro@kernel.org>
 <1dc47644-56c9-4fdc-80cf-756cf4cea54c@linaro.org>
 <ZiiuxI3GfJQIjxAG@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZiiuxI3GfJQIjxAG@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 09:03, Johan Hovold wrote:
> On Tue, Apr 23, 2024 at 06:24:39PM +0200, Krzysztof Kozlowski wrote:
>> On 23/04/2024 15:46, Johan Hovold wrote:
>  
>>>  properties:
>>>    compatible:
>>> -    items:
>>> -      - const: elan,ekth6915
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - elan,ekth5015m
>>> +          - const: elan,ekth6915
>>> +      - items:
>>
>> Don't re-add the items for this entry. Just const.
> 
> Sure. But note that the example schema uses 'items' like this (e.g. for
> 'compatible' and 'clock-names'):
> 
> 	https://docs.kernel.org/devicetree/bindings/writing-schema.html#annotated-example-schema
> 

Yes, that's the inconsistency we keep. The point is that clocks usually
have just one list, so one "items:". For compatible there can be many
and it leads to less readable code, e.g.:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml?h=v6.9-rc5#n15


Best regards,
Krzysztof


