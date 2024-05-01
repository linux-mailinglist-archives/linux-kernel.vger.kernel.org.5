Return-Path: <linux-kernel+bounces-165325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16E8B8B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13411C21453
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2D433D4;
	Wed,  1 May 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ue/SI2Pq"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395C5C14F;
	Wed,  1 May 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570664; cv=fail; b=LpdHvfjI+5HQbRyKWkHphX7TDkIwHYzfRg3i9SCXQX97wesBWKEmtbCzoKbBCqTTD7EMTBK86JFd8HgWjgV3cqNplSfOan95vt1QyyR+RYVOsC/aus82mYxJvZIndqSErmUj481QYyHYZ3n6VY5YWT0eCLUWoV7GcnfRMom6zg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570664; c=relaxed/simple;
	bh=LR0/cX5UZGwyCtip/Q+DwaTEg8oYyqrAWxZLphk++zc=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=OQDodSZYtQ0tJvI0rXjKHCW7Ug+6loKMS1CRWEjCoe+RJlUd0GkmmnAw4Aguj8NoEouiYTvXxVbDz6zsJB+XJNGlJiYFLWjYS3AdOBWaxtd6OPywWjYD/VG6qtMCIwZpw7tQv0GNEKOQoiUtrC6+l5qLFGfk5gDV9Ij1nEL88/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ue/SI2Pq; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDIqkd5+OwrijVwBZ91B71Mz3YJdx7iGJuEX3pDPLOOUSEszTh13lTbMRdxxx6cnssgD1oC3OUdloZzOWD884YSkcHbKXwvBnVyNRfuwfR9ER41qjbSNb4xj56x5gWCCPg24R9h9a2fnAHiRvOxyjB218z5JA6JgyjrVy8GQ2p46YSUr1WHlU5gEh8jfEoU526FcbDbx/vHJvzGh0LbJN1JIReByUIF8TKbmZJUroGknt6NyR6HCybaIIttEQV/DRZH4keMey31JIZiAWjAl2nNAI2EVejqTGSipG0CC9pPKZrmKXBJ3w7bbzmYYLv/gJymGlfdZ4E5Y2B4NrVeLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXlaz13NLSSwEWYjQIVHn7OuN7AtoU+yGDnjSVLOOco=;
 b=ZuaSu+LVG9O9hpfrspMSzBXL0v8Un0n2DWLRtklKIg3NMf7OILlVzlfd/i0ItkuzXcr5/Pxwwat0e3egChMj4CVxax8o0FZy1sfXubGM7B1KPaqMpFW2QaEUiT7mqF08O7JprMavgX5B4Oz9hYuJ2G6aF8DdDEhGwu8PDQFhNomqAU68Wr3dX3vZSUwuAy4WmoK1z+PZlZ+q8S4fewq5U3RJ5eVnz9dlqtyIWm6QUdP+sEFuWMfbM1g7y2M3iWppskqwJJkQSEzObkqWBu5tOmwZf/LS9uwyUubP0fNQHMgTuYoicROnwMveRAHfZH2wDmb47WBia988WF2piyiAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXlaz13NLSSwEWYjQIVHn7OuN7AtoU+yGDnjSVLOOco=;
 b=ue/SI2PqRWW0YlvtTRLn0JQhHAkdLZ+XESN4nnWs3gLbOwoONd+AQOwK8sLWkm9UviLZsDDE3Zul8tphGn0vjaDuzHsNbt7ev8pw0FFijX3YR9YJEm2ZoK2wxQC1lgiT0QT7f+a1TGrhpGfZdVcV4VZJ3uRj0sfSc2AY+wy1Lg1BJ+2JYkDZjzzhTgijhvzE/u7jjhkGEQnOATGo3BwfXRokWwwI1NniQaeXEsoXQv3ABNCOpRw7aNaFuSuFdaJKJwbViw7ZNo6H/AuXdr115x2rJRyMPWyCDx1X+qA9Zz1Sb5EInJsLNnc7xnCkgTY+fK23MuG23oPCj/9/QD2ipA==
