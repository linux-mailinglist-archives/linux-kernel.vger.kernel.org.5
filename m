Return-Path: <linux-kernel+bounces-36792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2183A6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584371C21C61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2487318E2C;
	Wed, 24 Jan 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GIPSV56+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8101171AB;
	Wed, 24 Jan 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091919; cv=fail; b=HqhpIQgrCi39O6fUvKVOSYywD9dn69EO5UXROMzhfp2fQ7PVJCcM832sEXD8R/0iq/IcU4uO/Einq0nl0Bbb2uD4Q6MKqQNz/v6ywyv5tYyIZ9p47xQTLV1oEe1de0QCW9KIl7trLdPozxYoILkiPjOeVbL7bhocLghlA+9NUSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091919; c=relaxed/simple;
	bh=UqjGccZsAVN0Ol+n3orOtwUCN62aYfRhiUwCZLr3SMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CwUmWPWzXYwv+7wSsIKy0+JNmgS5mKKPSuJvCg9qFnxXiIeD1stsbpGhRzwTDzOS87AdrKrHfsFl2Z5zFFhJxc+P0cF1DXPuvPrYvsuPdC5zAONtBSc+pvnBiYzPtBNiQHmj6b3RcSBuSzz7vSDgaVGLwjUl16b9TpVeaKMMFTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GIPSV56+; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUBZ4CKI3EJ48oNvv4R8TMk+qkKJaCmR6zRBjTl4g94Jzk8vjJHNium01DTMa7J3ZU6nU88Z3tNw/ogoazPIsWzVA2AZCR6SgXDteHhD8PmCM5nA9G8vulZabGbdcteKVTASlkz0yMd8E7RzJQl7Z4dryDkkcy20xJO/RLnkKMBo3R9AybVOEy7Soev1QKiwfjVzMzBa3SxAME7tRvJct8+TQK0AtA8dWCtGb6ivZThMXvEXt42VV7uiISnmo9EyKGNo/oCh3SLDJQ2NrJ5SgyOT1rAepgcohaFr1IvKg3j17Ff2fC5jaN2dT5Bz7I8UO4iSb+K/nNdcAMGOAWfz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrL64ftIf7zaREEDjRpxeh1ClSRQUsfbhpfyT+2Wnbw=;
 b=PvFkGFCibMToHavVdDtv6+8WRFl9BxvlxsLOSA8USOZZ86Ng1zojxlyWnSIgCcfn7FhcvXEGw24KFbJui5wGae5avfcc72aU/5eYQ1jzO4YGZuGsrBXM2iDxfx+sDM53qsMfS/4qW/1HG038qkyf33Ei3a9818If5h1JyYBsg4Cd2WAAHk7tGJ997IBIBzFB3Av97Eh1D/nEZwMdlWOncNBVJwsJiq28ktVDH/ymAtjz2MCZZNShFH1WY3UZ8FLhqh/M6PGlLwjlOHUpEsVavH177OUWvu6nWl1ytFkJIyFk5VfuSxUpT1Vuk/0Yznm21NJBa4ghMttfisd8Gs5XhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrL64ftIf7zaREEDjRpxeh1ClSRQUsfbhpfyT+2Wnbw=;
 b=GIPSV56+KVfgF+hcuw6aFdgUBwXv/mYx4wwUGE4xfZHdvDGQJQYvL0XB4f5hvnSMLdayPE8hXrxz8BDBxlJHtG8OYKehBmFDNTE3A+4Kl+kZ5jkHhiV6fBc1AvSGeFIQXSMBZyDDbipyHvDBA42fDo4aMt4/eJxuPxQe9gTwXidO7VbfZ8yUI+fQailGCSR0uQssQXj7ZYp9BzFDX9a2LIAqmXHQHFhhxGwnjLkiZ7NS5AqVPb6LzAs0jecm3urAMKRuBYcu+k9ngri4zyGRyv/OSvJocFvPcJn26Zj1VVwIL5/jrhHUpJmCgodlafd3s7UXxPFB74JCGctY8+3ZIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 10:25:12 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 10:25:12 +0000
