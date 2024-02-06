Return-Path: <linux-kernel+bounces-55457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B184BCED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CBDB2124B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46F2134AC;
	Tue,  6 Feb 2024 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c7LkG3fX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44512E63;
	Tue,  6 Feb 2024 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244172; cv=none; b=J14nj7W3m74J/vSU3dwlIVdStXyxBYMG28l+kfL7tNs1pimyh8PeCiIn/FxBKCBKLW3+J9eEmM0PJURz/2pQZ2ih2nfBBIKoIXkq7IIMKyg6Gp0kiKUSPY0xi8uvasA6hU3Nr8FMYX3UqcSUwOkxQ5s8hMPOLA7CkLptafrvCww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244172; c=relaxed/simple;
	bh=PqB7AVu41nfUk/E52ijBFrD3I5saZlijxm0toW1x8/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z1D/kKnC+lyjEuY0Hr0bvzjw48io2xxpEOy2UrkyeXNKSydONhmchE6n7T2401X/GEEMVJNTmAt5Vw6MrPECchV7mJmyS3IbJj2Gg5Hj/gF5RwdUNXJh3ARodQbRyr4zDVQEtescUOQo2obBTjg2EbndF8sr8ZZx44AqVo0ElvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c7LkG3fX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416ITE18113854;
	Tue, 6 Feb 2024 12:29:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707244154;
	bh=X/wNxrHWR+0ipqHOzo2Z3LxELm/8z/GsUjUq40unZHg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=c7LkG3fXMnMm42k04ixEMTOsxjIHfUe966J5A4k/mIAoJgoVftbdzg8ZjaewKUhec
	 wj7crwEthe3J5KdtHfyxt6gYYwbRQevVy4rK0WGLbNlGe5m9i6F5MqnAP2wSfLMYV9
	 amV8K84Nh3ZigltdT99gtf8kxVyIk1eAAAzPW4ZA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416ITEr8016242
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 12:29:14 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 12:29:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 12:29:13 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416ITDfn104618;
	Tue, 6 Feb 2024 12:29:13 -0600
Message-ID: <65a24f21-4cc6-4843-b838-b1c7020ca45d@ti.com>
Date: Tue, 6 Feb 2024 12:29:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: mallow: add TPM device
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240126165136.28543-1-francesco@dolcini.it>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240126165136.28543-1-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/26/24 10:51 AM, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add TPM device to Mallow device tree file, the device is connected to
> the SoC with SPI1/CS1, the same SPI interface is also available on an
> extension header together with an additional CS0 signal.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
> index 17b93534f658..77b1beb638ad 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
> @@ -127,6 +127,16 @@ &main_spi1 {
>   		    <&pinctrl_qspi1_cs2_gpio>;
>   	cs-gpios = <0>, <&main_gpio0 12 GPIO_ACTIVE_LOW>;
>   	status = "okay";
> +
> +	tpm@1 {
> +		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +		reg = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_qspi1_dqs_gpio>;
> +		interrupt-parent = <&main_gpio1>;
> +		interrupts = <18 IRQ_TYPE_EDGE_FALLING>;

Just a heads-up, the SLB9670 datasheet says this device uses
an active low interrupt (IRQ_TYPE_LEVEL_LOW). Using TYPE_EDGE
here can cause missed interrupts if the line stays low for
multiple interrupts.

Andrew

> +		spi-max-frequency = <18500000>;
> +	};
>   };
>   
>   /* Verdin UART_3 */

