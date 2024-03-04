Return-Path: <linux-kernel+bounces-90174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620B386FB68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E162C1F22B09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98634175BB;
	Mon,  4 Mar 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHe5gIng"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883511758D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540018; cv=none; b=O4AYeuUiEGsovB8Jhc/OB7GbFODkQ2yc1NPOKzErngCtE0r7bpv/fZlSRPqEPge1N1Ef3HoSEnCImpxXIlCuHPKUy8d7/rs52Rn+RJiKlpTgnZY3GoHkhth1tT+LHTocmIbnJu5reTEcGp4opQxVxw2tCs4r976ORIV5spFfEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540018; c=relaxed/simple;
	bh=RxbEGsnhNa5uTRjQx9BTkviUBjVSsvA60c9HxQFotVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oY1YZ4yA+DvZD+dT11oidWwiKTzkeFjzrflsPlUXxLpb+QGSl2+q4ADB78VHRy/uxSr8O6hsN3f9oOlHVCYRoVaXejC/BC7xLH0Y5yvfBkmuA8lVuXnpw/5xAcJ8ziyi+TOv7LoLWKgKjApdA0X06e0BYlKceFjpnX8fWXdsSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHe5gIng; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d2b354c72so3169075f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709540015; x=1710144815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeicVjFWQLYWEbgTMQ1yeqci8fFDXO86y2K2X4IlkOY=;
        b=XHe5gIngWKa8nBVyLHcwEhYbo/fxvRy4sOg1fITyylfecAcQwgMhsUM0MEJuO0NFob
         3t+UQnQ56mwEpe8M98neXBhv0Jo/Wk6iRmP0cpqE3JX0Vk6LMWdSIB+qYxH972NjCp7f
         JrjzYispP03oCI54LWdZk8HT1g8Ltul6EkIdkK0WlRZe1EyhBoV2fMBfCddjDOHKcXPo
         43U440p7Nl4z/8lnxnw60U+AioE/y1hmV30UokS+rSlHf7+3mXyITTSue3KabIYyzOMx
         ib9q18SvA78BfFuFdD8mWWUpeIdvuicj8DGZTO5UfqSqr6846zpQ78OpcKPaxKjnJWLf
         QWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540015; x=1710144815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeicVjFWQLYWEbgTMQ1yeqci8fFDXO86y2K2X4IlkOY=;
        b=F/GlcwV1Rx9duNYnUCzleKxZbQgfHjRx6aBZBfgDxRgzKaLhLul9VkdqM83yK9DESL
         aLlBuXNZ9o1wBn9yzUbhviaQq0M/C2GA9htW7G+2zRC2yeDvRSkeonITTGXXtPInL9uO
         wsrR5unj9QdGd9OydMU4JYK92rDZhCbDfiiaAMy8MEPvAYmHI+ovb5BW8YIWQUIKt9U3
         SnjssFWgc85DL/0d7No+zJDb79gescjq6zibDY8L0wYyrn5nSLmLtKzlGEKfXLSDbjKI
         4lS2oLg1SDV0tB/FeUYwvgeDvAs+om80Lgw1vSJfd1yyVVAT5xmFPV4TtiWoGRvTIqri
         Lvcg==
X-Forwarded-Encrypted: i=1; AJvYcCXgJm4pnVVW0pWd/m0NgN9V0YwMT+edzB1aIR9+H0TbnaUu+6zzlDQ0RY+iYY3IorhTuvFeXTx0FjAfKFX5QOBbOlk6o+W41OFAMf+C
X-Gm-Message-State: AOJu0Yyx4ayELhw+BP3MhSw6Qq8Sj1yiZmZnXyH6xzFF2ZtiCvhhaHXL
	TapIzOoNHw0CQEz27WI+92nGEfpqGGjYW4f+e8S0zUGR8zdwEspR6JKVU3VGFrg=
X-Google-Smtp-Source: AGHT+IG8Yscjdvp7or7AcmXjxfdDmuq0Jm51hAQQ9qhH5ZBgQX9/+ik+vnjUFNxTM6bSBdO6gmrXpA==
X-Received: by 2002:a5d:670e:0:b0:33d:31dc:cff7 with SMTP id o14-20020a5d670e000000b0033d31dccff7mr6671420wru.32.1709540014825;
        Mon, 04 Mar 2024 00:13:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id q1-20020adfab01000000b0033ce727e728sm11567761wrc.94.2024.03.04.00.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 00:13:34 -0800 (PST)
