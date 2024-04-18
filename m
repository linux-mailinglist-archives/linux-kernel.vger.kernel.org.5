Return-Path: <linux-kernel+bounces-150851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF568AA5A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538C01F21E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B956464;
	Thu, 18 Apr 2024 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlUQMRjX"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD93D64
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481582; cv=none; b=AN0fp6/uRb3YjUpNqyBZ/wmubPYmXoCEy4OFYFwnoh2z9vUt4/o0wIh2TKZe4oGfHTtnbdycVXxrenGVGB27RgIn+Lp0QvoODwD8o3KxmX/PVQR960k1krMSnd/4ksVLn2ogXIC9BOzv4gF+fv9NNJB2NjJ6BZFxho0jjZS7mYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481582; c=relaxed/simple;
	bh=RAlNXI0pZdRt1duDvMUlU016mDBq/sV73XepOv3WwSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjPQIWN3DE0g+7YazqfHnYzqrMQAubViMHNDMlqW2INtTxdoxy2UV79GItrlUKulmXr14X67r153qLJOnZADXuQiqrhj6E7OJlDe2W7YoLxv524vgb0tcBeIQRZtJ4WfK0+Sb01FW29UeRv6Xu+VxGV3GDYvPh3rMeYgMOz5Irw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zlUQMRjX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5f7a42bf0adso463416a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713481581; x=1714086381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+eBAbd5WwPqI3LEdzv+bUfvrmzrEdDodkqWSBZ40boY=;
        b=zlUQMRjXt5BPaLJQYb680eLxnIQQqwl9RmzC3K/jpvgC7u4lPVLqvBE9eEC08xGc7k
         iCrU1L+ZXxJ/WDvskexuCoScb0UdeBcDcFgCTKTo4Pv1mHvIbRtahzznCdamS9EFZo2I
         /PKK1SJFtMAaezn0YfkU4CGeNRWCQkhK/Q8d95zSsXFkQ1bJ1ZJGE4/3ojcdg0/G6LW1
         HdkK/hqFdG/iaNnPWTmPdIm/d0GkRVmZpSTXGX4gK03Abfur9W8YnX5zDOId6WBRny4c
         9lRo3gInAwrSMK4JaYyC5hysfUmtxElaaoVeDJ6tgxmiczdMPkGLty7+zpAiqIZiePn+
         31vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713481581; x=1714086381;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eBAbd5WwPqI3LEdzv+bUfvrmzrEdDodkqWSBZ40boY=;
        b=cjzRymbqymj5OasY2ZHTQJ3ZNi1S0WtzFibrb2s6KsCZP3FdimcLIaAJv7/KgW5Okc
         0Ogr+vtKuvpU8aKQdMmP/J1SaQAAMd462Ye7C35/b7c5zujj3jcD/23+e8GYdByHQitp
         DZOMA+7iwlfHBZTE5RUnwquXVOiITqb+DXxyx6Y4yLtAEF96J8T7ZZsgYWaDnEpBlXV4
         RNO1mrnjLJMt8JDhlQzd8f8GSNbWYJktpSwkFEjOfLUDR1LtDGlLEvFxI3TbCcwa7jwz
         j4loM03LIH4e3o8U5XmUrAArzovG6b6/KbpQigpLoPsJYuSveuKSlhaNiSPKdhFoucbX
         Rp+g==
X-Forwarded-Encrypted: i=1; AJvYcCUIHwiFqj2lBN9KkfCTbxzmM0qtRFw1+y50LQiKlQ1OtI8kyKxkU67dVRbcOOLhGOYGfxJCgvZBpYPxHP1TmM44yn+dKnfb2/0upEbH
X-Gm-Message-State: AOJu0YyhRxA0QvPT7ASPsq1v2IazpOVP+w2pQ5E4j0vJ4U5zxXXHHTfp
	KaUcPANrrAaM2Am/o2bHJUEOCaRFgmLcTtv6W6FRns8OGu6qqmD8MNwSyKdY4YE=
X-Google-Smtp-Source: AGHT+IHZov8Ta3j29EV4qG0fYa92F9QoQSdSDcWCBKZ2jeADxr5Zw/wAzlj+Ca9b8XiXLcf5T0rFYQ==
X-Received: by 2002:a17:90b:818:b0:2a4:f16f:f31f with SMTP id bk24-20020a17090b081800b002a4f16ff31fmr557256pjb.40.1713481580853;
        Thu, 18 Apr 2024 16:06:20 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.146])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a77c700b002a55d8a99d5sm3673136pjs.22.2024.04.18.16.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 16:06:20 -0700 (PDT)
Message-ID: <76b46467-6a27-4f07-8a3e-cdd51e2e28bb@linaro.org>
Date: Fri, 19 Apr 2024 01:06:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panel: panel-simple: Add generic panel-dsi driver
To: Johan Adolfsson <johan.adolfsson@axis.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@axis.com
References: <20240418-foo-fix-v1-0-461bcc8f5976@axis.com>
 <20240418-foo-fix-v1-1-461bcc8f5976@axis.com>
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
In-Reply-To: <20240418-foo-fix-v1-1-461bcc8f5976@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 16:01, Johan Adolfsson wrote:
> Add generic panel-dsi panel, similar to panel-dpi that can have it's
> timing, lanes and flags overridden by devicetree.
> Add some dev_err() and dev_warn() calls.
> 

..

>  		/* sentinel */
>  	}
> @@ -4992,17 +5051,28 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
>  		return -ENODEV;
>  
>  	err = panel_simple_probe(&dsi->dev, &desc->desc);
> +	if (err)
> +		dev_err(&dsi->dev, "%s: err %i\n", __func__, err);

This looks like debugging code.

> +
> +	if (desc == &panel_dsi) {
> +		struct panel_simple *panel = mipi_dsi_get_drvdata(dsi);
> +		/* Handle the generic panel-dsi binding */
> +		err = panel_dsi_probe(&dsi->dev, panel);
> +	}
> +
>  	if (err < 0)
>  		return err;
>  
>  	dsi->mode_flags = desc->flags;
>  	dsi->format = desc->format;
>  	dsi->lanes = desc->lanes;
> +	of_property_read_u32(dsi->dev.of_node, "lanes", &dsi->lanes);

Is this defined in the binding?

>  
>  	err = mipi_dsi_attach(dsi);
>  	if (err) {
>  		struct panel_simple *panel = mipi_dsi_get_drvdata(dsi);
>  
> +		dev_err(&dsi->dev, "probe attach err: %i", err);

Do not introduce unrelated code changes.

Best regards,
Krzysztof


