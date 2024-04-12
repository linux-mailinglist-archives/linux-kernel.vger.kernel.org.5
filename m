Return-Path: <linux-kernel+bounces-142200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB4A8A28CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51361C223D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828053819;
	Fri, 12 Apr 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O1hK9mLX"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B914F20A;
	Fri, 12 Apr 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909018; cv=fail; b=uv5StFwGYDf8sx80Pr4Rv8DpdC4O4pnqHl+ZihQBuaQFBh5NyuTjtOErsoXmjayVpMfI06sXVkYdCGwCjL0hfsrRGKiTGa9bQ8opOzb4pwWj2xpft+ujtXBgYIL6GzB3WeIhUMhJBDogFgK/tRQzMABA0mI4AC3uPQ5y44F/AoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909018; c=relaxed/simple;
	bh=396RMRtSjEYB/FdQJepVM1zKOYjS08bzLmymjY2oVNU=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=ZWL+5JS8gNK1wgBTTEElYcXblH45PT5oj9dvrdM8RJuczKqvAERfEYy+wRiBV8B9qsopRiAokh/MICPi8uhcwu788pbc5MNYKfSwWit0LaOK12D/IkX79MI1eBIpo9NTBveK8e0Zr2txmYUAAmVipTRYK3prp5+CeUeqnvzPDms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O1hK9mLX; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBZnDOMycCS1/u+JuSoJqEiy7+NcAuL+h1TNabcwJ7cGgTtij/pwuc+VK+3gPNJMIqrwO6jzZnaLOtQLFJwNi+WyNcwbbeKEh6a1xNSNRQgpRC2Bk20w9/Nmpbp9ojTrVe2/doO4gwfGHIQIG/slO62nzDAh7MfhIRYl6hRmdfyEN0tquIha5eVE3EAdEoNvLOqdf6PCSjo/XAkBa4yDwxMsknruv7fMyX2A2kK743S5aoXz4tYGoJKruqejdswHLZfex+XQdwa1fKowcmkusR0uPOjrshxirH7oHxKYN/J2+A7KbONgDuDi/Ihnl5GduK+4gSTY//E++nCiXHBtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLyGhwNnNv8k8Bj7rSLwEZnIg/ongaviFkMc4FkS8xI=;
 b=oZdg0UShLOBGhQQc555/aAuqM5/QlDnwUcUJFHSIYRoZVd4auhrPpV1mKJraWUFfCcARQN/JL+fZf5j++TRsVRmqeeyuf8DkqFzhXnGuzBGgHpl0x0RtxOkVYR83I4nM8Gi7lXGmDQrFzUfyEgcExipmNttbzCU601oUAdn+GeQFuWkwk4I6wt02vGMwmvxBPuJ7TfCO+Snnno09OC7/LMu33Vbj7V4uTkFXYqMcEszhq1hvo/jJ7//8A+0AkGXwvoNYUm3HfwiSfDFASkuCO6c3lB+GToVO6l0tZcFixmTDef62dNrrefn9nMNXC3QFXQprqRgR5f+SZIU0RWx6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLyGhwNnNv8k8Bj7rSLwEZnIg/ongaviFkMc4FkS8xI=;
 b=O1hK9mLXunWs782l5xmPCKTawR1czlreMr5eB/8Ax7H0gJfszVwOMZu8tKUXxEuSgjF4N4fICJSZVqsckw4ows8TKC4sNlvRVvqzVj9InOS4OGcRWD+T+iiPTNoFVaP2ABhCNYxzLEHVG1+fZYJ+hG58bLnpOwUoOES1w4FHXbOFJ8exboZKdyXX473Lbb7AaN0CYC9S2O64meiIt11ofYJfA6cjGQduqEaQS/o6fY0sz90OFOiRT7Quk11sqZ9uhHpZHyQ7CElOW9Zpg1os4nVHVmQ2TPcyf0RvJR6OG1dklB5rNeB4bmNJFsIc5Uwm5QJcCXREfAIswiXKIKFmyw==
Received: from BYAPR02CA0011.namprd02.prod.outlook.com (2603:10b6:a02:ee::24)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 08:03:28 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::6a) by BYAPR02CA0011.outlook.office365.com
 (2603:10b6:a02:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 08:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:03:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:03:13 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 01:03:13 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 12 Apr 2024 01:03:13 -0700
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
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
References: <20240411095419.532012976@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b7e396a1-5397-40bf-9755-1dd7de81c74e@rnnvmail203.nvidia.com>
Date: Fri, 12 Apr 2024 01:03:13 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: a164c22f-b592-4f5c-3811-08dc5ac70977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Gr2vjXERrcBkZ8xi0lLMAXU/YYOTO8ImMaLaLS1QkSXcYgyM7oDezIZAyRPFWo04h8Qq9BMKA9i5zHwPQI9UKa0W4Y0dHJXa/tG2IRlagNT+NyqTf4Nck0kJuUgZLDLW6btDqPn/e8F7vY1S9KMX4snlXXgMEruArbJqaH0kXy4jVPbNSHFmjeDKoELdTjuc0pRA7yazV29sqCnem9GOilh731gumwDe/AHd9PyHW4IQ4xBldFh/kvYVnmCdX34qvEGHR5rl2tpDZ0e3pYYEWrgP4/o3mqsmedevkWxc4yyCVuZ0+eLPMrRixFDj1N3R1Y0jql4Og1qWPf/ykP04KehsgQlvmLzCoCbP4wCJzdey1steKoqgXob55YPDIeSyB1k+8F5ohDToZgRvQxV+AgLsSnQFN4YXcd7Y/DlcOcC85GPyYyJBzkQXzCHjl10NnvXCGD5TP2wSykj1U3ZI+iIcV0HQLMBMJg2KdPmw/qY7bRpFFZeOIQfN+43f0x/wcWd/6BzaGC++Yzxaw6PaCe5he3e8EZPUSW1+SDdDP5MRbdkbpDvaiUpRDGSbMXDtiMEnVOOFOPI8MgJ6D9tHV/dzCY8Ipj4qm6HosY7Ha2kqv5OGe38vUUGulNBm8nAz1Jy2/xd0NKCcVkbJ1ap05YzC7k5CYpNGYwaHnK++yoGR8i0m0bgB6Cah+Jy1eQErEydR5/h11j1Us3zJicO2vPbOEIYbyYIjqLKvuH0imPkCZ88E8ThKZEBdgaPLTfH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:03:28.2630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a164c22f-b592-4f5c-3811-08dc5ac70977
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

On Thu, 11 Apr 2024 11:53:43 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.312 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.312-rc1.gz
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

Linux version:	4.19.312-rc1-gf0cf5f6110a7
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

