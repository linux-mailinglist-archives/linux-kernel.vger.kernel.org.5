Return-Path: <linux-kernel+bounces-38100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352CC83BAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA0DB24F19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EA312E5C;
	Thu, 25 Jan 2024 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PB6zL286"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D012E48
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168782; cv=none; b=WjxIb+W2Zx4Q0HZ8DLqIredY5wMEUPfi7Kyc+av6Sp/31CGRtTzfVTOEeRCVgGd2QyRQi/kz/JUYlg7bZHFpinM2H53IAtUs2oClQ4Mjx46EHYey8114Y1eRoALXmusq55gwWSfh7M0UrAWnLuRYlG63ZO9+mP4VBgpJz6QR31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168782; c=relaxed/simple;
	bh=lq3Qw18a0IYvMyc7eMwCvEMPKYqJuwapZWYaFsLvWEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7klGNfP6vSK+C1KoCAM7nTXciczcyQgZoOkkQQnWBtqRX37JquTkJmfZSggM0seW40Y4wFTP/RCpZb2bo8GT07iT6E0De8AgK20DMC1WMHe2z7ApCBKexQmZBknCH++hYTxCNNYqJsXRtWWV9rAkRXaOkF8VkY/W8SqsNR4hRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PB6zL286; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51005675963so4312376e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706168774; x=1706773574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLJ9hqRNdMmwKJi2pdcZAjFZNSmuS+g91IU0KUQzJ4k=;
        b=PB6zL286iBiUhYeRv81OB78ldIRDuEB8X6HSjo9DpDpMDCaE53Ep5IJ+2ARzhilDY+
         fYTb4sSFLxRkCudaA7M9I53dczs0YoAwOzsiRTyGJ7MUoHGBdO9XZPbQVymE+PUAlTeK
         7wJhZoGy2sZ0I2XfKPdAYr/2NKw9z3suL7PsVg0zaOG133m1DdROHoq/0xUVqt4SWuok
         xiid4vM/6n9E8smkUjm6bCO5wtR3zKJY1QqXfa4Ly8GWvsfsWGKjQVEcCedE5DIm+aOp
         gq3Of1EBmdiu+I1aYsewGST+a6FZqKXJAIzhgRdvvbJPNZbRKzVOtp0tasI1cjizBQn8
         H2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706168774; x=1706773574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLJ9hqRNdMmwKJi2pdcZAjFZNSmuS+g91IU0KUQzJ4k=;
        b=YLBnLiaZGRp7NPKDKnaSGX3V8adaXzQ52CzrAlLUH8n3lmMqHsSjP3XJ9T/jsgJjqa
         3DDsfjKObn84Yg4mniJT5SlrPNEVeTL923e8y38BtIAZstY2sKVqv/1QRLYKJAZ8xlDu
         vzrZJlpKqWwzFTxDiQJ6JMRz2oRTZ8B6tRZx9NVgppqRiM7NA8SmRI+oVL0XtoQmtCXK
         h3gJzm6WXoEEE3NSLjJKovZ3St4gY1jLvr/wGTfy4Hy7tJtxPx3RW7V8vtZQpt0FC5k2
         RgM1y457IT8/c/+z765E7BgtGsz4lYwdXz+Q1vDzgRX5wrRa9WmNWKpUAzuEyb63MZ13
         KNaw==
X-Gm-Message-State: AOJu0YxWb/I7NnQJXInxjLEUANTwK9m1AND9f30HIxXxMY8HPvCw4PUY
	jDN0eKmvJbM5mOmDqWKjlac3rCSU4gId3DuYdnKZKlXxDfSy8u9IqiQgLqrFw5Q=
X-Google-Smtp-Source: AGHT+IElj6u1gYVFw2VudyXs/G3iQmkA0PqkWOzKELx42H3hiRqiA5lm303AXC7IlvG0UNt7FxRz+w==
X-Received: by 2002:a19:f816:0:b0:50e:b19d:c992 with SMTP id a22-20020a19f816000000b0050eb19dc992mr145487lff.197.1706168774376;
        Wed, 24 Jan 2024 23:46:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id k8-20020a056402048800b0055d0a05b1bbsm114114edv.5.2024.01.24.23.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:46:13 -0800 (PST)
Message-ID: <001993b9-ea0c-49c3-a4e5-4cea10c54082@linaro.org>
Date: Thu, 25 Jan 2024 08:46:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/17] clk: eyeq5: add platform driver
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-8-392b010b8281@bootlin.com>
 <127fd51b-cd64-4e00-99d6-7be9b79f2dcc@linaro.org>
 <CYN33YJ10HYS.2YDXB158LFZPL@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CYN33YJ10HYS.2YDXB158LFZPL@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/01/2024 17:41, Théo Lebrun wrote:
