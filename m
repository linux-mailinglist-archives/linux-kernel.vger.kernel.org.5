Return-Path: <linux-kernel+bounces-67524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCD2856CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126A9291D09
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9BB139593;
	Thu, 15 Feb 2024 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7U++Ash"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880C2595
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022197; cv=none; b=iZZM4g3+mVmI6MqGzPSa5NBTczWflDHB6m8QzowFd9XiIQWgr+wA8OAaZUs3T79I5kV3MfRPfIRg1rUlNz/eowGxkthrJOAXsBYqTDW4OV26MJnup2komiErAIhrDEi6jc3XuNg80KQ9FjctkMKT7pXaESygMFdFI78BSD9ZGSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022197; c=relaxed/simple;
	bh=Gn0i2K5ZrM1sl3Jl5UwO73GZta57NAtNJ5z/r5z/wbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yps/otXJL9jP+1Y8lv43x6clRdJtWVR1jW9nq+YA90JOD5L0kb1ABEwOiJC1DZfkuvIOD0lKeefGnleU3uxZ3TlKK+UNdotmCx3oHyVfxm21QS12EIohdTbNHA5+Nr77B7HYZXJmoBuI3y4h+BOtELx61YwSwGa24O3evDtYKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7U++Ash; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511acd26befso1483154e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708022192; x=1708626992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xGVX1wPQK+wyPOlhm2+iM5IPHVEiOSE8bOIKkqHbYvg=;
        b=J7U++Ash38OZmspquIUsgz6MyyK2GV/S3JEGfHTm9Sfkmk4vjYt7I6a54m0JgUdbbU
         SgUeq9FyZk4DXwEdmf+f0DnDR0mS0vYND/eZcWU75bLNGJZrAShTiPLe88UbNj8Tn7HM
         3W1iTy8qrWWlis2Eiui/O/AJGX4KmrmstMGfKx54kzptoxCJpxYVbyeL6K7+gcx1qeXd
         xxicE8GAJyUuhveqC/M3Jig4Fz4qW2vUZyDbiceYWXUNHADo+QM8C6sXn/cnMc5O9LLO
         +eo4QnzEoTyZBwgeO+ov2GsMMmtxKtLBlJhBb8dRfj03pIg6X/7QXGqRhup9OED4J+oy
         LwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022192; x=1708626992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGVX1wPQK+wyPOlhm2+iM5IPHVEiOSE8bOIKkqHbYvg=;
        b=mOBrtAHflhRHa1VGNeMkfHVTwBNr7pJ7bzjY3ZCiawneMVyNCM1ZuiDjx3nEV9bK/s
         RoR9YFgHDdYWhHsw+ciFU1Ra11oneoyHhytpGifX5zHnL1SLVUseIDVw2o+Hixmvoy1a
         0gkUNGwrU71D6BHLBLUMGipbbwDEbVXgjl6k+0JgsEEWW96sWbixBeWdDT79NxO6X1Oq
         i+k0i9cQxk4ATcMeo4fNrxGmtW7n6RyywZM8FT8ASKkiTQ/pVulFL5IGXVCo6QbsHnKo
         JMzR/RjUxMzBiY2kZkuGNFLIzquJH2duoRCvW/K/fp7QkcEQ+KMhsko8obdFH1R8omRm
         LMFw==
X-Forwarded-Encrypted: i=1; AJvYcCW6HkUdf3Z6YJTdvM18byPgkn8GxEwu797ry+YBA3rnmqm7xPQv3JS0dnWH2tF93evchVWF/ZDtBqekfWzeSXARdgyn+Wv/GnynEXTa
X-Gm-Message-State: AOJu0YzEG0NQ0ExHZJktnIVu2dOOnXsvx43f8TMxNRqDZMtGZk86IiUW
	xCgHCy1eOZZiu9OySRjMKAHsiE8scfPX8WUpM+jli40RqE6VxfgbrhA3B4WXcLc=
