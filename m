Return-Path: <linux-kernel+bounces-142201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0428A28CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913D21C212A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442053E06;
	Fri, 12 Apr 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ql9Vvwyd"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA1A50299;
	Fri, 12 Apr 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909018; cv=fail; b=WPAD6srlqUhKeMU33J/GIAgbsgAghZrN3PKMCsFB+g/U5NA2IR3Nfl/0bl41K4/TIPwu+TW+u/YnCYLi4jNbZrV6giW8rqXzy+AkNpT7OBQcdAzzVMDGT5sNLgbeVQE2WW9zHR9+4FEVaEaxinnJS/iLY8tvG1Mt8uXJYZcEhmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909018; c=relaxed/simple;
	bh=uPK1o01R1dMwHN8xvYoFtusRb96M6w4o4wik7BVqZUo=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=vD413jLJdhsmiAbT8TPa6oulADEjwOG1lhUfU6kuaxf5E/nCoga/NZUw7RA+8YB+piRjHmTzb5qKR1YNrqfTiQ0JnyKpG/uE27kctLLGyTZmZlqj5EF4c98R/2VnJJYjJtfeU/OFKhMZNbJDcNAKt0mFtIifyd5AucIMo0B+IJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ql9Vvwyd; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpJdgESCqnMXO3zD2594q7+QS5B0oytnnHryPEbd9147XktPDZ94NBTrW4J14v5bWZYLht5l7Q+a/smjk4WiMrPYLcDmuSs2iiz5ucSYGMbsekJqsch4V1UDs9J6EaVxrbax20kye1pCdd3fx0Hc2tP2JUvQ6NeFtkH5k1lPaxItrjL/32MEhPGEXkN1pdKUacaLxGootrt85J37lsJc4aHq9PWhPyRbEFf0rFhiBhUSDBp0vpGLqqJ+rAXSdcvV2EHIgNA2cjyRNPIZyLw10QBDKva6ZbMSBXS5zWZHzGKIhYex0V3f6mgMHYBrJqYbJuIB3Iv2BjPCZgldYE9/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0S7cwzGXy6saW3iS0sOYFjji+aoOtViEWX2LCEAbvU=;
 b=FqRwvHIDmvWu3fCkOGU6yhymrqN5uJzm2yumNgJykjxSnxNBp+B62GGY593+sjEb+Jk2xNetPedop8m8AroRdZxtL+tAi6n7eDrtRBe9t3PX5skdPD65Z7t9lJ4mvdz1EBcUpju8ZtLklG1HKomI/JGQgnHvi5gdbsdIvWVNt8rmyDpQ8hriomGXqoHKsVqfxbxsU+ZhxPJE9Ol1FbwOU3nnjJYsEYCoPEnhT2rjUVACktOjclyJspvIztDwtlDxbV51xd5TfZI/bHKP7DoyCoYdjsbLWZcr/MkWtWYop3C+E5dO4MfAnbmfdCSsLLciAdkqyVnLt2e+zZPQ4e/k7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0S7cwzGXy6saW3iS0sOYFjji+aoOtViEWX2LCEAbvU=;
 b=Ql9VvwydGUnXhRFegdlj5x1L0h3TK4vUXJzpwnt2Wt0K7BKfuiBj0CGqaOYg3IjHpXXXn4daeePwNPkj4W+duYioswVlGXQ/zMNM5F4zcBUE1TbhuMKVQIfmCb26xoA550qHLHU7c1QR7hKHYSw4qCMHXloycAL4VN2DDNYu22kgyECb9MImacyboWgfDbOVy6SioIy9nE7rlrxP6pMFeahHlGJ5oVx73KnrVfFbUKwF34cO3+v/AtecRfqnZKOUAc2/R+GLqJ6DxG0GBbhaiDqT0LIK+bflQDnj8XDzdoilnKjBWIN9mqXpYUL4BA1FQ0y0kjnZyw2bA8OKeNgilQ==
Received: from BN0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:408:ec::13)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:03:31 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::dc) by BN0PR04CA0098.outlook.office365.com
 (2603:10b6:408:ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 08:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:03:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:03:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 01:03:14 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 01:03:14 -0700
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
Subject: Re: [PATCH 5.10 000/294] 5.10.215-rc1 review
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f6a6635d-5b04-496e-b8cb-f7ff32a7182a@drhqmail203.nvidia.com>
Date: Fri, 12 Apr 2024 01:03:14 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: acfc9396-8da5-46cf-ae5a-08dc5ac70aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N2bYi7FuM0cYBFZCBylO2r/hZnd7dNHhYGEFFJvmcyvcuI+PReF0cY31e1GRCVok4EofTqL8rzkccDRDx4bmuaHR/KGG0MCWkDuLJXKCyPOaflCJHkfVWsCjgPMBwAPHhNHUdiHKrKPmNvj4bBWJ1+THm9afWvY49oQOJY3cDrbty+w7ACofHkTSkNaKlEygGDdjuxUUKOjQV76Pk02SfFB2/RxAoo2l0Kx8BaLMTJyzs632svszE8lAabaKEcdGaW6/0egG1W+1p/xDXiHRZ3xUOqNcAq4B84PxPz1y+6iq1tIfDXuaBuLUTVqLPQ7zOgmdI+eFrNi23KeOnwSasCKJ/P6TnHEpvCJCeYPtEIhvJqpkRGLtUiOv8NjutpHPuKh4+HGSBP+dq90jDotjvGFNmKD/cEJzJM8VcGVTKlifi19akcica2/OXJvof+HRyEouFVVq+cfCWRUKdJJE33oZ0moL+2QmZOQN6TWheHGkv8uOKVsSnZYFa6drPq6/7RLEsRNDoqK9GqgdDRXXmuMgMh3xlUqVyZT/A9dDljGRUJgIUjRKR7vB5eCrKQlBnLZ5kkGWgaOzZ97+Au8ianhBbmSQnM/YhSIlBkSV/S0RMe8AkUVK6CTAiQ5Egj1QVfJ1tPeOR8U1LDOR8JUOCHoyqVU9NIbVnIzZDnWfj/dmcqQ9osbPXEJfU/0303QBGbQe0UDOvar/Z25T2EzzKo1rA7tF79SXpbh9t0Yhf8TnMyvzZUhFuKBw7/+j5bv8
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:03:30.7256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acfc9396-8da5-46cf-ae5a-08dc5ac70aff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271

On Thu, 11 Apr 2024 11:52:43 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.215 release.
> There are 294 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.215-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.215-rc1-g244ca117cb3c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

