Return-Path: <linux-kernel+bounces-157173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DA48B0DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ED31C230CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92015F321;
	Wed, 24 Apr 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrDUN1pS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B727158A3D;
	Wed, 24 Apr 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971742; cv=none; b=bvaSVDrkg+tIUYpTXWUNbFNisEv7cz+ylnyFWF/vJsKA7Tp0d6WjDZovYMJeXPMU/BKm/8ImmU9jQNAl8AOLXqiW+jdD/Ji1Z8oWBPcXVDUUhfFQCbeLi2mGshKXvcjPOzqibYYpztBSLaHXC1p1A0jatQHHm68jh/peMq+w+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971742; c=relaxed/simple;
	bh=uMcYy4FlcXjrYuGJofP0whwsMG8llTqowaxwAC+2Hz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLaU8uGMo9R7AHukAh1DHNEdKzT+Irarbh6E8h42hofACkH11X6IBtB/UGFgMXxz9nztTZS2OKkt54d/PraemHeZeEn3O0iNOFwQPQ7mRm01dS0rLiw92q+cVBgZERy+L0mYNE9Ppp8w14U5uULQoRZVTo6yFmyCuSbb2WTaE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrDUN1pS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784EDC113CE;
	Wed, 24 Apr 2024 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971742;
	bh=uMcYy4FlcXjrYuGJofP0whwsMG8llTqowaxwAC+2Hz4=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=HrDUN1pSpimPiob87xTAh1TjENQmCCFAZAKzBBE/ozPbKg0vUs0thd0qy6MEBm6kL
	 QPTDthYDXy8lv7mG4+ZBemlR88R/NVHT7z9ZtOHeEbxg1Xv5R1QZe4ftPiF767Vlvg
	 rBZRRCGj89KZ6E8tsvT/zID1N3MTHccEJQ48lF7I4FfW2ETX1f/oUVV2y3V9oE37/9
	 N2BIBhYCddfxP592hZ7uWIMSt0ClXFohFTPzt5DqN2xTQ2ECjS+a2AtI5QPPuKf7Tg
	 TNUVBVmsK5k3DdOA5tAyKBsnYfWT50UQ8mMMAhqCmgz7qYkSnBAMBRbZVAg4jJloU8
	 zVaJVApkcQcjw==
Date: Wed, 24 Apr 2024 16:15:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	James Cowgill <james.cowgill@blaize.com>,
	Matt Redfearn <matthew.redfearn@blaize.com>,
	Neil Jones <neil.jones@blaize.com>, Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] arm64: Add initial support for Blaize BLZP1600 CB2
Message-ID: <20240424-budget-vaguely-426f34eb305e@spud>
References: <20240424133320.19273-1-nikolaos.pasaloukos@blaize.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kfuG2k3Bnxl7jhEx"
Content-Disposition: inline
In-Reply-To: <20240424133320.19273-1-nikolaos.pasaloukos@blaize.com>


--kfuG2k3Bnxl7jhEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 01:33:23PM +0000, Niko Pasaloukos wrote:
> Adds support for the Blaize CB2 development board based on
> BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.
>=20
> The blaize-blzp1600.dtsi is the common part for the SoC,
> blaize-blzp1600-som.dtsi is the common part for the SoM and
> blaize-blzp1600-cb2.dts is the board specific file.
>=20
> 'make dtbs_check' complains about ['ti,ina3221'] and ['national,lm96163']
> which are already upstreamed drivers with no yaml documentation.

Might not be what you want to hear, but please add yaml documentation
for them. Rob told you to do so on v1:
https://lore.kernel.org/all/20230412140344.GA2234522-robh@kernel.org/

That said, I went and looked. ina3221 _is_ documented in a yaml binding
and has been since October. national,lm96163 on the other hand, you'll
have to document if you want to use it.

Cheers,
Conor.

