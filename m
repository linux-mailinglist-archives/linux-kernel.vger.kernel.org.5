Return-Path: <linux-kernel+bounces-158418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B98B1FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8766F1C218D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121F2374C;
	Thu, 25 Apr 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZaDwIXxr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63B23746;
	Thu, 25 Apr 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042653; cv=none; b=lNfiWgFz+ewJCDhvOvmDdwumDNow8MIx/ujws02svSZ1xE29eTd4jlIGUPXNHT/xCF7TCl63i6WeIGSNYuBWqieODwJ6jVQIFHYkEOgP/Rn3yPlb08gEG7OeFa7YOCmM+mz4HcrYHc6jaGwkAi+XNYGVPaUJIcuc3YOJ2RqUv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042653; c=relaxed/simple;
	bh=Nha82tPF+kAvGJuu6TdkHdw9nutrST3zF1VZkZo1+ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oImylb1T9DyDuW1lwKFlsEsPSC1ow4m/zrYgtBePqoHfXPqDMv7hjsvkDMJZRQC1Z0v2CLWos53M3mDnlOnzKS/l0Wvhhqguj1TmNjAUY46k9muyvGmEuOz4LnixwVioD1qfId/Hxejta810gT4pU2s2wzB416Lw840G7JcNVoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZaDwIXxr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PAvMbG027956;
	Thu, 25 Apr 2024 05:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714042642;
	bh=9a8NUB6RFjp8aLKzdzwPqoIv9ZJAHc3xZa+zD1WgfYo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZaDwIXxryAwxGwMK4KqyRCGhBNr7I4ZAbd7/Wbnc47WN/yQkkOBgUFkLHyoHyUCjj
	 fG8ywZJoIzTzQL8asN0rVQhCpFZXwC4x91Wl5or07vdHvvzEdbFIaO6Jg67yXQo9af
	 Ec4DE7IbRD0b5gbpaR9GPQvLy57C7bQpS96CUjk8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PAvMV7019408
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 05:57:22 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 05:57:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 05:57:22 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PAvIg5018631;
	Thu, 25 Apr 2024 05:57:18 -0500
Message-ID: <7d7ec336-85e2-484b-99c4-1ccd4ada6074@ti.com>
Date: Thu, 25 Apr 2024 16:27:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: Fix csi2-dual-imx219 dtb names
To: Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
References: <20240425-dtb_name_fix-v1-1-f3d0d7709be8@ti.com>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240425-dtb_name_fix-v1-1-f3d0d7709be8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 25/04/24 16:00, Jai Luthra wrote:
> Fix the output filenames of the combined device tree blobs generated by
> applying *-csi2-dual-imx219-* overlays on the base dtbs during compile
> test.
> 
> Fixes: f767eb918096 ("arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219")
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> ---
>  arch/arm64/boot/dts/ti/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index c76b41f86527..8cb0f50198ac 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -162,10 +162,10 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>  	k3-am642-evm-icssg1-dualemac.dtb \
>  	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
>  	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
> -	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
> -	k3-am69-sk-csi2-dual-imx219-dtbs \
> +	k3-am68-sk-base-board-csi2-dual-imx219.dtb \
> +	k3-am69-sk-csi2-dual-imx219.dtb \
z`>  	k3-j721e-evm-pcie0-ep.dtb \
> -	k3-j721e-sk-csi2-dual-imx219-dtbs \
> +	k3-j721e-sk-csi2-dual-imx219.dtb \
>  	k3-j721s2-evm-pcie1-ep.dtb
>  
>  # Enable support for device-tree overlays
> 
> ---
> base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
> change-id: 20240425-dtb_name_fix-350eab4dd8ab
> 
> Best regards,


Regards
Aradhya

