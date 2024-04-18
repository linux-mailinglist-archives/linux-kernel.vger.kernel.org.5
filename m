Return-Path: <linux-kernel+bounces-149693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573608A949C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D79D282993
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693B27CF1B;
	Thu, 18 Apr 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="jhTo4VAF"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2112.outbound.protection.outlook.com [40.107.8.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAED7C0A9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713427669; cv=fail; b=NzGu26Do+pSADN6dTvo+xkWErvqTCSKxdP5s0ySdqEeoHXywlzmPij1PwNlmHKAMd1y5Q3OOkQwMSDLRzEBx+OjqwTxUf0sjJha1UsBnVRHSeqo0VcBlNo3JUlrt5h+JtroaLN9X8HfHjSydfzisVAoEKjSdyXL8dXav7gPIf0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713427669; c=relaxed/simple;
	bh=vsZsZPLv7cagkokQfNA8NdO7vYfH4+IVZc4lUgyHIXA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXNEBAE+v8xsoB8hwD29YQm7k3euTVFQLZUU2fhBn2x6Q8SNXJuJ2y1BfQgapgctcdaapmSe/NIlETOXLUOf4sdEbO89RzL0WCt7UjqboHSH/vCu5GM5JANu+FdPFkZ6r4JIL4DpnI4Y2H0nb75GBFfXglD1E/hQ+kIDRHqxgwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=jhTo4VAF; arc=fail smtp.client-ip=40.107.8.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKphoKX1gFUs2ta+l+3d62SPkNTLE6sTUyPfhxs3S1gDo7xFJIeWNjrXCfdYdWHMhIUDA+/vXTv/6UzpQu6Nu6k0SmVkessu07/ZJPpm9cIhrHscqA6mfbBJgQQdX8wwSBTHKdeaecqlUDd8Y8Bk/NtYLrrI/OSQMlLhKuZBsP90Mi9ciOk/gyn1b1eXE+N17PFHtB76qjDmYNjFE7IB9IE7r8k0BHxy/XVnMD90Ky16B87e6IDqb163k/dsFWsdeezcSzoaWgoQIsF59hmgHutYfWWoYfFLkakesmOKbaLJCi/oO7JgnJcdWs/BU0RxTIX5L/2G6DAl6835hzAyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH1xass0LM4NDAEcAwX8TvA2ajUf2ocfyhW6AX7w8Cg=;
 b=mtmeOTzJVaJAYiJbQuIvTJrxo/osYwwt13NHMj1HT9c+jRFxdukLB1frXMmzObVv7ibP6WbZlMsqXB2dbqkZC9vz3GXkNeJAW6rhsnVqvUaqS8OcmIVmoeROmvt2maHOIQv2r/IEFeJ38BqJyrbUyKPHMKPul4VlUJ6oDReNCUtW5vbBJwqTYyddmE13aabvydP8zSNzfUbL9Mm2/f4C9/HYXWmgsIX1A50HwZVOeMiQe/XL32r3e9hGAERhTSEKwJew89QYH8QZVj8N3IpLgjQhUJ5kVgAGXieJKP902ZH3qMnbdlM1C7zUYJg7Yj1LkH3jcS4M7VeeengLwDpaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH1xass0LM4NDAEcAwX8TvA2ajUf2ocfyhW6AX7w8Cg=;
 b=jhTo4VAF/Arg5Xfr/f1Oom302tFTsGIaPT5rtt5Z3jqxpuObMzH/w+q4oJkuEViqb3BU24wM+YV5lVB6yD7eQI+16llFCRdRcDKxvBLrmQthZqh06XuQracN7t3XmL9ulAxO3M5htTOERe44INudnSaQbZARGwIF8BQP5K6UhGtA1HU1uwrzB6cEKECa9Zqw4gXFMiw9wFzGvlTFUlSZ3E7PxuZ9Lme6R/gMsuCLW92ECVgCSODQ4nbPB6Jer7N2k9RKDarIVbsrAlIRmANMH2B1gned0HArMCOFNQ+YmORXu+9lC3/aD3+QaCi6c3nKc+/zhFvM5gCS5NEFVexxrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AS8PR04MB7717.eurprd04.prod.outlook.com (2603:10a6:20b:292::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 08:07:39 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 08:07:39 +0000
Message-ID: <cb2004e3-563e-4d36-ab69-89b1d9f6221b@theobroma-systems.com>
Date: Thu, 18 Apr 2024 10:07:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20240417141642.2243193-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240417141642.2243193-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AS8PR04MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: ee426eb5-06e4-416b-c822-08dc5f7e9d82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xeDejG7IpHQb6XDKJRW3YbRYr/bnk+N35lW15IgZt3eGA02hy+D8DwOREBWd4K7piQslgK2x+PNXRdMGbdBzrEOq5bovTfTaqeB2WGA9jJnE83fa9IKjfAkNlSHHi+UozFdZu5lRSGA9Qm1+rqkYT/egnoeQKmZAJAAYnTLMU9KOxtaUSjgJ4iIaPOopD+OjJ4T7ZmPTb1ztYJcB8hcpR/mFC97ynanIc3pWycBl1IH3R1q/MesOJ7RSx8OQ7V6fLTKMypBiEFanKZ2G0ew5BPcXfWrPzpcOBLSskDNRv9ZMEbHBmHwzjw+EelGJRqSCX9nZOwwi6lggVI7GcI9oSuip6xAgtdZscvVtMOJ/knDPrFiaWLa1S/muDMRiTK0zxTHs5ux5YmSFNxycX17w6Fxgto5V/clptMoOEQRevQdxQaTHYRb7k8kd/48r8bnVXboNJm6DAbnB4tUuDZxZvAJRYqSupEMRC/u26Lz853/S7eXwKd6CcZSHTzcEgoFeEyeZkkDipwFVf3n0jcb/QGaigh7FEOJb7G3C0+rQV9bSiDqFO+Q0iTq9rg2DAjZLw8+TxAY2cG+muJnVBGwfB0pMXB+rXdwPrcNv+WhfadcyHkNvIqnjTo1yGYdjQ8/Y23QVgf7Kl5REKTsKaiYmozGixnrfHd96cphz2dIV7NY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZGNGhGckNSNml3MGRpZE8vaEdvY01rWTRWVGxpd0VCbzE0RldTem5uWGd3?=
 =?utf-8?B?bFUyaFZQKzFpLy9nTmFiUXg0Vkd0dXFCQm95UmZJQVlzektzd0NOaGpFUDVt?=
 =?utf-8?B?ckZOakpRQmRKSjI3WEhzNzJoY1EyQVY2bUVBdTRpeWxaODFvd0lJeWNpN0U2?=
 =?utf-8?B?L3FGZWtwU1FSMExiSUVqdjZHcjYrRUlhSG90eWM2VGFEcldLSzFkWUc2WTRr?=
 =?utf-8?B?b3ZmNDVHR3hBSUNOU2NRWElHVmxjSzhveHlqR2FabDFLd1R2Z3k3VCtEdGtB?=
 =?utf-8?B?UGZ2R0JHclB2M2ZsQW55NzlYSGNZZzRRdmQ2UUs5cEFZY0xyaGU2N2RYblYw?=
 =?utf-8?B?b2UyYitaWmpUeDc2QjBOcDE0cXAySUpKR0JxZHlMY2twZmZqeGxpc2pKdTd1?=
 =?utf-8?B?cmh3SnRGcTBjZlpxVXBySTlUQjZWUWg3ajdJRU03QStBMmUwR1hVWFk5VGdU?=
 =?utf-8?B?NlZuVHpNaGcvTklrdkhVdHVJKzNlQ3ZJZEdQK0xjVHNVeXRoaDNLOWxNOXJP?=
 =?utf-8?B?dkNLWDJQdkdQNll2UnRRWExoRFEyRDExRnZMTDVMbGdSWGlRYkJUMFBzd3Mr?=
 =?utf-8?B?T3VlWEk2a2lDZld0WlE1eTc0R0Y5Znc1dDQ5OERoMkxsSTBKRlBrMG5yVm8x?=
 =?utf-8?B?QkJFWS9ZSFYyQXNpSERHWGtOeXp5ODdDbkNiMnA1Rnh6SzdaSVFCZnJtL2xa?=
 =?utf-8?B?cG1pNlc4Mk50VFRjUURQTXhYMDdHejVzNkxnczFYeDVtM1BQdW8rZXBQZHd0?=
 =?utf-8?B?REZhNXZzTFFONFFJazA0eGt3bHhBc0tuSXJHR2tXeWFNcjhtU0d0dWVSalc3?=
 =?utf-8?B?MzJBNmNzdkswNjU1RmgxcWJjNENPWVlIS1U5cmpTQy9WZnFwUlQza2tXRXRx?=
 =?utf-8?B?R2Nhcit1QTVCUElPUm1PZUdMUXlvWVg0YUF5eFBqSW1DU1FKVG5qN2h2cGhW?=
 =?utf-8?B?WkJJbm84Y0VPWTJCUU1PSHB4cnR2c2V5Vm5taUppV3BvUnd0Q3F1R2Frck81?=
 =?utf-8?B?SnJaRTZndnVOdkNNOGxmNUR1MmNHaFhKanJRS0RRWUI5SE13ZjFFN0RIZnNn?=
 =?utf-8?B?UWtjVkRpa3F5Smx3ZmdUQjdtMFZqdTV4VWVJclhsOEQ3bDZWZytiMnVYbEdu?=
 =?utf-8?B?bzROb1FYN3NSblpDcDhsNHd1dzNXRlBRMk9Sai9KUHA3TTAxaWNsdCsybTZZ?=
 =?utf-8?B?S0hKL0k3d1UvN0J6Y2FiWTVpMHdleWJ6YlFkTjNUSHFCcXplNVBLYzFRaXJB?=
 =?utf-8?B?eEZINlpqRWhTRzN3SlQrVVhOb2VKWVZ1dWRuUkNtV2dWaDBPME53eitRNUs3?=
 =?utf-8?B?K040UXFDcENybUsxV29lOEM3OXQ0eWluUmgzeSsvQ05rOEJweWtHd3phL2NI?=
 =?utf-8?B?UmgzaFJQQTdMWmRLUEhCUmJzKzJsaGppVUtZZDFuVXA4S3c3N2dlMUpSWGVk?=
 =?utf-8?B?SVdZY3JSYnR3TkVBM25GTDVjQzVKRE5qV2Vjc09vblBHK0Z0b0htU0FNM3Zz?=
 =?utf-8?B?OUJWUUpRenl0a1o1b3dIZnJFNVBmc2FydWh4a0xpb29RY0NzWDFDVVhVcGVJ?=
 =?utf-8?B?NjNFb0dNcjUrcXNxL3VGT1BXMDdoZGUram45K2JoNU44azlTNWF5czlwTkth?=
 =?utf-8?B?bGZpTGNMVVpIV3dmSTF6Y1dhVG5sTEVnUCt4bFNqSG5VT25UU1dDeXEvLzli?=
 =?utf-8?B?OWxCQ3phaUpaVGpUWllvQXQ1Tjk2Z2dKeUxML0FBaGVCWXB2c3FCTHozM25s?=
 =?utf-8?B?SVl1SlFnR3V1YnpySlJOMWpTd3poN3NwaUVhTC9uL1BwdnZ5NEF1cjZJNDg4?=
 =?utf-8?B?eWlEdUtKVEh2QWw2dWhBU3BteEJxNG9ZMHRTeVN5MGJiamFiZCtlSWl6clV2?=
 =?utf-8?B?ZDgrd2trZHlhR2dTS21IWnZRaSt1MFpRSXhHMWlVSUlMaFYxUWNweFdMbURx?=
 =?utf-8?B?QUFjeXQvMHZFeHRWUnhORUd6RVFBZXpKVHR3b2xTTzJsekJyQlVIa1pUZHc2?=
 =?utf-8?B?MG9UTVJvajVKcDg4NTRhVHI4SkpyR1pGdVprUGRCRThzVVNtMkhTaGJSZENW?=
 =?utf-8?B?ZDdzNTVERjkwVExHd0FTS0xqNUtIcmhnZGFmUDcrTGtnK2RwbjdPMDlFVTYw?=
 =?utf-8?B?UlRDNmMzcisyMVlsL0wrSDlDejBHL1ZuQldqb28zTy8weTNZVTlQMVBmQmVT?=
 =?utf-8?Q?uOPnu4yFjYR3XKZvScxFIaU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee426eb5-06e4-416b-c822-08dc5f7e9d82
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:07:39.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeqP+DWTE+dchAwxVjLpeU23jZVNCqdfDMTk+V3wf9fQCdsgRoPLIqyM7uFPYsRcXnv3F+cl75Z1rzxNmCF8sPjCpJgetcwSg4K4jJKZBxdgyvhXPhwDW/Ic8L2OKXuA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7717

Hi Heiko,

On 4/17/24 16:16, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The Jaguar SBC provides a M.2 slot connected to the pcie3 controller.
> In contrast to a number of other boards the pcie-refclk is gpio-controlled,
> so the necessary clock is added to the list of pcie3 clocks.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 53 +++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> index 5002105dc78e..908fbabd8b00 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
> @@ -72,6 +72,25 @@ led-1 {
>   		};
>   	};
>   
> +	/*
> +	 * 100MHz reference clock for PCIe peripherals from PI6C557-05BLE
> +	 * clock generator.
> +	 * The clock output is gated via the OE pin on the clock generator.
> +	 * This is modeled as a fixed-clock plus a gpio-gate-clock.
> +	 */
> +	pcie_refclk_gen: pcie-refclk-gen-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <1000000000>;
> +	};
> +
> +	pcie_refclk: pcie-refclk-clock {
> +		compatible = "gpio-gate-clock";
> +		clocks = <&pcie_refclk_gen>;
> +		#clock-cells = <0>;
> +		enable-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>; /* PCIE30X4_CLKREQN_M0 */

I think we usually want to have the pinctrl for GPIOs as well to not 
assume the pins are muxed in that function by default or by the bootloader?

> +	};
> +
>   	pps {
>   		compatible = "pps-gpio";
>   		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
> @@ -466,6 +485,40 @@ &pcie2x1l0 {
>   	status = "okay";
>   };
>   
> +&pcie30phy {
> +	status = "okay";
> +};
> +
> +&pcie30x4m0_pins {

I'm wondering if it really makes sense to reuse this node if we're 
planning to change the only property it has to mean something different?

> +	/*
> +	 * pcie30x4_clkreqn_m0 is used by the refclk generator
> +	 * pcie30x4_perstn_m0 is used as via the reset-gpio
> +	 */
> +	rockchip,pins =
> +		/* pcie30x4_waken_m0 */
> +		<0 RK_PC7 12 &pcfg_pull_none>;
> +};
> +
> +&pcie3x4 {
> +	/*
> +	 * The board has a gpio-controlled "pcie_refclk" generator,
> +	 * so add it to the list of clocks.
> +	 */
> +	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> +		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> +		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
> +		 <&pcie_refclk>;
> +	clock-names = "aclk_mst", "aclk_slv",
> +		      "aclk_dbi", "pclk",
> +		      "aux", "pipe",
> +		      "ref";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie30x4m0_pins>;
> +	reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_HIGH>; /* PCIE30X4_PERSTN_M0 */

Ditto, I assume we want to have a pinmux for that GPIO as well?

Cheers,
Quentin

