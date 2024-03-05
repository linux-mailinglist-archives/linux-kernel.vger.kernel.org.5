Return-Path: <linux-kernel+bounces-92488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCDE87211C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B15B23C90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487718665D;
	Tue,  5 Mar 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsdO1B9n"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9AD86639
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647643; cv=none; b=VvTbnNyZpCJzPsm8krpGbm4Au+Tcm4ZqqxfN7R1G1dnqfU7fSBjxUm2bBJsBRCAlQ4BsQIdbHRGNdEYK7rrg2yIPJP58wtrvGI/vMQjIkrAI8ly7d2Wltqtbxd6qtDkfIgW03N1+r1a9UfxebcIK0jDco2aZ9JV2prYtTkFTy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647643; c=relaxed/simple;
	bh=WfL4tgYCBNlm88QF2xocX7qBGGscdXgT2nD7lKIGNYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8XojDJfEtHwF/8QrpuKifrzGXPRkaEsEoFU0lolb9GstlgMcu9FrEIb5f54zqur1gWqi87B1/f15FVJcx3NRaQzyO2q2QbE1XAeC8EfjaRe6hEsmPYxfx4SLKpa/7vrM44kynLRq5MMfw8wYpBdM4t2bc2TEvnLu1pZWwqtrnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OsdO1B9n; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5135486cfccso836380e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709647639; x=1710252439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SQZ1KwugUIsv31guuZMgo+Gr8p+7fO4HrOSEdoTVaKw=;
        b=OsdO1B9nBWqYzkdlmlhF8x2LIfCvnEIIqLFijesLmfcllwVB9jCyNcKZsavhje2J+C
         sLkl2Hp06LQVX8CmG4g7IAHlkam5N6irPyTAtRJfWBZBDJvxXE4vaKPZkLoUy5OG9wxm
         Q7j7KVvdDhANrOe/i+o0COjFYGgmrKkHb3euExf+bKPSNTopSIeomi2BJH8aRKgGC+Ju
         qvU94NASvshJGjMXwUuvVu3/UiIuZP92m7T8jJchvba2OnIh8q105fjmKkuK7Ap0T4hG
         IEQ4R928MKKfKOGwJ/rHqWyn4W+nKRIslx+5iPyoi2i4Rdb5HmaWGeOw+cu3TWka4+nv
         keRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709647639; x=1710252439;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQZ1KwugUIsv31guuZMgo+Gr8p+7fO4HrOSEdoTVaKw=;
        b=H4zXBWNND3FHBR3+4qM5i/N29QjJ5H9hH8j3fQV9dft60l77LIRTzb2KsRtlYLbEJv
         D/MG4qHC0BfEamF9eqJLiw55o1jLh3Mc7poTuIFXh15yAW5iwS1HlUyDV/iqUJpZePYV
         7B7e7pnJIrRY29/n4rKYEKw/k+3DTp9WeT5UKTHnWT8YI21+bckdtjZ/6lzmbyim0Ezq
         +f/TiAxIAlsydnqltFvZTK/yzKK6A6mTbVirOIPrRAGRIEAOFrhP/RgPGRXwbTa/JJRQ
         iI8e3W/Eo+s8/zBC19UUtfaIW4X6ufp8H1+lYFWk8nx64W0mNkhtGHAdA4MBWS0Gmrju
         eWXA==
X-Forwarded-Encrypted: i=1; AJvYcCXYauZ4PNlO4YuvIn5MTDkZGrkybufUT/VX9JnKCQOCROC7Rv4HMv0eFtgos4NmOhU+DDNgosTnvSYBcG2moYR6oJe0sCN5qDxzgfmQ
X-Gm-Message-State: AOJu0YyoQU4Yi2tGQ3WcemFybgJ3afl4g+RAMu9zUKoY/Ly3DnaP/3ai
	DPSKBjpf8FHbfoa+yTqYqOLzf1xBoOQnMAootDRVBnbBdMrSS7BfJJ912bvnaLc=
