Return-Path: <linux-kernel+bounces-129516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAC896BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD732B2592B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9FA13BAD6;
	Wed,  3 Apr 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TZYn4vBu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0713AA38;
	Wed,  3 Apr 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139162; cv=fail; b=XYAfi14LGcqMaAQEYhpg7a8A9/cYt1rUsWtDUDV4xV/rb9uk89AANLDimVB7kE+N9O6afXo3XnnebWrCdpQdRmSW1rtNejJNJPXoNW1osf8lJpAHl7NBFWH+KJMy34lJGTp5tiX1QpPD2AW2RKFcJzOeCwE0zo9HBLOMH8cFCBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139162; c=relaxed/simple;
	bh=1+L32c1cSOUcW0HuGW6RyrGJzuDTK8Q3ztZXt8Jz8Mk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDrnkWiShIkRQLkY6HagMULp3lIkygsJ0Pntqk8bG6t66MItGvAj/ls6f3WslQIgcSvKSSXfWRHVvNqGHq/hw09HAdGb2M/OyzXB/f+k7evL/QQX6kfa7QEYLmYEojYVXSSSFcauAOJg36SzGgZA5jhH/seTHPf+Gp8Ui2ZR06k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TZYn4vBu; arc=fail smtp.client-ip=40.107.94.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKzVKG03pHRRbmzAd2rSOvPoaVoZX1zsky5Qx9s58D5YW+Ie8K5Ml0w9Q2V0I+6SUq4Vb+tKyV+2+JSeWdQxbVxc8LiUpA4k7Cb3jmUskGwrLpZDHKlWoK17Cc0p9tm8z8aWv0SvLf7w9P7DcBYsRH3SK9Rh8uvUJa6QjYd9CSfhvsXzz994XxLR0fLi22wZBCWJO2Tzex45sBrbYvmtX12BMBiwYkArsyZbw/o5gIdNmPiWRb1BNJTGuP2DjKQptGzX3DM3AM0ubrEtuDmmLCtDVJM80Aa2vTFVTEJdHgkI8r/gjS56xRVgb+gkDqrOqcduhgvX6LwYP1kDJ4JiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlDas+a2I5HM5sRHdqYCbatbr7RMUx1AskEGSXqZ5AE=;
 b=DtDotJSFY2xViZOI3NI7fn6Ulmb6AtxEit4VPGNszMpzg7LsiFqUOgYq3HMCNBqqN7NA5c9CgI7yzLeUMmtuhTrFD9RSxsPbiAw4tCRgG8t3VUtMJ60/oY80PcbVl9sql8sFRwey8jBZF9XBT1NOpWeac5vsqz+1UqowUUqwy2gP+oAYe/v/mEt4dpOZsTo2rqQIZicSaw8D5YQ2uI5Rk1NksQdb+ea030LGi4p63NfxnXZCYvgvWsOhoulGLGksVByS+b+v+zufftaqEjPubf+4ngynf0H2KnMJZypBEpNNBMvjkD+AQHgOrBmm0Nl9lr4f6Zr0KIQ0pW8Z94aZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlDas+a2I5HM5sRHdqYCbatbr7RMUx1AskEGSXqZ5AE=;
 b=TZYn4vBu0GMuAJkuk8L3aVKfxhKb8C/TNQVvj/hLD5dYrCNJ5GgWLAC9gTQJqikSX1G1Zb1dY4c8YUKHdQTZfs3EdtOeoSrPq9AoHXmvbOmNhS8FMSt7rbfHO2/uVIKyNnpC8R6uXHnXzfKMs3EOUI7X14zMG3fWJJ4xRdFOC2qRtS/CzYGTNK4eUmeJ8t3xw+ryIA3QfCMUGtky9eDbopvbYoMemWAlbXLFX8gQCKR3+gfEctHjOffqetJKk0mT5bFATdHLSPrOYKyiNAtL4IRwQE1KhtHnpazAcTTcmmVpAL1j0UzMjo7Y/B9YUouV0eNqbBBvkwI/k97GH9VjSQ==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 10:12:38 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 10:12:38 +0000
