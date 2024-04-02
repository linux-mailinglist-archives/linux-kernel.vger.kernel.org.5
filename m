Return-Path: <linux-kernel+bounces-128550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA76895C4D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5542B2551E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCBC15B579;
	Tue,  2 Apr 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/fHA72G"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412615B55D;
	Tue,  2 Apr 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085282; cv=fail; b=KTGRc7pwEdfZd2ovZxPiog+uXyQ4Hxdp9QNQMc6pcNkOL9R+zxciuq+tyskj8ihRqIH4qSpzlm38d8sdX2fdhTGxg0/Mv1bgE/XSPcp58Ua0LFhzXeWSU1DQ45mC/wLUhtNfo1Vc6btc7H6mbNG/NnpfdZjcMdLGLBFKapUHV5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085282; c=relaxed/simple;
	bh=+ZMUg1yhewFoWbtE0G+OnRMZvtXDgD5WgcpuA69LfLw=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=Z7MdU9cCGs9NN53lyERSXvfMV/oQXeapkVpBgpjNiqPmTUD3Nuw+K+Jb+oMp27PyQyvDVE4nzbshvRJE0qqQcneXMLlJvJTE9TkpLInjASxhIC1FIAEOSveF5DN8/3bGar5dd7iE3vczIKID9iY3YUwXhP2WpalMAitEF8oYK08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/fHA72G; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbVFppTApncXCdAKDKoR766HupFnSOCI52kh2zkcZyQRNqSAjQJmoNqDckywNrz9jd7E/mYf0iHnVAuqF0GqXD2G5okfjEdhdOMArVGYbGKBeU6bMRlTV6e+i2GNGSuDMu8R1EKVTHG+sPRwsfbI/epYETUVCMb++Equh9/Qhp2STBGjHds3WAJh6qtEozGYyNcqVmXy+QMn2PgvAtki5Zc/IEqsUg/05OXuJhhNnhFooHHnIJSCHkTQYsVAwHJLghA6MCeHO2hJX2qdgtawdfqsMqMDPWsRRpvhe5HBnOWjHRHbAcJMRxoIl+/OQrptBKPIK31NGtNqYF4+4589qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8NX2iLFUxoelh8b7DkuVT0L0kRvyEvaAumO6Gw7NrI=;
 b=jttpmKnwSOgx7FI9Y/De8fglYHnebXaMQgJYEvbZq3zdXyivF1a5rYeR2gzng9rN1L/073N0KdT1eQGxUH1m+mUY5ofduCFSrAFJAX+LDSg4WtgmLE8XWpfcPZOEpeTLHimh1fZwcY8X9c0i6ByVsI/aDFBtVp8x63m0+X/eNaO66jU5bxumUHMifuFXHRjkIrabOiA83rlKx/7nUGQriDu+ZrcExEltlYDRQSmFLFj5GJ/ARxGI2oC6eMzuKQTYJJ6/nSRBibzZ5wkahoDyn9VaxkMgxM5khwiDoXFRrJYPfuMdDllS8+q0xV+i/lVL0mMqSHgfYhLDzlUFAjxV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8NX2iLFUxoelh8b7DkuVT0L0kRvyEvaAumO6Gw7NrI=;
 b=O/fHA72G/VivOfe0X6LdWf9mNGoAUgFNlxxKe5cPEgehugcOqAUVoF4M3OyLStpMaZC+CSU4d7YujeceGYp1ZrL00rbnj3qooVEBCMj1bI7xoYO5zf9IsijZ5ddb5p6mW2cxbqOWRWee3JZmHLl0ZtTRNzVyH8e3AQgKiNNFwpliygKicyNdg8Dv+66Bw7xXzB87YbfcwUep1/06QDEz7T0lm/Fq3xwOEyx11HYjzaxldubo1jhexm3oYu2wqv0vw/PS3q19snLQTpbXsy8kIODmsxZ5LdzVs6waIYVBqJ/uIFW+7DFmj4McRYNtuLbgifItbWif2tr4dumkZclnnQ==
Received: from SJ0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:33b::17)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 19:14:37 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1d) by SJ0PR05CA0012.outlook.office365.com
 (2603:10b6:a03:33b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Tue, 2 Apr 2024 19:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 19:14:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 12:14:16 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 12:14:16 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 2 Apr 2024 12:14:16 -0700
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
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <937b3b2d-6b3a-4a5f-9976-ce557189bdd7@rnnvmail203.nvidia.com>
Date: Tue, 2 Apr 2024 12:14:16 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e36198-219f-4fa1-2b7a-08dc53492354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ssg/wHgYZCQ7Lt2uPqZVc4q6alsEnZMjGfN3CUGYiET55IXldvrTEyrnnueUWHV0yspWG5uzTVJt//d4hO4amQHA7mWg4f6kJ/1Vm02+g4O5m9fjMM69ioJjrnuHLRHZakL2+QXb82KqWB3Sgbqe4WElgjUdBosqc9XZfmo+L5yqXIdN5gzvBupASqS4za3qkaYT45xOByp6Km+C2RTFz24Mw48MpjGP20aFiG/ToPqlITi9GrWz/Ujj3HvEzwRe5lNljvxo3qoDDY/q/AnKczCPR47c6cgHdL7RciyDTMCvsbcl/PwuNxh9qR6QDOXcSb6g5PgTcNj/39QiICHQy+WUyJDNZSL6lR6eaV+EZB4xWt1fvx3cWt9KaEHh7U0Q2MPs9mYv7nEfybc2JQPEPAg4TOtkONiNWX5dvUZsSbFjgSkrmthhcyi+2kVYrdZmAHo/Jhq0weQoH/EF5ppIODIyX8ZUAyTNHRvZvf0Q0DQBn0gAR0wzU/KDnuChKo8kb7pne9nLhEW/0C1BkRD570F1eRL4DANDPYRNF9k0EEwsmPwofIc7Ly856kB0b2BXqySfsRBOwpHlE1f/wuh/l6pG9VPRt7v6LESnvaB5MAAjR3TT0vNzA60fYDKkKMmp38Klj23uXrZ2L377aUjsi360aQAofh4tjNnFS6AtfTEKYqVzjxFakABEBWqnUq7YRCRMbiSQJoDz3OruODF8L0LemBdBqzyQ1soc7/bwyQbGUlUKcaoXHUHBWWEk/oPX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 19:14:36.8798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e36198-219f-4fa1-2b7a-08dc53492354
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825

On Mon, 01 Apr 2024 17:39:47 +0200, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
> 
> ------------------------------------------
> 
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.7:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.7.12-rc1-gb15156435f06
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

