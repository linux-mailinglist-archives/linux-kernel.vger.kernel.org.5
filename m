Return-Path: <linux-kernel+bounces-58996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD484EFA5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928B4286CFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3302553A9;
	Fri,  9 Feb 2024 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qbW3Thzr"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F163B3;
	Fri,  9 Feb 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707453456; cv=none; b=WsfGmdePIKUcczqpt/jq0KDRHco4sqxz6JXqQuINk7m6b+p88I2P0IJG7tK81bhPFjCxqkEhgUYTJw93ygbLm3uZPUi3SWX/VePqTHwj3+ya10fWga69l02DK5qUJXngLnIKvDW6B2GIMGl6B7VA0ixwJvDwpetXPPJhcy9D6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707453456; c=relaxed/simple;
	bh=of2HRmgb3U2O+cmnzRP9db5MsyjJw62oz0g9OBi4rRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dZ2m52QY4AtfkvpFWBeOnqNPzQM7xJ816L0JWcItcguzEZs6SVNVrqXpUyzSOVe2pLBW/DZvPca2hx/91nIfXPqKiMxMjdlTj9kU06eGaxxoCgHHNr20VhqS1diY/Owc6ggPlhz92NopsAZnI4p80fXrt4NNdANrPWAHB6vTjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qbW3Thzr; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4194bQUH038342;
	Thu, 8 Feb 2024 22:37:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707453446;
	bh=lqf7HvEYgxQ3Ig0HvOwZnKSDuIuRmKQ96OsHv9HbQlM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qbW3Thzrn5QajSPRJIZxCwMd/nq3Rg6OSSjNFGynlxvv+mrUDQt5UdvoYRFBETI4p
	 z3dqMD4B2E39UriGC5oVSjij/hFJx5BG58SsE0u4hVIQ8IG75dOAy9z3klI+0mLbNn
	 HAMWtuBYQY0nvYAg7rIXIYhyoS4B8X2nzUb7A4rw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4194bQaU113849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 22:37:26 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 22:37:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 22:37:25 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4194bMQx013216;
	Thu, 8 Feb 2024 22:37:22 -0600
Message-ID: <eec99081-cb76-4170-ad99-5faf47e17cd8@ti.com>
Date: Fri, 9 Feb 2024 10:07:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j721s2-common-proc-board: Remove
 Pinmux for CTS and RTS in Wakeup Uart
Content-Language: en-US
To: Bhavya Kapoor <b-kapoor@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240208110602.931573-1-b-kapoor@ti.com>
 <20240208110602.931573-3-b-kapoor@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240208110602.931573-3-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 08/02/24 16:36, Bhavya Kapoor wrote:
> Only Tx and Rx Signal lines for wake up uart are brought out on

Please be consistent when referring to instance names

s/wake up uart/wkup_uart0

applies to $subject and in commit msg (same issue in patch 3/3 too)

> the Common Proc Board through SoM, but CTS and RTS signal lines
> are not brought on the board. Thus, remove pinmux for CTS and RTS
> signal lines for wake up uart in J721S2.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index 361365bb5523..6371cb1c1fe7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -190,8 +190,6 @@ J721S2_IOPAD(0x038, PIN_OUTPUT, 0) /* (AB28) MCASP0_ACLKX.MCAN5_TX */
>  &wkup_pmx2 {
>  	wkup_uart0_pins_default: wkup-uart0-default-pins {
>  		pinctrl-single,pins = <
> -			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (E25) WKUP_GPIO0_6.WKUP_UART0_CTSn */
> -			J721S2_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (F28) WKUP_GPIO0_7.WKUP_UART0_RTSn */
>  			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (D28) WKUP_UART0_RXD */
>  			J721S2_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (D27) WKUP_UART0_TXD */
>  		>;

-- 
Regards
Vignesh

