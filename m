Return-Path: <linux-kernel+bounces-155815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C742C8AF784
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE34288266
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB6142620;
	Tue, 23 Apr 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2g9+Ulc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E41422AC;
	Tue, 23 Apr 2024 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901655; cv=fail; b=PfYcd+cPd11wxA3lC6A1wmkM53SI6yCQwkjyGXe1CSIEHHz5BkRg/54Fut8m8kcw22vnHLdyXMbDJS0cTT3RJEOz4yEFg5f8Z91iCuTmH/LHa+uhB7tZEV9VpOtsjsFvteiCCkCdIpfbs7ktEJDZz7d34LB/Ve1OIk1jMpOHIIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901655; c=relaxed/simple;
	bh=9Cn8QIREBO4T+AjLp7Hil+GyiKNBhjl2SeiACC6hDUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fbyge2Y1EHRwPfPV3eLIv2iiUqzgMlNgyKRWI76fCTeMppUw0iOCg9JfsGlSNo2Htmt9OsH+K+gPQdSc4SXaQ0aRES9gjAvsK3BktqOfVHr567QUiV1FA8tf/8T4feslcmC/klh0gSfGe6DXodrWFvtQnqTPMuXJ0j2LGnwOv60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e2g9+Ulc; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXDPntDh0Fq/S/n7TXEkxFoeKaYsYNTwiwHZgkEAcEb6fmE/X+9P0EoH80Hc89yCWIknYxJFjGApWFx/ahgjO8ygP1LDsmd+ZgsglnfghlST92aYZw2I31oRIbvyDAYqJG3l+MQfxi40B9TjkjAjkqc1xgmDtYqmeGJl1mZUl2f1BBYwoIMDdwixLXjn4KS3BXPM2muZJcmK1kC/CiQwXUSHmGWOQeQpwp2afO9didFuFdDiVcJhOdYx3IY8b5SRcqSGT4wt3YDCGJjQkc6FYfE6+oYgWIolTXC9bPCzIMZgjT9niMvaESRtkbEBXdDP7oE4S7n7fBFCn9vykwa8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KBBbdJIX5qdDHDo5jB2HUpPyGi8y7koVzbLrxLtcac=;
 b=WYOMZztddsC/VdJAA8PJVYWEphzj/cJI6gnTwiEIDKDE/zQQy/Rsqosh8hNk37mKhk1YOdTgKtAofxRO6zkRonChO5TsOfMW0FxQeqSvXAQ8HX/NPKHiZjm96dm1HNPbYjJrgdu30BVBMsxYCAml+cibIe9/yHxcorPygk0ZRLP2BIvdmtivqhwQzczUDMesR5WlUs1nCRDIgc6lpHZTAB7IDAJRU24vCqZcXigrk3kSTZXj7mKWhQJadD5Ga06/Q1H70cZS2/Z2pLWbZsYkBqu0F8+NxTPxDLsgQhVR+Nk94dOVqjIlmbE25F5fLIJJO8A7ne+6aziox7ZDhtDytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KBBbdJIX5qdDHDo5jB2HUpPyGi8y7koVzbLrxLtcac=;
 b=e2g9+UlcE63FYCmY842P0WLS14iCjYastMeKQ4BIptj0ZLX59EBph3xSobe3CqaoXsEurgId2yQ/3kffxZfx9rIMsDxOkVIERyN2hNAbgs0O59Zdg4anujZcMiSs8A/0uFTva0eshFl28tOLlMcF5/b42YZ/OEiev77cYpJFbA1RvCtGTre1w19VbiQ+5r63G86NoJKGtbrJuh5n3ZB6IvKoEdPaatMblGsUSU9yUOTyxltYWBKRZsL3MczfwKlUJisQvtxYpgJex5GChcsGG/tEJW5woUbhdXic6H4uad51MQ6ljrDJRI0/97CRV/Tu8vLfc2x9ijWnrbmU6uT3nw==
