Return-Path: <linux-kernel+bounces-45719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF4384349F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339C21C208AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B7314A9E;
	Wed, 31 Jan 2024 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Vg4SXkuk"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2101.outbound.protection.outlook.com [40.92.103.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92220B3E;
	Wed, 31 Jan 2024 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672696; cv=fail; b=YU1YiZUhX6dY8HW0B+rSlAI1o4ifyO+JpRT0/eItvOCz6RCk8+pw7bLoF+FM7cdPqmUTKmxdIJhi4v+c2oxPTkDfk5c36zKaUMF2fCtOEHX95cmn/4+Z+M9ePlrIqqrG+vjKff/W0ZJWtscg/UWcukNK8UttY9L94EL26hGR8/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672696; c=relaxed/simple;
	bh=dBPfStzYjS+J+FPeie0awDc/J9He1YR10vtIajETHHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vc/qYk9JsPhhYBnwlpM0npzhUlhpJj+dWr67EFeGfhlHPuOtU54HxpM2NDAM3vpCnndIQL1pV/yZ7V+OAxmRF4U0DJxsNHjiRW3ryWUz+dbe8r/qoQS39BoEcV/fGj9Ho6OYYXCIqXOwoqd0rZRZISskKC5UaSKriwkmnIA4bqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Vg4SXkuk; arc=fail smtp.client-ip=40.92.103.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEkeS7Dt59CazUwFp/lO7DhG3tHUk31Zf4Lyum2QdL5ekstNVc6Rl1ncOYhUFCCrcfhzLedF+qtKtjuoVwo3oCMleXROj2nh8L+KmpMakbeN9iUBugpPRqA9rFQPnimSRRLA7phZVbfWP5kGZJCH0Drl7p1HTX4upizOXRZTi3XRhfwQmA5IegfiPux3nF6t5MnxLKu2BRttIJQnEzuzaFSipePqEzjTFTxuXe/Ez7tKABH3F5cjJIvylcdfurNlpytSlRvdEfpdRuycVwOlY4FRuX3GgKdbVxDBeSDf0eFEoAoLRhaRo5nYGBamytgzvF703Zvk98ZiomY7Ou6Ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZeWFT1Eq1O+YFM6Kqh9uq/VTCI3UkGAtpdaPH1/rWg=;
 b=VQ3qjQnOCIlJ1JbNmaXsCxZhJ2UoW3nz1861CNU4WHM/irVxhNSDn/OE7e/Ca4hjY+IWHiNrgY991XE6YOqQXoR0oyg/0b0YmId4pRcMIpaZmJroAqI4y/NxancA2mUfxltT7EGphUEjGM8FoMqBuvLaqgR4Yjtt+JfFO5dW8Tb3JmCy/fgLeAy9PGsIBsTkM/J9HRJH2QgrU3dAZr3IwXpN+lWwBq9KM4QoJZwfmqep7g6MQ7BxhHcQM5JWZrfV6VY/4KPxtYNVOOdydgBBtLNQiE2wG+rVfi9mmubow+pi0yr48cxnWCY4xt3hJNHLFMkYoOJiZOs5d1+a4dnkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZeWFT1Eq1O+YFM6Kqh9uq/VTCI3UkGAtpdaPH1/rWg=;
 b=Vg4SXkukVViJG9H6GFo2gVxWC+uZPjfbS1vBozudibxYQoPneT1cW6IhKi8tg3E9FA3drSGkpNbmVRzmogH1b5BySiT5TJoaePlUcqwZUiThMstm2w03C3MTKVOvbFUk2AsZn/Sglt3RS3Lze0/taLZMT7yMjCJHRSsdQWKYYOcAhgbByXhr/3IpXSD5wpwVCwopKHz5wWnN2jsCeq7Amu3+ct95tgyN3D4pwpd4iB3VfleG4cUFDeye2EYGgD9G8U15JWgv01rfXAq5C50dh8x+qaSqGQdCcton7L2OvMsLUiDkWLWNExDi9YOua1DL1mSdJwUpIT7k9WD181E3hQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB0875.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:16b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 03:44:44 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd%2]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 03:44:44 +0000
