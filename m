Return-Path: <linux-kernel+bounces-165331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9C8B8B5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DEA2830B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44912EBEE;
	Wed,  1 May 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lDPWpd9Y"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705B12EBCA;
	Wed,  1 May 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570738; cv=fail; b=IvWj45R/AbNQv+5z/ANmyEgMiaSMzFE4MdbH/tvq23EIJ02cVsT77bf2zvTGkXaeSZHxMgoZOLTTRK3TaKJrfw+eI1hSJ+uIszrdsRLJkdyb8IBMsFYnfjmq//oLLhhIQPmliRY++mSWbZB5lILsXwcOrDEINbajGPfq4Kjj73k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570738; c=relaxed/simple;
	bh=A6hU5S3BDf8gXAN1ltPRjt1K7NB9p716Mp/NpDkMfcA=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=TEC0piEMxe5Y6HfG/DJ6pvJCB7BgPviLGkN9IPV43VefDxLfgpr29e/H86KOAJfcz8xEOhj1SpUHsQZNZ+ATr5LE0dpjMhfjMCHfHp3Ogu5H3zUmXVY4fDlWxVozwKkGSL3/Zasft2gr+GINB8RmtWXgxt/qgAyuaTRt1gx9elA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lDPWpd9Y; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGZ4vgnYhkg4lONsZGMkr/58PKAkM+Pe6tAT1tKBt2QFaU4346W9fQxZoIDl9JjKdV+w7liyGjJ9ayvrah4gL8xfKJooyC8d5+n7roY7RtBLRKtBtKhh2SR9NhrhNukm9Zqgu/A2eLtvUMzryk2Pdt6ECHn0gsBhA3M6GgjVm0/lGeqhA9gSriIsEfNRTPch6+mVEMwR5e+W595dE7nRj075WdLDZF4RxWQUnUZ+j8PfOG91qwKfyOwtvh4TI4YHUEmRjpAeQxP+etCYNEjeEBJzZwAYHiNx8P8l3DFZFKpLm3Pb2eJpW/dwwqtYewPMqMlwxNA5E8Mw9EtGRD6WQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQvWZhn5jyibuK9GgPN5pZujDY0YwOesP8accLMMw+s=;
 b=igw0OWZf/zcS+JuhuxE6b5THSzYrAUuQZ5HiPAk6RdnePbRRdjQHB8bUiVp9mgFGzVgE3D2+JObmMQw+Uy1BVhWbIC6WVLjG/cBiA/0yBgGtHwH1u/wxy6i6haX3f+hhh0dJYBR9yYdcx7LmMUGfkUisBkFdhbD3VdEz5hlfzxS3btdmQP6d0nh5eIg/bCv0wxHxaFTW9IQspmZbK6SxHAwPwF2B1roQR/uJ76DDJWlso6a3mJAB4JxYynLykXELKgx6TtsnVXy57oiEvK3lGKxeCbg4m4FX6jbLeCV0rBokfQkV2V8fgBQmvJtaScDpPTdc9zFJ1iel+VtI1w0IdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQvWZhn5jyibuK9GgPN5pZujDY0YwOesP8accLMMw+s=;
 b=lDPWpd9YtbdsMPYu7LdVwnHEwGILA7KbMYeEJntdbPenUvV14fMVKmXGuESHnqkraj3yWkuCcDkMWdrcCQYNaQ2ghy9UuK66I9Zm8If8N7gR19E1a2/60snX2XIOONq2MsrdtHOMgPU9h5soJ7UPI3FCMyVSMswVm9Ygi2SKfcCv6B4pmBhd6FxjjhXWZJygfZmcwTglaNPgQ9xeCGLpUA1qSa7t7q1KwxMrSM09O8t0DfyyvbjcIsVDlqbwjE8XCgcrQyUpBYa2YVMdmCW7jUfMmnXyJ1FjeXbBY7Fl7DlZPYUinJZH1sh5QDNAAwpvirLyD/Ez15o5MgptCLpUsg==
