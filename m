Return-Path: <linux-kernel+bounces-90950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EF870770
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC2DB24E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5554D9F9;
	Mon,  4 Mar 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SimkksoN"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4AC20323;
	Mon,  4 Mar 2024 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570778; cv=fail; b=qj/cWQhH2HHX+YYqaG8vwhOKMTwvdFzc7ImZjXBzIZTu7cOGzIwZtbzFF0lbStQZHkcUX1jnNJ4bHcrkihHavVySuDDp031GFyQev3BlPIB5eACIRaLylCLAP4txjs/pbsoiDKPF8H8AKvb811mQsBQB44Pqk4odokgAgpI45bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570778; c=relaxed/simple;
	bh=VmFxFAkDwirddRzt63pRfzbXgo2sGc7qDpaGPtytP9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcIpYFMdYAvyK3XzSqfKPkq/O/J3lvG3oDp3Fcuvj+UMRdMBslcw9Bk3MqiwSCgjRE1fFCDlXAwhi8gMMoWQdmZrcHynQ5c5iGnw0rlygEdc3W/A4WouS3fobU3O5X9d3zV0VUPoeMgRmwdMFuCwfnbDEe8IJKcuGOu3AMiQO3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SimkksoN; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR96neI04ELr2m6lukS5CMaGFvTZQSZAZd2BA/yLsDMyQ+mKgfssewB4Djy4PqZufAXLSm98OoQh4nKQ4BLl9Cxl0xSxXpYkOQpZhxoOfFkNbbLr+eDaMrLpYDWmGOUC31gqhUyH3ulOU6b9srGmNV20YaxH9mIT9O9uFxYRpyI6UY153NOFKTOH1sz9FqufmnzP2nU2eDsj2i9fUfvdqOmpThQovA/TLYhflMB5bffJbfJcK50KyW0Zc3Imwhum4ZmYWXiqeWqHcWgfeQ+lZGn+2d+jTn2u0Nl884TFM/J+MosG43dCg7Lr+XyNelMxtNJ/eLJ56JPmQvBoQpkm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYm3SgqIWPCZgfA6CdEk8duTE9If765PHlprpyO7+hs=;
 b=X68IlCRb+2bzTctKm2isAfyNhCk1gD0D5uvFmXsl7s35YN9toTseDcOHuEB6i2jYyf3o/8Uu2Bwk50ARk4cTdQGiA9ImRXLZiuBbYFmiz0qsKtLAu9ZFoj59+TqrC8Ekqq1JveBPlxNUiGT1/NcL6nDhTzWFRNP44Ry+IUxY4+nEiAka+WfSF1WsPHp3I+Td3B2PeI9qPwiBFR8nn+u25v1kdMh6vo4AOH6Z2/NoXOGyhvvHO9GMYv+NAZjGJ8K5lpzeUB3prohW8oiFzS/vMKFfA3XrbnljluYVCOrYoszeTn0775urMX4h03SkARo1V7lBS0WiZhc8c0h9ZfX5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYm3SgqIWPCZgfA6CdEk8duTE9If765PHlprpyO7+hs=;
 b=SimkksoNgYX4XWFr00eZJZ4psBxg/c3tzFVYNlQb8b1LqXs17NVQymHeVxrFVTnN9btFyZ6Ge3914wPzaxYeW8Wetvo31o2eA89Jrdeky2VjQkErSO+ppdfiD3S5AfNgqQZZGkxezh7oh0Wo9VWrNmV0fCPuk6n+99PLiwhlqbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Mon, 4 Mar
 2024 16:46:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dcf1:946c:3879:5765]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dcf1:946c:3879:5765%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 16:46:13 +0000
Message-ID: <a3c78f89-2170-429e-a6af-59398b8a85e5@amd.com>
Date: Mon, 4 Mar 2024 10:46:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: yc: Add HP Pavilion Aero Laptop
 13-be2xxx(8BD6) into DMI quirk table
