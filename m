Return-Path: <linux-kernel+bounces-61512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31E851313
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB7B1C225D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939A3D386;
	Mon, 12 Feb 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FZEPMKho"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0D3C492;
	Mon, 12 Feb 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739449; cv=none; b=WzvKf9ITDv10CPRYDQ0u2lgdwbPIkKYAmx+H/ZQn2D/TJn/GJ7IVxawRn/AvlgjMry0X8LfJEGXyty5P/Qvst8B+i2GL9rv3kYreCuaRYBEgpQfQ4Ym1Ii3hwa9tihh4VL5By/yVkn8RM4LaQhJdgjDvNrrXHc1IXPIAAUfGa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739449; c=relaxed/simple;
	bh=7Z4NKPIH8rbJrwmKAiLraBqaORQHV+vWcdMGFYjBTR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iq1l454qdN32zMwg5b+7Mr00eqnJMSNc5QEusfFIBN0Hc46A00PK7YmHZ6//F2VCaIBeC01rOnD2No28DxaYBleMZIW06KHI1xe7Dacs4lyFFQaceBVIovxF78hDPELGJIM9q9lyr6VX/K/YfDQK5Bmoijwe5lrUQvnr/csOU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FZEPMKho; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CC3x9D065651;
	Mon, 12 Feb 2024 06:03:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707739439;
	bh=RR5lX/mXkS4MvKsSYs1MlRyej8IeOHOZMi/FDum2iiM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FZEPMKho/nVGSVQ+++U3j5kubULmT2dVH7nkWi2w4GCgkMKDjm1aNhVH5URgtwx2n
	 iYYKwyPY946eROAd4UavhlQFdS4gSQ0EdPoAswje3OAOCkZa+VLxZTOnr3bCrNGi+R
	 YpFDw3jW9f3zVwhzSRuIqbIhLik8WieS7i4IH7ok=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CC3xm3004922
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 06:03:59 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 06:03:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 06:03:59 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CC3s6s085591;
	Mon, 12 Feb 2024 06:03:55 -0600
Message-ID: <994c6ff1-96ed-4dde-94a1-43f6cab2a005@ti.com>
Date: Mon, 12 Feb 2024 17:33:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-am62p: Fix memory ranges for DMSS
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
 <20240201-am62p_csi-v1-1-c83bb9eaeb49@ti.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240201-am62p_csi-v1-1-c83bb9eaeb49@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jai,

Thanks for the patch.

On 01/02/24 18:37, Jai Luthra wrote:
> The INTR module for DMASS1 (CSI specific DMASS) is outside the currently
> available ranges, as it starts at 0x4e400000. So fix the ranges property
> to enable programming the interrupts correctly.
> 
> Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62p.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> index 84ffe7b9dcaf..4f22b5d9fb9f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> @@ -71,7 +71,7 @@ cbass_main: bus@f0000 {
>   			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
>   			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
>   			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
> -			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
> +			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06408000>, /* DMSS */

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>

>   			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
>   			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
>   			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
> 

