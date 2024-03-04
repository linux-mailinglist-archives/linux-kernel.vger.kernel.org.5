Return-Path: <linux-kernel+bounces-90132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EC186FAD3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99B71C21435
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4613AF0;
	Mon,  4 Mar 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqcLb7mu"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42838171AC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537422; cv=none; b=t5pqnS89MNjI66JaTmMjiAm0q48OaX4nfFIc1XixGqpNlPVGleW2f3v+8nsivGEBrWAeRCGFgP4wjvZ/97W/aeZbU9NekgpEU90H5L3KRgqDrOzIT2eMbga2SoA77rv/0cvpPhZ8v+JMtsxC67qx7hGgsqqLlTyWXtut0H4Q5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537422; c=relaxed/simple;
	bh=T9CJwU7JJlWalRdy7ev8+NX3fm5mBPdXRiF8u/fzrns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DF3Kxf3G1EErkr0MawqyrtgOcvhIJGp8EH/JynShFuElxEVD1vdaWd2b3c59ycnkmTpOHprqGnZYSVKmEFTfnPuKuAamH9q++8AzseKaVZ5y8LMRNb/QFU1VisjLM7/RmvtKSYbGUQbPb1OeDxEbSIG4D3g092k0X7cAB7Ji7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xqcLb7mu; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d28387db09so47134881fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709537418; x=1710142218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TER1wmHNOOjv/GulNATrBtLGlH29aFe8AWFhg8Tr/o=;
        b=xqcLb7muQjvBKuB4AC1bytt0Uc9SeLrRmuvAoYNVUvOL8XyDXCibnaZc2bL0MPAjG8
         /NLJiDLleqpxUcTNIQdoMl1BKcfv2LXD49/M3pJXldPjZmYEv0dkq/GAe5rOXpICv/j3
         o1RhO3l81bmu8JLEgRVI0S/GD5yjky0zdtfYMGC1u3nR5Bizyir2IeXgPPfdt5Q2qQqC
         1EEOwcw3xp/A1ExFWdLtb9FQKT/InRDj2W9BNmMY/4okJjbUaoa9Qeu+kLuKaCSgraCL
         sof5DYa1XGCkyBDPrrtipisqeK+tIUhlFcov6QQtzvlgSO9MwHZezybZgVqPNOifhqvj
         /G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709537418; x=1710142218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TER1wmHNOOjv/GulNATrBtLGlH29aFe8AWFhg8Tr/o=;
        b=SJS5XZJfTqsQ0ZIE7A+MEVS5IXH9Z0t0JhdmPiHuV5SJ3Zf+uBPzUwZ5Cp5T4yZ8V8
         4Bfy1Dtw1LsFrbSJqwoK5JtkUIrlbngY9SslHfsIvTKRR5OIb6kHhr3fn+5Ex0hPn4vu
         hGZ/XKFUjHUJNQh7ESNfnii5Gjl9zda8HKOGzp1Ru7waf53gKTWoHb4CGYDBRoyi3J8p
         sK6jxUcQWxvHVKYJb9atWxSPt1ysvaNSSLBGjofunIVXxX/v1UOdAAVH1w8U/7meXJSN
         SWN1/2Bn/KnI1hsk49H/gaUn+XowpnG0W0X/03rX+oDTauulC2A+SAO2XQcrsggN4htB
         asvw==
X-Forwarded-Encrypted: i=1; AJvYcCWLvxDBoNBEV0AcrXxtCOHFOAf5OCussOFysbKHzkSx3NgvJPLrnPjdn1EFf28sGqhUF8wSgmeSENzDqvuh4SRui6QmKXJzfEXAJzHO
X-Gm-Message-State: AOJu0Yzn4f2OMVj9iuapyBIb0HeNl/N9jluzjTfYdvY2ExBLuB/Kl2cN
	oF/3kfSnwOS8mP1Cyd55KM1/5jlxIxHinNUzUEAd9pSBwZT6AbIL/GYT1AH7K4M=
