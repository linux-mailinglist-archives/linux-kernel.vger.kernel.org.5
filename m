Return-Path: <linux-kernel+bounces-89428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887F86F03D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CF71F22309
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C71754E;
	Sat,  2 Mar 2024 11:25:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AB79C8;
	Sat,  2 Mar 2024 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709378749; cv=none; b=ZI4kgepFtQA0Kukq5BOztKcKJxCngasqlDOMpbJgn9C7DtoARR0cKicdWqlvlrchZ+/HoLCuCxtNqxrZ1d++69btvWdnrX+EAgykPhp6mO9Oi0XuMpFkDTaBF6JYqJxgPNzY5lajle1c9dDMPgJy86Vi711Cg8EKhFhv8O//RRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709378749; c=relaxed/simple;
	bh=sMqS1fumc/mbQ7Gx2OwAlS8gdIKqwndhQBFUGCp6lfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8DlZr9FV12bli4+hSGHkFxo3lqZ41ac/nmgPHOHgak1cw2VvqJXiJ02Rj/6hDzLiOBPwb1e7SRuPdbqzyB8NhLBYmQOUPvOhxFTc9x0uFJQRe9WCI8jjGN0WxiLyxoBtX/QWXAg9I/ugqF+gcGqFvHb+oVdyizffnwZQKEE+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rgNUb-0004tX-MU; Sat, 02 Mar 2024 12:25:25 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alexey Charkov <alchark@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
Subject:
 Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal monitoring
 on RK3588
Date: Sat, 02 Mar 2024 12:25:24 +0100
Message-ID: <6279836.31r3eYUQgx@phil>
In-Reply-To: <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
References:
 <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 29. Februar 2024, 20:26:32 CET schrieb Alexey Charkov:
> Include thermal zones information in device tree for RK3588 variants.
> 
> This also enables the TSADC controller unconditionally on all boards
> to ensure that thermal protections are in place via throttling and
> emergency reset, once OPPs are added to enable CPU DVFS.
> 
> The default settings (using CRU as the emergency reset mechanism)
> should work on all boards regardless of their wiring, as CRU resets
> do not depend on any external components. Boards that have the TSHUT
> signal wired to the reset line of the PMIC may opt to switch to GPIO
> tshut mode instead (rockchip,hw-tshut-mode = <1>;)
> 
> It seems though that downstream kernels don't use that, even for
> those boards where the wiring allows for GPIO based tshut, such as
> Radxa Rock 5B [1], [2], [3]
> 
> [1] https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts#L540
> [2] https://github.com/radxa/kernel/blob/stable-5.10-rock5/arch/arm64/boot/dts/rockchip/rk3588s.dtsi#L5433
> [3] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pdf page 11 (TSADC_SHUT_H)
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 176 +++++++++++++++++++++++++++++-
>  1 file changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> index 36b1b7acfe6a..9bf197358642 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/reset/rockchip,rk3588-cru.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/ata/ahci.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	compatible = "rockchip,rk3588";
> @@ -2225,7 +2226,180 @@ tsadc: tsadc@fec00000 {
>  		pinctrl-1 = <&tsadc_shut>;
>  		pinctrl-names = "gpio", "otpout";
>  		#thermal-sensor-cells = <1>;
> -		status = "disabled";
> +		status = "okay";
> +	};

so I've skimmed over the general discussion, though don't have a hard
opinion in either direction yet. Still there are some low-hanging fruit:

- having the thermal-zones addition in a separate patch would allow to
  merge the obvious stuff, while this discussion is still ongoing
- status=okay in a soc dtsi is wrong, because okay is the default status
  so if anything the status property should be removed

In general I'm not that much of a fan of things just working implicitly.
So somehow, when someone submits a board devicetree, I expect them to
having ensured stuff is enabled somewhat ok. So even seeing a simple

	&tsadc {
		status = "okay"
	};

suggests that they have at least noticed the existence of thermal stuff.


At least that is where my thought-process is at the moment ;-)


Heiko

> +	thermal_zones: thermal-zones {
> +		/* sensor near the center of the SoC */
> +		package_thermal: package-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 0>;
> +
> +			trips {
> +				package_crit: package-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 0 and 1 */
> +		bigcore0_thermal: bigcore0-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 1>;
> +
> +			trips {
> +				/* threshold to start collecting temperature
> +				 * statistics e.g. with the IPA governor
> +				 */
> +				bigcore0_alert0: bigcore0-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				/* actual control temperature */
> +				bigcore0_alert1: bigcore0-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore0_crit: bigcore0-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore0_alert1>;
> +					cooling-device =
> +						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between A76 cores 2 and 3 */
> +		bigcore2_thermal: bigcore2-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 2>;
> +
> +			trips {
> +				/* threshold to start collecting temperature
> +				 * statistics e.g. with the IPA governor
> +				 */
> +				bigcore2_alert0: bigcore2-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				/* actual control temperature */
> +				bigcore2_alert1: bigcore2-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				bigcore2_crit: bigcore2-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&bigcore2_alert1>;
> +					cooling-device =
> +						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor between the four A55 cores */
> +		little_core_thermal: littlecore-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 3>;
> +
> +			trips {
> +				/* threshold to start collecting temperature
> +				 * statistics e.g. with the IPA governor
> +				 */
> +				littlecore_alert0: littlecore-alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				/* actual control temperature */
> +				littlecore_alert1: littlecore-alert1 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				littlecore_crit: littlecore-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&littlecore_alert1>;
> +					cooling-device =
> +						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		/* sensor near the PD_CENTER power domain */
> +		center_thermal: center-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 4>;
> +
> +			trips {
> +				center_crit: center-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 5>;
> +
> +			trips {
> +				gpu_crit: gpu-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		npu_thermal: npu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +			thermal-sensors = <&tsadc 6>;
> +
> +			trips {
> +				npu_crit: npu-crit {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
>  	};
>  
>  	saradc: adc@fec10000 {
> 
> 





