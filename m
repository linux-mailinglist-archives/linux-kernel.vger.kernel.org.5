Return-Path: <linux-kernel+bounces-158227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6E8B1D37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CADB23F55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CF282485;
	Thu, 25 Apr 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HIv4KTA/"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54907F486;
	Thu, 25 Apr 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035595; cv=fail; b=KYbNu8bfUtrBaphYbQFQGePxFf4FfSZr4lDnZb5PqWOwAf2tnRRnfR1M0J6wfQ1hRqDQt3SmMTfU3yoQBi7RL7KvhPDP4SH4E2xrQF8Tvrh/k62nRNzT7e1aNZxBhONqCe14g4yeanneHMIlB6ZM5hWx/iY+NV10X63/0WW7GBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035595; c=relaxed/simple;
	bh=gzAHYhwIcOL6HP76NjPINIqH/Fb2AhS+nZR73+FI5j4=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=OoqPivykRQ8yqhLAIXCnx0/5OGr3W9MdV5TxKMjvRaLDyO4BKj91BQOGZVgBUEmj1bCke1vPgpmiWOZM6nHvOBBqvdYkC6LrSq9q0Te0MWehJhA5Ykt6MB1ylh4uY1O0dFeBNfWGIQRv/1RIm91FAd3V/wLah5r/80OPCKodcP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HIv4KTA/; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj+hNJRhsE/VUUFxm5mNTcDNyD0pLKA/MHuk5qX+MoFdKWyvxJMR2bVxBzbJ4NcUAhMbc2+n5Gcw5U7qVt5O9yBnVK2Cz3NLiG0VFK9xg7gi5w947GhfAaFgow95vYlB0phm+nuzQMvf0CMeb4QJxu44/fv0Kbbh/XB+Z/VBIHFIqe0SFuTXJZWfh0Rx9ytwvPV1zp4gsek/nE+HU7VU398J4IOEoGAzRuK/94RjIuI7yTou1+I4VmTKj+PuSNkql9GlOayUp0cDsIkXICTyCoLWbv60j7JLKxktZmHefP6tsFULyLLj6QTxZdrCXa/H2KEC1OY0DXY4cYXtEu23hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NASeWTM9GKerepBQlDQ3dbCqXR2WcIxKiEEna9FEgAA=;
 b=Yijlc9ajj2c5DFVU51p0W1VNLo3zj/1KfgkSeqdfrUviQUxFwpoU8My5aaPemFm8xBalqlU9VizWzoyemmjS/W2F61UJeA3VHx4YKjvOUwzDCjlx/5ddomYO35pZmjm7/7aTquynAtNETTPwebCw6VR9TdugFudBWuUZL9l9tL66wjFnA5PujzNXko5hy9PhceX6tIt3LpyTdVYEW5o7Hns7dRutdqPFBW8AVp+WkYabXkL98d1dTNtaljrF/1lqOXMEJJgwBcILED5ZRkNRWFOjmpTZMNgvxAJ8T0aMflCw6WLhaGPypNbuBvdNIXFiuqTHqBtNFkSVRQI6AjT4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NASeWTM9GKerepBQlDQ3dbCqXR2WcIxKiEEna9FEgAA=;
 b=HIv4KTA/vtK4AlCBaklm8fIeWf2I71m/rr8/OddDVzjQsMOzHj1IKkXiYRGZc7HrJf+Ce1hPLmVl+AK61aNW7oeqwbBaEkN3MAhjQ+aalANg4Fw5Maa6mrNyM2rPzfkEDEBccmZqoAjT3ypO+crbks00qSUd4sS7bkeyAQfskgydEXNvylc3AT4O1XsWngb0TtrcUbGlYFweBCJhgxKS+/62icF0vc6UiNNuPGzWNjhZoXo1To+86/htRIsTi6ojZ4n+FYJZuuuDAU/sHbz97MfcWBH1Lp8yqQrOkP54aD/8kZkX/aIiqrFUxWJVffVT8iToxOGktcyfmppUxr8DWA==
