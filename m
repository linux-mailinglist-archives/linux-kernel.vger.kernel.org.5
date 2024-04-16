Return-Path: <linux-kernel+bounces-146640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4D8A68A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00457286AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567F6127E05;
	Tue, 16 Apr 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qSCvPLIA"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58B6BB30;
	Tue, 16 Apr 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263976; cv=fail; b=TU4j8HoN2jzUQGYsRICZcpl/KwjJU+zd1Z74phYvQVGHK7WkJ5d7r90eRlUsCFgrTJIGxiJDRZX+OPE7F079ozObRPXZoMgaFE6DTO+EHjlp+L+kbjEAg/5vJOX3yZMwPySFErQznrMCXarqn13nl82oHVdtqZ+5p5VLKce2fvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263976; c=relaxed/simple;
	bh=Dp9ApITDb/k6yquDEdHP4vlhLHsUMQbKswzs7BoIygw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nwNECbP6avHN+cmDJubRqGc5+KTsUGumJfOxl6pnPjERyDhF+ZBUpKuHjtifFQAJqh8timQxdfsMYxDNFgozwoc/CNhQw5TqODqWkopuiO22mhjfbbvLvML00Md3z/ln6/IMfkybPkXzATXT3rvPdzLugFDFtpUrQ0NVrTCkMds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qSCvPLIA; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrnDD3kvKb/BrWEbR2BcRYc91QfTMgvOxXPijDQ5sEFmrkBbhOYaFzVFvi5qKnwuW5jymdEUkZ1Hc+uFfp9fnHoGuQ+ogaewl3Xlvv65mn44oO2a7B7gLvX6wNX1V/NqjiTZnAJh1ZipvkK3R9XOFqu3OhmBnXIeQNupk+NG8+/8L8Rkk8ymdUdpuoI3bo0RtrcU1Ns7k39Eh1fCNzj+sU08RpXnMFp0XR9XjmTMib4f3AoXxsJuI1Wpi1s1KCOVhevDfK/ght16CXqz0JiEGx6fNiGpa/hHuMzjPMpprTE/KrOn0HSs+JWJIg0nZnsjgFXHvWfPKXkpm+5rVUouEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKlwbo1lvdM5wO5alWjPj9Shq9At/aHHI05oy3R+DGA=;
 b=kr+kTRNoFs4mBrrjopkgTY7MTcDyyKOj5vSVvQD6CHeEUBNG9FzAq3VBG56klLRA4SM4trW6E4HbDNrBEkLxteBqa29D/K5cO1vf4SbYWrQa1VvxO/Z2hzZQnF+aODhLThqkVe5Q9QrTctUvn9RLy4UwZXAMRm7hIPLcm7rXvUsnzpUjW948uGn1H8vtFuoid5A6Zd+pbom9E/d3FSx5LxlZePT1Kg6ohBnJc8MYhDjVZw5dpFQE0ysAmH99U6jgyZViQ7uxdP58EJLHeQS3+nPBnW2TGEGT3RulqnHyDrQItSSD4bmmkeV+FogUhbsauDj75nJkVkvv9sNBiyWEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKlwbo1lvdM5wO5alWjPj9Shq9At/aHHI05oy3R+DGA=;
 b=qSCvPLIAw8WgLhuctmUceCW/v4kc5H60rljmpAmm5Ak6ubfZu+Qf3ntkQ5BvOYn7kYJSvJYKARZKzKVDhRjgYPF1JLe94JbffJbEfHMwcCRJfho/VyD8+q2+XFI/avjzydI8RGl7LmZk4frEs5frNVwS4rDGIae0YkRoY4Q077gK1lr8as23NFzAYKEf535JRH04Ym1KiX90EgmUQC5UATtHa3P7AZ9XJBHIfKK5AxFOmf4jzrrLyL626DQofEU5bPJrsBgwwnmsIfLyBi5gLLRsR8oSaVJOR5rr0R0YLro8Q+wLt6MeYzKk+4Adb5mZV3pXi6pEC4ZqjSWRvIdiNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 10:39:31 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:39:31 +0000