Received: from SN7PR18CA0029.namprd18.prod.outlook.com (2603:10b6:806:f3::28)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:47:13 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::12) by SN7PR18CA0029.outlook.office365.com
 (2603:10b6:806:f3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 19:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 19:47:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 12:46:50 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 23 Apr
 2024 12:46:47 -0700
Message-ID: <e1d4e915-08c9-c2e0-f882-6d7cd9500c96@nvidia.com>
Date: Wed, 24 Apr 2024 01:16:44 +0530
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
 <1aab0272-85ea-e3a1-7d68-27ab4f1e1993@nvidia.com>
 <6506b2e8-c7f2-460d-b17d-55b731fac1ac@linaro.org>
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <6506b2e8-c7f2-460d-b17d-55b731fac1ac@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 9650ff02-fa63-4b1b-766b-08dc63ce2c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGgvVUVZRXlIbW5GK1czOUFtZ1dRMlRNN2dITjNXVm5oc09BZW8rL1ExZFpn?=
 =?utf-8?B?QnlPbDk5NURVZllZcW9OYktTU1FLOFphU1ZzalIxaFVmWTVHVzFtZ0t5bzIw?=
 =?utf-8?B?MnpscXVxVjlUcVhDbnZRVk1tTTRFaWNMYkx5MFJIQWNVMGN5R2M0cnk4VDNQ?=
 =?utf-8?B?b1E1Wm5UUkNHMk5XZThBTXZCQmk1M3VzdlBmWE1WOU84ZzNrRVlDOVdRd3ND?=
 =?utf-8?B?WGE4d01ERmhwVWJSeXc2bVgxeHN3SjZmREhLN0I2QjNNSEVLSWFXaWFiSkIx?=
 =?utf-8?B?NTcxckNMODhUUHNpS2RYTFpzWHFqMDZDR0IyRHJJOFl5ZmNrMkZ4UUpXdWJG?=
 =?utf-8?B?di9CNHQ5UDNRM3d4eE1sd0RlSjJjMGJyNUdFL3BHWU14SVptWHZuWVA2VTZJ?=
 =?utf-8?B?bDFYS3V5ZnQxVzFVSEJDemdMUlh4WlNRbUE0ZmFySHIzalhYbUpGTDUrQnBa?=
 =?utf-8?B?WE1YaHpvZkRtM3FoUm9XNzRLVnIveVJWTkZsWFIrVTZYUWpVQ3hlNDd3em9N?=
 =?utf-8?B?bFRtVnQ0Yk51Z3l5S1FZaDBGdDRYcG9ZR2NnMmZFUk5FOVl4dU9QZkQ3dmEr?=
 =?utf-8?B?cWhQZzI4azczQVZNTS9Bb1o0RExZbzZsNCt0UzZyNTdKZ3pPVitRbk5tUmRR?=
 =?utf-8?B?MFpFVlZ0T1V4K0cxeTJUMTcrc2JrMUVlOFQrdkdIdVpEZGlpVVhXYmxmUnVP?=
 =?utf-8?B?YTlsY1ROMmVZNUN0UDZyd2cySjVxY0I1QW5wRThnZjQxNS9JanJKQjA2YWh4?=
 =?utf-8?B?eGNKbmwwVEowbFNleTN5bUw3ekFRaHMvMUNHMlhjWmVkMEhRWTBwMnhRYUtO?=
 =?utf-8?B?Um5MSnU0bVRIVTlZWXVYOFNzV3B6VEY0T3hpTGZQRzYyODdsbzdlcTZNbVlt?=
 =?utf-8?B?R1E2NXlzSXJEZlJjb3ptdmJGa3JKMzF4NUh5NVF6Y3IvNlBZMzVQN1Z6aWNV?=
 =?utf-8?B?Y1d1emlhQk53Qm54RkdxMUZranpBcWVTWFZXSkVPQmpGbXVtSTFyRUxhRHVQ?=
 =?utf-8?B?RitId2oxeFQrT2VvUVg5TDV3MUFYTDM1c1NSYXIvQkh6ZWNCM0tJRWtUMUlB?=
 =?utf-8?B?eWZsSjJJdm9aNTNNYVY4VTlxS3V1WlNvd3ZRMkxDOFBpR1IzQlZKRzFTSnF5?=
 =?utf-8?B?bDdWVzZsZ0VCUzZwWTlmVnlVR2JJM1BGeFFnbnZSMEVqWXpMMXUzM1JqQ0h0?=
 =?utf-8?B?bE9STlZVcnlHbVQrbGZjVFhMaG5ZN2pVaVIyd0tlMGFQK2hiaHhBOHJ3dExN?=
 =?utf-8?B?VU1LajM4Sm9sQU82ckVKQzRwemNGblkzYnFSQUV6SnVBRHNZRjlvKy9QMWs4?=
 =?utf-8?B?Z3BCMG5QMWcwUGpjQjJMNmlEMDJHRlU5VHRKcXFoTjVDN2lBSUNNZHVWTS93?=
 =?utf-8?B?SzlhZWZSMlFBK1hzNW9aTTQwSUs2UGp1QkR4ZytQdTVNKzVESzQrbHo3TDlK?=
 =?utf-8?B?T21sWGYxS0RGeERhWnk1ejRrRCs0Vys4MUhReWVvZDJVZDByQjIxZ1lHU0FH?=
 =?utf-8?B?TGhCY0hDTzE3TkFldmhYRCtnK2ZWdC91WnpMNURFbkEwNTFGWlBOUXQyYVVk?=
 =?utf-8?B?UWdCZlFxZWUxZnVObnd1eWJRcEdLZEJ6b0VEeGwvbnVBMHc5ajlDbmk2L3JG?=
 =?utf-8?B?ZGZOLzBqQXE4bzdTK3pndUJEN213QWRiVTUzb2MxeTZ0OWVnR2xtZDh2QTAr?=
 =?utf-8?B?cnBtdTBWV0FmNDAybndqWHI3LytlNndaTWhYZkZjODJSRU9Ua2IrM04rdTMx?=
 =?utf-8?B?b3VKS3VZd3RCc0w2ZEg3THhYaHNxeVpaUDRUWHkveFhBWUFXSm9WWGtkWWdh?=
 =?utf-8?B?eHBTWDMxdzR4ZEl0bkgzR2lJK1JKZThlaVBOOUl2TFBaaG1Yd29SQVMyYldn?=
 =?utf-8?Q?rsSZqeEzmipFN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:47:13.2444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9650ff02-fa63-4b1b-766b-08dc63ce2c16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704




>>>>
>>>>    static inline u32 mc_readl(const struct tegra_mc *mc, unsigned long offset)
>>>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>>>> index 1b3183951bfe..716582255eeb 100644
>>>> --- a/drivers/memory/tegra/tegra186.c
>>>> +++ b/drivers/memory/tegra/tegra186.c
>>>> @@ -26,20 +26,16 @@
>>>>    static int tegra186_mc_probe(struct tegra_mc *mc)
>>>>    {
>>>>         struct platform_device *pdev = to_platform_device(mc->dev);
>>>> +     struct resource *res;
>>>>         unsigned int i;
>>>> -     char name[8];
>>>> +     char name[14];
>>>
>>> How is it relevant? I don't see this being used in your diff.
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Did this change for below warning coming with 'W=1'.
>>
>> ../drivers/memory/tegra/tegra186.c: In function tegra186_mc_probe:
>> ../drivers/memory/tegra/tegra186.c:51:49: warning: %u directive output
>> may be truncated writing between 1 and 10 bytes into a region of size 6
>> [8;;https://gc
>> c.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wformat-truncation=-Wformat-truncation=8;;]
>>      51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>         |                                                 ^~
>> ../drivers/memory/tegra/tegra186.c:51:46: note: directive argument in
>> the range [0, 4294967294]
>>      51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>         |                                              ^~~~~~
>> ../drivers/memory/tegra/tegra186.c:51:17: note: snprintf output between
>> 4 and 13 bytes into a destination of size 8
>>      51 |                 snprintf(name, sizeof(name), "ch%u", i);
>>         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I asked how this is relevant to this change and you answer there is a
> warning. If the warning was there, your answer is really just deflecting
> the topic, so obviously this is new warning. Which part of code uses
> longer name?
> 
> BTW, really, such answers do not make review of your code smoother.
> 
> Best regards,
> Krzysztof
> 

Apologies for not explaining it earlier.

I increased the buffer size to suppress a static check warning in the
existing code due to big range of 'unsigned int i', if copied to small
name buffer.

Seems like the warning is harmless as the maximum value of num_channels
is 16. I will remove it and keep the buffer size as 8 in the next
version.

Thank you,
Sumit Gupta

