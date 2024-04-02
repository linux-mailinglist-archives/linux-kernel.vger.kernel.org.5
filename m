Return-Path: <linux-kernel+bounces-128330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF08895965
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F0728D237
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70914BFA1;
	Tue,  2 Apr 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rCNn42mg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16D14B097;
	Tue,  2 Apr 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074398; cv=none; b=s8gIMI63WRRTzJAnRjzuFcUZOX46G6OTPNgNfJdxTqo1L5xGAlhTQ+vzjj0Rk0o+IQHULlWt9bP/4D3Dzmqjug8BS+YOiupx0ms1FnrDMpyBuov2LptYwsBakgtRTReQS1wy2hGf7RNyghrbJV6T9P1VEAqmtMDo8OF5mwTRsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074398; c=relaxed/simple;
	bh=h2fJyqLnsQoLlTfcl4w4qsPKFT6B5i9zN1WvD6ba3+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDBTXzvGGHi3MDDauCt7O+2D6JaBSje3g7lYG8amJrmZgj3tZtaaKLcUlQXKhk13rayDd3agR9I+JjjcTmjdhHIKWxYI/kiZOSXzftiynzJmEDpjngImhHIzNr7jyeLcikubyCN/WSFj5kkibD1c4mkmHh7gIkTgwMxJKPf/9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rCNn42mg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432GD7mX122906;
	Tue, 2 Apr 2024 11:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712074387;
	bh=AwYCceT/5F6ItFhtiWk0XbQN3CxqTE6sM7MJfLiMEQI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rCNn42mgiiLR/O3MMAr3ZGxFqkk2Er+FLWmrEQ9yLTj+8V9LFVfwqZojQuFyZgQoU
	 neKZNGDkvz2/PZr7dT1TDjLebnGucqhcThsy+73qKCdNq454c1Toc/9onu+2N/yHZZ
	 AcNOnBZjEKRTcEloVHZYf2y22L8YJ0CbG7CTSEn0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432GD7iI066070
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 11:13:07 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 11:13:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 11:13:07 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432GD7tE080769;
	Tue, 2 Apr 2024 11:13:07 -0500
Date: Tue, 2 Apr 2024 11:13:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Michael Walle <mwalle@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s: Disable ethernet ports by
 default
Message-ID: <20240402161306.tkg35heqlwqxoaua@another>
References: <20240402151802.3803708-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402151802.3803708-1-mwalle@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 17:18-20240402, Michael Walle wrote:
> Device tree best practice is to disable any external interface in the
> dtsi and just enable them if needed in the device tree. Thus, disable
> both ethernet ports by default and just enable the one used by the EVM
> in its device tree.
> 
> There is no functional change.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
> This should also be true for all the other SoCs. But I don't wanted to
> touch all the (older) device trees. j722s is pretty new, so there we
> should get it right.
> ---
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 5 +----
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi    | 8 ++++++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index d045dc7dde0c..afe7f68e6a4b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -224,14 +224,11 @@ cpsw3g_phy0: ethernet-phy@0 {
>  };
>  
>  &cpsw_port1 {
> +	status = "okay";
>  	phy-mode = "rgmii-rxid";
>  	phy-handle = <&cpsw3g_phy0>;
>  };
>  
> -&cpsw_port2 {
> -	status = "disabled";
> -};
> -
>  &main_gpio1 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> index c75744edb143..d0451e6e7496 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> @@ -83,6 +83,14 @@ &inta_main_dmss {
>  	ti,interrupt-ranges = <7 71 21>;
>  };
>  
> +&cpsw_port1 {
> +	status = "disabled";
> +};
> +
> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
>  &oc_sram {
>  	reg = <0x00 0x70000000 0x00 0x40000>;
>  	ranges = <0x00 0x00 0x70000000 0x40000>;
> -- 
> 2.39.2
> 

Meant to respond to this thread:

This is better at arch/arm64/boot/dts/ti/k3-am62p-main.dtsi.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

