Return-Path: <linux-kernel+bounces-165326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F68B8B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAAA1C2153A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6C1433D4;
	Wed,  1 May 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bGXKpwaX"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64AC14F;
	Wed,  1 May 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570691; cv=fail; b=BBscAOzde9l8oAyUI+sVFtjEpR+ygSO27MKVSYQSxiPsZAvrwf/jO8kUp6KnyVDSX6A0ATyNYFmrTdY+r2I/cAIjO88xPeWNY7NDjmRKnGQ9ugH2RbNPIIS18ITSwp2v3bYIQw7zeH3PohikEtXhXEdRZA/Nlswn5vskadT9mn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570691; c=relaxed/simple;
	bh=68z3ARseJn6gkJioNxKRV1b4VYbUCzr/UM27Bs/hTi8=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=oWGVxvsq0HvijaPP104ZDZg2mEOj/agAcaFR/41B/rN+t7uzLpgYk2Q4kSg+uZipY2OWp4fybkwNLTfIpqJk+CL8v6q4rq80ZeGB/kP8qmqEER5HSe6g1qUG+TcYTHVfw7I9+yHMmgQoAZr9Az7H3E4Fh3oFp6CYgHMdjbszFbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bGXKpwaX; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qzb5+ocCsEAC9lsIrIrEO3rGxlnunsIZCDB+mfYbOnyz7FNrIC1vNk5h+xAZh0tqyHU35GnkisqNHvjnk2D6O2a6zzfZtnAtPeEN9xXejKYCsvSnRyQ5m3VrlMTWfEhb58kvz/aGGEomWZKXfXipxVQOqZeSSWMsjBvwYd1hNrK0o0YwkLAQ2XW/SgXR0/hegwEHczyi4xKmPzphe73i9LvFMWIfdWufDWE9XVF8PCnlJ0fDvVSBqR7E6YhnUAg1LoeL8yAVlR6cZXJN1syOmk3VUmTiU+nSCWUEiGchYx9sd/4FhAOLPmZ++iyH78800xwdNJ2C1Xp/ZaxnI1x34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOB/9y8zCLUMbFkhep0S5u9n/6lfA75VG9J944SWPBo=;
 b=HGFRSI9WLpiYDF01HqW9g6D0O2dxzpqq3XIAa21PL7UtA6vdwi39CsrHE00XWA3H+eq7w6TBKRt9d93O4xGfKc43nuPIaSG2tUR1ZSN7nTStP87T9yVH4Ok/SJZOgwaB+GUi7X3ilTdkKrtPacx8D47M9eyw10XVgSFNCAp/3ANWKsH0J/KLQpJLa+PoCl8QJup4vaE7gk2cQd56putE4hdP86ggPdj3BjGX9h6NuTBDp3/rPmT1wHkBZoxfcEOipqHzluWg6HDKrur/rZphOTalR1QUTSY/lQE7eVtM0ew7DCJOm0d9Thqt7ayxe29s8rNRpr6jvuPi7qtWYRCgPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOB/9y8zCLUMbFkhep0S5u9n/6lfA75VG9J944SWPBo=;
 b=bGXKpwaXcC5oxhLxjzrMWJ2cxYTVCN9fwwuqhEIb753cLdt10jBh1Ixq55kMRq4D6AndeSzL1WY2bcCk9Aqa7cV+0TDOgutOnEkBNjvtngrWCvqsoFuebGczZ8WdI+v5l3U4Gvgyqj9+mBglp7GpcJfKzHNRHSk2BpbUJcYey/e6nqTzr14PaaCsVQCsh6N0cXL+Lx98dR6bk4yqjmSX77mYDq7/yqbRqS89rEbWOLutgh2Ca8vGagaqJdp1I2N2xryjpftLfuzbOXS7HXGvL1YPmLdDOcPUI3Qi/dAdeGqGaYMjQ5pC+H8M+N0HjpcxWOQTBMURhTS00NAhfeFzdQ==
