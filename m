Return-Path: <linux-kernel+bounces-93403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BD0872F48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AAF1C20CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4135C5F7;
	Wed,  6 Mar 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhWp52Zg"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAFB1B7FF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709152; cv=none; b=IJFFCoZ79HIvG7JJ3kmnQlGeoEffn2eWgP9lqCRDEkoOuRfY9fA1TmeGEmKf9iyT+Fe0MXD0cFXy5Iat3c4IhMm3varkMkeB58JxLF5A46qHLJQj5DuYdV02ZnaphPgxXn1E+NZae7Et9FrmkMLwu+RY6ATzyRgp4ZCoTtWIEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709152; c=relaxed/simple;
	bh=OJy+Fbn5+hB3oI4BdZob93g0SRQmy5FHhDVMOYgqTjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnxcCjyzt4dfAxsWM+GIzM8OqsCbxquRuUn7iC15MX4urfUeSyv0rdaB4x8qAZQZd4gZaj9nQE30cnUL/5x7ubU8HO4fgbvnnbUF8anZVE61DxWZX4jGeiQMYfehMAZhfbNteVGCtHbBvZl8GUpArbtjImlBudJgZwJzPq4VoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KhWp52Zg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a446b5a08f0so96119866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 23:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709709149; x=1710313949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=im7eqXJrsxkgVFwNBr16ZKH6YthsVgCDuph85s91Et0=;
        b=KhWp52Zgmdndsg51pU8+9cerv4E6qoNILM4AsUe/gi4QiFMSyOyuX2WyMmOH7MTX/T
         gx0Jy9JOMJBrCHTVZsXNoNXzuxUfFK7lhLva+zlYiho/prXSAGufSfwLYEoqOMstQQNg
         etzNZLDYH3xevXewaJ0xz4j/OixrkggePnfrEHYQHX0CYoHp0kHh0DtcSpqxubu80Q1W
         LR0EL/+LidDaKiSHicU0r1feWHx8FZilVa5G06W+x/DmkChylPb7DamgZLFJMhLW2HOl
         Y3kM5x5xuDqjYwp1x/UEJSFUtvxcKVVDl9uCirFXdga18J89+DzsyxEiJ+lYNM4U9Dnw
         IGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709709149; x=1710313949;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im7eqXJrsxkgVFwNBr16ZKH6YthsVgCDuph85s91Et0=;
        b=MsAB9ddYCx64kfswBkSjPYjf1CWWxTCkux0fDqZ5TxiAyxeEcN/GaDsH+bJRcJfA5o
         HoiFzbb6q+vvMtuAhGc21eybyPA4hg1YfZzMOmgyXQJSBWLJ8u/+X4jR9/+SnCuwRw3G
         onNxkYDRhrevqZM8jRe1EWXu1jWFUgZKzNe68iunv3Zd3E6eAg77K7unlPIoaolWec23
         BhC/gE0NW2DgfZAqTXaAsNogWmbF5ZQP8KEuColmp1T2yTpjwKdg1E7sp9Lm5VUVcDoc
         kTtOHlTB+6pnajDr/H5aQEGwoaLYME4Ne6iULUcTz+kEI9KvpeMwrm7RUfRRTtyLnc6X
         2FMw==
X-Forwarded-Encrypted: i=1; AJvYcCUCIbejHUdhTOo6KhoxpAbRc9wbBoGOUZhpuoq3Wa8N7dqLTJ4FsLVCipM1sSkxvlOvfpDyX0BhmbZCFWTu8Ozo5QTcnwzIeSX9nucO
X-Gm-Message-State: AOJu0Yx/ubVPalA3KK9KUPHK1Gr+mEkd6wHZd2nNGRcMfBFnTWeJnQ7X
	urxPS/VUavMX87R+3Hdm88Gd3ntazBjF87+qwM8M/9+mN4Wy9Q6QyJZoE4nL1s+Hh1e1+Gn+EH5
	3
X-Google-Smtp-Source: AGHT+IFvU0v3OSkxmYhF4G4jr8vB4pAIkTgWqIUKwZTEILQq+lAMvG8YUAoxDxV0eawJsL5UsircVQ==
X-Received: by 2002:a17:906:eb12:b0:a3f:c3f0:69bf with SMTP id mb18-20020a170906eb1200b00a3fc3f069bfmr5277043ejb.13.1709709149055;
        Tue, 05 Mar 2024 23:12:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id gt25-20020a170906f21900b00a3ec216ec6csm6732868ejb.45.2024.03.05.23.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 23:12:28 -0800 (PST)
Message-ID: <4c1e237b-d72a-4e3f-b6be-1434849ddd2a@linaro.org>
Date: Wed, 6 Mar 2024 08:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: qcom: qcm6490-idp: enable PMIC Volume and
 Power buttons
Content-Language: en-US
To: hui liu <quic_huliu@quicinc.com>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304-gpio-keys-v4-1-03604d778c86@quicinc.com>
 <f09dc3a4-ed5e-40b7-ae71-7c6cfd79da1b@linaro.org>
 <02a2e93b-f0f1-4506-9e17-444cfd1a208f@quicinc.com>
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
In-Reply-To: <02a2e93b-f0f1-4506-9e17-444cfd1a208f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2024 04:02, hui liu wrote:
> 
> 
> On 3/6/2024 5:20 AM, Konrad Dybcio wrote:
>>
>>
>> On 3/4/24 08:09, Hui Liu via B4 Relay wrote:
>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>
>>> The Volume Down & Power buttons are controlled by the PMIC via
>>> the PON hardware, and the Volume Up is connected to a PMIC gpio.
>>>
>>> Enable the necessary hardware and setup the GPIO state for the
>>> Volume Up gpio key.
>>>
>>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>>> ---
>>
>> [...]
>>
>>
>>> +&pmk8350_pon {
>>> +    status = "okay";
>>> +};
>>
>> This device is already enabled
> Hi Konrad,
> 
> The status is not set in pmk8350.dtsi, so I thought we should set it for 
> "okay" manually. Do you think so?

No.

Best regards,
Krzysztof


