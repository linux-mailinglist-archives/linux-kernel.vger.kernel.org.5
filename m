Return-Path: <linux-kernel+bounces-128325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B789595B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FB61F239F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7E814AD38;
	Tue,  2 Apr 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mVm932bh"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482E134BE;
	Tue,  2 Apr 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074339; cv=none; b=WmfvysEB21FVI/MlE5a8zM3bqL78rYx5aZqG8hOMswGJyh+ng52QSGggcY/tAlSDoE7VkgzerDhuA4t0TX5PkVKny4rXGCEZIz32sYYQKBW+4P8hXBNXL7RT9B1/CtMB7u0tw/4MDWdbsw7oZXSyacaFqfsPdDTySzJvgR0NbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074339; c=relaxed/simple;
	bh=cgPRmicqwe8b+yU2t6Pfs3NTgxU+9b0RCyjcLkxUvlU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy6dAVtZv0mpsy7/cxzQP1UaKDSqcKNBTVs+5gbqwCcmApJcAFPcrAeorQwT3gvqXfauO+e5AgRYw5a9Vl9y87mD1v25UPwN3g3eVL6TXBLVC6M5ygWxJ4gYgWQ9NfVMfn0OnZ3997GsnPmBpIpFLuFnPrv/mP9OqEpNbymKUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mVm932bh; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432GC4db108535;
	Tue, 2 Apr 2024 11:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712074324;
	bh=C6tvEDnpl8HVz+/ZK2ZwT+RfV+7ZC0EKicCsn72xlok=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=mVm932bhiuLcTpnDr4hdFu8kiPm5d/mpg7ucB9W0wx5B7ZAxB5DdX/lEWLzBFtrum
	 RV/byN6Wb4Vpaw0JcZkpKKm+xvTJBNFrbuu9RBleWRAcDIOSTUn2kwLb96w7q+lF6P
	 Y6C8Xv8Tum5MEoUURsvrj/KS7WaQARqazXixLaAk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432GC32p033084
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 11:12:03 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 11:12:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 11:12:03 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432GC3mS034583;
	Tue, 2 Apr 2024 11:12:03 -0500
Date: Tue, 2 Apr 2024 11:12:03 -0500
From: Nishanth Menon <nm@ti.com>
To: Nathan Morrisson <nmorrisson@phytec.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am642-phyboard-electra-rdk:
 Increase CAN max bitrate
Message-ID: <20240402161203.q34gyqfaoewvjbky@unburned>
References: <20240402160825.1516036-1-nmorrisson@phytec.com>
 <20240402160825.1516036-3-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402160825.1516036-3-nmorrisson@phytec.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:08-20240402, Nathan Morrisson wrote:
> The phyBOARD-Electra has two TCAN1044VDD CAN transceivers which
> support CAN FD at 8 Mbps.
> 
> Increase the maximum bitrate to 8 Mbps.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> index 8237b8c815b8..522699ec65e8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> @@ -42,7 +42,7 @@ can_tc1: can-phy0 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&can_tc1_pins_default>;
>  		#phy-cells = <0>;
> -		max-bitrate = <5000000>;
> +		max-bitrate = <8000000>;
>  		standby-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
>  	};
>  
> @@ -51,7 +51,7 @@ can_tc2: can-phy1 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&can_tc2_pins_default>;
>  		#phy-cells = <0>;
> -		max-bitrate = <5000000>;
> +		max-bitrate = <8000000>;
>  		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
>  	};
>  
> -- 
> 2.25.1
> 

This is better at arch/arm64/boot/dts/ti/k3-am62p-main.dtsi.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

