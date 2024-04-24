Return-Path: <linux-kernel+bounces-156300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C8E8B00FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D86E1F2358A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E1C15533F;
	Wed, 24 Apr 2024 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0SDcJJq"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C4943AB4;
	Wed, 24 Apr 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936478; cv=fail; b=VZW53gB/gUrh/XM80PaBU8e008cUrSt3vJ1L20tKZYvg4YzI3q0YIVcnHEkRFr2MejW07rfp1HatXv4/I26tmGBk6wk2ce5eI1xatNr0w9LyQqusyNTkkeEXPzWYEUKPb9G2b5PvwQmg+T+SlvhAKck1lovb+nIbVBLVbp2lnns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936478; c=relaxed/simple;
	bh=QChjuquDjGxkwS0HdmyHm6YyDPRlKq+LgaPKD/tVMng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B8GQXT/dbAwxa16X29aACDPb2PPxI3U2GiXvT59K+oPINe/jJHyVZvTLzOM7ZhWrtFDmLRUrZqG7zEVFPi6OBpGdM6pzBrHQiG8+4ByOcxNd+mjsZBKI5FVBTNWywRBoONPw8ognQdcspWHJ5MrdOyVV3LkcskXwt0CKV4w41PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0SDcJJq; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOfVqf/Xwz0XgMEW6wVfEG7D2CQeqRLf/S3Iv+lmr5l3+K7xnt1blsw/0ZLkPomtDbP4FgjjR6kWrMnrUuaA2b8bB9Rd1XnJeS4YO00lH44VUUZfhx221ZcZ9DlqQ4roIwSCY1KvhMDvPGHnehbh3p6/FJiYra4EX/20yIXEs4kDBs99Fl7yAHmq/M+Aelxo4ijnI4KPI370JQpdngCNdWyjGlt+rN6V0jmmHuIB3yA+2X7HuFreDr+lwd+tQZ+DBVKaPYvXxUlna7E6okFmvlx/jj9PHIkNdmOc/lMrsiztEh96T/bHlx7+hbAwT3Yv3T8+UwCor0G+FL7RSEiriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvHxSp6TCf+seJ2MtTBKJNmfG/BaDvWCgrud7t4O29I=;
 b=cBKyPnST5B5xkz1QmEGaUX61QFBJPdBOu4Rb15FEdyd4DZcENZBbvXt1Yg6/gmJKMBsxXy0R2ydvUzXFQbY12WpuHth33wJf62ZXa0eNHsH9BXv7ifLFMlHQPZHWvtgjqjYYKXx4gRtAt8PhyRSmZQJBEppNX+kNU3ELnTrpjIflVOjYBO6oxWaOGQTbDzsl5Xm/z3gUFUNM7aBzODAGQPfNfnXG8RwegZh9QvqapVeMAqDbvMhbIEE+iDAEIMFwHph/pm36gWT1W2ikqFDsYFYuzHuIcSWfzKtDG3TvlJg5vXC3mA8vT412VrT1gYvu1gtb7OFnsmg94XovteA1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvHxSp6TCf+seJ2MtTBKJNmfG/BaDvWCgrud7t4O29I=;
 b=Z0SDcJJqVwp3w23RPp4RFCu5Yde1XFOJhhKjJncCZCSFaatgKgNYYuMrl4mt8rgkZ+ip/TEXW7+qFEuWgwLJ/IMcCZ22kuYeYcNhr6opQOjeWfFWfNW3qkTyZVwzLQCIiwqmMLTCTFow4YJ9+FaOJ3EbSYmoUacvHtKQQTnHeUIeBLaQq8f36U4+kdZueYzo4sh9Y2x6BkmYKehIoolgmkSV3q8DM+qXnXKj4tbiEAwP5AsMmHTDZkTzmwBBkQfzrJkxtR0E84FBtIx0f3xLE/kKGEn4Q4qbMOgN5TsFjUPYN/OwgLS3okdI80mSgHtzI8aniuJ/txFTjyRdc7KrNQ==
