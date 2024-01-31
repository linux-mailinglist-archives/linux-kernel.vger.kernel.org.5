Return-Path: <linux-kernel+bounces-47007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0808447DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B07D1F2441D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81CB38FA1;
	Wed, 31 Jan 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b7eiom/A"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E273717F;
	Wed, 31 Jan 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728645; cv=none; b=UpTMnx/Rf+gJ0b/CDLunRAgfedHLL6J5hLefY6QTkzysTVenhMARtGEVtlC+ZU5fu0wWoTQH/d5vnA2pjoJnOSZXHE0Tth8ty4MZLQnM4lt9HQuw7uQLDvB80NjRE7oBZplHOGib0dtvLonD6bT5dVe5/D5xBhZ1mYh8qSA0pdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728645; c=relaxed/simple;
	bh=JIYnjpqR8UE/3gFI59D74DalCVAjAiNmvFR2SLeQRgU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtn0sKyd5/rT4iTs5O6zLQF77SJNN2FxZn5Tn26OwRvwPt8n1OQTK+lVigobQ7aRTT9gH9RISxu32iXD/T4RBdVFNknVtVhT9y6wXCH0Ltvp+OvThoYILjeydcTlJeWBUkbbKzbDb2btZVYxSYurKAqfDmuvzIeLhKT638rAAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b7eiom/A; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VJHIX5087175;
	Wed, 31 Jan 2024 13:17:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706728638;
	bh=8FMoGz4wqJaPTnr7/dWM6UByHmBhMsNnlIBuI4F/lVQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=b7eiom/ADq6UrIieMkMCMEpIBr9PPCuh1H2bk+SMA2jyIOEL9Tk1VWF2OsntqpnmW
	 80AUV1ZGKE8xB8rjDpTntRCjJ0aeQZtW3Q+FlsyV4dlxR13x//0VtrxpaNAtSc613e
	 KxvXxRSUyM90uVfmeET0OtN9xzmb2MtZCVdcoh5A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VJHIoO020675
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 13:17:18 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 13:17:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 13:17:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VJHHFd067635;
	Wed, 31 Jan 2024 13:17:17 -0600
Date: Wed, 31 Jan 2024 13:17:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        Randolph Sapp <rs@ti.com>
Subject: Re: [RFC PATCH 06/13] arm64: dts: ti: k3-am62a-main: Add sdhci0
 instance
Message-ID: <20240131191717.igbfpfchen7gmpam@headstand>
References: <20240131003714.2779593-1-jm@ti.com>
 <20240131003714.2779593-7-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240131003714.2779593-7-jm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 18:37-20240130, Judith Mendez wrote:
> From: Nitin Yadav <n-yadav@ti.com>
> 
> Add sdhci0 DT node in k3-am62a-main for eMMC support. Add otap/itap
> values according to the datasheet[0], Refer to Table 7-79.
> 
> [0] https://www.ti.com/lit/ds/symlink/am62a3.pdf
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---

Side note: will appreciate if the dt patches come via the SoC dt tree
for TI K3 and not via mmc tree.

>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index f0b8c9ab1459..523dee78123a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -536,6 +536,24 @@ main_gpio1: gpio@601000 {
>  		status = "disabled";
>  	};
>  
> +	sdhci0: mmc@fa10000 {
> +		compatible = "ti,am62-sdhci";
> +		reg = <0x00 0xfa10000 0x00 0x260>, <0x00 0xfa18000 0x00 0x134>;
> +		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
> +		clock-names = "clk_ahb", "clk_xin";
> +		assigned-clocks = <&k3_clks 57 6>;
> +		assigned-clock-parents = <&k3_clks 57 8>;
> +		bus-width = <8>;
> +		mmc-hs200-1_8v;
> +		ti,clkbuf-sel = <0x7>;
> +		ti,otap-del-sel-legacy = <0x0>;
> +		ti,otap-del-sel-mmc-hs = <0x0>;
> +		ti,otap-del-sel-hs200 = <0x6>;
> +		status = "disabled";
> +	};
> +
>  	sdhci1: mmc@fa00000 {
>  		compatible = "ti,am62-sdhci";
>  		reg = <0x00 0xfa00000 0x00 0x260>, <0x00 0xfa08000 0x00 0x134>;
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