Message-ID:
 <MA0P287MB2822C383EA3F6763705AAE28FE7C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 31 Jan 2024 11:44:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] riscv: dts: sophgo: add clock generator for Sophgo
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
 <IA1PR20MB4953355805F79ABDD7FE9129BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953355805F79ABDD7FE9129BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Lbc5l0YOv8f9WQOsk79/CalNQO0ovj53]
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <2adeb19a-f86c-4244-ae7f-9e16b8dd6d2d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB0875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cad8fda-3ecb-4e42-0b39-08dc220ef54c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cNBhJfiMoze6N8KAUiguCtWqhXaSOkcSPxrQ8uSEd8PMjiLIJxMxVmSZMe4l4UnNPhZq7QQQ3r5yzy8/41k3Ymvj4N0FsdthXSSh9MEY0gqnLDQr65zKZ/pBEeSGHSn3Elysb+TtHplvz3yfRsUawumrxzQEEl/Zkx4jJPNWZwRa/AxSIwOXjF+JElbG1k7qJBqC4G/8RtB76LEF+JOYunuH4akTmwillpJd4zSVkEyMUAA2Qp7QR8eBiuNoB4BzZ3AHclKfD72Rih3zd6Pgu20fWJBODjrQH9Uyxonp787ZZdg+zZ8IMj0rEZN6DfrMktft9NcANjuvp3hT+RO/D1eqV7kfEWXpTix9VMHcFMmaCeQAa6qhB7T52mbc5/rJjSK+NK8aQ/qbiUNe6BlAYTP5GqzZZekix3DXIfiJMmw3iL2PsXw0iSdoidH0GMz+n3SgsEZ7DLqw3JJx+a1DWcX7a/wy5T8ZEbImawezBJtMGH+zL/okEJgbfzsOuXsacosuUEeT9BXKg8ooVuXm/+qiRK91+ev+Xlyn5nnEHsjK7hMAS6I7qQhHJ6FUTMDYyhh62mkXGVJWKYB8uCCRPXWgXY9aSdOeQjwM1SehTcEJm4vUH6FNgKpCKcJ767MUFpFX7MPWTKvrlpE2hb65Aw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXIwL3R3Wk94Y3hlb29BOW1NN0RjdGlvZnFGUElUNXFSdlI2VS80dUxGSFl5?=
 =?utf-8?B?ZytZbkE4V0R2SmM1d002NTBESUM5N0dRdkpGYzV2REJuS05MbXBacE9aSXE1?=
 =?utf-8?B?MXNFRkN2UllVc0NKZVBBTkRCT3RHTkttdDFMYmJ3OTlmZys5MHhhc0lVZ3VP?=
 =?utf-8?B?citVWExXbXdobks0RzNLazNtQURYcFR4bTRKNXBQUklqMU8zTFczNFhuNW5T?=
 =?utf-8?B?YTBIbm1jZ2k3cEZOdHdBSHJKazVPTW1OOHhkSGFwVUFHeS9BeHJBdXdMOC9h?=
 =?utf-8?B?SEFocHhXUjdyK3BoaG9mMnZ0RXVlL0NCaHNTcVhqVnZWUmxDRGNSV3RFbDBJ?=
 =?utf-8?B?TEdrNCtadXZvNkpxRlR1Qkx1QytTNGFoNTk0Q3N4NFowSWNndlBnZDV2Mi9t?=
 =?utf-8?B?eGxlZG5YL1BUVnpKMXVRbVZWZm1tQmZVMU00Z0cyNmlkUEpHUldQMGVxUmEz?=
 =?utf-8?B?cENmRElBbWdDU1pVd2k0OEdVeFE3N0pZNXJoTmNJb0JoTjdHc1BuRGRDNXVu?=
 =?utf-8?B?OXpVWjlGNHE5WTBRc3dsQmEyVENXVE05TVhRdmY0QUZDQm5XczRGZW53Y0Y4?=
 =?utf-8?B?VWxCS2VnTUdZU1N2UEwvcVFLMjYyTXcva2g3Y2Y2aXhBVFJ1NXAxZ29uRGdS?=
 =?utf-8?B?Mlo4WVh5MXRXNTRhcC85MS9nbk9kKzR1RHowRWZHRFBzK3JoY0RrdVo3Uzl1?=
 =?utf-8?B?cm1HWkFPa2xnMDEwRkczZWJaUVJaa1NzWXQyQzNsUU9GenZ2TmJUU2FqeW9K?=
 =?utf-8?B?TVhtRTFxY08vZ0Q0UEtHN2YvMXp1SEZRSm9nTmdUZVoyZGNtMXpCU1RYTHBi?=
 =?utf-8?B?YkVvYW5ZNHQ4cEdUQ2oycnRGUGpGV0EzdXBGaTVrcitTU2NJdjNaeFI4VHh1?=
 =?utf-8?B?aFB6eElySUNDVEZqdHloVmZhc2xteWptaVZPSWtWcmM1VG1pUFpkVXB1VDRh?=
 =?utf-8?B?VlEyTTVhNVVST3BZUnpIM3MvQ1R2MUIxcXFsay93UFNHd2d3R1d5VkhSczM3?=
 =?utf-8?B?UStTdklMYnF4T28zS2FSVG8wQnRZbGtIcUQ5ZWhrbzhkdVc0KzBIVk1WZnRJ?=
 =?utf-8?B?SjNvUTFNTkNVK21UTlFEd1ZFRzlWZTMrTVh2TTd2OCtQL1pMRExWc0Q1bDlF?=
 =?utf-8?B?QzkySmdLV1krazBqbU9sY2I1b3BvZmlXYnhXZGo1RTVYTG5Zd1FIUlNqOG5S?=
 =?utf-8?B?WFluSmI0NHJXcm5OaS81TWE3Q0lZWEJBMCtEMnhNaUlCWEJrMjZTZ0g5SDhG?=
 =?utf-8?B?Zkk5Vnpib3h3TUxvOWFJWVA1RG9HMW9qUEEzRklLQnJlRGk4aUFmVTkvbTFl?=
 =?utf-8?B?M2Y4OExnbnpJMlJGdlRBMVcyazkvblFoRXp0b2pBNHNUVjNaNkh4MkJxMlVZ?=
 =?utf-8?B?U05QUkhrWDZyN2t1akw1VnBvODRQbS9jNnIrRnFJZFpEWXNLdTJHZXZHMzVR?=
 =?utf-8?B?UUFhSnpOZkg3NWVVL3J6YkVBRHhtWjIzN2NjaGQyTDRkZ2hpazRkUDBZbnNl?=
 =?utf-8?B?SzZmM0ZkRDBVVy9KVUd3THptMDJCY3NSK0JiYW8rTW9zQS80ejlPMU5WK2V4?=
 =?utf-8?B?WjVqVi96a0VvZ2l0aHlndXRla1ZDbXZxVThBMW1hc1VYelhaYW00ZnBHUVBR?=
 =?utf-8?Q?81AJOP+XsTvjKf7yBBH+eByIvShNOVegEMQIzXA5/IMc=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cad8fda-3ecb-4e42-0b39-08dc220ef54c
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:44:43.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0875


