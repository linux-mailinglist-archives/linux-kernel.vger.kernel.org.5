Return-Path: <linux-kernel+bounces-58994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EEE84EFA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15512821C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2B5394;
	Fri,  9 Feb 2024 04:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ak2F+eMg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAD5667;
	Fri,  9 Feb 2024 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707453141; cv=none; b=Jym/TJ558mvA2LiN4n9eTO5gTBwu8Y74/3VSqwmnNFQKl4S04DBRyMUInbe2aQdMb/EpuZi67ooWrcdVHxbEEtrnaTJmVC07U2tA3gkFFArUmHAp/jVKQnlwpuLC5WXQNxuWTV/t/7mCnwMJwu/n6CRBikfZmW8ZD6CaVPnAn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707453141; c=relaxed/simple;
	bh=bZrvCuSOQMNUmKNsRvjhpQgjgA0Peil2icaRvMuA1xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hlx7nxeKe+iEFxV1j08++2pKgFQC8TnuOWcwm+bQwkS/osWWZMiNKAVtRct1rOH26oqmAlt1a6RP27jE3WRzmKVMLpinEIPPxAVXxOI6IP6T4QGSoNqBj7G6AlFFbS162IjmvakuI9dpvISO+4Rtxo0aZmGOZN5uoK1kOSQE9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ak2F+eMg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4194W1Pk107335;
	Thu, 8 Feb 2024 22:32:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707453121;
	bh=zjBEHr2TXVf64x70Kkim+L61ZVcMM8U30PCVzLJdbfs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ak2F+eMgsNwlcr7cOyeYwg3jMBvKULoAznMxp/9MMqWVzHOJ/2co7J1vyF1HXvQnX
	 q8b0T4HXGGv0vvikw3KLYNQERzSmP5GM4Cc9U/Zrtk4bobHLPdAWdMsS/arNoIr2GF
	 VlOS+9enkwlgkxcayKK7i9caYAVoHZr5EDYB46vQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4194W1vg121050
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 22:32:01 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 22:32:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 22:32:01 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4194VwgB007245;
	Thu, 8 Feb 2024 22:31:59 -0600
Message-ID: <f9030cae-d059-4083-91d3-d790a889d012@ti.com>
Date: Fri, 9 Feb 2024 10:01:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-common-proc-board: Modify
 Pinmux for wakeup and mcu uart
Content-Language: en-US
To: Bhavya Kapoor <b-kapoor@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240208110602.931573-1-b-kapoor@ti.com>
 <20240208110602.931573-2-b-kapoor@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240208110602.931573-2-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 08/02/24 16:36, Bhavya Kapoor wrote:
> WKUP_PADCONFIG registers for wakeup and mcu uart lies
> under wkup_pmx2 for J7200. Thus, modify pinmux for both
> of them.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 1d8bddcae90e..6593c5da82c0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -119,24 +119,25 @@ transceiver3: can-phy3 {
>  };
>  
>  &wkup_pmx0 {
> +};
> +
> +&wkup_pmx2 {
>  	mcu_uart0_pins_default: mcu-uart0-default-pins {
>  		pinctrl-single,pins = <
> -			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
> -			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
> -			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
> -			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
> +			J721E_WKUP_IOPAD(0x90, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
> +			J721E_WKUP_IOPAD(0x94, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
> +			J721E_WKUP_IOPAD(0x8c, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
> +			J721E_WKUP_IOPAD(0x88, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
>  		>;
>  	};
>  
>  	wkup_uart0_pins_default: wkup-uart0-default-pins {
>  		pinctrl-single,pins = <
> -			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
> -			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
> +			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
> +			J721E_WKUP_IOPAD(0x4c, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
>  		>;
>  	};
> -};
>  
> -&wkup_pmx2 {
>  	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
>  		pinctrl-single,pins = <
>  			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
> @@ -272,7 +273,6 @@ &mcu_uart0 {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mcu_uart0_pins_default>;
> -	clock-frequency = <96000000>;

You are not only modifying pinmux but also dropping clock-frequency for
mcu_uart. Please split that out into separate patch with rationale for
the same.


>  };
>  
>  &main_uart0 {

-- 
Regards
Vignesh