> Hello,
> 
> On Wed Jan 24, 2024 at 8:05 AM CET, Krzysztof Kozlowski wrote:
>> On 23/01/2024 19:46, Théo Lebrun wrote:
>>> Add the Mobileye EyeQ5 clock controller driver. It might grow to add
>>> support for other platforms from Mobileye.
>>>
>>> It handles 10 read-only PLLs derived from the main crystal on board. It
>>> exposes a table-based divider clock used for OSPI. Other platform
>>> clocks are not configurable and therefore kept as fixed-factor
>>> devicetree nodes.
>>>
>>> Two PLLs are required early on and are therefore registered at
>>> of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
>>> UARTs.
>>>
>>
>>
>>> +#define OLB_PCSR1_RESET				BIT(0)
>>> +#define OLB_PCSR1_SSGC_DIV			GENMASK(4, 1)
>>> +/* Spread amplitude (% = 0.1 * SPREAD[4:0]) */
>>> +#define OLB_PCSR1_SPREAD			GENMASK(9, 5)
>>> +#define OLB_PCSR1_DIS_SSCG			BIT(10)
>>> +/* Down-spread or center-spread */
>>> +#define OLB_PCSR1_DOWN_SPREAD			BIT(11)
>>> +#define OLB_PCSR1_FRAC_IN			GENMASK(31, 12)
>>> +
>>> +static struct clk_hw_onecell_data *eq5c_clk_data;
>>> +static struct regmap *eq5c_olb;
>>
>> Drop these two. No file-scope regmaps for drivers. Use private container
>> structures.
> 
> I wouldn't know how to handle the two steps then. Two clocks and the clk
> provider are registered at of_clk_init() using CLK_OF_DECLARE_DRIVER().

Right, if some clocks have to be early, CLK_OF_DECLARE_DRIVER needs
static ones. But your commit subject says it is a platform driver and
all other pieces of this code is rather incompatible with this approach.

Do not use CLK_OF_DECLARE_DRIVER for cases where you have dependencies
because it forces you to manually order initcalls, which is exactly what
we do not want.


> The rest is at platform device probe. Without a static, there are no
> way to pass the struct clk_hw_onecell_data from one to the other.
> 
> I've looked at all clock drivers that do CLK_OF_DECLARE_DRIVER() and
> register a platform driver.

Even though the code is correct, using arguments "other did it" will not
work. You want to say that you implement legacy, poor code because you
saw legacy, poor code?

> 
>  - The following use a static variable:
>    drivers/clk/axis/clk-artpec6.c
>    drivers/clk/clk-aspeed.c
>    drivers/clk/clk-ast2600.c
>    drivers/clk/clk-eyeq5.c
>    drivers/clk/clk-gemini.c
>    drivers/clk/clk-milbeaut.c
>    drivers/clk/mediatek/clk-mt2701.c
>    drivers/clk/mediatek/clk-mt6797.c
>    drivers/clk/mediatek/clk-mt8173-infracfg.c
>    drivers/clk/nxp/clk-lpc18xx-creg.c
>    drivers/clk/ralink/clk-mt7621.c
>    drivers/clk/ralink/clk-mtmips.c
>    drivers/clk/sunxi/clk-mod0.c
>    drivers/clk/axis/clk-artpec6.c
> 
>  - Those two declare different clock providers at init and probe:
>    drivers/clk/ralink/clk-mt7621.c
>    drivers/clk/sunxi/clk-mod0.c
> 
>  - It doesn't register new clocks at probe (only resets) so no need to
>    share variables.
>    drivers/clk/ralink/clk-mtmips.c
> 
>>
>> ...
>>
>>> +static void __init eq5c_init(struct device_node *np)
>>> +{
>>> +	struct device_node *parent_np = of_get_parent(np);
>>> +	int i, ret;
>>> +
>>> +	eq5c_clk_data = kzalloc(struct_size(eq5c_clk_data, hws, EQ5C_NB_CLKS),
>>> +				GFP_KERNEL);
>>> +	if (!eq5c_clk_data) {
>>> +		ret = -ENOMEM;
>>> +		goto err;
>>> +	}
>>> +
>>> +	eq5c_clk_data->num = EQ5C_NB_CLKS;
>>> +
>>> +	/*
>>> +	 * Mark all clocks as deferred. We register some now and others at
>>> +	 * platform device probe.
>>> +	 */
>>> +	for (i = 0; i < EQ5C_NB_CLKS; i++)
>>> +		eq5c_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
>>> +
>>> +	/*
>>> +	 * Currently, if OLB is not available, we log an error, fail init then
>>
>> How it could be not available? Only with broken initcall ordering. Fix
>> your initcall ordering and then simplify all this weird code.
> 
> of_syscon_register() and regmap_init_mmio() lists many reasons for
> it to not be available. Am I missing something?

Yes, initcall ordering.

Best regards,
Krzysztof


