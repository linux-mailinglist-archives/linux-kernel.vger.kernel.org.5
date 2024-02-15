Return-Path: <linux-kernel+bounces-67080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122A8565EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF8A28384D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AC131E50;
	Thu, 15 Feb 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qhNGsWxP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A21130AC3;
	Thu, 15 Feb 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007218; cv=none; b=rMfq/LC/HxeVItdhQtuHCtPRghR982J+VMcmkgphHqrCCIodkmWxH7BKeE2XpcuJd8Cj2npi1C8ypqZTElQgoXlgHQyGebGx7EOiL9PLtLxwOYbaAU/UtwMBYDhPpZl88bVMzHT8Ly32aOgTz2kuVz67RyGQXvSrVkk7pFc8Wcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007218; c=relaxed/simple;
	bh=j9ITj3d8lRCK3n4rRoSOFa3j1UaG+SfaxitoJTBcDfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PQpSTfZlKiskjMJaKdvrlDLEpZTrFB1jG4VRVWe8eMLA/eT3p9SIWsq/X3GACQDgk0a9aUCyqSDPOtoeamjXku0PiNLgmS37Vr4puSB+4GWF7nhFI3XoY75NlsxFXXLFokoZ5kkoYJQ+S/ho0v2ME6V73h7MEZgMsxpEYBRueqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qhNGsWxP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FEQlNF031380;
	Thu, 15 Feb 2024 08:26:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708007207;
	bh=0aoAEQiGSIWc7BwNRPPsCsxo3a+QdD0m5M9Mc62tfDg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qhNGsWxPsZ0CvcuTQCdUW75r84WOKH1B7EizWUtd1t17scBlTTXzsoEU42jm7j6Xe
	 G3EZ3SwIEzjMbeb6G4PLAbFrYCzCjsYr8von6mf+v7NM005HwPF4mRFc68R5Rzk3we
	 4xikvEmAV7x3fZbovLOQbFuvzsaUclHqw7NTvy9A=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FEQl47021598
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 08:26:47 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 08:26:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 08:26:47 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FEQkBp067848;
	Thu, 15 Feb 2024 08:26:47 -0600
Message-ID: <e78406a7-189a-4847-8625-2a66dce818b5@ti.com>
Date: Thu, 15 Feb 2024 08:26:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am654: Drop ti,syscon-rgmii-delay from
 ICSSG nodes
To: MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>
References: <20240215105407.2868266-1-danishanwar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240215105407.2868266-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/15/24 4:54 AM, MD Danish Anwar wrote:
> Drop ti,syscon-rgmii-delay from ICSSG0, ICSSG1 and ICSSG2 node as this
> property is no longer used by ICSSG driver.
> 

I see a couple more instances in k3-am65-iot2050-common.dtsi.

Andrew

> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso | 2 --
>   arch/arm64/boot/dts/ti/k3-am654-idk.dtso    | 4 ----
>   2 files changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> index 0a6e75265ba9..bb0e29873df7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
> @@ -68,7 +68,6 @@ icssg2_emac0: port@0 {
>   				reg = <0>;
>   				phy-handle = <&icssg2_phy0>;
>   				phy-mode = "rgmii-id";
> -				ti,syscon-rgmii-delay = <&scm_conf 0x4120>;
>   				/* Filled in by bootloader */
>   				local-mac-address = [00 00 00 00 00 00];
>   			};
> @@ -76,7 +75,6 @@ icssg2_emac1: port@1 {
>   				reg = <1>;
>   				phy-handle = <&icssg2_phy1>;
>   				phy-mode = "rgmii-id";
> -				ti,syscon-rgmii-delay = <&scm_conf 0x4124>;
>   				/* Filled in by bootloader */
>   				local-mac-address = [00 00 00 00 00 00];
>   			};
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> index 8bdb87fcbde0..d4bc80032587 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
> @@ -72,7 +72,6 @@ icssg0_emac0: port@0 {
>   				reg = <0>;
>   				phy-handle = <&icssg0_phy0>;
>   				phy-mode = "rgmii-id";
> -				ti,syscon-rgmii-delay = <&scm_conf 0x4100>;
>   				/* Filled in by bootloader */
>   				local-mac-address = [00 00 00 00 00 00];
>   			};
> @@ -80,7 +79,6 @@ icssg0_emac1: port@1 {
>   				reg = <1>;
>   				phy-handle = <&icssg0_phy1>;
>   				phy-mode = "rgmii-id";
> -				ti,syscon-rgmii-delay = <&scm_conf 0x4104>;
>   				/* Filled in by bootloader */
>   				local-mac-address = [00 00 00 00 00 00];
>   			};
> @@ -140,7 +138,6 @@ icssg1_emac0: port@0 {
>   				reg = <0>;
>   				phy-handle = <&icssg1_phy0>;
>   				phy-mode = "rgmii-id";
> -				ti,syscon-rgmii-delay = <&scm_conf 0x4110>;
>   				/* Filled in by bootloader */
>   				local-mac-address = [00 00 00 00 00 00];
>   			};
> @@ -148,7 +145,6 @@ icssg1_emac1: port@1 {
>   				reg = <1>;
>   				phy-handle = <&icssg1_phy1>;
>   				phy-mode = "rgmii-id";
> -				ti,syscon-rgmii-delay = <&scm_conf 0x4114>;
>   				/* Filled in by bootloader */
>   				local-mac-address = [00 00 00 00 00 00];
>   			};