On 2024/1/14 12:17, Inochi Amaoto wrote:
> Add clock generator node for CV1800B and CV1812H.
>
> Until now, It uses DT override to minimize duplication. This may
> change in the future. See the last link for the discussion on
> maintaining DT of CV1800 series.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8df248a19ca70837a3/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> Link: https://lore.kernel.org/all/IA1PR20MB495373158F3B690EF3BF2901BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com/

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

> ---
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
>   arch/riscv/boot/dts/sophgo/cv1812h.dtsi | 4 ++++
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 6 ++++++
>   3 files changed, 14 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index 165e9e320a8c..baf641829e72 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -16,3 +16,7 @@ &plic {
>   &clint {
>   	compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
>   };
> +
> +&clk {
> +	compatible = "sophgo,cv1800-clk";
> +};
> diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> index 3e7a942f5c1a..7fa4c1e2d1da 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
> @@ -22,3 +22,7 @@ &plic {
>   &clint {
>   	compatible = "sophgo,cv1812h-clint", "thead,c900-clint";
>   };
> +
> +&clk {
> +	compatible = "sophgo,cv1810-clk";
> +};
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 2d6f4a4b1e58..6ea1b2784db9 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -53,6 +53,12 @@ soc {
>   		dma-noncoherent;
>   		ranges;
>
> +		clk: clock-controller@3002000 {
> +			reg = <0x03002000 0x1000>;
> +			clocks = <&osc>;
> +			#clock-cells = <1>;
> +		};
> +
>   		gpio0: gpio@3020000 {
>   			compatible = "snps,dw-apb-gpio";
>   			reg = <0x3020000 0x1000>;
> --
> 2.43.0
>

