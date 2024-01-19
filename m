Return-Path: <linux-kernel+bounces-31252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09398832B37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62128B21171
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF553E2F;
	Fri, 19 Jan 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="stzVS3TQ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7954F87;
	Fri, 19 Jan 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673689; cv=fail; b=RPH1m4OmBdBBwBjfyqSJSi+7p/R1BZQC8vy2cqVZHv8pev1Y2QtdhTI+K7xX0YRhu/FEoiGg0BX3pRD3jNZ1VfJXkO1sizwNMUmF++h4pKGCC/R/j59ni7qzxPYw6Xan+KYU+KUPtjIZc9mKdB8dRZ5KEZy9cTdWk07xuXDu8sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673689; c=relaxed/simple;
	bh=CHL/cnAWlfFMjdVO9EAzk8+FBnQJWTRjrIWQ3RMzXtE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WRXzUMTREye4QGxCgKx7b7uOjjeTsY2Xju/87EBEbxTMulk9umDxvwU44PRsE+9XLrVBskgbP+o8hSPF8vROY5pZ6ykWDaYeY0OhnL5szRe9TWlf2X5iZ0SSUv9DG436eB/S2kwJ4VGlWeszrh0PAae9jnNESq6cl2J4nhN9ZoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=stzVS3TQ; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POddFChSjup+IkR4NsI/wGaWOWfPWpuWxm7azbXKZfwjSmLrQDXGc6P2BTTV/hlBRgP78ld6r1ktc31GSbb1vWSoIgZw0RMWeK2sCOFK4HMR/DAkUvzo4Ro0juAn6TzbLUFUdnuTlvxs696aFoDcHMnUox4nNVheGuplLRusEw2zAYdnUpAVDb0RnNzQ2aqeyLp2mwFHhSdp4rE0F0DTyvitmR6/2t8MRCHkdKP1KEAwpLIt/19j5sC4NOgH7NpQi97lltnvOVKj3PpqF3j7TPhGatHN9STiKMA9Si0cNkj340zAo4u69VmKcWcT5HvxURDIE+/rx/bPirgzr5fi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdt9quGLElHrPchcCjcYG3TCE8RxpoSGT+a9QccOjVM=;
 b=DUj9OH1tC+0b6jWdtmaOhqUIN93szUAtlapczczLRC6ytZu2UrkFeya6n/NxSJXDUL74mwk6//JlHUiZEIJosALZB26j1ufvhpNMyEuLmETviz12iBlQzD9/Ivd4NHSecL0hbA/C93faFI0UjmI16G425oW+KU846uL+1afnCPHNDUxI/AWb/rZaeBdzqi1JCtg5Rewynbhw5LRgmhSMr8eLC74Xj2eGNA1C6Z9xfjcvPGFVYw6zUovhwHT6weG5VTj63V/U0UNuE3Xw6Dvx46XwpPZY71X4STaU3lzBIcEyRkeentD4BS+8KsKppRTytg0zvVwPcXOZHc9zIXjEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdt9quGLElHrPchcCjcYG3TCE8RxpoSGT+a9QccOjVM=;
 b=stzVS3TQ2ktRJV+Iti/LyDXS2FSAcIvTQ/QFE2NQMU+LNlZPlVhvpyM+EELWEWRlqrwRewhMFkOiFte4o4W1IoCiXyB8VQerRuuHsKD7x4cWpOVjB0pqpgmdmprEnEpXnxHtGty+Znoq3BiuMAvp6Chi1ZF7X7JwjtIGhsKTzT//p39MY5PPkO3JPedCumbJnoN1vVidXjFzFDzbkVqOXpkxPGNA+Q2b6xffulZaaenW9W6qotMxB6/U1pOILOx8w6/kqI24VfL/SUaRMcoCenIIizZ1LrR0Acv+U+lpPtE4Cgm3DFpDm64PX55j3g1I8bNzobLlE7XOVNA3tL+dnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Fri, 19 Jan 2024 14:14:44 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 14:14:44 +0000
