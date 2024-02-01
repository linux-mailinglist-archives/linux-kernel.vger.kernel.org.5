Return-Path: <linux-kernel+bounces-47840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAE184538D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732B328FD10
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE315B98E;
	Thu,  1 Feb 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykq2K1Ix"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45F15B977
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778865; cv=none; b=kN+QnPf2R31Q0iBJ+lb4FTDTxJPmfmP27Zc2JYxHYlp8XGaaQlMNz9L89xjrMcpChqp3vZLQuhONncG/+/FKfEUE/49cs0IU/z5cDxPm0D/YX0Kl9zQ1Bm4nsRzfmLsvyl/eWjfETAttnRepON154/sNDS2KqJBmxFJgS41j0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778865; c=relaxed/simple;
	bh=ZzZFC8pCFWDVU7JyslqsXXC7ChqqenGWk7j8CMB9YZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j34J2X2CXpMtgL7Aky3a9IZMXjkq2lDVI5RVgh9ysAKvfFnJPeTpPsoyAk0z1FyMmuJRpqJ946U0Cl70h7QUMOlGTtZCSgR9XypSMn9eECduDn5E03tY0irrudce7bTewrnQ3w/4PJ8i8Ju3IX9c9maXjySxUnOwNxxTgstckCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ykq2K1Ix; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a30e445602cso397094966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706778862; x=1707383662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/8tPV5f9TkHhEsp1Q8SF5XrFa/+sW2kJLUAlbmmFaM=;
        b=ykq2K1Ix+7w7JHy1Wwqt+aO3b0NHMpZrA7mSQvvRM2QXFuGZt5G1xhE9Grqe0Hynso
         BNv8x6kbkExbpsAme8o1T00naIVim927dthHAfLvdCs0uLMeigNtmTQm8uP7KCR4+9ru
         h2gKfBAd83mpeeLKAeCNbZ/LHQbU1E1IoBiGx020pwl0EOXa5pveks0UqKUYsmide3pV
         sIiX+dTTzma9YL4+EuWvG/t9i+EKOsOmHz3TD+tJeC3NsyDgOdmGCsoNQ2sKJAcwZzDe
         HdRphsmZxtx2m3Wq90cu28ZoIi8BYc8/VrZ+ZpASDhX0ANkH0/NafzB7DDOJdepEd5yw
         0xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778862; x=1707383662;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/8tPV5f9TkHhEsp1Q8SF5XrFa/+sW2kJLUAlbmmFaM=;
        b=fnAdGkhTZL29GT6gdUE4o24w6HgAN/r+VJlxfikwpPsUDI6PwDrK3yddA3HtpLqe5U
         p2No8nOmEIwdN12NJhXmo+RPEQYEPVot9uIu8dAjTkSwvKa8ClmqMHWEThEVPAsd+gum
         BlEU6TFgaYQzIX6TNzWWQHqmOafT7obErblJcA1egw90ebHBh3G7WRdt4WS75+iio0EF
         sNVJXRRiQVq7ypxsWGm646hcoNt6e1lOpyMS05oZzDCjzxLCy4z9dGsRXI7qEvIt6aKG
         cSRdHiout7Zw6VmD/zshYjYn9YI11a01TeTgWtl27bTQtBNW84Tlj/sw+r1gU/J4uYTI
         R3AA==
X-Gm-Message-State: AOJu0YzdC6qNNsw8kgyPC5e2v1BGUScz4pkNmM4AwegKnNP6GPNgPQo2
	xF0qC89YkfGIf7HIWhQ//7mkTBF9KWrNWKwk4NcK++AIQAnw/ghCmu3GMghcIwU=
X-Google-Smtp-Source: AGHT+IH58gkd1fs10vyT7eEcqXGDJwqAYIKiVC+I+A8OP3YgTKftOtUxlewXAhONh6DTSb80sUji2w==
X-Received: by 2002:a17:906:cb2:b0:a27:5fd1:791f with SMTP id k18-20020a1709060cb200b00a275fd1791fmr4794552ejh.0.1706778862246;
        Thu, 01 Feb 2024 01:14:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWvUprgPBYD2U5tuVsSbAuU20y3L1EkaOCfB/E7XauuVlm207EHxazpSCwE0AJntKuON6cu9pJDhPyOaELebk2/+1Ct0BVPnM3Alw2QMYyumYfV3i9o0uuu9/MULr0wLtkuYEjpzLoKDAEdfPjmb6PElg+ccXl8s6S4cT+Uj094vd0ArqSxLiLobBOjub+irO7E+OFarD/3RvhCdmc5WgDIMlrSrrBPQuqKKNf4EoPHup/HeGbV/CH0+z5RzTJyTPvzJBKy6b2FR+fjE6V7KIGKe1HHNwqhBQ74jOHQ2bRweqcNMWlknT321vBnF6rgjzGCtcjCsmWSdwcKskInUtiWkSE7VJsapNHo5c5TPxLPGZjiFBn6lPCG10K4gk5OIgShD8eksHIGpXT+Phb/xCHTjiyIqTD1zT812omj+vQ2xD3Aw7WhGqU/sANK8U7d/7FAvV2WfvFgC1fCy58+Lw5gIHYWxUtxq57wnUzy684TqbSMoVV0RAPR
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu3-20020a170906ba8300b00a368903fc98sm1165092ejd.136.2024.02.01.01.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 01:14:21 -0800 (PST)
Message-ID: <32ac8056-1820-4871-8526-8b467162d78e@linaro.org>
Date: Thu, 1 Feb 2024 10:14:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/15] MIPS: mobileye: Add EyeQ5 dtsi
Content-Language: en-US
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
 <20240118155252.397947-12-gregory.clement@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240118155252.397947-12-gregory.clement@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/01/2024 16:52, Gregory CLEMENT wrote:
> Add a device tree include file for the Mobileye EyeQ5 SoC.
> 
> Based on the work of Slava Samsonov <stanislav.samsonov@intel.com>
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---

..

> +
> +	soc: soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		compatible = "simple-bus";
> +
> +		uart0: serial@800000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0 0x800000 0x0 0x1000>;
> +			reg-io-width = <4>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks  = <&uart_clk>, <&occ_periph>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		uart1: serial@900000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0 0x900000 0x0 0x1000>;
> +			reg-io-width = <4>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks  = <&uart_clk>, <&occ_periph>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		uart2: serial@a00000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0 0xa00000 0x0 0x1000>;
> +			reg-io-width = <4>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks  = <&uart_clk>, <&occ_periph>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};
> +
> +		olb: olb@e00000 {

That's not a correct name. Please do not send knowingly incorrect DTS.

> +			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
> +			reg = <0 0xe00000 0x0 0x400>;
> +			reg-io-width = <4>;

That's not needed property here.

> +		};
> +
> +		gic: interrupt-controller@140000 {
> +			compatible = "mti,gic";
> +			reg = <0x0 0x140000 0x0 0x20000>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +
> +			/*
> +			* Declare the interrupt-parent even though the mti,gic
> +			* binding doesn't require it, such that the kernel can
> +			* figure out that cpu_intc is the root interrupt
> +			* controller & should be probed first.
> +			*/
> +			interrupt-parent = <&cpu_intc>;
> +
> +			timer {
> +				compatible = "mti,gic-timer";
> +				interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
> +				clocks = <&core0_clk>;
> +			};
> +		};
> +	};
> +};
> +

Stray blank line.

Best regards,
Krzysztof


