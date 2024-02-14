Return-Path: <linux-kernel+bounces-64998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D284854660
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB71C21C99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3F2171C1;
	Wed, 14 Feb 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JL+omqEX"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712561643A;
	Wed, 14 Feb 2024 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904025; cv=none; b=oV+JIefp7DMn3Pt69MstY8/dWpZhbAJ+uvzdE5noalIG4gtCgeAteic/iWvVZHfMzX1zdZONp+aOWtSxCeDsDJre6JMs5t4Y/LhsKA398fR8ANCZ/9U2RiQRx66H1jc2JLf++E242HeiCGDamMnGBI9C3eESrTy/h2W7qdNSmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904025; c=relaxed/simple;
	bh=rP+ebuEaMc5tg61JLVvAUmEdrvUxyfm3wABBQbxoYIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QHFgiylbUqdzKCCeELTg9yIg5ag88nTHIVHTLS0RhHcE2JrtODRCeaNRydhJG8aHtDtLWngpHLcbCCvOFYmI49VxCtjEHjgFKKvmVMAXBrJvzfCKwWxb5mNVPLkoEDfL1wwHmRdCYn0MNO9x/r4l6Mu9EB6jJItcztnkEw2kWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JL+omqEX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41E9XM0V125985;
	Wed, 14 Feb 2024 03:33:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707903202;
	bh=Csk1oDtsAK1M0LasBQmN6aKIfpkSnc/BDiK3CDXsk2I=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=JL+omqEX+Tb6dI1G7b/HdymagiVC39okOKd8iguaaw5tw3CaBS1034o0WxZ5V5xmd
	 /HzJX+ASVbz8gLgnmLlAsjQGPBz97py8trFnTgP1vnCChyokLVyjxKfj8JZr7/dUZy
	 LA5QSRXcsqQAuvfbiwHivaqloV/edU7zDuJhxiqU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41E9XM4C028558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 03:33:22 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 03:33:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 03:33:22 -0600
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41E9XI5x090954;
	Wed, 14 Feb 2024 03:33:19 -0600
Message-ID: <75241296-c698-4983-9dcd-9f59c31cb286@ti.com>
Date: Wed, 14 Feb 2024 15:03:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am69-sk: fix PMIC interrupt
 number
Content-Language: en-US
To: Romain Naour <romain.naour@smile.fr>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>
References: <20240209171146.307465-1-romain.naour@smile.fr>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240209171146.307465-1-romain.naour@smile.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Romain

On 09/02/24 22:41, Romain Naour wrote:
> The tps659413 node set WKUP_GPIO0_83 (AA37) pin as input to be used as
> PMIC interrupt but uses 39 (WKUP_GPIO0_39) as "interrupts" property.
> 
> Replace 39 by 83 after checking in the board schematic [1].
> 
> [1] https://www.ti.com/tool/SK-AM69
> 
> Fixes: 865a1593bf99 ("arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC")
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Romain Naour <romain.naour@smile.fr>
> ---
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index 8da591579868..95c9d3da59d3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -646,7 +646,7 @@ tps659413: pmic@48 {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pmic_irq_pins_default>;
>   		interrupt-parent = <&wkup_gpio0>;
> -		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
> +		interrupts = <83 IRQ_TYPE_EDGE_FALLING>;
>   		gpio-controller;
>   		#gpio-cells = <2>;
>   		ti,primary-pmic;

Thanks for catching this!

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

