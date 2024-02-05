Return-Path: <linux-kernel+bounces-52701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC71849B98
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FD21F2350F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09E1C695;
	Mon,  5 Feb 2024 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BVm3ujhY"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3A1401D;
	Mon,  5 Feb 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139108; cv=fail; b=ZyGszrEGg1ThE14FKehXBc+cOjGJTlFwrhi+JE+F0Ox9I2nzkfKO+ZGP2FXU/ZN7Vzczqb5mj/Ni7TNOjluWjF+4aBiYW2T0cIY7gx8oYN7xGvnkJ4RkyHdAA4iZnJZIgQ8ZdB5nxtrOkAHWF5rA2tqcqcYw1RE6IsH2suSjaCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139108; c=relaxed/simple;
	bh=PUviv0c27oa7u0UqGoXhgKi4nR5e8bYV5JuGLaOMujU=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=rlqeL2X9GZB9azdATXnYBHtfQwCtoi/M041L9srQgbNnOgWBFujpG29GiZhe1ZB2Z4luAJU3pg6VNHGDqwonLyOC1rQ97H7pI5YdzAhLC/KFkfTUXn8fIoUXJlWMKOP/v0K6VoPSkZoQlfeiExdFCRviQ55j2DgRLjic8N8yu8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BVm3ujhY; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY+2RBauFBKbowcDFZqufSJhLnk0LVGazeP6bZjC1V94VnDs0MW3UuEg9fCbkHxeVRzpyXRuh7veh6xQxptjqu9kRYA02qIv5NKjBd/UAqWJQTCehMxkEXolL3rUG9ZXyJyXh1f1C/Z3rITP7KsjiL28TJbMgwgCh0G7X90pnPekIf9RtnkzM9/R1txR8YGAqhlGq9nKNsAJmxNKnAikHjmNuUcdjJd8CN3ht6rwjAvwQ04BJw8JsuLDtAxGSUxo8NS7IOPL6yh9R59i3wuKVrc+G9Mn9KP6xnCeAFGdf+BCXrdkLeSMb6EsArvxybdmnZGsofc9odUg6NG5HFvxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDoMMH11T/oxP3xf8mWdbHcDUff/A5FJFecVHIQwVOE=;
 b=RViSENtj8U8K9XhL1kZPIiqQVkI/oC33lx2jYdzxBEaXQaWz3TqRQwMlrKLRUYnNGx74O5iOU1pztbcd5Ds9mmTIpfLwBmSyujurvJOIzFusoQA41ZJGyZnajsFNVOU2dOVRF415xkxnG3x4FiZ/nyycSgGWiocbmYxJBfd/gW/Z1Sx8kDLZ3xoW+T70RjYupPvwq2ePK1EW2TMBBnbUQTyRUgcJazKm5dVaLIKnPyvOPBnc7p+94r9FU0FFpkHFH3xgCbSRhOxwRMAfxsjcdDJ6MA5LE0/AywUuF/5mwk9FSnHfC6kwLUS0Aw9CaBDHofZISVTwA7s1IO2/kuD2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDoMMH11T/oxP3xf8mWdbHcDUff/A5FJFecVHIQwVOE=;
 b=BVm3ujhYn3dItTJ/7LjacyI1ZE2wJ+/L5D+Yn3+Jcb5PTIvqXpvyanw9IdrYwsWI8/+WKIYTc/ZbRsKS3TSFv8vNjAjVW2n+cYnrwV3fkXwf4V3IaDf/SQAF1j8GFM8e0Nmy2qXdAaRIGaupQF01yW5J39RENhS+YcjigaFGs8RCwcbCV8osZgWeCs/yTxFNxtBnnoZjVr0h/J3Zplk0p8UNCqcDhhNt8iXcIIE3w5rEBcQXePIkPw3RpKtN7zdl5gZBxitz5zzucpPSmqZQTu+x5B1hH8pdZwRURliYppztxo7Ab6X+6cGStXXQ2THpEgAHTfc72yH0ZdajF23Rcg==
Received: from CH0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:610:cc::34)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 13:18:24 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::b5) by CH0PR03CA0089.outlook.office365.com
 (2603:10b6:610:cc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Mon, 5 Feb 2024 13:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 13:18:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 5 Feb 2024
 05:18:10 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 5 Feb 2024
 05:18:10 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12 via Frontend
 Transport; Mon, 5 Feb 2024 05:18:09 -0800
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
Subject: Re: [PATCH 6.1 000/221] 6.1.77-rc2 review
In-Reply-To: <20240203174756.358721205@linuxfoundation.org>
References: <20240203174756.358721205@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4d9f902a-fdf0-4700-bebe-9e831defc91d@rnnvmail202.nvidia.com>
Date: Mon, 5 Feb 2024 05:18:09 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 164b2f0c-b21c-4fa2-6705-08dc264cee90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXItUWrn5IeqD/+q/+r7kd8k6gJvv/JUDduJNe9Taw2TmfRdPwy+fCINAPDc6C5DeXaFdmOZmk55tyW+fUR8m5akWf2A9OAMJPGDH4v1xrjoiV99j5fwMx0ZIoBbe67DiZ1g0gvUVO/J7DLdN6feR1/024LUCe54wuraimJwvKz5fXfna56QE/R48K3qma3xXp7ecLFkd/vZbkjdaeqtgqxZq0+UQyVSHW/D1NK3yTg7PgcJ59GNUuFR0G/EBw1iOtKcbSnaQ6+Qc5Cx+LYPg9WTLKXKEJeJyWfbA+Hhy8UqkH9u+dd6oWDVRrsqq0IRw91lbDk3hlSRMlQQoYBqulHzTYxVai7V8yLHonWbJFH2jOfwqnvUWxCqfjiJ4UB7TlZgfCkTyzXOCj71LjH2ejfgH9rsSNf5dFWxHciIVVZyUKNJEAOLC+o/9puu0CimcUCVj8R1UHzVHGJHv8NY3QRedbv3AbIh+kiZHpYVQmunmZWYGkA+fCgcOtLvsxPozLnGifQkgxH3RMfnDmlsiDlY733Eq5bkZnaom7Dlhxrk96DJP/0QIcnijDmPVvTDw/PzyJcqxLsdptsQhMXVui9rEukEWD1GS3t3uSqjTHsg0wHSr4NT0ynCOPW0oq0Ar6W0huvdm8oYNwRK3mtoYtDFvfphAucOA1MjsPp63mUK4RTxRVJQCkB0fn50hXkgCrF2vUvHFelsLvqQU8B1GUlEviCQLfFsAxPIL3eyn7CSfXVrxib3xsasMTzvJmvT/rLQci6hGesVcYd09Ep2o91Rouq51yAz5pByhHtvwUI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(41300700001)(31686004)(478600001)(86362001)(31696002)(966005)(356005)(426003)(7636003)(82740400003)(26005)(47076005)(2906002)(316002)(5660300002)(70206006)(336012)(54906003)(7416002)(36860700001)(8676002)(6916009)(8936002)(70586007)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:18:24.0016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164b2f0c-b21c-4fa2-6705-08dc264cee90
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

On Sat, 03 Feb 2024 09:52:43 -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 221 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.77-rc2.gz
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
    116 tests:	116 pass, 0 fail

Linux version:	6.1.77-rc2-geccceff25f82
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

