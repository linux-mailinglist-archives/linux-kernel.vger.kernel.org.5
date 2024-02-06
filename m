Return-Path: <linux-kernel+bounces-55292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35C584BA5A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEF6290298
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2732134CD3;
	Tue,  6 Feb 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbaDcj+u"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468B134CC6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235144; cv=none; b=knAc2ZBkBeWlVYa1z87q7T+TvEc7mLThuGKMZaFC/gdb+XAwI/fr3AfO20O6lXEhicuCEBddEHyxgEnC38CX4ML+HIv4y5yhdJ2zSsgiaojHXG4OSM6LuzHNfMF0QPKrDCeCgT9KDuXw+avOz+1w0mEFzZ5B3BUJZbxiuXnOYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235144; c=relaxed/simple;
	bh=W7TmEfcaAf7mUi0lhLSIcqMS4NfyIbKKmEINiMsU3L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XywzQLY6TE+AVrdOAwcRwUDi47l59gpOXawngekeUGVau2NhPmAedSqxn7T1zB+6y/3BhTNBH+SB5mvPvkhlbwJSD0eTnr7CuE0sm7geBWnLrWdOl+uiqhbQMteHopa10mOSLBVnlKq2N9ICpFr2isPU5ePyzECd0lBp/f8X+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YbaDcj+u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ff0799f56so2938265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707235140; x=1707839940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3y4riJtVXabIcvTGIs4XKxzmt10nNZgAnUCqo2bAP2s=;
        b=YbaDcj+uvExKnZG99RWiyfPFrC+IiTs61z2qVQqw2IajYATed6Po8Vn1laTeosyH4F
         2Ep6WPg34eTONJNK0Mz5Mr4WAgE8LTat/cUa3mJreiVCoMK7/k4OQ3CjC7PU6lSSycE3
         fw5GvBnCMD3hYFVoa5Uw/tEz2oPUJWyrvYc55Xsu9aVsdkX6CJ0J0OCiIAE77GuKDyP5
         G1UPokgyH44OuNXmi8R0kmiBpOdeU4BuvRaa1deU8jtCQA876mwubG7LnBbtxHcqYy67
         ITVTzp1hBLMcNFZ0Ca+nKB8P4vWFlcq6H3TFEUPYnQgNlbWLSM3mzZ3u3IZpMbKXEoz5
         7Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235140; x=1707839940;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y4riJtVXabIcvTGIs4XKxzmt10nNZgAnUCqo2bAP2s=;
        b=noXhWjeuiI0KKEiBy4S2WZVIxHOHxv5APSy/VcrZLQ7Ho4YGhz/qBViPkqgfB/tx+M
         rxyjEVkypwlNxUscPjV3CMXA359w/ztBx+GowOdByNFwX4TdRpiJC1GRmekC6cnosi3m
         pBpVrMo9ehQUjwwQ4BY62/8oYV62ANqeE0n6ir8CwxtvpKyQ+dvfc9wfODiP0DkBEyot
         WI3Dh7SyuHGJgL2Fc863LJ8TglDXz+o6sHLrhQQ+VgksdGxqkDg/OZVh1ZV+qQj0Eib4
         S2EWmH9bW551UFzut0vOQ8b+IQVIw9jjYtVUSlq0eJbWHm/PvYOSpjZ65zImZDpsjbSY
         mZOg==
X-Gm-Message-State: AOJu0YxYA8RBW1oU1xtDk/ipbJZQ0hRQZNgd78fNTP0ShWZCk44dL0dg
	CvIoVIUnUe1XFwo2oyRY5PwWGX27fwyWwnJD/tZObAo4Ar7t8UqEQnTz4EhY3AY=
