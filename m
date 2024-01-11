Return-Path: <linux-kernel+bounces-23224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BE782A92A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DBA284868
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A9F9F3;
	Thu, 11 Jan 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KaF6d0Hg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DDE558;
	Thu, 11 Jan 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7509EC85;
	Thu, 11 Jan 2024 09:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704961903;
	bh=ceQsDzx9kmf/zRBGPdmkZuFW/ytCU3PmUX8H/digl28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaF6d0HgOgcGH5ytchcHR12iaXtbe9jS/8O7JFfKq56ECJLgqHOMeT+x7+klEOV6w
	 k2L2sKF6iMPG1hTMKE57TxRwoEjcl4NMzoLaLCdsgTHNsU97S6JhvB0fKVHW5HzMaE
	 9L05waBXzHRRISrXXwIvUmqavUeChgPbWEMEXJNw=
Date: Thu, 11 Jan 2024 10:32:55 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Florian Sylvestre <fsylvestre@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	Louis Kuo <louis.kuo@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Phi-bang Nguyen <pnguyen@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 5/5] arm64: dts: mediatek: mt8365: Add support for
 camera
Message-ID: <20240111083255.GC30988@pendragon.ideasonboard.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
 <20240110141443.364655-6-jstephan@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110141443.364655-6-jstephan@baylibre.com>

Hi Julien,

Thank you for the patch.

On Wed, Jan 10, 2024 at 03:14:42PM +0100, Julien Stephan wrote:
> Add base support for cameras for mt8365 platforms. This requires nodes
> for the sensor interface, camsv, and CSI receivers.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi | 128 +++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index 24581f7410aa..9059b2f83b83 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/power/mediatek,mt8365-power.h>
> +#include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
>  
>  / {
>  	compatible = "mediatek,mt8365";
> @@ -703,6 +704,133 @@ ethernet: ethernet@112a0000 {
>  			status = "disabled";
>  		};
>  
> +		camsv1: camsv@15050000 {
> +			compatible = "mediatek,mt8365-camsv";
> +			reg = <0 0x15050000 0 0x0040>,
> +			      <0 0x15050208 0 0x0020>,
> +			      <0 0x15050400 0 0x0100>;
> +			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&camsys CLK_CAM>,
> +				 <&camsys CLK_CAMTG>,
> +				 <&camsys CLK_CAMSV0>;
> +			clock-names = "cam", "camtg", "camsv";
> +			iommus = <&iommu M4U_PORT_CAM_IMGO>;
> +			mediatek,larb = <&larb2>;
> +			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@0 {
> +					reg = <0>;
> +					camsv1_endpoint: endpoint {
> +						remote-endpoint =
> +							<&seninf_camsv1_endpoint>;

I think you can keep this on a single line. Same below.

> +					};
> +				};
> +			};
> +		};
> +
> +		camsv2: camsv@15050800 {
> +			compatible = "mediatek,mt8365-camsv";
> +			reg = <0 0x15050800 0 0x0040>,
> +			      <0 0x15050228 0 0x0020>,
> +			      <0 0x15050C00 0 0x0100>;

Lower-case hex constants.

> +			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&camsys CLK_CAM>,
> +				 <&camsys CLK_CAMTG>,
> +				 <&camsys CLK_CAMSV1>;
> +			clock-names = "cam", "camtg", "camsv";
> +			iommus = <&iommu M4U_PORT_CAM_IMGO>;
> +

Nitpicking, camsv doesn't have a blank line here. I'm fine either way,
but please do the same for both nodes.

> +			mediatek,larb = <&larb2>;
> +			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@0 {
> +					reg = <0>;
> +					camsv2_endpoint: endpoint {
> +						remote-endpoint =
> +							<&seninf_camsv2_endpoint>;
> +					};
> +				};
> +			};
> +		};
> +
> +		seninf: seninf@15040000 {

This should go before the two camsv instances to keep nodes sorted by
address. The camsv1, camsv2 and seninf nodes need to be moved further
down for the same reason.

> +			compatible = "mediatek,mt8365-seninf";
> +			reg = <0 0x15040000 0 0x6000>;
> +			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&camsys CLK_CAM_SENIF>,
> +				 <&topckgen CLK_TOP_SENIF_SEL>;
> +			clock-names = "camsys", "top_mux";
> +
> +			power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
> +
> +			phys = <&mipi_csi0 PHY_TYPE_DPHY>, <&mipi_csi1>;
> +			phy-names = "csi0", "csi1";
> +
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +				};
> +
> +				port@4 {
> +					reg = <4>;
> +					seninf_camsv1_endpoint: endpoint {
> +						remote-endpoint =
> +							<&camsv1_endpoint>;
> +					};
> +				};
> +
> +				port@5 {
> +					reg = <5>;
> +					seninf_camsv2_endpoint: endpoint {
> +						remote-endpoint =
> +							<&camsv2_endpoint>;
> +					};
> +				};
> +			};
> +		};
> +
> +		mipi_csi0: mipi-csi0@11c10000 {
> +			compatible = "mediatek,mt8365-csi-rx";
> +			reg = <0 0x11C10000 0 0x2000>;

Lower-case hex constants.

> +			status = "disabled";
> +			num-lanes = <4>;
> +			#phy-cells = <1>;
> +		};
> +
> +		mipi_csi1: mipi-csi1@11c12000 {
> +			compatible = "mediatek,mt8365-csi-rx";
> +			reg = <0 0x11C12000 0 0x2000>;

Lower-case hex constants.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			phy-type = <PHY_TYPE_DPHY>;
> +			status = "disabled";
> +			num-lanes = <4>;
> +			#phy-cells = <0>;
> +		};
> +
>  		u3phy: t-phy@11cc0000 {
>  			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
>  			#address-cells = <1>;

-- 
Regards,

Laurent Pinchart

