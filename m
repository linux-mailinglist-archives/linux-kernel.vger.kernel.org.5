Return-Path: <linux-kernel+bounces-137958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D1A89EA52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF4B1F22980
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8A20326;
	Wed, 10 Apr 2024 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K8Sgwi6f"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2317C129;
	Wed, 10 Apr 2024 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729158; cv=none; b=h+4MeiSxLFE9NZ+UYMmLsk8DAvk0/lmvaheOnnmN3j1mzcLt9lfQkbVOFVcIvYoi87gDsfNeKfrIlFcFsj0zddejrYYRf7XB919KkedH1fNHtcxQf6IlujixI29uotvM0etKuOF6gAqtiThrUfjJMNRkwaoSTx7VQcMQZJ7Z3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729158; c=relaxed/simple;
	bh=DVHB2q2GJovhxPFwVciTSpWQoweRjR50YuTmJuOXzoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cE2D3ncF69EcO66DZQn0d8jNCUh+ch8bs0eY4qVmTTau2wDVtuo1epDVoAa4gMWh4Bdvw/UeoIyiTafmxB6Z1PXoef+gosnL6LaLqwFHi3wYDNT18Y14Flye0vcTVCnYaGZV8aMGU0W8n+cWgQW32FIlzw/03W1L8kYVMpjuAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K8Sgwi6f; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A65i81084426;
	Wed, 10 Apr 2024 01:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712729144;
	bh=LOHKtXEiE3d6AuJ2L8rr+IMyqwcKlUeg9Up/wDw6oeg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=K8Sgwi6fBQ0zTyropujuPdrOfaQV2UUmZE2PBKyf+cZHsxXJ5CFmHItPBVpxyqu2e
	 fDqG5Ab0d3bMNSDwQIcwiEwBrLOxeswWYUy0FLBdIAV2Rstqd5r+AcL9R3eHhZm7Sg
	 a5/fC2cmDVNobSorivWJsFZ4653gSEtKe5XpWg3A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A65iSi007048
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 01:05:44 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 01:05:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 01:05:43 -0500
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A65eI9070155;
	Wed, 10 Apr 2024 01:05:40 -0500
Message-ID: <f999020f-0f07-4eb3-bc59-f1a0f7237af7@ti.com>
Date: Wed, 10 Apr 2024 11:35:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: ti: k3-j7200-main: Add the MAIN domain
 watchdog instances
To: Neha Malcom Francis <n-francis@ti.com>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>
References: <20240326122723.2329402-1-n-francis@ti.com>
 <20240326122723.2329402-5-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240326122723.2329402-5-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha

On 3/26/2024 5:57 PM, Neha Malcom Francis wrote:
> There are 4 watchdog instances in the MAIN domain:
> 	* one each for the 2 A72 cores
> 	* one each for the 2 R5F cores
>
> Currently, the devicetree only describes watchdog instances for the A72
> cores and enables them. Describe the remaining but reserve them as they
> will be used by their respective firmware.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 27 +++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 657f9cc9f4ea..c448c2218e23 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -1254,6 +1254,33 @@ watchdog1: watchdog@2210000 {
>   		assigned-clock-parents = <&k3_clks 253 5>;
>   	};
>   
> +	/*
> +	 * The following RTI instances are coupled with MCU R5Fs so
> +	 * keeping them reserved as these will be used by their respective
> +	 * firmware
> +	 */
> +	watchdog2: watchdog@23c0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23c0000 0x00 0x100>;
> +		clocks = <&k3_clks 258 1>;
> +		power-domains = <&k3_pds 258 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 258 1>;
> +		assigned-clock-parents = <&k3_clks 258 5>;
> +		/* reserved for MAIN_R5F0_0 */
> +		status = "reserved";
> +	};
> +
> +	watchdog3: watchdog@23d0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23d0000 0x00 0x100>;
> +		clocks = <&k3_clks 259 1>;
> +		power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 259 1>;
> +		assigned-clock-parents = <&k3_clks 259 5>;
> +		/* reserved for MAIN_R5F0_1 */
> +		status = "reserved";
> +	};
> +

Please see, if this make more sense to have label as watchdog28 and 
watchdog29, to align with TRM.

Also request to add mcu domain 2 watchdog as well.


>   	main_timer0: timer@2400000 {
>   		compatible = "ti,am654-timer";
>   		reg = <0x00 0x2400000 0x00 0x400>;

