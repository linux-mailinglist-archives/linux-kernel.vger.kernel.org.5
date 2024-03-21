Return-Path: <linux-kernel+bounces-110524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2560886020
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BDA288272
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F741332AB;
	Thu, 21 Mar 2024 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrjMfchD"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4CD8C0A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043699; cv=none; b=sSLj7M26eahf5oZSgRP7llSoyrqgASerNlGfc8JlNbeqJpN3iLiMTIXRjGvYBOtaAtmRG47ul1bxhYv+DfvvUf7wPSehxjnK07B1lVei9ALPZ3J+aSR7P7+ZIWje67SbRn7G6CqHrNDZ3kOLqP57Mt5SUGxGEeQljpEf/NLynhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043699; c=relaxed/simple;
	bh=8EoHhIa/q3TD4ugJ9U851nn5YTozjokCgdMnwY8UE40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zyod9oaSY7tQwdzv+T1K8vGRMVI4ytULUcGL8dNzLhw5IcVD6jF5rCmm2AhIoeAE+vExsGJx2qhOdmK7EIV/xK2qTHHycZG21VJ1zqbaVG1MCXkDui0leylTzjJE0eI4X4fGC1v5G+LMcQANW/bax4zMLLDfjqQS8c4mrgpGzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TrjMfchD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e8f76f18d3so1038184b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711043697; x=1711648497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C32/M+PeWtGjloI9TgPaFcgwlNoOt3Q5DnKZeiA7gC8=;
        b=TrjMfchDNOm39MJ7kuEwMknhgpJ8Yk/QkrIw8nLVMb5mY2rLlzxoSHV7oytls2j4c0
         JbpWxtFOxVA+OUKvxtPa4igKUPlbJ1sjuqDJ+ZiUnc8NsfCsVJa/RLEzUqp29RpZiKdb
         5AQByuy/2lanUAskn/pfrInxyXiFupKMG+eh3Y2JSi9h4H+r+m2OiEyDuEksnK88EYNU
         Y+tIc1LfikElALfGnzETX6KcvMasWlkWIeWfzwoe6NswfDwnoSx2N64JqCt2aR63n8Fx
         LHRqUCffkXznzrBs6eCB2CPYALjlaOWkP76oewWzyakq5Uj8OlI8ca8I2Xb+OyKPBKDh
         WgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711043697; x=1711648497;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C32/M+PeWtGjloI9TgPaFcgwlNoOt3Q5DnKZeiA7gC8=;
        b=dZP98Xg1gJ4yP83+fSbDqU6tfBkse89L3SmR6G3cxlbJ6IkCYyMMBisbgwINKmiy+q
         pHWUAl37WKbIBzb0Kb9RMeuknhmj+B8sYUC4/RrlpvktQYmlE0Q66Tcpzfe0aWTujBqB
         O4z1FLR4HCeOtVMKXGBu3q6SgrWI7jZ+JOm4RKU51BBrF09vu4Uew2VOrDddL5ACRT2W
         +gmT5F03FBuVxWLCYaIneLrJLlX3jl8Dm1RSIMWRFWbbSyzURqmUKSab7gNd3n4JtCd3
         FkL4LAG0uZg4HF+AGCIBOnnbqMx8pzI6mstgHMZZyTN3UaO/c3qwvTu29qIQ+fEXVRCW
         X8tA==
X-Forwarded-Encrypted: i=1; AJvYcCUV6S+a2QtJzt9xXCvk8PhrY2Hzb55eTGVDKq8JyBuIjg96d6GoY7ncj89aOUGDNg5aYvj76UaXu08oYinkYdFPiWhU1UtFSSvz18Ek
X-Gm-Message-State: AOJu0YxKvrpgLYMaQZm/1Td7xjeIrmZZuK1rHeaKky62as0I9GVknKcZ
	oyMwIqVlm99aW26eYLHfrQzZk5bMrlmXk6sbGpD0uSgkeKKkwdMyE1NRmP1i+H0=
X-Google-Smtp-Source: AGHT+IGg0vXWpzAvQLsGXg2V30xXB70hgkCIQzWlkD1/RMV33pvQtj8/wsn9i5I6UjX6kG0vqoaWyQ==
X-Received: by 2002:a05:6a00:14c1:b0:6ea:306b:3726 with SMTP id w1-20020a056a0014c100b006ea306b3726mr407188pfu.3.1711043696830;
        Thu, 21 Mar 2024 10:54:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id n37-20020a056a000d6500b006e6bcda8480sm112750pfv.121.2024.03.21.10.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:54:56 -0700 (PDT)
Message-ID: <4f5a91e7-7d67-4012-9928-90d8fbfea582@linaro.org>
Date: Thu, 21 Mar 2024 18:54:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
References: <20240321154108.146223-1-wafgo01@gmail.com>
 <20240321154108.146223-5-wafgo01@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321154108.146223-5-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 16:41, Wadim Mueller wrote:
> This commit adds device tree support for the NXP S32G3-based
> S32G-VNP-RDB3 Board [1].
> 
> The S32G3 features an 8-core ARM Cortex-A53 based SoC developed by NXP.

..

> +
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x103>;
> +			enable-method = "psci";
> +			clocks = <&dfs 0>;
> +		};
> +	};
> +
> +	pmu {

Please order things alphabetically. See DTS coding style.

> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* phys */
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* virt */
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>, /* hyp-phys */
> +			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>; /* hyp-virt */
> +		arm,no-tick-in-suspend;
> +	};
> +
> +	reserved-memory  {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		scmi_shmem: shm@d0000000 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x0 0xd0000000 0x0 0x80>;
> +			no-map;
> +		};
> +	};
> +
> +	firmware {
> +		scmi: scmi {
> +			compatible = "arm,scmi-smc";
> +			shmem = <&scmi_shmem>;
> +			arm,smc-id = <0xc20000fe>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			dfs: protocol@13 {
> +				reg = <0x13>;
> +				#clock-cells = <1>;
> +			};
> +
> +			clks: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +		};
> +
> +		psci: psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +	};
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0x80000000>;
> +
> +		uart0: serial@401c8000 {
> +			compatible = "nxp,s32g3-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x401c8000 0x3000>;
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@401cc000 {
> +			compatible = "nxp,s32g3-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x401cc000 0x3000>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@402bc000 {
> +			compatible = "nxp,s32g3-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0x402bc000 0x3000>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		gic: interrupt-controller@50800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x50800000 0x10000>,
> +			      <0x50900000 0x200000>,
> +			      <0x50400000 0x2000>,
> +			      <0x50410000 0x2000>,
> +			      <0x50420000 0x2000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		usdhc0: mmc@402f0000 {

Keep ordered by unit address.



Best regards,
Krzysztof


