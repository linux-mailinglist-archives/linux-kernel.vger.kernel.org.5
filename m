Return-Path: <linux-kernel+bounces-120438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB3A88D767
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C461C238F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5FD2C68E;
	Wed, 27 Mar 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lg2sCRIh"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2047.outbound.protection.outlook.com [40.92.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1A25779;
	Wed, 27 Mar 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525170; cv=fail; b=sQ3Mn+xBBudTHB9HBr5fPAcY9L9d9fM0sBBbemRw2Ae+D1E/jkjqipvxdrXmVN/Ba2qptz2F5nIa1hnksEiNFTTjdNKChV8SuSbLkj+ePzK7FrNpU6WJN20RD5V+P4kCjOfSn7ZbfMRk6R0c+7uVK73Bqf9I5vEnkrox4Vu0rUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525170; c=relaxed/simple;
	bh=8FjKproQDPU6iMRCa9oym5j85t0CU2LX3wMahi3PEQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXByAvTXgb3nUqjsjSVLZv7xKuvlzaGy++27clxyvjBLH58tOE6YLD+wJiJajJiLeu4SebP+my60Ps7ZuHF1ljVmD/4mFLPgFSjrStcHFcuUYKdJ4+4dBopy0kThhvvFAj2E+C7QewuCnnV8aQHgcZpeIOqlYjpHU+nQM5XEZ5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lg2sCRIh; arc=fail smtp.client-ip=40.92.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbRu9pLk82FGBFNjQC/FiuF2t16hkZy7ed7ri7peCoeaKvg+KjvuErUWXsta24s6ovSA+x7Mi0DXHyc+wHS1/BOf1D9dsaDjMn/Z1W+kwefnKKhR0guVte7mu1C8en3fpy2DxMoJiMHpvC9K4sKDtNgcTV6SQdIUaeuDmqsc8aQD/0rQw0eBpQcLrtdvxN1iPOVKN1fNDVW9oBwkWZuTfTWNedeSUyELgeHITljxC20qR80jgOvCZijvqE0UGUTSAY40Oeu6DRsVuSEzniRb4sBd0zS4YGCjsgF8MQHbspgFNpZywUjDElHAcGeN3crhOA9V8Bpp+xFzZ2vHE5QsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8I07IGH4QA/zvKGgpAlhdtghhdKRSeRUMOwGgEusbQ=;
 b=JlwhzarGUl7PrgzLMa3oOecDrd34F03OsEZESWMLsuKbey+kG/yrvQWWA4bEC0RCFYLwEoC3dLz7SN7XwqsCrB49aPJ+yfa1+vOZEn2wwtEN6vOU2TZc2Y454KPnuDLjMMSXV3yiaZArYxSXb8e55XOUdwK/ruTPszvPgHJMHN5tsTiFSOxLb1dGRL3/zbgd9V0dKsq06vAa/YwzIhOZoe116ERKu05HEoLexRpdTmQlyglNYrWosmI3AlJAZH9qbomorEB2n1D0st6t5oQ7pfUYc1g4auw4gluDiRZbWepBO88Y3F9M6xWagSXTgGiPTGvJo6RV9a836et0l+SyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8I07IGH4QA/zvKGgpAlhdtghhdKRSeRUMOwGgEusbQ=;
 b=lg2sCRIhsHh0lOkmcGvzf8o/oCdtJJMOke1qLY1SoLriov5VQU3DlIH6XRKwUr6ueRTRXq9eJ/aMJZ9OMlQRHmFJ9zVuO0TZ2xYZ5graq1jV72kV6qoUAL22y9Y7diACXlZzsqsXm5gv24mTXRY5QyJTe832h2fVvlCueni8TIxwCPWVVDHQO35Rb8WtFJjGZEzHNGKYxf5cyR6DTudS4fDBF4FR8cNRWuqvowXMuzsQeIOWGa3T1tpMDYKCPBSxcnGuIW5zPRrfVc6wxv6pgnRc0Tsds3T6hU2EPGvFyUrupTZaJD5afCqe//rB2W4RN8RabZE43noFno3QO9iz2g==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB6968.namprd20.prod.outlook.com (2603:10b6:610:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 07:39:27 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Wed, 27 Mar 2024
 07:39:27 +0000
