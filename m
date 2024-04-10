Return-Path: <linux-kernel+bounces-137915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E04289E981
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C0F02875CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E6125CD;
	Wed, 10 Apr 2024 05:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NMCuIVCl"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D210A03;
	Wed, 10 Apr 2024 05:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725995; cv=none; b=ZLqKkDi38Y+MIbN5QK2WY/50QHzuc+RuKPvDHkLeufjbRNvENKDNXq9Qlwf+yp+pQ8Og/R10phO8R5DiCYeJsgykJlqWAv/MS5IdeWJTefoQqwKa5iE0Sm7FO+dJWHF1iS2R1hpb1dC3jUEUqoiWZO5eTYkfsPaSaKuFAbWwtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725995; c=relaxed/simple;
	bh=a5TRDKWuDCYt5gI+XHKyT5nAS3FAmyoyKjRLdhRqDDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rSP0sg5ny/BO8fHcROeSLO2S38/RUlMhpF45hlCC2wyr20icYAXDIQHdJ4AyJ6HF1Np0+nl0NfV3CeRM91qEQkonj3J/lagPYnmoh61CXIUGELBls6uPzgpH8iXj6gpsYwgALhYFKc1Cf2aXjX1yYzioiyeOxZr+SNplZRMstSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NMCuIVCl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A5CgFq014205;
	Wed, 10 Apr 2024 00:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712725962;
	bh=SI8+icJ/jHUxDmt0fviSH4T6t10zh8dpUwxz6qPx75o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NMCuIVClO7FFMWTgN4PfQgrMSg0jSeFXEf+V3M5wp9pLyKBYoZwZX7AjNFOoSyiHU
	 SS4atkiVywaWqKwHu+CDphSnOuFHFVdExXyntafDgd2VPh3DWuocwibCWOtigV2VEt
	 HrF4ZDhEWyYR8p2qQm9RE8hwrWETY3StbqlX5qWU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A5Cg4J023221
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 00:12:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 00:12:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 00:12:41 -0500
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A5CcXu093874;
	Wed, 10 Apr 2024 00:12:39 -0500
Message-ID: <b76578ca-9e94-43a6-93cf-690e23545529@ti.com>
Date: Wed, 10 Apr 2024 10:42:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM
 instance
To: Neha Malcom Francis <n-francis@ti.com>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240326122723.2329402-1-n-francis@ti.com>
 <20240326122723.2329402-2-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240326122723.2329402-2-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha

On 3/26/2024 5:57 PM, Neha Malcom Francis wrote:
> Add the WKUP ESM instance for J721E. It has three instances in total,
> one in the MAIN domain (main_esm) and two in the MCU-WKUP domain
> (mcu_esm and wkup_esm).
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 4618b697fbc4..b0f41e9829cc 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -689,4 +689,9 @@ mcu_esm: esm@40800000 {
>   		ti,esm-pins = <95>;
>   		bootph-pre-ram;
>   	};
> +
> +	wkup_esm: esm@42080000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x42080000 0x00 0x1000>;

I think , only  esm@40800000 should be good for this SOC.

I am not sure, why you want to add this. If you still want to add this 
for completeness ,

then two options, I suggest

1) If you plan to use this mention bootph-pre-ram and ti,esm-pins

2) In case , no plan to use this then please mark node as disabled


> +	};
>   };

