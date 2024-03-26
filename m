Return-Path: <linux-kernel+bounces-118372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1999E88B9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C993D2C8252
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E217128374;
	Tue, 26 Mar 2024 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+9Y8DrI"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375B5D905;
	Tue, 26 Mar 2024 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711430490; cv=fail; b=o21je68z9BddVPTbD9bWzMtMqB/mRnTFik6aJ1e1eziAlyyIezV9p2L5hiGYY/eANgd3ywNldyP7tfV8QJ2B1WvktWw3YjeS1+pFEk5e/oLgWl3OPO5nzmubmgEnHDKkbtWKnZLMTiVZT/17c3R4jaKC2IkBlHON9ilxxL1nFQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711430490; c=relaxed/simple;
	bh=IlCU9pVgMQhWOnvMJ2ue5OH1S74hYi/PS1tY3nSjHqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QFR8ZTcdKmyJJd5vG6kElURw07As8d/Rm1dzErOd0o/uh7yeT/rg9UWTwS9fwGNE+qZhiKPyFlNMbnvVpeNBJXmej85WBEbLYNwUgpC3t8iVsA0qGbFkr46CW1Y45mOMBnsvfg80v+FKAPLLTDp/lCkD1maDFSa1tv1gjvjuviQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+9Y8DrI; arc=fail smtp.client-ip=40.107.223.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9iWIM4PCAaIs2pJHIwApFkUjJ38uOGfHIjfN2YJDXZ1LQNzKsncgep/C1o3zYXteAjOAjxueIPA1eBV1HIOFZsZW6a+f3q8gLA5QePdp6DNpIFL02P25ew/uzX4M1r+P04iN1O67DayZ6FPgHpIvr/4ERgjASptNiS7XPjHq8gu30NM/P3lz6I2d22JMU3os4BqOaZM+8/TobCUffcMjubtEiibeJlpEfST3LHMe+vOAjfqtkXDGRj2RkBdqC38gLjXAyICVE9VHuDHYsBa+7pM5wWF8KwWiqmqpZx99XlM5cFDuIxlKD07tuUptvT47/nnEbWePi95HTery5yi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3LSQPPSzmMl2IQY68Wct1pnShN74R4KseSunRKXby8=;
 b=OsN0jWQXORd7CaNgOg2EdGiZ3Z/rWRge5gebMx7hfafQX8XHr3rMovqRKFf2qOLlcjUO9KIvXpXgK9bpYXSxxfCA5NFBMkZ6WaE35L4PKRWtVZOgT8PyHf7c9YjG/hdF13mF14Sk8Af0N+3/qjZNYZTsCxWx+YXu0qvz86feiFzFA8BfcveCfKBX52jFN/OUsxFPdlDC18+gul2j0I7xgTQDbpuGZSQsymg/Ur9K3/l5CbBQ+ILVmRnhSYX+DIKO3RD8EnMO3XzuqJf4FKEW8S0IIndemn7lcpYqBh4D4q3JYCmV1WOWffJJBU1MFGcOmO1UJ4sjEX9Fta70RkkepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3LSQPPSzmMl2IQY68Wct1pnShN74R4KseSunRKXby8=;
 b=o+9Y8DrIHGAW92JQ/sbHevZNMGiyim4Ae1Qyak6TuJou2N+yEhRdgQP/Lvp/JO5zobzAV4YTqC4oGEBtGgOTCZxlUMGoiGnAM3A92H8QFkhw2Z7Uih/KjZSX1jwO5EBu/rcDMRknU/VOzIGwA87jb7RJU4goGjfrj9fcIpdOpsyxHANmvHVt8bJygd/s12DHM/HSuMiFZb8cZMZwQsgz+O9PJxE0eQsXrcR3K7UEO0VGvcRtuQlM5p1hZw9caorgj5LXoBy/RuI+0v4JYam6PJrM2PAcKAOQhBkwLOMqbPEzkAM/bR3OviY9B9Ogbi7HI5XUPqVxbj1BzzYAwLamrg==
