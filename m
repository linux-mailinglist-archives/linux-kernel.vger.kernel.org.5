Return-Path: <linux-kernel+bounces-45143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524B842C21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B9E1C23DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F617992D;
	Tue, 30 Jan 2024 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wFlWAKE8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2A79922;
	Tue, 30 Jan 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640793; cv=none; b=fkbHjz3vWiYelKixOZNdJpAluuHDLomw252xHbFxjolUQVfF/nb0qlieBrRhruCQ436/xRFvR98whlVcRpx6ZN1B6yxo21nb2XoU+fwF2HpX/5rSZFAAGI9125jJQ8cUeuuC5/6JUpdTpVGiTA/L66OtXG3kkUTHRFeFwQc0uNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640793; c=relaxed/simple;
	bh=yeETa2MvQKXw1GBXppudQevIMedsrx9cZNqswDyepSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GnQdUc6kjVsuU35/bJ6UjeU0/Hzwc89nCuhJkXbERu2xAKbDaDJiz8Pb/QJSQrqT8du0sWtH9HloGp7KsIcx5L76UvGmg6KWbhbV2ulvvo3f0rD6LZAjayJdP7UzuvcbUT3a3BJbtt15EZQtO/y1idbOWDI68GqPegAQU3/AoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wFlWAKE8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UIqsi4068495;
	Tue, 30 Jan 2024 12:52:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706640774;
	bh=Ovt1YfG0aoQ5gOJqOMhtkx8exf2ExGlg716uesnayg0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wFlWAKE87po47qOSIC65JXpdmgjSX/lkBsaCUx5/bENPayQhEzbnG+KN1Gt7/c5dK
	 f19gOxHqmrKoAciqYIFgGKandoej4U8WkTw97324YkCHxZXl3dj9juPuonqQ6LIe6B
	 X9cGgapvZhxKmdiqU7rt7xBXV4tlQZLV/9CtdoX0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UIqrQn002762
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 12:52:54 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 12:52:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 12:52:53 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UIqreX090285;
	Tue, 30 Jan 2024 12:52:53 -0600
Message-ID: <e2d254cf-090e-403a-a445-6cd4f6e1a184@ti.com>
Date: Tue, 30 Jan 2024 12:52:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] arm64: dts: ti: k3-am65: Convert serdes_mux node
 into reg-mux
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240124184722.150615-1-afd@ti.com>
 <20240124184722.150615-2-afd@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240124184722.150615-2-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/24/24 12:47 PM, Andrew Davis wrote:
> This removes a dependency on the parent node being a syscon node.
> Convert from mmio-mux to reg-mux adjusting node name and properties
> as needed.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

This one patch is not needed, I'm going to fix this for AM65 in
a slightly different way. The rest of the series is still fine.

Andrew

>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index fcea544656360..a18edd34283c7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -492,11 +492,12 @@ serdes1_clk: clock@4090 {
>   			reg = <0x00004090 0x4>;
>   		};
>   
> -		serdes_mux: mux-controller {
> -			compatible = "mmio-mux";
> +		serdes_mux: mux-controller@4080 {
> +			compatible = "reg-mux";
> +			reg = <0x4080 0x14>;
>   			#mux-control-cells = <1>;
> -			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
> -					<0x4090 0x3>; /* SERDES1 lane select */
> +			mux-reg-masks = <0x0 0x3>, /* SERDES0 lane select */
> +					<0x10 0x3>; /* SERDES1 lane select */
>   		};
>   
>   		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {

