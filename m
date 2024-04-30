Return-Path: <linux-kernel+bounces-163978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE8F8B76C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AD01C224B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066FE171E45;
	Tue, 30 Apr 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WWX7/8IO"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA9171664;
	Tue, 30 Apr 2024 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483041; cv=none; b=FpFVoDHx1qlkuk3MibyMBPai753CJEc35DxMzr7hePlGx/J+XxdZ6JF4WgMhhX9spS4i1R18jGBwqkfS2ytTOLgEAeMXh5zhhc4NfqHmeQkEOWUJGC3feTcMzzjQjceMg9pUaOPDaMY5Sjxy9C6m3KL/yzXO7PtL67P6bFN2LwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483041; c=relaxed/simple;
	bh=VMkqoBJRN48tblfmFf9bcJEYsIJXhgMHYeRuvgtQoI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P42PY1N9bHtwCp1ARRPh9Goa1fpNiP77+/oQ3U6a8BLH6ACh33nTCPFeQBwypmSEAC5DBULA3iqgDcUI3KJi4iIuYPj8rUbFmUp1M5rv3hlFs+KyUzPqA+M+e02QQlGpaaj0GiZDWh4NlPExCq3HJmbUKjLyysvy5kLDO0erpkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WWX7/8IO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UDHDN6090744;
	Tue, 30 Apr 2024 08:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714483033;
	bh=aZzicnjqDrPOIhmfm0+MOKr4+ehahLnwfmSmNFzdlao=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WWX7/8IO0UMYL61wWN5dfZMik8bPg8IiWxXPuqifur81p6B1TSmcQ++HOHC1jiO0D
	 KypYIoOaUMebxmmkl5xJfuCJlFT/FXAyBZcUg8OT7dqWE2goym15qI/flf2MuiPK9Y
	 qdpyUTcZPbY3tX17umXDQ5RkgeQKwI0JZzFKPwvE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UDHDEH012358
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 08:17:13 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 08:17:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 08:17:12 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UDH8oR029655;
	Tue, 30 Apr 2024 08:17:09 -0500
Message-ID: <104fbdbc-a3f6-091a-72f4-17d4fa24ad92@ti.com>
Date: Tue, 30 Apr 2024 18:47:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] arm64: dts: ti: Fix csi2-dual-imx219 dtb names
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
        <linux-kernel@vger.kernel.org>, Aradhya Bhatia <a-bhatia1@ti.com>
References: <20240429-dtb_name_fix-v2-1-414fb8b7262d@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240429-dtb_name_fix-v2-1-414fb8b7262d@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 29/04/24 12:13, Jai Luthra wrote:
> Fix the output filenames of the combined device tree blobs generated by
> applying *-csi2-dual-imx219-* overlays on the base dtbs during compile
> test.
> 
> Fixes: f767eb918096 ("arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219")
> Signed-off-by: Jai Luthra <j-luthra@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
> Changes in v2:
> - Rebase to latest ti-k3-dts-next branch
> - Link to v1: https://lore.kernel.org/r/20240425-dtb_name_fix-v1-1-f3d0d7709be8@ti.com
> ---
>  arch/arm64/boot/dts/ti/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 48fb19a523bd..9c536d4902f4 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -170,10 +170,10 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>  	k3-am642-evm-icssg1-dualemac.dtb \
>  	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
>  	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
> -	k3-am68-sk-base-board-csi2-dual-imx219-dtbs \
> -	k3-am69-sk-csi2-dual-imx219-dtbs \
> +	k3-am68-sk-base-board-csi2-dual-imx219.dtb \
> +	k3-am69-sk-csi2-dual-imx219.dtb \
>  	k3-j721e-evm-pcie0-ep.dtb \
> -	k3-j721e-sk-csi2-dual-imx219-dtbs \
> +	k3-j721e-sk-csi2-dual-imx219.dtb \
>  	k3-j721s2-evm-pcie1-ep.dtb \
>  	k3-j784s4-evm-quad-port-eth-exp1.dtb \
>  	k3-j784s4-evm-usxgmii-exp1-exp2.dtb
> 
> ---
> base-commit: 3454b58dd9d99e317871e9abd57f589ae7580642
> change-id: 20240425-dtb_name_fix-350eab4dd8ab
> 
> Best regards,

