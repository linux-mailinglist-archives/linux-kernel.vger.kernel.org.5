Return-Path: <linux-kernel+bounces-92674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB74872404
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05241C212E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38E3128827;
	Tue,  5 Mar 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kuGQsUXI"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C2128829;
	Tue,  5 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655729; cv=fail; b=tWdNgQetz+QCIcQHhBLHObwq/wmoOe5bEdm5pOxgwL7c2i782viudrPqt5u+cdA4IrCWCbUNHR5y0Ye6y0d0wMKMK2meqRuSL5PYxdJIEj2PGvsklh6QvT5lPxpmdEaGfxtMDjbSLqjdp69fcJjOynD3VSCVzU8DNkXX3FyNFW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655729; c=relaxed/simple;
	bh=pYn0p22yBHnDToAe1mebpDy5vAZLy0ffsUIlAxBGBfQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=mYThjprGhc3wj1JyE1vWrwm8XLxvcwC1RkuAs/tQXJ9WJeUwYOvUrDPQ/bAHXHneQzLvAWyvGXSViVBBJ2K1qrbGQx2LL8ZsvOUjOKvikIUCVP0ZnDqniLYSTf2EqKII0Cj0aKXr5ZC2V2n51zIuG7Ttag4IrT56lsK6trb0CNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kuGQsUXI; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KakWv4bEoQ8hg9PF5X2vgSJ5/DBNQ9CxfvVqC2//T7Xmw33OZ/VKKuEZXHLrKmBGFgm8BYp2Lc5zQNlF4FFSEkg2Nsbi03jKkqwt0hcQhJRsBE52Kqwj6/3d/gqk3FKRXETct5ht538akbFwhdiyWhY/Deq5fxDr5rnqGX8VQfENVmqOxW3z/pUzQFf06lvS0rzRRNmaqS4xEgc+fgBP2RE2VySm7LARkFDTTGLBrW8dsrsmBDsFCToyRMtryd5ZKDFubBTrkEH+AQ+ArNSY8BpN7jCNHuDNgWff6pPeIAqf3/fVFOUsaKbFN+BEm4OVM26Ak/x4Ym//xM/fkSWizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLyUZMRcAKZU0LIPjs15ZpoFdhKC1SGDJvjuNMbIhjg=;
 b=IdKCkRvBn6zeG0+soYlBVUelucr+KizqgSoIKCumyMcs+8QWEbbVrQz+cTY4YlrYu05dVPOzs7ZriF18XWeCiNwjCMw5amwpG9PmDyj8fQaKm/ncXprF5+8f0jFCJd01/llG6vkxP87J9F/+e2tldjKq7QkeqlQjvYnU+SJvSwRz1ILyhittAD+V+Hw1QEQRV9nlW7XTgOOa4w657JkhTs0n6PgkoJ/UC92+TSb7jvbcPrdPQ0jLy+KX3TUolp014ZvIT7zWw+fq1hgESLDoKUnAxqOReBon6M7rAnETLDvu8bghDLSUJMujH6G3fe1Q4r/IN0ec7zd99vvoejoQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLyUZMRcAKZU0LIPjs15ZpoFdhKC1SGDJvjuNMbIhjg=;
 b=kuGQsUXIzP1FhoX5yw1jJrlKJ2bp59d4QB4xcxTdCNreZP3CUREVL1J2BxgAG1A186IcsKhq8bGyJSjnmr/V5EWujsi0R2omAQ0a5XLkbI8I1qlzbHJtDDB3bHkku4C5ls4sLoS+QCmJwMXDi6g+DWgtL2ciMk4+WOPUxnNO9vt+B15fsGMG650c2ZU2ELjwIxDer9tzi5nuwNb2kQZbKcCDiVrHkmwcnMWIe+0Yle4NRP/BFTAnnY+xDGpFjQtl1uHFZCtF1pzQCwFG81MQDet5iRgbyzhlSY84ta4fJkCr0BQc+PgVfF4F2PXE+nYDCFZbj20Rgjijgw2T/9Xdng==
Received: from CH2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:59::13)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 16:22:04 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::30) by CH2PR03CA0003.outlook.office365.com
 (2603:10b6:610:59::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 16:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 16:22:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Mar 2024
 08:21:43 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 08:21:42 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Tue, 5 Mar 2024 08:21:42 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
	<rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
	<linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/41] 5.10.212-rc2 review
In-Reply-To: <20240305113119.020328586@linuxfoundation.org>
References: <20240305113119.020328586@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f06ec869-e4b3-44d9-ad47-924b38e64a78@rnnvmail204.nvidia.com>
Date: Tue, 5 Mar 2024 08:21:42 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcb3943-e58a-47ff-dbc2-08dc3d306537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NJe8fU+LIr4X16JLBN3fqt88Lp1JSW1vHugAiDaKTzqWO9mgDaB+poK7sXsB9+hh3JrwfYBwo0Moi+wxo1LJyTj1MJ98ykvqZn52fe8zI8W10q89KwnGfPQj+JA6XuhItXGC3L+OP4TWOF51RU4I4lwyZhLTIA8HjjdYxaxFVAU+D1K4oxr1NuQ5E7q/w58KvrMVtUdGRyI5zimk54gufaNWb+fnFZgwsGFQuxMnbH//YsfcvC2U9BnYNY5/UmUcZXi8WOdUfIMFf7iz7tkmK4LeoLI688oOIWFfjAMGpBZUKCyep5IuJR84U+gNy/4MF0oi6ybw2dz9/Ci4jQP0VYQJhyUoj1WtYIQI0gNXX9j0Xpri5NEAuFI9JEqDnFk54FAiobPP5uis8lBDTA19M4mL6mzjvlUrK3EZoqc1meJYsGk3liPMlH+TbqUgor2GB7Hmw8bKHOWS0+bsT5VvnTkL1Z3cyGTOnV2PA6LGYkJ3MZcOg5DDGSYMshVQmc5VWlsSao2O54YMYszuGw2K2DjRCfiLKy+aqL7JHXGwXI1zPa1+vEB4HxEnoH9046U+WJBtOeUW4zSQAdAhDKoWrWgaD7THewy5ylFPexOKB5ESJjsxxtUKOh6N0h3noqasQa4R5efogJwaIzHllSN6Dw/LvGTsAELfW+dDoKkFoxlC71zqggRNw4xFPkVZO+e5Ykqr2gtFzhAMI3I6S4NuYjnhnL7Cmyi9cMtKRbAAc+xGPnjwqGvxR+BNKiKPhStg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:22:04.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcb3943-e58a-47ff-dbc2-08dc3d306537
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394

On Tue, 05 Mar 2024 11:31:49 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.212 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Mar 2024 11:31:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.212-rc2.gz
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

Linux version:	5.10.212-rc2-g713b6af903ad
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

