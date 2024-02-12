Return-Path: <linux-kernel+bounces-61518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A5851327
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD151C22263
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BF63B19B;
	Mon, 12 Feb 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WW14W2bJ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478C3A8D6;
	Mon, 12 Feb 2024 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739607; cv=none; b=XxPi58bO3Vxs0Hum1cjmfyOjje7o6yMcabK+6pHHEL3i1Xo3ScCL1PkGFJHkiLIwwRimvRvCFPmIc5uj3h/Ba1Llh1aZ3WrhmPrETG0ApzS4SI51uWRQJLwr2gZ4a2UACmmWyPV7YEGigCgdJnDKX5hxDKNV4afc0D6z+exvaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739607; c=relaxed/simple;
	bh=WS2EwGIYfjfVYeJeT+YZsja3GaMwcTRbUQylau3i3Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r9OHITgxSQuNk3Paz+SCftp3M0rs2HTLNYa8/8aRYQ5KVYae4n8ifshrThpmmld0EiyN9/KWHfP/BkMmUgn7yrj4rwzUk+F153kNXx/3mExtoVUkHFniknJwwgXVlrOSPrgXbjzdX+Qm5202sulH3Dgl7hanwVLxp57Tkawc4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WW14W2bJ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CC6dZT117182;
	Mon, 12 Feb 2024 06:06:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707739599;
	bh=S5J/1ObFeoSiJ6gia+94nSw92mC+A99I/PrxqgTLWS4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WW14W2bJfJTJeCbB7afdwKJWmIZVkb3pzb9UZCYWr6IQaq6oD6MaC8c6e/R6GCJVO
	 dqXrc4cGoX/3NewVDdqfmSu6RuDTUXg8HZWPSs1/rsMiFZVldTdaCs7TpKbuS3LSKj
	 KAd2oWHLOQLfamyjV7xN+CFhm19CWiYr3tPeVumw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CC6dWJ022746
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 06:06:39 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 06:06:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 06:06:38 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CC3s6u085591;
	Mon, 12 Feb 2024 06:06:35 -0600
Message-ID: <a64d7c6b-8c22-47c3-a60f-e9dc39026fe0@ti.com>
Date: Mon, 12 Feb 2024 17:36:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-am62p: Add nodes for CSI-RX
Content-Language: en-US
To: Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole
	<d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>
References: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
 <20240201-am62p_csi-v1-3-c83bb9eaeb49@ti.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240201-am62p_csi-v1-3-c83bb9eaeb49@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 01/02/24 18:37, Jai Luthra wrote:
> AM62P supports image capture via the MIPI CSI-2 protocol, it uses three
> IPs to achieve this: Cadence DPHY, Cadence CSI-RX, and TI's pixelgrabber
> wrapper on top. Enable all of these IPs in the devicetree.
> 

Add nodes and keep them disabled sounds more apt here as you are keeping 
all of these disabled.

> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 61 +++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 57ec4ef334e4..fdd835a04327 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -928,4 +928,65 @@ mcasp2: audio-controller@2b20000 {
>   		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
>   		status = "disabled";
>   	};
> +
> +	ti_csi2rx0: ticsi2rx@30102000 {
> +		compatible = "ti,j721e-csi2rx-shim";
> +		reg = <0x00 0x30102000 0x00 0x1000>;
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dmas = <&main_bcdma_csi 0 0x5000 0>;
> +		dma-names = "rx0";
> +		power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +
> +		cdns_csi2rx0: csi-bridge@30101000 {
> +			compatible = "ti,j721e-csi2rx", "cdns,csi2rx";
> +			reg = <0x00 0x30101000 0x00 0x1000>;
> +			clocks = <&k3_clks 182 0>, <&k3_clks 182 3>, <&k3_clks 182 0>,
> +				<&k3_clks 182 0>, <&k3_clks 182 4>, <&k3_clks 182 4>;
> +			clock-names = "sys_clk", "p_clk", "pixel_if0_clk",
> +				"pixel_if1_clk", "pixel_if2_clk", "pixel_if3_clk";
> +			phys = <&dphy0>;
> +			phy-names = "dphy";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				csi0_port0: port@0 {
> +					reg = <0>;
> +					status = "disabled";
> +				};
> +
> +				csi0_port1: port@1 {
> +					reg = <1>;
> +					status = "disabled";
> +				};
> +
> +				csi0_port2: port@2 {
> +					reg = <2>;
> +					status = "disabled";
> +				};
> +
> +				csi0_port3: port@3 {
> +					reg = <3>;
> +					status = "disabled";
> +				};
> +
> +				csi0_port4: port@4 {
> +					reg = <4>;
> +					status = "disabled";
> +				};
> +			};
> +		};
> +	};
> +
> +	dphy0: phy@30110000 {
> +		compatible = "cdns,dphy-rx";
> +		reg = <0x00 0x30110000 0x00 0x1100>;
> +		#phy-cells = <0>;
> +		power-domains = <&k3_pds 185 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>

>   };
> 

