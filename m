Return-Path: <linux-kernel+bounces-157831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C68B16F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D348286AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC216F0D1;
	Wed, 24 Apr 2024 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OZInGKf7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949816EC10;
	Wed, 24 Apr 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000753; cv=none; b=aYq8zayzD1Jq7WDfvULpQGSYcIvXiwNLshR9tWmdTa+YskE4Uvl5o5c+6+aa9bGsF73//9/MHpKjE8mL2IWmdkh2AGL+ULahemFpB5EYfhy+1cgmw3HyFoV66PFUqOWbpWCOV6Ioc1fl27bRTZnGgH0SEKO8FKTOBY3IICV/OnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000753; c=relaxed/simple;
	bh=4aaKBVduWOJM95JKxvcA1B7apI7Jgt4i+iaW1eaRPag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=afWFsO8gcEyUHu4MKvjNIN/ulz0EQZV2zOLCNGd8ZXw4Lon+XIc/36t8R8ZunhpkgG7GYdwUy390cYn+ZraMj9vDlPB058/vSPtPg/3Oeu3BtOUTnEXksj/5SevdcSTR8SUArWLdBRuI3eb1/dcJRURHOsphbpQFG0Wl8xOUI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OZInGKf7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ONJ1oF109675;
	Wed, 24 Apr 2024 18:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714000741;
	bh=J6F8j8/ZsSBql2PqWUy+H2xt7wT8B4cFuj6Vd8aWQ08=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OZInGKf7HbxpurvXRrsUdKehKSc5c6Su7fG8rcFJkgi8rkQjnl+sbpA6AZp+KocF5
	 p4epnDp3H81VljGFOuGqn5VmqVVLm8kVoGUQr0YKLTyS9Lya3H8+s2dgmRmD6OqL2W
	 uTMZpgbWbRfplcydXbo7GBx0NFNdfmzeYtzvFO+U=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ONJ14F089026
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 18:19:01 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 18:19:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 18:19:01 -0500
Received: from [10.250.224.184] ([10.250.224.184])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ONIw3q043960;
	Wed, 24 Apr 2024 18:18:58 -0500
Message-ID: <ca239302-f4e2-48cd-949b-8d5207687ddc@ti.com>
Date: Thu, 25 Apr 2024 04:48:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a-main: Add Wave5 Video
 Encoder/Decoder Node
To: Brandon Brnich <b-brnich@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Darren Etheridge <detheridge@ti.com>, Vijay Pothukuchi <vijayp@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>
References: <20240415204659.798548-1-b-brnich@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240415204659.798548-1-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16/04/24 02:16, Brandon Brnich wrote:
> This patch adds support for the Wave521cl on the AM62A-SK.
> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> ---
> 
> With HR timer polling[0] now in -next[1], lets add support on am62a to
> probe wave521c.
> 
> [0]: https://patchwork.linuxtv.org/project/linux-media/patch/20240310104827.665456-1-devarsht@ti.com/
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/media/platform/chips-media/wave5?id=ed7276ed2fd02208bfca9f222ef1e7b2743d710d
> 
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index aa1e057082f0..73dbdcce68ff 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -1051,4 +1051,11 @@ dss_ports: ports {
>  			#size-cells = <0>;
>  		};
>  	};
> +
> +	vpu: video-codec@30210000 {
> +		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
> +		reg = <0x00 0x30210000 0x00 0x10000>;
> +		clocks = <&k3_clks 204 2>;
> +		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
> +	};
>  };


