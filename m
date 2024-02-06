Return-Path: <linux-kernel+bounces-55420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0AC84BC7A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E022890DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03752D52F;
	Tue,  6 Feb 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HbNsGKz5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C3C142;
	Tue,  6 Feb 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241694; cv=none; b=ZIZkdT2G4dpw3h6967k6Qft7XV9fbkLNO5ywO4JQ1CavOBYQ9XYUHIe3fi7hQpmAbToC+wA83jepohxmEEOBxrRs2yOV/PVwanjrMQX5tIs8uM0ECYRZ3bI7UFXKyq5n/a5mDhUAro+j1V9zthnSexc7hp0nrET5r1Fj1UmpD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241694; c=relaxed/simple;
	bh=tWytiE+EPWtK0O9gCPP8ljLMAJ0urrWOrT8peOquToA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FBNknXDK3SyPpQVCAkmymaJ+UCV9lVRfaao8GGhTW9l2dh0sYznL6ik54f4J3t7/huAC13AX199zR/u93ZU8cvEEcGxnolOOEaKSI+PqPbwXXWBB+J/PEcrgbf4BUDkbf40SEwW8A+iRsxSsUCn8Ouhi10xKy4ZpXUsmUWNd66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HbNsGKz5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416Hm6HY027607;
	Tue, 6 Feb 2024 11:48:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707241686;
	bh=bndx9c/51f0aA6apFHcvy/I/iLP7KvduXnn9i5n7fJY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HbNsGKz5MsfBM1ChVBKe7WSYKhGN0jPWkLCvlwFVphAVjamohetJxB5UGFTi+zhYZ
	 en7okpJh9MAIn4vb/kWMg6XpJVH0idOVS6CFvEKSOVuqZU9kPtbMLFMN5PSWZ35bPl
	 LsppjryuihvKsmCg0uc3j//P9RlbSlMrZuW/f9TA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416Hm6Vq033982
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 11:48:06 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 11:48:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 11:48:05 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416Hm5g3049653;
	Tue, 6 Feb 2024 11:48:05 -0600
Message-ID: <0b758df7-8583-48d1-b289-a297890344f4@ti.com>
Date: Tue, 6 Feb 2024 11:48:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: ti: k3-am62-wakeup: Add chip efuse nodes
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Santosh Shilimkar
	<ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-5-msp@baylibre.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240206143711.2410135-5-msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/6/24 8:37 AM, Markus Schneider-Pargmann wrote:
> Add efuse nodes describing chip variant and speed grade.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 36 +++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> index fef76f52a52e..14419df43624 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
> @@ -14,10 +14,44 @@ wkup_conf: syscon@43000000 {
>   		#size-cells = <1>;
>   		ranges = <0x0 0x00 0x43000000 0x20000>;
>   
> +		wkup_efuse: efuse@0 {
> +			compatible = "socionext,uniphier-efuse";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x0 0x200>;
> +
> +			nvmem-layout {
> +				compatible = "fixed-layout";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				chip_manufacturer: jtagidmfg@14 {
> +					reg = <0x14 0x2>;
> +					bits = <1 11>;
> +				};
> +
> +				chip_partno: jtagidpartno@15 {
> +					reg = <0x15 0x3>;
> +					bits = <4 16>;
> +				};
> +
> +				chip_variant: jtagidvariant@17 {
> +					reg = <0x17 0x1>;
> +					bits = <4 4>;
> +				};
> +
> +				chip_speed: jtaguseridspeed@18 {
> +					reg = <0x18 0x4>;
> +					bits = <6 5>;
> +				};
> +			};
> +		};
> +
>   		chipid: chipid@14 {

If you remove the reg property you will want to drop the @14
also or you will get a DT check warning. That needs fixed
in the binding example too (and the binding nodename pattern).

Andrew

>   			bootph-all;
>   			compatible = "ti,am654-chipid";
> -			reg = <0x14 0x4>;
> +			nvmem-cells = <&chip_variant>, <&chip_partno>, <&chip_manufacturer>;
> +			nvmem-cell-names = "chipvariant", "chippartno", "chipmanufacturer";
>   		};
>   	};
>   

