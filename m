Return-Path: <linux-kernel+bounces-61514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97296851318
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD142856B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30DE39AEC;
	Mon, 12 Feb 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s6yrDfll"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589D39876;
	Mon, 12 Feb 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739515; cv=none; b=AsGfDo6R2CimYb2C/56bxwApkvMGQvZCIqkthPkm+54Oa7/qURmZsb/2h64lfjmEk3D5YvChjKvMU1v8RchH5m0As574e2vZ6v3VRC8Ic0MDKOAKGKgyG5JdVc1GNIlra2LK4fd3YpO4pEQ6aNs6TfYYwNmFA6oujcsIeVWkztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739515; c=relaxed/simple;
	bh=WgIJkC5xhrZyjyYuZE6vWYchnzj/dZTvIPD1UeVYJeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KPxcn+LhvsjyRzMafgAJktxoEcae+ncJ6P4wgZYkhY7x2Tc18ai4nyP+0Ht+FR7zBPiwqsVQjclW49RE/FR+cAuRIs46umo9PQ+x96hiVvyuINX7lZfzmh0rutCW8dHWIt4VBv2xUUwJ2vQKunyGp4BKJotDP+yGuoaixKVESjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s6yrDfll; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CC5719065814;
	Mon, 12 Feb 2024 06:05:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707739508;
	bh=eeF/hI8vKc1yPZ9K5V1IToVQ4hp0xUWUozHaKa0Tkx8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=s6yrDfll3YrHXXqcvpS0zkgiFI/RksxHzneC4QH+3f8c8Y/My7CfHZP7fVXuGdYMk
	 BDpeARTi4WaiECeF/AaXOsodEFviIH7shBVxg6VBydeFXhb2nZU+n/iUJNFzBh5t2k
	 LIwNsqO/lWPVw4Nsd4qwJk+6+/YxYRvbcNRfkHIo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CC586G006074
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 06:05:08 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 06:05:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 06:05:07 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CC3s6t085591;
	Mon, 12 Feb 2024 06:05:03 -0600
Message-ID: <7e5cbf78-7668-4fc2-90b9-27d0d4b857e3@ti.com>
Date: Mon, 12 Feb 2024 17:35:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
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
 <20240201-am62p_csi-v1-2-c83bb9eaeb49@ti.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240201-am62p_csi-v1-2-c83bb9eaeb49@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 01/02/24 18:37, Jai Luthra wrote:
> On AM62P, CSI-RX uses a dedicated BCDMA instance (DMASS1) for
> transferring captured camera frames to DDR, so enable it.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 37 +++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 4c51bae06b57..57ec4ef334e4 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -158,6 +158,43 @@ main_pktdma: dma-controller@485c0000 {
>   		};
>   	};
>   
> +	dmss_csi: bus@4e000000 {
> +		compatible = "simple-bus";
> +		ranges = <0x00 0x4e000000 0x00 0x4e000000 0x00 0x408000>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		dma-ranges;
> +		ti,sci-dev-id = <198>;
> +
> +		inta_main_dmss_csi: interrupt-controller@4e400000 {
> +			compatible = "ti,sci-inta";
> +			reg = <0x00 0x4e400000 0x00 0x8000>;
> +			#interrupt-cells = <0>;
> +			interrupt-controller;
> +			interrupt-parent = <&gic500>;
> +			msi-controller;
> +			power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <200>;
> +			ti,interrupt-ranges = <0 237 8>;
> +			ti,unmapped-event-sources = <&main_bcdma_csi>;
> +		};
> +
> +		main_bcdma_csi: dma-controller@4e230000 {
> +			compatible = "ti,am62a-dmss-bcdma-csirx";
> +			reg = <0x00 0x4e230000 0x00 0x100>,
> +			      <0x00 0x4e180000 0x00 0x8000>,
> +			      <0x00 0x4e100000 0x00 0x10000>;
> +			reg-names = "gcfg", "rchanrt", "ringrt";
> +			#dma-cells = <3>;
> +			msi-parent = <&inta_main_dmss_csi>;
> +			power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <199>;
> +			ti,sci-rm-range-rchan = <0x21>;
> +		};
> +	};

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>

> +
>   	dmsc: system-controller@44043000 {
>   		compatible = "ti,k2g-sci";
>   		ti,host-id = <12>;
> 

