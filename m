Return-Path: <linux-kernel+bounces-166048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73888B9539
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478E31F21C41
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4580224F6;
	Thu,  2 May 2024 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="o+3EJRTj"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B32230F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634712; cv=none; b=nPcDQaLVNVVGkLuLwUa+iqSWUi+of0IpI6/MXzJidREyMx68+ZEk4OxC1s7yB6DlBStk3qPbDpGn5oQxtESkYWuf+wNzVIkYhr4OTkWo2PPCUTryJiiyClvRMW0a/dnr7/WiIqanGKcJW1a7b1phOQAtvUqFQroeE95c6WqXrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634712; c=relaxed/simple;
	bh=KwmzZzoDnQqA2MyGh7jqFo5MjjJemNuYSwzxF2nnuDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i+CA0TdxOUq+JZsQGKaDONRVpJgeO7dkSaMjveDAVZ/7s4g83vfZuqmhIb9s9w4p4nzR/RPicf1m9YEEyxttNLqiXXLu1cZuKc4KIyqoMIfPF0bQKNMTRb6mwteylaCrzmb+UV3uf7WKvlPxpgs69rTSKxzc3lqcLucV963Sr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=o+3EJRTj; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1714634705; x=1717226705;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KwmzZzoDnQqA2MyGh7jqFo5MjjJemNuYSwzxF2nnuDU=;
	b=o+3EJRTjqpBR4958wAJFtlHf5KFrcmaPH3Zx4/C0qeMzncujG8+soce9okooApUx
	Cp6iw/cjp43Uyz27LJ5dy9GZ0OqO0eKBBVKSxDxjsUldTqdJ+BCNVYw5AhbxVyhr
	6QA9V8ZxpKJIi/wfppMZkkhz/vqfsfwL0bR/Xvfk4/8=;
X-AuditID: ac14000a-fbefe7000000290d-a4-66333fd04e18
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EC.E6.10509.0DF33366; Thu,  2 May 2024 09:25:04 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 2 May 2024
 09:25:03 +0200
Message-ID: <aac6a41f-a384-43c5-8eb0-722cda74b4ea@phytec.de>
Date: Thu, 2 May 2024 09:25:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: phycore-am64: Add PMIC
To: Nathan Morrisson <nmorrisson@phytec.com>, <lee@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<vigneshr@ti.com>, <kristo@kernel.org>, <j-keerthy@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>
References: <20240429195830.4027250-1-nmorrisson@phytec.com>
 <20240429195830.4027250-2-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240429195830.4027250-2-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWyRpKBR/eCvXGawa1JlhZr9p5jsph/5Byr
	xantTUwWyz/PZrd4Oesem8WOtoUsFpseX2O1uLxrDpvFmx9nmSw+NG5ms/i/Zwe7Rfc7dYv/
	Zz+wO/B6bFrVyeaxeUm9R393C6vHn4vvWD2O39jO5PF5k1wAWxSXTUpqTmZZapG+XQJXxtrj
	VxgLegUqPvzfwtjAuJ+ni5GTQ0LAROLWyvmMXYxcHEICS5gkHu6aCeXcYZR4dO0FO0gVr4CN
	xLzJf1lAbBYBFYkDS95BxQUlTs58AhYXFZCXuH9rBlhcWMBJ4uGWnywgg0QETjNK/Lm/ghnE
	YRZoY5SYOuENG0iVkEC+xIsFPUwgNrOAuMStJ/PBbDYBdYk7G76xgticArYS1y69YoSosZBY
	/OYgO4QtL7H97RxmiDnyEi8uLWeB+EdeYtq518wQdqjE1i/bmSYwCs9CcuwsJOtmIRk7C8nY
	BYwsqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGC4lCEgWsHY98cj0OMTByMhxglOJiVRHinLNRP
	E+JNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cAo3THXbsfM
	HI+WZNPdgj6GE1u/NG46/UV+zYfw1zstMpLDD736/3Xxhy+KWx0NNQ/OZqr6nzR5o/znH880
	4xUP1tye5bbtM8Px2D+Bdse2JMku4LYt/PcxdgYbr5B5xUnVdvszOXcvWjRNk9o+7/jJKPV1
	+Tcd767PNalP/v5grnr7zYeTjxo8VWIpzkg01GIuKk4EAPx30T6xAgAA

Hi,

Am 29.04.24 um 21:58 schrieb Nathan Morrisson:
> Add a PMIC node to the phycore-am64 device tree.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

Please enable the PMIC driver in the arm64 defconfig.

REGULATOR_LP873X & CONFIG_MFD_TI_LP873X

> ---
> v2: No change
> 
>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 44 +++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> index 125e507966fb..2c3b20ddfb8b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> @@ -265,6 +265,50 @@ i2c_som_rtc: rtc@52 {
>   		interrupts = <70 IRQ_TYPE_EDGE_FALLING>;
>   		wakeup-source;
>   	};
> +
> +	pmic@61 {
> +		compatible = "ti,lp8733";
> +		reg = <0x61>;
> +
> +		buck0-in-supply = <&vcc_5v0_som>;
> +		buck1-in-supply = <&vcc_5v0_som>;
> +		ldo0-in-supply = <&vdd_3v3>;
> +		ldo1-in-supply = <&vdd_3v3>;
> +
> +		regulators {
> +			vdd_core: buck0 {
> +				regulator-name = "VDD_CORE";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vdd_3v3: buck1 {
> +				regulator-name = "VDD_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vdd_1v8_ldo0: ldo0 {
> +				regulator-name = "VDD_1V8_LDO0";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vdda_1v8: ldo1 {
> +				regulator-name = "VDDA_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
>   };
>   
>   &main_r5fss0_core0 {

