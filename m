Return-Path: <linux-kernel+bounces-45722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4E8434A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8631C21432
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2548114A9E;
	Wed, 31 Jan 2024 03:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JotxQo5s"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2073.outbound.protection.outlook.com [40.92.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFAF208A8;
	Wed, 31 Jan 2024 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672832; cv=fail; b=k99ojwUq/Vo35shOgxKV9w3f7iof7BdnWhnrQYQfloRNHcnwwNu3JjpfATlYwWPrNBp/4mY62iKfQ+Ve2ysd/eQu//zDkNorrdwGiNYOrA854SgDfj4BksGS3+bSQswDfKpsl8R5ZC4ZwyQHGl8dbFnT2TOs7DuHWcXgF+qcqn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672832; c=relaxed/simple;
	bh=uJ+Fr2OwimAzrHIjEcA0yfWsHVy3cWJ/r5bom3MK5Bc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kiP+3hCg1AUDLYL4FCfnQGym3KBln0ODybnCr2kBOPPzsrx3KmG4rx9ngKnB09lr7qdi7pdkS5Rk5A5dt2a/zVAf/Tga3dJG3Cn9X6DzuRhox97imCDqkbRzZcly+6uN5brKwUZsEqO8XCmPwDqk/vWWyXfuXwsQ7IXroz16sGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JotxQo5s; arc=fail smtp.client-ip=40.92.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzDZox9zUaRvuTcXWGy/R9HWZCkFhSF08Q2xRDykNt80+TmBlR/tTzB62Utfte2Cq+9w372Og11QZ6FH+WKSuPi4lmV1SX9LsnxVtYi2f+FDtmFhkE0PkXjTMfR9fxCx2B+GYwtXZR3G5uCUZK5FbPUS7m3nEd0g12bA4TdHgeJwJtSqaYQNHIw89nqFiGLJvX2VgxvJ9OA+aJQOOBLa4JErWF3phFcscqA312rIJ6SY1HjkSscij+Pd+tb/DOWbS1pR+Sz+/xwRMNGqMCVb72EZkmzTgg0ORVn3DpogPtrK1ifLiDG3bOrcF79XMhxrd6uCPIO8TtgUjOy4Hhos4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SMAnDe6QgUGhxviCekI42vWk9nHpHbtgLZoD4heVQA=;
 b=J8fNaCxAB/MjAIhpi4UX4CsuKMgCLpVnh4NJwpmTmUIb85A1NuAj3GuPeL9Gd3z+GjETMsYpeIJ2YjU9J+ECPRZEG/vg/bs/8AuOh8cTehZ1XErE3y7CRV09MtmWWBKGBfD0sWDM7hXdAJ3Uwy0oZ3V5LPnkLQAvGLpT68P4a5xcNxm+6z/iPNEL/nx3gei555uLsZfnJrtbv2C2Kq4bxJ5XdEkNurc5mvsR5LIjzJdjKVFmnQQfeNiLcSPQMCyV9MOO01rdhhlCEGIJciI3KxrXprhhiBWPCkTR5QBQJW1JoseMrkRqWd+O2fY0EVor0hLNKVXkUjutIN6zJuv/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SMAnDe6QgUGhxviCekI42vWk9nHpHbtgLZoD4heVQA=;
 b=JotxQo5sp+QQI2uQBuWBvz+MretoYObDxwfwb37M2NnCy32wjCfXLGh77UczOi/vSp8FTCTm+oiiwXg31+4EajqyVdPoHRaOCLqQLnO0JijPGiEdvMcDTMMd/jmWPeELgUu8gPPELYjBZjd8l90X/BHnRjvUebNYTBVu8LoQwgbf+tLussUDw1xJlyy9p95MOdKANzRiPY7agb8ICDTNJNdSMnijHC7bSCVLzbvUCyUKR1ErFKK9itsRn/JVIJLvLE1F4Xt5Ug0x4EDCsqkWH9GsWlROO2x0ZXvcjjaizpvfsEat3AhQbQDZuE9twFRvAzFyytincRRjbjXqTc3Mjw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB0875.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:16b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 03:46:57 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd%2]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 03:46:57 +0000
Message-ID:
 <MA0P287MB282206D6A401C372384B73DCFE7C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 31 Jan 2024 11:46:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] riscv: dts: sophgo: add uart clock for Sophgo
 CV1800 series SoC