Message-ID: <b508ffe2-1346-4bd9-86e2-ea0df66387af@nvidia.com>
Date: Wed, 3 Apr 2024 11:12:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152549.131030308@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0466.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH0PR12MB8125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	63nP1ctqLKWU7kgl8/XVN7dlApWkItm/k1ig5/0N58eNkGJNuCI1reOS/6Sfa6Np8nSBlSqpmfTIduoc84V8T5A728joluxlgTash+6iiVI7SU391H6SSal9MTtLZzsXf2YEL0dRd0gN4KlolfPXJvrCmnOkd50vMJ6TmjC0ff7EYtfvDGMXKZ+Qbz7DwL0cl9ei25lfst3L3PTXBxtcishf4gpRBhQtg5vJUKtb4M/IeFzQ9NMDIAhzEjqAx+Oxn0OM8HBiqPoNpJi6Lz8hxBUJNmfN8HnH3WRd8F12mh6x58LCgyLdQldlZIF5/buPr56AI8ERrpANcaSHNOtq+ayUf6BtXl2masC+TpzDLzJNHJIWFRkOZJbOGFNBFJ0reQNJMbJeKy8FNjF1oIwpreBYRdLyR+XYNqYGLyK5YDlMkoaFpJP5p8nnKe8rZyG7OnZXruyFeDuiyvOnDK+STTubClFGAjTVnHWSWwFBXVKIPO1gmbsY+jrTT11n15BWF/GUNedhHP2EnJEohIpQqfJRZVxaQryMfYiWUlIdoSAkGBFyAAbNnr8YsPVCsuGYay3YPHWMtxb4+8YF7SaofG5Kc4rO/9Ijn6tzheLOZNZtsLgPxEo1ewmdDZ0Wk/d+9NrDbRVeNS2lHKnw5yUO630GqosktI9TDZFI07E7mzM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0xpTjJYZ2V4VHp1MHJpQkpYQ2k0TkFlOWlxV2ozMmRDYlBUMjBXOUVXWElX?=
 =?utf-8?B?Y3F1MjZiVExqalpCZ0w3QXEzNCt3Rmk0Vk1uTXE3cXpDdE5qZGpzRlZ5c2Jp?=
 =?utf-8?B?VVhxbXZxOE1sU0VlRnhMei9VSElsaDAxZFdTTWViL050dTZQemFncFQ0ZXEw?=
 =?utf-8?B?Vk5PVE00UTl2TWp1YWMzWERHell5Nk8wa2oyRE5TbXJZYkFCLzNRNjZxMXFq?=
 =?utf-8?B?QURGbWRPMVhQUWg0eXZPTCtYMzh4M0dUczJXNkQ3QzFOSHIxNmgrcDZ4T1pT?=
 =?utf-8?B?N3B1UktnMjMzNTIxS1hzR1BxMThpTHVrQmg1OVZSV0RKMXVTSmluQ3N2SXRq?=
 =?utf-8?B?TWJvNUFXTzVNZnBZMG4wUCt6VE9lUTBiWVJMbGJjeDRtWEo5YThiSkhMbEg5?=
 =?utf-8?B?ekh6VXJ0MlJIa0tqSmFSNlZWdmpkcGwwMjdrYTk0Y3dkdkdVWEd1cTRNWCtO?=
 =?utf-8?B?a29wNGNXQklhVFdHQjhHUGN5SU9CVFE3VmxWSk1mRW9Sd29YSFNNOXNqRzA1?=
 =?utf-8?B?cXZseXVhN3FYRVcvby9wU2JqK252VTcyS3ZtdmVqd0ZwRXF1S2hoZFE0c3Bh?=
 =?utf-8?B?TWZzMkJWbkZacGFEcmwwT1pVeXlzYklTaVZrVUtESXJObjU0L3VPZEhSOTZD?=
 =?utf-8?B?bW9SNi84Szl3cmdpN0pPNVBuWHFBeVVjUllBM080dk8ySDRHeVQvT3pzdmVJ?=
 =?utf-8?B?ZW9ZbWI1QnlBZXdJU1BEajlXallUOTRqb2NwemQyR3k4a2YycTZGUHVxcC9N?=
 =?utf-8?B?dHJndVUwODRHZFlnbEUzYTlQWkR1eC90UzkwTEpxUVJET2YrZW9BMHVWY25E?=
 =?utf-8?B?VWY0SWJ0VkRpVGNhWWdQRllxSU1OdjJNZkx5MnIxMUZUeVhCdHE4T2JYU2dh?=
 =?utf-8?B?R1VvZ0xwNUdORTFaU0lwT1pINHJFcEY5UEw3cGMyRGhHQXlPREkrOGZERUZ4?=
 =?utf-8?B?NjZaY0VhYTk4RWRVVlpLYTZjVG14UXF0eG5KUHRWbldEazNsdjBrTUx3M0xi?=
 =?utf-8?B?U0VNU2hmRkNqSFFUNjgxeVRSaSsxZEQrN1hNdGQ0SmNsai9TNXJBWGpPQ2hD?=
 =?utf-8?B?RnhVZ2RyS2M5ME12MlBMbitoZmlMdStPREs4ZXNPLzRIK3RhRE1hajE3WU5P?=
 =?utf-8?B?RmNFVFYwMEJLYWN5L3BnODBGd0trWnBjT3llMUZiZDlkYVpGYVZueUE2Yjkw?=
 =?utf-8?B?UmhreVU2MkdaV052cVgyNXZkNG1ZTFI0TmpXM0tySjB0VE5Idyt1UkxRM1Vx?=
 =?utf-8?B?dkV2M0NPbm1rWHJtVEVwYkM2NmxZK0c5VEY5R1NsQWg3ZG1acVNja0NkZGRF?=
 =?utf-8?B?ek9ZbHo0dVFzSmtWYWFRVjFSTUppelM2UzdaWDVTd1BsbU1XSG5SeE01QlRX?=
 =?utf-8?B?aHQxMlpNTWJ4UHZJTngzZ2VLTXBRakxMVi9rQm9PTWMzeEd5Mm9IbHRJMnZt?=
 =?utf-8?B?b2huN2ZVSUtZYkMxUEVjSWFjTzVDelBReEZIQ3BYZTJCS2V5ZUxESURIa3BQ?=
 =?utf-8?B?T1o1bUtiNzFZNnhSYUl1VmNRNC9FSUp4NXVuaC9vYjJOZGV6bk1zMmVmSTNM?=
 =?utf-8?B?ZVZMeUZwODJPQ2hDQ2ErNk5iQWk0YW9zTzYydk5hRXZlM25pS2s1MnFwN0NZ?=
 =?utf-8?B?VUs2VUJ3NWowNUo4U1IwTjZrSGxoSFJnMG81OGFWZXUyTkt6NHVMaDlGQmFp?=
 =?utf-8?B?QU9jNlY2SjBZVFl2SVN2S3VZajJ1VkhKYU4zNWdJa2VKYVhVbTdGaDk5TVZv?=
 =?utf-8?B?c05CdXlLNUQ2SHI2eUQ1MU1mL0VwQ2dkMHlSR3FkV29PaVNMb0pQSFpBRDBu?=
 =?utf-8?B?eU9FWWJvZkVrN3FITnVteFE4d1BsOS9Jczc1RG5vZWs5b3VSd3FOZ1NtelBR?=
 =?utf-8?B?ZFZ6MGRadmlRRmp1TFYwNGxMZkhNMy82dzRiQXkxbmhwWnY3bkhoVC9MbVBn?=
 =?utf-8?B?czdDeDUwYzRLczkweUZwa1REaG1IdVYza29KZ0VSczNJV2dtKzA4bHNKZkU1?=
 =?utf-8?B?eHpkYWU1MTRTemhEUnVzckhKd0xrSUJzUmZnbVBQcEFrLzFOY0Nxa055czUz?=
 =?utf-8?B?S1lEVzc0bmpjcGJSUHVySGtVVktPRjRrK0lKeEF6d21pV0kwTDg5ZDlLL0Zh?=
 =?utf-8?B?MEpwbmxlMWtlN3NESzhHMkhMTXVFa21ycE13RGIyY2M4djkzejVSc1Z5Q041?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dcf717-c660-48b3-3329-08dc53c6970a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:12:38.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bAzY8o3+SNcwDFous2oBBkFoarylclHsgpR3HZbb6ujUTJsuE7lBteOGH7bGVT/JfE/NTCIeJJQAPovXGUTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125

Hi Greg,

On 01/04/2024 16:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


We have two test failures ...

Test results for stable-v6.8:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     116 tests:	114 pass, 2 fail

Linux version:	6.8.3-rc1-gbffeaccf18b5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh
                 tegra194-p2972-0000: boot.py


1. The system suspend regression appears to be a new regression from
    v6.8.2 related to some workqueue changes and I have reported this
    here [0].
2. The boot.py is a kernel warning that we observed with v6.8 and still
    see with v6.9-rc2. There is a fix in the works and I am checking on
    this [1]. This is not a regression for v6.8.y but a known issue.

Jon

[0] https://lore.kernel.org/stable/0cdbf4d6-3dce-42ee-8029-c486ec999fb5@nvidia.com/
[1] https://lore.kernel.org/linux-tegra/73a71381-7c8c-4d0f-9fa4-3d9511c9bfbe@nvidia.com/T/#t

-- 
nvpublic

