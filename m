Return-Path: <linux-kernel+bounces-46724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC345844332
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654A2285246
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36EE128386;
	Wed, 31 Jan 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NHzKKBBt"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFCA86ADE;
	Wed, 31 Jan 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715432; cv=none; b=nAAp3kS06Eq8v2Mqt+ifrNf6kcmDl8VQ/uLbf+l8HipZ5HI4jU3UM4fzFDigDhzmqxojWkn8fXc+fdRTEfI82hps8o9J8n3kefeagcPnT0LpGVO3sarMjy2XxMplBh+HOJZjU3Q20EBlBDSTCeB7EgaR7VaXsxqlD8So/hlYSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715432; c=relaxed/simple;
	bh=5WnSnvdqsETBg2FJDl31iWb7+HObfg9zGGDHy+zSa8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PbeH6Widvkrc2WkUri1k7XsHMU+wPZYrsBpGFY+Qt83Q17Bm+/tyyENHE1WmUW8HEsiU1PWyVOsKoV2brW1dXJ9E/dbh4wlO1D3JSCD2BUxpTheSfEYhk/h5VLFaVcB7tET+s/kqcgtjn+gT6migjhw8vWTwdPawmynYYo967pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NHzKKBBt; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VFafF4080577;
	Wed, 31 Jan 2024 09:36:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706715401;
	bh=FazfW96VSkGHVGCSpQtOTGWyHKfn1458NWxApCq/AlM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NHzKKBBtuSsrbBzK9gxataXiNXUZbYDZT2mD1hxHBSvAPVqZHkmwWMZ5ICioidIH5
	 d7RUEB57nKriSmaniiUDOLQwygM6iJ34UWc+kCC7ssxY9YOZrKzmO5Fb2+ma/29BFe
	 Pmnq7F/pvmM22oZBcrWtpe0sTj0keVxr14iPpzdU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VFafEv047720
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 09:36:41 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 09:36:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 09:36:41 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VFae1D018943;
	Wed, 31 Jan 2024 09:36:40 -0600
Message-ID: <469a7f15-0539-48e9-993c-5b9c638917e0@ti.com>
Date: Wed, 31 Jan 2024 09:36:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] arm64: dts: ti: k3-j784s4: Add alias to MCU CPSW2G
To: Chintan Vankar <c-vankar@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>
References: <20240131101441.1362409-1-c-vankar@ti.com>
 <20240131101441.1362409-3-c-vankar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240131101441.1362409-3-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/31/24 4:14 AM, Chintan Vankar wrote:
> Add alias for the MCU CPSW2G port to enable Linux to fetch MAC Address
> for the port directly from U-Boot.

Could you explain *how* this alias allows Linux to fetch a MAC
address from U-Boot? Sounds like we are doing something hacky here..

Why can't Linux fetch the MAC from efuses the same way U-Boot does,
what happens if I don't use U-Boot to boot?

Andrew

> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index f34b92acc56d..b74f7d3025de 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -27,6 +27,7 @@ aliases {
>   		mmc1 = &main_sdhci1;
>   		i2c0 = &wkup_i2c0;
>   		i2c3 = &main_i2c0;
> +		ethernet0 = &mcu_cpsw_port1;
>   	};
>   
>   	memory@80000000 {