Received: from BL1PR13CA0407.namprd13.prod.outlook.com (2603:10b6:208:2c2::22)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 13:38:53 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::f1) by BL1PR13CA0407.outlook.office365.com
 (2603:10b6:208:2c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 13:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 13:38:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 06:38:31 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 06:38:31 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 06:38:31 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
	<broonie@kernel.org>, <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1aaba541-25a2-4e8e-b27e-c7872f8a71c7@rnnvmail204.nvidia.com>
Date: Wed, 1 May 2024 06:38:31 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: d120e28d-2aa6-42f5-16bd-08dc69e40aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|7416005|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGZNbkM1Z1FmZDdxN0xVRlNYZjJEMUVTUmVGOGJ6MzBHRDRrNXcyNm1YUzdX?=
 =?utf-8?B?U25RTEpDME0zRlZSd2Ntd3EzWnRGbHBTR0hZdTZkTnVyWFpkQ25rbHNXTkdr?=
 =?utf-8?B?TFIwcko5U0Mxd1pOKzVnZ3RnQ21RRVphRG1uK1FYV2Jmb01IVmFJTmFRSHUz?=
 =?utf-8?B?bFp4amdPaWxWTWU1Q3dLVmZFSERLMUw2eE1nNk0rRW83dGJGeHBseEkwVkpF?=
 =?utf-8?B?NFhLcGk5SnY0ZHJLT2IxQUdIWGMzYVQwNFppb1g2b1ZiZllXayt1YkplcDhv?=
 =?utf-8?B?di9nbXV0V09BdElnYVBVVzFGZUY0TjkvMFU2L1dYRkJiYWo5WTNTWnBkQzV3?=
 =?utf-8?B?bjhFY3ljUWJDeVFXaXlRdTJiWEQreGtaSHhidVZROGRqa1JYLzlKL0Y2NG9m?=
 =?utf-8?B?bS9sNEJBdDhCUkRKUnNCMklzTGR4VkRsalhsWlJ6ei9iM1IxbGxjb0l2RFk0?=
 =?utf-8?B?blJiUUQrKytRbW5uazl2bWhWaUgwMnBqMGRHWVFkckNRMnVxMCtHVUFTRGNJ?=
 =?utf-8?B?eWxWMmhVdnVyYitabktpWEY4d0pCSXJLeU9BazVZTDNwSE1JSFVlUEp6SWFN?=
 =?utf-8?B?N1ZMV1puVU9oNXlZSG5iaVdSTmt3VEUxSFd1LzB2VjZvVWZ2bk9ITFhOdXB3?=
 =?utf-8?B?SEI1djZjQTBFWitZeXVYbHNaMnVUbno1ZTg4ejRGdkhlZEhhaFpGUVd2Wi9n?=
 =?utf-8?B?QitvcWZaS3FBamFCc0wzaXB6RnBUNEdtN1NaOHlEb0VKTDVzNW9MTjlFNEdq?=
 =?utf-8?B?UXd4cHN3d29jT0R0bmVweVdPeDRORk9HVWMyRzQ5aUVIOFlQMjZrU3A3bHVO?=
 =?utf-8?B?UnF0N1pFbkFsOE1DREhHVG9OeUx0YzVja2JnTDV4TjdrMW40dXRpUnl4WUhM?=
 =?utf-8?B?bEppVjljOWtBaXpPcGdxWmpMdkFSMHpSRExrOWNQSmJJQTRSdFd2TWNyRzV2?=
 =?utf-8?B?NWNObFExdVpaYzlYTHR1clE2VUlJNDZVNkpZK01nSTJuQjk5RmpOTmdvNzRa?=
 =?utf-8?B?QkcwYkJna3RMMU1aWS93SzRyelZBV0tCTnpCT2NJb1ZKQjFCM1JXSWp6c0o1?=
 =?utf-8?B?UHZNSC9JL2JXMnhBMEpIZEtMejhHbU9PZUs1STdOVzgySGplVW1qaU8xMGhD?=
 =?utf-8?B?a2JyLzdJbnNER0wxc0NacnZ0YTNncmxpRFpMaDQwb3A2c3BwMldUeW1ySnV1?=
 =?utf-8?B?QTYvaGx3SEpxVnVnK3F5b0lqanY2QjFtU0dBaWthaUFBbmJUVkJpZGFKQk12?=
 =?utf-8?B?QXFvMUJaN3drOHkxYVhUQXFDVGpxdnVITDh6dXVWMGVxQjRCNFpMZmpIdmF3?=
 =?utf-8?B?Q3RXTFBjZkVLOXZsa0M3OFNKckJ5OExaOEpSNGl1eC9WVGNNZWh4UHVNdVFY?=
 =?utf-8?B?YlFaOGJpSTZ1bStOb0dIQVFjYmhvSEVJZk1FOTJTcXJucnlNM09zMHNEQnBN?=
 =?utf-8?B?Z1FlZ2hpalR1bmkraWV5MGMxdGhQQ3pZN3F6eFBvY1BIRVIwYVBnS0c1Q2Vt?=
 =?utf-8?B?K3EvMks0b3R1Mis5aHljNEE1SmMvMjV6YkY1S2NGazdONk9YRlQvc0l6eTFS?=
 =?utf-8?B?S0VwWEVMTUVCdk1EV2g1K2J5SzFIVW13MngwcU9FMG5uejJ3ekdTaC9oclpr?=
 =?utf-8?B?bGV1L3ZQRUhDUUY4cDNHSUJBR2UyZVMyckxiODBZVS9yK1BNUUlYcDJmRTU3?=
 =?utf-8?B?a3lMeUVSY3Faa2NtYlFjUlhZVUdXWXBzRTIraWU1dUl2MHZzbWRNbmlxOTZl?=
 =?utf-8?B?UEp1N3pKTW92ZldNUnNqTklpU09Va1dHUW1uaFAzb2lFazJEK2VGemVnRlZT?=
 =?utf-8?B?UzFMUHUwTkdBRnlhVFNsOEx5RnJ3MHdvUGtWQXY5QjBhY2UvNjQvaURmSERl?=
 =?utf-8?Q?BqmcTt18Xw7FB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:38:52.9722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d120e28d-2aa6-42f5-16bd-08dc69e40aa4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542

On Tue, 30 Apr 2024 12:39:29 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.90-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.90-rc1-gb3fba631803d
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

