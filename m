Return-Path: <linux-kernel+bounces-77127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24286017A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C63B263A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6F14B833;
	Thu, 22 Feb 2024 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnzMwDWa"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FFB14B830
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625978; cv=none; b=cWLTD//adwGyOjh8G+N44LQuGwsmxEWcYgS2uaMI9/rc3oroCSdoDfWJXRPlgH6csnM7IeKvHzdjtp93s9Vcz9jf5gYDlrQ1i7AFXIr8It/35yi7U9Xw+lS22VWBNR8p8jgx16qAJz/Z8EJu6hxrAC2E61CX/RRjx4Q5mE/Kmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625978; c=relaxed/simple;
	bh=4auB3Wu51TGi/OiRdGHtky2AtFANemyJj3HfRrvvy/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzamIpBGmbVtfIoMBRg9v0blegw3MlDGal6tloE1KLi9cthqjYl8H7OBQ3mORJ4c/wU/4qbRHyH/iZMUTyGjr0eBREh7QUzvos+hqVzeCMvJ9A1sMwwXwwTOaH7HPRDTXXQbf9bVhM9Zdv5z+piAQHB5nW0XJPwOpmSwlDDlaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AnzMwDWa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a36126ee41eso1874666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708625975; x=1709230775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFsNeXiJglo6yKxWaC4ijNcR6HEF6YmYkv1G4zrBDQI=;
        b=AnzMwDWa6rPnFsOTlYEmVMOO/zkZsU4/w2fHWGMcbwrkbhfBzj1gLMfM4EWiNMZpRe
         ihVpDo7wYkyceECc+iUPvesbBXRyjfnpcBHUh4HskJBqFFsHgtAlR2794yMI0AyQ9pVV
         lRnikZ4+sn+J49QasAJpxbuHA5cKQSdCmHZ6lQfuZwCANdGfBXpcr8aMWzMWUp4JTEYI
         +9D4orSSD/QBPJA6cMWcrqTuewH8cha+qzcnFGQ14VwWXlhawuoq74VHEoLMKPegOPab
         SOTVUgETNJcZD7OK5DJgKbArkM/3NsAhAJBPJCeB7/xZKDdMONN2QY90apJjB2PsuT7o
         /Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625975; x=1709230775;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFsNeXiJglo6yKxWaC4ijNcR6HEF6YmYkv1G4zrBDQI=;
        b=p+y5wykuahrGZ8QwVCXaq2Ba1mBljSC/13P69Zn+FcvUHnLDTw/YCriVi4V/0T2Inb
         INPzh+T4IE/NI9NKyon++vXUyUcIOqUbN4mct/VIreoFX9b0Z1A/OBMprcsmhhRzQYpj
         Ocoq2NDQXXot6s70VBMpY+fsKZKmXqNsyfUK4/4S3snpuoGLRRvNyEXlzMF0S19YSawx
         dR9IndlFFIwpGktyJrDA9LhD3a9ewZXEEZzwO6iaEAmzA8BVe22eOonmlSpa4zmDH9T0
         tas15ym4XWfzN9G4hc9tBdj5pfADiHBA8vtyF2wXHCyDahAOZSui1dL+p3X68f0Kl8V7
         C6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXAieEeRJe1bDw0297QGVzZqmeE4DVL4FJ3hf0GB+6zpVMnq6YmnPi4vF7f+XFG4yKAqs5eFfCNDMRLNWp0ngHi3o/+YJc3Q/qJJEut
X-Gm-Message-State: AOJu0Yz9qqVooFc19kZrgN5gLUBYCUklFwkOF1Hvki7+2g6pKf6lImBL
	pkU1PBgBxUAC7zVynDENFYpzCX0SndupM4Of/G2x7mdLL4bPKLWi84BYUmOAQNU=
X-Google-Smtp-Source: AGHT+IECgkZ2kjobZrW3rIQWJcd2uPQuvy7Oj8L0aqxH8svO3Hs4YhuCtjeHl2p5eWFbc1qS0E6haA==
X-Received: by 2002:a17:906:48ca:b0:a3f:10:bf70 with SMTP id d10-20020a17090648ca00b00a3f0010bf70mr5382264ejt.37.1708625975221;
        Thu, 22 Feb 2024 10:19:35 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id j20-20020a170906411400b00a3efdb625cesm2762457ejk.124.2024.02.22.10.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 10:19:34 -0800 (PST)
Message-ID: <80e3b597-1273-4391-9aa5-72e2a9e76e57@linaro.org>
Date: Thu, 22 Feb 2024 19:19:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] dt-bindings: clock: histb-clock: split into two
 header files
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-clk-mv200-v3-0-f30795b50318@outlook.com>
 <20240222-clk-mv200-v3-3-f30795b50318@outlook.com>
 <5781c1a8-8097-49f6-b672-33a6bcf2ffaa@linaro.org>
 <SEZPR06MB695934C69446B4878115B17796562@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB695934C69446B4878115B17796562@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/02/2024 19:15, Yang Xiwen wrote:
> On 2/23/2024 2:11 AM, Krzysztof Kozlowski wrote:
>> On 21/02/2024 17:41, Yang Xiwen via B4 Relay wrote:
>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>
>>> The CRG driver between different SoCs provides different clocks and
>>> resets. We should not provide a generic header file across all HiSTB
>>> SoCs, instead each CRG driver should provide its own.
>>>
>>> Split histb-clock.h into two files: hisilicon,hi3798cv200-crg.h and
>>> hisilicon,hi3798cv200-sysctrl.h. This header file is for Hi3798CV200
>>> only actually. For other HiSTB SoCs, some clock definitions are missing.
>>>
>>> Create a new histb-clock.h to include these two files for backward
>>> compatibility only. Deprecate this file as well.
>>>
>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>> ---
>>>   .../dt-bindings/clock/hisilicon,hi3798cv200-crg.h  | 62 ++++++++++++++++++
>>>   .../clock/hisilicon,hi3798cv200-sysctrl.h          | 17 +++++
>>>   include/dt-bindings/clock/histb-clock.h            | 73 +++-------------------
>>>   3 files changed, 87 insertions(+), 65 deletions(-)
> 
> 
> Should I fix the #ifndef #define #endif stuffs here? i.e. s/DTS/DT_BINDING

I would not care. But new files could be correct.

Best regards,
Krzysztof