X-Google-Smtp-Source: AGHT+IFvilm/A6uPSq1BSTUUbgdyFwbFGl+2O7ZvO96QaEmcmVY8EsU5EK1HAAChcrJjRk7UgMKlBg==
X-Received: by 2002:ac2:5629:0:b0:513:2027:27db with SMTP id b9-20020ac25629000000b00513202727dbmr1342797lff.17.1709647639500;
        Tue, 05 Mar 2024 06:07:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id d12-20020a1709067f0c00b00a4495c51f4esm4857730ejr.39.2024.03.05.06.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 06:07:19 -0800 (PST)
Message-ID: <58a62c7b-3348-4252-91be-ec30d5b723b6@linaro.org>
Date: Tue, 5 Mar 2024 15:07:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
To: Yuklin Soo <yuklin.soo@starfivetech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Hal Feng <hal.feng@starfivetech.com>,
 Leyfoon Tan <leyfoon.tan@starfivetech.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
 <3b9201e0-e1d9-463c-aa1a-cbbedd1f8907@linaro.org>
 <ZQ0PR01MB1302FD75082E80DFDDF81E82F645A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
 <2236948f-bd68-4476-bc2a-814c46c99334@linaro.org>
 <ZQ0PR01MB130288F0EC3C17147A46E4CDF622A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
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
In-Reply-To: <ZQ0PR01MB130288F0EC3C17147A46E4CDF622A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2024 13:00, Yuklin Soo wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, February 20, 2024 4:10 PM
>> To: Yuklin Soo <yuklin.soo@starfivetech.com>; Linus Walleij
>> <linus.walleij@linaro.org>; Bartosz Golaszewski
>> <bartosz.golaszewski@linaro.org>; Hal Feng <hal.feng@starfivetech.com>;
>> Leyfoon Tan <leyfoon.tan@starfivetech.com>; Jianlong Huang
>> <jianlong.huang@starfivetech.com>; Emil Renner Berthing
>> <kernel@esmil.dk>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>> Drew Fustini <drew@beagleboard.org>
>> Cc: linux-gpio@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; Paul Walmsley
>> <paul.walmsley@sifive.com>; Palmer Dabbelt <palmer@dabbelt.com>;
>> Albert Ou <aou@eecs.berkeley.edu>
>> Subject: Re: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100 pinctrl
>> bindings
>>
>> On 07/02/2024 03:42, Yuklin Soo wrote:
>>>>
>>>>> +    type: object
>>>>> +    additionalProperties: false
>>>>> +    patternProperties:
>>>>> +      '-pins$':
>>>>> +        type: object
>>>>> +        description: |
>>>>> +          A pinctrl node should contain at least one subnode representing
>> the
>>>>> +          pinctrl groups available in the domain. Each subnode will list the
>>>>> +          pins it needs, and how they should be configured, with regard to
>>>>> +          muxer configuration, bias, input enable/disable, input schmitt
>>>>> +          trigger enable/disable, slew-rate and drive strength.
>>>>> +        allOf:
>>>>> +          - $ref: /schemas/pinctrl/pincfg-node.yaml
>>>>> +          - $ref: /schemas/pinctrl/pinmux-node.yaml
>>>>> +        additionalProperties: false
>>>>
>>>> Why the rest of the properties is not applicable?
>>>
>>> The regex “-pins$” make sure all client subnode names end with suffix
>>> “-pins” (e.g, i2c0-scl-pins, i2c-sda-pins)
>>
>> I did not talk about subnodes.
>>
>> I asked why the rest of pincfg and pinmux schema properties are not allowed.
> 
> Initially, I wanted to allow all properties in the pincfg and pinmux schema. I misunderstood the meaning of “additionalProperties: false”
> and I thought it means all additional properties outside the pincfg and pinmux schema are excluded. The “additionalProperties” will be
> set to “true” to include the rest of the properties in pincfg and pinmux schema and not to be restricted to only the properties defined in

In that case drop all the properties and use unevaluatedProperties: false.

Fix your email setup, to wrap emails properly. This is unreadable.

> 
>>
>> Best regards,
>> Krzysztof
> 

Best regards,
Krzysztof


