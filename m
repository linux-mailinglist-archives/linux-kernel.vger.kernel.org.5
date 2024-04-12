Return-Path: <linux-kernel+bounces-142206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99708A28DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A9B1F248CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15AC4F5E6;
	Fri, 12 Apr 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgKNsLns"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5F18C1A;
	Fri, 12 Apr 2024 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909096; cv=fail; b=iJlPco0Na6KvXIKVdPSyPJqH5kyzenjSqaSFdE/EFz2FdnY8iKhjF8wXHo0ziDmzLMMhIGMODblEmz8IQOweKtfE/uE8gAty3JOkK0kw8Rr+iLqlOGcJxV81VJUbu4ZUXpfTR9R+hU3BuMxxcyyekO7BOoQkYcFqBrrbF5QcurQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909096; c=relaxed/simple;
	bh=JrM/uSt0c6YgFTc6Ttyq9v7x9AsoKzj/vtKc9AAqz0w=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=lyAa00AL7w9AvhtrwzWMDIt05pVmg7fEA4n3aaQOBj0TSw9SNym81YYZ2rw67F5ZasptjPsOaJMkigyrou+2ehN12rQIu3mvKzQSj64PeEsAkf6rjw5h+eR/E8QpQsXMTJg6uOtEZcKlPWhJTM3+JO32oYstHleCtHV4Jovpj8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AgKNsLns; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzeyudLvvQfU7CjN7EU7+V7UAFehuu81bElO/IbOQRdEMdMph5rC1DCXZ81QO7ZKHofZm5jpKPSMnn1KPu/JheUAhaQJd2KyIRjiJINz5Lo21Ys6mX5r9ptfNnDQ7MtpYxq751Pz4Lq5IQqgSwbBttDYxYKhxH5ZsDDAi2tFfL6UKU1VEGAFVn4mOIKBWT6TVPAqRJkmhPANUZWPkr9U1srLUQMAZiqqpkqnwxTdgr/3/v2HYJDJVyVqOOKEMZO4Dlf7Nfx4JJ2jXsSHyzwrLpeXF9NO9O7zFdV+OQCYZ4rrrIx40YA7G8N2C4qZvadkdwP0ywZZQTHAtR+S5CS61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DodTLhPCmJPQsP/P1GEbL4a7Ac0EalIhM8DIJbFl2g=;
 b=OGPIocHjD0a5jY0poRtLn8Kb6vfgfq8vQfcTjVNAqaL7VrRRjZjl9sxV2C+HEIgap9ITU9hfHOgv4LbqlwNASiJteBuqzfRZdO8IKLlw+jk3qTHdfKQTZxvOW7qni1RxxcEmC/k3MfOrgbZruXPe6YkPsoPHvldIwJ/2Ktlun15M6c9mnoiHoNTHRkmp3CwnnHYFRltELrYN4HT0gYEaSfpq36u0ThKGu1T5erA5bbiIpXU/bttk9HNqxIsSlN9bzPKErP1X4BGyJ/QjR/Y2jkLBJEOszE5HaLkfgC7+XRBoOeQHEWhc4MshNVOSUHPIZ4qY5667KT1u4CTvqg6gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DodTLhPCmJPQsP/P1GEbL4a7Ac0EalIhM8DIJbFl2g=;
 b=AgKNsLnsXmI1BWT+qJg9R2r321J9wwRiuLXe+XORKaCp8VWj+sBZ5yfRq/1O2Q4Cb1kU10fs9YlnZgDAIS5s1VSodbbfM2ZqNjf9T482f8xQ+RDXILBquBQUrIb+q1gwGXhRck4Tv1rfHFKeWf1gh27wtLBjUL9S10JksbZqzPm7dWEGquH2tz1t52zE1cXNn/P4Tjz3TJZ4xXbHse5QxaBWETk6CKMPO/SxBDhWRyPk20yHd227Slm6YzjlBu2YcCxDDF4mXfjRnK6Rv1oQdShaUQvlxnBoDq4fK+sXM4MflaXUWU+scr3sqM4/+CEscLnnU/dJl7yezRV67u6U2A==
Received: from BN9PR03CA0629.namprd03.prod.outlook.com (2603:10b6:408:106::34)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 08:04:52 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::b9) by BN9PR03CA0629.outlook.office365.com
 (2603:10b6:408:106::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 08:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:04:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:04:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 01:04:42 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 01:04:42 -0700
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
Subject: Re: [PATCH 6.1 00/83] 6.1.86-rc1 review
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
References: <20240411095412.671665933@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f6ce33d8-da20-4ee4-ae4e-149857eb31c1@drhqmail203.nvidia.com>
Date: Fri, 12 Apr 2024 01:04:42 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbdd1f4-9855-4629-b0a9-08dc5ac73b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	giYWHIy2cdSkZTvLC7NM5z1nsF8wQRB59fNUe1w8Gz9Qj79XZZsS3UAJm6wwmqUnPd3Pj0mefQdmX2VYPMFfQnh1b6OsY6iBgUV4pmXqsOPu5o8Yfcw2HVK7an8gbTORcoHk0P9inKkXWOcGhTTRjkT5hgSh1L4zDN7Y91PTx01Qq4+HPsenM6H5kty5aWFGdNUPdpvg1Rmtl8Fqu1MZJk3nIJUftwkqABaJPGqh42wd2ABeN/gtHEQ6ScBHhKZNfovleN8TOED3mjVhJiR34jtIKgSXyN9bp7Xm/o+vKab00VeJCsnY2biosThAuYLMPDP68cKipHNIL6k16tqDot0mK6D7zqL6bSWD8UFqURQpu91FyYwMywq1QyBIqq0uiRMOJKuHwvU3d/ygxLRxTqYjJnbm9oTcH57OEVQ4YChY8TuCUUui6krmLO05WDkRgXCJ442eIBFw3Ln2YYjzf8bl9NbhIgrHJxVSbNEYnWnZ6SJeESy6J3MVcoYMTaZrynIwNxTnldHmDuiNvrBPJ6qMfpEW0f8kxmTbPlS7+OysIRCRMTE9+TEOje+8uH8ADxMYDYvyJAsRrqs+VdS2+SEhRghTqkCZ2hKW1xxHZIWgSuiCWDloQcYMjSfJsaUuwK1m18oCbqLjVR8lenf4sQDGg3v7I6nuGWGkaWo76Nj1jPMlSO0XNsxDTEdRXlTu81GMO7Y2OucaUXmuNB59KVoBj2bWnnwhghLk9rzfNSnLB838njJxqtQDxMM6915h
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:04:52.0125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbdd1f4-9855-4629-b0a9-08dc5ac73b70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793

On Thu, 11 Apr 2024 11:56:32 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.86 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.86-rc1.gz
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
    102 tests:	102 pass, 0 fail

Linux version:	6.1.86-rc1-g2cacd493e299
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

