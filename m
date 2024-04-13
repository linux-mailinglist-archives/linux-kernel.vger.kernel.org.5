Return-Path: <linux-kernel+bounces-143643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFDF8A3BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DCA2828F8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81C922EE4;
	Sat, 13 Apr 2024 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CwEapwmc"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2015.outbound.protection.outlook.com [40.92.103.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDF14265;
	Sat, 13 Apr 2024 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712999044; cv=fail; b=nutDgnN85SEw5lQVaB5O4BmBVUPX7QEZPAb4OYdEXoIUWPH0ym5/nSHNOUuvyvvlx/uMuFamlyKFU8YpwTjGMmihp1filDzq7pRGssasUA6YwFIkCyvRXSoENMvAQdhNoW5ykf8gn0cOhaU7JsyllzGlh9blcQZEGD+FNOztHbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712999044; c=relaxed/simple;
	bh=857XDgg0F/5FFpPHhG6ay7iLpIjJP4/dGOp6VA9GAWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Os0MEMp6kJ+UTs3bQNF/eJd11qENk2kp9Ik6Bat7r37/xcizZDLVObq0hce1cVfduFNAl3vklRqRsR1aPO4ciOPPiofiQlxo+gL60mwRvQLm++QrTSPe4va/IYeVkVmXvBJ+fyqcg2M2srJGO+ebiPiuKKUn7uWkNbVZa7wu0Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CwEapwmc; arc=fail smtp.client-ip=40.92.103.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEAcI18Z0urGtJyISsTibkulasVQTiY1CQoE8imtogpa+7ftNNZ21fba9aYZCLm2sVBLIDvWxTZJRwXCRFO2oHAqudiqjQS6xiF7u+keY9fLDBmRuKGNuOy2fbYNSQpAzZN8rPocWbPgvR5MtaNNb/enFGAUXbaCAoNnUugvA6D6dmLx5bIMYbbtT0AhB2OubpOVD1Jd/7zNuAB17lrkNRZsJ+z150H68OcV7om33Ck5IjrZFG99Wc1rtVCzSxwEhikCX/ZCe2raQFM0NpgjaC/d37XH7R6TVM/L1u719mqhZvhdjBe3lviSzjfKjyZW2sgcdNnQyd9gzZWxHI5ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm7kQ79ge/VjXMkwSDu8956GkQIzzsvc5fioeHGcbAc=;
 b=XKIdyyssK0KW+rFvyacSmeXTbEuK+6eI7dXiKY+uQkq49SrQUjpVc8s84JfNrkH0v1tUHJ9p4QoNfK36StvhwQ9U4PIdGVtSSOllzMcGuPBiGGrZP/UkHAvNw+v9M8aFXAARNSgZ0z6wlWF41N+82f120c5tw25WHu3fmz89m2qbyOEvxojnY/zH9Ck7eYqk1q6orsiJ6OcyykQ0lxEteqfkT1iP59S2zFEKmIede9j8MmZpkWBAde4rHuieY4KwrrKYfyp0AOdwVwL0E8HeuTDZnSS0DYSuOQHwspFqWr3qkZH74jqrXgzya8jNq/pug14ax5Bl0Ubo018XFIyyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm7kQ79ge/VjXMkwSDu8956GkQIzzsvc5fioeHGcbAc=;
 b=CwEapwmcQWJa5EsAkZ7RHw+mVBxLYJUJiNjqRHBQO3kmsXfDy7BZDB1c1NSGYeEVy1kAL7iKQ4aLp8wy4CtYesvg8EWuUxRSkNHYvE3YanppnWcQ7zrIPAvDiJbR/qe6budPVmacQs9DwEpLkQ7Qpr4VyKGPLkApp9ydMWnQbaez6M1szrGDwzA4ScYRlYz1EbphFgHbUktQr8G2Ma6RBynOS7p+pDPlLETuRLwwEHjfbrwS7rQ3OXfWpqEdMnq8wm6KFhOhpLTRZpVawpw97PV2vBDvzro2Rt6h95p7u9Zn+HAqBvpABD/kQyJ2mqX9ncjsAvPmiNL2x0x/6k9rZg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB2108.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 09:03:56 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7409.046; Sat, 13 Apr 2024
 09:03:56 +0000