Received: from CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::11)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 13:37:40 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::fe) by CH0P220CA0021.outlook.office365.com
 (2603:10b6:610:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Wed, 1 May 2024 13:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 13:37:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 06:37:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 1 May 2024 06:37:29 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 06:37:29 -0700
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
Subject: Re: [PATCH 4.19 00/77] 4.19.313-rc1 review
In-Reply-To: <20240430103041.111219002@linuxfoundation.org>
References: <20240430103041.111219002@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <60fd6ad5-8b6e-4ed2-a8c4-2662608bd38a@drhqmail203.nvidia.com>
Date: Wed, 1 May 2024 06:37:29 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: c23a7926-869a-45d8-d844-08dc69e3df1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEhUdEtiREZiMXg3Szl5d0dUdEQwVDVPN2ZYbUlhc21rSkplRlhWTVZacE1O?=
 =?utf-8?B?WTAzOHhhK3NSSUd0djBtZlJ1TTliL3pNRkVMRVh1cHBnM1pCdjVJbFdwcnVD?=
 =?utf-8?B?UXRWbXMxN20xNjZpUHJvQVVMR2ljcnFWbm93cmExSkRMZHNzemR4WkFrdHZq?=
 =?utf-8?B?VFBGUDI3VE1xTlVxbmJCYmRtRzZDVklmR2ViMGVtSzBzZjY3Mmp3cGE1YmZ1?=
 =?utf-8?B?bW5uTlR2bmRtb0hjb25Gb201RzczM0tmaERHRTJCdWtveG9qNzhoQ21VdEgr?=
 =?utf-8?B?b0x0ZVlSTmE4Zks3aXVnd3FWckQ5d0k2d3U3dU5FRnRVS09UbjcyeXJwWit0?=
 =?utf-8?B?NUpaaFlpWThCOVhHTXBUTUFEQW5vSEw2VnFNamhaK3dOdEhYM0pYOE9kSXFr?=
 =?utf-8?B?S1RRajU3a0QxVy9YSU9ENkhQQ1o2OCtTaVhDQU1EUXlHaHl3d2lyU1FQQTNE?=
 =?utf-8?B?N01CVzlKeURZRnhrZ1BwSFB5em1BWTRQQzlMOFMrQWN1ZmgwekFaVGRrS3hw?=
 =?utf-8?B?cXAydEVHOTlRZFZYRXRvYWdlYnBKR2NSWktUSHdCVXMyTkVBWmVWa3dTelc0?=
 =?utf-8?B?OStQbVVEOWhnWHBsNzExc1lka0xFZFFIOGdzeUUxb2hZWThFNWhGV3BPRmsx?=
 =?utf-8?B?dllrN1hjYmhyL0ptS1NqR0E4NkxFcUhQRWJiWDNxUVJnb3FCMnBNZXJBa0tt?=
 =?utf-8?B?UEJaL01MbVRZblA0aGhXK3dobjZXWHlFMnVYd2hhamx4NytGWWEyV0FjcFNp?=
 =?utf-8?B?Y2xOK1lPQ1BpYnFZc2NFdE1Xc1l6Y0YvMEJVWWFUeUE2a3A3WkVRaWxqNE5G?=
 =?utf-8?B?VDNNajBPY2tCR1VmR1B0SzJ1cHRQQkh4dmVZakFMQWZlRG5HdDJBZitVWWZR?=
 =?utf-8?B?MmJsZVZYVDJkaVovMEdQS2Q5a1lsQk1GcGY1U1gyTGJJblRBVXlta1JFNTBs?=
 =?utf-8?B?WnhXRDZIL1cxb1gyeFFDM2E5ekI3SXloNlYrMVV1bUUxNjE1Smdsa1Znbk9P?=
 =?utf-8?B?a2tvQlZ4dWRlMjFVSlI4NFJRaGVPUjFtK2s2NHJDYmo2ZkVZMHQ4M2hBaXMv?=
 =?utf-8?B?WGVNMXRYT1hmNkM2NU9UdW8raFRPNDY3VXRsT0pCRndNT2d5bE8xWS9ZMU9i?=
 =?utf-8?B?dWx6U3V5RkJ3aW04UFdLQWtydEl1NjFzQ2E0Q215OWQ3djdZWEJsN3VRK2Vq?=
 =?utf-8?B?WW9pL3V2bExrY2lLWTIvcitwWkJRWlVwbTYvdE5aNlpmSTBJOUVocXQxakY5?=
 =?utf-8?B?RndwVDJDRGlsT2tZTTdlUnJST0E2aGNiVSsraGp5REp1emVSWWtkZXBPdjFK?=
 =?utf-8?B?UzFIcEx2ckJLOVg3Ry9Dc1IwNlFDY1hHU1FCTDhHQjFJeGtGNytIbDdXZkpP?=
 =?utf-8?B?Zk5EYllDeG5CY2N1UVYyY1lqYUJ4TzBTWFRZWW9IUmYvdGNZSFExbWNBWis2?=
 =?utf-8?B?RHRyQXNOMzlrTW9jM2xjN3RjeHpCVjBOK211WCtqQTRORVlhSlNQVmxSYWdV?=
 =?utf-8?B?ZVJhSHlyRDBDL2tmSHV3b3Uxb0dQUUdVMDB3ZEZlNGNHUFZpQXR6TFZLclFq?=
 =?utf-8?B?ejEzSExJZWtKQmhqWFlsNVV0aGFBc0ZaRm1veG83WUdSa0M5cEZLdWtMb0F6?=
 =?utf-8?B?Mnl0MlBEQ2tGMXMyMFA2cUthZUw1blZRczdNdG8rRDkyNTl4bmIrd1ArNmU1?=
 =?utf-8?B?TXBialpXamlGb1BpbHNMcFdoNXhjZ0J6ZXl6dFBpemZSUktUdDdoNVRiUVdt?=
 =?utf-8?B?ZU9sVnhWMzRZOVl3UmRKMlBIRGt4b1J2dHlrYjI0ZTZ5RXNIODVhdnMxWnhj?=
 =?utf-8?B?aWxYUVowenkxNXlNamQyTloxbjhzL2E1Sm03Wkd0RkxROXpvYlkwU0lUQkdO?=
 =?utf-8?Q?pvIdHq3emqRcP?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:37:39.9973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23a7926-869a-45d8-d844-08dc69e3df1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398

On Tue, 30 Apr 2024 12:38:39 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.313 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.313-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    20 boots:	20 pass, 0 fail
    37 tests:	37 pass, 0 fail

Linux version:	4.19.313-rc1-gf656c346d44e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

