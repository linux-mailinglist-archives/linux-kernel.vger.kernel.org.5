Return-Path: <linux-kernel+bounces-38571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A383C264
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683171F267B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F845035;
	Thu, 25 Jan 2024 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U10t6E9P"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2104.outbound.protection.outlook.com [40.92.102.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E872A3BB38;
	Thu, 25 Jan 2024 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184944; cv=fail; b=bHrDEhisy3qnoweAGpsUme/LsFv55sIZSyi58V5C/SOKnFenc+bt9fBMklwCYlIlaf6GsL6YZrLrVRDTCe1ahcxJGsybS3Qso6b0Bo6XhouE6yD2zFR/YrCil1J4nLMlQc8Fp1taXyIAJy2XwXidzUYebiMpht3s9vpfbEXqmsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184944; c=relaxed/simple;
	bh=6Qfd+b6/gg778th4M7D/2i9R7l9Juo0D/mdPFNYkYzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBuYtVc7p4oRW5J/mwt8pAq4bbnvXxRc6GBAkFgCcemW+RDL0yIJEqi9O8kURpKgpUli8OBgbljnRbdyq2fbuZ4TsFfn9CSnAXyo3P/Wp1xP8aLYOzsABC6o6g86WicuIhyxX3Dx7zRETKVeAKVUSC7X+Qi3K+JprjSth9/w4Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U10t6E9P; arc=fail smtp.client-ip=40.92.102.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+plB3TfUOs2MZ9hOzPOpPbGNLFzl4hDyh1bxtrNxHrhPrLdrpfXCT050mLAhJU4KveC3InNumjRO+/9GMR/HNxg8VDoEXsVjpo6+XLLxVDauTvdiJnYF9aeV4UPeJoElqbq8qnrygUXA+chQsW62zIDd6rfouOxO9xUitXCVL+64hkCLmPiZm0jky/3sGXIwWM9n30rQN0k0zAbW3gMAf63eK4hLZpc2tMu6auaFQkln+VJ/Dagc1mw2sDYnlZMjl+x+55tG7d3g49rwLAfGzLHMq9BtynIkZdkJ/75ouFn92lKCQqGtmzRtR/FEOqdUfvWAQVpQZ+vChNgKC6L5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xWIeft0jiR18iEWjhQfcnixGjLYpQQukkR/pV23KAA=;
 b=UKz2W+2jOWnmB69MNResdFitJ46ZEQgyIAS4AEQLfjkVA0n0bl2tKKKIrKSKh9ozutuyw5urEI1NPWC/o6ryYOEqsG3pOOE91fWc/h5EFnhjpZ1DltV8qn6y+tpfYR6lE2yEqhFk+4cDe7S/rzYAJcZJFopJxarY8ITkP75ojIUk2zaiucP7Cq99yrUKvxRJjZQhpSgAh81cUub1ZKvRFNggjKe6w4opThdHKwtNseIqfcdtwgqOO9N0ZD8+6FtZVfnkPS6JdQ0O0mK2FpnHMErXouhOJH6Hd21vnGjTT3JGjJd2M4g3iEJzPJoP4FCl31iO00raBgR0TG5mWQJ3rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xWIeft0jiR18iEWjhQfcnixGjLYpQQukkR/pV23KAA=;
 b=U10t6E9P0VQez6ZZSK3hONeLqZtzyr/rg0+gDT7dF0P8/uJw9gv8e4Uzu+CxjCcp2juv97+ZcHFYyyzghUjBQpEj22jQqVIM6CGfPd86DjFDK7cCH1N59NgEBF1RbY9y+ik8KuraK0jUs75NzbDTjjx5g+n7YbehISB1b9CA7TXy7/3EOmn7cCGIVehHA4RECw9RWy4XH+rAmN447wK3hrfoFlYzMj3DdZDEWTR7q6SKgi8OdLjWhtPGZJBLpzmTHkOFoj5fdYTkIZZFZcD/JDWxuR0+j5R1lzNlJmSgKl6NU7z9Fk+448t7r84U4cEW74Ibx9GN4BJ19GLKz3W2ug==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB2619.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 12:15:36 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a2d5:82f2:b6d4:f2cd%2]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 12:15:36 +0000
Message-ID:
 <MA0P287MB2822D37F523A075320BDA99AFE7A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 25 Jan 2024 20:15:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
