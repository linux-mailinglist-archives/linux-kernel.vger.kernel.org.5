Return-Path: <linux-kernel+bounces-156358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9008B01C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C681C22805
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E02156C79;
	Wed, 24 Apr 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlJnTdkf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40415687B;
	Wed, 24 Apr 2024 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940083; cv=fail; b=ngCfBZcghh88a56yFCvxS7GBYhh5XTa1OEWkEceLMEmFBozNg7LfYghC7iisMtG4UNp/gV33kXLzI97WV6iLmzj+ebxkRAAsyofLob3wEnDuA5Gca6AlnTTqBjzaJtMAX6g0l/peGX96iQfWxaLBJgcm/p73fnB12j601EwiOxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940083; c=relaxed/simple;
	bh=f3WNOz9NeO6UQYxy4Tz2OLPKSve1CxtrajHQkVjciz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LYq5nvUZnkGcFAaalwAh5BcJ9S3e2OzrZyELTOAaDNME0SahlCJy9zj0cg1+kEixL3smzf8fmgQQfttkvwb9My5nWFaaMRy76ojemdGLEfylWvKtY3p/evIQ+6j0jFQ8gEaR2Iu7BqEYBgY1iV6DyABv5iaEb3MdZH2q00gYxho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BlJnTdkf; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ+xFZt0wONInWuX3LFau59n7K9jG5EK8KhiMHgAX1R7BmezlF03CySexF5ZKLDjxpSIw1rUY1X1YqKKNOZdc8RHIEQ8h/OU3zLZA7gpxEv2wovdUGHBmfUpdsurAy4v+SkOR6sRduAQ8NoXT0zBvPJrSKkQw6VYHmJN7JJDweSQ0gZ1hPwuAggUNT9RXOsoyDuQColI5iMZrrBtgf0+R4WzRH1bxU0x+GN9tLCMESvl1E4wtqkzYPsn1iTYhjjx20vbI2pGiRzMd5WfZ3BMBrhiQKElNH2iCWkSCFRBnB6DNwCN4TGsN5n/CjUqMm043cxC8gR/lywgm5alp06L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3nBczLe8Vywg9B3jbzGWogXHETHRfdDVJB+hwvJeJA=;
 b=ZbE7QA2p7jZXrRDrWWjy0YzP3JmIGBZiTdR7AtiaLRApASMgE7ti21q0kbVFZqb2qMQtEkB7CT2SEBDZh1FYXslhE5jY2YZF483psq/9ww00+PhqF340Ler2Mc4KGKkgZiO9qE7IhoghyjpSeyr6AO3aiia646ynfRog/7Ikz5GYctA0FsvO3gQMAkxpkuflhUp/YKCEL/3pJ7Djut83NPWpWHLaBa7hC6VzlGtNhLWRiXyISrehXa+RmIgQxJaZst2VZj6xbzYipV+U1GaGF5xLx+IXFfhfknFNVWxmo3pXsx6s4CqjBPbcXhYUXBehP7sioK6QXVt6hUKSVwAJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3nBczLe8Vywg9B3jbzGWogXHETHRfdDVJB+hwvJeJA=;
 b=BlJnTdkfLpIOLTWAH+0nTFy79DyJvZV4ZcknV8C4wWlRaxVdxs12UMMPVSJTWzCORNdNdMIRYl+1HANwDp9jqUrGHRBy+J+sK2xsUSDvxBKiXJ40Mmuvu4KOiT3Okkfg9Nw1fboDsBxjhax0nkJ2yy9G1ZekfTOEdFY1LzOdHzDZvn0sOP8PwjX8uHigPSiLppLmg807c5zu33u2AirlfLKZXjjY/7HanhERvZskcCYweh26sTYNPKXbRKrXR1KkNJPFXkPhpmyqoFoHut2lOSXlKULdWTktYKQarF9SQ/srtnv3VyV6GQZXvpwM4DW8Gcnh5iqLN2trLB9O+LJ9vA==