Message-ID:
 <MA0P287MB2822087FAA743D612EC7C110FE0B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 13 Apr 2024 17:03:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: sophgo: use real clock for sdhci
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [uKrAbWDDSnVVigfZSyhQk47nnAYoO5+t]
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <5a657ec3-02a4-4bf0-86be-5870c14b5b84@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB2108:EE_
X-MS-Office365-Filtering-Correlation-Id: b624d2d3-4bb4-4c42-9129-08dc5b98a631
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CgLCLe3EcbyurMNhP44jzxFq3uIhXnusgzCF+dTmurI9yQIrCI63cFHXEB80Imflc+a7goBoFjet/B6GvydWfHCXhavtjPZvLLL4AS8+5Zx2IYCj4GtiR0F+1upMxAvUp/PxvFlb+DjbLNNxL6bRPWtxhTbOcpO1HiUBOJ2gNes6uW5KcVmIi0VmgmKhpllJ4ytnCzTTa2XinNfA0gQu4YD4/WYcMdNV+A0nA+uAxaAG8JJJzTo4mp1P1IkNTYGl0+KxeZcRWI/Ku3iPjtT73SgCc1aNxmYvPGc42jWrE7Xbbzk2SC3eM2tjl0F2tpqCFKGYyD6f+FT22LoY9ljJewLbqPcyD14AXpbz9FZd/Ml1CpdHXXvyz2Of5Oeuf2qDJ8+JDlE8xLPMI4vJ6oazGPBC3l9QNKqnm7EyhEEpdikWN9EuXhYJ9GfcJo9IUBFXYATBDbS2DPSWiMz53Yozo7gSO5blepzmu3iNOpH2m6pjAMfAhEYJVp9Tk5uHxb5IoCjrZkSWgZ7XiYwMbmtf476b1QFvNxdyXQt65wV2cESFgq5W3cwCPvXia7rZYl+X
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTViZDFDMkp5VUJ5MVArSzcvRmdsanNKbTBZWFp5SnJuVFRlM3VQVUFBSklE?=
 =?utf-8?B?WGdxTHM0YVhBbnFlbFAxbWx5a2ZWMFF4WWgzK3MxYSs5cGdzVWpIL1JkbFNm?=
 =?utf-8?B?ZzczMDFraXVUU2VhYUVHQi9JeklWMStiNS9WWk5PZExUSWpLRmJObVpCRVRv?=
 =?utf-8?B?c205RWFHTVRLNmY0MWg0UnpRdWVHMWIwWDE1U1RmSEVub2U2R294M0lqbzI4?=
 =?utf-8?B?Smc5MEZkY1JPWDRWbTFWQW1OdGk2MUpCNStMN2NoL1JPb2lJU05EUVlER0NK?=
 =?utf-8?B?NFZWVDV1eklSOXRBV211SFhxcG1wMXRCUkw0aWRFNXhoOUxORnBKcHphMmE5?=
 =?utf-8?B?dFNNeVdUSWkvWGg2SzdlZUdyQkR5T3dvaWdFOFlCT3ptWGhVQnlBdFpkejJo?=
 =?utf-8?B?NVB6bWw0ZitlelFUZ1RzNTZZRHFGQ3VkbVRjdThVMGZIamw0bk1JTUJxeFEr?=
 =?utf-8?B?MlJQL1Fmdk5ZWlBzZWswclNiN0YxWlU3WkgyZWhXbzZQNzlGeGVXYi81MjNP?=
 =?utf-8?B?SFhidkEyM2tBT0twR0lnSG1MZHMrT2tUSlBPUzNpNFZHaUp0VXd2UWFidmFJ?=
 =?utf-8?B?SDBIQkREaW0zTHdpUjA4Tm90UXkzTmp0aWpMWGpyS3J1Q0RxVDArVTNEVVhW?=
 =?utf-8?B?bktjYWkwNDY3Uy9EMzRTOGdPT2JOUmp2ZER4Mmh1ek1lMEVtVmtTZGlFaVp5?=
 =?utf-8?B?TGk0SWZKRW92cDBkclUzYWdDcHJvb0wzdlBlSndTL1VnNys5SWVia3NTekh3?=
 =?utf-8?B?QTg0OTAwVVJsTlJUZFdVV1A2TGVIcFRlbmNWMFZITk51OEVlY2FNdTdiRFFz?=
 =?utf-8?B?bDU1TWQ4R1VBNnEvYmhxN2ErU0t0UUVZMjU4cU5sdXMyZmtXcEh2SDFaTTg2?=
 =?utf-8?B?cnJDTmxKa0hnY0J2RjMxVDVZdFpJd0U4SzZVeTRpZTV4TEh4d3JmSkxJTS9J?=
 =?utf-8?B?S2prYzBPQ3pVSDhNdUIxeXZ2a3FrZzNxVmhlTytlUTdGaDZxWTluKzYzRGg2?=
 =?utf-8?B?cnlpWmlXZHFHT2IwWFVac3dPM0F6SUdReFNaUVNNck9hTHlQeFd0Y0oyZ1lp?=
 =?utf-8?B?cUlSNnR2WHNudlNuV1UwS09xRHVyZ3FaMytHTStjM3V6RWQ1Y1hRendSL3Ix?=
 =?utf-8?B?dzl0WEovQmliM0dxTFdVbllYNmVaWlpka2ZMc3VocXlvcFdDT3o5SzIyTkg4?=
 =?utf-8?B?cmFDazR4MjFaWUJBR1pmSFBMb1dmblpvSFJKQitSQ3FTUStYdEdXWnBzOFla?=
 =?utf-8?B?K3pFeXY4OSsvd2hvUUlWaXgySXJwVzVjYm5JaU95OFVZMzRDWDJqckl3bHJW?=
 =?utf-8?B?T0pkdWZUSVRIZk1EWnVHOUJIWXNqakxPVFdndHczTVNzaWZaUHdJdDhCK3kv?=
 =?utf-8?B?RkJEZmFXaS9WOTlFUndRWmdsUE9pS0VsNjVaV2JWSXpEYStITlVGWEh5RkV1?=
 =?utf-8?B?YnJVdnNPL0NMdDdRNU5lYkdpVzJFa29qcXh2aFBTajNkaFFzeGczY29ySW9B?=
 =?utf-8?B?WkFDU2dadzBsdnNXY3p2MnUxNi9RQmR0L1lyVmhKaVRUWFoxbkxNQ1FXb3Fi?=
 =?utf-8?B?QUYyYUlNUWxyK3RRRHNQVS8rMnAvUll0ZlhKQWVXTGVEanM3VGY5V1lGZjdL?=
 =?utf-8?B?QjBaQmtESXlYT2hNZ2tXTHZOeTJFRm44ekZpVmlTNFBjNlZTanRmdDNyU1Zx?=
 =?utf-8?Q?KwRSqJSGTrkglBfb0Y7M?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b624d2d3-4bb4-4c42-9129-08dc5b98a631
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 09:03:56.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2108


On 2024/4/11 20:21, Inochi Amaoto wrote:
> As the clk patch is merged, Use real clocks for sdhci0.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> index 75d0c57f4ffb..891932ae470f 100644
> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> @@ -47,13 +47,6 @@ osc: oscillator {
>   		#clock-cells = <0>;
>   	};
>
> -	sdhci_clk: sdhci-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <375000000>;
> -		clock-output-names = "sdhci_clk";
> -		#clock-cells = <0>;
> -	};
> -
>   	soc {
>   		compatible = "simple-bus";
>   		interrupt-parent = <&plic>;
> @@ -298,8 +291,9 @@ sdhci0: mmc@4310000 {
>   			compatible = "sophgo,cv1800b-dwcmshc";
>   			reg = <0x4310000 0x1000>;
>   			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&sdhci_clk>;
> -			clock-names = "core";
> +			clocks = <&clk CLK_AXI4_SD0>,
> +				 <&clk CLK_SD0>;
> +			clock-names = "core", "bus";
>   			status = "disabled";
>   		};

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

Thanks.

>
> --
> 2.44.0
>

