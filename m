Return-Path: <linux-kernel+bounces-10806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E4E81DC05
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62DD31C203DC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98BD2FA;
	Sun, 24 Dec 2023 18:59:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C1D285;
	Sun, 24 Dec 2023 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193c.versanet.de ([94.134.25.60] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rHThJ-0005pM-Gb; Sun, 24 Dec 2023 19:59:37 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Trevor Woerner <twoerner@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: rockchip: dts: rk3328-rock-pi-e: enable GbE eth
Date: Sun, 24 Dec 2023 19:59:36 +0100
Message-ID: <2404910.8hb0ThOEGa@diego>
In-Reply-To: <20231221062244.11871-1-twoerner@gmail.com>
References: <20231221062244.11871-1-twoerner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Trevor,

Am Donnerstag, 21. Dezember 2023, 07:22:43 CET schrieb Trevor Woerner:
> Adjust the device-tree to get the GbE interface working using a patch found
> on the Radxa forum.
> 
> Link: https://forum.radxa.com/t/rock-pi-e-board-version-1-21-ethhernet-not-working-in-armbian/15061/3
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---

> @@ -165,15 +165,17 @@ mdio {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		rtl8211e: ethernet-phy@1 {
> +		rtl8211f: ethernet-phy@1 {
> +			compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";

skipping through that thread, it looks like there are variants of the
board with one of the rtl8211e _or_ rtl8211f phys.

So while the "ethernet-phy-ieee802.3-c22" compatible would work for both,
the "ethernet-phy-id001c.c916" compat effectively disables phy- probing.
So applying this patch would effectively disable ethernet support on those
older rock-pi-e boards?

In a similar context concerning boards using different phys, it was
suggested [0] that the bootloader should modify the dt it passes to the
kernel to provide the correct phy id.


>  			reg = <1>;
>  			pinctrl-0 = <&eth_phy_int_pin>, <&eth_phy_reset_pin>;
>  			pinctrl-names = "default";
>  			interrupt-parent = <&gpio1>;
>  			interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
> -			reset-assert-us = <10000>;
> -			reset-deassert-us = <50000>;
> +			reset-assert-us = <20000>;
> +			reset-deassert-us = <100000>;

I guess for those we can consolidate onto the "slower" ones in the kernel though.


>  			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
> +			max-speed = <1000>;
>  		};
>  	};
>  };
> 


Heiko

[0] https://lore.kernel.org/all/ecbdcfb7-32ab-45cc-991a-982c52bf4b14@gmail.com/