To: Inochi Amaoto <inochiama@outlook.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB49537ED3211A94684EA7E9A7BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49537ED3211A94684EA7E9A7BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [ICYDRCjCaSG01GdfsT0b7bBTYTe7Vig+]
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <ab110d54-7d31-49ad-89fd-c89dbdcb3bb9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB0875:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cf2d5d-951f-4856-7bc8-08dc220f45d8
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TXg22wotW7R82WDqgIiyOiHqU56zKe/EhKA+pWiS2CV1aW7IuTQ+uaJ4vclTCKxju5dHa9eALcPFbEW48BjjU8KIELHBqrdnX5sjyrWLJyY9/iy1BSVCKOxPi2JF57TnBK6ON29wWrKN+nfUp4TygrgoRyQZwwHZG7WO8V54E+u7dlAtd1gX0Udn2YDCABIWWADBQJmgnel2ThAfSfwbTjKVEokVZQHG+LYX3VWdfd6VibL+DZ4+uxQESSl9ZqfFn+9GOru2Pwh4FQ6N4+GFcboSijc79zJ8QBFUafCmKb7OG3qpT6zE9uraD4Ku+ATa1xb/ty9s1p3xo/hB9qNPFgaHwAYht520t4mJ30a6Dv38X6MjOQVjXZ9tt0v24TZISP1Nzo+dmoGFqeuviXKZACTEDbLKDcmN3yf7/x1YAAmFUuQ0hodbtOItSWJmUQhq6Ohwh688ToU8Yb2eVbrv0he6omz9SIQ6Jy4hSzuuFZanwtUICRxZ2FFAMrz3Xh5HQZDu+axdeDlzvztIqgk1AqAmFAetilCnzEY4DZsUOVCBLQZNuUh0EDkrFq0t9aZbXJ3RXvabqDHexhCeWiP7Tb73cR+MilZDkXDm+Pm3FghG33QZAK5Fr1m/TKgNYM5ktiuw1PwbaJytGxi5wLjyI0x6AGQzIoSzuH0FjOQyRWm1bV205sqidE78Mv2yT4fv9Zj2sQz9LwwlCbZeQ9tD/ufzo8IpnaHQ7Df9t3h5vWIMWIwyM5bqXV/Ct6+QoAGTVL0fQf1Lv9RI++LCMB8hbigYUJ9Kp5ZUzI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G9sBQOnjrNmJslqeNj5M+vuF+S/juVy1hCmO1+mucvW8T/2AVg+UaGt4mneBoKQNWz2Tz714gvSW4czSd1BWfAH+4BJBudGiRszxSkZFgwVOL0o92E0yUpYkZ/xGBewzHcNSuGkcyRGTYlpZbjTC0VOZzIrg8g1suzuqKQqL9HcyT0vnW0/XhCZWu4orSyfchKehZWbcIPTSf44a9m1Wh7JAGFn5tWWXATvpQWej9wA/5eYbIHJpMM068ky6QNCLtyKlPvbqBDT1/RWrFsav2BHOEGEO6jnqNgS4mwpFbVG6l5Qmm7P1qXHWoG217uy4uMzLWZmnGxz8zV+XduSPc0Jme+JADNBEWkdPrksILpFNm2OktwmaI30urJ97NnqtxTj8TZARoIIAxHmgjJdwtk5I/Pd8xZUVi+k0CVILMetqueb0iMFBjRPmUKZ65y0QtfVnPUuIbbtpqTbWXUlWA8YfEgdLHzPO0MmLzZROZdpvsoWiy4A7VJBwc9Oj7YRdwiqP5HX5dSaOuHTkxfOLXk3OL6I47iQ/Lz27TkxhyU52wyDDdDjuO+ijUrHtvpXD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NURTN3ZQOWF1N09WeStEejM2WTlEVmxOT0orL2FWRjVsMDdCYXRDeU9jWXc2?=
 =?utf-8?B?TzBDOUxCeXYxeXZxTEdRWTdZaHNoNVVSb0FmOGpvTlFMK21oUEUrS2h1YUVr?=
 =?utf-8?B?eUxaMkg1M21uYzFoWXV1NzVDL3YxL2YzalkvQ255S0tiUW0yNGphV0hrUERF?=
 =?utf-8?B?MzhHdnQ4N2NCNXVoU3NYMW5HQlpielVaSzJUVFF1bzA1dEJQSFl1ZU8zandD?=
 =?utf-8?B?QlVBS0pkbTlIZDV1Nk9aRVhlRWtpaFJXcThjaDFkYm00MWt1QmFHR3R2SG1X?=
 =?utf-8?B?ZVdSbVRGb21qL05LdFRFb0tmVjM1WmVCUm1nN2lqUWxFc3lScDRCZENYL3c1?=
 =?utf-8?B?SGF1T0xyTW0yWUgrTEJPU1VGeUFFd3puOCtaZHdROGpDRU44WVdqYUI4MXB1?=
 =?utf-8?B?YWpXK2xyWFNQR2FLNVJFR0kreVV0YWJZMnhpUEJOT1oyZUI1Uk5SSjdxUms0?=
 =?utf-8?B?SlhPSXBQbW5qUkVaM3dRZDErdDhFK3F3S0hNS0xWQUFaUU9MOVpxbUN1N1NQ?=
 =?utf-8?B?TCs0aDFnRkdaMytnY3ZrbmtaazNsemVFeFFCNS9uQjljZ0NxbVQ5VnNPeTdL?=
 =?utf-8?B?UTd5bDdsck54ZDJyeWduL3hZd01qY3huYzA1Q0FjYzkvVE9wK1VpM1hsWjNy?=
 =?utf-8?B?VGNLMzBtSGs3WlpYbXM5dU5oeXJubEtWd1JtekF2LzV5TWpsNDV0b3A4eU13?=
 =?utf-8?B?WVZidkQ0clVYYXdERUN6MWZyZmF2MnR0VGRlV3FQSmkveTB3Q1hNYlA4NmNn?=
 =?utf-8?B?aTF5OGpiamNCY1NxR21oSUQzSys1S0x6QkN6RVorU2M0OXA1R1dUcVNkamxO?=
 =?utf-8?B?bko2ajJXeGFpbCtzT1RIU2F6enJHNmlWdVViQlNUR2JiTVFsN0d2a3VzT0VW?=
 =?utf-8?B?TUJOb0YvZCt2RXI4WXFiNkdDanRjWEtCaG5VV3V3WlBQVTFrNG9jdEVxSmw2?=
 =?utf-8?B?aVA5bDd2TWZ3QXFiVUZGMWlGTGpaNmZnKzBjaTlpVGRzTU41bUp5QUsrazBT?=
 =?utf-8?B?OGpiY0FUemtkUkJoTGh6WXJYcTdvZmNjUkt0NDlnZ2tDTEJYTm85TzN0d0hR?=
 =?utf-8?B?di9mQVRwYm42eWcvOEhTWXJEMTZkaFhNSXNCUW9IYXAzMTdNdGRIa2I5QVUr?=
 =?utf-8?B?RWRPQzV1RU56eTFxbE8yeHRWNHMvZzlrSlZTRi9GMEFnTHpDNjVaaHJjQkVk?=
 =?utf-8?B?b0R1dm9pTngrQnZkaCttRS9SWTJiR0FDL1RTbXZveUxTVXRmQ09BcDl2MVJp?=
 =?utf-8?B?Vkp4WElkdHIxc3kyM2hvOXNmTzVMOWpqQVRGRVI0dkxhK1VLWlF6QW5uc0Iw?=
 =?utf-8?B?TFZjeFpWanlZY2lpdmp3dk1OMUVkTDk4QUdBZkJGejQ3dnRQK3Avcy90cS81?=
 =?utf-8?B?RFBxVlFvR1U4ZlVsd3NPUFpGNDY1ZFkwcm5BZkJVQ0p0OTgrTkl4Nmh1bGcw?=
 =?utf-8?B?ZDlxTHZtUXN2WDcySlJNNkZXZWVscXpEOG4vT0hiMUNwdXZ4UkVJa2g1KzlQ?=
 =?utf-8?B?MXQrYThMSmlrSnI4UFg1VU5tRUZSUVVtWmNRb0tsZDByQ2tUeU9tSXBFdHhT?=
 =?utf-8?B?a2pOZ1dUakVjY3VybkRLWFFpRDZINTE3Y1dhR0lSdUFkYXNraFcrTEZoMmpl?=
 =?utf-8?Q?r0ixq0ObzIg7G3piZeCfnSZqOWB7tlULxWiO0ecw0VKM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cf2d5d-951f-4856-7bc8-08dc220f45d8
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:46:57.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0875


