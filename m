Return-Path: <linux-kernel+bounces-142423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05E8A2B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106AB28436D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229E751C50;
	Fri, 12 Apr 2024 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ILlPoh4K"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA750A66;
	Fri, 12 Apr 2024 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914817; cv=fail; b=eRcJ+ECeYF92l2AVRgt4b5XwXlQ9aUO3O/lyDc8pXwnwcKojcFgqjiTPWx5jeiKKKCx+SD74W1rPoYjkNoxqkqilhmneQOXk4Y144mNJm+mrtXsJErGOqxjqXJYaEncTfofOM0Vx/GLgNiA4wRWh1UVNMpuUeSoltNcj18CyPj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914817; c=relaxed/simple;
	bh=F6Z3qYXm6T6W1spKq6CPqnoI5vh2OtwNMCWQc871P3M=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=T17mTPUWuO8jGoI69UgMYRPirroPgG8zypIL7zqUzJTz/zkmrZJRBJQUeccXK9EsEO+yudRoiTV6OBOC/NRqEJphlDZv/uPyLN8CYSrNVo91Ge8aMgOxZjE49RVYCH9fzxAwGcfzG9jvgSHfPp+PMC0q5qfwiIgXmgSEbWQpiqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ILlPoh4K; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keevAeNI4KL0Z3Qtp4g2QPq8GXQlDQe6U6sIYsWpgyZlbjkd+NxZpOF0VWm+S25pSMaNVN5BO7dVQRRZUrTGW+GJablEbSrL7JMxMPgDH6gaPlgMJ1oH5B41I8jTduAS9MeADy/sXDEW72FEOdCYJjuMzEog1on9vCp6rdIJn01i9EsFkKYdhkdBPXvouIfzC5GnCnmk2aRitrscd31BeNuwrSYilJ0CRB0SxSM4O/z1m0b+p9vQdAvPRfxxw2LmqlFYCE/JLu7ps0HErKwf7OE4ec43gl+EoEBA61ZSCNBwzlvammChlpdlvS/LoG2Z8oXew0NbFuzIkMevLOG0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPecnokKi8B7ZoG2acLDjE/K/mRXmOOJHnoPU/tsBmc=;
 b=hUB4GnvWgnlBe/km/Xm3sGz7NtXOUEptT+kMJKmz0P/uQcriiPgaoDp7QOc7ocJxgaWUjmkiKjLuU5dtgPbJsr79j/vaVcalbHInpOaEVujW0cJ+s/PFM/3ISLK4pg/Hx34lHPP0cD3Yu8IZekcSiPX+bsNWSiYw4cUjMgZOc9MLf1yI84W7EXoWlxX217r/fkuvp4u6UwA0nzNEQVUjxQqphYb8q+aaMTVUDjJFuMVxS4qHqSlbKK7i00JVnE2WrHYEiQb2s2/KM9hlDOT1wmkULzWBqZldbz28hERRQhYRbLwR2leZjyrU+knB6zwXNGpninHQQVmDsWpJnvR17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPecnokKi8B7ZoG2acLDjE/K/mRXmOOJHnoPU/tsBmc=;
 b=ILlPoh4KLmXEFat+7xcyw4pdYcr+dJtKxDGx0z91yoP+WlvFLpPxkjCift5EI0YAtPaVYnB4U55ta1X57TMAhsOp+me59jftiXUPVUliLhOmrBbhHYKE8ZIsX9TCALS6JqcSoo45rEZVWqMdlpSWEGDsTgyXYuys9oDxjFBuSpK/Xv0TAOXHPaCsBwnYpjdSHWHbM2yGDGwB8Zt5vzJGnrJFESFZAH5k7FakTNko658Rvxx2L1UWdeqAiaWDsRNEgVppgJEGxuUL9/A//cLn+AjBwHMEVRi63iR7WwFdtV4q+Qy6yOU4pGzsLxymqMDEEYQ7BXObFZrGSwk2vyL2eA==
Received: from SJ0PR03CA0386.namprd03.prod.outlook.com (2603:10b6:a03:3a1::31)
 by SA3PR12MB9179.namprd12.prod.outlook.com (2603:10b6:806:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 09:40:12 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::91) by SJ0PR03CA0386.outlook.office365.com
 (2603:10b6:a03:3a1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Fri, 12 Apr 2024 09:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 09:40:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 02:40:02 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 02:40:02 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Fri, 12 Apr 2024 02:40:01 -0700
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
Subject: Re: [PATCH 6.6 000/114] 6.6.27-rc1 review
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2e89d6c2-e46c-4ce6-aa25-b12677f98f66@rnnvmail201.nvidia.com>
Date: Fri, 12 Apr 2024 02:40:01 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SA3PR12MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cadbe5-24b9-48af-035b-08dc5ad48d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cQVmCgm9jqaCvP09OMaFcWne4v/9HdZKTa6C13YiTTqMBPvUg2MXjfxqt7aGrPoD0gPY/9W2qnjxSKmv/jw2RhIXth2DTzmAm3zM/bjei41+VXIUuulR91GhQM59OKciokGv98xFAxlgJjaLQf9rA+DcMJHSK+f47PnMwhRiVNKXZXULq4hTa5XR5oCo3xpSCQcd1Ro2gfMvwAqiNaupMa0r6keV1XH0jmSso+iAzSnIqp4+C6GrTOTgqWKX++FFNfG5NEv/7aEdXLKE9sDlS8DPMGStHFJhgMDVzck9wFr/tDjpDDrc5p5tbzHSh9HXuo3oYBJfqt80PGZgqlP2Xd78fTb6n6UHDuI+70g/v+Q38fH1ZPxJ1hgOyGkQWC7Dq9OIaCjRqP6qojWUnGtvS71Wi/NzBVYz25vSfMOm3DzBgx85Kg49mZwtjsQ5++JVUB/fUTGBIjn8c/GnowNUUpXDQWcDy14xe+wTgyWquHheo3242FZ2TfpYhfWAe+bH4Itk1ri6wDpT1JIMxPLMrT1fneMncrqWgeXYiVIVnSxdO5LDIi6QlQjMNn7g0rlUJ9nLEIny77q0NuleNkYcbQXzH6NZsDnYeQl/BBQeeF3/dWDr6CkPqbBx3tVr6uDkkf6rY5UQkHcIxXMcETlx2w4jJv84VlUlrBbt4qXVD8okje1yV78P+O0t+1QPH2WiQjRFmUDiwVsvMXt+K2uXpGV2Twm9T9hHKBWYzOTYazywpiFyy+KAn+Zg4KmzWtmt
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 09:40:12.6253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cadbe5-24b9-48af-035b-08dc5ad48d25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9179

On Thu, 11 Apr 2024 11:55:27 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.27 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.27-rc1.gz
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

Linux version:	6.6.27-rc1-g3126167a036c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

