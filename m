Return-Path: <linux-kernel+bounces-103225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16287BC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81379B20D69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F9F6F532;
	Thu, 14 Mar 2024 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DpLK7P/8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021236F09C;
	Thu, 14 Mar 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418740; cv=none; b=jfcusD82buM4djEqskBMwJIQNSJbce3UtAGT+afA6K5uCY+lbGzWPF265bAWVM7qTU4PMFHaRSeoiEQLXk62BE4YESeVw0c6BCLBPyrGce7Si6D/Ub8bFpv3hMuqdJaG1lAn0gq9bW76CMrlvukX3+gUAi6aICbBAGyCdDRlxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418740; c=relaxed/simple;
	bh=7Duuw1QM1mH7EtQ8Nz5oYOntnarGManNYlSsJV/zREg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEJ+0O0pfa39b5oaNjM1dgMOScMsquTXEG8DbcmOIIXFSzEP37ZtTVMwuwO0AhBpXglmY/nS4Bq92/KPgixfxjQTWKVheVS662HlYvZQk4wyO5Q7vrQPAGZZNj1ulcTY0I3xFsGAdtdRad+lErMfvXcTQrGvlEMnkGQmv8TPJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DpLK7P/8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42ECIXwh115297;
	Thu, 14 Mar 2024 07:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710418713;
	bh=gFtneBT2IQ8anQD8kbxob+b2ublZuQ0VAIj9RPlUd/s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DpLK7P/8puiZqCBai4dsfbOt6ITAHkRBDkzj2Rn/Y0CQEuScWmw4hKJuhzO36WyQT
	 BRham6K6wB48O4sBYt2xenOKz7uouAKT4D1L4+23pxNvMWKRRN4/kNYkCTXSUFUpoB
	 fYkq+UN1vqeuZ9scY2m4IKjuplG1fYaDus2UvjCA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42ECIX9G015559
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Mar 2024 07:18:33 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Mar 2024 07:18:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Mar 2024 07:18:33 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42ECIXWN094446;
	Thu, 14 Mar 2024 07:18:33 -0500
Date: Thu, 14 Mar 2024 07:18:33 -0500
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
Message-ID: <20240314121833.4fngkk35aw44o2x5@array>
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

Umm... Minor clarification - the SDHCI IP is not TI's - as commit
41fd4caeb00bbd6dc55f056f3e8e956697b0760d says, this was an Arasan IP
which was integrated into TI SoCs but needs it's own driver due to some
quirkiness in the version TI picked up.

Are you OK to rephrase this as TI SDHCI 'instance' rather than 'IP'? If
yes, I can do the change locally when I commit.

> commit 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect
> debounce timer"), because of this the boot time increases of up to 1
> second.
> 
> Workaround the issue the same way that is done on
> arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts, using the SD1 CD as
> GPIO.


Side benefit of this will that if you boot out of emmc and when runtime
PM disables the mmc instance, you still can detect card detect via GPIO
block, which I think is a better source of wakeup than keeping mmc
instance powered and clocked waiting for an sdcard insertion event. No
action needed, just making a side note.

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
> -- 
> 2.39.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

