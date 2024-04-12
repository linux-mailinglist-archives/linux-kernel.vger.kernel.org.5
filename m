Return-Path: <linux-kernel+bounces-141946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692868A256A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F63E1C215C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ECE17731;
	Fri, 12 Apr 2024 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GYg6O5Ku"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B2D2E6;
	Fri, 12 Apr 2024 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898244; cv=none; b=HCiFyZcJStd3jSbtSAyaESHS9wjC/a9Kxu8eXJwn19DQmkXh1dggOkMUUzOrG4Rz9ZWrMwkSuVq2AbtsgPSt2L3J6BMsgQKLxeb1m/1I6k/DL0jkOtIlVZtkVDGrWgA3mevyF6882+dPH7JEycUuvOUCV18tNvMbPlo5To6nnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898244; c=relaxed/simple;
	bh=zTS2JIUKY8SJNwY5cevworB3MQmBUxBsNB9yGbfQASQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YY7YidS8fjfW0AktwUyYWg56vGrvVcsaR0C+3J/W6Z4ewfSfV6s/+7RpcAUuX6pPknQsQ9ySgwZUEbErIiTFKrpMdgFrNU4f7qbcFvRk7F/WnBeONamLrP1W7OHe7kh+4202WxDYfX4kxZuoTN3r0uq0o19+5DGoZ8ileLsRRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GYg6O5Ku; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C53qPi073822;
	Fri, 12 Apr 2024 00:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712898232;
	bh=4qWi3a0BZ6leS4p7+WypCZCy4snmyv7qO6fF1UuJe8U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GYg6O5KuFjktfT5YtcwZGXqAS39ChOOD5cOk23B/jHwW3pasXao1Dk77+g/GfMG2q
	 NDaXodp5k4O90SrqPg+BODlKLWkXjetrPoVtYmJvU2jlhkCk0VCLM1/BXeiS/xNKkf
	 nVlacUBOM4C3vC7xT64+9Yg2t4k6asYN5agnLD1s=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C53qT6026044
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 00:03:52 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 00:03:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 00:03:52 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C53mlJ024692;
	Fri, 12 Apr 2024 00:03:49 -0500
Message-ID: <fd22f818-f123-482a-97ff-6f113bc08164@ti.com>
Date: Fri, 12 Apr 2024 10:33:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: k3-j7200-mcu: Add the MCU domain
 watchdog instances
To: Neha Malcom Francis <n-francis@ti.com>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240412042537.666137-1-n-francis@ti.com>
 <20240412042537.666137-6-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240412042537.666137-6-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha

On 4/12/2024 9:55 AM, Neha Malcom Francis wrote:
> There are 2 watchdog instances in the MCU domain. These instances are
> coupled with the MCU domain R55 instances. Reserve them as they are not
> used by A72.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Changes since v1:
> - patch added
>
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 7cf21c99956e..d1a42c3f30c0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -686,4 +686,30 @@ mcu_mcan1: can@40568000 {
>   		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>   		status = "disabled";
>   	};
> +
> +	/*
> +	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
> +	 * reserved as these will be used by their respective firmware
> +	 */
> +	mcu_watchdog0: watchdog@40600000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x40600000 0x00 0xbd>;


please refer  Table 2-3. MCU Domain Memory Map of TRM.

Size of wdt is 0x100 , with this change in size from 0xbd to 0x100.

you can use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>  for whole series

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
> +		reg = <0x00 0x40610000 0x00 0xbd>;
> +		clocks = <&k3_clks 263 1>;
> +		power-domains = <&k3_pds 263 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 263 1>;
> +		assigned-clock-parents = <&k3_clks 263 5>;
> +		/* reserved for MCU_R5F0_1 */
> +		status = "reserved";
> +	};
>   };

