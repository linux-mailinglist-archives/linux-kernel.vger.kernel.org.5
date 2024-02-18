Return-Path: <linux-kernel+bounces-70132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A74D8593D1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9605428273A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C015C9;
	Sun, 18 Feb 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pAF2UfF0"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2048.outbound.protection.outlook.com [40.92.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E21368;
	Sun, 18 Feb 2024 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708219355; cv=fail; b=cqHtDlneqBdEmAEiHTePbKmQoYMcUuEJlwwOVe0w2OPq2uDkVJsXulAkWPLC0Wh/+Ee5B1y65JrmBjeXo9oB4NN/N7dCgbxzUqSn9GvbzxDkOF48XfCBJHS5mgJuC4g2WfQVXf8HWScFo3gLqjlaGDFCnnaWrMt+d0mHdUl8nbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708219355; c=relaxed/simple;
	bh=TGICjXVfqDaZSHwQ+BZnZbyiB0MBFQQgOXTy9KpFAoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UPjKnqN73DuLDD6Ln8Xiqtm1Ym0JVLSrR66YUKaAn+/2eRCqmJ5pnub2uYi+x+KSNCkanw1UoTrxz5oN95ZK5SO5u6Vij9X2gGhoLMGmn0DYfHgYqDkhP91ePCYLerE7gOD3h/eo4vu7Iu7AZcAzLIlpFjtrHnH/ikwtp/AP+IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pAF2UfF0; arc=fail smtp.client-ip=40.92.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaUfGlE8j2Q2tuJiB1qhu/XAQDKXiaJcakRCHRQgtEqz4SmMCIjPlL83QjVYeZN+37kC716UzuEQHvGDJ/KPttL9eXAGOkV61jqL8ipsN53GlbHN9wRvTxu4arG/LNhiF5eqOhL1kRSA6DSZc5UH833fpkzINl6dNDNcAHlhBwB2A5wHnv3Kk74SLEuXNJsi2HfkS7k4PPF2u+gUW0ZwyyqouqbPcCpLk4hjH4oCRur+5LMOhjddcMM7K5BH14nDsL9p3RgtkidG6mn39sIi+fX9avZpuIdmMpriQ0NwGjcdXf1VqHWnD9g+zOEADEpHQupFuo0F7G2hQBUdiU3QhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vaWaqAFA+5Q5VEFR3QqVb5+qHNTx5HI79mrEpwjvWw=;
 b=UGhU2u4UMY/axwqpLlvstJGB06n6EY+QSAYuDbDR8kkhwfux779l2HI2HtTEw/ARU8UQdN3RExIH15fylVvWWKxS0X8TszjTx84Evoh6A60zPk6ZZ5By72WqKRk6etmlAa7hGSS0bspDAnt0NKvJoOPpuyO5cwCLr7CAArc5quE385LUl7Gla9HDR0rHqFXpn2U+0SiBj4UClgvZoR+6rXfH98QgFZ2U5AbD4yW4tMmx8sqqZkziLHTHgHkt7yznxvFCy33ECoHvyuiHyNqrV87H10Gke49/rwkttj49ZDyMwOxcBXOmLfV6p2oMpGCzfCY4/KVD6JuQBE0QIciuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vaWaqAFA+5Q5VEFR3QqVb5+qHNTx5HI79mrEpwjvWw=;
 b=pAF2UfF0qtvmh15WZ/WIHZ1xnpQp4ozkSdn/7ZeZ01RqDX81z6uzYBOR3kxRu34oBnBOP5L5GanS26VKQkrR1XfUouJxj/oBT5jSXkxniV4x6EPLnSDnj89MsgcqXj33Vm/izoUdfEcIs+877HQPDISE2QfHL3ew9NRB0yIE4DQ3nGJxDdnL2Z/gOdxKwQthyBG9mStfdcmlqU4LcYYNupGO4OKOfGejMLkOuazMBLOdnlQ2s7CaB6NzO5yBwAyRDY7p0wah928b1Qg/8AocBnOolwmYqEqt0Et7IDYKjHIbMA8kFEsdL1qQ+xqGBWF4AiV9vzEgaPxYZ0DyHPACxw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB0921.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Sun, 18 Feb
 2024 01:22:27 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69%7]) with mapi id 15.20.7316.016; Sun, 18 Feb 2024
 01:22:26 +0000
Message-ID:
 <MA0P287MB28223C65C1355D74E1348854FE522@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Sun, 18 Feb 2024 09:22:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] riscv: dts: sophgo: add sdcard support for milkv duo