Received: from MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 06:27:59 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::1a) by MN2PR05CA0046.outlook.office365.com
 (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 06:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 06:27:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 23:27:49 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 23:27:46 -0700
Message-ID: <df19710e-7372-26eb-8ece-2962d13d8146@nvidia.com>
Date: Wed, 24 Apr 2024 11:57:43 +0530
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, Thierry Reding <treding@nvidia.com>, Jon Hunter
	<jonathanh@nvidia.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, Sumit Gupta
	<sumitg@nvidia.com>
References: <20240412130540.28447-1-sumitg@nvidia.com>
 <20240412130540.28447-3-sumitg@nvidia.com>
 <06849796-f896-4cff-842c-118d86e94a6b@linaro.org>
 <1aab0272-85ea-e3a1-7d68-27ab4f1e1993@nvidia.com>
 <6506b2e8-c7f2-460d-b17d-55b731fac1ac@linaro.org>
 <e1d4e915-08c9-c2e0-f882-6d7cd9500c96@nvidia.com>
 <d27d0784-7f88-4351-943e-5c464a7d95df@linaro.org>
 <95f8e4b5-23af-90cb-4dae-2922e8e71920@nvidia.com>
 <4824ad5c-0250-43cb-8f92-ec5e6c9c49af@linaro.org>
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <4824ad5c-0250-43cb-8f92-ec5e6c9c49af@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: af6feca4-f046-45df-94b7-08dc6427af5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2pYdUpjb1pXNm94S1NDOG9GRlEvcjRlcWhiVDRQT1hPZFlzU0pCQkYxTDRk?=
 =?utf-8?B?RU1GVFRHUFNLdWVlSk11ektLQTk0ek00eVo0cnM1bmZxWmhudTcwWWkxd2Yr?=
 =?utf-8?B?UEE0L1FVbEVHYVVGdkFlS2hvTmwrd2ovdjJVM0dxY0VsbSt0bWRBbjlidFNH?=
 =?utf-8?B?dFo3aEtlZk5NWC9CTUQ5SjVZNkNSN0swYmNZemQrTWN6WUgzdWRucmtYczY2?=
 =?utf-8?B?cWxnTzdNWHJ3VWNCRmt2WVV2QnZlVW5DZXkvV05YbXBXSWNrR3FUZGFxMEpJ?=
 =?utf-8?B?NEptNlh5N0QzYTVWSzhtMjBWdTBGNkZWMzdNTS9ET2R1YlZVYnN5ZEU2dzZP?=
 =?utf-8?B?WWdySmx0bk5qNE1PZFIxUWl0WitrWWlSWFFrR3RPNFFuckNwbjg3c1plM2Vo?=
 =?utf-8?B?VGs1cnJDTVRWNjhjektpU2ZJbzIyOU56Q1VKMjkyaXZacFJMVmNwNFZVZEtr?=
 =?utf-8?B?TGU2UkZ6blJ2TitDcmVtaFVTWTBuU1ZaMmFHeEdTeWxxZVJkcWFSYVp3VmFv?=
 =?utf-8?B?cTYvaDZYRVhtUmFOUDVZT08rVUpuSWZIZ3FqdHZ4T25GaFFXWFlZZWMrdmY3?=
 =?utf-8?B?SnFwQ0d3T0RjRFA1ZTAwalJ4bjl3V01LMXJXL2ZhUDg3MnpOUnJ2SFBBV0pR?=
 =?utf-8?B?Sk8zMGNFSG9WakZxZnFHMEdZeE9GVkR2Y0kvanY1bFU3K2NOaU1peHFCb0ZH?=
 =?utf-8?B?cFlrWmMzYmRxVzFpMCtBVHFmZE1peFgyT0VFdGtjQkFNT3VpRWlKT2FVdmpN?=
 =?utf-8?B?dzNaQU9ReHlwRzFob0pMVzhsS3pFclh2RGQvbHA0NFhrWWF0dUxFVTZxMUI0?=
 =?utf-8?B?MVVMWlZwckxRd2hPZ0FHbUJEZ2EvK0dXaE1xcno5eWYzUDdLWUJ0NEM4bElO?=
 =?utf-8?B?UnJvS2ZSeW0xOVFrajdBdEwwNXhsL01vZFNKU3FTYjY2YWxMYzM4L0NpNmtE?=
 =?utf-8?B?L3JQMi9XNktIVEEvZHZXUkpRcTM1WmRzV0pVR256amdYNGd5ZjlzQTl2ZjZq?=
 =?utf-8?B?RTYvYjlhK2VkbzkrSWtSYVhzRStlZ0JvU25kN1ZSNXA5OGxSNldRNG5wM0xR?=
 =?utf-8?B?eEFzSkh0MThXK2xzTjh3YWxJYmlUSEJSdlhoM1pjb0RqNExPYjJTU3ZxWDlH?=
 =?utf-8?B?S2cxZE82d2U1S3lDNWNQUnpCSFo2eVRqdHFRcFlQcFZSY0RHWHg4c25SdVRi?=
 =?utf-8?B?d2xPSWUxdDhZWVkzcE5JZWdZWUo1Yjk4enFOMlFmdStVNEl5YlgyZzl0ZUdN?=
 =?utf-8?B?YkluZkQwbVdvUE9xaUtCTEtKa3laaXRtSjJZUWRRdmU0Y2FxRjBsOXRGMjU3?=
 =?utf-8?B?dmJ2c2xlSnNBVE1EenhZMllhS0dHNUtkYzNQZVRGcXp2UnRpdFVIeWcxN3lG?=
 =?utf-8?B?bGNUOWhJQjlscDVnZXRzTTd5amRYTkh4OEVqSGVSS2tlSFRKdGZpZ3l6Y3NT?=
 =?utf-8?B?QVJQSmJoV2htL0FuQVRJVHpNVEdDRE03SFdQYUJ5ZXJDeG02OGhqaFAyV3FR?=
 =?utf-8?B?Wi9aZTJNQytta3FvdG9NOWhZMDRPRXoxTHRlMkRQQXh6Ym9TVHVEaUF5K3ZR?=
 =?utf-8?B?cUNxMVhyQXo0ZkNZRVhvemMwRUdWRTI5eWhmS0NXeldwbXFvdityN0VQekYy?=
 =?utf-8?B?SWNVMnlNYmNxbjBydE9EenRRalBDbVFuYVFwalF6Y1FyTG84OXlKNG9vaVZh?=
 =?utf-8?B?QWVjL1o1TEdxZVUxRHp2T0M5ZVFuMUxEekNFcTBleXpmY21Da1hqU3VlZDNL?=
 =?utf-8?B?c1JWb2FRdksrZHpnYnNicjlQUkZ1VkwwQzFlYWlLcHhwVGMvS2k2aGhOZ1NN?=
 =?utf-8?B?eG05QkFDRnVGcHpQcGtBRHlVMDlyYnJMTG1UbXV4RjJDamY5SnJaaERuMXZK?=
 =?utf-8?Q?41BSBmHKBziFH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 06:27:58.6097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af6feca4-f046-45df-94b7-08dc6427af5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277


>>>>>>>>
>>>>>>>>      static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
>>>>>>>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>>>>>>>> index 1b3183951bfe..716582255eeb 100644
>>>>>>>> --- a/drivers/memory/tegra/tegra186.c
>>>>>>>> +++ b/drivers/memory/tegra/tegra186.c
>>>>>>>> @@ -26,20 +26,16 @@
>>>>>>>>      static int tegra186_mc_probe(struct tegra_mc *mc)
>>>>>>>>      {
>>>>>>>>           struct platform_device *pdev = to_platform_device(mc->dev);
>>>>>>>> +     struct resource *res;
>>>>>>>>           unsigned int i;
>>>>>>>> -     char name[8];
>>>>>>>> +     char name[14];
>>>>>>>
>>>>>>> How is it relevant? I don't see this being used in your diff.
>>>>>>>
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Krzysztof
>>>>>>>
>>>>>>
>>>>>> Did this change for below warning coming with 'W=1'.
>>>>>>
>>>>>> ../drivers/memory/tegra/tegra186.c: In function tegra186_mc_probe:
>>>>>> ../drivers/memory/tegra/tegra186.c:51:49: warning: %u directive output
>>>>>> may be truncated writing between 1 and 10 bytes into a region of size 6
>>>>>> [8;;https://gc
>>>>>> c.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wformat-truncation=-Wformat-truncation=8;;]
>>>>>>        51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>>>           |                                                 ^~
>>>>>> ../drivers/memory/tegra/tegra186.c:51:46: note: directive argument in
>>>>>> the range [0, 4294967294]
>>>>>>        51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>>>           |                                              ^~~~~~
>>>>>> ../drivers/memory/tegra/tegra186.c:51:17: note: snprintf output between
>>>>>> 4 and 13 bytes into a destination of size 8
>>>>>>        51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>>>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> I asked how this is relevant to this change and you answer there is a
>>>>> warning. If the warning was there, your answer is really just deflecting
>>>>> the topic, so obviously this is new warning. Which part of code uses
>>>>> longer name?
>>>>>
>>>>> BTW, really, such answers do not make review of your code smoother.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Apologies for not explaining it earlier.
>>>>
>>>> I increased the buffer size to suppress a static check warning in the
>>>> existing code due to big range of 'unsigned int i', if copied to small
>>>> name buffer.
>>>>
>>>> Seems like the warning is harmless as the maximum value of num_channels
>>>> is 16. I will remove it and keep the buffer size as 8 in the next
>>>> version.
>>>>
>>>
>>> That's not the point. For the third time: how is it relevant to this
>>> change here? Was or was not the warning before?
>>>
>>
>> This is not relevant to the change here. The warning was before as well.
> 
> OK, fixing the warning is always a good idea, but this *must* be always
> separate patch, with its own explanation and rationale, and warning message.
> 

Sure, will submit a separate patch for the warning and spin a v4 for 
this patch series after incorporating all review comments.

Thank you,
Sumit Gupta

> Best regards,
> Krzysztof
> 