To: AnnanLiu <annan.liu.xdu@outlook.com>, chao.wei@sophgo.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [NX0HriPZIpL7V+8YRsJx5COZy4mECRKX]
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <fd0588e3-ff72-453c-b3dd-7e75c72b0b7d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB2619:EE_
X-MS-Office365-Filtering-Correlation-Id: fd729d1e-4d84-4eed-37b3-08dc1d9f55eb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xaYJmZW6CzWr8DIh2dclVn1oncV2AI2EgjIxq38ljQku61c/MMYwjY9zNTq9tMCAIB/a2R83/SDYSXhTtpGbTu7i2Ja3rZYIGu1VpUSZpCSN0b1m6BQ0VPV626gJwAQfvjcY80Huj1SJuIn1XhoFiVH3GU87fvnDo+a24XIRz34rvPm3xKNemjBPoHTwW4jiAdg7MJBWloX/OKnjTvRtSTNolx1edviVTQHexdSU19w1Y8ttp++0tP98+n1DLf3dwlBceGqIkQxzy9NGivNTMcnVPvAehUdtwHLflgkl94iyeuvQZcRdl9NKGj0E5uyIBNgtjPnna15k2Hg01uqtYEMy1gkTkDvIr3A7YZnBZhCWvb582jqbRP8DU+QMYp0UZH1ycR4ifJbdDVJY9/iDkltv7x33V5swzx6UIUuHC+7WNf9oLLCy0IudOa7CtYLLaJSsOTEhWylMaufMhdMJ9zHZPUZIkDnS8FujfBblydkkiHmP9qy5LrhwakD1w6mkmZluS24ALNLG/Q/epKgQiCi6Sa/aL9sndVK5MDV774Cu6KA6m3E125FlmPB5Czu5+3GOIdazNSyy7FNZZgIcjQumW4Sr/3rVtCVhR7oDBeT+haX14Au7ot+3nCtDEpedcDMaFRnyDyGKFCYjfLHfuA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3gwOEcxRGROKzBSU3MrM0V1TDZuSkRCREJUekZISC93c2tmQzVqcXNTa2RQ?=
 =?utf-8?B?MUtzbGVxeWhnTUhXazk0OUo4bWI5YlFianZlWGxqVzNNNjVpdjhBSU9lWHQ3?=
 =?utf-8?B?R2EwbVBsclF0Z0ZQOWVuZWw2N0VGbmJGSUZKczYxeElxOWMvL2FOODd0amRL?=
 =?utf-8?B?ZXUxK1BqQ0lKb1RFSW5tMkF0dTgwdGR5V2hsYzh3N29McnMxR20vcnR5NDE1?=
 =?utf-8?B?ZDNmbk5PWVprNDh3MzBhMlZrcXpmQzVkUTFtdEc0Tm5nRTVvK2YydkhxakEy?=
 =?utf-8?B?Mm5PQzNaNm4zdTl5d3JKVk5oYWNOSUY4QzQ2SHdmYWQrbkZuOTJlU1pMa1po?=
 =?utf-8?B?RUhNd0JZc1U2Z2oxMm5tT1g2VDV6UXlWSWdwYnBENXZGaE1VQkVCR3dLOUY2?=
 =?utf-8?B?aFdSMWo1WXVzVUdhckQ3dHM2cU8ydGVaZWV5bXpQU2x3TjEvOEJTemVQSS92?=
 =?utf-8?B?U3NyT2s3emRyUVE0MXFsUUZtRzBpSTN5T1pGd2V6bnpXcEt5YkR0VG14ZU9W?=
 =?utf-8?B?WUtzZHBmOGdEc2liRGh4c3ZRd0Y3MTM2Z0lqN2hUL1FBUVVBdGVoOXNhd05v?=
 =?utf-8?B?VFh0bEkwNXVxT2VHL1ZOUGluUjUwMXVwQmgzT0ppbXFzMkQ4SGNST0t4RVRa?=
 =?utf-8?B?dnlMTUVXYWxVWVJkb0lmRGtzb09rYVppOXdwVW1VL0VWRzFnVjRjRk1LemhW?=
 =?utf-8?B?ZG5tK1lFUTlGS240NW4yMEhCcHNhNVAyZkM2WnBHZ1Y4TUcxK09uK0x3NGx3?=
 =?utf-8?B?a2hxSDI5TkNSemhZS1pJbWFILzg0a21GYnZyM2V1SkpWbU9BSyt5ZGd0dDNV?=
 =?utf-8?B?c3lib1RnZVdZV3RtcnVHdTErT0YwUlFGWEFnaFF5TlNEdmZPaStoRmp1NFJI?=
 =?utf-8?B?ZkJEcnVoSnJWWHJORk91RjIxK3RCMlNDSS9iTmNlMEZiTTRucGxCQUx6aDI5?=
 =?utf-8?B?cjdMWEFGdE1zYWJQUDVOaWNMaFhVR081emNYTjdqRlpKVzBSTkpqZU1TdGxx?=
 =?utf-8?B?VVpVUXhoK2tpNnY2NFdneSt4TUo5VUo5NkU3Q0xQY0Fhb0tsS1pkME4rb2oy?=
 =?utf-8?B?cFVWQVVBTjlKZGhqNlk0RTBBRDk2MTc1bk4zL2QzMStON2dNalV5UGFiQXBm?=
 =?utf-8?B?RHE2S2FhdDlkUlF2U3dNVDFpM0NHbjh4ZzVtdnh2YzFXaXdDdWRCd3UvRWto?=
 =?utf-8?B?MGFDcXEwQ3U2MUtwRE0xSVRkSExleDB6a0tLWVM0eUZoRC9WMCtyZ2lVNGRa?=
 =?utf-8?B?aUY0MWlQeVBsMm8vMjRjWE92cW1ESldmelNLNHlVY0FvOUpKU2RUbUpFVkEv?=
 =?utf-8?B?TVRORm5Cd1ArODhiRjRodVFWanM3bWNEU00waVRMR20ybmFxVkRmc0RvY3lO?=
 =?utf-8?B?Yi9SYVFveThrcDM4QjdYUTBpZnRPUGFseDlmaEYzQnJ6eGJQVVNFKzczOVFK?=
 =?utf-8?B?MHY4b01tNk8xbnVEOTNXK3JMTkdpY01MZnQreDdxVnZSbjB6SG03T09FS1VZ?=
 =?utf-8?B?ek83RVltakdSVytvUmxLQU5GV3ZGNGN3a1NSbnBMOWlZVVVsZUVHdHRvM0J6?=
 =?utf-8?B?R3hTRHVLOVZON3FRTEgvMHdaTTQ2YjdubzBQY1ZhQjZPbUdrTkJzak4xRksv?=
 =?utf-8?Q?nxSQ9N6Znt4UwtPPpi5k+m1CiB+fQ7cLSd9juEzJKcyk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd729d1e-4d84-4eed-37b3-08dc1d9f55eb
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:15:36.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2619