Message-ID: <49c6c68f-c10b-491e-a90c-b3b4201aebba@nvidia.com>
Date: Tue, 16 Apr 2024 11:39:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/172] 6.8.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240415141959.976094777@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: a8861c30-05c5-427d-5c88-08dc5e017f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gcE74GKQBKKwAtxsDiUi1nHBn/Mto9ApEBuqGnLlJyzftr+oDrdzLQq4pFxP3T24/VlZyeGeyrj4onR2SjV6bDyOM8cqZjZR3qu1qeApz5C6s0PND2dO69oVjLeK4wc0rPPMw9ebQOd8w0M5ILE4Pd47p+w1EjXiw28mbLCg5HjRkYBtawRyGCEa9qruBVkSXGL48Vpato1B0oeYdB8eFspNKVvNJ4Xe32y4F1RyZLty/yzZPSgS1XKBVAlA1P9LlgBc46xRKf7eq7SIkZElKIKVgvhvFbAsvrG3NwnFTuJOtXTJx77u6wh+XLkIdO3wFvp+RxjSgge9jk/9tT/o33cN/VWJuIjPVSbO99sWEDv5/3UgV2sKV3gA/5c7tfWqIPFDJ6k7tqpD+DTWKKHjAqHPNiPHKpdy2PJ8YOMBYm8bAamNrTMJuNgs+oz00v+xZbRom8YliC0PMNP9nJgpY08nEjcPS12sI9kaVi/dqxrlr+XG2nTXxmFecA/Pyr+91FtI0GfrqJh3hXaIenULQULFmj1boZR+SKupuJ7Um0mVdqPdQMz7Px5UwYywbdGcXCcCl9e4QOJoYhf97LfiL5c17LKIu99d1ZVGcPIxX7ZqmL3Gk3pZEW5lHbgiSz2h1KMJazt5pPWF33rYjbnLyRhmxgpgZCrQTs2zRe5ZQe0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y29YenFGOWFIR1FKYUlMdlYrMy9aRHJxR0lkUDF3aWV6UjVkM2FaakxCV3U5?=
 =?utf-8?B?K3IwdXF3OXdSYTlvTFAwM29KOUE1bHF2YUFFZTBJZHFDcXRKa0d0MHBVaHps?=
 =?utf-8?B?aDBKMkRlSHFIb3RwSnFERG1xTDFaWEVKc0ZaMHo2MFJGc20vUzNRb0lLL2J2?=
 =?utf-8?B?dEJESUJLaytTQkhGVk9icGNpMHJGcEdQTTRLSFlOclN6S09kNG1SQlFuMUp4?=
 =?utf-8?B?aDgxZCtEaUhGS0d1bFczSDBPTTduRGEvSjVGcEx1SEs5cjRpYVRmcjFIK2M2?=
 =?utf-8?B?aEgyT3orUG1IMVEyWlJaZkszaFJ2bzB6bC9zNXVyVWtidXFjYmp0T1Z0Yjly?=
 =?utf-8?B?aUxkWS9tRzlmK1dPTHBwK3I4TEIrdVZOem9ZSWZCWjdUNXdkVjhjVUt4cjc4?=
 =?utf-8?B?QU41cXV3QzJnaVZhb0F6YjhnTTJhYzFuNTF4WTEwUmVmeitEL2cwS0N5WThl?=
 =?utf-8?B?dHZMUmpscDlySTZZV1pzOVBPVHJTNDJPWmVmSXZpZFB6aTJ6UVBZTXc1dG5r?=
 =?utf-8?B?ZnZTVFVkT0hmcnEyOG5Zck1MT2N5RWNyZ1luRWxXVVN2RkwvN05QKzZXYTlZ?=
 =?utf-8?B?Qm1BaTZ6aVJ4SVFwakZJSmlsdytNdjhPWG1hZEd0VEVYSDhTN3dnamIySVNS?=
 =?utf-8?B?TC95ZndDOGxTM2lTZE5tSVg3cmk0YjRETWxYYkJwdjBFWnNDdEJnUy96SExw?=
 =?utf-8?B?dWx5bHFraVBoVTgvZ0tuNHoxT0RLc1BGck5MeExyRzJNMVBZVEk2MldxTzJT?=
 =?utf-8?B?cWlxMDl4anhWdHpBQkM1aTlQVzJ3MUdWeHRaVFJ5c0g1Y0RlVTlTSkg5Mmo1?=
 =?utf-8?B?clFua1pXcFdPdHJDTGFiRlNrbEJUV0dUTWlwaVlpdUVRM3dyYzluc3BWdkNK?=
 =?utf-8?B?ZGlCQVlSYjQ1RzJZNEt1Q3l1ajFkcC9PUHo5aFlFbTBNMVYxc1haRGtEQ0p0?=
 =?utf-8?B?U0hMWG9pRzRxaEFZVXh3dlFQTWJWM3Z1YlljMFdpOTFlYkdCRGNvSFZCMHhY?=
 =?utf-8?B?bDdhTlVIeDIxSjFBRXhzRG9oeXp3RkNTN2xRa1ZOa1YzK0dXalBKY2Jvcm5m?=
 =?utf-8?B?UkxQaHdNcWU2cWplU3U5U1RBTFA4cWdHK2ExM2hVWXA1UGNwNWhyR1JxZ3Br?=
 =?utf-8?B?Zk94UHJwUjl1MTZoZHVCbUljTUNacUtSbkdBVGM5SEo1czVFM1FLWkdIM2tv?=
 =?utf-8?B?ZWU1MkJBVzNtcFlYN3Z5TmtMYng5dXJNTnJjWUd0QXRsdDJVTFFWd2lONmhl?=
 =?utf-8?B?OGhGb3BaWG15bkdCUXNrcFRjZTErcDlEWnBPdUhlVkZsOTNVdXZKQjErRVkz?=
 =?utf-8?B?aU1HVzVVQUJOV0hiVEd1YXpGNnZzR3NDa050Wk11K2JFSUVyWmJGV0xRSFFs?=
 =?utf-8?B?WEJYcSthREViTkNYUFk2VVVXWnRMSmlOdVFHZlpmcUxKZ0xiK0JCWStQR2R1?=
 =?utf-8?B?dkdRNHhYbVIrbHVzTWpzdXZETURqbHZmTFJMRzBwang5T1lyRktBMWVHLzQ0?=
 =?utf-8?B?TXVsd0FnVFE0RHgvOTAvblo5R2NWZEdNSVVDdVVHMTlLazdTcXVQSW51L1Ju?=
 =?utf-8?B?Sll2Z2NTZkhPZlU2VlhyNGdxeHErTEF5VnFrZHpVaVhwQWNBS01GNkRUSDR0?=
 =?utf-8?B?RlJRbG9mbkExRlBCVFRTRmZTTk9LU3kvNTQ3R0lOVUsreWZuVGRwOWRXVW1a?=
 =?utf-8?B?SHdmVitzTENwTHM1Z0Q4UlI5empyZjdJNzRIRHN5MEYyelFGVnhkaHMxdkVy?=
 =?utf-8?B?bG9kRDZ2UlJQUDNxdGR2cWxKR0ROczEwbUpnbjlwYVl4b0RqeUkzbFlJb0h1?=
 =?utf-8?B?eElxMzZvWGV0bEsvY0M2dEdOS2ZxbHdlSzg5cDZXOFphRHlUaDFkY0dzaUhy?=
 =?utf-8?B?cVdyMUhrcjZoOE0vczZXcTFVNU02SzNZd3BmcGlxT0oxS21ySTBSN25FU0Vq?=
 =?utf-8?B?RnVaQ3d3OC8xNDY3U1ZmbDN2MmFGSlhuUmltSGlWM0RXTmhQU1lzUTNnWVVw?=
 =?utf-8?B?dVFPWVdLYTRCdzR5dEtUTG8vazNmZko2Z3ovQ1NYeDU3em8zMUFVcU93ODJQ?=
 =?utf-8?B?Q09Xb1U0U1NaakVkMVl2WjE5Yzg3RlRLeTNTYkJseWtKa0E4RXIrN2c3WGY4?=
 =?utf-8?B?SHZpMytIQkxmZmRLVFpXV3FVMXdkSis1bWlHSHVoTm12YzU0TW1CMEFNTWI1?=
 =?utf-8?B?ZU9zdG9nWWh6QkE5V2NWK2NxVlVvZjMxYWh2dEt1c0FPUXlMakRmQ1FWMXpL?=
 =?utf-8?B?VStKalZlbE9BOUxZSDN4dFJueDJBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8861c30-05c5-427d-5c88-08dc5e017f99
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 10:39:31.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHSiSKlMhV8hDmaPB/3lF944lF5+dIYVOs0SkiigeuIEYKyPWQCVBN5RGykXOgxKs709ARX0C1/sWvcltbYNRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671


On 15/04/2024 15:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.7 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.8:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     106 tests:	105 pass, 1 fail

Linux version:	6.8.7-rc1-g367141eaada2
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra194-p2972-0000: boot.py

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

