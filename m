Return-Path: <linux-kernel+bounces-154532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6978ADD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20189282CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D02135A;
	Tue, 23 Apr 2024 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dxAPXFcZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AF63C8;
	Tue, 23 Apr 2024 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713850746; cv=none; b=B2CV6nUcadz1pKC5qSbADfjihulDZDdVQaP3FdOEytqjR2SM8bjPJeRt5yzAAFKY6aKCcjYGQPqFYDvpeFiKYbgfW2Rnjhnu0cL1PSP/cYq9qtXUfFUEc0UuZduJ3nzD8AzhLj3QNLLk1r5ReeEA6H79i5AinlcGUO3EygNzDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713850746; c=relaxed/simple;
	bh=H3795iNx+iIYnXo6O4ivsqJGtMEM2uH4epgBDQHk9Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c1UkLXBGb0fRC/STrtoMWuYtuSjF37guexTkpB1psIfe7Pvo6Ct2UBJU7DMzytBST+XHjVXtVeWMauNShYQIiUCbxsZssxwfmTlbyym5u1ew0o2Bfn6wMrYceK7PSa6FYxIg+P+BwQMzrw+EL2ey8RxBz+8AZRkg/CUe6/GKWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dxAPXFcZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43N5ah8Q043591;
	Tue, 23 Apr 2024 00:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713850603;
	bh=zfX6IQq7nYn8WWU8q32/FB26+5W/hTad6psExqtaXVM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dxAPXFcZhv5aJ1dj5N+5kA6uTW3d33iI+lArmYyzb2mCB2zu9ow43UKbvG5K0+Lvj
	 G1qX2V4BpSGCG7VkjMRokBuuctzSlzpalUqrGNhKsjaY34Mfpgk/yftKRmdmdwkpdw
	 Fjenm3sMLILmJq6eTs56hkBJ6j82NoTP5ISXiS4w=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43N5ahPf006576
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 00:36:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 00:36:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 00:36:42 -0500
Received: from [172.24.31.60] (lt5cd2489kgj.dhcp.ti.com [172.24.31.60])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43N5adXg069668;
	Tue, 23 Apr 2024 00:36:40 -0500
Message-ID: <36f038f8-494d-4768-8a80-f7f42dc785c1@ti.com>
Date: Tue, 23 Apr 2024 11:06:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721e-mcu: Add the WKUP ESM
 instance
To: Neha Malcom Francis <n-francis@ti.com>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240412053650.703667-1-n-francis@ti.com>
 <20240412053650.703667-2-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240412053650.703667-2-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Sorry Neha for one additional comment

Since you are doing ESM cleanup.

Could you add following please

1) Main_esm for J721e, should have bootph-pre-ram

2) Main_esm for j7200, should have bootph-pre-ram

Thanks

Udit

On 4/12/2024 11:06 AM, Neha Malcom Francis wrote:
> Add the WKUP ESM instance for J721E. It has three instances in total,
> one in the MAIN domain (main_esm) and two in the MCU-WKUP domain
> (mcu_esm and wkup_esm).
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Changes since v2:
> - no changes
>
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 4618b697fbc4..3044e08f6858 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -689,4 +689,10 @@ mcu_esm: esm@40800000 {
>   		ti,esm-pins = <95>;
>   		bootph-pre-ram;
>   	};
> +
> +	wkup_esm: esm@42080000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x42080000 0x00 0x1000>;
> +		status = "disabled";
> +	};
>   };

