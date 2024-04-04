Return-Path: <linux-kernel+bounces-131209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECFE898489
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C57E1F2AC03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2174E10;
	Thu,  4 Apr 2024 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XMDwqsXq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC35D8EB;
	Thu,  4 Apr 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224839; cv=fail; b=NPG+C8jtZCJZvKKQc4vhGheRIbM9UBQfBS7s2YkgDTYqY/yHDO70zinZdqacvrvaFAVH6GGQ3bEPnVZ9tUqVpx88k44WcmdMLstPoIb7o14ikhLD1rPJkIlgUABT/XXzrXCjUHaBtGDnb5iAbSfGUuoFv0gNgRlVz1WjiydaDrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224839; c=relaxed/simple;
	bh=PMjzaJo5NZdBYchU0fhFSPGwEoTY6vNH7A3WNv1EIA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kj6W0idBfL72SsPuN43bkW+gJb1BR7x26CaMFle9bQPjXJBZTquC41mPT/jAJ53rAhIUThTUmKZWw0ysGzy/HV86E3HGs2zaUjuY2gWydtakj12zEcb0d0Gb3yDCf06jYz090FN2M686Cef5WJAapIQBtplnRxb0onZPD5q7zco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XMDwqsXq; arc=fail smtp.client-ip=40.107.93.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlwMLnRayQFYgORjpaBhA7xsfN9dRlBVZPBrfntnUIbUm7GRmnw3qmGZgjYqoW9Ap1KyoC3El1pT6jUAyJw0Tw9bIrBi/XpK6K+jJjCwIPwuwFXlrHprg7KBNVbE7zXBqfQzWmiri42rdLDuUCQknPzRb1qq9nALgOuLP+HStzGQ8VuUNAcfAqW5FrO543BroEzvx1Uz4mBV4AK7XecG0g4fhNP2zhXnnoB1iYeow/8BO9yNYdb2O7NmVcPVNNpG/uvn7JGRK/+h02/9KWAJO/TH/xs9q6bJny1BUesVyU2ZczyS8TvOuGaMHkoo3bT3/XJNvHBcZYwi39VPV4WBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAkTGgbLe7vBVCfg213APFu3uOcJe/fijStPXsDKlUc=;
 b=bkJGoaasBh3cbVB0gfFL3qdn2r0GJjKVud1Nh40B3BcNXsaUrcl3lB/Zb5DlNZmgonN6FqCiUPknxUifJWe6/QBjkcy9AWV2CWYxDC1gNnXg+uz2fBK5rdH+gohNej/S3OOY0OGIq0utwYqV/EDXZh8IvS9vwDgGuJuMHNJhh7nXPCh0ukfA/7jEAOQSq6YijIZqhcHg5FFwSrS7OCc5H8M61UNmt84Vd933V613tL0e3SQ8ZDn+QvhPsLxh4nUJ/jerA28ndn+N7l63lvqUPT/4FjQZA794p8JWi2QuZBmdGgoGW8oLx3y/KeqIu7JtS5ldqhgGo2qSq6y8p3hgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAkTGgbLe7vBVCfg213APFu3uOcJe/fijStPXsDKlUc=;
 b=XMDwqsXq6MnmkzOF/6sH1r3vJNxJh5CJ4XKODzggMEXJCoQsCV/EllENCvuJINJ7W4Klg34ezzBcT5nFtMMIO/wbGR5pz2UULVLm0aElAkWGpTvkz8Co6gbihu2nPs5o4MHKCqcTA/fwwqj+SdoeUeNZ7pkQkP5KOixeYL6pSWnazSVON6S01wmIXSqgy7zWowR0QtTAdJJ4wYVklzhvKu63Xh30GYl3s/o7S0MTOOGSjXJY8cGXx0FmK4E2cYeeDADMcF0iV87Znp9XHe2wByJpXywqxR3WLriE7MuSgIk3qIazPV2B+HxnKoQQNpzcfXk+xHN1QDxaemEbd5XGYw==
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 10:00:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5159:5fc3:7933:24c0%7]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 10:00:31 +0000
Message-ID: <e922dad7-051c-4fcf-8b3f-773645bbcf63@nvidia.com>
Date: Thu, 4 Apr 2024 11:00:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240403175125.754099419@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240403175125.754099419@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0387.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB6067:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JGNCX4y/yC0wJKw2if2yx24pTiMqx5FeFiX+ZG7YJxpZK/kgcnf6kGSGFiNw07+QILwmYq0XERTQ59NgWAvyOvKm2LUiSnn3x0P2nMR8xl3S7/huPpbYrCGEsdX7LxjAWSNvb36OLad7fi2djqBJ6wz98vW+laUtPE3YwJ5rBM9qjzhs30AmWNjqqSHfuocQt7v8tyqCoTws/4rIN12VBDkQRlsRxnjGtHYE2FN3juY3gwpGhmv3ax8Slot/2FvVDLi0JxqV9z2UpOuhwtvhjf3N1iIuSpBLv2J+ESgcAl/RALIGiUxlGxRT01CMpsg1+o5HOtObxgbBA3W/CcWWRRhz/OKf75SsVeYc2A0p5T6jrtr1cujqy94EhbZJ1XWSJfc4x5G7YsZ/ht9GcsE7GKKHMLKNn5bEYfo8gl3ANx+zqfJMeTOcFBBxDgCHUnroMgzLhj4n0ADkGQl9nSWwWYP4VBOfiz0zlw1fZZuNM1XTt/OKWMGckVbYtqHgSBpO9/Js6acTVlfsNqGLuNMosQPw6Ef54qCBTtBVtdWgUNlaO7tJWbKwL1vfh0KVqXxc9PJvvvlJY+pITT3DB9TPd0UPg208zETBUlBiQfeBJQgJzmyn9y34/7oWHuc7PqQYqD22LFJcWk9owNTSpJYHYtr+a1M6UoYjR0MktFcW+JE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3B5Qkc5YVNWVXpzdUxzdDlRSEkrb2Z6NDU4V0QxWVdkekQ3RUVQcUdzMzV6?=
 =?utf-8?B?VForOWJZazR5N04zYU5laFI2SHJTK3dwcnA1Y2lnampFTmQ0KzZyQ3dscWIv?=
 =?utf-8?B?MWRRV1JyRHlwRzV4ZU1FdzdrV3NSK21tZmNjSGVFWjQycUxGRnJnRi9PcTBK?=
 =?utf-8?B?dGV6ZzRwdEkzUHg3NzdldmJpVHZhb1NhTVhCM1JaaitoN1FNT0xwZDFoeVZ5?=
 =?utf-8?B?aVZpaHVZNk9jOGRXcjhSWlRtR2RqSmZaZzRXdW94QlhBN3ZMSDJ1Z3oxOVlw?=
 =?utf-8?B?Z3FucmVlTWdBbE84SXg4WFh1aHlySkJSM04za3J1UTFOSVRwcE1xTDNKYWpQ?=
 =?utf-8?B?UHVHdHExV3ZkTWh5dmc4RWxidU45YVFka3N6NG15MmF2ZUlwbm1SL3FoRE40?=
 =?utf-8?B?OEVYb3NjQU1JQlI0elkvcEx2VXN0VmhhT2NVTzNhTk1xWU5QT3lOSzR4aFlE?=
 =?utf-8?B?L2JHVEE5dk5kUFM2eitRSURZMEhwbUtBOEw4bjBHNzBSOFNyOTRDR0dReUVI?=
 =?utf-8?B?ak1sanBxc1h6U1d2WW5mblRPK1VTbXdZeVBzaER6azlRVGJDVG9YL0VYMVdT?=
 =?utf-8?B?b3VGY0JyMmo4QURKQ1BjNDNIUll2SjJxa0p0cmNTd1doWVZxaFdNRlFjcFRk?=
 =?utf-8?B?cVNlZC9mM2sxckJLL1hyVVZPM0E5QVpzWTVhUDJHZFh6WGdNcjZyTkxLSm5t?=
 =?utf-8?B?SjBqZkpGamhObGVKNXRUMWEyMjA0d2svNlYwUGcwQVRtbVRxSDd2aXF2Ym9L?=
 =?utf-8?B?VC9abkl2ZEJvQUhOQkNqWldaN3hpUVVzajI1OE5UM1NxRzhFZ1d6SzBQcjJ6?=
 =?utf-8?B?NlZkdk5kTXlqWHdwQW5hQ0FyMThPVEZ4MmNwNWR3MXF2UXUzY0R5TUlOZmtY?=
 =?utf-8?B?SDQwazNQSUZKb0poWlVMMnUzSFA3cG44clZoeVcxQWk4UWlaK21qMmhNd1Fl?=
 =?utf-8?B?elYrN0hxYm9hU2h2QlJuSVQ5YmxQbG0vSFZCWUhlanNEMjNMN3IvL0NuZVNH?=
 =?utf-8?B?a3dURGZuWEdQTWpXcjBWdTkxTVVzOW1kZWcwc3Q3NkdUYVpGZEJOaTZpQVpZ?=
 =?utf-8?B?dUhGblVJSzJIU3lFeHRjMnp2MVdrK1VrWDhBdlduV01qRVBYTjkvNk9BeTlQ?=
 =?utf-8?B?WWhsUVhUbUQ2SXp2ajE0Q2ZZWDhadnVMaThjQ3dWSmMwNnFYZFl5UG9RbHJ1?=
 =?utf-8?B?THh6TzRMTXZ0RzZxVU0rUmNSMm1HMmZQT0M0dW9wNDU5Nmh3T2NJMTg3WVBC?=
 =?utf-8?B?WldKQ1o5VmpvUVlXdVQ0Q1FiQ2dsK29sa0JGNWFOZVdwdVNIU0ZRVGt5OGhI?=
 =?utf-8?B?OTgvQlRxTmhoL0pzcXVJd1R6aHNoOElmeWRmZmVyMU83cGxXRW5rMTVVWmRi?=
 =?utf-8?B?K3lPNFNuMXMrMnJpVVJlWEJYSDZTNmFyU0I2ZDNpN1VmUWNlWGJ1SWtaU0ZB?=
 =?utf-8?B?TVdoUkVnWUd4TzFGNmlSanFUK2RDZlJGWXdDbjNhZHNDTzI3TnNQOEJGNUEy?=
 =?utf-8?B?T3Z1VUZ5MHlRbzBZbmlwTXJRNjV6cFI3YTh5VzBYZ2xkUmRpQkNLNUFXVWxC?=
 =?utf-8?B?czFXVzhMa1Z6S2p4OGZYcnhQUnVWSkVyVENhVFF4ZXlqcEczSElnYmdORVd4?=
 =?utf-8?B?bk9haXhNZTFPV0JGQk84S3lEb3ZXQjBvZld2MC9ETU1yaHlTbWdLSGp3Q0VZ?=
 =?utf-8?B?NTNGM053WkE5ck5RN3NBbEhkZ3lOV2E2MzFKbUliWW5leURLTXNaV1ZRNGJn?=
 =?utf-8?B?bTQ5ZGl4K25kekQ2b3BmSW5xYVJQeVplSW5XbytmbXhDZ25sVG5ESG1DSnlw?=
 =?utf-8?B?dStwSEJES1JjMVk1OUE0RVpwWnI1dFZ0cW9UaGRiZ1E1Tmhsbkx2bzArRFVR?=
 =?utf-8?B?UXZhYndVZmd6S3RCY2FEbExOakVOaTJObXpySGIyNC9FRTdhQk5LNTJQQW9t?=
 =?utf-8?B?cUxxdW1mdG1uMUZLT2M1RksvaTRnZ2VNOEFmMFVwWGJEbW9uZ0V3c0c1aFBs?=
 =?utf-8?B?V2cwd1FBZUdOWURCTGhMaVoweUNoc0x2d2QvWm5xdVZwTm1RanRlY3lOdy9z?=
 =?utf-8?B?RXJMY3hhN2gvQmg4ckFkYjdHalhZY0Rsdko4UjJBM2oyMldPQTAwMkJWZEpV?=
 =?utf-8?B?ZFFWSWxpR1dxa0M3SkJnelBLNnFEQVNPUjdvcjcvcUJZeE16OCs4UERZcXFC?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f513d-4fb1-48a5-83f3-08dc548e1066
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 10:00:31.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8gN2Ib4rqHw/3/EzUHwNT4R0JqO5Qc3FtiNx2OLWQm7WHP8J2FtDY4I8wMjXSAAW3CBg7Ut1E154suDHlbwxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067


On 03/04/2024 18:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.4 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.4-rc1.gz
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
     116 tests:	115 pass, 1 fail

Linux version:	6.8.4-rc1-gc4c57420c666
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra194-p2972-0000: boot.py

Tested-by: Jon Hunter <jonathanh@nvidia.com>


I have asked Thierry about the fix for the kernel warning we have been 
observing on v6.8 that is causing the above test to fail. We are going 
to get this into -next for a bit more testing. Once this lands in the 
mainline, I will let you know.

Jon

-- 
nvpublic

