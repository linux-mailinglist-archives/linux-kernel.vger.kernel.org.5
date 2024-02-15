Return-Path: <linux-kernel+bounces-66730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6C8560CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935061C21BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61612DDAB;
	Thu, 15 Feb 2024 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DUXHbvBd"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D512DDBB;
	Thu, 15 Feb 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994989; cv=fail; b=GOckfZxCUx3mka/HwMivfT/FXbArttsQzbMVHfB++CItNa48XWx2CwxdZ1PVGrw0QKevVsZgyAtl8PhfZ0bTgo/Is0VOPPpCPDPTZb0bxBBMKbYofzec+cBs6LG8KVcY7fl5VhAwkeYYTB4+lRjuvS9iP1fZZsa3Qudn5lNNfrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994989; c=relaxed/simple;
	bh=rAr0+IKzpSnES1jn9TlGjOMR2TZXwRpwceZs2z3YGB8=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=eZYVH+DV92I03Juf3K6MqxNp/0U+F9bc6brAYKeo2cqTT0Kdv2JbVxyZuQ2G/dOwvt/bti6lwlCBsmQbruXUhj0sd6T3xcrLUMxcwCr46VQOVEVri7QD9yRIUm/cMy5aJYLiQrBW7S+QQ1cSed03exfvWN/W8YqzWc9I8NDI8+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DUXHbvBd; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9EyryLRVw+LZQAyZA14nAcXOElwtFqPzt+iDmVK2pc3UH3252rrXxfcxC9/QBd7Y2fQU4SO24i5P9J9tQfKQaWAaQzkURh0gFV9Uo559tU1oW/JFa5P/dKLSNf7BgDGgFcjKL7r47Goayev/6JcqZgaylCywlVGD84sn6W23pROJNzjFTXrlCvYpm4fwgBZslplNzDH0vif2knXsekL9ZIMEWDesd0ohzeOLH+RrgYgOZaau7CJWrtB/ibzh+MLPFSNYUwXHaBBm0tBFN22ZBqR2QbyjV8uAPB0DWQ0cHs3kiEqB/7sO5C77U6TERNFhIIHn1rfAptAbd+tAzPhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW8OiclIrmH2+W4meRTXyiQKn2I/dRL8H6cFyzwMhOg=;
 b=HoECgf1SBBvSdnPf2DPITs1KAkAyOhknilHHOaQBC81APga9Uc04XC4c3fxHl8d/IJ3seSl3WoC/nGEoMRq9UUzihnA7wmzHWx0Ldg72/FHVD7YJqFazOu/iEO36IyUZMh134rmTMLftveV0HqmeqYefxKlK/D3VWwXVWAs2ZMONXK+moPdUOWTYhS3Z74QvcONImDAXA95Waf8expIiooqQANXOsC2wmjRTFMLIvF90S6LUQ5iQYAbFu7H7R8vFAF1+SLv1utPhtZ8oPhzCdtGfuQTQ5ryzJx+yPD/nxnNVH4A78kbQfpclG0BN/GW9OhQQCl+kqrUqn6YOf8ks+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW8OiclIrmH2+W4meRTXyiQKn2I/dRL8H6cFyzwMhOg=;
 b=DUXHbvBdKZN5dCcrt+DfI1URW0PXEs1oMAq+9Q33xzjnp70aPkdrVUnQIMbzSynFetGYon8yzNiNB3bThYuaLx2WfYeOkJ6Xz47ZureG21BXGvxjPo6/r/0tHTAAI+Klhes/4QRHSDNc8YiNcfvA6YQWh/c+24su3At4eYTNlGaWE1F65gzhEQiu8TaetX9OYvsNRUpXF63TmqskNeqCfg5EdH7WED+nVuitCVwg6fZ+XTy4IEQ/TKztVv0JXfLwSwFEP9xbp4Stu8PArWRz2dorIzDL2iyidzUnx7FOF4/50vP6ET5/oz7ImBRZUv1whvjf370kbuWZEFaJkcgt9Q==
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 11:03:02 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::a0) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.11 via Frontend
 Transport; Thu, 15 Feb 2024 11:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 11:03:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 15 Feb
 2024 03:02:42 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 15 Feb 2024 03:02:41 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Thu, 15 Feb 2024 03:02:41 -0800
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
Subject: Re: [PATCH 6.6 000/124] 6.6.17-rc2 review
In-Reply-To: <20240214142247.920076071@linuxfoundation.org>
References: <20240214142247.920076071@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <65fe862e-ab02-4b43-95d1-5f838c6b0415@drhqmail202.nvidia.com>
Date: Thu, 15 Feb 2024 03:02:41 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: b1993e8e-b8e4-44a4-38eb-08dc2e15ad86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8XWcNOLkyCIphq36zqpHV/wtCpzgUhWhLnBCNouZ3OCJhfvDzLUxVExROdCbtnD6q2lc0pgQeJACyD21K3IBmFZQdvZRExLdCkf4U5SLVlUq1vTXwPzOKzCjCUPQDnAoNhCzWk+CIV82fC23KeqokL45LIFnYo+UEqBTM955xa9QHaXT3LmN0G2ZH4+gAhgYz3UU/JaXqxVZ17KgwoAlrN2hJQCThKWecySM1McV6tYJb2bytVvb+UF36ZrM76uJwcCr/ResVk5d7Eq6NwqC8VfeDjyFMpbcJLw1On6zACcpgSny/ek3/SlbS786TWoR9bnApNv8VM6/JYC5jOpOj2+ly5LnMjmlOH+YYGAbYJc+4Yx1IYGaOqfBXlABtKqcsQnI9rMw0b+HGWkA+ZD498Czk4KVH1I/qMMx46bNbgFBgROQfPxfWxrTcNM/fDX9zAJK8/mz7Dzvp79GtmMNqu0YN/arHjtZiY1AQTgXrY+cyZzrNtBfTTPn+T0OqSiZYjQTp7fL/0A5VwNbcBynCnx6YtdQysg1FM3V0u/tv0sMmEugDHLmyOLALYR1+k99MuNsjNBI82/YM5mgWUcj8v9bF0K3QT0L1046ppY7tcsUQWlMOwMCrsg3iDde7Rmix9ZsaPXorZ96VJkSKUtljsIXeTvimQ7y7z88+vk/SZrf6VS4EXfZkOBM0oXNvQrcR7qFnEklKCLC/RO60oTMww==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(36860700004)(46966006)(40470700004)(70586007)(316002)(6916009)(70206006)(54906003)(41300700001)(31686004)(7416002)(2906002)(8676002)(4326008)(8936002)(31696002)(86362001)(5660300002)(478600001)(336012)(966005)(26005)(356005)(426003)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:03:01.9432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1993e8e-b8e4-44a4-38eb-08dc2e15ad86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178

On Wed, 14 Feb 2024 15:30:09 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 16 Feb 2024 14:22:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc2.gz
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

Linux version:	6.6.17-rc2-g36bb9c22c8b6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

