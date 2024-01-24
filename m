Return-Path: <linux-kernel+bounces-36637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C583A434
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5076A1C219BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BACC1758F;
	Wed, 24 Jan 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/PHmsqQ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C8168B7;
	Wed, 24 Jan 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085224; cv=none; b=C+E/edZjwNLBdaxB8EwntoLWvIaAsgM2Vk8FLhKbH0ECvUJV7u8kJ4TQ0+HAvB/5EEDPOGFQp86jeKJfWWYidP6BKom0BKQc6Vhqz+/PfhLJp6PW7oZetRguPkvfv5OJFQN0fSgTTAlL+5e4ZO+GfuewDzmR1sKBTkRkCepT+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085224; c=relaxed/simple;
	bh=EzCClBVRfIQQjiEtneiOW2Rs5f79PU3aGY7X9Y7gYBI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ckaZIYhFQ7K2tRwPfdMf4sojfxeW2MicVYglra8nBV3w+fj7hCDv6rWtO1MhmbzXgHlsdYNhJKAefRYXkDXJE1yhsKJZZfjhiLneOptw1WlraE+/vR75YRAoB8M+8ADgEE2pFSdb90cqMqt8gVcZR3SBsOWUdq10nkNUZJ7Zrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/PHmsqQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf13c259f3so14764591fa.2;
        Wed, 24 Jan 2024 00:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706085220; x=1706690020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hd/1O/Sg3JdYzCg1+SznBDCwVJqhnijf0uPOjWbChE=;
        b=m/PHmsqQzBwPfXvl3E8XmaEdmgpTFrNqPto7kvI0pVj2/6rIJZSWBr9p8JRKZqgCSv
         cAV5DehcLnWEgMmpI1yABlgqL3/fwuo34+DxdoJibDR/bMlZLZ7UKMlQ7EaDitA/gaZe
         H7YghbfYwavKRdPQ3kg/+mwCop+wyMZ/Z2M1KORvd9rH9olLU3bxONV4Pcb30Z7woLRS
         1pC5JlNSw1KCmwR1qmo1D42Z7t+HF7qcHtK0IMfgtTvHn5N3lU7umTavUXGjEVJTZbL2
         IGMpoCkW7ir4C6jk5ezVPs/Wn3shRcGUm4JIOjp2zO56Gnyo0ZThSBFSRX7iC5H4ycyd
         IBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085220; x=1706690020;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hd/1O/Sg3JdYzCg1+SznBDCwVJqhnijf0uPOjWbChE=;
        b=CrlgkBZOj6xtMuPqiEk+W/CK3SVxHVCSJeRs89DpULI4Sk147Qr+3M7Kf1D9SD+KEo
         IWXVdbV82IvK8zhCQDlPn/8a0FBYjs1Hr69vYgbt/r9cs9cTwZPblUXPrztVQOGWYCOh
         +q18RIFxE5dNK8QejMeidzaZKd18C029lQ/tGy2v3aCD4IUn5ur2dal58dZqw6UZwWD6
         ls4/QHQi5OeRDzybZmtmSkXFFjFJux/UEinTfPpUUCiEztEKsb3aKsJ8x95cJIFQ7pNX
         JBYatc7YZaf6ipHZSyqJSEhuhaEetZaSdt8moVd4rg5aWYKeGRJa3acfvYXE/JP6AYuu
         hLzA==
X-Gm-Message-State: AOJu0YyqTLnAGOjTHaVAytmvPe+yIAAKBrMBO0u2KLnUWZumcnjzrZad
	GSRzJwSxDoFIpDKMA30iT0PC0oOjnwYb6HjDRXWCiX0UNLWSh9wi1zrcaxkWD3E=
X-Google-Smtp-Source: AGHT+IE6U5DpYNkERuWKwc5U2ERYS4WpXA04rDyoxcT71SlhND78Rp2Rht6y6AEUfe9ZRdOUS1sqvg==
X-Received: by 2002:a2e:a37a:0:b0:2cc:8b49:6dbb with SMTP id i26-20020a2ea37a000000b002cc8b496dbbmr364086ljn.62.1706085220103;
        Wed, 24 Jan 2024 00:33:40 -0800 (PST)
Received: from [192.168.1.105] ([31.173.80.46])
        by smtp.gmail.com with ESMTPSA id c18-20020a05651c015200b002cce6095241sm3750351ljd.62.2024.01.24.00.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 00:33:39 -0800 (PST)
Subject: Re: [PATCH v3 12/17] MIPS: mobileye: eyeq5: remove reg-io-width
 property from OLB syscon
To: =?UTF-8?Q?Th=c3=a9o_Lebrun?= <theo.lebrun@bootlin.com>,
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
 <20240123-mbly-clk-v3-12-392b010b8281@bootlin.com>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <30ab446a-c00d-12d6-0f54-4bcf7c42a6fe@gmail.com>
Date: Wed, 24 Jan 2024 11:33:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240123-mbly-clk-v3-12-392b010b8281@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 1/23/24 9:46 PM, Théo Lebrun wrote:

> Remove the `reg-io-width` property from the olb@e00000 syscon. The

   The diff says it's system-controller@e00000 now... :-)

> default memory access width is what we desire: no need to make it
> explicit.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  arch/mips/boot/dts/mobileye/eyeq5.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> index 81497febcdee..03e7e942ee22 100644
> --- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> +++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
> @@ -103,7 +103,6 @@ uart2: serial@a00000 {
>  		olb: system-controller@e00000 {
>  			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
>  			reg = <0 0xe00000 0x0 0x400>;
> -			reg-io-width = <4>;
>  		};
>  
>  		gic: interrupt-controller@140000 {

MBR, Sergey