Received: from CH0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:610:e7::34)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 13:38:00 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::b8) by CH0PR03CA0239.outlook.office365.com
 (2603:10b6:610:e7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28 via Frontend
 Transport; Wed, 1 May 2024 13:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 13:37:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 06:37:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 06:37:45 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 06:37:45 -0700
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
Subject: Re: [PATCH 5.4 000/106] 5.4.275-rc2 review
In-Reply-To: <20240430134021.555330198@linuxfoundation.org>
References: <20240430134021.555330198@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b5b412d6-ddc2-487d-aba7-33d67f745998@drhqmail203.nvidia.com>
Date: Wed, 1 May 2024 06:37:45 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 4640510f-6e13-4ddb-368f-08dc69e3eb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|82310400014|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3JkanhxVWhCbXVZY0VXaUh1SHBIMnprNmtSeHJVc0ZRYTdtVUU1RW9DM1Bk?=
 =?utf-8?B?ellvMVpsTExKbzNWMDFYRm1PdjVJRy9QVThSRThHSW1zOGZsS2dCRGxhRnla?=
 =?utf-8?B?K0YwNDRxU2gyS2JGajZRR1FPT25kL21zSm5WcW9pMW5tYWNRTlZsRmxLby9x?=
 =?utf-8?B?UUNaRm5abTRma0RVdEVhNHd6SnBjOGQ2UlkyaW5KTFVPaHYzMG8xNml5djZm?=
 =?utf-8?B?UDNWM2Fja2c3UEVQS0V0RDZLdFVPY21KaEY5UjlHTVVHcHVoaG80OEJ1OU1u?=
 =?utf-8?B?YmEyZDNJL0dIMy9VczMrMHhjQ2pKZ3Z1azk0TmJNYUl2U1VOWm5NUXhkVmRh?=
 =?utf-8?B?dGVSVEt3SEQ2VXpxeC9sTC9Od2tQTDBJaGphYUxJaWFVSUZVZFJMRlhuMkVq?=
 =?utf-8?B?K3NzS2Y3L3R3Q2h4Mk82MG9nbkN2VGgrbit6UmVxOWhIcjFYUEo0TDY2bUNs?=
 =?utf-8?B?R1dRb3BaaWNucTYrOXU0aE5QZ21Sd0N4VDJNVWh3NUJieEJYWkhZeHRBNXlY?=
 =?utf-8?B?dS9meEtIbkFvSmk2UHVOWG0xUlRZaXkzWDFxWVFCdVNZS1kvaFF4Zks2akhH?=
 =?utf-8?B?VlVPWWlrUTkydm1EZFV6T2s2TzREVU93VzJLZG1XS216WEhUdmprVTRJUVdJ?=
 =?utf-8?B?OUZYeGYvOExoaFZuRkhmM1dFVHpodFJQNDhyMTd6bWU1QlhTSFhWS0owV29Y?=
 =?utf-8?B?N3ljSjhRMTBoWHZOOVdrNVg0eGpiUjNHWHZxaUNvRXJiSEFaNjlQcnp4dWsr?=
 =?utf-8?B?ekh1amdYcnNnbG5vRCtTeTNYbmZkNFNja0F1eXVxRU5sRExSSlowYkJUMjlU?=
 =?utf-8?B?QkRTRWV5Wk1qY2xGY3RpSnZXekszQ0VIWjVSSUVsUHYwcU9YMDdhNjFwUFVN?=
 =?utf-8?B?UWNvY3lzSi9GZktEMmxGZHVJRnFnQ0R1aHgxN01DOEFaWmRQMnJNYjNQdDlh?=
 =?utf-8?B?YVdTSmRsWnJ0eVgwai91QUkzWG4yRW1UUXRPVkJUYVBUbTJCWklDNXMzK2dE?=
 =?utf-8?B?MkRDcmM1NjBmNm1CSDRGSGpTU1hXMUxDMEszVVNEU0w3SEQ2NzFYbVFjRWlW?=
 =?utf-8?B?eG5UdFc1d2UvZnR6VTZBODMrVzdKZ2pEN2E4c3ZET1poWEZqWno0aTAvRU40?=
 =?utf-8?B?RzlzUzdWOVhNeVdqeVJXM0xmeVNYN0N5MWY0aU40bUtEcld1Vy9Ub2l1ekdJ?=
 =?utf-8?B?SnF6dW5VNlU5bEl4M1diTkg0VWZoR3NRSFIzNWthS3J3aGhna3QvTFI1Wit5?=
 =?utf-8?B?WWd6UDc2S2dLekdpaW9DK0gramRrSndwUkwzeWU1QUlFUWlJSHoxTFYyWVdp?=
 =?utf-8?B?VlBsMFlqR1FiOHNYb3UwS1FwSGpWTTBweWpHUnlEbHV1K0RnN1JVdkw2QTI3?=
 =?utf-8?B?WGxWN0MwL2dNWVhVbXdVTDhOaVkzQ0tPM012SjQwVU5aOU9UaXBGM3JXbkx2?=
 =?utf-8?B?U3IwOFphNnpQZ1FtcTVwR2RjMFI3VjFsUkovWWVqVWVDSnIya2E1R1dxL2Ni?=
 =?utf-8?B?bEpUQTcwTW5NSHNJa0lvYnFjaHlybjlsRFdhVm5EeTVMZnZhaytmMnlWaEFG?=
 =?utf-8?B?L0ZkaXBvWW9HTklMOXdISEdjNVFveFNpeVhVR29PUVRyWGswd3E1a082RnpI?=
 =?utf-8?B?a3JIRDZSeUJ3WE9UelpZL0Rrbm16eHBYV0N5V0ROeENDL3FOUXl3NFdGeHNz?=
 =?utf-8?B?ai9GMTRRd1RpMjh5akpOc2FpSnhvMnNkaytkS0FqT25MMWZxK25INlJxMWll?=
 =?utf-8?B?bHMwSnQ5VUpxVHRmOHYvWFE5SEpobEVoWTQrdzdLT3M4cTJaZFczZFY0YTZH?=
 =?utf-8?B?aGdtNUIwMUd3cHFaQkdxc2lwY1AxaGFtanloNGFRd1l3U252UWpNNDdETDVH?=
 =?utf-8?Q?dBLqHte/hu4a2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:37:59.9710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4640510f-6e13-4ddb-368f-08dc69e3eb03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252

On Tue, 30 Apr 2024 15:43:24 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.275 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 13:40:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.275-rc2-g6c530794f59e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

