Return-Path: <linux-kernel+bounces-10394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE581D3D0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4788B283887
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98030CA78;
	Sat, 23 Dec 2023 11:44:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3FCA53;
	Sat, 23 Dec 2023 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b78.versanet.de ([83.135.91.120] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rH0Q9-0001Y7-IL; Sat, 23 Dec 2023 12:43:57 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Mark Yao <markyao0591@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 Manuel Traut <manut@mecka.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: Fix some dtb-check warnings
Date: Sat, 23 Dec 2023 12:43:56 +0100
Message-ID: <2337863.6tgchFWduM@diego>
In-Reply-To: <20231222-pinetab2-v1-5-e148a7f61bd1@mecka.net>
References:
 <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
 <20231222-pinetab2-v1-5-e148a7f61bd1@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 22. Dezember 2023, 12:05:45 CET schrieb Manuel Traut:
> devicetree checks show some warnings:
> 
> video-codec@fdea0400: 'interrupt-names' is a required property
> from schema $id: http://devicetree.org/schemas/media/rockchip-vpu.yaml#
> 
> hdmi@fe0a0000: Unevaluated properties are not allowed ('power-domains' were unexpected)
> from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi.yaml#
> 
> i2s@fe420000: reset-names:0: 'm' is not one of ['tx-m', 'rx-m']
> from schema $id: http://devicetree.org/schemas/sound/rockchip,i2s-tdm.yaml#
> 
> phy@fe870000: 'power-domains' is a required property
> from schema $id: http://devicetree.org/schemas/phy/rockchip-inno-csi-dphy.yaml#
> 
> Fix them by
>   - setting a interrupt-name for the video-codec
>   - remove the unevaluated power-domain property from hdmi
>   - set reset-names according to the spec for i2s
>   - add a power-domain property for the CSI phy
> 
> Signed-off-by: Manuel Traut <manut@mecka.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index c19c0f1b3778..651156759582 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -597,6 +597,7 @@ vpu: video-codec@fdea0400 {
>  		compatible = "rockchip,rk3568-vpu";
>  		reg = <0x0 0xfdea0000 0x0 0x800>;
>  		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "vdpu";
>  		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
>  		clock-names = "aclk", "hclk";
>  		iommus = <&vdpu_mmu>;
> @@ -819,7 +820,6 @@ hdmi: hdmi@fe0a0000 {
>  		clock-names = "iahb", "isfr", "cec", "ref";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&hdmitx_scl &hdmitx_sda &hdmitxm0_cec>;
> -		power-domains = <&power RK3568_PD_VO>;

are you really sure that the hdmi controller is _not_ part of
the VO powerdomain? I.e. Depending on that knowledge it could
also simply be necessary to add the property to the binding.


Heiko