Received: from BY3PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:217::15)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 05:27:53 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::7c) by BY3PR04CA0010.outlook.office365.com
 (2603:10b6:a03:217::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 05:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 05:27:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 22:27:42 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 22:27:38 -0700
Message-ID: <95f8e4b5-23af-90cb-4dae-2922e8e71920@nvidia.com>
Date: Wed, 24 Apr 2024 10:57:36 +0530
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
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <d27d0784-7f88-4351-943e-5c464a7d95df@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 994752bb-66f6-44ec-2e11-08dc641f4a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0wrRkJDanRieUgzTHpnN2RPQmh5cTFqSnlUSVk1bEozajdZeUFqOXdkYmF5?=
 =?utf-8?B?c0E3UFI1NnhwN2pKVkM3c2c0czlIWmc4YnRTWVNWSkplN0ZHZVFDdlh3QUtI?=
 =?utf-8?B?M0pZT2pxZ3B2bjRiQTBMTVREM1Z6aWVUSThWN29lb1pmN2piRWJoa3FiRnQ4?=
 =?utf-8?B?VURhbnJHZUQ2VjRRRzh3MnJFTklWQlpzUnk2NVcrZjdjL3RmK24wRGNQRWZP?=
 =?utf-8?B?T0pvMERidENZWnUwMEozRGp3bU9rQVBlQmM2YTZnRU1Gd0tBaDVwUnF5bkVu?=
 =?utf-8?B?eWNCYjhTVjNLaDVVcU93N09ZUHZiTUd0UTA3cjVDWVZOMHErcGxLeXJBNE52?=
 =?utf-8?B?aVNrZmxRMm9hcUVDTDQzUFN0elp3cTZMa3lNREp2bG9ub2RyZ1NtN3N1UGlB?=
 =?utf-8?B?aEpZaU1JZkJQRjR6RjJoNTJKUTJjaEtQK2huYWVJbDArZkVXNmlvK3BveDcv?=
 =?utf-8?B?eDNHV0ErVmFJRitWL1NPN0NJZUtWekJheGd1ck5FY2gzSDgzeUZNTHRtelB4?=
 =?utf-8?B?U1NYRUt2b1R4NzBpSVgva3A4RWE4SjZWcXVEZXlaQlh3QXJ6YVk0VnIwYTRB?=
 =?utf-8?B?VHgrRGNrcXlCMTVnZXcxWWE1QzdJM3BjYVVmcDdsYlhmQm1HS0grYTROVEVC?=
 =?utf-8?B?bUp0SzMzSGxMbU51VVR0STBIeUJKWFV5YnNOQ0wwakczdWxDSVAwSVhsUXAw?=
 =?utf-8?B?VkV0T2ZKcWtIR2VvTFRvRllreG9aQ1BwWngrblRnSW5HTGhwbFNVcmRhYVNv?=
 =?utf-8?B?WGJ4cFdUcVBLYmpsYkVxNWFxUmtnY1VWTGJVTkppUEVXOUtvTVJoT0hmTXlt?=
 =?utf-8?B?RFlRcnpZc1RCZkg4V0N2S3VlMjBkbXhuRzV6WDltQVA3c3Mza0xyTWNMZEdU?=
 =?utf-8?B?c2FFdUFYWXdlQklVbzIyMm9Qb0VhZXNYNzUzWGYxQW1jeTVWaDhnekVLSXNJ?=
 =?utf-8?B?R1lLZVNWMmZoaGxRK091K1puWlZKY3BWaHFDVk9rRlNBSnptYXVuSEZHb0I2?=
 =?utf-8?B?bmYxMERHRndaeWFldmZXOVlFVmQ4MGF6MFJiaXFlUExtdXdjTEs4Zm82R2RJ?=
 =?utf-8?B?VTBCTGdGdWFWL0ZWa2Y3bWtTK1EyZ3AvZVhUM0lnR1NVNmdoMG1wTGxYbjBl?=
 =?utf-8?B?NGIrRDBPY0dEV1dKMmlyNXFUK1d4MEIzQSswa0JlZEtQTzBoTWpwQkVPZUND?=
 =?utf-8?B?TXZSZWdzL0tYeDJ0MExvU0t1WUFUNzRhS2FEMmk5cFVnN1plMFhQSThxODlT?=
 =?utf-8?B?aXd1dlhBSncrWWNyT3lZSTJGMVcxNkUrd1ppVmFBUm5ZSW9uM24yaDgzZGVN?=
 =?utf-8?B?UGRuOW9rVEFMREZmaThGSi9HLzZWUVp4TEJaY1NQNnN6eVpxd0FCeitUVklm?=
 =?utf-8?B?dzAzeU1zclZHZ0RFMnZ0SS8zR0oxNmJadnpNeEcxM1pkcXhtdU1sYmVIMUVV?=
 =?utf-8?B?OFZqSklaUDNFTHhqOTVISWVHYzlTVnpPaGVYNXFnTjF4L2JoVVdUTlF0NFVt?=
 =?utf-8?B?QWN4SHlKVmJ1QVBZSGRkTEJoTkVmT2NjVm44SkloSm5tSWZ1cUlROFJGam1u?=
 =?utf-8?B?Vy9sbzM1WmdIenF2elZPUFpDZFBXMDZoRGd6aGROV2Z6dzZ4MWRpM3lNZGRu?=
 =?utf-8?B?eElzeWs5ak0wT3pldFhKZlNGakQwOGlzVkNlbUp1RUJ0MFZaVzVaNXhaL3A1?=
 =?utf-8?B?KzhYM3EycldqZEZ3cWtkSE5Nc0pscnRza2k0NmQrNGJqdDJLVWl0c05NczRk?=
 =?utf-8?B?Zm5CL0czbHUrdDMvRTBBak9nYTU2VzdRby9vVmRxeE1pT2N0b0FVNmpsMDc2?=
 =?utf-8?B?aVNFeXkzWEdQWWR6cVlTRm93LzZDZVFGVzFTWkpnTG5FMXYrVG85dnJrZjV0?=
 =?utf-8?Q?QaTClvCTrfdBv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 05:27:53.6264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994752bb-66f6-44ec-2e11-08dc641f4a82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049



>>
>>>>>>
>>>>>>     static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
>>>>>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>>>>>> index 1b3183951bfe..716582255eeb 100644
>>>>>> --- a/drivers/memory/tegra/tegra186.c
>>>>>> +++ b/drivers/memory/tegra/tegra186.c
>>>>>> @@ -26,20 +26,16 @@
>>>>>>     static int tegra186_mc_probe(struct tegra_mc *mc)
>>>>>>     {
>>>>>>          struct platform_device *pdev = to_platform_device(mc->dev);
>>>>>> +     struct resource *res;
>>>>>>          unsigned int i;
>>>>>> -     char name[8];
>>>>>> +     char name[14];
>>>>>
>>>>> How is it relevant? I don't see this being used in your diff.
>>>>>
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Did this change for below warning coming with 'W=1'.
>>>>
>>>> ../drivers/memory/tegra/tegra186.c: In function tegra186_mc_probe:
>>>> ../drivers/memory/tegra/tegra186.c:51:49: warning: %u directive output
>>>> may be truncated writing between 1 and 10 bytes into a region of size 6
>>>> [8;;https://gc
>>>> c.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wformat-truncation=-Wformat-truncation=8;;]
>>>>       51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>          |                                                 ^~
>>>> ../drivers/memory/tegra/tegra186.c:51:46: note: directive argument in
>>>> the range [0, 4294967294]
>>>>       51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>          |                                              ^~~~~~
>>>> ../drivers/memory/tegra/tegra186.c:51:17: note: snprintf output between
>>>> 4 and 13 bytes into a destination of size 8
>>>>       51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>>>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> I asked how this is relevant to this change and you answer there is a
>>> warning. If the warning was there, your answer is really just deflecting
>>> the topic, so obviously this is new warning. Which part of code uses
>>> longer name?
>>>
>>> BTW, really, such answers do not make review of your code smoother.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Apologies for not explaining it earlier.
>>
>> I increased the buffer size to suppress a static check warning in the
>> existing code due to big range of 'unsigned int i', if copied to small
>> name buffer.
>>
>> Seems like the warning is harmless as the maximum value of num_channels
>> is 16. I will remove it and keep the buffer size as 8 in the next
>> version.
>>
> 
> That's not the point. For the third time: how is it relevant to this
> change here? Was or was not the warning before?
> 

This is not relevant to the change here. The warning was before as well.

Thank you,
Sumit Gupta

> Best regards,
> Krzysztof
> 