Received: from DS7PR06CA0033.namprd06.prod.outlook.com (2603:10b6:8:54::15) by
 CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:59:51 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::6b) by DS7PR06CA0033.outlook.office365.com
 (2603:10b6:8:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Thu, 25 Apr 2024 08:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 08:59:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 25 Apr
 2024 01:59:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 25 Apr 2024 01:59:45 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 25 Apr 2024 01:59:45 -0700
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
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <06ee6f01-6318-43bd-b6a0-ffefb210e654@drhqmail201.nvidia.com>
Date: Thu, 25 Apr 2024 01:59:45 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c17729-6e29-4815-648b-08dc65061135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmZjQVFZU0hXYmpqMnEySDVwMEV6WWtSMTQ0VFd3M0tOWFlBLzBsZGoweFk4?=
 =?utf-8?B?SUYvZUNyNDR0M3QyYllZS3NkK0l1QmFyem1Xa2F3TklJN1VBcUxiNGZISEQ5?=
 =?utf-8?B?Y1BzWDMyUHJCcmZDTFhVZUxFNDlyQzBkVVlNb09QVittM3oyRXhyTWFaRXlH?=
 =?utf-8?B?TUE5cE43cDNtOVRUR0lISFJYU3R4aEZvcTJKUDFUeldQeGNaZjRMeDRlaFhi?=
 =?utf-8?B?S05HeUYrbFpCN1lsL1U0dDkwQkFCVDRpYWFubGdDQWd4QnlQcC9PTWdrZjRP?=
 =?utf-8?B?NDRqeVpqOTc4eVladDlmdVhvczhPTnNHSlAwK3NNS1pudkdKLzJCTjJjV0pZ?=
 =?utf-8?B?RkhTQk9SZWNFeEp2WDU4Z2d0T09CbnlwVDh5VHZveCt5b2ZKS08rc3NxY1pZ?=
 =?utf-8?B?Q0loVSt6bmt1NzV5NS9SaEJkdTN5cXppbjlrb2dkTDlnald1Tmh4ZGhWMHEz?=
 =?utf-8?B?d09jZHFXSm43QUFQdDByd2VxdTRrSTM0allkeThHM25ER2tSTkNYODlUWWM1?=
 =?utf-8?B?OW1kaVdpNEVzYTdFSzgxYW9FOE1PNlpHMEZ2R3JmeWdLZXJ6Z3lSb0FZMEVn?=
 =?utf-8?B?NTQwOXVuai9pZVAxaUMvdTB4b0tFWkoyVVFScFJBV1lud1Nhc2xLNmJOaUdU?=
 =?utf-8?B?cEgrL3E4YXRtdUlrRkJ4dW9pazg5R2Q5ZmhvNlphQ05UblRZMTBrcTdpcWor?=
 =?utf-8?B?TjQrdXRINzNvZXFzTm5TTXVpZ1VZNUI5eXJLcmxndzRHbVhjR0ZOSThlRkhp?=
 =?utf-8?B?dE9rWDVxdkE1eW1oM29yTmgyeHFCMERCS2E3ZVlkejY1YWphQ2NKcW9Yemcx?=
 =?utf-8?B?eHJUaXNTcGdFZCtmVi81bkJ6ZTluRUh1MU5tY01rZTR6K2NWWUw1c0JsZFlZ?=
 =?utf-8?B?WU53YmgrMTBMazZiSEx4YnNPd2hBblY5cUlPOGdHRlJsUFFlSzV6TTRteE9u?=
 =?utf-8?B?SndROEY4d1ExQzdWdnIrVDV1SU44dkZOU2V5dFRuUjJMTk4vakFFRUdsbFdC?=
 =?utf-8?B?L3Z1VCtJWmtIVytPQ1dyMDUrWjAxcGNYSWxBb3dxYVMrc1dkdUhOQ3ZjN1VO?=
 =?utf-8?B?dkhyWXlpQzI1NEc4UzJaUHQxM3RmMnN5YysrdDJZQUFDd2FwTVd4Z3FKTGQ4?=
 =?utf-8?B?VTFkZ2JxeDFhM0lvR3U0WEVqc3RCbVBSU3U3S2RDVUV6T1BRMXlFZ0o3dXdM?=
 =?utf-8?B?OG1wR285SUtEeEJaR2hpVWd2MkVkbmFWR3k3d3dlaFpQVVlsY0FQQWpPdjNX?=
 =?utf-8?B?SlNXQi9tNnVuS04xZkw5OFZRU29nVXBmZlp3WURPZUo2Tm5uakJEVEozbHZu?=
 =?utf-8?B?eXdrOHpUM1BQUDJjdUphRk16MVJhbk9vRWV0dUkrZys0bU5wNm8rb1VhaDl0?=
 =?utf-8?B?cUQzOTVKNU5Wdy81WlcxcHRmMXBrODNyQlJ5Y3YwcDFVQVY4MVA1UXB3R0c0?=
 =?utf-8?B?RDVwZFpOdGlJcnZDSTZEUG1DZnM4Vk1FTnJMRTdBOFgyUE9LdHhKZTZLeEF5?=
 =?utf-8?B?YnMvWU9VZTZFWThldHlYWHVLVzhudjJKUkhMMnAxd0dGZEttUUVrQk13K1E0?=
 =?utf-8?B?a3RhYTdDbVNVSDZHUVFsekdEM3RidjNaWHNaVkdlbFlJNlNRMGVLbWdLS1NZ?=
 =?utf-8?B?WkNhUnhTNkZhR1U0UjJWZUpKZU9DaFJmd3NYbzZiOTQ3TW5IOW5oMlBGWEc3?=
 =?utf-8?B?Q2VVc2lRSDdGQ1I3TGVnVHl4WVFTSDBZVEhxQURIY2g4bHBuQVpBSHpyOXBX?=
 =?utf-8?B?YS9MT2ZvckVWNnNhcEUyUThxaTFoa1E2TTRNRmZhTTdmcWo1S1FkRVo3a0JK?=
 =?utf-8?B?V0l6QTdMSWRudXpZbGQzczhTZ2V5c216RUEwT3JiZkR6VHlzZDMvSHloZXV5?=
 =?utf-8?Q?n0OUNEq4+OK6F?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:59:51.1282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c17729-6e29-4815-648b-08dc65061135
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549

On Tue, 23 Apr 2024 14:39:13 -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.157 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.157-rc1-g70f39a25a6b8
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

