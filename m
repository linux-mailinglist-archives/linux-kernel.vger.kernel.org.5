Return-Path: <linux-kernel+bounces-127670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3281894F39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35971C20EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2F59178;
	Tue,  2 Apr 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rTFJYYP6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F545A0E6;
	Tue,  2 Apr 2024 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051755; cv=none; b=nxmLHfaLACqi6MVp0xfyiFo+larkHcSdv59429uro6ydFooGOpJLJ71xoN8jd+7rOKZWkOaCzoY5yirtfWGgEu7fHt7JFEtyF5VNR5meazFT5XWkPBfq7cfZt9Wrbyx2fa8Gs44vlcvxRYfPAG5va5aQgZX8QiyaWtr4PdMpKfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051755; c=relaxed/simple;
	bh=tHZve99TYGe5gNjplIO+OMlRgYRT+zacRBJQUYgCQNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LzYBuq4BnMNmy6xPVOdr8g8W5spajs3IvEeF4OSOLKLg6UdPbD+jlyb7oU3MaqLunjTr1CBB5n2lA1FHVVSSqr1MOIDGl40sT4WRl6678mMGigdtPbtRYpvlGJHepkEop2OUMS8oY0e0r+prMceOaRLqCHMb2LnrNaqmI5QIaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rTFJYYP6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4329tj3u003526;
	Tue, 2 Apr 2024 04:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712051745;
	bh=6plU258MKNWNf6Pe5QtUrip4m8bCxbcCEzAHVTV5AJ0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rTFJYYP6wVVX9TCe98ddb734sOU0SPwHMwNoTBBl4ssVAm5VGsmnOHyH81GD+Z9YN
	 7G+HkdSOqb8c3dNnzRzl+W2+usZDGlR1b8teJJuahrbN48/X6hovKLJE18tm01/rK/
	 Te9ZTo7+0ihZSL/vPPhwOLg395gC+TexL9OiVzfc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4329tjA4000463
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 04:55:45 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 04:55:45 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 04:55:45 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4329tf89090281;
	Tue, 2 Apr 2024 04:55:42 -0500
Message-ID: <ae04c041-688c-4413-8f15-b37b4ea44aac@ti.com>
Date: Tue, 2 Apr 2024 15:25:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-main: use eFuse MAC Address for
 CPSW3G Port 1
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240402094200.4036076-1-s-vadapalli@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240402094200.4036076-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 02/04/24 15:12, Siddharth Vadapalli wrote:
> Assign the MAC Address programmed in the eFuse registers as the default
> MAC Address for CPSW3G MAC Port 1. Utilize the "ti,syscon-efuse"
> device-tree property to do so.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> This patch is based on linux-next tagged next-20240402.
> 
> Regards,
> Siddharth.
> 
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> index 7337a9e13535..eb126f4a04dd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> @@ -696,6 +696,7 @@ cpsw_port1: port@1 {
>  				label = "port1";
>  				phys = <&phy_gmii_sel 1>;
>  				mac-address = [00 00 00 00 00 00];
> +				ti,syscon-efuse = <&wkup_conf 0x200>;

Sorry, how does this work? wkup_conf is not marked as "syscon" compatible?

>  			};
>  
>  			cpsw_port2: port@2 {

-- 
Regards
Vignesh

