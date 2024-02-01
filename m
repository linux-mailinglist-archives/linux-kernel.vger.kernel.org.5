Return-Path: <linux-kernel+bounces-48367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D8845AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6CC2B2258C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5E5F494;
	Thu,  1 Feb 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y+aCDQuG"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3645CDF8;
	Thu,  1 Feb 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800351; cv=none; b=aTEMM4Ah75bZr91Lz/jWKyYnGaI1PWWZUqZ+r47KAaW9Wyg38nchsHoCJfODNswkUBPhcrCNzjIKjFJ1biMA57NnqeyfFvHeJ9AQKXyDZp6BtF7I6WgB+0pXgnirheTYovEtP9PLw7gJnQ8cSc/69OTP+BgYsuNoO0WRDLupJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800351; c=relaxed/simple;
	bh=dVLCEsQG0nuHk5qp8res52bJhdD76J5X2UP72bjL4CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pnX2axurLHLy4TYfJSKmGYN/5pLaJEKygoJbGvglUzSEzQde/9Mt7NopR6/bBkRMYzSk4BpXRSkN9wDYSguVE2vcDCPjBN5Ppo858R1+l0oU180bWAdE6Yzo3H53FpwSFXbN8E3kv21nmSbWrtl2CsISpENlRstXmI6OW5bZRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y+aCDQuG; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411FCKjr010658;
	Thu, 1 Feb 2024 09:12:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706800340;
	bh=jG4VIb5fRUuPA2q/P2YInb9jGmcE2K2nGcJbz90n3cA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Y+aCDQuGR3NGvjxhcSLrOPnQOrhI4GJWfuSJi+MinHGKR7UrNzqe0kWSMScPsh9Nm
	 T43uo9x96Sf5+6c0BWvrPAQOHYIFg2KfgpHDk5W35JfxLPuNffy94lZPSRlcbwcUp0
	 tNGEH1kjM90oSPacmwZcpVtGkdK8+PRUxOvvuu5I=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411FCKbi076600
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 09:12:20 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 09:12:19 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 09:12:19 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411FCJvE009640;
	Thu, 1 Feb 2024 09:12:19 -0600
Message-ID: <82349e32-ed8e-4952-bf80-3f5319f32a45@ti.com>
Date: Thu, 1 Feb 2024 09:12:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4: Fix power domain for
 VTM node
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Keerthy <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
References: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com>
 <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-2-85fd568b77e3@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-2-85fd568b77e3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/1/24 2:07 AM, Manorit Chawdhry wrote:
> Fix the power domain device ID for wkup_vtm0 node.
> 
> Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/devices.html
> Fixes: 64821fbf6738 ("arm64: dts: ti: j784s4: Add VTM node")
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

>   arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> index 3902a921d7e5..337122c3f402 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
> @@ -628,7 +628,7 @@ wkup_vtm0: temperature-sensor@42040000 {
>   		compatible = "ti,j7200-vtm";
>   		reg = <0x00 0x42040000 0x00 0x350>,
>   		      <0x00 0x42050000 0x00 0x350>;
> -		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
> +		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
>   		#thermal-sensor-cells = <1>;
>   	};
>   
> 

