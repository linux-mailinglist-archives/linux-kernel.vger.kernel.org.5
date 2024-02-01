Return-Path: <linux-kernel+bounces-47735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4861845219
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DD41C23DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FE1158D81;
	Thu,  1 Feb 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCja0pvr"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65931586E4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772895; cv=none; b=KPQiYrw3Tr1BI2GNLy9f3sb1LdnLQaX12llaeHgc6iFC7c3CEeZMA2NRuS/kAjk3Was8SPV+gvW6T9TaPBOP/RcXhyaYCwyaNbLjyAxnkoiLkYHHVdFT/ycRaKpkz5dojNPCb9ymIeNpd5qAPGpQ3K+0RRoywCi8I88SwxXk5vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772895; c=relaxed/simple;
	bh=omvxYYUVzlZlGzNuwC3pg5IItgbXs8aIOXIcPUGiF7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZrfDsH2KQvjd7C/H9ayHbncbw7i/XstTkBEaT7ha+1Ypn3QthN+WVR+4QT0FFawDf7jfBmpl0TVFPuOLA1kGBRyF4foke0DI+Gc0U9EKLV0ZU+f1n56NwA3WX+T+klrTaucHo4odKPPYJDT9ApzHYBR2QwTFVBcU/AWFGw/uiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCja0pvr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3566c0309fso67851966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706772891; x=1707377691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtV5UaZkBV/O98jA24IeLSwwKAMs6w3Dse18asYSD/s=;
        b=pCja0pvrLA9Bk+URJDOJ/apBVKszBhxV10uzzBM7viUTVPXuZIs5Lgsb19fEUhqoTp
         SZv13SuKWfD1M2wQWb4J5UUL1+h+JiR7+noLB8Cp36fjkM5K07arwu4g9P7gXOKRvCy3
         pYcaVngCrPVNBcAuTIpcc40QyNvTqh0L1cV8A6mbtLDaaX0abOa/2vZ64QNsktJc720D
         NVcFN1xUXECF1x3CT20pcI8PW8yBbJqrEgQiQz/C8W52qJb6Zvs12qN+eQEcmsTuLimv
         //MQzc8MQ8BThyovLSnTFZhKuINt3CtyQ+ohesXxX1K6u4OZvXULNoOd3hYY+JfOwsPW
         i4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706772891; x=1707377691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtV5UaZkBV/O98jA24IeLSwwKAMs6w3Dse18asYSD/s=;
        b=I7QwQEPOv7j13auhu3P8uSoBg1uZhS4pBmRP91u5d0y+Ps1W+2FXIvdBDK5GAhygpu
         PbCJtdfq+ABxdxZO3eQxGOosDoGavWaKaqe7+XPYW6qPoajSANIhVAZRzz3zzrnWHPPS
         ZLZHGHFgL38v2nZzIt4ksXKbmbzQh1f3tSNP/Ks9MOsAVsJeUTEj4OjYoZT1h+f3mrrk
         1SE1R83xeuOhbfF9vJWC0CZdBtpIUNvVHjfjs1UlXIQxSSU7EhfrqQRuzeOz8oSGk4HW
         0XIg6436kyfBt+MfVPNHFRrKKe65c1GBflIZ3Tjbi0jVeJLuVVIRAE4miV+X0It45FzE
         J5Qg==
X-Gm-Message-State: AOJu0YzbyIlpvaXrynFwDGDZICcvtb2fQk+hgViCToDUkPrmwGHmvImF
	gsWEP37woR4mBshSM2pW3BZOIfmjHA8th9l6phJfI4VfWYAZx4xZFtcCd8hhck4=
X-Google-Smtp-Source: AGHT+IEI865AQKJCC9ukvAzwdj1LCnq7rbIiaYBs0SWcbAE8pnG/riFO2ce3yzMWUPNI9ffNlnjWjg==
X-Received: by 2002:a17:906:35d8:b0:a28:ec67:185f with SMTP id p24-20020a17090635d800b00a28ec67185fmr2809335ejb.60.1706772890806;
        Wed, 31 Jan 2024 23:34:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWBYAzr1O6DzSnGY9lCpfJUuluBb6TpJN42UMf0hjku2Q/zrCF3RB2qCNxSqRERsxUwXP68SBGb0C6g+mA/Tj2YdrRX1evv8DVeXKHEJlWGbRgVLmWx09GIWVlFssKBc/WB0TG5CV++wNXfBjzTS3nT/NFNp4HTEp/gx7G89qFdVvbI0qvJwbPjYyeBVq8+SWWkXqHQ5CW90LPUXpJgXsuiV25ouRw9CWOL/xByTyjLbApqy3/8sadmmOxMIJ+swsBueewIUba6XtJ3BtbkmW6aDSYEEgYERatBFP53WTcxduTH/W3jxljtfq/rCs6H0BdjEcJNEWSQarTSTRbsld4Vo8DKekUv43N0WmzOuniIDreAvwqTiDLBxQoMEfgEpMf7Ut9c1jGmAAxmJysvFiyFo3nfh2p4mgU9p4LAf3L7wA/9Gnm/fAppYurgdtNHhQtAfcCwHLDBdROE/JgFeC33Jhf30I+I1t05i7jDnyeEFwvad09wnQKdq/G1AyWLXC+TnXhI70xy0pujG0haSpow
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id tk3-20020a170907c28300b00a35464aab3asm5732191ejc.97.2024.01.31.23.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 23:34:50 -0800 (PST)
Message-ID: <b4b2ec92-b0ad-4702-94a6-ac128181d801@linaro.org>
Date: Thu, 1 Feb 2024 08:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i2c: designware: allow fine tuning tuning waveform
 from device tree
Content-Language: en-US
To: Aahil Awatramani <aahila@google.com>, David Dillow <dillow@google.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240201044623.374389-1-aahila@google.com>
 <20240201044623.374389-2-aahila@google.com>
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
In-Reply-To: <20240201044623.374389-2-aahila@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 05:46, Aahil Awatramani wrote:
>  
> +static void i2c_parse_cnt(struct device *dev, char *prop_name, u16 *cnt)
> +{
> +	u32 tmp_cnt;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, prop_name, &tmp_cnt);
> +	if (ret)
> +		return;
> +	*cnt = tmp_cnt;
> +}
> +
>  static int dw_i2c_of_configure(struct platform_device *pdev)
>  {
>  	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> @@ -146,6 +157,15 @@ static int dw_i2c_of_configure(struct platform_device *pdev)
>  		break;
>  	}
>  
> +	i2c_parse_cnt(&pdev->dev, "i2c-scl-ss-hcnt", &dev->ss_hcnt);

Please post your DTS and post results of testing it against bindings.

Best regards,
Krzysztof


