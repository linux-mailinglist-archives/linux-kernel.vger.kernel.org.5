Return-Path: <linux-kernel+bounces-66750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75C85611A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B651C21281
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801A012881A;
	Thu, 15 Feb 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WcVXIxR6"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCD66B2D;
	Thu, 15 Feb 2024 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995576; cv=fail; b=HXdZboY9HuEpcNEcvrN/fDPhOhHgAalz3gxnnl2iuSPzNC44bjqO41WzXDpG7O6S6afECNC1QT+pcFUkFTqHrH0DQBC9kGtDIgl3JbY0f21PqkIr5UnylmBSW3+BfKyz07FCWIc1yBB+5/U9rrggycgWbnXSP+spsVh4pJf8QDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995576; c=relaxed/simple;
	bh=BC/CwaGX4JlNigW5lLN46JSvHiIF6iyIvAYHgS4ewbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VWg6/g4KWt1rnUKcqEi3qGLIoDv/DuwQQYuyHheD5mfMqTVRhtYmfnQB7QXioaVv30Qtd3Kk20wSxJQBHAYpWg+ieqx5EfBK1scwGWJTuZpYkGioZCEiHT5q3RD8Ex5BHPrFSoN2Kk8jaoaa1E0vGZbqIEgcJdGg1oOLBzYEf3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WcVXIxR6; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFkT+lfljnZ5dXeXI+22pOopq7TwuzXMEX5sISEPu7mEWBX5PF3Ruf17ec9KbUEea5zBuUFRZegckZT63+AZ8QToZf9/l2zEkEeUjw+uQeJp82qyGwruwcRPrAXrtyEHiEBDoRhRnZ7Xlb+T4Ddv1ddQ94v7Yn8ocWxBt0fCjliQu2muCMz6kOmGNxspK8TbwBDKCJnEEupDI0p6Rm0I18GrZXGoyrGVvV3JRWC5s+Zh7TKrkffdW3MKIVtmvNkZ7YH/gMRKr5bA0qXf3EPA2FRL70d5Rs05VRDrvv/iqYu+Yjsk0ojLXh+9PyPTUgjmhLS7bGK89BbTl0bMMEpRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0btFjrmndTVIMY74dACOQRahTLHAEVbwmZ2O4EASgiU=;
 b=T6c9YETvQxQVlT1I46OeTUzu8MXF1vioZ3/E1uBAp1b4oF637YiwypigbSlQT3pxdpguNfgvB4LjL6kSuPMlry+oxFGRBExptSqsZxNgCDUq6C0HCRolaQ7V+NEr0hMWPptWzqAxaf5NM5IogZZZz0YC4vhp5SJg5vXRWZF85Bm8r6STyIEdw9OyPhO6ckMEdXv1MYHSsj4S2PU+Njo7zVyAFBvI710imHVNHC6VaAbFiGIygMq+swNDSrwr8BxOIOMeTQv0L7lGeO7BqPfEBffiOiKI6kOaaqaViAzLUTOQ1hWoA70pdJLJK6/dpLnl1ms9wfZ79zv+vsLtIjrSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0btFjrmndTVIMY74dACOQRahTLHAEVbwmZ2O4EASgiU=;
 b=WcVXIxR6thEwtNhcZbeiUfSxDiywJq288TP0MMeP4NH/nqf+aHRaT5LCZ4Pm6uGGZvV388ZERvSWOScimxz5Is/puLxOWsP5Qw25ikU0FRl7YCDJF66VXwdHgP8v+UcsxC02FAsuHOUpeOP+9UY1zwPkjMCNeCutHXdNL3ytmunPQkCsabh5kMYSQgLwg52XThO3m8wuWUXtpfo+HHw1TcvMeIc1eMpDxPmol6hHl5WQFtNpsiHEUyaYDjU3bB+PbY/1f3+1SMlIltMV/gwUuRcU5T2PqvhCTvgssJ7IFRFytRJpBoIYSOVTvNVsT/oT3y+Vca0h4YD3C2ck9Q/JgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.27; Thu, 15 Feb 2024 11:12:48 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 11:12:48 +0000