X-Google-Smtp-Source: AGHT+IFkRrv4anxymQqaC6+gFUNW1PWC79HVhB7OQRfg7dRzO6pQjj6UNsBav1jFcSM3y/jmL9nPZg==
X-Received: by 2002:a2e:9592:0:b0:2d2:c3ba:fe26 with SMTP id w18-20020a2e9592000000b002d2c3bafe26mr4940806ljh.48.1709537418377;
        Sun, 03 Mar 2024 23:30:18 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id e2-20020a05600c218200b004125f34fd7csm16569261wme.31.2024.03.03.23.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 23:30:17 -0800 (PST)
Message-ID: <cb51aadd-c350-42e2-9684-ac4f7dbf864c@linaro.org>
Date: Mon, 4 Mar 2024 08:30:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
 schema
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>,
 Rob Herring <robh+dt@kernel.org>, yilun xu <yilun.xu@intel.com>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>,
 Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>,
 krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-fpga <linux-fpga@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
 <20240221195058.1281973-3-charles.perry@savoirfairelinux.com>
 <4a9f0eef-590b-45df-92bc-b63ad9282e18@linaro.org>
 <1012793477.1508198.1709486517581.JavaMail.zimbra@savoirfairelinux.com>
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
In-Reply-To: <1012793477.1508198.1709486517581.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2024 18:21, Charles Perry wrote:
> On Feb 27, 2024, at 3:10 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:
> 
>> On 21/02/2024 20:50, Charles Perry wrote:
>>> Document the SelectMAP interface of Xilinx 7 series FPGA.
>>>
>>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>>> ---
>>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
>>>  1 file changed, 86 insertions(+)
>>>  create mode 100644
>>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>> new file mode 100644
>>> index 0000000000000..08a5e92781657
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>> @@ -0,0 +1,86 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Xilinx SelectMAP FPGA interface
>>> +
>>> +maintainers:
>>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
>>> +
>>> +description: |
>>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>>> +  parallel port named the SelectMAP interface in the documentation. Only
>>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>>> +  the clock, with the MSB of each byte presented to the D0 pin.
>>> +
>>> +  Datasheets:
>>> +
>>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - xlnx,fpga-xc7s-selectmap
>>> +      - xlnx,fpga-xc7a-selectmap
>>> +      - xlnx,fpga-xc7k-selectmap
>>> +      - xlnx,fpga-xc7v-selectmap
>>> +
>>> +  reg:
>>> +    description:
>>> +      At least 1 byte of memory mapped IO
>>> +    maxItems: 1
>>> +
>>> +  prog_b-gpios:
>>
>> I commented on this and still see underscore. Nothing in commit msg
>> explains why this should have underscore. Changelog is also vague -
>> describes that you brought back underscores, instead of explaining why
>> you did it.
>>
>> So the same comments as usual:
>>
>> No underscores in names.
>>
>> Best regards,
>> Krzysztof
> 
> Hello Krzysztof,
> 
> Yes, I've gone full circle on that issue. Here's what I tried so far:

And what part of the commit description allows me to understand this?

> 
>  1) Reuse the same gpio names: Duplicates errors of the past, Krzysztof
>     doesn't like it.
>  2) Different gpio names for new driver only: Makes the driver code
>     overly complicated, Yilun doesn't like it.

That's a new driver, right? So what is complicated here? You have new
code and you take prog-b or prog_b?

>  3) Change gpio names for both drivers, deprecate the old names: Makes
>     the DT binding and the driver code overly complicated, Rob doesn't
>     like it.

I don't think I proposed changing existing bindings.

> 
> I think that while the driver code shouldn't be the driving force for
> the DT spec, it can be a good indication that the spec is unpractical to
> implement.

What is impractical in implementing this? You just pass either A or B to
function requesting GPIO. Just choose proper name.

> 
> In this case, there are two interfaces on a chip that uses the same GPIO
> protocol, it would only make sense that they use the same names, this
> discards solution #2.

I don't understand this. You have devm_gpiod_get() in your new code. Why
is it difficult to use different name?



Best regards,
Krzysztof