X-Google-Smtp-Source: AGHT+IGQASE+VxssNf1wDM3sdLO1rUDNcmEVuadsj6QdJFeQEQYtw6KxkfgD718KPOiRjpyuKg3o/A==
X-Received: by 2002:a05:6512:526:b0:511:944f:de5b with SMTP id o6-20020a056512052600b00511944fde5bmr2198653lfc.38.1708022192294;
        Thu, 15 Feb 2024 10:36:32 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id h9-20020a0565123c8900b005128e245388sm63859lfv.29.2024.02.15.10.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 10:36:31 -0800 (PST)
Message-ID: <ab1f9285-73ba-4b69-8882-0cf08c508e28@linaro.org>
Date: Thu, 15 Feb 2024 19:36:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
 linux@roeck-us.net, wim@linux-watchdog.org, alim.akhtar@samsung.com,
 jaewon02.kim@samsung.com, semen.protsenko@linaro.org
Cc: alexey.klimov@linaro.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, saravanak@google.com,
 willmcvicker@google.com, linux-fsd@tesla.com,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20240208161700.268570-1-peter.griffin@linaro.org>
 <20240208161700.268570-2-peter.griffin@linaro.org>
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
In-Reply-To: <20240208161700.268570-2-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/02/2024 17:16, Peter Griffin wrote:
> Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> security hardening reasons so that they are only write accessible in el3
> via an SMC call.
> 
> As most Exynos drivers that need to write PMU registers currently obtain a
> regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
> is implemented in this driver using a custom regmap similar to syscon to
> handle the SMC call. Platforms that don't secure PMU registers, get a mmio
> regmap like before. As regmaps abstract out the underlying register access
> changes to the leaf drivers are minimal.
> 
> A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> that currently use syscon_regmap_lookup_by_phandle(). This also handles
> deferred probing.

I found an issue, which needs new version, so I also found few more nits.

> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> Changes since v3:
>  - Fix PMUALIVE_MASK
>  - Add TENSOR_ prefix
>  - clear SET_BITS bits on each loop iteration
>  - change set_bit to set_bits in func name
>  - Fix some alignment
>  - Add missing return on dev_err_probe
>  - Reduce indentation in loop
> 
> Changes since v2
>  - Add select REGMAP to Kconfig
>  - Add constant for SET/CLEAR bits
>  - Replace kerneldoc with one line comment
>  - Fix kerneldoc for EXPORT_SYMBOL_GPL funcs
>  - remove superfluous extern keyword
>  - dev_err_probe() on probe error
>  - shorten regmcfg name
>  - no compatibles inside probe, use match data
>  - don't mix declarations with/without initializations
>  - tensor_sec_reg_read() use mmio to avoid access restrictions
>  - Collect up Reviewed-by
>  - const for regmap_config structs
> ---
>  drivers/soc/samsung/Kconfig            |   1 +
>  drivers/soc/samsung/exynos-pmu.c       | 235 ++++++++++++++++++++++++-
>  drivers/soc/samsung/exynos-pmu.h       |   1 +
>  include/linux/soc/samsung/exynos-pmu.h |  11 +-
>  4 files changed, 243 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 27ec99af77e3..1a5dfdc978dc 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -42,6 +42,7 @@ config EXYNOS_PMU
>  	depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
>  	select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
>  	select MFD_CORE
> +	select REGMAP_MMIO
>  
>  # There is no need to enable these drivers for ARMv8
>  config EXYNOS_PMU_ARM_DRIVERS
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 250537d7cfd6..b846e343fcdd 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -5,6 +5,7 @@
>  //
>  // Exynos - CPU PMU(Power Management Unit) support
>  
> +#include <linux/arm-smccc.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/mfd/core.h>
> @@ -12,19 +13,132 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>  #include <linux/soc/samsung/exynos-pmu.h>
>  
>  #include "exynos-pmu.h"
>  
> +#define PMUALIVE_MASK			GENMASK(13, 0)
> +#define TENSOR_SET_BITS			(BIT(15) | BIT(14))
> +#define TENSOR_CLR_BITS			BIT(15)
> +#define TENSOR_SMC_PMU_SEC_REG		0x82000504
> +#define TENSOR_PMUREG_READ		0
> +#define TENSOR_PMUREG_WRITE		1
> +#define TENSOR_PMUREG_RMW		2
> +
>  struct exynos_pmu_context {
>  	struct device *dev;
>  	const struct exynos_pmu_data *pmu_data;
> +	struct regmap *pmureg;
>  };
>  
>  void __iomem *pmu_base_addr;
>  static struct exynos_pmu_context *pmu_context;
> +/* forward declaration */
> +static struct platform_driver exynos_pmu_driver;
> +
> +/*
> + * Tensor SoCs are configured so that PMU_ALIVE registers can only be written
> + * from EL3, but are still read accessible. As Linux needs to write some of
> + * these registers, the following functions are provided and exposed via
> + * regmap.
> + *
> + * Note: This SMC interface is known to be implemented on gs101 and derivative
> + * SoCs.
> + */
> +
> +/* Write to a protected PMU register. */
> +static int tensor_sec_reg_write(void *base, unsigned int reg, unsigned int val)

