Return-Path: <linux-kernel+bounces-82727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26A8688BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64CF281D78
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102352F96;
	Tue, 27 Feb 2024 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WPx15Bkn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0953369;
	Tue, 27 Feb 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012608; cv=none; b=U4ymZoE6VxT1m0FZvasvXLDKhp2y+Inr/KtPWhUCyQmIsD6KkZCwC7jG4uZFmRH8Bl9Ux16goviPXWx0BYwGPyhhWQ3W8BDrB7vYKhImzqwPI0skjDvB7QOm171awqC58wADgq2l5LBLHs4ctflJBihFSkCpaMppKGxEHyTgxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012608; c=relaxed/simple;
	bh=Myd0giQ1TuXSfO1EqGODj1DyxRC73GRGsRD75OoQr0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TnDMS9OKhUMkdTw+ngyKawM9iTdtGvLzD/iQHa+TpsKKhEsx7/ntBLN+kpm7gNKm05sbbSegDWLGlkN2TI5ZpwTISHnmNrDmY9hpwgGHn5XMaBiVzf9fs+4pR7b947II9uoqnkUoE4nrlNVZRZLoI0gw1OFjRfbmT7zSU9jMnIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WPx15Bkn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41R5gxm5065503;
	Mon, 26 Feb 2024 23:43:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709012580;
	bh=EItW2LR5/qUnhDT9nUEi0a9p9o9oslNZi87BCAirCRg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WPx15BknIm4/pkN+pX0t+TYdeTBhrMwzsHWYCfn3bgCUl4l0/MT0AuGcSXUmVPHAO
	 uO1JqfiBir9ZdYRDVHq4w8PxxIrCl/iTPBULMJsv8q4UZBJtS8FrGvR/twtDvqFHYM
	 u5ONsvR4ss8V1wTNuQK8FpSFdyzqVw4rmC/sFe+w=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41R5gxuG025134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Feb 2024 23:42:59 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 23:42:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 23:42:59 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41R5grgQ051443;
	Mon, 26 Feb 2024 23:42:54 -0600
Message-ID: <12d458f1-e269-a203-dcc7-a7b0674645fe@ti.com>
Date: Tue, 27 Feb 2024 11:12:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/4] arm64: dts: ti: k3-j784s4: Add Wave5 Video
 Encoder/Decoder Node
Content-Language: en-US
To: Brandon Brnich <b-brnich@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
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
        =?UTF-8?B?TsOtY29sYXMgRi5SLkEuUHJhZG8=?= <nfraprado@collabora.com>,
        Marek
 Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>
CC: Andrew Davis <afd@ti.com>
References: <20240220191413.3355007-1-b-brnich@ti.com>
 <20240220191413.3355007-2-b-brnich@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240220191413.3355007-2-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Brandon,

On 21/02/24 00:44, Brandon Brnich wrote:
> This patch adds support for the Wave521cl on the J784S4-evm.
> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 16 ++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4.dtsi      |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index f2b720ed1e4f..40dd2e8a9f98 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -662,6 +662,22 @@ main_i2c6: i2c@2060000 {
>  		status = "disabled";
>  	};
>  
> +	vpu0: video-codec@4210000 {
> +		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
> +		reg = <0x00 0x4210000 0x00 0x10000>;
> +		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 241 2>;
> +		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
> +	};
> +
> +	vpu1: video-codec@4220000 {
> +		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
> +		reg = <0x00 0x4220000 0x00 0x10000>;
> +		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&k3_clks 242 2>;
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

Above change seems not required as the /* Most peripherals */ range already
covers it. Also thanks to Vignesh for confirming this.

As this is already merged in tree, Could you please send a patch which fixes
this commit ?

Regards
Devarsh

>  			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
>  			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
>  			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
> 

