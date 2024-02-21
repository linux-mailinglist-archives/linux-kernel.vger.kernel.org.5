Return-Path: <linux-kernel+bounces-75423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616DA85E881
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B8E1C21133
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2435586AE7;
	Wed, 21 Feb 2024 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d3mn4o+v"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3812AAED;
	Wed, 21 Feb 2024 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544934; cv=fail; b=QfH2R1GjrQq61tctdNVdw3Udbg0vhfCSjCAgAt6JmDHJqqeJaJ+RcPJPm9WWuxXIVgEjQT9ab1KAlE+lMm0DrI9/2lZqj8BGsh8gl9FAeWdBE5BGZbL04WUAjIOcvXIDWbgIbSGA2UHTem0j0GWwI1TZtuBtQDJMty36Opup3Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544934; c=relaxed/simple;
	bh=GWqmv9a3kDBo0UdISuZ79ZjmiKPj2/uel+lr67vJOK0=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=OSYe3T8zn25t863CU5fZ3rMrUUuYbidPtD49ng5p0FwDLROf1l/3PQoXqPa+cDohz7SW1RrqbSeubtS+I0acbszX8RaFECoAldKm7WQemBKkzqfbnemJMfZVMGNsozpmMTxIhcmXcEtoWynflIifvInk5ZvoPsYv+o6MfRRt0uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d3mn4o+v; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVth8Z9MX/vXUDEVBbREUpdoaDU/3Exfo8kMtShNxzbqDjhnfqCMGnqt2sXBHbnHopCUpiruuAofZwC+vcp5wTlPXMIx+IlIWDxVtsbF55ThEOraKVAykkCVmCK9d/mrzcJYa3wVy2jahyLhRmHiDl+EqUsLVPxQgWY+cTARrhUvmwVKj9VAcR5XWHmEkGumfcgu7jfPHEmcgIDiq5EA6b92/I1eR6aYeLheu0J3AcvlSxTae81cVjhgBmfQiLTMysxTSyxM1n/5aBlqS5lEuohMCC7jWjVUX/8rfS58Twohz4jGlxJ4R08GGaCifRKXTi4/qTnIEHqeLamSy7XyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWos1l0P+308/kXXljV9xj5zSXzuPch5h60J+Mxr+Ns=;
 b=ADEapUKBu+c0+4OhoorQsi5JONqVJJc50YuI7AOOQpHmmBF9ys6fCefUwJBy0L1+vuKJwITyqFYHmcTl4Ych203fwINc6WTRCVG5oLmWtW1Ex5mdZWwQGWDExRjFmRY7gNmcIIajQ6S4z9veDo9Qw0esSWp7eiuPfHaHS83r5sWMRpGMGte5PXdxcbIs8o8TIC4TMB4mqvjiFfHftPsSWXyA7zIdZPSGV7I1pmnMGzkwoGlj2Kl/8wzwWy+7KK4OX8bxpIH4N7bdXDUMLDmyy5bQY/QFs2jg+FIPpDKDKvrKLhwgLVd1NG3oZ8j+T+aGpihtNK8I1QbX9s2inhlpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWos1l0P+308/kXXljV9xj5zSXzuPch5h60J+Mxr+Ns=;
 b=d3mn4o+vopxZ23IbS3JFDM7f9CKvii0z2k4b950fOoenZNekoeXncs1qpOaLBT0h1t7DIxxwH90lm3ptyJHrcQ5/n35akgst5j55CyeoR6gb4NkbROza99Z3s2uifUvWSHNs67j7BHnHwb/S+OWTMRpVH8G9jhnv54gcIFHPoOCT6LV4JPu+8qQaA0gq2zCRTW+80elsBY6JCyjYr7Qv5E1ATtVd6BtCR+ydGm6oP7LgNjmahGUJtzFgswgvRraBMxHAxCZqTgXrT8LYXnXjfB1R74SpWuES+i2WK8tsE0u4iA/bZ5f7eHMqFZpnbbyrOfmZ9CP3Jm2JmiafIgFYGw==
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 19:48:50 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::bd) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Wed, 21 Feb 2024 19:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.0 via Frontend Transport; Wed, 21 Feb 2024 19:48:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 21 Feb
 2024 11:48:33 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 21 Feb
 2024 11:48:33 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Wed, 21 Feb 2024 11:48:33 -0800
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
Subject: Re: [PATCH 4.19 000/202] 4.19.307-rc1 review
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <10d8526d-5f9a-462e-9c0d-58ae8dfbf49a@rnnvmail205.nvidia.com>
Date: Wed, 21 Feb 2024 11:48:33 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cf5e99-ee32-4123-c63e-08dc33161ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uwFE0asd8O+Ih89C1A5I032OLTOTz65UE/PZNwTGxpRVoM6PrCughgeYRkrA9HH9zVVmDbZaaDg6cqlZGnRyhg9+gXO3sJ9uqOjYa0i9sQkmoflKOIbcZC+8e3VIvV0MjRCNN61Ph2lcme9qQwN1KWMqRAplarjwrayzPKEnhPgUGagFPdwe9oDbi7XmUWrYHeFrOkz6gIpOi1qaHfvQnNjcf08AF4PqPW8WaDRzKpYVgf6kiuM/9AdMrH8u1zbG7gXRN7ESF6n2QG/BgBLhofHyyzc6j58TGsD4U6E/0p6IeCuy0rF2qbZ5InlIm0oOK7H+eVHogLBQI4jDHYfGggncqZA4tfEA3FNU/dSF9PVPVGuMmGYq/eN0wj71V1laTuLzSw7p3ZXFHoENos1JLo5jK/QD6vNSKn9iaJYj2LRtLIZ76vtpJ5n8MUrLLO6rCmdHxi1vnXvJhI23RzeK3fV5yxWWW0l7Q52XlNgV36jXWGcQEGiyrsnKTJ4Ti0dh8wCN0GQx1TroPNAT1zu43OmOOuKSVGq83Qf+xH1M50PuilD6BR66rLKtJ6gEHPaZh9FNdXytlvWB4SP1E5NJ7NwGHvDgTdF2Pl5HCTCaF19ghYZ1H8cjRNP9o+scwk1HyMqHo5j84AZ2zuVI+WDlDzcdLPmp33l1ObKNdkirVNumNaiE+Z/w/528q1PoVt9/CB/kH9T6gZJjJSK/B0JV9Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:48:49.6531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cf5e99-ee32-4123-c63e-08dc33161ff0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

On Wed, 21 Feb 2024 14:05:01 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.307 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.307-rc1.gz
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

Linux version:	4.19.307-rc1-g05a45288956c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

