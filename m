Return-Path: <linux-kernel+bounces-153558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4C78ACF94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7435284745
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75761152181;
	Mon, 22 Apr 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTS3F3Wn"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F031A60;
	Mon, 22 Apr 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796596; cv=fail; b=EZtiCRsQcN48ScLJBoGbO5gBpIxaahMf0+dEMcVKDyofRfzWe1Ynb/jNtocSwBkcPs6dZtl1MlrHN61F53Bm8meLWVKCmqOXhYnP+0kEp+RbZylRFuoUQtCWE0qb3h28dyEVyb6eLc4STRM4tlX795hxqrp5DogWG8QvfZmZ/d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796596; c=relaxed/simple;
	bh=bXuvOWjNTOrgOCmc+joNwXiITXc3ekl6WO8yAMeePUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kANMyKQtOfNUEiQ48py1+ANw8TjUXbCXRIymA2UQ605OYfM+2Q2I3py5DItk0Hci8DoVXTNZrTAIt/4aKPNhfGu+pqNfEEd3i49ff3j5vpuDxWSLRQh77EljNY7pMolRv/vFBxntbOYuncm3Zo1h89I9Xkk6MhqHyMFQg3XFs6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTS3F3Wn; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in3XO+tBNsZCxBsFFLXjEeDKb7BZHHSwQ9HNZdYw1RxKVSPDb3hArtUoNfXlsNFPfu6KL0oVk9Xo+9Ms2jPcujfgk0zAktAbc0SLRKnZJCZO/RyNdaW0x2RMAILx8ylAVj8/5Fjmia/+R5vSzUUR9Hf435kJ8+9iNfHQNtRrPnP5aQw6ib1OomMsUz/6AomN/1GPzl6w2QQFAeiyi5S1KcZUPXdmdOyXi/G1MzH4LMcll3uyf2dx5+p4MyTLsViCoDCPjEHgTZMzKkXs8ZTZHw2C/YTylqZ/KxdyCbGT1ds1Kzkc2o1E2IuYOwR+e66vsp/LyDX2/9GQzPtMrbpC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pS/+wgs1eswq9a2+n5cPP6i0YG6wmmBCb0n9s4n/nc=;
 b=PnzPSXkCxsEoj8S/R3HOktxO+QFaxSgumJg/Bq0IINhjyIPwvSxrgtsuCUx4+cGdsl4YqRurnPIj2wI3jGZOS/u6f3w0EKqezyhysGRCD0WSSpVBxVy0AzGhisTeQXZ2krKCuPija1MiogIhCHbWTb8wa0zZU3M6fZakbb4BV1ihfgoxCoBArtxvluWrIdnDNnSMXj/rOMuWTs8ge8mNEQABsRdHsHyjlPhW7O5hoe67lvsfxMGexcYDoQ4wTaPPj1aZqQBOmC+LpwyDtxcAR3QkGm2m3w3bKsuZp2a44S9VN8F5pXBXfb5Co3Lw7YntLcEeSM5jxVS0VCEUPMBLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pS/+wgs1eswq9a2+n5cPP6i0YG6wmmBCb0n9s4n/nc=;
 b=aTS3F3WnIXFsYkJoSSzHKHH9mdi4BAw4uo+KPojl2DztKvSRqev4EZGZI/yr8SOCdV0zKaRYmgZ/BoTN1xGWS5LILvbH35tHgt4r33O6eL2aGjWxfEX491XLkOkJdOykTdhPu0sKC9ItIuxU2tePM3Ygic4BCsELKty83Lh8bvcShXzUv5/dxBuFeE2yyLr8gg0ZPiFxHHqDzoYFHOeRs5GAFU17EffSfBFeBjw7d9iDp5UExXa/SAxDQjFnEY2v4y29UIETee2wNSsAPAAmdHKPlvCN0Q4ej5IJXyhLr1n+HL8Pl886hRs969WV1QMWcbNzl9dxu4Mfa73nGY5i3Q==
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:36:31 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::a) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 14:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 14:36:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 07:36:13 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 07:36:10 -0700
Message-ID: <1aab0272-85ea-e3a1-7d68-27ab4f1e1993@nvidia.com>
Date: Mon, 22 Apr 2024 20:06:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v3 2/2] memory: tegra: make sid and broadcast regions
 optional
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>,
	Sumit Gupta <sumitg@nvidia.com>
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-3-sumitg@nvidia.com>
 <06849796-f896-4cff-842c-118d86e94a6b@linaro.org>
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <06849796-f896-4cff-842c-118d86e94a6b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d97059a-800a-4a28-f906-08dc62d99a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0MweE9IYzhrUi9vMzkvRGdwUlZrbmxDeXJKNnZWK2NtZy9kMjFlSXhrR0wr?=
 =?utf-8?B?QXNJb3JKQ3dKL0orMlBkNVFCY0RsazRHcktUTzJMbzNEVTUwZDZSR2VsejZS?=
 =?utf-8?B?WDJvVDRTcGQxNlRzblpEVVQ0VVgxaVFySSsxdjdqUFdwTFVGZWx3cmlWNHEx?=
 =?utf-8?B?OHR4OVRwaC90YWYvenJ6Qm05cm1UbUMrK1VNVmRzL0lSSGdhYzdEU0xFNU1u?=
 =?utf-8?B?dzVGdWhmZnBmRFBpSFBndUxQdTA2T21HeWRZeXZoa3piRi9US0dJSSsrdU9l?=
 =?utf-8?B?bGQ5UWsvZ00zR2V3cVVPUmkwbDZWaHcvYzliYmtabkZXaWU0MDR1UlZoak5k?=
 =?utf-8?B?VHNoSDhCUnAzczFrdThDenZJS0JDRVplZk1xWjlWWmV5R2JjRDMvdUM2UjBK?=
 =?utf-8?B?WlpaSTNXUGt6MnNDTXJ2aFpYaktwcjJKWVllemliU0U0RjFRVTNhcUVQK3Fm?=
 =?utf-8?B?bHd3azZQMXkrRS9ObG1kZnNRUHdWeWdOMFd4WUtaWTJMVmVHbmNSTmNYZGJE?=
 =?utf-8?B?a3NUb1JJcXBxZjEySkRUMWROWGZPeFh1ZDdvdjJTMHNxMk5JU1VFYk5lNXBR?=
 =?utf-8?B?U2szRXQ4K3VWQVpqNmllWWRHeGgvbHR3Zis4Z1FxKzNBUnRPZHQwbjhza3d5?=
 =?utf-8?B?T01wdXlFdnV3TStzVDVxbDhyZEFhbzlhNmxHUkNTakxHenpqczc2Z29yWCsw?=
 =?utf-8?B?UHJRd1F6dWRQUkRSY3orL0s3b09qQll5Tm1XaGJUQ1c4aDNYUEJEZVVTWkY3?=
 =?utf-8?B?SlNuUnc1S3F3cXZOUy9UVHJiMU9LUXNtUElZalpqZmpTeW1lRWxnUmMra3JJ?=
 =?utf-8?B?U2lHYVJLM2JCUFhQdDdBaVVuVk9ObzVlZkxkYnpZVzJEMU9TL2hiZDRHeWxv?=
 =?utf-8?B?NTM5NHJNdkcrN0ZLRWRxa002WEZRQkl5dUNZb3o1eWJSR1o5NzRqQi9nN28v?=
 =?utf-8?B?dk9tSmRtL2x4TjYwMFFGbWNzV2RRcXFiM3F5NWhSNzBTbEpIZUQrUDd5ZytS?=
 =?utf-8?B?NHJabkUwMTlLd1RpWmJINmd6aE1IZUl2UVUwa2R2eVZ5UXNzZXovRnhGT3Y2?=
 =?utf-8?B?WnVEODBlWW9PZldFRmFNSWRGbGNwdzNtcmZNazBNRDFZaXFGVkNhNFl6QjNF?=
 =?utf-8?B?cWM4aW13dk1RNUlWK2EzSktUaHRYV2J3ZlhUeXVwYkJWYVlJMmpGSUkraDZv?=
 =?utf-8?B?aFB3dUtRdE96OGlUcXFXRUs0a2o3SEZGWGdyam9EM0l3QjdES2JiSjJyU3hR?=
 =?utf-8?B?eVRlSG80d2QrRjFjVHJWVG1RaVR2TjRrWTB1cE9MMWlDYWdTTTh0eVdWOCsz?=
 =?utf-8?B?VkZYNDlUQjB6UUNiOUxLZ1cyVnpsS3loR3gzK3hxbVduNzM0QjJaaTduT0hM?=
 =?utf-8?B?dzk2M290VTR3allIeUxGNHBhSElVMU1UUmY4c1BPTUc3RnJvYUMveXUxekkz?=
 =?utf-8?B?UjRzcVhLR3hwbTJIUzBsbDhuRzVsVXZYdDNjMG1GU0l3OWpNYmZjZ1VOWERF?=
 =?utf-8?B?RWZ1YlJhMDBTVStWWUVkbExTNVB4TGN5VVNiOUpCdDd6QUkrdjEraXA4bkRu?=
 =?utf-8?B?K1FOSHJjeFFsU2hITzZOZzdsV1lzYVM3dng3c0o4UEI1d0NxaVdjRGU2K25s?=
 =?utf-8?B?OWxLR3QreVcwdS9WVmtnbjB6NFhoN3hDdHAvOU9KdCttaDBXaWNhRkJscmsw?=
 =?utf-8?B?Y2t5Z0RPakNaSW5LdXhOb01DUi8zUTdUOWlDWGZYN2dTZXFEa2k0c0pyMzVG?=
 =?utf-8?B?amgvWVJ0SFYvWHNMUngzZlVQdlVCb2duVHhobjRtU1ExN3krQ1ptNEhFMm03?=
 =?utf-8?B?dnVpelZFRFV2WkYvUkJPM3VzZGErSnUrWCtvczFOV0c3ZGlaWXl6SkF1bktK?=
 =?utf-8?Q?R8ZEhvA2yPiBt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:36:31.3287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d97059a-800a-4a28-f906-08dc62d99a32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992