hi, Annan, I see another email with same title, any difference between 
them two? Which one you want us to review? Maybe you should void one of 
them.

On 2024/1/25 17:46, AnnanLiu wrote:
> Add the watchdog device tree node to cv1800 SoC.
>
> Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
> ---
> This patch depends on the clk driver and reset driver.
> Clk driver link:
> https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR20MB4953.namprd20.prod.outlook.com/
> Reset driver link:
> https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/
>
> Changes since v1:
> - Change the name of the watchdog from watchdog0 to watchdog.
> - Change the status of watchdog.
> v1 link:
> https://lore.kernel.org/all/DM6PR20MB23160B8499CC2BFDAE6FCACDAB9EA@DM6PR20MB2316.namprd20.prod.outlook.com/
>
>
>   arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts |  4 ++++
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi          | 16 ++++++++++++++++
>   2 files changed, 20 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> index 3af9e34b3bc7..75469161bfff 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> @@ -36,3 +36,7 @@ &osc {
>   &uart0 {
>   	status = "okay";
>   };
> +
> +&watchdog {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> index aec6401a467b..03ca32cd37b6 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>   /*
>    * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>
>    */
>   
>   #include <dt-bindings/interrupt-controller/irq.h>
> @@ -103,6 +104,21 @@ uart4: serial@41c0000 {
>   			status = "disabled";
>   		};
>   
> +		watchdog: watchdog@3010000{
> +			compatible = "snps,dw-wdt";
> +			reg = <0x3010000 0x100>;
> +			interrupts = <58 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&pclk>;
> +			resets = <&rst RST_WDT>;
> +			status = "disabled";
> +		};
> +
> +		pclk: pclk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <25000000>;
> +		};
> +
>   		plic: interrupt-controller@70000000 {
>   			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>   			reg = <0x70000000 0x4000000>;