Message-ID: <4b1fc90b-b8b7-4ed7-9199-d0c0533910c7@nvidia.com>
Date: Thu, 15 Feb 2024 11:12:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/65] 6.1.78-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240214142941.551330912@linuxfoundation.org>
 <6e281665-10d8-4db7-98cf-45829d3abf06@nvidia.com>
 <2024021517-robust-tuition-4ce0@gregkh>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <2024021517-robust-tuition-4ce0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 763cc8b2-1411-4f99-3f48-08dc2e170af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XZi5Y3c1nIWKCvuRBtCYkB9Riab2QiEjKekfDtTZ/TjZQYmBnHiuLCrBqjUASLqbD0g2fKCcjIj1F+Xu1gmxrRkxWcOvB94WrnSD0Qra1LgTw2q0keD5K86rR5yxuyoW8FsPGXO5DjLusste81TNbHVHzx60hQfftSlnDuPLip45Rfvhsm7BCwpHsC0/qMMLiqAM2TiZtXShaKMy+PniFS3v/6Jo2iQcmv7mi09WlbMGqt7iPxPMaeDJtldWdv2QuaC4xyE5uFFgEtTSh+nuymnFXsjamEMpA8gO/ou1jmT3gSB6JcqSHsZEfj4UtKsgAPUSbKbXRroIAWt5lYATdfUsvRSTG2oTsubWVtk1qZkL652G/5G1uvfOx93NvRdvUWn0jqp5yJF86wWyBrswYkOj4DthY0V5S3Cm9x/jM/Y41GkRZDfS7ucCkiYIZBB5lXTqdABclniNCB50mc54G9SA0ExWr4O0T7nNZYHv0e2qfcwuyUz5nSb3GUcLtm1o8Kp96XG0pmnBa/A5JNlCTh0rhoXWNFQOHQK7SPmCEad0DntYRpI5xTwcrK4r5QRZgF2W5+tJPTPplqOo/c+6LIqh/tZVkiOe7S8akv1rlYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(7416002)(2906002)(4326008)(55236004)(53546011)(2616005)(966005)(36756003)(6506007)(6666004)(6486002)(26005)(478600001)(38100700002)(83380400001)(5660300002)(86362001)(8936002)(31696002)(8676002)(6512007)(316002)(6916009)(66476007)(66556008)(31686004)(41300700001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFZ4MHRFT0lwZG15L2RiMFNNOVZsZzRqblB1MDRJWGpiZnFhMnVYWi9YNHpJ?=
 =?utf-8?B?QW5jY3BZbjNKUm9yTGE3eXdFQm9VUkVxTmNMSFRXdlRMdnBzbWVXU1k0ZEtG?=
 =?utf-8?B?cnZrcVVRWkJadDErSUhuWmVKSHE3Qjc5QVhVWWhFZWRpVUtYamEyODlRRmRF?=
 =?utf-8?B?ZDJCS3VkUDZIZTZmZk5qWjhlclp0T096Yy9WczdkdlBrSnV2VjdVMDBNVXpa?=
 =?utf-8?B?RWE0K0YyNFFpMUdFajdhZE5rVjhjQm9lZ0ZHYmRmQ3licDVOR3NxTXowWnZ1?=
 =?utf-8?B?NnBVU1h6blUzZ0gzQ2lQakhIWTlBYUgwNkJoQTYweFdDRUhnajFucndjZm1S?=
 =?utf-8?B?eG9uc2YyTjB0UHhFcUxSYVY0ZDJ5c2ZUV0FucGlnM0NEWTFxUFNkclNsTjk1?=
 =?utf-8?B?anM0clJnTVZmYWtMS0orVHVFek83TUVTRUlicVVVTXlkRVhzQS9TWVBRdzhR?=
 =?utf-8?B?c0hDWktVL05sa1YyRE9rZW56VVkrRzN4UmRuOFlDZXRNTVBuUmNVZ0p3N3p6?=
 =?utf-8?B?aVF2UzBKT0ZRV2FTNDFydFdyZ0FmdFV0d2U4bi9ZdFZyT3U3YXpWOU9Rc2tF?=
 =?utf-8?B?Rks2dlZJQXNZRk1pVll6VytNMGJTalIzUHQ0V2xvNis2Nmp1VnNLQ1NSZHRi?=
 =?utf-8?B?VzJSa1UwajRON2xYSnZNd2I5TUZwblNJVStoczByZ3lkeElUWVBPOHhMNlNT?=
 =?utf-8?B?VzJ2TDdGWWlaTDNiNEdpNEI4RG1aUmh4YzV3MnN3U29NdmhlRWZWUDJtNjBl?=
 =?utf-8?B?c05MQzlqeFIyUWJmOUZTQkJWYWx4cTZxSCtQYXM3ZHlYRnBKR2xTYlgrcENv?=
 =?utf-8?B?VXZtQmFXWWRyYm1xUzBKTW9RS0VadXlmUTkzVk04N1JSbzhzeTZNek11anJQ?=
 =?utf-8?B?MGU3eWU2RXV5eFA0alpub1NrK3EyMnNyT2RzYlZoK1Y0b095aVR4T2F5THJv?=
 =?utf-8?B?N2VwaDdOdVBGaXVOZlhiMzhrRGZIbmZObXU0ejRkRVBHY2R1Szk5aC9veFds?=
 =?utf-8?B?OStFV1VKOVVzVUZibXZlQzBUZHVuQXRnT0dqU3VKc0h1ZEZRbHN2Y05FMHNn?=
 =?utf-8?B?SVFGWTY2UXEydkp1TGk0S21Tdm1LbTliQ2IwQWxBRTk4Ky9Za0dwN3d1YXRJ?=
 =?utf-8?B?alVUYUVyRXA1dnRHQmltRGI0OHRYY2xGOEo1MFVyVFoyYnJqemgxSHlQOFAw?=
 =?utf-8?B?dFJkNi81d0o3bXE3MXFxc2kySzc3MTdsV0NhV3RRYzJyMzFZVld2S1k5ZDVL?=
 =?utf-8?B?SFZPVkFRQndXcm1lSTZ0Wmd6ckdMYzUxTUlYbFBvWXJ4a1lxWlY3K2NmZHgx?=
 =?utf-8?B?eXhDdXhuQ1I1QzBZNnppVTZhWGFxd1UvWjF3VS9HZ1JZd2ZuNDNGYldaK0lG?=
 =?utf-8?B?R2ZGK1MreE9CdS9LeHNIbWhqV0ZrVUo5ZnBWOUpwbkcza3BEMDFMREFqcmFs?=
 =?utf-8?B?UDUwNy9HcWhscGJlYURRM1ByTXhKYzU2Q2pqWWsrZWxkVUVpNUxhSFB0RTRn?=
 =?utf-8?B?MEZVdHNLUzk2bDRnRHRjdjg0b2Rwd0xpNXllaCtnWmZMQWNEalFybnVBMTFS?=
 =?utf-8?B?LzBsVXFzakxmbkJBdURoZURnTCtCcTEwZmY0WjljL1pFK21zdXA5ZVdRaXdY?=
 =?utf-8?B?SnJkRUpySXN2MGxaQ24yU1hJYURFVlV6bGZXRzAyT3dPZXJRUWhKdzNTRlFG?=
 =?utf-8?B?aXBEaUxuQXRJRWZVaDNKSHNlY1A4RGVmR1BlYW5JQnV1K3Q1T3dxai8ySWZX?=
 =?utf-8?B?VDJsZGhPTW5WckNXcnk5MzdBSHFqb1JrS1dzTlFibFVHSWRZZlBVQkpLbDkx?=
 =?utf-8?B?Yzd1bmpWYUh1Q09qYnRaNFo2Z2RCZ3ZrdmxyL1pmRXNqVTZENUl2ZkdpRjBj?=
 =?utf-8?B?YVh4NlVpanJqUlB2UXE1VXZJWGZrcWtzbVJKSVFSRVJSODRiaUlVQ2RpaitP?=
 =?utf-8?B?WWZ0NnJwQXIzMldNNjcyK2xNRXBOSGZmMjRDaStnMUZMNFlRSkZTZ244MnQ3?=
 =?utf-8?B?OHVCRmNXc0ExbE1DeUdHUGlPdW9qU1lLcmwvdzJuTTNDYTZmL0dlYjF0Wlhs?=
 =?utf-8?B?M0V2R0xVRmRpbkpBbm0zU3hWMVBobDBET05DTFBodEtMNVJhc1lpNHpuS2xB?=
 =?utf-8?B?OElZV2FSS25pWHpGNjF0cUUwaUpNVVFPVWZaSVRpSGMxUGVpUGI0a3ZDYmpJ?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763cc8b2-1411-4f99-3f48-08dc2e170af9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:12:48.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdIIFZ9DxoRntYEu3EwWUMWnaLmr9Y1kg0pkRG0A4kplag1OASkjREbEZdSN1mquhoJQH5kb9NBFLT2uX2MOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772


On 15/02/2024 11:06, Greg Kroah-Hartman wrote:
> On Thu, Feb 15, 2024 at 11:04:11AM +0000, Jon Hunter wrote:
>>
>> On 14/02/2024 14:30, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.78 release.
>>> There are 65 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 16 Feb 2024 14:28:54 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc2.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>>
>> No new regressions for Tegra ...
>>
>> Test results for stable-v6.7:
>>      10 builds:	10 pass, 0 fail
>>      26 boots:	26 pass, 0 fail
>>      116 tests:	115 pass, 1 fail
>>
>> Linux version:	6.7.5-rc2-gc94a8b48bd4b
>> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>>                  tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>>                  tegra20-ventana, tegra210-p2371-2180,
>>                  tegra210-p3450-0000, tegra30-cardhu-a04
>>
>> Test failures:	tegra186-p2771-0000: pm-system-suspend.sh
>>
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> You sent 2 of these, one without a failure, and one with?

Sorry the above is for v6.7 and so responded to the wrong one. So v6.1 
is all good.

> confused,

Yes I confused myself too.

Jon

-- 
nvpublic

