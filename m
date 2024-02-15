Return-Path: <linux-kernel+bounces-66753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C701856123
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF02280A70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600A1292F1;
	Thu, 15 Feb 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SI1jhPY2"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D124B26;
	Thu, 15 Feb 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995671; cv=fail; b=um3NgubAZwAPkH72riAvazogAS5hkRpdFRVprFtPWMfnVIeZ+6Jy59n3WKj0mqfSR2SedBAR9O31EsQdJtAWwAPhJ3vn/PqsMn7lseeVDc53Bv0qYFKqi31McYITQwKvh6wYgrUvdxBm6TyT6xgAAf8LVyYsp4IaWobwPdJjdeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995671; c=relaxed/simple;
	bh=sYgZk9pUMBRzOPaVFa5dymUsB60xm5hatYR5t6h0PzI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=svFAFAx0F4sYOihhviW8sTBrOFmACR/0zEZx7qxhDZWUQXHBVHS+vbEHEPKwyy/RF0cuLXlVkiBOMvTD9CyBQpU0jqjpQnh9cGcLmpixspZR5ugYUHi2hUG7tTctWvxV1t7BdYBkcv6Qdu+jPuTUKCCAJ0jmZuTXjI8D9BteVdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SI1jhPY2; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYFFm5c14oA1deRiGNwf31u9ePIqLqW7rUdX5JaGenmaCV2pXx60Y3utr79DS9paZWLKXpaoHK4W8PQV72TEFeSG5gfMHPNeOSmaVuHjevklNbfSPFQ7VQWj9ie/3kDItgftK9EehcI2L3Uy3VCEee4V0552DdjRjHzLqrB0ukEOhJ06OEvDldPXGPO9g6FV5xsIEEsH6YKtQWDuD06UB9srbNcpcrgbo59RTtgN0+xFjCR5WH6VWGUYfKWuehBkG39oWrOECgZ2tVvjRHYi7rRp1GHukEQmQm6LMkqkmt6aOifejfo6z+//hvTcnAa9oWib7md1JDp4klBQ1kLZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xki8EcatnF0wcWYmH0DL3FvaHXG7gEkt6vPm+nTBrtw=;
 b=AZpZD4GEPkSIRyfBeeA/5UQGaMU1xJo8ov1ZAPYdS/MX0QHnX23CbnR3ghnKPE4idmzL/91rlW0VFOxB6oMtwSNp7/SQKr/omAM9ZCsp1HO8gd8iBTmYabpZcT3M8bXAHxFzI3B1KMJxhsxOVhyuM8LAYLYkTBTt6FeyJANctTh7YO52yi6mEfofDygUBNBLaL1muhnJ+62SxHjzylkB1B1yTLRP7YGOC8E+V/zTQrE7lLrPLdC4EV0hkKkJL7uNAAhggK9h7gdQi9VlGUzTmQoMJyl5sgsM7ZgTdieZ4qKcVLS1d8DxVSdbeoImrsQ1pqp1xa3F8gk77VpLvpj3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xki8EcatnF0wcWYmH0DL3FvaHXG7gEkt6vPm+nTBrtw=;
 b=SI1jhPY2EnyTyaGM+gVHCMLI5BTdVLYrs+Z707kux55l0HyzZSzwZG+xiaqEkqE3ZkrTLt3pUugX8pTFaVzXCfEnv7i5pJD2pBLfkuNuzfVFTCM7QCI/5UKdWwco6FPUMXsHx7xb6eEYgf4d9lnrEa9BAzR+m6nBz0B2sz7X17v1Cn0/q9DeNR9tqrDgCUzxT7WpBuK5K91ACBKTotk+PMvAxdEE3L87fMOlYOXD96d9EBoblo0MWGms/9+HCDY8hPXEmknQKzno8HmAdW/MIdpfJ+fBum2JtRGca7rO0VYDLgK4JoeozhrkiDeo9MdOzzpqgYy5bDBiJtt6ZmltBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.27; Thu, 15 Feb 2024 11:14:26 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f462:16b8:4857:38b7%5]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 11:14:25 +0000
