Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC67C93B5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjJNJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:16:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D5AD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 02:16:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC86C433C7;
        Sat, 14 Oct 2023 09:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697274998;
        bh=k52xWdFX6UjAOvOzI3AWhj638Tolfhfcr0twbZHvcUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExLN7t9JOPknABzwTs92zb6MYEd7IAByQ2A4ANceSuRUOlbKMSUwhNbY4zapvk57K
         4Wwjpm34RhzcKKtIxFnFb3o3rhhkeWvq0tI0u5G4dd6nfEPNpUzqXm4vMAbS/u0KA1
         eQ5zEwMwkUHIcxqiYT5B9qgNn/jrtXxrQDFj/5tf4Pniv+wlXeBo/2lj5IrZklvTdg
         6h7hd8GpbyGjL7UoTa0ZNTQgcYTED7bLRARpuR9wb3f6KwpE0cWGKdfq2v9XgBPIVz
         3DndQSGJ6v+gnyd6B6iDbKC6tHDX6H0mlHF2vWdYXez/SPK437P6JyhqjvUcaOStwH
         p+kyy4v6kBSoQ==
Date:   Sat, 14 Oct 2023 17:04:26 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/7] riscv: dts: sophgo: Separate common devices from
 cv1800b soc
Message-ID: <ZSpZmsb29ZC5L9dS@xhacker>
References: <IA1PR20MB49531C1C34C3E972DBBA4151BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231009112642.477337-1-inochiama@outlook.com>
 <IA1PR20MB49532560A3CA2670A0EAB846BBCEA@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20231013-catchable-wince-f24060feb639@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231013-catchable-wince-f24060feb639@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 10:08:24AM +0100, Conor Dooley wrote:
> Yo,
> 
> On Mon, Oct 09, 2023 at 07:26:35PM +0800, Inochi Amaoto wrote:
> > Move the cpu and the common peripherals of CV181x and CV180x to new file.
> > 
...

> >  	};
> >  };
> 
> What I wanted to comment on was this though - it seems that both the
> cv1800b and the cv1812h have identical plic and clint nodes, other than
> their compatibles? If that is the case, why create a cv1800b and a
> cv1812h specific file containing entirely new nodes, when overriding the
> compatible would be sufficient? Doubly so if the other SoCs in the
> cv18xx series are going to have identical layouts.
> 
> I gave it a quick test locally with the below diff applied on top of
> this series - although I didn't make sure that I didn't re-order the
> plic & clint nodes, I just wanted to demonstrate what I had done.
> 
> Cheers,
> Conor.
> 
> -- 8< --
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> index 3af9e34b3bc7..a9d809a49e7a 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -5,7 +5,7 @@
>  
>  /dts-v1/;
>  
> -#include "cv1800b.dtsi"
> +#include "cv180x.dtsi"
>  
>  / {
>  	model = "Milk-V Duo";
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index 0904154f9829..e69de29bb2d1 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> -/*
> - * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> - */
> -
> -#include "cv180x.dtsi"
> -
> -/ {
> -	compatible = "sophgo,cv1800b";
> -
> -	soc {
> -		interrupt-parent = <&plic>;
> -
> -		plic: interrupt-controller@70000000 {
> -			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> -			reg = <0x70000000 0x4000000>;
> -			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <2>;
> -			riscv,ndev = <101>;
> -		};
> -
> -		clint: timer@74000000 {
> -			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
> -			reg = <0x74000000 0x10000>;
> -			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> -		};
> -	};
> -};
> diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> index 64ffb23d3626..1a2c44ba4de9 100644
> --- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> @@ -48,6 +48,7 @@ osc: oscillator {
>  
>  	soc {
>  		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		dma-noncoherent;
> @@ -174,5 +175,21 @@ uart4: serial@41c0000 {
>  			reg-io-width = <4>;
>  			status = "disabled";
>  		};
> +
> +		plic: interrupt-controller@70000000 {
> +			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
> +			reg = <0x70000000 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <101>;
> +		};
> +
> +		clint: timer@74000000 {
> +			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
> +			reg = <0x74000000 0x10000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
> +		};
>  	};
>  };
> diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> index 3864d34b0100..c0a8d3290cc8 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> @@ -15,22 +15,13 @@ memory@80000000 {
>  	};
>  
>  	soc {
> -		interrupt-parent = <&plic>;
>  
>  		plic: interrupt-controller@70000000 {
>  			compatible = "sophgo,cv1812h-plic", "thead,c900-plic";

Hi Conor,

Maybe this has been discussed before but I didn't find it. I'm wondering
the reason of adding each plic and clint binding for each SoC, can we
just use the thead,c900-plic for plic?
FWICT, arm gic dt usage follows this way, there's no binding for each SoC's
gic but directly use "arm,gic-v3" and so on.


Thanks in advance

> -			reg = <0x70000000 0x4000000>;
> -			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> -			interrupt-controller;
> -			#address-cells = <0>;
> -			#interrupt-cells = <2>;
> -			riscv,ndev = <101>;
>  		};
>  
>  		clint: timer@74000000 {
>  			compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
> -			reg = <0x74000000 0x10000>;
> -			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;