Message-ID: <e5d91609-829f-4318-a200-fb6657be82fd@nvidia.com>
Date: Fri, 19 Jan 2024 14:14:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 SW-Mobile-Linux-Upstreaming <SW-Mobile-Linux-Upstreaming@exchange.nvidia.com>
References: <20240118104301.249503558@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::11) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3d71d4-fd87-461d-b135-08dc18f8fc2c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EhpsFmJxeLPv9DlJ6bF4r90qhh+mBg4UEKzin2WSL5n3p15a0nT8s1faKO1/fQP4vfFtTKNTK08c/sowXehexi2+GACHUKSBcvRrUBNenXsNWY74Quua4y6RbVChI4GAWulmBSWVfUm1jSqjaKL9lbpvnD7J3rc6tAe4SGPuwqbjlZQ+27bdMT1lO4U6YhB4LeJpIKRtbF53dsViLqis1d9fo5VCtJQeJkUm0Ckbdn+STqi0Ql59FyQoxRlbDZzzLa/Ynu86bgclsWOGiKM6fe156jOTSeAIEyQ2wnxSlz2Ot6ji7OJXc0/vTStGTk2fW+/uC6SJ7XcVNQQZZoKz97PXRql00p03ZNn63mtGYJi1CJQ1W7GpHzNNi+QkEzfJpuQQ2Luym/3O5dsK+IB0NvcSSd/qfhpCYL0b8w6PtSh0zrBTva1RIY1/n/CS29Efc6fZ+BEV3yMPgAfioz8HoSPkWpHWPsLBSYoIkwPzQpbrTyuQ9OUAP/SA711G5jxxutNM6JPT0s4dWXacsXLnLV9MDxv+IKWVC3XUj0UJFN5fJiMQqeFslFWjXs2SClLyy2IwwWW9eigcJQarDXMebl3DSdvduof4zOVoVs5rHuCCM5HsJ0BPMU+fF90U+jsOAXdmPdkYeZRLp5/wES4Xb2xndH8Asc9rrhv+/fFnYKmqi3JT5PukuWkm5DhjIaJ8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(83380400001)(86362001)(2616005)(53546011)(107886003)(38100700002)(316002)(4326008)(5660300002)(8936002)(8676002)(7416002)(66556008)(966005)(6666004)(478600001)(6486002)(2906002)(6506007)(66946007)(66476007)(36756003)(31696002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE5JdUNlRnF1Q1hVVGl5aUFybkg3U2Vzcmlvdmx5dUpjRXlXWThNMUFvN0s3?=
 =?utf-8?B?YjhEZDJRQzg3aUJ4Vm9BaGw3bTBHQ0o0a1lZR1VPVEhMcGFzUDQ1QzN4QkFS?=
 =?utf-8?B?U2FYc0ZCVWRZNjYzcHhXeGpwTWNyeGlPL0ROZUQrdTRodFl0M1F6eW9heTNT?=
 =?utf-8?B?dXZvRW5Rck43ZkpUMStvT3ZETkEwVEdrNEg4SFhIK3RtbVE0ZEd1QnFMUGkx?=
 =?utf-8?B?Vk9Ya255S1p5bDJVMnF1MXgwclVNenIvcEs3RjUyeG9nVk5XRTBIRnYxdWFz?=
 =?utf-8?B?K0VIZDcyN2JkaHZJSHhnOGpWTVg2bFY4b1hobkZKL3Y4a3ZxMzdOTTc0YzZv?=
 =?utf-8?B?cE93TWF2YTlETUtYNWNxVnArck1yNnRudnZBcUF2bzYrU3RIOG1RYWZLb09u?=
 =?utf-8?B?ZVBXcFJVUmU1Tzk4eHhNVmFvdGQ4a2RFK013cmQ1NWpDbllRaERqYjZ0R2Jy?=
 =?utf-8?B?ZVlrT3Q2eU1MVEdRN0hIZVRkYStSK1AxY1dZYTZJVk5mS05iNHhEamtXaHNU?=
 =?utf-8?B?aEFRRkpaKzFYdXVaaGFEZ3A4M2lrK2VSRW9OUFU1YXlQeTZRKzgyNnQyaDRw?=
 =?utf-8?B?ODNvVG1zMnZnUEFNMXdQTkdzckVTbllvdVVTRG81bzkxT1c4eE84ellqbnc4?=
 =?utf-8?B?aHFpdzB4ZjFiT1dueEZtdjR6czl2cDlrZFJNZWhLdDhudDJsUnRrZzBjYkFZ?=
 =?utf-8?B?VGN1V2ZyL3dhcWF5a3ZGYzJTdm9pQktESmJ0Wk94MGcxOUFoTWVoR2NDTGNr?=
 =?utf-8?B?Tm5ORkhLdkFNUVIram4rV2VDZGtFZ3UxV1BDUlNMWG1EM2x1WE8zOEtYa1lF?=
 =?utf-8?B?K2QycUlIQi8xalFOYTh6NFg4NWpYa2hIOVlLVE50K0pzQjErT21WSGYydWZV?=
 =?utf-8?B?T2owdkJkbC9XUG13WUlOUXRORVIvUU1CdE0wZlpDWkVWYkdYekFseUdZVnFj?=
 =?utf-8?B?UzJKM1E5dDlLaDFiZUQvTE1HSlAzMzZ2bkc1OEo4MGZPSE5mQ0p5OXpnclBO?=
 =?utf-8?B?bWdLNUtMUVdJd1MzN3BRbkpoUk1sY0JpL1RXNktqNHpVaXNsS3dwU08zOGJ4?=
 =?utf-8?B?cTYwR2VybDdRT2JCN3RVa2Q4UWF6ZkRhdmdLa2pHcW52ZkQrczVydkpyOU1i?=
 =?utf-8?B?d2FZTnk4dk9xa3VjbldQZ0tjMnYxUjJvS01wSkZoL2dyT0czT0s0dEs2YnZF?=
 =?utf-8?B?TUpBK1Y4Rm5oMFJ2OWkxTkVLMWRuVmpQTVpkRGpYQXNucUxab3BCNW5yVU1T?=
 =?utf-8?B?ajJ5WHFPeWxBNzVTZmJiZXg4UDRqTXRFcE90Q0hQWUE5b1dYU1h3RWxGTHRi?=
 =?utf-8?B?MlM1NHkyOWRLckNQZ1lQei9wSUtlNXQ2WnVVd25UZzEvaFd2dmpBa1diSnJz?=
 =?utf-8?B?RDlvK2VwYiswWmRUVzM2NHVkclFMU0w4cFpmKzlWTFRsOVRySTV0Z2llTTZV?=
 =?utf-8?B?Y0hrNjJpbEtVVFlxSmlXOWs3NkYxMExja3BpYjFnc2VzTzJVM2t0czF3UVhY?=
 =?utf-8?B?bGZvU0t6UkloSnptTUVrcXpBb2JtUS9aOWhQeU5NTndTTDFPYzlHcmk1VFUv?=
 =?utf-8?B?TkhSSjNkMzFmMHh0MzdCa0JpSFFqUFJicnpzOW9IRXRtL25MeWVKOEd2TC9r?=
 =?utf-8?B?T2JTV2VWemExdUoyVXhSUEc2K1YzTk82Q1l3WkI0Y0lOeXZPenpWbVpQdlRZ?=
 =?utf-8?B?dWNzN3MvSHJnZFVva0lmNWEzc3lURzllbDVVSjF2OVltaXhYTDVRdWVKOGhu?=
 =?utf-8?B?NUtFSDl3V1JMOUZSdnlidGVxZkhyTm5iM2hrRjVGSnBXTUxBV1dWRnd6RDcy?=
 =?utf-8?B?SGlIcTlmcGNKTDRmcFZOK0RyVjV2LzhLU2t0YjJHYS9YOTFkalVyVmhTWmZJ?=
 =?utf-8?B?cXh2L3A2NFF5ZDFmWlpPS1dlQUdFbmNuTXo3b1JTWVlubmROTm5yWG54VTRL?=
 =?utf-8?B?MU15b3JiamR0Y3l5SHZTSVVCZFd5MHpHUlY3em1Od0U4SnRJdmYrdWpTaS9w?=
 =?utf-8?B?TGxVTDduWVZGek1tZVFoR2lvRUhqUmhhK29hQlE3ZmFQaThJU25XMGsxaEF2?=
 =?utf-8?B?eEJ3MEhrOUJyV01JUFBPN0Y0U2JnVnBja01nZHFjUDlwdDI5NzQ0QkxMQjlk?=
 =?utf-8?B?djlidFZtTU00aW15TEw0NjFycWNVZnIvd2d3ZldoM1Zia0pMZFZlcWVpV0Np?=
 =?utf-8?Q?Z8DEgIbviiHorZkDbs+plS1bqzB0LGwwIlyVlNs54HgN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3d71d4-fd87-461d-b135-08dc18f8fc2c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 14:14:44.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49hQb3puPMaYSuSPhsy2xP9yv3lMh7zpWskSNtWnS4DBV9k8JpcmOb/3P3btWi1MaSB6yclbrgmDDYhqMDjQIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416



On 18/01/2024 10:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.7:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     116 tests:	115 pass, 1 fail

Linux version:	6.7.1-rc1-gef44e963b02e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh


Unfortunately, we have a suspend regression for v6.7 on one board. We 
have identified the change in v6.7, in the Tegra Host1x driver, and we 
are working to fix. So the above failure is expected.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

