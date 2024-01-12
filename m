Return-Path: <linux-kernel+bounces-24860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9D82C399
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2AD21C20D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08174E35;
	Fri, 12 Jan 2024 16:32:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EACA59172;
	Fri, 12 Jan 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 057191FB;
	Fri, 12 Jan 2024 08:33:37 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2AD3F67D;
	Fri, 12 Jan 2024 08:32:48 -0800 (PST)
Date: Fri, 12 Jan 2024 16:32:45 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: anarsoul@gmail.com, tiny.windzz@gmail.com, linux-sunxi@lists.linux.dev,
 rafael@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 daniel.lezcano@linaro.org, peter.griffin@linaro.org, klimov.linux@gmail.com
Subject: Re: [PATCH RESEND] arm64: dts: allwinner: a64: Add thermal trip
 points for GPU
Message-ID: <20240112163245.3be1aeaa@donnerap.manchester.arm.com>
In-Reply-To: <20240101000008.65747-1-alexey.klimov@linaro.org>
References: <20240101000008.65747-1-alexey.klimov@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jan 2024 00:00:08 +0000
Alexey Klimov <alexey.klimov@linaro.org> wrote:

Hi Alexey,

> Without trip points for GPU, the following errors are printed in the
> dmesg log and the sun8i-thermal driver fails to load:
> 
> thermal_sys: Failed to find 'trips' node
> thermal_sys: Failed to find trip points for thermal-sensor id=1
> sun8i-thermal: probe of 1c25000.thermal-sensor failed with error -22

Regardless of whether we should really *require* trip points (what Icenowy
wanted to fix), I think it's good to have those values in the DT.

The only question I have: where do those values come from? Is this coming
from some BSP, or some downstream repository? If there are multiple
sources: are the values across them consistent?
I have seen a lot careless and unreflecting copy&paste in the past, so
just want to make sure we get the right values.

Cheers,
Andre

> When thermal zones are defined, trip points definitions are mandatory.
> Trip values for the GPU are assumed to be the same values as the CPU
> ones. The available specs do not provide any hints about thermal regimes
> for the GPU and it seems GPU is implemented on the same die as the CPU.
> 
> Tested on Pine a64+.
> 
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 62f45f71ec65..07963eea1bf0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -243,6 +243,29 @@ gpu0_thermal: gpu0-thermal {
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 1>;
> +
> +			trips {
> +				gpu0_alert0: gpu0_alert0 {
> +					/* milliCelsius */
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu0_alert1: gpu0_alert1 {
> +					/* milliCelsius */
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				gpu0_crit: gpu0_crit {
> +					/* milliCelsius */
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
>  		};
>  
>  		gpu1_thermal: gpu1-thermal {
> @@ -250,6 +273,29 @@ gpu1_thermal: gpu1-thermal {
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 2>;
> +
> +			trips {
> +				gpu1_alert0: gpu1_alert0 {
> +					/* milliCelsius */
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu1_alert1: gpu1_alert1 {
> +					/* milliCelsius */
> +					temperature = <90000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				gpu1_crit: gpu1_crit {
> +					/* milliCelsius */
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
>  		};
>  	};
>  


