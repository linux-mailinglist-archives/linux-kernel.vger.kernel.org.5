Return-Path: <linux-kernel+bounces-66478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF6855D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD43B32F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C801C29C;
	Thu, 15 Feb 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uRr3EtWT"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2029.outbound.protection.outlook.com [40.92.103.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB41C287;
	Thu, 15 Feb 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987561; cv=fail; b=duM+YhcSWsfJcX9m1jhybH2YA0FSoo5cXRcZ82ME6FXsRYQ4w6g5iWy2uk1EVmgij5eRoFy8M0ivBIW/OlSlMU0vLkKZAxFRcDgg4VhSnpBOwKsIo3DT8SAuNg2VrR1qhFwheWHuYz0fhU/qbNPb490PHHgwIysUf9dRrsTs3tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987561; c=relaxed/simple;
	bh=njE2pIfqe4ZkpSJz9U4+TlWj8cCm9cz5lQWc2uiSdXQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=epj2rRe9RfYCNgZl69KY9dKY5bdkkY3DO7T/eVYlCOcL9UKiqaC4We2Gs2OPA4LIwDk8Jaahz2vqfnRxT0gAUhPPXCdwQsFKXBKAMOjeZMLPMKaYpyRFUYDiWST3iIQEIq7R5HszAnmC4zTm+JsurrjrRfnF1k3tHMftklczAcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uRr3EtWT; arc=fail smtp.client-ip=40.92.103.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl8b6ZdRW/5NaaHO45GgD38jaRcmDCh8+L2mQyFV0B7/0K2oHgM+JmaOGzCFWMCAx2UXbs5yh/wJi8PwrtZDxIpPPqrfoCqPLTnvpPYCtRVpdIkAIpV9Q1m/Z7CMXdYbpECIyWcvU5rdiPgSmRv9PNZLgi4P3Xg0w/ZVdUSenqidp2eP6sFntA+yjp2sncWmsPt5VEJLkC9uurXin8wzqIKlAD8MEKHUq6PdyZGTwRn1lPhtDZYFUZUMG7LwT1CehK9AZwvNafVn4Bq9yY51aLFShUsB2tJpeCrlDq9FJqEUJow44dWNXwI7SriNX4oJMbIFSEhSU1PHmPhS7+oGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvw0StO6sF3Mb2RacrswPFgqc6BX3Cu+vPdrOS/mZTU=;
 b=I4GlS2sRM9sZLkge0xLeoHYfVahbwcX2VjiQy27mWrXWAxhv2BRMGwlK0WpeuxR53uJQV2+jInVIjcr1kIuUtqwJM+0qpeD2bJwQgwgrg3ww4aIc8Si/KTWmXtzVtJvB9gPfJq6xCVV90gKoJiSou1NWAgXxQOhnRgd0MjQ/E0AH4BJkGZ+eCIurMqwv8SN8JZ3t4O5XXJLc6jzxVlQCniL0m6jyK25xnfIp122VZTA9XI83YzS0PJBj3k5CHQKPfA+UgfPXpQqspmgmLcJb9zMY7CRRYc8YgaQ2X4fiCRt44vhonq8Cy2MG7C0yuv+ADQTuT4pp3DZimj5zOjT0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvw0StO6sF3Mb2RacrswPFgqc6BX3Cu+vPdrOS/mZTU=;
 b=uRr3EtWTwQ4R3DGmpFFtHTdaadl5wXGBiAM37Dq+u8bXSpYG3RXjHoXTrTuV9w4Pq/B/RQcqmxJ2b2Mq5YAObfJkdJrKWZbhnKOdKTCPkEeZ7BfKl5eeSD3+fDgGHZHArdaqQkV2p4DcqvpoLxvX/VGT1MmxmB4Na/nN5FwHd2cL/oiI9skj4dPZvxX1ht39ZCwNAYbbdU1SsE1+VAUUepnLF82hW1iFma+uISV5ofhNbkV8AHQ5RaIt7znOEp1I3gzr2eiHC7wTOcKV4fwOkpdVnblg56tETezn21p+g3LjOaZW5uJSuoKavCl051go6JzOKU2JqEWDswxw/2YsUA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB1645.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 08:59:12 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69%7]) with mapi id 15.20.7292.017; Thu, 15 Feb 2024
 08:59:12 +0000