To: Jisheng Zhang <jszhang@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Inochi Amaoto <inochiama@outlook.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240217144826.3944-1-jszhang@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240217144826.3944-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [FTeycHnoXhFIHYeXfHtl0nCv6ZLUmVUg]
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <19ddf793-7e9a-410a-827c-187557aed60f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB0921:EE_
X-MS-Office365-Filtering-Correlation-Id: b14ec5f8-79e3-475f-7d06-08dc30200fbd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zeXnT2RCA6Nt5aRuGC2rhDyha/ZQ7ot1ScGATX3DpxeS3yNtn4cAUs5xtJqGmA23MmBk+QDGDh8R/c7nJstiSJPomCFv68Tdo4rDTMTA6ka2Cvne7iPzXZYhFuJsdXo3qygNDcxHvJZtnLiFXuKZfqpFg1alc7QwYdp9eB2lUho37STHPF3bFoF6gdXapJPevQhPRh7YcDKHBJous5y0L3jtJadcR0r9RYpG11k66UQ8tSCUuTdyhpoqsHqrwjh/1URi/wnpDPNYCyqAIahc1qUmb8HusVAMRBSKRUqD0XQ7UtOyS7XBMpJtfhxEXna5bIoIUaNkpz4HKhJVCkxwTbwrYp31RIPhfghbrGOCAO8HkAOx6QnEuuJS2IpyvJFB0j56tBqhmqQOCeJ/8xGuwNzv4oPsdhXgrwPNCiDw/26UWxdGC0i88Rqkby7BcGbtZ0ekhGHaT+uPaHjokA6e8V3fm4In8uboO2s5dJF16Trjz3g3GKC4llbhdbKhGG0yGBhWrTVgiRpQ+rB/1dhedASMF6X+7e0j79cGG2obdQHYVOs3A2Qe3UI99Lgvdv2bpyWAjyy+tfHtigvEqCQNI32mqQL0t68rwPJCfFjW//8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGw3b0ZES1hGWUdXdnl3VmdEVWMrb0JIZmIvOHJMTzV2T0hDRXdMbVRrNFFv?=
 =?utf-8?B?SXJXUXZmOUhrSW1oYUZhTVpFdzJOclV4STV5TTRhbThnOHhIdG00SmRLVmFH?=
 =?utf-8?B?eXR0UlpzaGtDV2I5bGxOaFY5OE9lWFNoZFVqU0I0R0x4K3pGMXpka21sL1Ez?=
 =?utf-8?B?ZDJ6clV5ck8xTjNtM0EyR1UwWnREbUNNVytxV3pmWmxwejFldUdxNmRKOFk5?=
 =?utf-8?B?Q3VsVTFxSmFjZXBvUXZaYkRoTzNJUElxTWh5Q2JhUFJaWmxEd2tkMHlPOHh4?=
 =?utf-8?B?RzdNMmRUckZyT3FzemtPZmlJSnFIZkNtdWtRczZmc3p4UFJFelEwU0xtVTBY?=
 =?utf-8?B?ZFVPRlJJb1BoV0hNWjAwK3RjYWFlREJLMVZlaElCRGttOElRTEJoeUJFQ3pl?=
 =?utf-8?B?aG9Sa1RRb0cxWjRabjZwUWgzTlZxcjFOQVVXdVRFQ25CNTgxWGZ2SitiYkZX?=
 =?utf-8?B?NU9iRkE3S01TUkYwczI0Q09uUWpmOVEycDhUM3BlUkNTQldBQThtaDIyeHd3?=
 =?utf-8?B?ZTJnQUhtUDhVK0RkcWIwQWtjeGNNblB0cnFrWWNvYWlNUEhpZERQbzBjSmh6?=
 =?utf-8?B?aHR4aWdRUjByVytSQkxzRnhMNE5IZzljQ0RmY05Mb3c5R3REOVQvaFlITzRq?=
 =?utf-8?B?b2NETEZqMThCMWRjM1QxdnIwc1FtSWM5eDNYR0k0UkkyTjNPb1JVZ3RhOTh6?=
 =?utf-8?B?WEFQZFFHeFQvcUNqNzFVOHRKM29Fb2V5S1E2WFVRVnZ3MHQxZithRVorMUN3?=
 =?utf-8?B?SEdsWXZJRWltVEtmcXFNemtLbElZOERSb3FXa25HVVJaTWYxOVVzL1VPMzZZ?=
 =?utf-8?B?NUxXVzBTcG9BVGhBb0lqSGl4UzRUOTZPZ1RqblkrVG91RFVaTFJpTHRHVndX?=
 =?utf-8?B?MUZvY2IxajRrQnFuRkphbXB2eFk1Ni9sQnRyWnkzWENteStRQlhoRTJHNTFz?=
 =?utf-8?B?dHhmeGFmVVFVZEhXWHc0L1JkYk1SeEljTGVQY3ZOOFN1S1dlajIzVkhwWW90?=
 =?utf-8?B?NGdVelJmUTU4Y1ZpSnR5TUgrSkt4Mi9KeUQ3YjBTcjNxMk50alc5dEluc1F5?=
 =?utf-8?B?TmZlWCtxSmV0Q2FyanVHdlppWVI0bkxnN1doOEdGTGwveStjTzhEeWoybDND?=
 =?utf-8?B?WXJFaVQ1cm9yay9TSHBGUDdseVdaNFk0b2dlWS9XNFQwcFhxQkR1NnZSMTlP?=
 =?utf-8?B?N1RIZGw1bG1wKzZsNGUyVXFMRERGbnhNaXIyTG5QREpKZHpkUkFzSUo5WVNX?=
 =?utf-8?B?UXVoQVBZNHdWUHpQT2lYVzY2Mzl2eGlkeWVUSXo4eCt5bTNkOURKeGlET0ZH?=
 =?utf-8?B?RzQ2eFA5RmtHZ0RFWWUwU0M3SkltbTFmaDFxbGY4TnRhcjB5N2pvdlBKU1ZW?=
 =?utf-8?B?Nk02NG51SzJRYnpkRHBiV0kwMjFGcXhqNzIvZ2xlbzg3T2Z3MVc1N1ZvaTU2?=
 =?utf-8?B?c2ExaWJvRm00bEs3eUtXMXVnYU1TVDhmRXRxeTdDZUZJZmJWbWZtcHJFdzFJ?=
 =?utf-8?B?N1FmM1M2YUdCYVl2STJWQ0lQclZxZFJQNGF3djJ4cndZYmZKWUtoSVlKOTVE?=
 =?utf-8?B?S3cwc01rcXorcWpnaG9vclFITW0rSzN2QzIraERDYk9XRmJZNGlnZTZDdkk2?=
 =?utf-8?B?M0pOOXhzcmlwV2I4ejcxN2NUcWRreWNocXlUa1VFQmxmK2NBSnRlNmR6eEFV?=
 =?utf-8?Q?/UCB4uauvmPcSCZrdvEv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14ec5f8-79e3-475f-7d06-08dc30200fbd
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 01:22:25.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0921

