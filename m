Return-Path: <linux-kernel+bounces-137944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BE089E9EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF441F240B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD951C6AD;
	Wed, 10 Apr 2024 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DTHiC25M"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A0C8E0;
	Wed, 10 Apr 2024 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727965; cv=none; b=se2vzo3JGQacVPfmh96YpgzsVDN5zmEIfEVpYXIqUn3Ou+GcYhL5y82nnFmH82p6NtqeG60bCfZ+GsdH5UklySYZZmT7Yqfh0+WcIwypvRnwYkA1tgPCtPi2fpp7qkGIVC4MWchnxfiWxsuu1qolSJsBQFdxXWfBbRsi33CsDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727965; c=relaxed/simple;
	bh=m9SEc8LAMGN3xqdpuXiA1ByowMiwImuc8L3+DbmP5N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=avqr4ptS+YlZK9f+UtQB3n5G/s+sF8GU46u2jE3i4hAZR65Vdsk19x/0fQxD5DTKAU8/JAlrd/BXF4DmZF92iLZU8OIAd2GXMSQcFaFliAB0Rn88jffH1kp1BK1AYdPtQWzNtk0jxIHCpbc3Bn8knOCN/8A/9xiG7lRI8btqP04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DTHiC25M; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A5juJR020991;
	Wed, 10 Apr 2024 00:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712727956;
	bh=8YBZhxCl1d6nU4C8o85yeW6/48rb5M/ISfWQlkxsPEM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DTHiC25M1gVCkCZLYOnO5Mjr87G6JrHV2WpDPW4ohITftQZpuUvOg/IjDIg1NL4EI
	 50ODMYSBCKolQFSxHAaQNaSguD+2fh59pFx9wug2i3QpWT7NtxYeEK/+RuDs/O7h4q
	 wXCgHkKTUMUlEKDG7zs0Co+PZyjEiH5M+x54+4CI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A5juBE001276
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 00:45:56 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 00:45:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 00:45:55 -0500
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A5jpUe024126;
	Wed, 10 Apr 2024 00:45:52 -0500
Message-ID: <2455386b-cf9c-4060-ba86-34ea80a5af6a@ti.com>
Date: Wed, 10 Apr 2024 11:15:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-j721e-mcu: Add the MCU domain
 watchdog instances
To: Neha Malcom Francis <n-francis@ti.com>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>
References: <20240326122723.2329402-1-n-francis@ti.com>
 <20240326122723.2329402-3-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240326122723.2329402-3-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha

On 3/26/2024 5:57 PM, Neha Malcom Francis wrote:
> There are 2 watchdog instances in the MCU domain. These instances are
> coupled with the MCU domain R55 instances. Reserve them as they are not
> used by A72.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index b0f41e9829cc..867f307909be 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -694,4 +694,30 @@ wkup_esm: esm@42080000 {
>   		compatible = "ti,j721e-esm";
>   		reg = <0x00 0x42080000 0x00 0x1000>;
>   	};
> +
> +	/*
> +	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
> +	 * reserved as these will be used by their respective firmware
> +	 */
> +	mcu_watchdog0: watchdog@40600000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x40600000 0x00 0x100>;
> +		clocks = <&k3_clks 262 1>;
> +		power-domains = <&k3_pds 262 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 262 1>;
> +		assigned-clock-parents = <&k3_clks 262 5>;
> +		/* reserved for MCU_R5F0_0 */
> +		status = "reserved";
> +	};
> +
> +	mcu_watchdog1: watchdog@40610000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x40610000 0x00 0x100>;
> +		clocks = <&k3_clks 263 1>;
> +		power-domains = <&k3_pds 263 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 263 1>;
> +		assigned-clock-parents = <&k3_clks 263 5>;
> +		/* reserved for MCU_R5F0_1 */

Table 12-22642. MCU_RTI Hardware Requests (In same TRM referred in 3/4 
patch review ),

says each WDT has destination of MCU0_R5_CORE0 and MCU0_R5_CORE1

Please suggest, if fw level this is decided to reserved like above ?

With that clarification, Please use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> +		status = "reserved";
> +	};
>   };