Message-ID:
 <MA0P287MB2822E03B61DF33B4438833D9FE4D2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 15 Feb 2024 16:59:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] reset: simple: add support for Sophgo SG2042
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, p.zabel@pengutronix.de,
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com
References: <cover.1706577450.git.unicorn_wang@outlook.com>
 <1cfd7b3ba447942784c4f7aa595e962399e9f617.1706577450.git.unicorn_wang@outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <1cfd7b3ba447942784c4f7aa595e962399e9f617.1706577450.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [pkaefth7PK0ow5jywzr+6ygs02ZBz9xw]
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <4e6987ee-4772-4219-a02e-e818980b0685@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB1645:EE_
X-MS-Office365-Filtering-Correlation-Id: f48ff6ac-8d65-4380-933e-08dc2e0460bb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DPTHHHsjJgDEv3uZ2C/M4WQaD7eRzoqhg74jmyXNkS4SMvfPUByufXO3A5askxZU6IlabNQQZamN0ZSBudIll8bJN3OelCa97IkWOTRS8/VH0O/6U96ajYwloMzkzklQidF0iwkSstF5LuMZHzslsymdrjgdGULF7lLZNAqnAHLFWt8/SVjihUc7vrGCZmS6fcUQct8Yg2r7k8CcRVGJm1VlaJ9HhpyNlbgQnoLOPMHVzukiCZ6S4no4wh3T6W6bz3COB3mo16F/r6VhT+yoth5AF/0EdvXtsF+ze5LK0X697DoqtbIvKqcxTFw/LHSkHnYyeCAXOsXffPkQiwENjuOtAi3uoehxOTSJTmHwAOEqtAT/D7s3hoP0YKcynezTxbv6yC2dTN96uMhUu3L/2JMm8ZcHtt9DcA9oOLDfpSpZhfyBPo9Jqv2Ys3vo8nXpconITu2fC7B3Yiy1fYpDb/b9aeN+DWJmD0U4usV9SkB+E1V73biVKrM5C7xds0n4rfXU3b9M/kqWESk5b5e+kAxjo2upCfQdrHPVkQG3QfCg7xhQcQL/qfBd+rFIBwc+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVYrNGswNVd1Y0ZaVWRtVW82WVZxVDM1N1UySHQycmRRaThUTFdEMTNYV2Zh?=
 =?utf-8?B?TmthZEYwQUVZRlZ5R3h3QUlvcWdXalRYK3hFVzNPdSsvTVY0R0pNcWZwYVVs?=
 =?utf-8?B?azNNdDQrckpzU2swWlpZM0VxTFdXYmVlZFlINy9sdnlFamlSVzI0NmhIR0da?=
 =?utf-8?B?MzVsbFp6NDBiNHhtdnZHbWQzTHgwY0hMQm9TNm9MNkhEb044TjZRcVZ5bmdp?=
 =?utf-8?B?Z0lLYTRIS2dBbmpmUHRiWmo5bGplaXYzWGxyUzlSNU1TVzdIY2F2NnZDTkpw?=
 =?utf-8?B?aHRUWlpFR1lCYThlUnBaa00vaW1JUmpFL3VVbEF4eXJWeDBuRjdoeWhDd1ZS?=
 =?utf-8?B?NmcyYmkrQkR2eVlzODdrazVYWVpDSGYwTHFqOGNYT2hXdjFML2d0N2NVcjc1?=
 =?utf-8?B?RUhudkhKMER4bVd6V1NSNVgvWDdRMmVZeHRZaHJUbTU4bHNqcDd0citlU2Uz?=
 =?utf-8?B?cXV6c1lNc2RIR0h6Ym1CMEJESWZzT3ljOWM3TFo1c0tqMHd1eE1zK0JrK3FV?=
 =?utf-8?B?Vm9Od0YyMVFNbXl0Nlh0SldwQ2FMb0FqU3d2b1Iwa2NqUjV2djNlNjVsRGNi?=
 =?utf-8?B?UmlpTm5EVWxnL0dTalR1a3VDWGVwMnRkNktvSnlRbEhzdkptNnJMNW94Z25V?=
 =?utf-8?B?OFRIWkZLTDFvK3JWYnh1eEh0V01UUTRSQlZLV0h3ZXdLOUlkWHJnbk1scVlI?=
 =?utf-8?B?Y3lpS01KS2hrRVNaZk1KR1d2UlpOYjF3WjAzOHphdkVpRUVaOWZTL01IMTFI?=
 =?utf-8?B?aVEvcHk5VDdkUGtDRU1iQkN1ZDBVTE81Tmh4YXQ2anZ3M0FxV083aFliVjBJ?=
 =?utf-8?B?SDFJVGxhK0dJeHZJQ0dhZ3g1UitwLyttaUQzQjF1VHRKamxEY05HZEh6MU9G?=
 =?utf-8?B?OHpDYm9HWnFyVGMrUlpiMjhKa2ZLOXBUZEZvQ0JwRHQreXNxZWdrY0FjYVRD?=
 =?utf-8?B?RjJ6dzdDcUtERjl5YnM5Y3Y2Um9kVFdoTjZFaTVFT2ovTVRUd0Q2WlNqQzlZ?=
 =?utf-8?B?VHlIa3hiVFA3OVFLNTNvbzFXK0ppY256UnRJU1ZkM0pmOW5QM1Nnb0NMZWFu?=
 =?utf-8?B?b3dxTHhyWkw3L3d1MHZkRWJYYzNDTG52Um5WazJYaEE2OVcwVzgvbk1GTWJR?=
 =?utf-8?B?ZUhHaFNwNlZNeHFmWkE2V21DZWpqck5UY2xwZERVZE9UNmEzbGhsMUt1OWtm?=
 =?utf-8?B?R2NJUlE3ZzMwNEtOWnRBYURCVkZMMXVvVWRrSE5ic0RyMWR3VlorWVp3RzZX?=
 =?utf-8?B?TFpRdm5WS1E2SWJxTDNTa3hWdzltS01jS3hWcjBHR3B5Z2FuKzJHeHZjNXd1?=
 =?utf-8?B?cUd1VW94cjV3TUlWQWN2dGNXanpVVk90dW1udmRCK0VuVUlzV2xrSXRJTXlr?=
 =?utf-8?B?VklVNnR1N0FNRTh0ZVo4VG1UMzNMMmVhbmMzR2cwSWFROXFld3FxTGVxS2pa?=
 =?utf-8?B?OTZ1S1k3aUY4bE8yNTBNNUdxc2JkeXpKVFFDRzFRTjFsN1hhc3FmU1lHOFRJ?=
 =?utf-8?B?N2pTQis1TVlTQ1VWaEo2UWRLTG9MLzV0cFZNRmM1RjIwd21SU1ZTOElHcHQz?=
 =?utf-8?B?RURaVlViSEVHWS9qa2pJTEllcXJRU3dSVzg1ZzJSaHVBVFEzdzBMbGZIRmln?=
 =?utf-8?B?clVvWFRWZEx2Vm9LSHEvSDYvYW9Oa2ppZmNOTytYK0JOS3Z0VTFrYWpFKzVO?=
 =?utf-8?Q?JnI7MJz+YUxMhUb+vOxC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48ff6ac-8d65-4380-933e-08dc2e0460bb
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 08:59:11.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1645

