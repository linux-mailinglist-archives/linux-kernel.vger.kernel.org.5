Return-Path: <linux-kernel+bounces-119884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7088CE35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCDF1C66B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CDE13D518;
	Tue, 26 Mar 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QR9hfHKM"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6313D250;
	Tue, 26 Mar 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484482; cv=none; b=Tj1fLprib/WYy8+GeUJQKKUr4LqwH9dccWsd7j1uJ1BvpGq6aUOs49AXumE3EQI1FIzizYDOTsCfsvxvOQU42HGWZ7zr/Qoz9+iMpi0bePVM1Vmy6CFse+QRw/sxf2MHb7Jy6F9WR1I63I0dlrrI+iPk32BQEkFdSuSN3hYNjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484482; c=relaxed/simple;
	bh=ugkhIh8LPDu6CqWLRYYCLsjM5750dODZnN0y3eIFpKw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDnoeSEjBdBKD5yz43AdeZy77yHaN1W8w79f4vnTsFdObTf13hj/yUHKX6KiugAiLl8+6GZ6Tq+gX6N9x1tUldJIPsLrtxOp2eAHh+KiRb2Tcp6v1tdYfo0NHuHrdarB6PaTmOoQ7UJT3M29CYNNncb10Izq3H8Re2Y4BEAJTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QR9hfHKM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QKL5ix059927;
	Tue, 26 Mar 2024 15:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711484465;
	bh=FdHAjC/7les37YnkMTaQnJcFGPt0pYqC/e6SnuxXsSE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QR9hfHKMbQNi1QYVrr44ZP6S87lmhGk/WN1dCoWOrpsdhU/3QY6XS7XSR1L06jq0H
	 n6CIAPr3yfUGSiy1S6Uooi4brB21tyD0+wQENKZ7y+kX4mRfoFwXInSWATKRcM6abn
	 xCi6+9kUDCH+W3GHtnQwtzRtCJ7NF7tPpG+mxqfU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QKL5HV057504
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 15:21:05 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 15:21:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 15:21:05 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QKL5cf002062;
	Tue, 26 Mar 2024 15:21:05 -0500
Date: Tue, 26 Mar 2024 15:21:05 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] arm64: dts: ti: k3-am65: Remove UART baud rate
 selection
Message-ID: <20240326202105.duim7cooxk4dwlz2@makeshift>
References: <20240326185441.29656-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240326185441.29656-1-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:54-20240326, Andrew Davis wrote:
> As described in the binding document for the "current-speed" property:
> 
> "This should only be present in case a driver has no chance to know the
> baud rate of the slave device."
> 
> This is not the case for the UART used in K3 devices, the current
> baud-rate can be calculated from the registers. Having this property

I do not understand the explanation above -> how does one do this?
If you are talking of the 8250 divider registers, someone has to program
those - how do you compute the baud rate from registers that aren't
programmed? Note: I am not commenting on the rationale of removing the
property, just trying to understand the assertion above.

> has the effect of actually skipping the baud-rate setup in some drivers
> as it assumes it will already be set to this rate, which may not always
> be the case.
> 
> It seems this property's purpose was mistaken as selecting the desired
> baud-rate, which it does not. It would have been wrong to select that
> here anyway as DT is not the place for configuration, especially when
> there are already more standard ways to set serial baud-rates.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 1 -
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi    | 1 -
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index ff857117d7193..670557c89f756 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -89,7 +89,6 @@ main_uart0: serial@2800000 {
>  		reg = <0x00 0x02800000 0x00 0x100>;
>  		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
>  		clock-frequency = <48000000>;
> -		current-speed = <115200>;
>  		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
>  		status = "disabled";
>  	};
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 6ff3ccc39fb44..4f808e5089755 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -43,7 +43,6 @@ mcu_uart0: serial@40a00000 {
>  		reg = <0x00 0x40a00000 0x00 0x100>;
>  		interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
>  		clock-frequency = <96000000>;
> -		current-speed = <115200>;
>  		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
>  		status = "disabled";
>  	};
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index 37527890ddeaf..eee072e44a42f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -59,7 +59,6 @@ wkup_uart0: serial@42300000 {
>  		reg = <0x42300000 0x100>;
>  		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
>  		clock-frequency = <48000000>;
> -		current-speed = <115200>;
>  		power-domains = <&k3_pds 150 TI_SCI_PD_EXCLUSIVE>;
>  		status = "disabled";
>  	};
> -- 
> 2.39.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

