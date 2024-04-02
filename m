Return-Path: <linux-kernel+bounces-128483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F5895B6E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4338A1C22783
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E88615AAD3;
	Tue,  2 Apr 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ln3evD+W"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B815AACD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081311; cv=none; b=DPNQcGltmivix1BVmJ6dBvk5HDfWUHg1DMyCPnLEnwOapwP8jKOYyfH0LBE9N09ugI1A+UiY8S9baKvvh72zDVAAkGshmiV94UDMSobStrjc5RgvDrU5JtP6Uo03J9dxLp82Hm+AEiGhl2WymTEk8yeN4LjTPt6rybXU7Xnc8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081311; c=relaxed/simple;
	bh=QXDe+b1pfFmrD1gjlyxJsiElaZ/NisJR/CXuCCO7JPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snhfktDCZIR7kzQiHsIVc6SzyxjXrOfN07ykPFs01wHC/dzXNOsYdJ5B4v1NQYf1X9c3Ygqw8n5bwQtEh2DEHvzdemHHJIrChJrxmcIx6EFC8Kgfmp7u6mJ5WbFcurZL+BN/OtnTsviXfgmM5qyKWZWfOxRWkroJykDQ1UCsJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ln3evD+W; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so8057129a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712081308; x=1712686108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jl+HxXrubbPCLS60WSMbACM5nh9bIds43FCR4XaMIOs=;
        b=Ln3evD+Wki7stwWLIhwV4qbnkyXRd8fWrBWdV539izA4c+XJGwONallPBPfEUdSa5/
         RrjEm+TqnA1jXN99RGuYU2Lz23PZX7PueUs1u7UR0mYc65GDCN9jxrn0ppFUSSZ1/DmN
         Ls+ZtKvpUSaHxbdZVKdmW+g1dh1lLyYoFN1FJxe2a5tNSCPOguH25Oq1dXuyGg9I44mA
         dm5ZnXlLPDF13QCDhuskytjry/SAOrruBpjV3fqqWA8mxPgZvOEd1WfCcmVzO0MIwwQL
         Vq6oRHXUh+R/1Eo+iFH4jyw0UfurJFFzymEDNTGrfyh3CTJdfD/s0XoDzh3L1/v9S5xB
         /qAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081308; x=1712686108;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl+HxXrubbPCLS60WSMbACM5nh9bIds43FCR4XaMIOs=;
        b=Q4WfvBhxMb4WArhh38cH0vlUWYsdnr52SXWhRHw6RXI9c4L3aMFVg/xTtyuPkyxTuO
         ewgUWly38hTh1tSOwhl0FjDHMCF1TRKQhKGCf26ErqoFXLXSUK0Bt+x7EAVyOq1JBrZu
         mPZd20tpTGrqYTmZvJwEnyHi7MnrBoITS7XeudCExxm3bELOva5c8rk1FOgMpdscZTzT
         Q+IOZnrMyuUXu5osUoUMYyQsbaA+tT9sCP8x3wGyn5pmVH7bHq2G6OzZRNIzvhqLu4Nf
         egCMBsr7+6kpsEy2e3FYtphjGw03w17N7fHjmBvUBYuKBFBfAwwieHpo9G8xPLTnuTub
         45ww==
X-Forwarded-Encrypted: i=1; AJvYcCVRPDc98ZK/FwQydhcedKq3xA17UppfZ4t5c/MevzvsqStXE1C1e/s5DKcjy7+V4J+hbmfI95yCAq2dOxj1CftstD7yVD0nUFOAiTPx
X-Gm-Message-State: AOJu0YwfekVH+gPytTJ0TKrKQJe1L/xRT8zKrBvAuJVfPzM7C0+wQdwN
	O2P3947oiVtq2q2kzBfbsh9elhmof9U/9HLf2H+vrGep5ng6z21qJWlHT0/1Sug=
X-Google-Smtp-Source: AGHT+IEpHC6uFtWT/O+6601uZ6iKWzRqqKpTom20RYOzuLpdVKK6XdUwgDXNU10M5hLhekXyn2izug==
X-Received: by 2002:a05:6402:27d3:b0:568:d315:b85e with SMTP id c19-20020a05640227d300b00568d315b85emr422679ede.36.1712081307540;
        Tue, 02 Apr 2024 11:08:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d14-20020a056402000e00b0056dd6c5f23csm2478221edu.10.2024.04.02.11.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 11:08:26 -0700 (PDT)
Message-ID: <a19688d3-5402-41c0-b10a-131cefed5b91@linaro.org>
Date: Tue, 2 Apr 2024 20:08:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: leds: add LED_FUNCTION_FNLOCK
To: Gergo Koteles <soyer@irl.hu>, Ike Panhc <ike.pan@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1712063200.git.soyer@irl.hu>
 <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>
 <6b47886e-09ac-4cb9-ab53-ca64f5320005@linaro.org>
 <5864594aa47ecfeb23d5d05a3afc02393f84b44e.camel@irl.hu>
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
In-Reply-To: <5864594aa47ecfeb23d5d05a3afc02393f84b44e.camel@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 16:36, Gergo Koteles wrote:
> Hi Krzysztof,
> 
> On Tue, 2024-04-02 at 15:55 +0200, Krzysztof Kozlowski wrote:
>>
>> Do we really need to define all these possible LED functions? Please
>> link to DTS user for this.
>>
> 
> I think for userspace it's easier to support an LED with a specified
> name than to use various sysfs attributes. LED devices are easy to find
> because they available are in the /sys/class/leds/ directory.
> So I think it's a good thing to define LED names somewhere.

You did not add anything for user-space, but DT bindings. We do not keep
here anything for user-space.

> 
> J Luke missed this LED from /sys/class/leds/, that's where the idea
> came from. The scrollock, numlock, capslock and kbd_backlight LEDs are
> already exported.
> 
> https://github.com/tomsom/yoga-linux/issues/58#issuecomment-2029926094


I see there sysfs, so what does it have to do with bindings?

Again, please link to in-tree or in-review DTS.

Best regards,
Krzysztof