Message-ID: <4cc8718f-6035-49f7-bd50-39564ac4fba4@nvidia.com>
Date: Thu, 15 Feb 2024 11:14:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/127] 6.7.5-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240214142244.209814342@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240214142244.209814342@linuxfoundation.org>
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
X-MS-Office365-Filtering-Correlation-Id: b121bfcf-ae46-407b-690a-08dc2e1744f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T7StWSuceiF6wREr9WyJAaBIdaoimGttIeREPZnHRWg+ZPlZbpKXGLXWv4nBKCYojcVfzO8xkSgRdle7jYBJem7NQbEsqbR5d4OJvDRSwrLgYV8Hur4i8g0PtAhk/CMta83CkmVPO+514RyoiooooRKZLQ6Dyh3t5ZX0HvqG7ooFe4yOVN/77EyDYmxcWrMuosnjCpwta+p0D3eIUrijkEtC2JDiEyfbJM46yCoBhefIReWZjkPw6vV06JoMAe6bpMBmg+u/uiaO/poDBk/KXZ6e/LfhaIvGnAcp6xUqZ79IRM30vUM1wDqhqzhhg/FJ0LuGr3WnbkOsqcP+LrhPPluTdIbFwiiQRv5o06qra0wpEpHMuShqRZCLrnJXDkylftm3BZlVxEqqRVXXQ84hkQ4ibJuNFW4cVX7KeYFJRcJbyJ8N5S9TfLX+xjt1229LT932fq7gopScwu74clGQVWsTWYkLzoGQ+Ak7+rVutpQUWD4XPHaMjfpis6Pzttu2owyrs52DQVJ5HpWUc35O1kwHCmmQdpHo9o4wr8ExAE+vfqlhSNB13Q1NdC/ip0X6fyzx9GE7uM21BRkT7Te2pmqcul9utSq87VDbYMHGEkE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(7416002)(2906002)(4326008)(55236004)(53546011)(2616005)(966005)(36756003)(6506007)(6666004)(6486002)(26005)(478600001)(38100700002)(83380400001)(5660300002)(86362001)(8936002)(31696002)(8676002)(6512007)(316002)(66476007)(66556008)(31686004)(41300700001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEVJcXNxcmJWNjY5VXVMNUF1L3VHdDg5a2FzWW90SmEzakRZWmEvcDR6Z0di?=
 =?utf-8?B?TFd1WFFnblZDNVhSOUJ6SlpGdUJ2N05Wa0pkZU0xQk5ERnpyeXpVUis3TTV1?=
 =?utf-8?B?MEZlUDZzUHppYTVrdXplKzBVWUhSMHhrcy9aNXFFWGhQVU4xQ1BnWS9yUnV1?=
 =?utf-8?B?eUpLeWUzTTNWeXBXRVBGU3ZFU1F4cFFnYVUwenRqMi9wTW9wcFVldHdJdmdx?=
 =?utf-8?B?eSsxb1NLOXNZdC9nMTE5VHpFdmZYUEV3Q1JDSXc0VjFvR1lUaXg4eDJlQ0tG?=
 =?utf-8?B?R2VRa2hqdlJsamxCUlRwQVFScGRGZTB5YUE4U2ZwSEVOTDBIaUxxZy9sNGp3?=
 =?utf-8?B?UlMzeUMrbHRKUzFYTFVKcDdEeWJlb1JUTmVFdzVuczVjS3BiL2xKemxGeDhQ?=
 =?utf-8?B?aDl2QjlJVHJvRHFBc0hGQUVxVm1LUk15NlNNL0JCWEcxODJlQU1Xc0cyL1dF?=
 =?utf-8?B?SGF0Y0ZnQnQ1TlRqM3dteXpISzJTMjdwTmg0WTBmbzJYNHc3cGVzVXVjaC9m?=
 =?utf-8?B?eG1UdWxtZld2WjZZUy80dUZuK2RVSFhkZHc0aHgvSnFldC9IMkZxQWRaajFW?=
 =?utf-8?B?MFlwc3JaYmtaUlloeUQ1Z3psUWVuQnR2dzFZM1dROGIrc1FrOTFaWFlLZ2xy?=
 =?utf-8?B?NUVIbzUvTURwcXdCbmZFdkE2MWpGU0Yyak1mckVKM203TEtlcGJ1YU1kaW9x?=
 =?utf-8?B?WmE1WEoyZmhXeE0wZVRkcm9NbEFiWCt1VkRPYXBoYXhoNlNNNUwyd3pBankr?=
 =?utf-8?B?R1RoMElobWQvblJIRlpYUUFkZlJZSWp6eGNmNEhPcnh2aWhPT1hmVHhLT0pp?=
 =?utf-8?B?OUlkaktzOXIrdU1xZkJROEdqK1RBUXdSUTk1L0NMSDBFbEhnNW1xeWVkdlc2?=
 =?utf-8?B?RnpiVzZ2dnFKbUROVkc3UlBQbTVXanU2U1dQY3BmR3hmSXpZRWR2SVR0ejhh?=
 =?utf-8?B?QkJleVVaVEJNTTZEWnNwZTZrYW9ZWExpalhBVXB0UXlDREplQTc1U3F0ZnNp?=
 =?utf-8?B?cENlaGdIZnVzaG1JWjZTR0dBRkxDRDJCYkY4dXd0UzZnN2k2aUhGUDFUMGF6?=
 =?utf-8?B?N1VkT1JoMWNMWkNZdVFUV01qQUxTUlhZTG1Vd3NVOWcyQWRHcnkxeFFEMVJI?=
 =?utf-8?B?b1RYTjE5TjhTbkpTeENWQVVHUWQ2OEd6TmFLbEo4VC9SaG5wM1ZiWXlXcFFn?=
 =?utf-8?B?WFFxK3VoT3Vwd1dCczQzc0pvdnRkRS9iTkw5c2g5U0g0T3BmWTJSMktMTWNt?=
 =?utf-8?B?VlRFV2Vra04xMzdZQ2tYYTM1RWx6cFFsOWxGNTVMMkNsM1NCSTZpdTRuRG5r?=
 =?utf-8?B?KytBSmRVeEUzTE91Q050S3NPUnIwVC91QVZRZitTR3AycXVoeURjTXZhT3d5?=
 =?utf-8?B?WEdidEpGV0hXU2hPcmNTM0I2RS8rTzNpbXN0aTgxaVVxR05uaXlBZ3BBQndz?=
 =?utf-8?B?Z2J4anRrbWRIZmNPQTRKb0xFTzRGazV4UWpyOWY3bERldE5kcEp4Q3d1c21N?=
 =?utf-8?B?VDladzBoV2hiQnF4YjYxM2lRZ3c1akd6bHRaRTdTUm9SSGM3UjhpeUk5OHFE?=
 =?utf-8?B?Q2xtUXN6UVFZRHVZRmRtRnlSK1NHcUhJZXExdi9PNFU5dVgrdmpoMkdCRUQ4?=
 =?utf-8?B?V0tYMTArTVBId1JTbHZCNTZkQUdoZDJycTZDSDVPejZ2WVFGdkFjM3pCSTg5?=
 =?utf-8?B?M21ZUUxhL2ZZSkhVL0s1YXIrbGl1UHRJTU5IUnNWR3h0V2lhQ2kybTBLWWk4?=
 =?utf-8?B?bUxLU1FpSnNmVGZtbGVvL0k4UzNwRWlWVmlXdWZFbDd4SDhFNUFyaUZWWktM?=
 =?utf-8?B?R2ZkS2xGK1AvbjhsR0Jxczh1UXBxaE1sT2dqck5IaWliVlA4MDVnU3FZcGpm?=
 =?utf-8?B?ajlUMC9OdXFIb1BQWTdHYzBOWUtic0psU1hIMVdxUFovK00wVE5RWGZhRnBN?=
 =?utf-8?B?MlZqZWl5NU92dEJEVDU4ZzdGUzZXZmFRMnVRSUlyNDRvRTl1WjFGVlJ1TVRJ?=
 =?utf-8?B?QjdhSVNxNDJNSFBBTnRJK2dqYlBSWHltMHk1bmN1OFRCUlVYaVUrUXB1UmF6?=
 =?utf-8?B?anZzWTNyU2dQdWxURzJOays4N0REUjJPeFhPS3lKSVlVNGJsSU56dzVMVzRx?=
 =?utf-8?B?TE1uYy9EVU9FRlFONWRsSWMvTzNydmNsZXhsbXN5ZVBXb0pHM01NLys5TkNm?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b121bfcf-ae46-407b-690a-08dc2e1744f5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:14:25.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxoKG8cY2FRwTBdR+i67/5oEuA5CuRMSOVMXp3Nw1BdUtIYrpIO3OCjB3QL8Gh+7HNCmC92Ke7so70VCRMYfkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772


On 14/02/2024 14:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Feb 2024 14:22:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.7:
     10 builds:    10 pass, 0 fail
     26 boots:     26 pass, 0 fail
     116 tests:    115 pass, 1 fail

Linux version:    6.7.5-rc2-gc94a8b48bd4b
Boards tested:    tegra124-jetson-tk1, tegra186-p2771-0000,
                   tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                   tegra20-ventana, tegra210-p2371-2180,
                   tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:    tegra186-p2771-0000: pm-system-suspend.sh

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

