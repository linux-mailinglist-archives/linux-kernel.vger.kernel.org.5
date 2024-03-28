Return-Path: <linux-kernel+bounces-122687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A2A88FB6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475A71C29350
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E690657BE;
	Thu, 28 Mar 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCaruzJJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28756168C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618053; cv=none; b=sGC3Ki9/p9YoA2IbxFbaF5+oW8QdL9AILHRfdpanZz9g91hXmObG3PR80UiMNMH71v2WjvzKR/WogN0AsKExRdTLxcZGyUqtcHwJpIoFSda576W63ynyrrKcVyTKYhj7iKS+ZBN85dcjt0EgNu3O3dbJNF5rIFQ5S2htFO4LT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618053; c=relaxed/simple;
	bh=MHbH5zm+12fNT184APGqNsU6vcHt53p4t8DhY6V+kRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIUKmFxYgOMuqBF3avWDF44i4d9rpdU/mro90Y1QHJAXdQYx/EWrV+OtyTp9fl8Iq75VXec/gw9XaCrYZ5OzNyNwq+ac5vnitKgrg5SptwiAQ0MzYLgMwJja3n7keVV/n2OIPZrQ4LbvkjlSrYloP03V8Z+HqF7NCrLeKlckyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SCaruzJJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-415447b16aaso3061065e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711618050; x=1712222850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCwjcER/lMJ/fJPO7Gp+tSLutjiwq6IKrQ3AJQk8T88=;
        b=SCaruzJJSh6g/A/kmujL70AOzuqogHuwyF3penpms0zVLbkXOaf+ym2+1LN3UgdAWF
         WHaabLPjhOucSe7UsUam9vD3WnJH0vyoIxx3DfQ5NWYqg+EI9/GAxjSDR1Yzn4yFSOcH
         4np4oqmR0a0oPOTRSN+zcz6yjCnKu7ytU1Jloa75eXq6tSNnOUR7Dx0Zaeco57nTGEI/
         xxjz7yBKXuGGecCrOd48361ho1YzSz3Q4IzTedqMoVD4WBu+o2qHhn5kXZq7RfFl+3Nh
         RVuplQwTT4QQgieplLVqfg9u89AVCRByHgV+3rW2EILQe9jDz2cReo0r9T/eqdFWdDvQ
         DfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618050; x=1712222850;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCwjcER/lMJ/fJPO7Gp+tSLutjiwq6IKrQ3AJQk8T88=;
        b=a6cYS8m5IAFD5o+tRdcWTX6tTkeEiufVcl8dxMmLO9ZuV/WejiWRXl5GOKX23xuWOI
         hYhUCkQqL1qOv+1F6oa2wmRgeIQFpKW/AHU6CAFhiAKHNIE2GnMN79tGZch1vdiSPmhJ
         oZFh/57b7YlExFw/9ljBGkwIGgdNjASqaa7gYn9XIhOZFS8nLELXZJo+PrjtnfmMappl
         1mukm9e1hOBbXcObw8g+QwjVDNTwNfwQMnaE01azTK/xV+OoAzDHtl5S0VgOIWUtazur
         QRaOc9y1Cs5HkWVbgcZKZcdPpdhAIOqtHyIW39hnxSpzVCOwKch8AYPXGCQpBXG75aeW
         8+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV7wABn5cW8TqjCYp6kzRodK1k+RSvZDTFmmMYF/DrVtQ5LKUqnpdbLeXev/ja/YKarTdhmjxb64xzjXa7GW/dWiSo2eN2wOa896Lhm
X-Gm-Message-State: AOJu0Yy0Ezd1O8NN6ZhTbePI+R31fnrMssySQdFBqf+xd6MBAw4YNU80
	7TPudzK0iUBdCiQsyiddO542RHnDW8C6tnqBYqmAGoBIv2VdpSrfngztV5UkvZdgWbh7WcBnUj+
	x
X-Google-Smtp-Source: AGHT+IHeKH8wdzSZ0gji+t41MwP2jcRa+dmZzD3lCw7OXtzEirBVepFnHGyavETjRCLea3YJ1/jpIw==
X-Received: by 2002:a05:600c:3b9d:b0:415:475c:28da with SMTP id n29-20020a05600c3b9d00b00415475c28damr535950wms.0.1711618050326;
        Thu, 28 Mar 2024 02:27:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.148])
        by smtp.gmail.com with ESMTPSA id j29-20020a05600c1c1d00b0041493a93cc5sm1717044wms.2.2024.03.28.02.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:27:29 -0700 (PDT)
Message-ID: <f96e14dd-a570-47e9-ad92-b71cfc2c494e@linaro.org>
Date: Thu, 28 Mar 2024 10:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: hsi: hsi-client: convert to YAML
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327-hsi-dt-binding-v2-0-110fab4c32ae@collabora.com>
 <20240327-hsi-dt-binding-v2-1-110fab4c32ae@collabora.com>
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
In-Reply-To: <20240327-hsi-dt-binding-v2-1-110fab4c32ae@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 20:11, Sebastian Reichel wrote:
> Convert the legacy txt binding to modern YAML and rename from
> client-devices to hsi-client. Also the example got dropped,
> since this is a shared schema. No semantic change in the binding
> itself.
> 

..

> +allOf:
> +  - if:
> +      required:
> +        - hsi-mode
> +    then:
> +      properties:
> +        hsi-rx-mode: false
> +        hsi-tx-mode: false
> +  - if:
> +      required:
> +        - hsi-rx-mode
> +    then:
> +      properties:
> +        hsi-mode: false

Why do you still have this allOf? The point I was trying to make last
time, was that all your efforts to mutually exclude these properties can
be achieved with that one simple oneOf. That's why I linked you other
schemas as an example how to achieve this.

Could be that I miss here something, so why do you exactly need this allOf?

Best regards,
Krzysztof


