Return-Path: <linux-kernel+bounces-92635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4952487233B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F389F280F84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20350127B67;
	Tue,  5 Mar 2024 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="f2xXaGIg"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DC8564F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654051; cv=none; b=L9M2tA6+EDZJB02jBVcBjKuPPhUDZfqP1FmVqecHDGI9pfjFk24RGTddHbwJCIw4153tbqLquchuF9fLcwxrZa/WeFwuOArpfssjNwGUnLNZawoJtpI+eZohtBx0nimFzqeeeG/0MoEwxgRWe1avSMH9LK/HXyY/ZR6dt+E4toE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654051; c=relaxed/simple;
	bh=B3TrxxUdhxYXlwui+xw9qFWGXWaYEKxd85w6gc2Ih9Q=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Rmn2b+Sqjm/yKriL//JtkWo9AK0+CORgZ1JWTpPlfwKDqYleYIQ/MZEMZBiqi/xg6L5XxLuatf6m2c0wF7BK3GIfOflBM4cdKc1mRVM2hxB4PasXObb+JTLfQKvg+UCrRSBpMh6aHEF2p5RHYvYrKeyWKXJJn1QHoYY36YDMGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=f2xXaGIg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dcab44747bso47877415ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709654047; x=1710258847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5G61tXUbGyFGVEagtl7j7PuvWUI5+td7JU6ZKN8dSM=;
        b=f2xXaGIgMP3gFy3410p9l85WSRmoZERQK1kFMDgQnC1+ywSzn5xgrp+049lSnknU3U
         O3L8aAzAxOWcMVCSeAwGWUtm5/6sBHa3QBLAOTu77i76bnA5ZdKwPHxJNbwUBDNCGbJw
         WCV+J8/XuzPIFW+XHvnnJN8rrdWPAnD18uzhq93+LpQsNCoF3EVFOji+dVmOeYlV5jaA
         QEa2N1VAGK03EOwOGw0oVTtX4eQSzbiEQ59z0aL0SpDO+cnu/ljGoqUzq3zYOtJ/7hP4
         uMdY4Q3dfDlJKFL0Ev4+z21X03u2/HhuwpSBYk+IzwlXJAE0iXbkFpOoWbyGosMFxpO4
         cXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654047; x=1710258847;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5G61tXUbGyFGVEagtl7j7PuvWUI5+td7JU6ZKN8dSM=;
        b=lcfcNk6XAEwFbv8aClTpEPazn9Z1uZYb1ZSnf1lBj4dX05+Wwgt27fcDyXPhKGRnpE
         m5R0ic9hnYQSZxK2l4V2lFOezFDP31OJ8Fyt6LTvnVQW6Tw0zjaFHtrhdTDrsOrv+UXP
         Vuh6nOfb4y82pirQgmTorsNSHWbktX21MtnY7hhUjPvH+540zW2RfLdCnWJ1IScYnPjb
         proI2hUfzOmYcgegb02w+hbEI2xlaTdaknPeETgL2QImijv8otoaj8YIRUWXbAEZnUlf
         /PIuJ3DZggHkRY0PWUb2bq8630Py+Oi9leMZbIswSiCMXoCDKE2/z5UyOQi8BBYbF11Y
         jepQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF/H+mjB33gxckyOvzDeVDsLkPC0acU3MQyNP+n+eErPHj6EBUK/6X1Z1r1FMrHM9ICeisqIilV4NAarc74WbTG017mYicBPiM0aGQ
X-Gm-Message-State: AOJu0YyfTleqg2bYw3DDkEEVr+bKDRF0phJ40vNI2Tik7rNnv/hcfU8Y
	FNw2q2qgarKM7IJ7VvTwemGedSqBBtDsWMO+hq8rSeD7XJx8DkVObxto/PhgoC0=
