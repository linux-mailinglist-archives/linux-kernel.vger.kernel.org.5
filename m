Return-Path: <linux-kernel+bounces-36533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7CC83A2A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B976B23BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0262316428;
	Wed, 24 Jan 2024 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBpEhQrr"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927A1428F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079944; cv=none; b=XHLShRnFdBgpyKHmUDS+Lr9tQa+MWCmzP7v51YUAwrVUHoeKB4O6XRkIJysIdmbKtJjnsNrWbrj/EVm2J3pjArhy7ksd/GU3/ZJbPTjoOnV8vIdteFI26/nElRBCvX2p5VHb+C18E6En+WBmsKLnSH9JN6sJRtsNWbONlgiZf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079944; c=relaxed/simple;
	bh=Zj5tnw4jopb0rTKmkovPBqBq8nwSE/xJiBlkRKTkq6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=US2AipmguYCsBIfkDAMbXRyNBbZ6I4eG3lphe00L4TH4SfruVCAUUhqnr+9msEriDEPupxbdd9OOdCdbU0kXbHPGHU56tCxqNVgRCoVMPBSGFJdmZzn6t0JcEmW4VeQbo5gD1U7mMpk+vQyOMRUKUlZqLVMktJPr1VVMnINkJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PBpEhQrr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a86795a3bso5025684a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706079941; x=1706684741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNh642ztM9/JIoi6gRH/DDCNqKXOoK1COb5sZK4/5nY=;
        b=PBpEhQrrHgi9HZbnr5XsKmpdB6EmsDrwEhXugKSQSvPDEymgxdMb1hzpatiKdvNalY
         h9LQ2NQLCwQRivcUMRchKwFxTot75840OcR3CxszpH9K3V0utr6vMXaCh4JMC3t5AUFG
         jr1btrg4RXgEbu9/f/HobYIj7DRMPb752D6ZtLdCf79RuKhB/zpjS53NeyVxwujSPl9Y
         JIOKRc3sMRMFBNmgBb97OrXh3MQ8MhxqiFrgdE+MEf5XwWaerCBItbdi1XOsWC2c1y9R
         Q0ds+LouvdV+iOOcuvQYqCHqN3Vqkxd49IZ//D9MM6buxd/UJOI2lH21izgNcvSQFwnp
         k7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079941; x=1706684741;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNh642ztM9/JIoi6gRH/DDCNqKXOoK1COb5sZK4/5nY=;
        b=s66f1qpf0kpjgbdpxg2JkiBRxbvjJiVDsIivkLRWP/z7PqmXVkkQlvEQ+lR9/vhpdz
         vqT0EcQGj5lX3cmNO0oskiZ6SEyQawtBxdLtYCKVKgr3uv46lkGofhJ6GMf9MYly678z
         46VUN7Q6IwjXg45MSdrqi/rfOIXB3CwG0BDW1EzGcbPlys8ZJNFzF9ZWPxf0ZwIRCrAn
         3AMT2UU2joWhrjFmsGSBMOHn54sFyPdWWxgpYAdBe+RfhVDJJL9HOK7BSW41IEquuK0R
         +GVkrcbxiA8RLexoNY6Tsor48esgAf7Gl8TtJsqyKQz8CqkQOdlM9PwnKIInrhHgF3Sm
         CIRg==
X-Gm-Message-State: AOJu0Yx0pvy1Q5GqS7cORcEk5IoqxGeMQtNK/YZXiMUa68gjgrHlTyia
	FYEehKJ7Nn34+TrhR7rEiDenaY+FipIfNEce77t1IY08L2H61v7uKCXYM1FdA5Q=
X-Google-Smtp-Source: AGHT+IE+B/bzZTkN3YO9vqMT1INobm1x/DmdeR4af9NrfWeqRBgmTbxK71v+Fgo6vHAYR38oOWNrKg==
X-Received: by 2002:a05:6402:1358:b0:55c:ccd4:7cc3 with SMTP id y24-20020a056402135800b0055cccd47cc3mr81823edw.49.1706079940797;
        Tue, 23 Jan 2024 23:05:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id ch27-20020a0564021bdb00b0055c4a251205sm2823463edb.90.2024.01.23.23.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 23:05:39 -0800 (PST)
Message-ID: <127fd51b-cd64-4e00-99d6-7be9b79f2dcc@linaro.org>
Date: Wed, 24 Jan 2024 08:05:37 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240123-mbly-clk-v3-8-392b010b8281@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 19:46, Théo Lebrun wrote:
> Add the Mobileye EyeQ5 clock controller driver. It might grow to add
> support for other platforms from Mobileye.
> 
> It handles 10 read-only PLLs derived from the main crystal on board. It
> exposes a table-based divider clock used for OSPI. Other platform
> clocks are not configurable and therefore kept as fixed-factor
> devicetree nodes.
> 
> Two PLLs are required early on and are therefore registered at
> of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
> UARTs.
> 


> +#define OLB_PCSR1_RESET				BIT(0)
> +#define OLB_PCSR1_SSGC_DIV			GENMASK(4, 1)
> +/* Spread amplitude (% = 0.1 * SPREAD[4:0]) */
> +#define OLB_PCSR1_SPREAD			GENMASK(9, 5)
> +#define OLB_PCSR1_DIS_SSCG			BIT(10)
> +/* Down-spread or center-spread */
> +#define OLB_PCSR1_DOWN_SPREAD			BIT(11)
> +#define OLB_PCSR1_FRAC_IN			GENMASK(31, 12)
> +
> +static struct clk_hw_onecell_data *eq5c_clk_data;
> +static struct regmap *eq5c_olb;

Drop these two. No file-scope regmaps for drivers. Use private container
structures.

..

> +static void __init eq5c_init(struct device_node *np)
> +{
> +	struct device_node *parent_np = of_get_parent(np);
> +	int i, ret;
> +
> +	eq5c_clk_data = kzalloc(struct_size(eq5c_clk_data, hws, EQ5C_NB_CLKS),
> +				GFP_KERNEL);
> +	if (!eq5c_clk_data) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	eq5c_clk_data->num = EQ5C_NB_CLKS;
> +
> +	/*
> +	 * Mark all clocks as deferred. We register some now and others at
> +	 * platform device probe.
> +	 */
> +	for (i = 0; i < EQ5C_NB_CLKS; i++)
> +		eq5c_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +	/*
> +	 * Currently, if OLB is not available, we log an error, fail init then

How it could be not available? Only with broken initcall ordering. Fix
your initcall ordering and then simplify all this weird code.

> +	 * fail probe. We might want to change this behavior and assume all
> +	 * clocks are in bypass mode; this is what is being done in the vendor
> +	 * driver.
> +	 *
> +	 * It is unclear if there are valid situations where the OLB region
> +	 * would be inaccessible.



Best regards,
Krzysztof