ping ~~~

On 2024/1/30 9:50, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Reuse reset-simple driver for the Sophgo SG2042 reset generator.
>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   drivers/reset/Kconfig        | 3 ++-
>   drivers/reset/reset-simple.c | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index ccd59ddd7610..2034f69d5953 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -213,7 +213,7 @@ config RESET_SCMI
>   
>   config RESET_SIMPLE
>   	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
> -	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
> +	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_SOPHGO || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
>   	depends on HAS_IOMEM
>   	help
>   	  This enables a simple reset controller driver for reset lines that
> @@ -228,6 +228,7 @@ config RESET_SIMPLE
>   	   - RCC reset controller in STM32 MCUs
>   	   - Allwinner SoCs
>   	   - SiFive FU740 SoCs
> +	   - Sophgo SoCs
>   
>   config RESET_SOCFPGA
>   	bool "SoCFPGA Reset Driver" if COMPILE_TEST && (!ARM || !ARCH_INTEL_SOCFPGA)
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index 818cabcc9fb7..276067839830 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -151,6 +151,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
>   	{ .compatible = "snps,dw-high-reset" },
>   	{ .compatible = "snps,dw-low-reset",
>   		.data = &reset_simple_active_low },
> +	{ .compatible = "sophgo,sg2042-reset",
> +		.data = &reset_simple_active_low },
>   	{ /* sentinel */ },
>   };
>   

hello,  Philipp,

Can you please have a look of this, I have fixed the issue you raised in 
last version, any question please feel free let me know.

BTW, will you pick this for v6.9 if it is ok to you.

Thanks,

Chen