Date: Wed, 27 Mar 2024 15:39:32 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Jisheng Zhang <jszhang@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC] riscv: dts: sophgo: add sdcard support for milkv duo
Message-ID:
 <IA1PR20MB495363491777ADC885D830D1BB342@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240217144826.3944-1-jszhang@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217144826.3944-1-jszhang@kernel.org>
X-TMN: [jPNAryQo7DRe+VxwcchGsIduvIm8YflRwQPl5Ahafc8=]
X-ClientProxiedBy: PU1PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <qx3vooxvaicshk6sk73brw6ebn242lxd3gtm3y5sd55dln5pix@teyswivlmvxc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 427fa61c-dd3f-4d52-7e2d-08dc4e31065f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TUa60LCVu9+KtNAYJtF4AHztwgqnmhB/T3hVUXVDJtxarExAHISMaIyOEfEWTEKlq4f9KEUSq8BewTzzqYY65gKj0kI4pWpWtlPz1Hbl3/dRfdrPUo+8H5Hrr0MEefGjfKhAjL0IOL1SCuKnca4qB+oHq0FZt9vdzOdz07Clo87lem3hxHHLibdlYJMqDcfqoUjqNEpkT/i97FdCosv/YLeYYxGomBoU1c7XiooKC4N2NXtWDueFYdvb7PVu+E8Hp365QZR+m2ZpO9OMDGz7DEaHTGXZYd0abApF7TZjyRL/ra1MX3afDzB2lt2hjo1jBSRUUa5a72r0NpXdjcte/aag4d4Du9tw1o7UTSx4Z1gEE+I0p9pKNch+IkUiIXc/PP6xlNacPyrsXpfqUPwd9bHA+RTm6DKpEvLjTUxBcw22d+6y5Hi8ETuKmV/LlbGuHCBXmrgGhSlMjPccXo79B9fzaeuoBnudB0oaOAY2beauoN+uweEBXE1bCeHC3LBc+KowzFLmpNyJlf6N0OcihtZ7EYu6oshmbz1afokbsWi2Gg4EqhC3p+RDeRRjEzw9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?poSLNEONaibh8HWpuxU4aQD2CNIr9v78Kgaxcj6E8JF7FwZxIKincKx4uzBR?=
 =?us-ascii?Q?PcZufairBma+DJID4E6CTb2iMmN2ljYT5IHZPW6WeIYSGN9T0bgB9XYnpxgx?=
 =?us-ascii?Q?pbE/BOkPTj04ENT6uwPFDQguxYSarE1mU5MZ+VsXd7PfEpYNXvOcURDfeUwj?=
 =?us-ascii?Q?dmMvWOvx+P5k/d05VEBPz2ZLRojT9WpwlG4/HRa6lSsMh6hezTCuv3bjA+zR?=
 =?us-ascii?Q?ASj6oToV/kBGFkhd7VIqLcPo04eGmdRTKRiEMc0ECrKYRUjRIApk5qsgp1u9?=
 =?us-ascii?Q?9YAY+EFP1yb4Y3j6KlACUNTLQMgTdal61NFutnMQ/BqR6tyXsapwm73BbjiK?=
 =?us-ascii?Q?yiYMqWKsOvu09LCxem16ieB4WQiYvbAT41P5SQmfxbFHJPIy0figxr2JF1Xe?=
 =?us-ascii?Q?niXDrOFDYN0NEv+9GhU2cK9bOVnBtn3/NeMMkxxGcCo7/AL9tHbYNnMXrQo/?=
 =?us-ascii?Q?DUbzzeUYcsEWzqfWp45Pa6MOaQ0oRwY3g3SuK/AZRUrCJuNtyqRoL14t+MKl?=
 =?us-ascii?Q?3ZGmGTTId0sot9Ts2Vi/+K0spjnCRfkLZUokC5KmpPPz4FQvpNX9fE6gatQW?=
 =?us-ascii?Q?ghhpl+UWC9RMbKR/YbzRzPmPg+Q/+e8YyvzYbp9PE1V3B4IML8Y+FDoRxTtM?=
 =?us-ascii?Q?jklxipPyjoFdWF+Fr8c+4kMqZPt8fJtKqTXUTRAoL7pWoekecuCfLNCupDVM?=
 =?us-ascii?Q?HiS4OjtADUZ0IceZQfeVlD92pEb8lBJKPhONRKhGP3037O20DOvurwsmMm81?=
 =?us-ascii?Q?AxXtH3CXobdmWS2bqNJTQNywnFgpyqbOwOwwFRhtNIOdbmFpjTOgOo6A9XlU?=
 =?us-ascii?Q?Z43IO7IDgJNtg2XzyDYkYmeQX05kUB9wjhVocYLkYk/s6j/UW/xCt1S68j8T?=
 =?us-ascii?Q?9jBupBKQjgsee+lNtdm/EOq5O7jChe8txjUGUY6u1yFcgS9pOiQ1LUkHrc5n?=
 =?us-ascii?Q?dd6qIiyJB/J5XoZ3woixq/X7XaaITXGf31oB+b+r4NF3jV9E1a7AZEESuv2T?=
 =?us-ascii?Q?XwPzaEU30Y4sifuD+xTndSZka2pkJQq6/ARhyNVNvILkl3ybaNW5AROfhZKH?=
 =?us-ascii?Q?KXDjs8d1aWbJcgNv5DvHsJuv+tfZ/ezm/Ch3/VnfGg7jW68Y/albdYuGE4/T?=
 =?us-ascii?Q?YQD4lwNxoG3+UergERhp20DSYzq2CJy28/FYwPWdUnPcAhW4aDtn1adHlq4O?=
 =?us-ascii?Q?wc+Mc3vwpEp43Sk1Ydss9Dx7+NKkDkj2odazYoRDJTvPm6TyxYcZYFpKofEk?=
 =?us-ascii?Q?ZSi/NdEdcr4Gs71k1M9c?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427fa61c-dd3f-4d52-7e2d-08dc4e31065f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 07:39:26.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB6968

