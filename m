Return-Path: <linux-kernel+bounces-57253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D058884D5BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BBB1F210D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099DC149DFE;
	Wed,  7 Feb 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PUVxTqRN"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851A149DE1;
	Wed,  7 Feb 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344476; cv=none; b=G8lV43u3Wp+m/YNSfXd1AGUBBXKVTg/rZjR8dD38fxj/aospaVCXxUZjrw8JEA4q0uCmLV1X6NWjtM6wf6TNKgqOGiXe4t6uHxby7e5TJvazynZPVVW+UKyISVKTHpubbnLiTJiDOQ8Og6YvOfvTfmiWn9lk1vTMaiENLKTXtBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344476; c=relaxed/simple;
	bh=MwKKEGQFdFPG17wTp+h4gYVVhNXo2sy1ZgK90C/wlfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tBWV0/PC1/DaEzb7RI5r9JPRhlhApvOkyYfbOJz02Z1lNcyn7l4PufgP6r+bPHSmX1DwrbbJYg1ApU+i8B9n/iWg49AEOaEeioEY6+c9DEYYQnfqfru/QtP3OfhHVPlEUg4KG0F7R+wCV0Jn+KxrL7P6j85CzF3+/v7CjMUsX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PUVxTqRN; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417MKeTo092705;
	Wed, 7 Feb 2024 16:20:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707344440;
	bh=eJhrs04xgEpmz99w4LZjg0w+qu2XVcprjfFaFuIENRs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=PUVxTqRNaX/jUnmKv47wB7SCWj2JxwopdOptbRF1OTFKZJYiqq0vMmAIaxFgVCh94
	 39oahiqbKdv8cFNCMeTwR95k5Lfb+nqMo7YAEcmT7kG38Lv1ParELxzjDHP+jctdTh
	 ahBXLUPGnrBOrjZC6eOvJOQgBbBvvyilY9tpWj+w=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417MKerg046097
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 16:20:40 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 16:20:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 16:20:40 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417MKdtZ043771;
	Wed, 7 Feb 2024 16:20:39 -0600
Message-ID: <acd3c7f2-930d-46c0-9924-9775e9795fca@ti.com>
Date: Wed, 7 Feb 2024 16:20:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: am62-phyboard-lyra: Add overlay to enable
 a GPIO fan
Content-Language: en-US
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
References: <20240207172820.478332-1-nmorrisson@phytec.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240207172820.478332-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/7/24 11:28 AM, Nathan Morrisson wrote:
> The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
> header and sets the fan to turn on at 65C.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |  1 +
>   .../ti/k3-am62-phyboard-lyra-gpio-fan.dtso    | 51 +++++++++++++++++++
>   2 files changed, 52 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 52c1dc910308..379fb4f31a1f 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-mallow.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am62-phyboard-lyra-gpio-fan.dtbo

Why not call this k3-am625-phyboard-lyra-gpio-fan.dtbo to match the
name of the base board it applies to better?

Andrew

>   
>   # Boards with AM62Ax SoC
>   dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> new file mode 100644
> index 000000000000..9c05748bdd9d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-phyboard-lyra-gpio-fan.dtso
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2024 PHYTEC America LLC
> + * Author: Garrett Giordano <ggiordano@phytec.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/thermal/thermal.h>
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	fan: gpio-fan {
> +		compatible = "gpio-fan";
> +		gpio-fan,speed-map = <0 0 8600 1>;
> +		gpios = <&main_gpio0 40 GPIO_ACTIVE_LOW>;
> +		#cooling-cells = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio_fan_pins_default>;
> +		status = "okay";
> +	};
> +};
> +
> +&main_pmx0 {
> +	gpio_fan_pins_default: gpio-fan-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x0a4, PIN_OUTPUT, 7) /* (M22) GPMC0_DIR.GPIO0_40 */
> +		>;
> +	};
> +};
> +
> +&thermal_zones {
> +	main0_thermal: main0-thermal {
> +		trips {
> +			main0_thermal_trip0: main0-thermal-trip {
> +				temperature = <65000>;  /* millicelsius */
> +				hysteresis = <2000>;    /* millicelsius */
> +				type = "active";
> +			};
> +		};
> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&main0_thermal_trip0>;
> +				cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +	};
> +};

