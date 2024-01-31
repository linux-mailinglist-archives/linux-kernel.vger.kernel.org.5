Return-Path: <linux-kernel+bounces-46919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8184465B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FF21C24FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617312DD98;
	Wed, 31 Jan 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FoZromDy"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BB12CDB3;
	Wed, 31 Jan 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722884; cv=none; b=l0Y7EeIgh/Q2wRgU69F1W5/UnsZyrG6xZ2nxvckdhBBHFz0hms18+KrEZRCTq34hK1gNP+rH3j5wjRDrt9c9pHsCanH1u2Q0VKvfLICErpK/QIWNgLZNsRXEuDLlWMvJCJXdQSvWzVI6GjlSN27o6G6PtYzEMb2RaDZlw9x7awk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722884; c=relaxed/simple;
	bh=RFRKfn9SrFLVHftowQmvZPXkgOgXzmdqBehMMSwaTds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iTilydLug8U/ErKAWX1BOpfYkTtNEM1wzfZUhfnAFV9VXFFJCVeJBKuyck6lPpN5V+Bvs3tWDdxUkF3OX7ibxbFqOj1R+on8t3jOAMdazUC9dbrDEyuDmS/OU5/ZCkEc+Mhe/vInaeJ2tX3Qpy3LXosleVvTkh7QK9kFUnqD2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FoZromDy; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VHfECj058563;
	Wed, 31 Jan 2024 11:41:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706722875;
	bh=0EDAIkVSNIwFY7uzM0VylFUgC93m7m8nBWih+B1wgLE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FoZromDy352Emq81yei/8RVjNeBnj21iMfRGzFCdSu/9X/WslRKqNPxkRMCvYsIU8
	 K4IDtSCO5qj8H89trphqrf/LkoF1X2BN0cEcffzlVUxNARABS4aLBOJvEsE/CbP2Yg
	 49JQ+nDs003OiYdAHTjObAO4kEk5fatW9c7MLHGc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VHfEAe045065
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 11:41:14 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 11:41:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 11:41:14 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VHfDGO066196;
	Wed, 31 Jan 2024 11:41:14 -0600
Message-ID: <593547f9-f9c5-4efc-b163-d7f289ff7db8@ti.com>
Date: Wed, 31 Jan 2024 11:41:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
Content-Language: en-US
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
References: <20240131-b4-upstream-j721s2-fix-vtm-devid-v1-1-94c927bb9595@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240131-b4-upstream-j721s2-fix-vtm-devid-v1-1-94c927bb9595@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/31/24 2:18 AM, Manorit Chawdhry wrote:
> Fix the power domain device ID for wkup_vtm0 node.
> 
> Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/devices.html
> Fixes: d148e3fe52c8 ("arm64: dts: ti: j721s2: Add VTM node")
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Looks to be wrong in J784s4 DT also, could you fix that too?

Reviewed-by: Andrew Davis <afd@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 80aa33c58a45..a47cb557dd95 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -663,7 +663,7 @@ wkup_vtm0: temperature-sensor@42040000 {
>   		compatible = "ti,j7200-vtm";
>   		reg = <0x00 0x42040000 0x0 0x350>,
>   		      <0x00 0x42050000 0x0 0x350>;
> -		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
> +		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;
>   		#thermal-sensor-cells = <1>;
>   	};
>   
> 
> ---
> base-commit: 774551425799cb5bbac94e1768fd69eec4f78dd4
> change-id: 20240123-b4-upstream-j721s2-fix-vtm-devid-86e55c8a59ca
> 
> Best regards,

