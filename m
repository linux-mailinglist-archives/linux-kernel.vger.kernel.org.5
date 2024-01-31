Return-Path: <linux-kernel+bounces-46767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1124D8443DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DE71C25108
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3908812AAEC;
	Wed, 31 Jan 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TOGjFlE3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F0374E24;
	Wed, 31 Jan 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717621; cv=none; b=V0QnjU19e28oaddD/8JXL064Ma5DvRmPyfaic6vd6VK8oMKPGc12nBpHJZs9qEOISiL7RANuCsEgLIhwy1UxsXgG76xJaO8ATJx6W+EcRUSxtS2U8avzvuEt1nxn9Ge7rmby+Mi5xpJafBCxJPl53DtcVA7C8VdaIh6H+S49O5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717621; c=relaxed/simple;
	bh=9YE0qOWivDOAeCFM7z+t1YHkoqsksy4dyNDZidoF3qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i9xZDfyDbdllX8Nxj/N68fa/FFUJdG41zKoSP2aVH8YATIZjobln9+zNFmN1C0/IX1fAUDNhIBET/8lLUZG0B72vSGNC+YZnZYH+UZOysPXR2MApzzsgkLfgEKg7W998ZoZ4cd/ahxkDNg0QuFw/BLFnkDCgT3r13WFT9fDs/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TOGjFlE3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VGDYxU092499;
	Wed, 31 Jan 2024 10:13:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706717614;
	bh=CZkwj9UKIiSG/7dHj75MVWvozrZK3G8n/YKQz55bdEI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TOGjFlE3Yi41DGSvg7EdENpay0zgFLCqT0AsNQtLWPQb8oFBgYUYcK34/05AYP6de
	 63yndKUi97l6SJUkYxzagscLb2CDuhUGctNi4iB87UH282H0vl5LtxOh08Ea9UsVsi
	 o0UUoD15fR8YLmKyrXkfLx+bAxfp3LWswGsmBF0w=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VGDYcK085141
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 10:13:34 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 10:13:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 10:13:33 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VGDXuN070543;
	Wed, 31 Jan 2024 10:13:33 -0600
Message-ID: <be60e695-894e-4281-a62c-b77e45680293@ti.com>
Date: Wed, 31 Jan 2024 10:13:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,k3-pcie-ctrl compatible
Content-Language: en-US
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240131112342.1300893-1-s-vadapalli@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240131112342.1300893-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/31/24 5:23 AM, Siddharth Vadapalli wrote:
> The PCIE_CTRL registers within the CTRL_MMR space of TI's K3 SoCs are
> used to configure the link speed, lane count and mode of operation of
> the respective PCIe instance. Add compatible for allowing the PCIe
> driver to obtain a regmap for the PCIE_CTRL register within the System
> Controller device-tree node in order to configure the PCIe instance
> accordingly.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> This patch is based on linux-next tagged next-20240131.
> 
>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 084b5c2a2a3c..da571a24e21f 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -73,6 +73,7 @@ properties:
>                 - rockchip,rv1126-qos
>                 - starfive,jh7100-sysmain
>                 - ti,am654-dss-oldi-io-ctrl
> +              - ti,k3-pcie-ctrl

This might not be the same for all K3 devices, you should use
the name of the first device which uses this, so:

ti,j721e-pcie-ctrl

Andrew

>   
>             - const: syscon
>   

