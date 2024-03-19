Return-Path: <linux-kernel+bounces-107501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F44387FD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0F5281FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450B7F7FE;
	Tue, 19 Mar 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w455ev9a"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957F7F7E8;
	Tue, 19 Mar 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850058; cv=none; b=qZamf7Ce9IKgWMvZQGXuoHayqyrZaBuM/pl3Rd/a26tMTktPVolgUskHXypF0Mj1ErmwJmq4mJ23amoGL6+FX04jNCNEW8B7URwPGTEJDCrMNeniIMNv3nXQe+rKifuNkKO712k8mILFT7+jcYNIbcP6KKsW06FzHiC0lWTaLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850058; c=relaxed/simple;
	bh=cPXOCxN/qj5MNkfZA46Nw70sJLBoN3u3hI5FpL/THBY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwUPGPvoRvtfq8Es+QhuvOV+oGRWyr2ow4rpVayRY5dRMgK+XHHvI/v3SFx9/3bxZ5Lsxkc0QSTQKqrKKw3nyqIZCCYYX4eV5RN/phoLDl5WedOMI9x0vYHvwkYfdOlGN23/nxep6+zgtGs/jXwLo0NtX76s1A0S0oQ4NXbV5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w455ev9a; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JC7IZ9100949;
	Tue, 19 Mar 2024 07:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710850038;
	bh=lMgFu7XIMey/lHmBEVhgEJNMBOcUUdu7IfwteAPw/qo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=w455ev9am1AokC27j+mHA6YYLzG6eJFVO89yAaqLHkYWCrwjsJPFlUQtGT48hkhpQ
	 QcoT49OyZyReLLt5210mlM6B3TAGZgYnDEsWUQPAPS7xHI1xf9ZAqiIjJ8DVRbuwDj
	 teolUBmZJI+c6fwnCSVdkxCvu0RABtYEY+AJo7dE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JC7Iav131031
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 07:07:18 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 07:07:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 07:07:18 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JC7HcP032285;
	Tue, 19 Mar 2024 07:07:17 -0500
Date: Tue, 19 Mar 2024 07:07:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
Message-ID: <20240319120717.e2p65ricusxuz3wm@subatomic>
References: <20240312144956.40211-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312144956.40211-1-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 15:49-20240312, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> TI SDHCI IP has a hardware debounce timer of 1 second as described in
> commit 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect
> debounce timer"), because of this the boot time increases of up to 1
> second.
> 
> Workaround the issue the same way that is done on
> arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts, using the SD1 CD as
> GPIO.
> 
> Suggested-by: Nishanth Menon <nm@ti.com>
> Reported-by: João Paulo Silva Gonçalves <joao.goncalves@toradex.com>
> Closes: https://lore.kernel.org/all/0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index e8d8857ad51f..a9bf2c17f95a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -457,6 +457,13 @@ AM62X_IOPAD(0x01c4, PIN_INPUT, 7) /* (B14) SPI0_D1.GPIO1_19 */ /* SODIMM 161 */
>  		>;
>  	};
>  
> +	/* Verdin SD_1_CD# as GPIO */
> +	pinctrl_sd1_cd_gpio: main-gpio1-48-default-pins {
> +		pinctrl-single,pins = <
> +			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 7) /* (D17) MMC1_SDCD.GPIO1_48 */ /* SODIMM 84 */
> +		>;
> +	};
> +
>  	/* Verdin DSI_1_INT# (pulled-up as active-low) */
>  	pinctrl_dsi1_int: main-gpio1-49-default-pins {
>  		pinctrl-single,pins = <
> @@ -571,7 +578,6 @@ AM62X_IOPAD(0x230, PIN_INPUT,        0) /* (A22) MMC1_DAT0 */ /* SODIMM 80 */
>  			AM62X_IOPAD(0x22c, PIN_INPUT,        0) /* (B21) MMC1_DAT1 */ /* SODIMM 82 */
>  			AM62X_IOPAD(0x228, PIN_INPUT,        0) /* (C21) MMC1_DAT2 */ /* SODIMM 70 */
>  			AM62X_IOPAD(0x224, PIN_INPUT,        0) /* (D22) MMC1_DAT3 */ /* SODIMM 72 */
> -			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */ /* SODIMM 84 */
>  		>;
>  	};
>  
> @@ -1441,8 +1447,10 @@ &sdhci0 {
>  /* Verdin SD_1 */
>  &sdhci1 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_sdhci1>;
> +	pinctrl-0 = <&pinctrl_sdhci1>, <&pinctrl_sd1_cd_gpio>;
> +	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
>  	disable-wp;
> +	ti,fails-without-test-cd;
>  	vmmc-supply = <&reg_sdhc1_vmmc>;
>  	vqmmc-supply = <&reg_sdhc1_vqmmc>;
>  	status = "disabled";

Minor style comment based on recently added https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

ti,fails-without-test-cd comes after vqmmc-supply and above status.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