Message-ID: <a856857a-e4ad-446f-ae14-db004ef95dbe@nvidia.com>
Date: Wed, 24 Jan 2024 10:25:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240123174544.648088948@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::15) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: a24d62e8-e22a-4f50-f421-08dc1cc6bf56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xp7hoMyLctN2Sw7iKn2nuMAVTHLxbB1GWjSVJX+07pYilMCOPjz09dxDFsNodlY5o6k26ABQ6/S/4thp9sHTrEmhdZ5V9LQfUj4WkB1lMgsbm9Ak6Xzsn34WPj9hwdsryPzoaZcpXRjFdpM3dM/ZckNP82QbzTapZbkPD+gUvh9mYriZU5mHAAGheTsRwSXS9muJMUi/Vi6S/0jAvxjICUu9P9WpFWh6iKHGg6EACg1BQDE+d14bNkVn+CIGrAhwxSHWlJpLjdYbyrT2dpdi+7D9pGecRa6waFrlNi4tIKC9oivykeJWdaO8Z5IeuHGC4Elc3AIIzIdwAIkWI7pkPEKzvhdEs2iBiKYQqJLDz9WD+vM1HT+A/E6MESXqptywi4ib+W7T0O+9U9ydj24l/trrRi+wQTOBT3uPoDmhnlC8FVHjm3MSHlaVfgB3tNrCypU7Y18eIJuoL/tKjZFjI9pBQ9HCxJ3OWnQr+74iPQjmdwvoTXIhuEb77aXQGJZ3/Cyxs5ZdiMZZ5dtzL1+Z9Lu2UJewmVmX+8os64jOMIWCZ/0A3fXaxxxJ32JjQD+xM6Co+wnXRnnsZ9sPYrIEht44He59GJYe/j138HUPRFjjom6SBJpQ39nWHnx7G9foXMnbWATNak6bFio7yfcJs4n24MOvEOUdPoPRzKNX5pmPdeGIuGJYFIG3x3Wzi19k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(6506007)(53546011)(83380400001)(6666004)(2616005)(41300700001)(8676002)(36756003)(4326008)(8936002)(316002)(5660300002)(7416002)(2906002)(66556008)(86362001)(66946007)(66476007)(31696002)(6486002)(478600001)(966005)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0k2ZTQ4K0F5aWc5Y0VkYVBkbnFXbWc0Q0o1Q3F0cHYyVGZsZjQ5MHpMY3dJ?=
 =?utf-8?B?b2g2UURaT0psbzY3UEgrOFZKU2RlUVV6MWloczZaSlNESmR6TU9zVE1CUUIw?=
 =?utf-8?B?TFZKYlNNdndGUHplcVVUUVpJSlRDZ0ZlR0hrOEN0V3B2UllQZFNOamxqQ1Nw?=
 =?utf-8?B?RUZlTVA2ZjhKaHBTNzRMV0NpQnlQUW9jRHZhTlJvS3BYUjFVMWFrM1NaTTha?=
 =?utf-8?B?RWVzVnY3d2xnNWxFUjVwTTdGTWNBQWM2Z0g2eDEyQ1hMQWhFZkNGcEdHVHF3?=
 =?utf-8?B?ekJWejgzOElJRFRka01UMjRnR1ZZSG8vd0xjMGRBNFZrWnB5WFBXclJTckRT?=
 =?utf-8?B?Q3pWM2RjdERGaGNsMkNrWVpMU0lOc2RzdGhyajhVYjNHUFlselRQWUNmbVlN?=
 =?utf-8?B?eHlaSHNLUzRpaFBkMmZ3QXkwU0YvV0MvY0N3dVVyS1MwdzErV3ZDRGFJU2dP?=
 =?utf-8?B?UE9aN085MlYvWWlFZFdSY2plemYvK3hJQnJsU0NpZU1mMVZqM3VxVmVSUU9u?=
 =?utf-8?B?bmtqTFlNVTV0Tjdobks4UmN4emp6RmJhdE9OTW40bGJ4UmhHeGRXNDg3MGIw?=
 =?utf-8?B?TUIyVExMQXhDek95QkxLT1lFbSs1MG5LQVJ3L01FbnhvUzdhRDJVV2szaVo4?=
 =?utf-8?B?ZXdLTmM5QVl3L1NFOVF4RWZ0V2gwVDc0VWhDQXpvUElWS05NNmJQdWxHMEx1?=
 =?utf-8?B?NkEzMGs1ai9OclkrSTlSbVBYeWkxNE5Fd1pxeUFaUzIvZ2NWZmZoN2xaK3Bs?=
 =?utf-8?B?RVQrbDdQcElxN01ZUHdNbmJtcWNvdVV3em1lODA5RjF4dER4bjdRclN5NWhT?=
 =?utf-8?B?ZzRDWklVVmYyUWl1aUNKandyOTJXaE1HZnR2d1dSNkdDZHV1Zm96UXpWRzdH?=
 =?utf-8?B?RDh0dC9ONG9GbUkzTnhWTWY4ZlBCNkw2eWM5QW9CT0RWWk9EU3p6Uyt5Nm5i?=
 =?utf-8?B?K0pmVytHTlhrc1pJeHVpNFUxR29GTkdJSFYxSDJhSTRhR2ZJYmtxQUtXY1lX?=
 =?utf-8?B?bURteUJMZ29DV3lzcS9seE8xejBMS0RjTkp0UnpDQVpHT1RYakhYN09aRWJq?=
 =?utf-8?B?YjlmdGxyUThVeHl4U29GRG9NYW9rU3dabCsrb0FFZC84VGFxbnU3NlpsWWhv?=
 =?utf-8?B?cEtTaWZpblY0UW53aUdRR3VDS3A2dDVlcFBQVFBncm1UZ0d4K09semlBWnRj?=
 =?utf-8?B?amxMeG1Sa3BWbFpnV1ZKbnhEcWdqRXFzdnRkKy9JNlpoNnI0cVJBT3d3eVZG?=
 =?utf-8?B?c25RS082WEVCZFhRWlVDQ1N2eGJlZ3RtSkFOUHh4bFZkVzR1bVl3TWNra1Vq?=
 =?utf-8?B?OUpCb3QyZmRKaURzN2RRU0puUUVnL0dxbjBFcElIcDh5dVJqdVBWcmMrNzNo?=
 =?utf-8?B?Rk5PYUNFN2V0Y1FjM2o2OWdBTklQUjdVL1R0Zk1OcXNQUGtxN1k1UGtUQTNk?=
 =?utf-8?B?MGYyYWdWQS9Md2JIdFA1N2F4N2txdE5FM1gwUmN1dytObURhNlZRWGZWb2M4?=
 =?utf-8?B?a3Bob0FOaTkrQ0VRelcrVnc3ZVNTMzFPOUgrbUFkMU1EUGVaSFFyNGo4UjVL?=
 =?utf-8?B?Ym9yZnhkcGV4ZE13SXN5RTNMckNSYmlkZDl3VFh4WUh5WndrUHQvYUtkKzda?=
 =?utf-8?B?a1V2Z2pYck5adHhpNGo4Mm9TY2wwaDJ1Y09MakhOcE1lcmtuMnpmSjhjNytu?=
 =?utf-8?B?dCtsOTFpZEZCYlFQMHRMK0Zqak1MK3BOQXhoY1htR2NxTm45MjNpRTA0VnBO?=
 =?utf-8?B?Tit5V2NSWEpub1RTNXM5bS8xSDQyZjRFMmZRaVJqNVE2aUhuRlQ5TFIzNUl1?=
 =?utf-8?B?bFE5anE0ZGFxdkFTUkdHSk05SUsyVHRRaG9jZXI5aWtYWlh3UGhNeDVCaEY2?=
 =?utf-8?B?RE01aE5iWlllT2RDSVdIcWVXaUM5aDUvTy9PUGJxc25DekFEcHFCdlpIT3JW?=
 =?utf-8?B?YmJCb2dMaWJ6R2xhS21xOWtUUCtHL0RLalVhU3VjZjE3T2dSOXcrUkRhMkFL?=
 =?utf-8?B?aVFZRXoxbU1YZzlMSjRxRkswS1NNSndkTFZrNlNzSll4VzhMeDRNV3g5VzFq?=
 =?utf-8?B?MGgrdEYzM0p4RTNjM1VqYUtKRk9FMlRPNHZ6T2ZQaU5pUHFucktxallPVlB3?=
 =?utf-8?B?eElxeUVRQlcxN2FCQktoTUNrM2JvV3V2Q1FXLy8zN3BXQ1Y3cEVtNEx1UmNL?=
 =?utf-8?B?MjBkRjNDSG4vZHhqS3haMUt3STJhTXdDMHhmd2FVQTdaeEVCRnZYRkJUR0lO?=
 =?utf-8?B?Q1F5S3R0OHVRbURaZzdsaDJhWnlBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24d62e8-e22a-4f50-f421-08dc1cc6bf56
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:25:12.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxP4Y4Rr6nO6IvUTTMHtRQCGwJp2CCebKMOxNAcid6r4rbcm6JVeX/fEod5cz2UqRV1KhoxvlrvJtmesJiIKOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266


On 23/01/2024 17:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.2-rc2.gz
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

Linux version:	6.7.2-rc2-g2320541f64ba
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