Adding Inochia.

hi, Jisheng,

For changes under arch/riscv/boot/dts/sophgo/, please looping Inochia 
and me.

FYI: 
https://lore.kernel.org/linux-riscv/IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com/

Thanks,

Chen

On 2024/2/17 22:48, Jisheng Zhang wrote:
> Add sdhci dt node in SoC dtsi and enable it in milkv duo dts.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> Since cv1800b's clk support isn't in, this patch uses fixed dummy clk
> and just RFC, I will send formal patch after clk support is ready.
>
>   .../riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  8 ++++++++
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi          | 17 +++++++++++++++++
>   2 files changed, 25 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> index 3af9e34b3bc7..94e64ddce8fa 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -33,6 +33,14 @@ &osc {
>   	clock-frequency = <25000000>;
>   };
>   
> +&sdhci0 {
> +	status = "okay";
> +	bus-width = <4>;
> +	no-1-8-v;
> +	no-mmc;
> +	no-sdio;
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 2d6f4a4b1e58..405f4ba18392 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -4,6 +4,7 @@
>    * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
>    */
>   
> +#include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
>   
>   / {
> @@ -45,6 +46,13 @@ osc: oscillator {
>   		#clock-cells = <0>;
>   	};
>   
> +	sdhci_clk: sdhci-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <375000000>;
> +		clock-output-names = "sdhci_clk";
> +		#clock-cells = <0>;
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		interrupt-parent = <&plic>;
> @@ -175,6 +183,15 @@ uart4: serial@41c0000 {
>   			status = "disabled";
>   		};
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
>   		plic: interrupt-controller@70000000 {
>   			reg = <0x70000000 0x4000000>;
>   			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;

