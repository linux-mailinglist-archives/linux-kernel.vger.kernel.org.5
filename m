Return-Path: <linux-kernel+bounces-142212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1858A28EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F761F239C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF5C4F20C;
	Fri, 12 Apr 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cA/OfliP"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1050241;
	Fri, 12 Apr 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909339; cv=fail; b=aiB3inkWbJtqAsDT0f8DSnH7/0rSRqkoR7X5iZoAyqHhhjBxY3YFZjLTz79RdoepXItWpO85rQR+DmP0BTre36lAbDsnk0rWwFNszdCvvBOpO/ke3h+uqLHXq++YI1mSbjPxN2O7abSYNzmOHbUj5cbfe/F5pPgZ9WgLHG1BOWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909339; c=relaxed/simple;
	bh=vw7Hb6HjGQRmLBm3Itz1kJlFKwgRwquJtR3eL1vFL9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lrGimoxrtHrdbMW8VTxlg9HrUfMtZ6yxHNRD7vIUJp8qHMcXu+OvbZkuLbNq5RwZfmAJnlKe9eq40TwFaEmRrzD6WIRw9+qRQsbkQS4HSnT3Rh2K3RAXGFxbgBz7OSIr6iiXGDB0phJ2WnQx7515CQBVLIdThbvK4RfxjI2juUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cA/OfliP; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND4udzvPru6K++7Y+upzo2i22m9xlTewGaNFMJmm7kTyhJL8qy5IltST31yUpuTu4X5k6zGR1OO+j+thM/R+EfXkE3xlV+7V/GqxqrbZXrXmntuEeOrqeY1gfI7w0j1rDzDz1pXgXvF+z6Q/ijsjDXKO2omp6yir7BVFhpR/O7pgk3ig2Y796vjeV1zM2BiI9ot/g7GPw+SA06kBdJ9LEjd/YJ7rxJgkefmq84oTMHFc36sRxXEQVJHzC/JDjICKOiueo7x0CFkR00yOotpKN7WSAGFFLTab38EpOZVrFNyL1+OQVL0hMmK9dJ1X1AC713K44NdWT1Jc2O4enFQVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6FGcPuhhWojrGFCezqC/OvDpa15EOe8c+UbnCkpg5I=;
 b=BEjIi+9Vj+qff46I6ftSpI+Bp7y/La5VV4ZkCyV60vqXakoPIDvzqaiN73Upwb7WMae00UPGmzCEHQHe6bix5ZtTllTqZs9tppj+iDhZ5xazDbkVhqZcIEJY+8slezIY7Ca5I3NzwxarQKG1lsK7UI0alKRYXTSUJWaTnQc/q1VOvDofJ0WVRWlxRAMiEezYJooZDa63po1Mvb1LKMoFrgkfUSWX0jpNJJJTqGEXifnMG5y+bowVWbaZ9Eg+at+Ido3CJfLYLGYwG6sc0wQ7xPDj+dw1JyduVeC/TwFBr4IZse1WjBQViGOCj0ajg0I/lakKReS9uO8sPsIedj8zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6FGcPuhhWojrGFCezqC/OvDpa15EOe8c+UbnCkpg5I=;
 b=cA/OfliPkw8hgEq5773WrPh07+2r/1R4qdsJ+5/CwVnknKBISHFHs9N48rlQbN3cpvcmMaNRozU6gywK/twxIeibKboAIPjLjhmK38mbrOiDK5B62YpqInMmMvyutUPyj3vCEHX8tVLFSftG+yrmGShffM8sqB7iBFoZAu9igYe+xG9jjk4Z1cDAFkvYdGWxQJIv+QtOvtYTtV22j5YV0UL1bcJr3Rk5wkfFPcb4nWbFh6baojyXCOzj6aju0Vj3cfHLMHZG00fDP70eugaQXL1uOllvUOVz/GaEoSHcPhZp1nCTLYOHR2u62309+BMxrgHAp5VW0pGXYzWcdrrDgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.48; Fri, 12 Apr
 2024 08:08:55 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 08:08:55 +0000
