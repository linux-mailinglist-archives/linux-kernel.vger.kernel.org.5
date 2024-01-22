Return-Path: <linux-kernel+bounces-33040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C051283639C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7028E297102
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B0E3BB3A;
	Mon, 22 Jan 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzzbiyTr"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92463A8F9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927236; cv=none; b=MDaZuo7TK6hUPCGeEy8PEIamFG7WmOOPJsIEYFo4OC+/K+e6aovaNTFAtrLsXE5gWgKm06D/86GDPE/2HL4BXy7dNhNQgqCrBOQh5VFr9ggP+OJUX9lIi12j7giXBNvKRcPBAVeUg4GKggHc+rAV9VC5jok+s4gJedAdSe1jjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927236; c=relaxed/simple;
	bh=cgGflAX7Jk/DKD8c1/qHFTxGSFNzXzHgf4fiCny/284=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBEgEh1D3oMhU/W1ne/0mLZxmftQ6Q9gAOsXUevJxGWwb1nNVEkBw+VKytdZFtYLQ01opA7hoOkWhYXTaV5tYKWIY08FKe+eDH3uMmfgYaxQGx8kTLCycuzUcdi4f5H/7LFVw5oyhKqzWFYXoVmXlmRSjmpj9QyMsZvDZDkQPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UzzbiyTr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso4282653e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705927232; x=1706532032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekfPLQELwtuiCCO7YX+l1adjQj4DFXg4TFgO74oq338=;
        b=UzzbiyTrlyYo3/bdAAOOCb/vO3OSBTrUR3r80QrRhCuBRGhc1bq2WN85g7Ofy6IgF1
         svOAZfLTNBwnqj1+rOLz4P7o1XUtlYKtSRzO3NVF5KUUuFUEOpzxoOsJy+Y8SmePXLHH
         WzMqtAKERgd08T5OJg8kKIjZEWhYzw4wXMrq8vcX00nGa6i94JPkdXuUj0lylinf9JAn
         rKT/wSc0vwa1zE2dh1hiN/0ZNvR+UI8r8khQdDsvwTV2Xx+9qv3f6cfwAxRps+bkiJ30
         nmzXwO2pyvf+lyEyfrT86O2dvKVVRqJH3zgGOUhRSpKwHq50HKy9M1kAop+DGdHiAkVq
         UnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927232; x=1706532032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekfPLQELwtuiCCO7YX+l1adjQj4DFXg4TFgO74oq338=;
        b=r3ao56CGoMbv6wz1kH/5Aazmbx4fpzpCZeb84vUDGgtPZ3wvRmY25HZxFsevZBn3li
         1qT2NfwyhGMV04ve8Zkxi513Q3njhSyaJZpEhoDUHyWiGgPXWezDTpHQtCgQHf4+ZPtP
         /ZgDCW66Y0Cl0+I8Fwv2hG/iQbuyzEwAxHawtxAUW0chc/eqLIxJucsDyyGcZL64ooIe
         aJ82vbfp0DUJL+SjNzMSmG05/vQMZEp6iOHtOobadh0h7UfurWtl4Xgq91voxy3JG/xr
         V87zhwaX2EJdoiO7S32/0VTexK6O5ZUcypSmT3qPPpdvyxjnzJW3SAycGQFroJFwNHDF
         7IgQ==
X-Gm-Message-State: AOJu0YwYYBM7Ox/9kZNoI+nKj43y4H1qFVyhf78rF0AduyO8csxNv8G/
	7UavQgjcWYVP5eq0G9S9DyGrXJov655ISOSk4N/mD6wKXsXp/TSRhKDBuRpLPv0=
X-Google-Smtp-Source: AGHT+IEiFGQCnyB1ZPUgp96VxEKCkoa0z4ttz40Jl3uZYKmI1PZ+LItqGbMOR2LytoFl71tWVxsnCg==
X-Received: by 2002:a05:6512:31c3:b0:50e:7c08:1a55 with SMTP id j3-20020a05651231c300b0050e7c081a55mr2005478lfe.18.1705927231862;
        Mon, 22 Jan 2024 04:40:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id a18-20020a195f52000000b0050e70ebbaa4sm2037137lfj.186.2024.01.22.04.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 04:40:31 -0800 (PST)
Message-ID: <2e34faa9-a0ca-49f6-a268-1c01c31b041c@linaro.org>
Date: Mon, 22 Jan 2024 13:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: gpio: add adg1414
Content-Language: en-US
To: Kim Seer Paller <kimseer.paller@analog.com>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20240121103505.26475-1-kimseer.paller@analog.com>
 <20240121103505.26475-2-kimseer.paller@analog.com>
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
In-Reply-To: <20240121103505.26475-2-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/01/2024 11:35, Kim Seer Paller wrote:
> The ADG1414 is a 9.5 Ω RON ±15 V/+12 V/±5 V iCMOS Serially-Controlled
> Octal SPST Switches
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/gpio/gpio-adg1414.yaml           | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml b/Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml
> new file mode 100644
> index 000000000..24a51e79f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-adg1414.yaml

Filename like compatible.


> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-adg1414.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADG1414 SPST Switch Driver

"Driver" as Linux driver or some hardware driver?

> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description:
> +  The ADG1414 is a 9.5 Ω RON ±15 V/+12 V/±5 V iCMOS serially-controlled
> +  octal SPST switches.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adg1414
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  spi-cpha: true
> +
> +  reset-gpios:
> +    description: GPIO specifier that resets the device.

Drop description, it's obvious. You could instead say something useful,
like name of pin.

> +    maxItems: 1
> +
> +  '#daisy-chained-devices':
> +    description: The number of daisy-chained devices.
> +    default: 1
> +    minimum: 1
> +    maximum: 4

This needs to be added to dtschema or at least its type should be here.

> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +


Best regards,
Krzysztof