X-Google-Smtp-Source: AGHT+IGYpvG9SYHBtz+sIPBATT5vxM+oBOaSdvTDEPpYc56rOp8wIP2kIJGB4MgJyotf8C4I7pIF0A==
X-Received: by 2002:a05:600c:1c08:b0:40f:ba0c:4e83 with SMTP id j8-20020a05600c1c0800b0040fba0c4e83mr2341814wms.19.1707235140269;
        Tue, 06 Feb 2024 07:59:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBcsgVm8J2PV8LJQWrI8s/S6SP7/Yb0eSzRKIfGGd+EEj729qchCG3bRmHmyKbF1JUBfxi0np8NlUdzHj5H5Xi1y3qWCdCuNszZzZas5P03RPhiPZ4YaXXEYCtUKBFo9bI9wY72oHJID0PelT+EWSplOv2T++f/5jik341wRLzshLBBtvQCMW+ZNR5RBeyzwoqgKymadI0fLFLovINx8GxXMfJ693B+lfjeiSbl4FFGdPQoxqO21jRTOlwT4gmjWU61CCkfcSGErpd6KXbqB5PW2ylA4a3o1lmjau2RAYJFKOv0Xs6uW6E9M0lTPzV9taResKyesgAj4KYyzUbIE7b6bZBzpT9CpwJhak9fesF2U3xaZ9pqWBKFLoh
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b0040fdc645beesm2437231wmq.20.2024.02.06.07.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 07:58:59 -0800 (PST)
Message-ID: <8d4cf7f7-0ee0-49ab-994a-892b200347e8@linaro.org>
Date: Tue, 6 Feb 2024 16:58:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: usb: typec-tcpci: add tcpci compatible
 binding
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux@roeck-us.net,
 heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
References: <20240205164316.805408-1-m.felsch@pengutronix.de>
 <20240205164316.805408-2-m.felsch@pengutronix.de>
 <004dbeb3-f863-416c-a4e4-18739302ae58@linaro.org>
 <20240206145253.u555h3rvtetv3qaf@pengutronix.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206145253.u555h3rvtetv3qaf@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 15:52, Marco Felsch wrote:
> On 24-02-06, Krzysztof Kozlowski wrote:
>> On 05/02/2024 17:43, Marco Felsch wrote:
>>> This binding descripes the generic TCPCI specification [1]. So add the
>>
>> Typo: describes.
> 
> Argh.
> 
>> No, this binding describes PTN5110, not generic TCPCI. This is not
>> accurate commit description.
> 
> This binding is currently missued if another TCPCI conform chip is used

Why would people misuse binding instead of doing things properly? :)

> which requires no special handling. I could have dropped this commit
> since the 'tcpci' is already present at i2c-device-id level.


> 
>>
>>> generic binding support since which can be used if an different TCPC is
>>> used compatible which is compatible to [1].
>>
>> Sorry, cannot parse it. Please run it through native speaker, Google
>> grammar check, ChatGPT or some other way.
> 
> Argh.. you're right, sorry. I will rephrase it.
> 
>>> [1] https://www.usb.org/sites/default/files/documents/usb-port_controller_specification_rev2.0_v1.0_0.pdf
>>>
>>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>>> ---
>>>  Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
>>> index eaedb4cc6b6c..7bd7bbbac9e0 100644
>>> --- a/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/nxp,ptn5110.yaml
>>> @@ -11,7 +11,9 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: nxp,ptn5110
>>> +    enum:
>>> +      - nxp,ptn5110
>>> +      - tcpci
>>
>> I don't think this is correct. First, this is binding for NXP chip, so
>> why generic implementation should be here? I would expect it in its own
>> dedicated binding.
> 
> The nxp,ptn5110 device was the first driver which implements an TCPCI
> conform driver. The driver already support the tcpci binding for i2c-id
> devices as I mentioned above. IMHO this whole binding (file) should be
> converted and the nxp,ptn5110 compatible should be marked as deprecated.

You speak about driver, but I was speaking about binding.
> 
>> Second, we rarely want generic compatibles. Care to share more details?
> 
> As said above this particular NXP chip is an TCPCI conform chip. There
> is nothing special about it. There are other vendors like OnSemi (in my
> case) which implement also an TCPCI conform chip. The (Linux) driver
> already binds to the generic tcpci compatible if the i2c-core falls back
> to the i2c-device id. It's even more confusing that the i2c-id supports
> only the generic binding the of-compatible support only the specifc one.

I don't know much about TCPCI, so maybe questions are obvious: you are
claiming that there will be no differentiating hardware element, like
reset-gpios or power supply for none of TCPCI-conforming chips? All of
them will never need any different hardware configuration?

Is this what you claim?

Just to remind: there was such claim for USB and PCI till we figured out
it was simply wrong and we are living now with on-board hubs and PCI
power-sequencing stuff.

> 
>> Are all details expected to follow spec, without need of quirks?
> 
> Please see above, I hope this helps.

Sorry, doesn't. You still speak about driver and how it can bind to
something. I did not ask about this at all.

To be clear:
WE ARE NOT TALKING ABOUT LINUX DRIVER.

We talk about hardware and how it is represented in Devicetree,
including its supplies, pins, GPIOs and any ideas hardware engineers
like to bring.

Best regards,
Krzysztof


