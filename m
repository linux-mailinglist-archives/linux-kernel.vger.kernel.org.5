Return-Path: <linux-kernel+bounces-112310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F101B887831
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2034E1C20EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65F168DC;
	Sat, 23 Mar 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUEeaANx"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1263FC7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711191737; cv=none; b=RTiMyiPGE4HPX/G1ONInu8kZuEaOuJeKQdHiwKZINDprLjB7EywxoYNPcB828T2lc7PELzWid6WIjm01INOi/6LW1MyWVrzVbGsIb20kCN94ftQiaZQwbQbS0TkojJr6+nViJHFAHPPZRs6pDnIJ7H1mXHAjvbt05G9COGG4Zp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711191737; c=relaxed/simple;
	bh=1/lBuUFFu47E80gX2+9hmCehguCK5DlCp9iszbTL8W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mmqt6E3spcrQBuWP7WDL2RvcVkq+nOCAvr/Qdg018rn2JDeuUQwZTzf2/lbM+AUCMwMOu78SImNR5+lfoTexIXO4TpDFlJnssWiyZA+j63f8WEodVjZK6Lv0exaNyCywvbRR9x2vZRs7BxKSWoOllkV9zLWEvX/gw3XKGoGvMso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NUEeaANx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bf5104ce2so751633a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711191734; x=1711796534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dq9iZxQWSEhkDSaw4XzDPMOvLVbhwjj2yH4g9CSlP7k=;
        b=NUEeaANxSvY6cqP0HEgPY2MNARXFZ1lETLH0gDk9dJSubCH2vXFbTN1qZE1e0See84
         O1Etmw0tR1SkUBBzaKsOFD1hvdnwfv39qw7i2gJTsSZ71VKZYpESrKSPq1werUWhUeRD
         X1zGwC5W8UubuqRWDfbX3FqZyLSTaS8SGTL/NS/SsdCfUWc10X8FH1qMEPEteHSxJIjr
         Hy1SkGy/zCLdDEtCeXns3L+u4Fo2aebofzyh0W9MT58ZOOHfsE0vTJ0cyWq/Kh4Siw2C
         zfPNdDxz+nIVq/gPaIUUuejDnVV+0Z0jed9rzYr0ol2RWIozPah0jKL2Iucp//+V6H4K
         RoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711191734; x=1711796534;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq9iZxQWSEhkDSaw4XzDPMOvLVbhwjj2yH4g9CSlP7k=;
        b=CKjD5yD7sXHkOPX9raFXv5U5StijB1HKUgQdbubgFHAeT8f4pqohyMW/R3emFRziL2
         u0lcuCfmii8Azfk7Bl0SgLgN8BxuwCIFjtg3kUieq2FQYBZt+WcBNY+RkbxpgaYFXVvC
         i7jvhO0jrbeevuDRKL7h8/OIIDlMu3eLY6mAgwwsmrH5BQ79YqMPJUH83bowgcrN9r80
         a7KlKSckpt8mIVq+9Qkw7mpL8whoBz8q321owqNwTv2jAVCxvO9fXDiPJAgYgnHmqXnU
         BkxG20tmV42d1LPaWSJgGIwD1mnlH6MeXvuaZZy95AksGrLHGCR06IWK68ifHtwcqq2V
         7J6g==
X-Forwarded-Encrypted: i=1; AJvYcCV3BNRl+rTIHy9kZRV0yA3K0KKDcOassJEbIkHItFkXUrG26c+zf6cYSzcjDA9ui9QwiafuQIGTNz2P83a4SPZnuhG+AHau0IT0pYnz
X-Gm-Message-State: AOJu0YyMbW8MdIPruP5NY6CoFAiTn1F+uF8GmoqetNqoHzO/XLB/mWTK
	2VYGR8MuG1HkcfShEl6bAzGYYyIj6BpBHMsrIRMehnBFyFqQdw7ZfCS1lsBz/w8=
X-Google-Smtp-Source: AGHT+IFgRdL1ldCMZPGdtxNQwCeQt6fRjLSGiWKoxzjM+E933CWvgDGRRxcb0E5RDdjN2Q3HQajR3Q==
X-Received: by 2002:a50:9984:0:b0:56b:f2d6:4be1 with SMTP id m4-20020a509984000000b0056bf2d64be1mr1436258edb.4.1711191734212;
        Sat, 23 Mar 2024 04:02:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id q3-20020a5085c3000000b005645961ad39sm767848edh.47.2024.03.23.04.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 04:02:13 -0700 (PDT)
Message-ID: <f892767c-7e01-4099-b674-0eca6edf7bba@linaro.org>
Date: Sat, 23 Mar 2024 12:02:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: Add rk816 binding
To: Alex Bee <knaerzche@gmail.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20240323085852.116756-1-knaerzche@gmail.com>
 <20240323085852.116756-2-knaerzche@gmail.com>
 <bfe79f3d-1615-45a4-81f7-7e30740308d7@linaro.org>
 <3c0d5aa2-55fb-4827-bcd4-256e6ae55ee9@gmail.com>
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
In-Reply-To: <3c0d5aa2-55fb-4827-bcd4-256e6ae55ee9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/03/2024 11:56, Alex Bee wrote:
> Hi Krzysztof,
> 
> Am 23.03.24 um 11:32 schrieb Krzysztof Kozlowski:
>> On 23/03/2024 09:58, Alex Bee wrote:
>>> Add DT binding document for Rockchip's RK816 PMIC
>>>
>>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>>> ---
>>> changes since v1:
>>>    - lowercase/hyphens for regulator node names
>>>    - rename "-reg" to "-regulator" to make node names generic
>> I don't understand why did you do it. I did not ask for it. If you want
>> to rename, drop redundant regulator or reg suffix from node names.
> You didn't ask for that, thats true.
> 
> I did it regardless, since node names should be generic and the "-reg"

device node names, here you do not have devices.

> suffix is not. They are all subnodes of "regulators", indeed, but I don't
> think dropping the suffix completely makes the binding any better, since
> there is a boost(-switch) and an otg-switch which are also subnodes of
> "regulators" and they are just switches.

Adding "regulator" suffix does not make them more generic... anyway,
that's not expected pattern. First, do you see such code anywhere?
Second, the regulator node names should be usually named as the name of
physical component. That's the most common pattern.

Please do not bring some exceptions from coding style just for your
device. Your device is not special.

You did not respond to rest of my comments, so I assume you agree 100%
with them.

Also, please trim the replies from unneeded context.

Best regards,
Krzysztof