> On 12/04/2024 15:05, Sumit Gupta wrote:
>> MC SID and Broadbast channel register access is restricted for Guest VM.
> 
> Same typo
> 
Thank you for catching. Will correct in v4.

>> In Tegra MC driver, consider both the regions as optional and skip
>> access to restricted registers from Guest if a region is not present
>> in Guest DT.
>>
> 
> ...
> 
>>
>>   static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>> index 1b3183951bfe..716582255eeb 100644
>> --- a/drivers/memory/tegra/tegra186.c
>> +++ b/drivers/memory/tegra/tegra186.c
>> @@ -26,20 +26,16 @@
>>   static int tegra186_mc_probe(struct tegra_mc *mc)
>>   {
>>        struct platform_device *pdev = to_platform_device(mc->dev);
>> +     struct resource *res;
>>        unsigned int i;
>> -     char name[8];
>> +     char name[14];
> 
> How is it relevant? I don't see this being used in your diff.
> 
> 
> Best regards,
> Krzysztof
> 

Did this change for below warning coming with 'W=1'.

./drivers/memory/tegra/tegra186.c: In function tegra186_mc_probe:
./drivers/memory/tegra/tegra186.c:51:49: warning: %u directive output 
may be truncated writing between 1 and 10 bytes into a region of size 6 
[8;;https://gc
c.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wformat-truncation=-Wformat-truncation=8;;]
    51 |                 snprintf(name, sizeof(name), "ch%u", i);
       |                                                 ^~
./drivers/memory/tegra/tegra186.c:51:46: note: directive argument in 
the range [0, 4294967294]
    51 |                 snprintf(name, sizeof(name), "ch%u", i);
       |                                              ^~~~~~
./drivers/memory/tegra/tegra186.c:51:17: note: snprintf output between 
4 and 13 bytes into a destination of size 8
    51 |                 snprintf(name, sizeof(name), "ch%u", i);
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thank you,
Sumit Gupta

