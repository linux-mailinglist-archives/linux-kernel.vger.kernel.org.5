Return-Path: <linux-kernel+bounces-66283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E478559B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261DA1C24482
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5F79F2;
	Thu, 15 Feb 2024 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H1WD5Njm"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41B17C8;
	Thu, 15 Feb 2024 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707970676; cv=none; b=f9ejx9l/3ru7OoydOoMN0NCv3KIFBMyLgB7GIvAqLEr/1ADPYf5eo+ScI/8wuI4ArU/Q42iOXFdUI84RBXPSLmB3I9BP9ZDp3JuMgzPSJOmiE0OQwg/AgpjjyDuAZwQfd6qdZja1O8UQJ1q6ac3A9K5aqvEvrj58+KVW/vP8jC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707970676; c=relaxed/simple;
	bh=ZD8mgUoGZ9LuNUBrQoLP9k3Mcl+ZrUOcZSgTSYVRlDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TQu3MygtcjU7OzWGliaqFx/kPXgD1YZRf4Qp/t+O+yMBu8JvY7PSq6wD5ocASxyWAwsXwHFzvJ1Lpai+JBVxPPKQqF4kBLDUJUucvuuBafcYCtOgCNx7iF7zHvZdIGIQkNolHs+uSqsDNaXKPb9W/KM7jg0pumH8qNPDCSGpKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H1WD5Njm; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F4HEv0007469;
	Wed, 14 Feb 2024 22:17:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707970634;
	bh=Blh+w72b/pcek/m3Fb92pQ9DCthY9zPpigNvFxTetZI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=H1WD5NjmeIg+S+AbXOlTk9Z2IJeqPqi+p6fEmaT6M426c1bimH7/VLBV8+E0KWpbJ
	 k+A9W9zx8y9Z0DWD4WWXeoQ7mAEGdzPDKMgCp4eu2AxPIDoErwVjCkVk52WMow0b4X
	 EAS94d+9Nkuds26xXh2Vn3Xj5oN9082mV2SozoSU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F4HEAZ027181
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 22:17:14 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 22:17:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 22:17:14 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F4H8NO050822;
	Wed, 14 Feb 2024 22:17:09 -0600
Message-ID: <52608865-b3db-45a9-907f-e954cce88b51@ti.com>
Date: Thu, 15 Feb 2024 09:47:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] arm64: dts: ti: k3-j784s4: Add Wave5 Video
 Encoder/Decoder Node
Content-Language: en-US
To: Brandon Brnich <b-brnich@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>
References: <20240205194706.3605309-1-b-brnich@ti.com>
 <20240205194706.3605309-2-b-brnich@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240205194706.3605309-2-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Brandon

On 06/02/24 01:17, Brandon Brnich wrote:
> This patch adds support for the Wave521cl on the J784S4-evm.
> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4.dtsi      |  2 ++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index f2b720ed1e4f..e628e748f215 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -662,6 +662,24 @@ main_i2c6: i2c@2060000 {
>  		status = "disabled";
>  	};
>  
> +	vpu0: video-codec@4210000 {
> +		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
> +		reg = <0x00 0x4210000 0x00 0x10000>;
> +		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 241 2>;
> +		clock-names = "vcodec";

Binding doesn't allow clock-names [0]

[0] Documentation/devicetree/bindings/media/cnm,wave521c.yaml

> +		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	vpu1: video-codec@4220000 {
> +		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
> +		reg = <0x00 0x4220000 0x00 0x10000>;
> +		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 242 2>;
> +		clock-names = "vcodec";
> +		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
>  	main_sdhci0: mmc@4f80000 {
>  		compatible = "ti,j721e-sdhci-8bit";
>  		reg = <0x00 0x04f80000 0x00 0x1000>,
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
> index 4398c3a463e1..2f633721a0c6 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
> @@ -235,6 +235,8 @@ cbass_main: bus@100000 {
>  		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
>  			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
>  			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
> +			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
> +			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
>  			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
>  			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
>  			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */

-- 
Regards
Vignesh