Received: from CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 05:21:23 +0000
Received: from CY8PR12MB7706.namprd12.prod.outlook.com
 ([fe80::f67:eb09:fbce:b5bc]) by CY8PR12MB7706.namprd12.prod.outlook.com
 ([fe80::f67:eb09:fbce:b5bc%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 05:21:22 +0000
Message-ID: <c778674c-577c-4099-ad44-440c82eb0634@nvidia.com>
Date: Tue, 26 Mar 2024 10:51:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: tegra: Fix DSPK 16-bit playback
To: Thierry Reding <thierry.reding@gmail.com>, broonie@kernel.org,
 linux-sound@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, jonathanh@nvidia.com, mkumard@nvidia.com,
 stable@vger.kernel.org
References: <20240325104928.2796868-1-spujar@nvidia.com>
 <D02VH5KH4A9R.6IOJPPMBF0K5@gmail.com>
Content-Language: en-US
From: Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <D02VH5KH4A9R.6IOJPPMBF0K5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::13) To CY8PR12MB7706.namprd12.prod.outlook.com
 (2603:10b6:930:85::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7706:EE_|DS7PR12MB8273:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8AmGlVLD1MLEIHkwPJVwrmOXuO65PNc/9TG9gRiHV2G+R1tZfv5GosKyeNGtuDFS6G1wuDIox8Q90H96IYFbXCsjJtIPLWI6xy4ozJwuc7JPZoJG1RrpY/rf+D6bNgjHE72HyRxMoDkg6f3fw0c+SQxIMpZsfXnDp8NIkMIv2zGXDtl9CJrwAYk+DwLv0w/bl/jX4JhBNUkzo3W59EU31tghqgBUu3SbhaorNx6WF+YvI0hZLN7vLR1uNx/P/TirfFeKMCB/Sq+tsgdC/FxmT6Wg1hAZ/O8VJgrqBanvwFv/0uepOkpsF8ZZ/O3F+fpgiK4mWvpTJYtpmuUO9OeAZ0BmddCGNVKDxwOr7y0DhjOCeEtyWxYxQeuMJqQYyViHzrIe9avnpIkvssxEIsR9VPS1VKs9x+miPbDL1BgicM1e7B/uFHjj/l8nbSHzi6WsIb06Rm2tTLSOf+834C30G2dKjY/uXeKd+sp46Lyhe7KAAepZVk49H6kwt1C7K/lG8+mX5+x5ZI4KsNlbyCNWEs1iUt+b1IE7JkZg93in82Hler0aQOVA/z0IxoL9i5v/jmuD04wxLup23Ug8ETZUWidPIG1ri0S1igf4Ga1XJr7WDXprFOAcGZ4pPvb2c20gIlsxzq75o05/OO+RWY5W9eOYtd9420w8mEfOtJM7rtA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7706.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmliRXVTVm80MURTL1B0MHkvYUtCSno1aTFWT3Uwcnp6NGFTRzFaYVozWHI4?=
 =?utf-8?B?RmV4ckRhclk5aUFRZ1dkUTMybG50V2ZSaFNsRTlScUt6TlZpVmxFclVHeXJr?=
 =?utf-8?B?bm50dFRIWHFvRmQ5K0VBbDYrT28wczBBR1pha1RCM0dVQU9VYjVmS3RMRVIr?=
 =?utf-8?B?YkQ3ZWhublFjNWlkMzJSeDNhVGMyNXJoV2lNS2taRnNRbXVOQzJkVXZZNy9v?=
 =?utf-8?B?RVZPc2hHWW5KZ3BGcWR5ODdRdmVha0syc2JVd3ZyTUNJanNlWDQvcjRHLzM3?=
 =?utf-8?B?N1lucEFObkxqSVJDZmF1S0FoNnBzUW5UZS96MGhpSHN4QjFmejRQVGpSMDRj?=
 =?utf-8?B?R1B2VTVQT3h2alhlcUdrZ1c3M1REMTc2TkZvTWVYVHlidXpyVHZzVXdFcmFT?=
 =?utf-8?B?TDU5V0EyWkEvdks0MWRkc1RkT2U1bWpleGJhcEUxbVF0MWRLbURKUG5zcW9m?=
 =?utf-8?B?NGtLems5OVNtQ1E3OXpscjBVTHBQL3JvRVJMcjlJYStnYWY5WnVzMWU1bzRY?=
 =?utf-8?B?VmdLOXFINDA2SitVS2hVcEFXaThFVjZRbFZqbXRTS3VnQmw5VWViTkhrMkNi?=
 =?utf-8?B?dm1Xd0FERGNISFlSNExhODZVTjF6cGgzdVVUMGxJc0hXc0kvVFNxdEtmemJV?=
 =?utf-8?B?YVpEYlc1S3RkQlNyTnUrME43SkRWeDNDaHFreXYvdVFMN0x3c2U5K2diT0Rh?=
 =?utf-8?B?RlZ2S29ISjQrbkFMRFcwWG83YXVyMHdpaHNEM2pGajNPWW1jN045V3RQQ3Yy?=
 =?utf-8?B?MnJWbnNUYWorRkwrRFFldlgyd0hwRGRNcmREaUowKzVWVHJhS1hVMFY4czNN?=
 =?utf-8?B?ajV4RXpqMGZLRTRlWUJIeEwyMThJSkttcG1UVEVkWSt5d1dNNFQrZWp0ZU10?=
 =?utf-8?B?VFF5VU95bldyU1J5RUpxVGNaVjRBdkEwUnh6Y1k5b1ZYY01WczY1REs2MmRI?=
 =?utf-8?B?Rmw5NnlWU3FOQnAveGJnUk11aGk4dkp0S1VIVkhEcGNvTjVWcHh3V3RPY2xG?=
 =?utf-8?B?MHQxRFZrUnBVUlNBRUhyd200MTVzQ2xhUjRYQ2lMazVPZmR1c1dRV200OXM0?=
 =?utf-8?B?bFQ5S0E1Y1o2WmhPWUR6WlJFWHlnaHFXTlJNbmZEQVZUaDRQbHphNlJlemsr?=
 =?utf-8?B?dWQzTWRpZGVSbWhmV1VKY014VVZnQkNXR3dDNTJFVmNwOE4rYlAyVVczcU9m?=
 =?utf-8?B?V3BRSzZQVDB1elN4MUx6RTV2bElMRm83aWk1SVA4ZW1OSjFiZ05KSUFkYk9u?=
 =?utf-8?B?bENzdE12ZGxtRWN3a2J6UWxlcmZlNDNhTlBQM1MwSUhmeWhQSkU4anZzbkVH?=
 =?utf-8?B?MVlpQ3VJdi9wY2dIN0ZJdFlyMUs0MUx3ckRmSTVmb1hic0RoMmtjTkZGWXlD?=
 =?utf-8?B?TmJZdFI5bWcxUzk0UHFqY3Z0QkJaTTlCTVZ5V1BCUlMyYkc4My9MbGVvWUV1?=
 =?utf-8?B?Z3VYOVZidTZWQmlJZWZLckFyZFdVcmRDczBIb2tQaEJWRjI0bEIzVmJwWUZs?=
 =?utf-8?B?MlZOV2JjN1Bwd1dSK1JZQys0OVRqdkxralEybTAvemJTaHFMNkxveHE5ZzRE?=
 =?utf-8?B?UHBWa2U2cktCRjlsV1dTa01qNUJVek1MWFp1czhsZDZzeGlOMmJJbjd5V0Jw?=
 =?utf-8?B?LzQ1S3hkMGJJR1dIL3Y2N2lnWSt5VTVRYU1yR05lcFUvNm1rb1FFeDArUE5U?=
 =?utf-8?B?clZGdVdFcFVDZUFMaDQ0UHE4Ykc5RmcwTXh6RlpoYzh2WU9GaFFtbWFQV1B4?=
 =?utf-8?B?aFhTUnlwUXJSSEdxb1R6dTRKMU5nSCt1c0RZbXFPVmNreUJJY3c5R3RCS3U5?=
 =?utf-8?B?S084dEx0ZSszcU9nK2VaSUp5NW5odlYyWGxUL0gzWDdQL3QzbmxxZk5SbFU3?=
 =?utf-8?B?d045NzVPOGp3d3NBR0VQckJyQjI2RGdTZFpJWmNaaGdyVTNnUXgrMm45M2Nz?=
 =?utf-8?B?bXdUdlR0ckdsT0xtTHFnVzNVcCs3WGRraXFTME5kYTJGMGNhbmw1MklmSHJs?=
 =?utf-8?B?cFE5ZGQzU2NzczFRK00rRWVEak5JT29rMWdLSFBjYytIM2wrVHNmKzZvUnJj?=
 =?utf-8?B?eWFoYnc3MlMvaFlKREZYZHlTNTdqQ2JiMVNIYXY1TFNLT2JDUDRQQXluamJB?=
 =?utf-8?Q?FTEzta103ZtOQRNtDSPM54ULv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978758cb-53d1-4b00-08e1-08dc4d549365
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7706.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 05:21:22.8644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEnynwk1kCCIhotBSGpZauWPeMLnarHDA5B1JqhsIcypqHQ0vZxSoUQeeINxwrsGc8ODND4hxe+Htwku6O044A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273



On 25-03-2024 19:11, Thierry Reding wrote:
> On Mon Mar 25, 2024 at 11:49 AM CET, Sameer Pujar wrote:
>> DSPK configuration is wrong for 16-bit playback and this happens because
>> the client config is always fixed at 24-bit in hw_params(). Fix this by
>> updating the client config to 16-bit for the respective playback.
>>
>> Fixes: 327ef6470266 ("ASoC: tegra: Add Tegra186 based DSPK driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   sound/soc/tegra/tegra186_dspk.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/tegra/tegra186_dspk.c b/sound/soc/tegra/tegra186_dspk.c
>> index aa37c4ab0adb..3a152e76122b 100644
>> --- a/sound/soc/tegra/tegra186_dspk.c
>> +++ b/sound/soc/tegra/tegra186_dspk.c
>> @@ -1,8 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>> +// SPDX-FileCopyrightText: Copyright (c) 2020-2024 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>>   //
>>   // tegra186_dspk.c - Tegra186 DSPK driver
>> -//
>> -// Copyright (c) 2020 NVIDIA CORPORATION. All rights reserved.
>>   
>>   #include <linux/clk.h>
>>   #include <linux/device.h>
>> @@ -246,6 +245,7 @@ static int tegra186_dspk_hw_params(struct snd_pcm_substream *substream,
>>   	switch (params_format(params)) {
>>   	case SNDRV_PCM_FORMAT_S16_LE:
>>   		cif_conf.audio_bits = TEGRA_ACIF_BITS_16;
>> +		cif_conf.client_bits = TEGRA_ACIF_BITS_16;
> Do we perhaps want to move the common cif_conf.client_bits assignment
> into the S32_LE case now? It doesn't make much sense to have a common
> assignment that's overridden for the S16_LE case and only kept for the
> only other alternative (S32_LE).

Yes, it makes sense to do so. Will send v2. Thanks.