On Sat, Feb 17, 2024 at 10:48:26PM +0800, Jisheng Zhang wrote:
> Add sdhci dt node in SoC dtsi and enable it in milkv duo dts.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

LGTM.

Reviewed-by: Inochi Amaoto <inochiama@outlook.com>

> ---
> Since cv1800b's clk support isn't in, this patch uses fixed dummy clk
> and just RFC, I will send formal patch after clk support is ready.
> 
>  .../riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  8 ++++++++
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi          | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> index 3af9e34b3bc7..94e64ddce8fa 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -33,6 +33,14 @@ &osc {
>  	clock-frequency = <25000000>;
>  };
>  
> +&sdhci0 {
> +	status = "okay";
> +	bus-width = <4>;
> +	no-1-8-v;
> +	no-mmc;
> +	no-sdio;
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 2d6f4a4b1e58..405f4ba18392 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>   */
>  
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  
>  / {
> @@ -45,6 +46,13 @@ osc: oscillator {
>  		#clock-cells = <0>;
>  	};
>  
> +	sdhci_clk: sdhci-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <375000000>;
> +		clock-output-names = "sdhci_clk";
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> @@ -175,6 +183,15 @@ uart4: serial@41c0000 {
>  			status = "disabled";
>  		};
>  
> +		sdhci0: mmc@4310000 {
> +			compatible = "sophgo,cv1800b-dwcmshc";
> +			reg = <0x4310000 0x1000>;
> +			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdhci_clk>;
> +			clock-names = "core";
> +			status = "disabled";
> +		};
> +
>  		plic: interrupt-controller@70000000 {
>  			reg = <0x70000000 0x4000000>;
>  			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> -- 
> 2.43.0
> 

