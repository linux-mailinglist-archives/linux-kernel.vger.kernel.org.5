Return-Path: <linux-kernel+bounces-118050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC5088B2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBEF1C3FD92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E316EB74;
	Mon, 25 Mar 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPCav6rn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36AB6EB52
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402821; cv=none; b=A2JfhR8WRwNwcT8K18Va9NjVUh4Wum4PxH/ke/dL2TAEmL/xdDtIR/chdz0UtA0e6c9d5aAEYemVWNXtRJfTRHDNTxqG1BNUwECp7qQxld0THFbA7/qZxP3PT2mWpeC90fS7ujY5Bp5h4p9C+cTZJbHp7YGDeqDPco3c4HO0VAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402821; c=relaxed/simple;
	bh=33fbIsdcLQosWi1ubicv/V4geBOu/bFkYtjafQ1Ixnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gaZjEshJi59rQUbWKL1tZyJ+//G1nJankvwDkQ0UCsi8GReLL3Bpo8Puj6Im19ItlQukvLaQuySYkwpT0LLzbp63frPi7cUq+zFcX4tAcGDGzGqm/Wsnmw4byC4bOwuwVFZ0AWZQ6I4wa4C0wBMX/f29J2wzjNEs8TQiNyo+k8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPCav6rn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c29599e0cso54513a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711402817; x=1712007617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=seRw9WiSo73vDIqUe40efu3pj+vdrtDU2N7PEbfhGxY=;
        b=zPCav6rnFLlZOkUWHDQG6deNsRWSieJLaog5Aaa0xS106PGdYk0Gcev6qpAK/+/TWu
         dN3nucuMNIeq3nujv1jowJDcmj7hs6ENC3mAu2GsVIqq8yO9dxNWQKrrmGPkgLyUNBM0
         6sB5Pr0spUIBOWMFgexfMxefKDkTqMKkByr8pwN5SnpVvhjPAyOiZDkuoU5RQsYHISUj
         xdNs1+0ZuQCQf/Wc1tYMWW5CTygJ0c1YQbIScpr2d7z9On+x5RtWGqreePktyUxD+zs9
         834UOrscYO46GDwmeTy0gROPLA5AItW2307BgC4IWl+HCwFJ+GGvJsSpUqPohkBJcfcq
         uYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711402817; x=1712007617;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seRw9WiSo73vDIqUe40efu3pj+vdrtDU2N7PEbfhGxY=;
        b=Oz2ppoi24CNeyjqvDxfoUnSM6tABCDYzSF4KpY/bMbgMC3EumUtSVqV1sTqrYRzO85
         VWUpF4jY7Fg7OVin16K6EGGPomCdLke+bQ26hzaKIb1RzSa6ZimZf0t9HM0CMwUMyQpk
         7k/MguLLkPv/YZlZvLQypRCjmTjd8teNxLCvy2KUWdTBWov6zJYaHT7Nwr3xXfDsersG
         VN1eb/+Bq/wuAl/11H7IwVoA4cDmVPrWM31MFmpvvvOjqT+hYyVyZg9Op3VBZUcxRnCh
         ME5oXqupd+Zjc7GIm4WTXevQks22YtJUmsfAaLB5EJVor7dSKX0vGW3ORtgByLNfkVov
         Iqhw==
X-Forwarded-Encrypted: i=1; AJvYcCW2dWq1R7K4nrg4IgGkGWZKjfwbA22Ep3jYrd7SeAAPHWgYnUWA1hH6fti33XqDbBmzkEOKI2bC4/xt3iTFopCMU5nb/R28cdFDYLNG
X-Gm-Message-State: AOJu0YzJjDHN8f7bEy+D64uorJrhHUGErA+wgvYbUMFl7rjcWTLCj3pQ
	Dg5UN9wBZErVXMT9gL027EUHVW/KsccSsLcxrUlFcorI1VOLK4S1iyiKA4UENLM=
X-Google-Smtp-Source: AGHT+IHwLO9w749fEByAg3+La2+o7ssyCNIapqWz1kGPyb3+zR8woUtBsPDN94mbgvo/zynwS+VvSg==
X-Received: by 2002:a50:8e50:0:b0:56b:c210:870c with SMTP id 16-20020a508e50000000b0056bc210870cmr634013edx.15.1711402817136;
        Mon, 25 Mar 2024 14:40:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id ck5-20020a0564021c0500b0056c1bf78a3asm752460edb.28.2024.03.25.14.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:40:16 -0700 (PDT)
Message-ID: <334970e7-2edd-43c8-9f18-b7b3ec5f4d17@linaro.org>
Date: Mon, 25 Mar 2024 22:40:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
References: <20240325153356.46112-1-l.rubusch@gmail.com>
 <20240325153356.46112-5-l.rubusch@gmail.com>
 <f74a01bd-46a3-46cd-a47a-fcfccd7e4dc6@linaro.org>
 <CAFXKEHbJ_5unY24aZeutvM-xrjevQ=z7ngDcgwJR=NXzXONx5A@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFXKEHbJ_5unY24aZeutvM-xrjevQ=z7ngDcgwJR=NXzXONx5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/03/2024 22:05, Lothar Rubusch wrote:
> On Mon, Mar 25, 2024 at 7:32 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 25/03/2024 16:33, Lothar Rubusch wrote:
>>> Add spi-3wire because the driver optionally supports spi-3wire.
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
>>
>> Thank you.
>>
> 
> You refer yourself to the above mentioned wording. Would replacing
> "driver" by "device" in the dt-bindings patch comment be sufficient?
> Did I miss something else?

Yes, the wording, but isn't the device require 3-wire mode? Don't just
replace one word with another, but write the proper rationale for your
hardware.

> 
>>>
>>> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>>> ---
>>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions, under or above your Signed-off-by tag. Tag is "received", when
>> provided in a message replied to you on the mailing list. Tools like b4
>> can help here. However, there's no need to repost patches *only* to add
> 
> Just for confirmation: when I receive a feedback, requesting a change.
> And, I accept the change request. This means, I received a tag
> "Reviewed-by" which I have to mention in the upcoming patch version
> where this change is implemented and in that particular patch?

Please go through the docs. Yes, you received a tag which should be
included with the change.

Reviewer's feedback should not be ignored.


> 
>> the tags. The upstream maintainer will do that for tags received on the
>> version they apply.
>>
> 
> I'm pretty sure we will still see further iterations. So, I apply the
> tags in the next version, already scheduled. Ok?
> 
>> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>>
> 
> Going over the books I feel it does not make sense to still mention
> feedback ("Reveiewed-by") for the v1 or v2 of the patch here in a v5,
> does it? Your link mentiones "However if the patch has changed

I don't understand. When did you receive the tag? v3, right? So what do
you mean by v1 and v2?


Best regards,
Krzysztof