Message-ID: <08a8187e-c4bf-40af-ab18-71e8809088d6@nvidia.com>
Date: Fri, 12 Apr 2024 09:08:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240411095420.903937140@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0629.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3cafb5-0a42-4c8c-e697-08dc5ac7cc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zsgxYLRM4rj5oJ7dY+2q+ViV06yP9OrAwNnzVXb4ChLWzOeJgZGJnXzJ0r2j+IbPDLeyjvlws6Vg6WyDSjZikRKb+NYe1tggbX2Xd/EVeB3Ymvd70wyLaVnuWAhzU5nqCgwWcqjjYk1NgzNGeaYOk/kINpwGvVU8mWTVG8G3RgRzDfPvvVtUGVNyTe2+Ek7kMZoUly2b29MdLkcVoegnIVtmvcmTvxQljNBnhwt73UjypPL/QDt1I5/5SneZEMd4dsxubNI3M5bwUDdY8hMdMhoInM8MZHpYDiDKRmf5hUcrS6JkbBXqDDVkA5FteaNus7wrSQFIr5fUY6kOaod9sy4hMh/v4CeXNgnOnBy3y+eggO12D2abcUNW+uKpjVcVLjv2h5LnHwQCGlkYgECnDw/8vXwGXJ+gmmzppXoWQrisqXFW29Yp7oAvDVbsihpu5L5lToLt3Iujj070uTGyTUyF7TlB5q+9T3jLPkUP3pQgFvzg1QACZz6aibnqBtMDZLX8Xyov65kBVHfgMC15Hh5poOi9k2Ojow7Yb2WhPolNtGzwUw47ENl+nFrKM8yT/iK0SSZfaT6w02sEC8W3JdoIgyNjinFt60EnFhFFwg5S+a5nXyl5kCKBN+ztTZi91gXYt/E/xLHyEbUO/CN3DZ6bABQgwlZv5Ewwt317eHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUJBa3krdG1JczBqeVRhNkp0Smd4TnFHSFJhTmhMa0xkZk9CQWxkMUhQM0NU?=
 =?utf-8?B?TnAzRVh3bjhNbVRvMmhVd2grVUs3TnYzRVhaVXoxd1E3bmc5Um1sQTZjR1ZD?=
 =?utf-8?B?UEFUOEdLTldLMHo4NmtaK1BCa0Nwa1JhMW5ONFFqV0tkbVI5NXpLSTc4WW9T?=
 =?utf-8?B?RVg3eHVZRkNRdTloVlAvblV2czhXTW5EWGd2RlpTQ2t1aXdmWmtkUkFuVnIv?=
 =?utf-8?B?RzBJQjM2TE0ycHRxSm5VSG8yY0huY0lVMkx3aG50VG5sUGZtZlhncE81MkZZ?=
 =?utf-8?B?UU1qaDlmQlBCT1lMWTdIUXhkeUpDMUdUOERxaHl0S0cvVWUrMGlFL2UvbUhY?=
 =?utf-8?B?Y0czTUVMdnBjejNHUmNXajU2QjlobnJnSHhmR3JBOTZRajhockYzWnJBemFh?=
 =?utf-8?B?UDltTGVET1JUSVRvaVU3b291MDdjSUI5VDRhOUJGbDFaWlVZZmN1K2o3dUZV?=
 =?utf-8?B?ZlN3bk91S0tFTTR4YnY0NU0vdjh5S3ZRbnNSL2p0OTN3d2xNVUFOdUYwWWVw?=
 =?utf-8?B?SlNwb1dBZjFVckZabC92aUUvbFBYR2tlU0gyN1FxZ2p5bkJIYk9YZEVudldU?=
 =?utf-8?B?ejM3eTluOFlKamdxL2hJaE9mUEhXYnd2a2NIZnRUU0dTNUx6aEpKTEQ4UVhw?=
 =?utf-8?B?WEdqNTlVaExUQkYyZCtpbG16bmRON2xEemZEWjF0S2N2bnJPbjcrZ01PeWNq?=
 =?utf-8?B?N2xNMkVvUmhsQzdpOUd2THlHMnJ6dDFDdzFLdHRSY0thWmR1TDBrR080M3Rm?=
 =?utf-8?B?RDlxN0w4aWZjcTJxcHliVWVCLzdKWnBtQlYyY0VkVFBJTWJSWUNUVjdoWDRL?=
 =?utf-8?B?SG1HL0lDb1gwOUpiSHNnN0pTRjlQMHgvQWhEYXdZaDQzdStqaVlDby9OYS9m?=
 =?utf-8?B?cmRNN3RublFwdkNPamcvZk5YVVlqblZqenJ6ZHQ3ZkJOZDQ5NGRLZmNRTEhq?=
 =?utf-8?B?aTMxc3lsRzMzUFlpTldxN0tPSnRvbmpxeHl1NTNxL0QrM09vMjZFRGtROERQ?=
 =?utf-8?B?UDBNTEs5OEtRckFZckR3WDZLL1lyMzdzNllQU0p4MTR1bjBJUVRwbHByTUc5?=
 =?utf-8?B?NkV1OWp5MWxOOFBEMk9LK0hFdjNNcVRvVUFjN2Y5a1kyUFVSYlNCdlM1UmpD?=
 =?utf-8?B?ejhHUzVzaFRhWmhKTVZ4RDJaWkNFRUVCQzUzcGZsZTVvYlU0dVBnenptb0lz?=
 =?utf-8?B?YmJMVk12S1hxSFAwc3JBNGJ2UnprSU1ZcUZzOFRFc0RyeFNSWktjQlZBcW1Z?=
 =?utf-8?B?VmxueU9DQjdFTlFsamxNbDA0THljNVBRdTF0WTZrNkVqSEhKUEdqZnloMExs?=
 =?utf-8?B?cDNhMGlINzBTRk4yTE1sQ1MwUGFMR1AxSEpSZzhsQnJTVjRJc1hybXRMOTFu?=
 =?utf-8?B?alFxdHFoaEVUVHMwLzQ2YXJpZmx1YmpIL0xyYVRQZEtBL1VHTE1DdDFWQjdi?=
 =?utf-8?B?Z2JSSlZWYkduWjc0TFBlV213ajk0NWE2QUJYOUhIZTZncnZLSGo0OTN4eENC?=
 =?utf-8?B?REN0ckFvZFNSbnB3dlRyK2tsQURBckg1K1c3VC9SVStjVWNLdnZRdWUybXpT?=
 =?utf-8?B?VlVkZWdDakpQMXVoK1BNRVB4L0VoNHJJa1dEc1NSWnJpQ09uYlNXTkhYUTBk?=
 =?utf-8?B?bElBd29aOUpWZk1QT2xKM0tScTJjWlg4N3hDZVJmN2cvekdUYlVtMEd2U1E2?=
 =?utf-8?B?RlB3dlNUbFEySjN0eWd2N2JHbDlLcG5HZkFLZ3doVnFlVFZBZlg1cXQxZTZq?=
 =?utf-8?B?M3VLSFROS21HL0pZZHMvZTVJSU40aXlrYU5EakJPYUdyVzlYdVBVOU40Rjd4?=
 =?utf-8?B?S0hXSGNyNkVoT01iZmEzTzBZc0o5MDBPaVZEZklvbmp1aVIyTFptNkZVcGlk?=
 =?utf-8?B?NXEzY1pyNEMrbWZlOXBqakR0enZSOThhdkxTTjNkVHJRV210ZDhZUHhoVkoy?=
 =?utf-8?B?SXFvY1dlZHZ6dG1LQ0VyWmtDcVFhSTEzaVNxdjNlT1gwTGkyY2RLM1prK21R?=
 =?utf-8?B?R3VReHN0MHFWaURqbFR0R0RwZU8xVFA4aklGaEt2MjlkNlkreUFTaTZIUjJF?=
 =?utf-8?B?SXlTbGRHYjVIMTY4TkFMc3hwYitKdnUrODA5Nmc1STlzdmVOR1NSQTJrdGZC?=
 =?utf-8?Q?7KJmJxpaiRXWcOL8YHjUq0XMF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3cafb5-0a42-4c8c-e697-08dc5ac7cc10
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:08:55.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdkPYQcJX1YnwInvodpg5XoCIYj2vIAIUsMwITFM5xqkrSqTXx0GNo2R5A2MRl7/JgEo/m2Pv6zlVDuTujwoVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762


On 11/04/2024 10:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.6-rc1.gz
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

Linux version:	6.8.6-rc1-g1e41d76814ed
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra194-p2972-0000: boot.py

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

