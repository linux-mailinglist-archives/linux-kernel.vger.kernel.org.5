Return-Path: <linux-kernel+bounces-112374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3E4887911
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AD41C20D2E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40568405FB;
	Sat, 23 Mar 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJH0kJGE"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3C3F9CE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711204030; cv=none; b=LTC3wD6IEXNsVH7nDy2vcUN0iodDC6er41dXNFrC/9gfis7dYi0Yz5TPKwEkz92+XRjcUanwLcWNkDDhJRl9lFGHMvvQqE7hSSKKztW657qcgSQpk3u9RQ5JVGBpheoXpKQafMI+HP7XZwyW04evh7Xfkbs35OTJv8R2R2rFcMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711204030; c=relaxed/simple;
	bh=yAu9+EPTHObXFA6DXYHHdnrKv2ZFkpaqVL3c/WYox7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1dZqsvylylqKkIAZO7JhscBDaCl0S+nNuFPKxCBXruFZKNa7VE07e5iz11tU5Ao4poRSkuFuWcBcjSDVCW2oJq+VWrkg2DiXXya1AxJ1FjrVd+UEa9gaht/fJSJt5pvgVMFGS/V9ccwFqIvO5qKRNKGj0JHQl8szMTnXkdKOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bJH0kJGE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46f97b8a1bso394631966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711204027; x=1711808827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+mPyCydP232/a3ZqKo1prnF0wT4mtv+pHJqA+no/89Q=;
        b=bJH0kJGEt5KoR4r0dPG5AMLadzCVi3tfF1SWdmU76osm7o12juZhIWNR37QY7j+++f
         pkB0Ih0BO/zA/8GNJmzOOQDVbQD9VhVFHvBGInhNYBYlUBS62I/iyiqnaUzEy7jlsWn7
         KiIqZVLMs1RLGBoOwKR5YKJtoLFajTUu9ctgd5JKw2nOEMFZGuG0gGbvS45O5Fdh9oD1
         K3a5a8l3QThzBji42ooKU/ofoGO/uGuefO1iGiDSRgsoC/m7bXjlFJoom7r2uXsq+aMk
         DPWazgPTh13m+rHwufJAiezO384btEW5CMHWs7cubx4IeltoZk3Q0Csr2AmeNln1tvP3
         0TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711204027; x=1711808827;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mPyCydP232/a3ZqKo1prnF0wT4mtv+pHJqA+no/89Q=;
        b=fHbFncPddv9+0KjwmChbGQf4wwFqNg+feoZgCNoCr9TAXJsG8KwjZNzsT8FRMkTwRL
         ssJVSfDVNJnZk+tfKgJiouK5wiWYBFp0mQ+ep0tGUYQFyZ2/KdVLg9NMCk6OwyfBtowF
         NnCGEhJBqKmtZb1awHymeNfVUFiqZyMToHGt8hzC6sXUWm44vlht3TQVQSgJ11mex/7n
         1wiPROxq5HtZnuJonMg36tCrfrSRiG0slWeerBs/FkkAs9l/m3A/61wHVQT5PJws/Qmz
         OuiCJjH5H1W2mv2kHsQsolbBKNUt1Ba+w66yO9je+0ZWEyQsYWnTtghTzVReeTi9jpvK
         0BrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmrFh6GrcArgkgrLR9mSnswoLqgJIaxS2iAEj9TRMqugFP5iGx0WLxs7ZQHIZ1rUW8da+UM/JS67CK5triXoUGfcXr+1vlZLTIgnV/
X-Gm-Message-State: AOJu0YxiYfWbtTXsSHPwlQS/EDrF1F/+12ByWcjq54W5YbxYRwBiOAx7
	Po8iX5Mx5u8o8aKOU9QR5X1RQIXwh0nAezLAwMD2chOeVremAwoY4LzC/34WQXQ=
X-Google-Smtp-Source: AGHT+IG8gWF6QmW4BFVAigIDpGdN1RzHG69iv6AmVZQOUgrJ29rPOx7Dx3tg6m/7ZrxrP81vEw971w==
X-Received: by 2002:a17:906:3016:b0:a47:3900:7b2d with SMTP id 22-20020a170906301600b00a4739007b2dmr2163463ejz.6.1711204026997;
        Sat, 23 Mar 2024 07:27:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906180800b00a46be5169f1sm956411eje.181.2024.03.23.07.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 07:27:06 -0700 (PDT)
Message-ID: <60ed3d61-1ece-498f-97a2-7b1c618ceacb@linaro.org>
Date: Sat, 23 Mar 2024 15:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Lothar Rubusch <l.rubusch@gmail.com>, Rob Herring <robh@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
References: <20240322003713.6918-1-l.rubusch@gmail.com>
 <20240322003713.6918-4-l.rubusch@gmail.com>
 <20240322021739.GA3418523-robh@kernel.org>
 <CAFXKEHYrRn+vKZB9eX_RFDLanhqLsRwT1b-wxUdeZTrBrshSzA@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAFXKEHYrRn+vKZB9eX_RFDLanhqLsRwT1b-wxUdeZTrBrshSzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/03/2024 13:04, Lothar Rubusch wrote:
> On Fri, Mar 22, 2024 at 3:17 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Fri, Mar 22, 2024 at 12:37:13AM +0000, Lothar Rubusch wrote:
>>> Provide the optional spi-3wire in the example.
>>
>> That doesn't match the diff as you don't touch the example. But really,
>> this should say why you need spi-3wire.
> 
> I understand. The change does not add anything to the example. which
> is definitely wrong.
> Anyway I'm unsure about this change in particular. I know the spi-3wire
> binding exists and can be implemented. Not all spi devices offer it. Not all
> drivers implement it. My patch set tries to implement spi-3wire for the
> particular accelerometer.
> Do I need to add something here to dt-bindings documentation of the
> adxl345? Or, as an optional spi feature, is it covered anyway by
> documentation of optional spi bindings? So, should I refrase this particular
> patch or may I drop it entirely? Could you please clarify.

Whether you need to change bindings or not, dtbs_check will tell you.
Just run dtbs_check on your DTS.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

AFAIR, spi-3wire requires being explicitly mentioned in the device bindings.


Best regards,
Krzysztof


