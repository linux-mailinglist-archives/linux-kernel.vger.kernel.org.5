Return-Path: <linux-kernel+bounces-83381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01C8696A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61B14B29381
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122414533E;
	Tue, 27 Feb 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ae5IGL4z"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D813B797;
	Tue, 27 Feb 2024 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043201; cv=none; b=GGagJ9nDI3rIj6rwf2klzWsFGU4fsB4K5fKcY9ZOLMfOw7VeVg/KE6GObHMD93JEUbGqELrKB1O637PynjKaFyQ0jlzKZNkQ2aWtKaeX3lAaX/L2Wg7pkP2AwCXRCvGtL0FgTbvfv881pBIuJaT84T2zyz8ep9nWcH1FIS6+g1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043201; c=relaxed/simple;
	bh=mUuwmlC0meHZASaEIz5WA4LuGQ0Dr67URk+uNV/EgD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=otsexT7/s6mGLaezXUeYHLis80pVvANB+dUgCeNfgdfQvjFtPPlEgG0WZF67AorokwhO8FkyiEB2xRPSsrazSNQYtnc990VdaK2t1iM27GUpQ84YjOvb9yVFjSvjuUKyPtqdH3BOGH59rx/npDQQkxlHRHakdV2G8UqQfON2mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ae5IGL4z; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41RED0Cm064396;
	Tue, 27 Feb 2024 08:13:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709043180;
	bh=89TgnGcV7AWusBNJIhZxYRDeSlSzPcr0Ty7C/sjjwMQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ae5IGL4z5LmTchav//6gcnweNsR0f5yZ34OmA5EpMpCAEMVBOpAtkC4Dr7SkdtWYz
	 woLcVnujhS1I3y0E3kIGL3xdkc412smFXhW+iN+FaMGwlyt4k7Aw/1bpWikz2QnHna
	 mV6U6gmYpqCCx1rmVjyLATMyMNBZ3TaZWvTBw8UU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41RED01U055730
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Feb 2024 08:13:00 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 08:13:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 08:13:00 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41RECuKD000420;
	Tue, 27 Feb 2024 08:12:56 -0600
Message-ID: <c4f9bbf2-a30e-44bb-91ee-8e6ab209115b@ti.com>
Date: Tue, 27 Feb 2024 19:42:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>,
        Grygorii Strashko
	<grygorii.strashko@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
 <20240219-add-am64-som-v7-2-0e6e95b0a05d@solid-run.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240219-add-am64-som-v7-2-0e6e95b0a05d@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 19/02/24 20:33, Josua Mayer wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The ICSSG IP on AM64x SoCs have two Industrial Ethernet Peripherals (IEPs)
> to manage/generate Industrial Ethernet functions such as time stamping.
> Each IEP sub-module is sourced from an internal clock mux that can be
> derived from either of the IP instance's ICSSG_IEP_GCLK or from another
> internal ICSSG CORE_CLK mux. Add both the IEP nodes for both the ICSSG
> instances. The IEP clock is currently configured to be derived
> indirectly from the ICSSG_ICLK running at 250 MHz.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---

This patch is already picked as part of different series:

https://lore.kernel.org/all/20240215103036.2825096-2-danishanwar@ti.com/

>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index e348114f42e0..9d2dad8ae8df 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -1244,6 +1244,18 @@ icssg0_iepclk_mux: iepclk-mux@30 {
>  			};
>  		};
>  
> +		icssg0_iep0: iep@2e000 {
> +			compatible = "ti,am654-icss-iep";
> +			reg = <0x2e000 0x1000>;
> +			clocks = <&icssg0_iepclk_mux>;
> +		};
> +
> +		icssg0_iep1: iep@2f000 {
> +			compatible = "ti,am654-icss-iep";
> +			reg = <0x2f000 0x1000>;
> +			clocks = <&icssg0_iepclk_mux>;
> +		};
> +
>  		icssg0_mii_rt: mii-rt@32000 {
>  			compatible = "ti,pruss-mii", "syscon";
>  			reg = <0x32000 0x100>;
> @@ -1385,6 +1397,18 @@ icssg1_iepclk_mux: iepclk-mux@30 {
>  			};
>  		};
>  
> +		icssg1_iep0: iep@2e000 {
> +			compatible = "ti,am654-icss-iep";
> +			reg = <0x2e000 0x1000>;
> +			clocks = <&icssg1_iepclk_mux>;
> +		};
> +
> +		icssg1_iep1: iep@2f000 {
> +			compatible = "ti,am654-icss-iep";
> +			reg = <0x2f000 0x1000>;
> +			clocks = <&icssg1_iepclk_mux>;
> +		};
> +
>  		icssg1_mii_rt: mii-rt@32000 {
>  			compatible = "ti,pruss-mii", "syscon";
>  			reg = <0x32000 0x100>;
> 

-- 
Regards
Vignesh