X-Google-Smtp-Source: AGHT+IHCVON0sCbjYsLanDImjLZsf91OJttuqhARe+fEK93l9ikme/HjKRPOt8QlTrAuQCkdLsnuhA==
X-Received: by 2002:a17:902:c3cc:b0:1db:509a:5a31 with SMTP id j12-20020a170902c3cc00b001db509a5a31mr2179890plj.26.1709654047156;
        Tue, 05 Mar 2024 07:54:07 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001dc23e877c9sm10746096plx.106.2024.03.05.07.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:54:05 -0800 (PST)
Date: Tue, 05 Mar 2024 07:54:05 -0800 (PST)
X-Google-Original-Date: Tue, 05 Mar 2024 07:54:03 PST (-0800)
Subject:     Re: [PATCH v3 6/7] riscv: dts: add initial canmv-k230 and k230-evb dts
In-Reply-To: <tencent_1B7642BA1B77F81E0423B41B1DD770E36209@qq.com>
CC: linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
  dlemoal@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, guoren@kernel.org, devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org, cyy@cyyself.name
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cyy@cyyself.name
Message-ID: <mhng-f1aa91d4-211f-4eb4-a94d-a9d88b0d3f6a@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 04 Mar 2024 13:06:00 PST (-0800), cyy@cyyself.name wrote:
> Add initial dts for CanMV-K230 and K230-EVB powered by Canaan Kendryte
> K230 SoC [1].
>
> Some key consideration:
> - Only place BigCore which is 1.6GHz RV64GCBV
>
> The existence of cache coherence between the two cores remains unknown
> since they have dedicated L2 caches. And the factory SDK uses it for
> other OS by default. I don't know whether the two CPUs on K230 SoC
> can be used in one system. So only place BigCore here.
>
> Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
> CPU1, the csr.mhartid of this core is 0.
>
> - Support for "zba" "zbb" "zbc" "zbs" are tested by hand
>
> The user manual of C908 from T-Head does not document it specifically.
> It just said it supports B extension V1.0-rc1. [2]

I'm seeing

    3.1.6 Vector instruction set (RVV)
    For more information, see RISC-V “V”Vector Extension, Version 
    1.0-rc1-20210608
    URL：https://github.com/riscv/riscv-v-spec/releases/download/v1.0-rc1/riscv-v-spec-1.0-rc1.pdf

    3.1.7 Bit operation instruction set (RV64B)
    For more information, see ：RISC-V Bit-Manipulation ISA-extensions, 
    Version 1.0.0, 2021-06-12: public review
    URL：https://github.com/riscv/riscv-bitmanip/releases/download/1.0.0/bitmanip-1.0.0.pdf

so I think maybe that's vector 1.0-rc1 and the final bitmanip?

> I have tested it by using this [3] which attempts to execute "add.uw",
> "andn", "clmulr", "bclr" and they doesn't traps on K230. But on JH7110,
> "clmulr" and "bclr" will trap.
>
> - Support for "zicbom" is tested by hand
>
> Have tested with some out-of-tree drivers from [4] that need DMA and they
> do not come to the dts currently.
>
> - Cache parameters are inferred from T-Head docs [2] and Canaan docs [1]
>
> L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
> L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
> L2: 256KB, PIPT 16-way set-associative, 64B Cacheline
>
> The numbers of cache sets are calculated from these parameters.
>
> - MMU only supports Sv39
>
> Since T-Head docs [2] say C908 should support Sv48. However, it will fail
> during the kernel probe when running Linux on K230. I also tested it by
> hand on M-Mode software, writing Sv48 to satp.mode will not trap but will
> leave the csr unchanged. While writing Sv39 it will take effect. It shows
> that this CPU does not support Sv48.

I think that only works due to a bug in our sv48 probing routines -- 
unless I'm missing something, we mixed up the sv57 and sv48 probing and 
if sv57 fails to probe then we disable sv48 as well.  So I think we 
probably need some cleanup in there.

