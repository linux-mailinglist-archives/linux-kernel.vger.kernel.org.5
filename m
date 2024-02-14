Return-Path: <linux-kernel+bounces-64834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B4854369
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28278B2449F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ACC11715;
	Wed, 14 Feb 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rtmp5M2K"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599E10A2C;
	Wed, 14 Feb 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895733; cv=none; b=KsXLmxIoGZdVGCYPxZKvPfOAIxfnFxq71mUltGfDgeWqNOpBX0wOkxHh2LgUY1ok0rkfdThLzXRS4uogjUDXoQOW8Lwh3rHG44iPsc+mogSihr4pMgcYpTV4nfXiy1vFFTKnX5uO/NJWxkGS7lZhnIM8YzkR4bzhpG9jPYZlT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895733; c=relaxed/simple;
	bh=Klz922SY6zwP9fd4HzSeoQUo+HDErk4CymP3J/L/94Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PeqZt0a8B75+UqxIFrrrmJyf7/W3EbvUVSOxBG0EXWley+EE/ETYZGUPD3Eql54J+1dV6vdhpwiYnRhMATCbQtci/TEm/bbgH3rkbi6RJgFfm84bYpCo5I+so+YJIBpoeji/ekc0yVVpGNUrB/WVQ8XG0JIj5Dn1cveghZP1Btg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rtmp5M2K; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41E7Sgp6108947;
	Wed, 14 Feb 2024 01:28:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707895722;
	bh=jvcicBHwXOpS6B6qPvZL9c7TT+K2R2aQ/1U8VreJT+E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Rtmp5M2KdOVzTIry6egMKufcbb7zt5JcfBSbB0iFrtbEY3DbztVjiTN8+i2fBtMJb
	 vI9laGaaqJ3irWYWi2Be30SVXV0lX2WwyrVgj/StINt9minYfsVkB2+KQT25SMggGR
	 tkB8HYaQjtuegKipogcbPbpViWmrqHroHLA2oQYU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41E7SgI3027586
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 01:28:42 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 01:28:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 01:28:42 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41E7ScpE009345;
	Wed, 14 Feb 2024 01:28:39 -0600
Message-ID: <2c1da868-0295-4398-8811-6367c589df52@ti.com>
Date: Wed, 14 Feb 2024 12:58:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 1/4] arm64: dts: ti: k3-j7200-common-proc-board:
 Modify Pinmux for wkup_uart0 and mcu_uart0
Content-Language: en-US
To: Bhavya Kapoor <b-kapoor@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240212104417.1058993-1-b-kapoor@ti.com>
 <20240212104417.1058993-2-b-kapoor@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240212104417.1058993-2-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 12/02/24 16:14, Bhavya Kapoor wrote:
> WKUP_PADCONFIG registers for wkup_uart0 and mcu_uart0 lies
> under wkup_pmx2 for J7200. Thus, modify pinmux for both
> of them.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---


This warrants a Fixes: tag. Can you provide one here? I can fix it up
when merging.

>  .../boot/dts/ti/k3-j7200-common-proc-board.dts  | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 1d8bddcae90e..160580a0584a 100644
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

-- 
Regards
Vignesh

