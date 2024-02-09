Return-Path: <linux-kernel+bounces-59019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44E84EFE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CB428A07C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87C56B88;
	Fri,  9 Feb 2024 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="VCk01+Sn"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75E56B7F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707456395; cv=none; b=mpHRC6p84xw97kbmPoSTmCXUjZD+Bz9xnFESTnIj+UaKF3vyVoFwYsrxjKIBSCsiRH3Mih96CgGBmZPagwn7ZS0RPLW8SHd20QJiKHT9SZ4s6f3V/w1hXRthSA/XLhEwIi2QGn/mVcTa3RiyFf2qhYWS5wBUxuYxt+ZFQVQt7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707456395; c=relaxed/simple;
	bh=LU343LXx/knwbBD2JmFNNAEoZvmvYoXV11fwUg6/Kgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kyPbwkNsCLaiz1RrIgrMnp1F4Bl7/drgCtppN8sQK8TfjUuO7LNyBV5zoCkVANt6V/+V3XEWopsaQ47Xuznhynxp6KyDWDsjY+s6BEYSmoZTy81jviryU+w1xplr+0pcH4+5VktGjaZnUDFuACjFHU3QChHNAErtlRz9MsgJntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=VCk01+Sn; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1707456384; x=1710048384;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LU343LXx/knwbBD2JmFNNAEoZvmvYoXV11fwUg6/Kgs=;
	b=VCk01+Sn7xbSV42o+VCEkRydDN1EJ8wcTz8Pq0DuM+/KaxtVPpRnAimALIJyYXAY
	opQOlZ4EmuTgbj1NWonEUz/zQjepeFss1Gb5nzZIGez/iuHPItqLg83O34OUgv/h
	rVsWv9JOn+payoNnGzDQBY8CsjdjQC9mtxQ/OkRG7vU=;
X-AuditID: ac14000a-fbefe7000000290d-23-65c5b7801676
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 20.43.10509.087B5C56; Fri,  9 Feb 2024 06:26:24 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 9 Feb 2024
 06:26:20 +0100
Message-ID: <1ab1d500-1429-4dc2-b31a-fc24d171206f@phytec.de>
Date: Fri, 9 Feb 2024 06:26:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: am62-phyboard-lyra: Add overlay to
 enable a GPIO fan
Content-Language: en-US
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <upstream@lists.phytec.de>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240209002916.1284433-1-nmorrisson@phytec.com>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240209002916.1284433-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWyRpKBR7dh+9FUg5mThCzW7D3HZDH/yDlW
	i+WfZ7Nb9L14yGyx6fE1VovLu+awWbz5cZbJ4kPjZjaL1r1H2C2636lb/D/7gd2B22PTqk42
	jzvX9rB5bF5S79Hf3cLq8efiO1aP4ze2M3l83iQXwB7FZZOSmpNZllqkb5fAlXFg2wamgjXS
	FSeetLI2MK4X62Lk5JAQMJF4cmg1cxcjF4eQwGImia93JzFCOHcYJX69n8oEUsUrYCOxceMZ
	dhCbRUBF4s++fkaIuKDEyZlPWEBsUQF5ifu3ZoDVCAvEScx6e5sNxGYWEJe49WQ+E8hQEYHt
	jBJrFi8CW8cs0MYo8WBDN1AVB9A6G4nVU1VAGtgE1CXubPjGCmJzCthKXO56ywIxyEJi8ZuD
	7BC2vMT2t3OYQWwhIPvFpeUsEO/IS0w795oZwg6V2PplO9MERuFZSG6dheSmWUjGzkIydgEj
	yypGodzM5OzUosxsvYKMypLUZL2U1E2MoNgTYeDawdg3x+MQIxMH4yFGCQ5mJRHekCVHUoV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwWiktOinUsY5n
	iiszQy1PjdexNTMkluzkEb0uY3Xx3uYfpTNc9K5HGd0t6O244b7s7Opv1xco5Ty/OyO2+Xux
	+QZeywmrihepfLZm+CeULDrhWfF/xsojInP2ik+arP/p4xGFq9+UvleI+hhEHHrY8Nzi8QXP
	z01xs5Un72X+qyB7X2W+1P0pO5RYijMSDbWYi4oTAa2behSrAgAA

Hi Nathan,

Am 09.02.24 um 01:29 schrieb Nathan Morrisson:
> The phyBOARD-Lyra has a GPIO fan header. This overlay enables the fan
> header and sets the fan to turn on at 65C.
>
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> ---
> v2:
> - Change overlay name from k3-am62-... to k3-am62x-...
> - Add compile time test
>
>   arch/arm64/boot/dts/ti/Makefile               |  3 ++
>   .../ti/k3-am62x-phyboard-lyra-gpio-fan.dtso   | 51 +++++++++++++++++++
>   2 files changed, 54 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 52c1dc910308..bfeb496d5039 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dev.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-mallow.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-yavia.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am62x-phyboard-lyra-gpio-fan.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
>   
>   # Boards with AM62Ax SoC
> @@ -87,6 +88,8 @@ k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
>   	k3-am625-beagleplay-csi2-ov5640.dtbo
>   k3-am625-beagleplay-csi2-tevi-ov5640-dtbs := k3-am625-beagleplay.dtb \
>   	k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
> +k3-am625-phyboard-lyra-gpio-fan-dtbs := k3-am625-phyboard-lyra-rdk.dtb \
> +	k3-am62x-phyboard-lyra-gpio-fan.dtbo
>   k3-am625-sk-csi2-imx219-dtbs := k3-am625-sk.dtb \
>   	k3-am62x-sk-csi2-imx219.dtbo
>   k3-am625-sk-csi2-ov5640-dtbs := k3-am625-sk.dtb \
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso
> new file mode 100644
> index 000000000000..9c05748bdd9d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-phyboard-lyra-gpio-fan.dtso
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

There is no need to set the status. If no status is present, it also 
indicates that the node is activated.

With this change,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>


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