>=20
> Co-developed-by: James Cowgill <james.cowgill@blaize.com>
> Signed-off-by: James Cowgill <james.cowgill@blaize.com>
> Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
> Co-developed-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Neil Jones <neil.jones@blaize.com>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
> ---
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/blaize/Makefile           |   2 +
>  .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
>  .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
>  .../boot/dts/blaize/blaize-blzp1600.dtsi      | 211 ++++++++++++++++++
>  5 files changed, 321 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/blaize/Makefile
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 30dd6347a929..601b6381ea0c 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -9,6 +9,7 @@ subdir-y +=3D apm
>  subdir-y +=3D apple
>  subdir-y +=3D arm
>  subdir-y +=3D bitmain
> +subdir-y +=3D blaize
>  subdir-y +=3D broadcom
>  subdir-y +=3D cavium
>  subdir-y +=3D exynos
> diff --git a/arch/arm64/boot/dts/blaize/Makefile b/arch/arm64/boot/dts/bl=
aize/Makefile
> new file mode 100644
> index 000000000000..595e7a350300
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_BLAIZE_BLZP1600) +=3D blaize-blzp1600-cb2.dtb
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts b/arch/ar=
m64/boot/dts/blaize/blaize-blzp1600-cb2.dts
> new file mode 100644
> index 000000000000..0bdec7e81380
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "blaize-blzp1600-som.dtsi"
> +#include <dt-bindings/net/ti-dp83867.h>
> +
> +/ {
> +	model =3D "Blaize BLZP1600 SoM1600P CB2 Development Board";
> +
> +	compatible =3D "blaize,blzp1600-cb2", "blaize,blzp1600";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200";
> +	};
> +};
> +
> +&i2c0 {
> +	clock-frequency =3D <100000>;
> +	status =3D "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency =3D <100000>;
> +	status =3D "okay";
> +};
> +
> +&i2c3 {
> +	clock-frequency =3D <100000>;
> +	status =3D "okay";
> +
> +	gpio_expander: gpio@74 {
> +		compatible =3D "ti,tca9539";
> +		reg =3D <0x74>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		gpio-line-names =3D "RSP_PIN_7",	/* GPIO_0 */
> +				  "RSP_PIN_11",	/* GPIO_1 */
> +				  "RSP_PIN_13",	/* GPIO_2 */
> +				  "RSP_PIN_15",	/* GPIO_3 */
> +				  "RSP_PIN_27",	/* GPIO_4 */
> +				  "RSP_PIN_29",	/* GPIO_5 */
> +				  "RSP_PIN_31",	/* GPIO_6 */
> +				  "RSP_PIN_33",	/* GPIO_7 */
> +				  "RSP_PIN_37",	/* GPIO_8 */
> +				  "RSP_PIN_16",	/* GPIO_9 */
> +				  "RSP_PIN_18",	/* GPIO_10 */
> +				  "RSP_PIN_22",	/* GPIO_11 */
> +				  "RSP_PIN_28",	/* GPIO_12 */
> +				  "RSP_PIN_32",	/* GPIO_13 */
> +				  "RSP_PIN_36",	/* GPIO_14 */
> +				  "TP31";	/* GPIO_15 */
> +	};
> +
> +	gpio_expander_m2: gpio@75 {
> +		compatible =3D "ti,tca9539";
> +		reg =3D <0x75>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		gpio-line-names =3D "M2_W_DIS1_N",	/* GPIO_0 */
> +				  "M2_W_DIS2_N",	/* GPIO_1 */
> +				  "M2_UART_WAKE_N",	/* GPIO_2 */
> +				  "M2_COEX3",		/* GPIO_3 */
> +				  "M2_COEX_RXD",	/* GPIO_4 */
> +				  "M2_COEX_TXD",	/* GPIO_5 */
> +				  "M2_VENDOR_PIN40",	/* GPIO_6 */
> +				  "M2_VENDOR_PIN42",	/* GPIO_7 */
> +				  "M2_VENDOR_PIN38",	/* GPIO_8 */
> +				  "M2_SDIO_RST_N",	/* GPIO_9 */
> +				  "M2_SDIO_WAKE_N",	/* GPIO_10 */
> +				  "M2_PETN1",		/* GPIO_11 */
> +				  "M2_PERP1",		/* GPIO_12 */
> +				  "M2_PERN1",		/* GPIO_13 */
> +				  "UIM_SWP",		/* GPIO_14 */
> +				  "UART1_TO_RSP";	/* GPIO_15 */
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi b/arch/a=
rm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
> new file mode 100644
> index 000000000000..efac0d6b3d60
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +
> +#include "blaize-blzp1600.dtsi"
> +
> +/ {
> +	memory@1000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x00001000 0xfffff000>;
> +	};
> +};
> +
> +/* i2c4 bus is available only on the SoM, not on the board */
> +&i2c4 {
> +	clock-frequency =3D <100000>;
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi b/arch/arm64=
/boot/dts/blaize/blaize-blzp1600.dtsi
> new file mode 100644
> index 000000000000..ad1e502559d8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Blaize, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/reset/blaize,blzp1600-reset.h>
> +#include <dt-bindings/clock/blaize,blzp1600-clk.h>
> +
> +/ {
> +	interrupt-parent =3D <&gic>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <1>;
> +
> +	cpus {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x0 0x0>;
> +			next-level-cache =3D <&l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			enable-method =3D "psci";
> +			reg =3D <0x0 0x1>;
> +			next-level-cache =3D <&l2>;
> +		};
> +
> +		l2: l2-cache0 {
> +			compatible =3D "cache";
> +			cache-level =3D <2>;
> +			cache-unified;
> +		};
> +	};
> +
> +	timer {
> +		compatible =3D "arm,armv8-timer";
> +		interrupts =3D /* Physical Secure PPI */
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
> +		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
> +		method =3D "smc";
> +	};
> +
> +	pmu {
> +		compatible =3D "arm,cortex-a53-pmu";
> +		interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity =3D <&cpu0>, <&cpu1>;
> +	};
> +
> +	sram@0 {
> +		/*
> +		 * On BLZP1600 there is no general purpose (non-secure) SRAM.
> +		 * A small DDR memory space has been reserved for general use.
> +		 */
> +		compatible =3D "mmio-sram";
> +		reg =3D <0x0 0x00000000 0x00001000>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges =3D <0 0x0 0x00000000 0x1000>;
> +
> +		/* SCMI reserved buffer space on DDR space */
> +		scmi0_shm: scmi-sram@800 {
> +			compatible =3D "arm,scmi-shmem";
> +			reg =3D <0x800 0x80>;
> +		};
> +	};
> +
> +	firmware {
> +		scmi {
> +			compatible =3D "arm,scmi-smc";
> +			arm,smc-id =3D <0x82002000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			shmem =3D <&scmi0_shm>;
> +
> +			scmi_clk: protocol@14 {
> +				reg =3D <0x14>;
> +				#clock-cells =3D <1>;
> +			};
> +
> +			scmi_rst: protocol@16 {
> +				reg =3D <0x16>;
> +				#reset-cells =3D <1>;
> +			};
> +		};
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		gic: interrupt-controller@200410000 {
> +			compatible =3D "arm,gic-400";
> +			#interrupt-cells =3D <3>;
> +			#address-cells =3D <0>;
> +			interrupt-controller;
> +			reg =3D <0x2 0x00410000 0x20000>,
> +			      <0x2 0x00420000 0x20000>,
> +			      <0x2 0x00440000 0x20000>,
> +			      <0x2 0x00460000 0x20000>;
> +			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x3) |
> +						 IRQ_TYPE_LEVEL_LOW)>;
> +		};
> +
> +		uart0: serial@2004d0000 {
> +			compatible =3D "ns16550a";
> +			reg =3D <0x2 0x004d0000 0x1000>;
> +			clocks =3D <&scmi_clk BLZP1600_UART0_CLK>;
> +			resets =3D <&scmi_rst BLZP1600_UART0_RST>;
> +			reg-shift =3D <2>;
> +			interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		uart1: serial@2004e0000 {
> +			compatible =3D "ns16550a";
> +			reg =3D <0x2 0x004e0000 0x1000>;
> +			clocks =3D <&scmi_clk BLZP1600_UART1_CLK>;
> +			resets =3D <&scmi_rst BLZP1600_UART1_RST>;
> +			reg-shift =3D <2>;
> +			interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c0: i2c@2004f0000 {
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x2 0x004f0000 0x1000>;
> +			interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&scmi_clk BLZP1600_I2C0_CLK>;
> +			resets =3D <&scmi_rst BLZP1600_I2C0_RST>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c1: i2c@200500000 {
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x2 0x00500000 0x1000>;
> +			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&scmi_clk BLZP1600_I2C1_CLK>;
> +			resets =3D <&scmi_rst BLZP1600_I2C1_RST>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c2: i2c@200510000 {
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x2 0x00510000 0x1000>;
> +			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&scmi_clk BLZP1600_I2C2_CLK>;
> +			resets =3D <&scmi_rst BLZP1600_I2C2_RST>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c3: i2c@200520000 {
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x2 0x00520000 0x1000>;
> +			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&scmi_clk BLZP1600_I2C3_CLK>;
> +			resets =3D <&scmi_rst BLZP1600_I2C3_RST>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		i2c4: i2c@200530000 {
> +			compatible =3D "snps,designware-i2c";
> +			reg =3D <0x2 0x00530000 0x1000>;
> +			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&scmi_clk BLZP1600_I2C4_CLK>;
> +			resets =3D <&scmi_rst BLZP1600_I2C4_RST>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			status =3D "disabled";
> +		};
> +
> +		arm_cc712: crypto@200550000 {
> +			compatible =3D "arm,cryptocell-712-ree";
> +			reg =3D <0x2 0x00550000 0x1000>;
> +			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&scmi_clk 7>;
> +		};
> +	};
> +};
> --=20
> 2.34.1
>=20

--kfuG2k3Bnxl7jhEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZikiGQAKCRB4tDGHoIJi
0ps5AP4wP6aFnR7sdpB4TDe+cVIARtYf81ONJTxyc2NCu9m3OQD+I3D8Cbwt7nPd
QhCjt92qOe3wd66cCBpfGvL61Z0NYgk=
=LUdV
-----END PGP SIGNATURE-----

--kfuG2k3Bnxl7jhEx--

