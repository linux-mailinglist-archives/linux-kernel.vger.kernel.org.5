Return-Path: <linux-kernel+bounces-2899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68B18163F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E9F1C21EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3920E4;
	Mon, 18 Dec 2023 01:09:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A6F1FA3;
	Mon, 18 Dec 2023 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA0F01FB;
	Sun, 17 Dec 2023 17:10:24 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6A413F738;
	Sun, 17 Dec 2023 17:09:36 -0800 (PST)
Date: Mon, 18 Dec 2023 01:09:26 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
 <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Marc Kleine-Budde <mkl@pengutronix.de>,
 John Watts <contact@jookia.org>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 3/3] riscv: dts: allwinner: d1: Add thermal sensor
Message-ID: <20231218010926.10e15c57@minigeek.lan>
In-Reply-To: <20231217210629.131486-4-bigunclemax@gmail.com>
References: <20231217210629.131486-1-bigunclemax@gmail.com>
	<20231217210629.131486-4-bigunclemax@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 00:06:24 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

Hi,

> From: Maxim Kiselev <bigunclemax@gmail.com>
> 
> This patch adds a thermal sensor controller node for the D1/T113s.
> Also it adds a THS calibration data cell to efuse node.
> 
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> ---
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index 5a9d7f5a75b4..6f5427d9cfbf 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -166,6 +166,19 @@ gpadc: adc@2009000 {
>  			#io-channel-cells = <1>;
>  		};
>  
> +		ths: thermal-sensor@2009400 {
> +			compatible = "allwinner,sun20i-d1-ths";
> +			reg = <0x02009400 0x400>;
> +			interrupts = <SOC_PERIPHERAL_IRQ(58) IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_THS>;
> +			clock-names = "bus";
> +			resets = <&ccu RST_BUS_THS>;
> +			nvmem-cells = <&ths_calibration>;
> +			nvmem-cell-names = "calibration";
> +			status = "disabled";

Any reason this is disabled? We typically don't disable those internal
devices in the SoC .dtsi, the THS is one example (check the instances
in other SoCs' .dtsi files).

The rest looks alright, compared to the manual, so with this line
removed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> +			#thermal-sensor-cells = <0>;
> +		};
> +
>  		dmic: dmic@2031000 {
>  			compatible = "allwinner,sun20i-d1-dmic",
>  				     "allwinner,sun50i-h6-dmic";
> @@ -415,6 +428,10 @@ sid: efuse@3006000 {
>  			reg = <0x3006000 0x1000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			ths_calibration: thermal-sensor-calibration@14 {
> +				reg = <0x14 0x4>;
> +			};
>  		};
>  
>  		crypto: crypto@3040000 {