Please use the same argument names in all these regmap functions as in
struct regmap_config, so base->context

> +{
> +	struct arm_smccc_res res;
> +	unsigned long pmu_base = (unsigned long)base;
> +
> +	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
> +		      TENSOR_PMUREG_WRITE, val, 0, 0, 0, 0, &res);
> +
> +	/* returns -EINVAL if access isn't allowed or 0 */
> +	if (res.a0)
> +		pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0);
> +
> +	return (int)res.a0;
> +}
> +
> +/* Read/Modify/Write a protected PMU register. */
> +static int tensor_sec_reg_rmw(void *base, unsigned int reg,
> +			      unsigned int mask, unsigned int val)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long pmu_base = (unsigned long)base;
> +
> +	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
> +		      TENSOR_PMUREG_RMW, mask, val, 0, 0, 0, &res);
> +
> +	/* returns -EINVAL if access isn't allowed or 0 */
> +	if (res.a0)
> +		pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0);
> +
> +	return (int)res.a0;
> +}
> +
> +/*
> + * Read a protected PMU register. All PMU registers can be read by Linux.
> + * Note: The SMC read register is not used, as only registers that can be
> + * written are readable via SMC.
> + */
> +static int tensor_sec_reg_read(void *base, unsigned int reg, unsigned int *val)
> +{
> +	*val = pmu_raw_readl(reg);
> +	return 0;
> +}
> +
> +/*
> + * For SoCs that have set/clear bit hardware this function can be used when
> + * the PMU register will be accessed by multiple masters.
> + *
> + * For example, to set bits 13:8 in PMU reg offset 0x3e80
> + * tensor_set_bits_atomic(ctx, 0x3e80, 0x3f00, 0x3f00);
> + *
> + * Set bit 8, and clear bits 13:9 PMU reg offset 0x3e80
> + * tensor_set_bits_atomic(0x3e80, 0x100, 0x3f00);
> + */
> +static inline int tensor_set_bits_atomic(void *ctx, unsigned int offset,

Usual practice is to rely on compiler to inline, so let's drop the
keyword here.

> +					 u32 val, u32 mask)
> +{
> +	int ret;
> +	unsigned int i;
> +
> +	for (i = 0; i < 32; i++) {
> +		if (!(mask & BIT(i)))
> +			continue;
> +
> +		offset &= ~TENSOR_SET_BITS;
> +
> +		if (val & BIT(i))
> +			offset |= TENSOR_SET_BITS;
> +		else
> +			offset |= TENSOR_CLR_BITS;
> +
> +		ret = tensor_sec_reg_write(ctx, offset, i);
> +		if (ret)
> +			return ret;
> +	}
> +	return ret;
> +}
> +
> +static int tensor_sec_update_bits(void *ctx, unsigned int reg,
> +				  unsigned int mask, unsigned int val)
> +{
> +	/*
> +	 * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF)
> +	 * as the target registers can be accessed by multiple masters.
> +	 */
> +	if (reg > PMUALIVE_MASK)
> +		return tensor_sec_reg_rmw(ctx, reg, mask, val);
> +
> +	return tensor_set_bits_atomic(ctx, reg, val, mask);
> +}
>  
>  void pmu_raw_writel(u32 val, u32 offset)
>  {
> @@ -75,11 +189,41 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>  #define exynos_pmu_data_arm_ptr(data)	NULL
>  #endif
>  
> +static const struct regmap_config regmap_smccfg = {
> +	.name = "pmu_regs",
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.reg_read = tensor_sec_reg_read,
> +	.reg_write = tensor_sec_reg_write,
> +	.reg_update_bits = tensor_sec_update_bits,

> +};
> +
> +static const struct regmap_config regmap_mmiocfg = {
> +	.name = "pmu_regs",
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};
> +
> +static const struct exynos_pmu_data gs101_pmu_data = {
> +	.pmu_secure = true
> +};
> +
>  /*
>   * PMU platform driver and devicetree bindings.
>   */
>  static const struct of_device_id exynos_pmu_of_device_ids[] = {
>  	{
> +		.compatible = "google,gs101-pmu",
> +		.data = &gs101_pmu_data,
> +	}, {
>  		.compatible = "samsung,exynos3250-pmu",
>  		.data = exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
>  	}, {
> @@ -113,19 +257,73 @@ static const struct mfd_cell exynos_pmu_devs[] = {
>  	{ .name = "exynos-clkout", },
>  };
>  
> +/**
> + * exynos_get_pmu_regmap() - Obtain pmureg regmap
> + *
> + * Find the pmureg regmap previously configured in probe() and return regmap
> + * pointer.
> + *
> + * Return: A pointer to regmap if found or ERR_PTR error value.
> + */
>  struct regmap *exynos_get_pmu_regmap(void)
>  {
>  	struct device_node *np = of_find_matching_node(NULL,
>  						      exynos_pmu_of_device_ids);
>  	if (np)
> -		return syscon_node_to_regmap(np);
> +		return exynos_get_pmu_regmap_by_phandle(np, NULL);
>  	return ERR_PTR(-ENODEV);
>  }
>  EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
>  
> +/**
> + * exynos_get_pmu_regmap_by_phandle() - Obtain pmureg regmap via phandle
> + * @np: Pointer to device's Device Tree node

A bit unusual naming... drop "Device Tree" anywhere here. This is:
"device node holding PMU phandle property"


> + * @property: Device Tree property name which references the pmu

Name of property holding a phandle value

> + *
> + * Find the pmureg regmap previously configured in probe() and return regmap
> + * pointer.
> + *
> + * Return: A pointer to regmap if found or ERR_PTR error value.
> + */
> +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> +						const char *property)

property -> propname

> +{
> +	struct device *dev;
> +	struct exynos_pmu_context *ctx;
> +	struct device_node *pmu_np;

Reversed christmass tree.

> +
> +	if (property)
> +		pmu_np = of_parse_phandle(np, property, 0);
> +	else
> +		pmu_np = np;
> +
> +	if (!pmu_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	/*
> +	 * Determine if exynos-pmu device has probed and therefore regmap
> +	 * has been created and can be returned to the caller. Otherwise we
> +	 * return -EPROBE_DEFER.
> +	 */
> +	dev = driver_find_device_by_of_node(&exynos_pmu_driver.driver,
> +					    (void *)pmu_np);
> +
> +	of_node_put(pmu_np);

You are dropping now referencen from np when property==NULL. This does
no look right.

> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	ctx = dev_get_drvdata(dev);
> +
> +	return ctx->pmureg;
> +}
> +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> +
>  static int exynos_pmu_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct regmap_config pmu_regmcfg;
> +	struct regmap *regmap;
> +	struct resource *res;
>  	int ret;
>  
>  	pmu_base_addr = devm_platform_ioremap_resource(pdev, 0);
> @@ -133,13 +331,42 @@ static int exynos_pmu_probe(struct platform_device *pdev)
>  		return PTR_ERR(pmu_base_addr);
>  
>  	pmu_context = devm_kzalloc(&pdev->dev,
> -			sizeof(struct exynos_pmu_context),
> -			GFP_KERNEL);
> +				   sizeof(struct exynos_pmu_context),
> +				   GFP_KERNEL);

Not related here. You could have separate patch for cleanups or just
skip such change.


>  	if (!pmu_context)
>  		return -ENOMEM;
> -	pmu_context->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +

Best regards,
Krzysztof


