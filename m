Return-Path: <linux-kernel+bounces-158286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C968B1DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3295C1F235D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D53A8663E;
	Thu, 25 Apr 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r08SoTYT"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE082D82
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036892; cv=none; b=uodjcxH6AYbZrig/iHYPqH+tQxUs43Y8ptRG6ORoB5iGWLJmLuDDNvgDWiLKBuh67Gp7M8C9JQr3EDb71HFi8Ft/1Dtnd1eOe6+fFhNuewyussAw6n9HQELQvMNO+jxg9stPTSI4HFyfx89mfYqH5uVlwWFAOXYJiUH7jnzWX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036892; c=relaxed/simple;
	bh=DIxCZWTbT9ex1eNUW7EVfiV9rPgE5SIJK7MAesGyx5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDcKLf93JmhUmUgBrbCye44BCPV70p0DHqA3R6ApImAJhNjd7F3A5rfo7xqCaodO+L2W+aXaYgYavT4MKYgtgltmdvp6cukRWnu87Tgo9M5moQgRCXTgySF/1uzyVDytaQJJ7Z7za8RarTMbuyRi+s17X49UlKZXAGEdu1qp7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r08SoTYT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572250b7704so634637a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714036889; x=1714641689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ycKgQHtAUZ6lcTtJlqIOpE7h07r0Jxh/0W84BnG1/MY=;
        b=r08SoTYTFtb8XWjGUeXbyuX7J+DeZKgE2jtOWljojkoVTR1GSOUbKZWw/Te34r7dSX
         i39RqyhTl/M2zSLQmOO4oduoCV/VtWblgvtXFldwWE9K6yJQFupWrwylALEsJJ5YHP/a
         20G2vbCFgeMEjhsrJQ8Gl/FB1psPlTEl9C0guMuABmG7bqcAOzwjrgedv2j0MamPenuH
         scUVEICiay6M8pHadia4f1ct4wkuv1bOJORhZUX/+N8RY9aWjo18L2ywrToBaZFWGrnQ
         7GwUqa1fP9yFQ1OphJGNmxyUQJB/wuXUWvLj5XR0xNbpPDm/hqDrB4FlzEs9iq7QnDZ3
         4SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036889; x=1714641689;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycKgQHtAUZ6lcTtJlqIOpE7h07r0Jxh/0W84BnG1/MY=;
        b=a2RdM8+Ri2d6ZiQ7ho2eQw7gORxV/2X1NqE5i29z4qKP056SCjB7x7h6USvj8pcrHm
         x8EB51WCVBTpeDbq5XjLWfnabWqvW7GmzZebqKhc8SVBaLhRcBvBgDnJOj6YxTvIV4Uw
         NFT76LC0h5BhDBHfOEqj0EryoDUGKekILvVVC8y3pm1qa6W1q6DWi7btJBpiJpbc/iqY
         H5chgNsnpAzYwmHsPuEC1w/AbpvPrRrYlAKykPU1UvWMeWDJ2d24Fj+SYC90mS9jdjB6
         cinfuNEl4Z3lwI4NPy6+tcbh3nIxuCCBrBIzM8zPFnKP+JHik98RV2CmSC/euLex/wXX
         FAvw==
X-Forwarded-Encrypted: i=1; AJvYcCVkKYhp1LPxNVqqXVDkdR8Un72EZrH9+iIJNxfIxkJW2EcKyQ7M8Vl/MtiqGsGNu/oUFR8Osf8jso5E2riSz/Ji4JhAIFwqO8Nc4A4+
X-Gm-Message-State: AOJu0YzvP/3YboQSaPaLQPnmeQV+ajZBvSLM9sG7NoA75Vdv7nTLVTJC
	rISfz/PZaytaOSbaWdCD+pHomx964zqgB56nw2gSSjYqdTk5jgK7/yyDZKyhyHU=
X-Google-Smtp-Source: AGHT+IHX6Ld8omjwoxmOsJRoaL6fZBX83GKBvunq+KDlYXea3OdkfPFVRVe4eNBADH/SwCVfspxiZQ==
X-Received: by 2002:a17:906:2786:b0:a55:bfdf:937c with SMTP id j6-20020a170906278600b00a55bfdf937cmr3319563ejc.32.1714036888764;
        Thu, 25 Apr 2024 02:21:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906a29500b00a526a992d82sm9355428ejz.4.2024.04.25.02.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 02:21:28 -0700 (PDT)
Message-ID: <9b24ffdf-1247-4164-9841-6063106d76ea@linaro.org>
Date: Thu, 25 Apr 2024 11:21:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] arm64: Add initial support for Blaize BLZP1600 CB2
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "olof@lixom.net" <olof@lixom.net>, Neil Jones <neil.jones@blaize.com>,
 Matt Redfearn <matthew.redfearn@blaize.com>,
 James Cowgill <james.cowgill@blaize.com>,
 "heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
 "sre@kernel.org" <sre@kernel.org>,
 "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
 "andre.przywara@arm.com" <andre.przywara@arm.com>,
 "rafal@milecki.pl" <rafal@milecki.pl>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "andersson@kernel.org" <andersson@kernel.org>,
 "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "nfraprado@collabora.com" <nfraprado@collabora.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240425091403.17483-1-nikolaos.pasaloukos@blaize.com>
 <20240425091403.17483-5-nikolaos.pasaloukos@blaize.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240425091403.17483-5-nikolaos.pasaloukos@blaize.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 11:15, Niko Pasaloukos wrote:
> Adds support for the Blaize CB2 development board based on
> BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.

Subject: missing dts prefix.


..

> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			reg = <0x0 0x0>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "psci";
> +			reg = <0x0 0x1>;
> +			next-level-cache = <&l2>;
> +		};
> +
> +		l2: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-unified;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = /* Physical Secure PPI */
> +			     <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     /* Physical Non-Secure PPI */
> +			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     /* Hypervisor PPI */
> +			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
> +					  IRQ_TYPE_LEVEL_LOW)>,
> +			     /* Virtual PPI */
> +			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
> +					  IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	pmu {

Nodes in top-level look randomly ordered. Any reason why not using DTS
coding style in this regard?

> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>;
> +	};
> +
> +	sram@0 {
> +		/*
> +		 * On BLZP1600 there is no general purpose (non-secure) SRAM.
> +		 * A small DDR memory space has been reserved for general use.
> +		 */
> +		compatible = "mmio-sram";
> +		reg = <0x0 0x00000000 0x00001000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x0 0x00000000 0x1000>;

ranges follow reg

> +
> +		/* SCMI reserved buffer space on DDR space */
> +		scmi0_shm: scmi-sram@800 {
> +			compatible = "arm,scmi-shmem";
> +			reg = <0x800 0x80>;
> +		};
> +	};
> +
> +	firmware {
> +		scmi {
> +			compatible = "arm,scmi-smc";
> +			arm,smc-id = <0x82002000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			shmem = <&scmi0_shm>;
> +
> +			scmi_clk: protocol@14 {
> +				reg = <0x14>;
> +				#clock-cells = <1>;
> +			};
> +
> +			scmi_rst: protocol@16 {
> +				reg = <0x16>;
> +				#reset-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	soc {

This does not cause dtbs_check W=1 warnings? Surprising a bit... This
should cause big fat warning, so I have doubts patchset was tested.


Best regards,
Krzysztof


