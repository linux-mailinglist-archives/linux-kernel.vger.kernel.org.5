Return-Path: <linux-kernel+bounces-148441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033FA8A829A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE501F22768
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126913CFBD;
	Wed, 17 Apr 2024 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R3A4vAf1"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BDC7FBD2;
	Wed, 17 Apr 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355036; cv=none; b=WwQTOQBqHs9puR7V34GDU0WErcXnk9RNIYTyepeuvh1LNKJWEAzeLALghIIflDpwnm+Rez+goza77OYb5wVxH+vWSi9A8hK266ABjcXRpQHPqzdHF+BBzonKKtOMv9DDWIgoooC8EZwH+oOXj4td2tkHj1KLBk/eS3xOW0b3Zj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355036; c=relaxed/simple;
	bh=HemC5jj1e7aQcD8qKpIfEBsO/Z/wNcPGtYU3mwsGTSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KEF+Fje6CoXK4TpR5lvE2txdL44+O5tpy3RtU+8KHi/sg2pY9E7bMR9Fi8ccPX9dBod2SJ8vN9KtuP8QiXpzuD1wL87tRwb+iFdw42h/JXrMjnJ2eYOXVPrPaUc6vcOiYpDz6nlRGvocMOrDWZ/RkT2B1LkBRlOz9s0R0sSnlAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R3A4vAf1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43HBv5lW026341;
	Wed, 17 Apr 2024 06:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713355025;
	bh=DCMypKZidOB2wAZl80SkaybM9OwuNT+k3d3G7XXO11A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=R3A4vAf1D5eaPJy72DdQNATMLOPy9iLlkA1hQbp1PCNuLDNaw00i+tHTwZNE+t6Jt
	 nnOJhrSGKi3PTeMgbOLSoMfWgX4wSnYbs8GnRwLtmcfWJyxjLd0IHWpjuNLIiDU/ik
	 7a1z1sRO4qbFjONLQmjGiBdrgGSNPvLgbtY0LOW8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43HBv5SL095613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Apr 2024 06:57:05 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 06:57:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 06:57:05 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43HBv1pA053558;
	Wed, 17 Apr 2024 06:57:02 -0500
Message-ID: <c6288523-84a6-48b0-bf9f-c25721a1519f@ti.com>
Date: Wed, 17 Apr 2024 17:27:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] Add CPSW2G and CPSW9G nodes for J784S4
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
References: <20240329053130.2822129-1-c-vankar@ti.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240329053130.2822129-1-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Chintan,

On 29/03/24 11:01 am, Chintan Vankar wrote:
> This series adds device-tree nodes for CPSW2G and CPSW9G instance
> of the CPSW Ethernet Switch on TI's J784S4 SoC. Additionally,
> two device-tree overlays are also added:
> 1. QSGMII mode with the CPSW9G instance via the ENET EXPANSION 1
>    connector.
> 2. USXGMII mode with MAC Ports 1 and 2 of the CPSW9G instance via
>    ENET EXPANSION 1 and 2 connectors, configured in fixed-link
>    mode of operation at 5Gbps link speed.
> 
> Link to v5:
> https://lore.kernel.org/r/20240314072129.1520475-1-c-vankar@ti.com/
> 
> Changes from v5 to v6:
> - Updated order of properties in Device Nodes based on
>   https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> 
> Chintan Vankar (1):
>   arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G
> 
> Siddharth Vadapalli (4):
>   arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
>   arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add aliases
>     for it
>   arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with
>     CPSW9G
>   arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode
> 
>  arch/arm64/boot/dts/ti/Makefile               |  11 +-
>  .../ti/k3-j784s4-evm-quad-port-eth-exp1.dtso  | 147 ++++++++++++++
>  .../ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso   |  81 ++++++++
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  51 +++++
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 187 ++++++++++++++++++
>  5 files changed, 476 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-quad-port-eth-exp1.dtso
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usxgmii-exp1-exp2.dtso
> 

For this series,
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

