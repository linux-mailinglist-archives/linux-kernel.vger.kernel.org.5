Return-Path: <linux-kernel+bounces-61522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5AE851335
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C26F1F2138D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FA43C494;
	Mon, 12 Feb 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rI2Hl0V9"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F43A1BD;
	Mon, 12 Feb 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739675; cv=none; b=MEOgJHwVNEc9WulGJE20urh+SdbnQCX6vgWAB8A3cZrfVVVXbn1II/XFi6rCriNsLp2P3Adkle3iEd5YqrafEHy+OUHPZQRPq1E+48grclwNmr1C703f800cH1stVExww++3x82S6h6k9GehIE4ZBGYemuruPqzhGVypfx4hWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739675; c=relaxed/simple;
	bh=FZQxAjSbsMENYeZLlWs3oYY/+VkmTLQEDlNQuTKkD+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gmIR5e0y/7HlAjJtAGFRiyaEu++Q7dlUYwSf26WtccY8+VWXhNFIvt4kWmWz88V3HyxWxg9Exon7AaGD4qBMhONBzfi7gD6nYgUegAe2j6MAnf1tHGX7U7Aa+SwMVslFFac9usysS6JM/HDeQxJ0+JjeFqJJCmDfQqG9Um7Hsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rI2Hl0V9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CC7kLa066489;
	Mon, 12 Feb 2024 06:07:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707739666;
	bh=zp0LNv0goHqTBv+tF/uktMm89aj4UuDjLZQ8Yu3qyOs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rI2Hl0V9qPkGxcJYadiU4tsFzAPpDSskPwhUQgaGwSv6GQ8M55aD/5MlKB7QfQmps
	 9OEQORZND9v8//xgT6Mfbi+0HyRQkLq4ZRdTC5FoeKefXDIRIJfwx+AK605bJS0MlJ
	 1zAZOrB98m89nUtcN0PVcjXwSkCDPgZQMOBsvqTo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CC7js0008973
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 06:07:45 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 06:07:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 06:07:45 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CC3s6v085591;
	Mon, 12 Feb 2024 06:07:42 -0600
Message-ID: <b473f88b-ae6d-49fd-8ba8-2f3e27b6e536@ti.com>
Date: Mon, 12 Feb 2024 17:37:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: ti: Enable overlays for SK-AM62P
Content-Language: en-US
To: Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole
	<d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>
References: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
 <20240201-am62p_csi-v1-4-c83bb9eaeb49@ti.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240201-am62p_csi-v1-4-c83bb9eaeb49@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 01/02/24 18:37, Jai Luthra wrote:
> Enable symbols so that overlays can be applied on the base DTB for
> SK-AM62P.
> 
> Also compile-test known-to-work camera sensor overlays for OV5640 and
> IMX219.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 52c1dc910308..80733ed747a2 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -101,6 +101,12 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
>   	k3-am62x-sk-csi2-ov5640.dtbo
>   k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
>   	k3-am62x-sk-csi2-tevi-ov5640.dtbo
> +k3-am62p5-sk-csi2-imx219-dtbs := k3-am62p5-sk.dtb \
> +	k3-am62x-sk-csi2-imx219.dtbo
> +k3-am62p5-sk-csi2-ov5640-dtbs := k3-am62p5-sk.dtb \
> +	k3-am62x-sk-csi2-ov5640.dtbo
> +k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
> +	k3-am62x-sk-csi2-tevi-ov5640.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
>   	k3-am642-tqma64xxl-mbax4xxl.dtb k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-wlan-dtbs := \
> @@ -118,6 +124,9 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>   	k3-am62-lp-sk-hdmi-audio.dtb \
>   	k3-am62a7-sk-csi2-imx219.dtb \
>   	k3-am62a7-sk-csi2-ov5640.dtb \
> +	k3-am62p5-sk-csi2-imx219.dtb \
> +	k3-am62p5-sk-csi2-ov5640.dtb \
> +	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
>   	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
>   	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
>   	k3-j721e-evm-pcie0-ep.dtb \
> @@ -128,6 +137,7 @@ DTC_FLAGS_k3-am625-beagleplay += -@
>   DTC_FLAGS_k3-am625-sk += -@
>   DTC_FLAGS_k3-am62-lp-sk += -@
>   DTC_FLAGS_k3-am62a7-sk += -@
> +DTC_FLAGS_k3-am62p5-sk += -@

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>

>   DTC_FLAGS_k3-am642-tqma64xxl-mbax4xxl += -@
>   DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>   DTC_FLAGS_k3-j721e-common-proc-board += -@
> 