> - Svpbmt and T-Head MAEE both supported
>
> T-Head C908 does support both Svpbmt and T-Head MAEE for page-based memory
> attributes and is controlled by csr.mxstatus. If the kernel wants to use
> svpbmt, the m-mode software should set BIT(21) of csr.mxstatus to zero
> before entering the s-mode kernel. Otherwise, the kernel will not boot as 0
> on T-Head MAEE represent to NonCachable Memory and it will lose dirty cache
> lines modification that haven't been written back to the memory.

So I guess we need the bootloader to just be accurate here?  ie: 
whatever extension it tells S-mode kernels is enabled is how S-mode 
behaves, and then this should just work itself out.

> [1] https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_datasheet.html#chapter-1-introduction
> [2] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369347/XuanTie-C908-UserManual.pdf
> [3] https://github.com/cyyself/rvb_test
> [4] https://github.com/cyyself/linux/tree/k230-mainline
>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  arch/riscv/boot/dts/canaan/Makefile       |   2 +
>  arch/riscv/boot/dts/canaan/k230-canmv.dts |  24 ++++
>  arch/riscv/boot/dts/canaan/k230-evb.dts   |  24 ++++
>  arch/riscv/boot/dts/canaan/k230.dtsi      | 140 ++++++++++++++++++++++
>  4 files changed, 190 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
>  create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
>  create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi
>
> diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
> index 987d1f0c41f0..7d54ea5c6f3d 100644
> --- a/arch/riscv/boot/dts/canaan/Makefile
> +++ b/arch/riscv/boot/dts/canaan/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_CANAAN) += canaan_kd233.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += k210_generic.dtb
> +dtb-$(CONFIG_ARCH_CANAAN) += k230-canmv.dtb
> +dtb-$(CONFIG_ARCH_CANAAN) += k230-evb.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
>  dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
> diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts b/arch/riscv/boot/dts/canaan/k230-canmv.dts
> new file mode 100644
> index 000000000000..3ab5c8de11a8
> --- /dev/null
> +++ b/arch/riscv/boot/dts/canaan/k230-canmv.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include "k230.dtsi"
> +
> +/ {
> +	model = "Canaan CanMV-K230";
> +	compatible = "canaan,canmv-k230", "canaan,kendryte-k230";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	ddr: memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x1fdff000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/canaan/k230-evb.dts b/arch/riscv/boot/dts/canaan/k230-evb.dts
> new file mode 100644
> index 000000000000..42720113c566
> --- /dev/null
> +++ b/arch/riscv/boot/dts/canaan/k230-evb.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + */
> +
> +#include "k230.dtsi"
> +
> +/ {
> +	model = "Kendryte K230 EVB";
> +	compatible = "canaan,k230-usip-lp3-evb", "canaan,kendryte-k230";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	ddr: memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x1fdff000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
> new file mode 100644
> index 000000000000..0bcff67b78a8
> --- /dev/null
> +++ b/arch/riscv/boot/dts/canaan/k230.dtsi
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
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
> +	apb_clk: apb-clk-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <50000000>;
> +		clock-output-names = "apb_clk";
> +		#clock-cells = <0>;
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
> +			compatible = "canaan,k230-plic" ,"thead,c900-plic";
> +			reg = <0xf 0x00000000 0x0 0x04000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <208>;
> +		};
> +
> +		clint: timer@f04000000 {
> +			compatible = "canaan,k230-clint", "thead,c900-clint";
> +			reg = <0xf 0x04000000 0x0 0x04000000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> +		};
> +
> +		uart0: serial@91400000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x91400000 0x0 0x1000>;
> +			clocks = <&apb_clk>;
> +			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@91401000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x91401000 0x0 0x1000>;
> +			clocks = <&apb_clk>;
> +			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@91402000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x91402000 0x0 0x1000>;
> +			clocks = <&apb_clk>;
> +			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@91403000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x91403000 0x0 0x1000>;
> +			clocks = <&apb_clk>;
> +			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@91404000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x0 0x91404000 0x0 0x1000>;
> +			clocks = <&apb_clk>;
> +			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			status = "disabled";
> +		};
> +	};
> +};

