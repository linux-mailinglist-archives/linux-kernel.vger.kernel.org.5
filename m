Return-Path: <linux-kernel+bounces-131204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39530898476
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9121C22D38
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E038745C0;
	Thu,  4 Apr 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e98l/qNX"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1B1B7F4;
	Thu,  4 Apr 2024 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224614; cv=fail; b=HbmAbYeFrBl21MyVOKT9lmrpOzg0tpg5n35KDsTmg6cdrYn1ykwrowN7dQEgDisf1kXFOPAorz8m8Z9frqSkDfECYr5t7Njx88W9YRvnMqXO7f5rn+uNUp2tkRFYuG1hd6xJFdi5xbnZfJoFqD7X+K4NO6aLDjjhYrG4HIsqlKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224614; c=relaxed/simple;
	bh=Uc90YfFfCeOoTeWHkrNSZDNwg3M3fUtK/OlYEb8EPHo=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=gUGUPzGwvjxED1AXa+Xn9NgZFl8ihif2iuDWvYdP53GCPaxtY3YJ5qkfhSOEL7h1Z5RuMS1bIQjSRUxAHyEeHLWILxAzgTovoMPprtwdt5qYeZkfVE5jOJMTa5ONFIFMaWu+2Zgt2gU29mUB+kv2gadkL7wiZYQWfRKqAoQTWms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e98l/qNX; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwCYCy/1l4k/Xh0qKCW4cmO0LeYjQeVxlABUnp/+2yAjvUvq87/0L0YOVyS8wWnANpHa//vWgCgDZjQjYL8Xyuk/DaAoqHG1zpLAofsK93Bgsf9faedPL08NBTXm4ojKpMBRicpSZvmQGYLk2gyTvg6MIz8tcOsjDRtTB5itfwy/1fb6thN1y8D8y1QUnYCpza43lOxkn/cIrtM37aX5/nAmPnLvw0KnZ4Gl8vqEplwyUquwROuLAl2xOZZgoPpkyh9W2sxgybRAPX0wb1Seq8aEu5idVnmgszG2cS6t5o4YLE3/VUZiDkxJAc6TTfzVVxlNUuw+bjBa65O1nrr5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v4LF8N5+WtMoKS4ESiZyZyGbd5+vuu6VhcB4OLgp1Q=;
 b=LgHCqDFP+ysbDyO0o3ExTsWfxNaCheLGc/RxfTYRuvVAJB8mutZMZxaIvJdGN5cg037r0fA1s1f6LDzRqw99lI3F/F8Mse7b4M9UO+Cbpfjfrp/SO5pVub6GZnxRzAZanlsI1j1bBoOc2g23IS0Q4f8eIp9TgtSWmTvSgcEvuVEwJ0CHNJlMrPYoovD/MC/3H7T+95s0hOkLhJEMZZB/C/uxTj9BK7WQVfYvaJBlujwhu49Dj9cql89ayhXpxps7tl5pVQhTQxYnI9Gq7RgRc5MCjQA9wAaOT3R3VKNzwdsh4LrU9obQjvRpqLNOBkXDiyEnVynSDdANuaFJD1F1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v4LF8N5+WtMoKS4ESiZyZyGbd5+vuu6VhcB4OLgp1Q=;
 b=e98l/qNXM4RGqiNvsgFSInRosxrIoeIn++vjvQS68PcybbKUaamE4rvnnYa+s0gwxHlfO//XYZszR84BjjGCB38d+d+sxW4cu8o+tpouhPCyDn79Sf39A41Gd+9fVlYwfx4CTsKdzdQnUtV/LK10X/B+AAd+ofivPzyicdOcuTprA8rTw09tWFO7Y08MgsjI/0FuvGH06Fl+k/8XCaOyyns3nH7TqhkRwL5kp6gkUm6qbrJrjvlP8o91+l6RSR4M8Z0x8ZcnRGob0CBuIVoNAAVzRuKtj/sVkReeUqQg08mbUNPWhDS52Rm3buA1QNbLDGd67uENMGmKwnVPeIp9fg==
Received: from SA9PR13CA0166.namprd13.prod.outlook.com (2603:10b6:806:28::21)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 09:56:49 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::fe) by SA9PR13CA0166.outlook.office365.com
 (2603:10b6:806:28::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 09:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 09:56:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 02:56:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 4 Apr 2024 02:56:35 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Thu, 4 Apr 2024 02:56:35 -0700
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
Subject: Re: [PATCH 6.6 00/11] 6.6.25-rc1 review
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
References: <20240403175126.839589571@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <8f67c236-b035-4c35-ae14-28dbfd4375d3@drhqmail203.nvidia.com>
Date: Thu, 4 Apr 2024 02:56:35 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 351e9ac1-808e-4f10-15a6-08dc548d8c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XJ3HwV2FJH5Yni8Bgid0ekSMqieJBWdA2wAzkKQM+vPyxFklT6HRUC0x9yb/GihBlZeoi11O20nNErRjB7r21aQAlM6uaGMb5HVWstKN0/3pWWzmRPQFvEGuYAG+k432jrVopYMvoNMTZBUfb2k+aH/4XoIzj04Rc+25aY2K5WrtdjdN6VpuNRTVM7K/UPYTrOFZoqVar+Tv/tK7fLHbCVfKbgtUPMtxFGXbEKvfQmFRgH5xOFKVs6BKDly5FOud7HWQlzZDciNFAKPFnWKBje/dVYBs+bImbEdCngfkZhpda4fUVuhTJaG0OAvxq2Ri7+XspgABi/dW2u/csCGt8mniSz4muZNxLyLFFyMCCWSiXJNUe1Hs1Zy2DAyd5t1/qHQ7cvtmHcBiJzlz/QALfqmoNyKwt0SN50xYMIrlp6D98Gjnsbv6nbIk2zqjBi0PLUGFa99vWUVasdjniA7nL0iLKxjzRwo31GH7a1DUjyyD6/EN6CVKLIPo4GJGbBSOU/92n2JFr4yYEqzMv2PhlzyhI7IyqvXPiKcRP72r6P81Dzt1cN4FJePVz5nrwZmtA+p3HjRSDHZUrfxUA7Sx/wEp1uzOyMV0bv8NzTHK4i3JYFlWE+mCHUwnB2+e592ARVrPEDM8cSJc1ciwfKfRD/flitDFk87R6kXDcRJ7cXSC9OzMNVK6XvznvTgrohNMS1iaKpmZuHfL4T36DpMMk9920PGF2trkpJWe242vyE4HH/MRLEZ13hHbJNvCCOLN
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 09:56:49.6355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351e9ac1-808e-4f10-15a6-08dc548d8c1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090

On Wed, 03 Apr 2024 19:55:49 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.25 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.25-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.6:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.6.25-rc1-ge253a5c1b7de
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