On 2024/1/14 12:17, Inochi Amaoto wrote:
> Add missing clocks of uart node for CV1800B and CV1812H.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 6ea1b2784db9..7c88cbe8e91d 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -5,6 +5,7 @@
>    */
>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/sophgo,cv1800.h>
>
>   / {
>   	#address-cells = <1>;
> @@ -135,7 +136,8 @@ uart0: serial@4140000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x04140000 0x100>;
>   			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> +			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
> +			clock-names = "baudclk", "apb_pclk";
>   			reg-shift = <2>;
>   			reg-io-width = <4>;
>   			status = "disabled";
> @@ -145,7 +147,8 @@ uart1: serial@4150000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x04150000 0x100>;
>   			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> +			clocks = <&clk CLK_UART1>, <&clk CLK_APB_UART1>;
> +			clock-names = "baudclk", "apb_pclk";
>   			reg-shift = <2>;
>   			reg-io-width = <4>;
>   			status = "disabled";
> @@ -155,7 +158,8 @@ uart2: serial@4160000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x04160000 0x100>;
>   			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> +			clocks = <&clk CLK_UART2>, <&clk CLK_APB_UART2>;
> +			clock-names = "baudclk", "apb_pclk";
>   			reg-shift = <2>;
>   			reg-io-width = <4>;
>   			status = "disabled";
> @@ -165,7 +169,8 @@ uart3: serial@4170000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x04170000 0x100>;
>   			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> +			clocks = <&clk CLK_UART3>, <&clk CLK_APB_UART3>;
> +			clock-names = "baudclk", "apb_pclk";
>   			reg-shift = <2>;
>   			reg-io-width = <4>;
>   			status = "disabled";
> @@ -175,7 +180,8 @@ uart4: serial@41c0000 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x041c0000 0x100>;
>   			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&osc>;
> +			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
> +			clock-names = "baudclk", "apb_pclk";
>   			reg-shift = <2>;
>   			reg-io-width = <4>;
>   			status = "disabled";
> --
> 2.43.0
>

