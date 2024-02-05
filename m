Return-Path: <linux-kernel+bounces-52296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E466849675
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75F5280F79
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59B412B8A;
	Mon,  5 Feb 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQ+Bt2Dh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CAA12B71
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125319; cv=none; b=JbEVbZbM8kB3zO6tOYTpyrIKrTsblUGNQqXNOUQb7QCtmlK+KK9Ky4zCR/1xZ0GtOUBs6CMRR8CI7XIz9wCJ+qan4uwRks5WIWM2/wHjRYum611bDpHjVOLd4Z2Rex/fEBEuxmU0nh/wfTcMe9tK6k5WbQcQHFIyz3QGpMhc3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125319; c=relaxed/simple;
	bh=X4ALGcpsV4UaQiPrJCc0VpdLNOaBURKUpJTn4aBuWcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJKFdaRRYl+kU2tDtSbRpG6OWwSleBafSFw8QnBioA2R1sggdAmz7uGUT0G1WPjBU/3YoNjtsI1Zvwmib55ZVQ/lWVCtTRBN4szy3/dEB6hSWeLzagojbvgj5V8Mot+29IfPQHToXAojcCixFf1toyISzlbbBDdm8ST1L05u0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQ+Bt2Dh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55790581457so5770819a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707125316; x=1707730116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsR4UKv4nZOmxTfx+Z74r0Squ/dac0InL6X79pDAQPo=;
        b=QQ+Bt2DhUSj5nFwOOLbILlmm2a2DteVMK+KyHTPOYcKYEkTlCg37DXUJzlgXzD5ne7
         dz0gVzzrCksLIplZT73ls9oCnV8lJnKN/6SOeF10JfIIpYobd/RM5S4XFfMf+AQcSugk
         vSaOpbnyrnoGHYLFyXXN8Rrff21zgdQCPSDL8TVCCSxThzz6t6xWJ+0VqoE9lm0nVm5h
         4QNwkZv0MKx3hKD7xkZdiOLDg+vEfTg5wWMHqVLgVKgt0hq4ha/55/94CawioCZnaz7d
         uGvOwWb8FtIe+BwEJRpe0iahFVjlQk+4JRsb53SukinW2/zyUbNJ51Izb4ztIXc7xzWr
         gXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125316; x=1707730116;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsR4UKv4nZOmxTfx+Z74r0Squ/dac0InL6X79pDAQPo=;
        b=mpN7L/YmtzBMwA8kw9Ct360xkzYosQ09PD7A0E+uTw79JSIBnALBN2I23CaaC74EN8
         sZAHDfEHpmtgmSaGrNcB3Oiya8dqma6dYjygUyZfmGiTWDKkc0Qpuzf3+S3Hd8a5aT5F
         NLYw7JBC/ae+mbza8KJetv6o+9hG+OFdzkRiqhRYwxk4bCAnKHEEy0LO0LxCkhpEfZ1A
         K6qhcjfdu6UIVjvTywtGO04DTfrbMAv89k26tj2+DmG8x+BShlz4tV7R+ldI9sXb6hdA
         qHFcMHozbQZyqYSKdemyaVh4cyKBKk/BqEXlnt5y43ygF6Sw36SJzMDC7NdKufvVHz0G
         r8SA==
X-Gm-Message-State: AOJu0YzlZWtfsASZeIxdhQCncDGTkBEMYHOt88iZchHVvW+cOOZlzuso
	Lg+mqMNKOHf+A6q26vyOmjvEE2CKqj2YeUKN1Jpow+DBSNtsa/EqvVWah33X5aY=
X-Google-Smtp-Source: AGHT+IFqfbd2QJeWiBRrJsA40CHzBhei6kYhdmWDNrzFyGIZBwIjKKXW0+KZp+vrprT3CJp5OeFK4w==
X-Received: by 2002:a05:6402:3595:b0:560:11f8:5468 with SMTP id y21-20020a056402359500b0056011f85468mr5180082edc.32.1707125316318;
        Mon, 05 Feb 2024 01:28:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUo2T9BtLdhNsIObIChz2xstRz9X/HKPqgqhxVWwR7B94mE5Ft46iOT+E+te8ZPVppAJ8k4ml2lkJKQUzrw6cbt7KMKIfbxDr6wUlzvqrUkRiTqRmtbTp3u52UtOZBgkmO4FW0xjXnHhLO2bTIbo1rucZ5TWpq1ZtoUcs4/76RoTVhlfZPFYm6gNKcsri7DXjU1iWPnvx4qSUjavaN/mt7//Kvv4H99CnLggHeHOiN871p8dLMo1+VOxOiDMkVlZDzs5LkzCedNRzRpUIah6ZNKmeEXp6KNb2Gid0RqyB7gjlvu+lYoZCJF8GIEd6kfX87Cws0JdAHzc3i7esdqyg8ZYCgvKbU1di71/9zdVGl2Az4mwsi0oa/litnQa7NtLl7O9PCCMbDWFDn/A6MU1Mp5/AnhKOxNb9Bv/xTG0fnh8Ff0Tw/xJS67UiPvvdC/25TbLnlPnsAmTAXQdY1q5igE7g==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id a27-20020a509b5b000000b0056036fd311dsm1905337edj.93.2024.02.05.01.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:28:35 -0800 (PST)
Message-ID: <5bc2bd1e-16a8-4de4-bec6-9391addacc89@linaro.org>
Date: Mon, 5 Feb 2024 10:28:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7192: Add properties
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>
References: <20231114200533.137995-1-alisa.roman@analog.com>
 <20231114200533.137995-2-alisa.roman@analog.com>
 <c6ca5a25-2d41-4a46-95a5-eb994c4cf529@linaro.org>
 <09cc2ecb-b73f-495a-9196-dbb4899f4c85@gmail.com>
 <CAMknhBFhr=qTd=nioq_m=icZZUfYWSq8Moy4A4RssvbcNoLNQg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAMknhBFhr=qTd=nioq_m=icZZUfYWSq8Moy4A4RssvbcNoLNQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 23:20, David Lechner wrote:
>>>
>>> And this should be input clock.
>>>
>>>> +    type: boolean
>>>> +
>>>> +  adi,int-clock-output-enable:
>>>> +    description: |
>>>> +      Internal 4.92 MHz clock available on MCLK2 pin.
>>>> +    type: boolean
>>>
>>> This should be clock-cells and clock provider.
>>>
>>> Unless you are just documenting already used interface which you do not
>>> want to break...
> 
> This property is already used in the mainline Linux driver, so sounds
> like the "don't want to break it" case. But it would make sense to
> deprecate this property and use standard clock provider bindings
> instead.

One could think like that, but what type of process would it create?
Send driver changes WITHOUT binding, then document whatever crap you
have saying "Linux already supports it!".

Whenever such argument is used, I am repeating the same.

Let's be more clear: NAK if this is clock provider and the only argument
is that someone sneaked undocumented interface bypassing review.



Best regards,
Krzysztof