Message-ID: <534c93a2-8bc5-42b3-b7c6-2a3fe63c197f@linaro.org>
Date: Mon, 4 Mar 2024 09:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] riscv: dts: add initial canmv-k230 and k230-evb dts
Content-Language: en-US
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
 <tencent_1DB2D1914F4E30569BC4B103B724A6214405@qq.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <tencent_1DB2D1914F4E30569BC4B103B724A6214405@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2024 14:26, Yangyu Chen wrote:
> Add initial dts for CanMV-K230 and K230-EVB powered by Canaan Kendryte
> K230 SoC [1].
> 
> Some key considerations:
> - Only enable BigCore which is 1.6GHz RV64GCBV
> 
> Since is there cache coherence between two cores remains a mystery since
> they have a dedicated L2 Cache. And the factory SDK uses it for other OS
> by default.
> 
> Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
> CPU1, the csr.mhartid of this core is 0.
> 
> - Support for "zba" "zbb" "zbc" "zbs" are tested by hand
> 
> The user manual of C908 from T-Head does not document it specifically.
> It just said it supports B extension V1.0-rc1. [2]
> 
> - Support for "zicbom" is tested by hand
> 
> Have tested with some out-of-tree drivers that need DMA and they do not
> come to the dts currently.
> 
> - Cache parameters are inferred from T-Head docs [2] and Cannan docs [1]
> 
> L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
> L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
> L2: 256KB, PIPI 16-way set-associative, 64B Cacheline
> 
> The numbers of cache sets are calculated from these parameters.
> 
> - MMU only supports Sv39
> 
> Since T-Head docs [2] says C908 should support sv48. However, it will fail
> during the kernel probe. I also tested it by hand on M-Mode software,
> writing sv48 to satp.mode will not trap but will leave the csr unchanged.
> 
> [1] https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_datasheet.html#chapter-1-introduction
> [2] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369347/XuanTie-C908-UserManual.pdf
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/boot/dts/canaan/Makefile       |   2 +
>  arch/riscv/boot/dts/canaan/canmv-k230.dts |  23 ++++
>  arch/riscv/boot/dts/canaan/k230-evb.dts   |  23 ++++
>  arch/riscv/boot/dts/canaan/k230.dtsi      | 146 ++++++++++++++++++++++
>  4 files changed, 194 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/canaan/canmv-k230.dts
>  create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
>  create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi
> 
> diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
> index 987d1f0c41f0..b4a0ec668f9a 100644
> --- a/arch/riscv/boot/dts/canaan/Makefile
> +++ b/arch/riscv/boot/dts/canaan/Makefile
> @@ -5,3 +5,5 @@ dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maixduino.dtb
> +dtb-$(CONFIG_ARCH_CANAAN) += k230-evb.dtb
> +dtb-$(CONFIG_ARCH_CANAAN) += canmv-k230.dtb
> \ No newline at end of file

Please fix patch errors.

> diff --git a/arch/riscv/boot/dts/canaan/canmv-k230.dts b/arch/riscv/boot/dts/canaan/canmv-k230.dts
> new file mode 100644
> index 000000000000..09777616d30e


..

> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
> new file mode 100644
> index 000000000000..4317bda38142
> --- /dev/null
> +++ b/arch/riscv/boot/dts/canaan/k230.dtsi
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/dts-v1/;
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	compatible = "canaan,kendryte-k230";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <27000000>;
> +
> +		cpu@0 {
> +			compatible = "thead,c908", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			riscv,isa = "rv64imafdcv_zba_zbb_zbc_zbs_zicbom_svpbmt";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zba", "zbb",
> +					       "zbc", "zbs", "zicbom", "zicntr", "zicsr",
> +					       "zifencei", "zihpm", "svpbmt";
> +			riscv,cbom-block-size = <64>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <128>;
> +			d-cache-size = <32768>;
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			next-level-cache = <&l2_cache>;
> +			mmu-type = "riscv,sv39";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		l2_cache: l2-cache {
> +			compatible = "cache";
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-size = <262144>;
> +			cache-sets = <256>;
> +			cache-unified;
> +		};
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-noncoherent;
> +		ranges;
> +
> +		plic: interrupt-controller@f00000000 {
> +			compatible = "thead,c900-plic";
> +			reg = <0xf 0x00000000 0x0 0x04000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			reg-names = "control";
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <208>;
> +		};
> +
> +		clint: timer@f04000000 {
> +			compatible = "thead,c900-clint";
> +			reg = <0xf 0x04000000 0x0 0x04000000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> +		};
> +
> +		apb_clk: apb-clk-clock {

Only MMIO-nodes go to soc. Such stubs go outside.

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +			compatible = "fixed-clock";
> +			clock-frequency = <50000000>;
> +			clock-output-names = "apb_clk";
> +			#clock-cells = <0>;
> +		};
> +


Best regards,
Krzysztof