Content-Language: en-US
To: Al Raj Hassain <alrajhassain@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jeremy Soller <jeremy@system76.com>,
 August Wikerfors <git@augustwikerfors.se>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240304103924.13673-1-alrajhassain@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240304103924.13673-1-alrajhassain@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:806:126::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: c525967f-726e-44af-29a1-08dc3c6a9a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UaziAYKS9EuZQW9S7gbpIPYEiGWGIgDNNUsEcFO4GssbNYSoUu0JZZRhamfKzcuuGkGoyypCum+kxPx4/TQ9DN1y45m6BCIiNR7TP9mp4WdL0oi+ScJDerURPn0UYa3SHASXaxfx3RhSrwwRg7Psf+BHzN/98xgMwOkIz/FXJNunwZdmIqndZXl46Sqn1h0OUZsxQqYLT6wVeyT0euMld7J+hJnEqUgD1vWMLI68xe67fnEWSNsNVSDiLTWYqhhi0n4F/eRFJenst07s38SfnuEdwDcgMh9vpkZCoHOqf4ZtI2r1Ig2ua1m3SHuX6vsJ/OL6DY6RqnvGHHhUZabp9euhtHufAUd2DMAd9r0VVsrWy+GDYK7Nd+xpg2+U1xBqrikaQ5E1nIShqTfSpQybrb67bqIMw4k4j8vwc311yVe6pXsvcvwIxTNXyP0aIdRP4g4MO+NY+rGMPOowWLeVxSAKDiANasv7RkylLoLmhbsqbMjMNY4JIqSL0jdCxdwbzecuRKUFey2WMCN4Qe5yQleBi+XLaC4WthUQ3kezJhOT74zKvoqwAbUni/v4xW7wi9QQblDEz3nTRND9JC5fzXU4rrdNf3jAEtOK7ylLftPcJn62UKdE/1H8pNDl083m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDJWRmprVGFibml4S2V2RFVJMUpDdXpRNVV6UFpWTnQrOFRsN3BjcXpGRHBJ?=
 =?utf-8?B?dXBzaTZYK2xkWTdQcFdyYy9CT0NYbnpkc0ppR29JZ3p0Qis0TEF6N2RhT3BU?=
 =?utf-8?B?MEVvbnRTcy8yOExVeC9UVXlkeS9xdHhVOTgxSC9BYWRENmZWNVRWZm81a0ND?=
 =?utf-8?B?ZTdsSkl6MHhMTFB2MDlaZDhqWnZlZnZuRStKSkNrL1JOaDA2bGpSblN3N2hs?=
 =?utf-8?B?QnpYQWIzdmdxdFhCbEZURmN4cjBKYmswQXRpNmFCdjg1TDNMbk9nSTB4eUQ2?=
 =?utf-8?B?VnAxU0FJQkJYbDZ5S0RkeXBKUlNwSWV3OHZDaFdpZzVEQ0tOKzM4S3dFR3ZR?=
 =?utf-8?B?L2d2MjFDbnZDeFhGckN2VFFEUHpkMW5VT0Raanc1VTVlV2JNekczRnRCWnc2?=
 =?utf-8?B?dU1VQndPaitaNWpTSWwyTjg2RDFvMm9HcVJDUWkzMkJvSFNxdCtvWGxjMDFi?=
 =?utf-8?B?S01rcTJwd2dtQnI5ZzAzcDBkaTRQUkg3R3hseXlacDZzUmpJenNTL1BLaU5T?=
 =?utf-8?B?YTdiRDVWalprUll4WkdRcEJXL0dLdGp5cGJCR2ZVOWxKZGVDeHF5TTNaNUVU?=
 =?utf-8?B?c2VzM2RUaE5SM3FaR0V5TzQvOXczRFdKb3JIdnJVRkF3L29JcGdxMHY2OG9J?=
 =?utf-8?B?RDBVcG9LRDZMaHRhaGY0RXZRY3doL0Jpb09XbGU3L2xjNSs1MGNuSGZkSHZ1?=
 =?utf-8?B?b1NpLzdiZkVHS01oZUlaWkpQWUdVQ2NGTkRWSGdKYkFhcDJwUmhxTFlJVzdi?=
 =?utf-8?B?UmFXcmNtZ21oYS9manBUTWQ4N0NFM1NqbGxkOWR1ZmNKWXhhNDBKeit1NXpi?=
 =?utf-8?B?L0xCQ0dHREY3OHpWVTk2UVFMeWxubmJGTklCelFCbG9TOTBEdXFtbkdLbGlF?=
 =?utf-8?B?MnJVcVFQUUhXdTYzd2lvMmdZdlgwOGhNcjNUcHJVMEVvU056ejJNdUthT2cv?=
 =?utf-8?B?ZEU1bXZlMjFZMWpnSWJ6NHZ0THdQeCs3VGhtYUtnVXZycUROb2lDMU9RU2Zs?=
 =?utf-8?B?cVUrSWF5UkJLYmxleTc3TEFYSFViNVIrQVUrTnMxS21KeFFrRkFUOC9PWGNM?=
 =?utf-8?B?TlhOd2FDbFdDSTVHeWszUzJxOWtKL0NmL0YvTlpUM2dDWWtGV0FNY0FJc3hC?=
 =?utf-8?B?Y1NlcXN3TzR4K1c0QlV0S0FGeWVNM0lmbnAzUnAveS80QzNJc2tmdEtKRnpv?=
 =?utf-8?B?eVVwalhCOWZOK3FONGI2NnU1Wmg3QlNHbDJ2T0Q5czFVdmJic3ZaVnM1L2pv?=
 =?utf-8?B?V0pYbTZOWm9SRGlsZ3ZSRTl3SExjRXA4V0NZblVQZGNBMGF4TGR1VGNRTEww?=
 =?utf-8?B?a0NjRmg1NGtPUUpCU2pVSU1qM0RNMmZWcG9RTFJlTkZCVENQcVVyeSsyaHUx?=
 =?utf-8?B?MU1QR1lZWDJyOVRmOUdkTW05dkRpZWY2aHQwR0xqanQ4dHY3YVhSTXpLSnV3?=
 =?utf-8?B?STg3VVA1bWFUcmViaWRMbkZFRXo5OHJzTjJpMkpNc3dmbHpWSXRjSjc4VUc3?=
 =?utf-8?B?NllJL25UQXEvbEpiS1p6alBZT1ZqNWFORmxuUU5nTkpOMmlJMGM2SmdWbXNQ?=
 =?utf-8?B?eHBlZHF0TVdFOTZUb0FBcW1pZ0JYdGh2Qi80SVNpOFl3bVMxQzFQQzV3WFVS?=
 =?utf-8?B?VEhvL3VGZ2p5M0NCYk9peDVpUU9OcTdXUFVPOUt2V2kyMjNnSis1RXBpK3VW?=
 =?utf-8?B?Q2VDbVRadUtjU2FJUHJTaDZLTlFZQ3VVQlFCS3NEa1UvdnFTM1lVaGMyMHZP?=
 =?utf-8?B?WDhxdkJBdHNyclpXanBzUTZZZ282RHFSNnN2YVAwSmdXQk42MzBYRmI3ZUVC?=
 =?utf-8?B?Mk13amFlQTB1azFqMTJGVU5FOGlIditYMjhLbHU4NWxqQlY4LzJsWmJzTDNh?=
 =?utf-8?B?RVdWL3ExekQvU0cvRnhLVXVwZHNrNWdiTTkyVDcxam9rZ090bVZqS2lxY0dn?=
 =?utf-8?B?RW1rNmM5SnVhTUxVSW9DOTNLOUZmU1pTNVpNaiswQnd4SXBRbUVBeHZEbGQ0?=
 =?utf-8?B?bkdsNnpVRFo3Q1p0NnYrcjZJQzE4QktyOGx0cXZXdDcyUGNtK2hjSGlXOUJh?=
 =?utf-8?B?V0JZTGFiUmJ5ejlmYmtZSU9pTTlMTHdTTlJMa3BRQWY0bTVIUjNmV3BoM2g0?=
 =?utf-8?Q?x311wjtcH4jqaytA46FoP1T5H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c525967f-726e-44af-29a1-08dc3c6a9a30
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 16:46:13.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B35444F+4ehFuhKvvgOjDAMiPCCGvqnS65qaWRjdlKdLrQloJcO2/lK8VVx3NXdMtafBj0egDRWLQ/4BLlQxcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

On 3/4/2024 04:39, Al Raj Hassain wrote:
> The HP Pavilion Aero Laptop 13-be2xxx(8BD6) requires a quirk entry for its internal microphone to function.
> 
> Signed-off-by: Al Raj Hassain <alrajhassain@gmail.com>

Makes sense as this is a 7735U/7535U based product 
(https://www.amd.com/en/product/12951 / 
https://www.amd.com/en/product/12956).

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index abb9589b8477..90360f8b3e81 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -416,6 +416,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>   			DMI_MATCH(DMI_BOARD_NAME, "8B2F"),
>   		}
>   	},
> +	{
> +		.driver_data = &acp6x_card,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "8BD6"),
> +		}
> +	},
>   	{
>   		.driver_data = &acp6x_card,
>   		.matches = {


