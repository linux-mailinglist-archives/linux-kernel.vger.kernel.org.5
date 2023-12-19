Return-Path: <linux-kernel+bounces-5082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E8081865E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFCC1C21CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C35168C7;
	Tue, 19 Dec 2023 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sPGkx13C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217B168AB;
	Tue, 19 Dec 2023 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMsDXFEO2jEW/eH5+A0NcvLAH4MiJewFAMKEiYoLwMEEyS7pAu6m23OZMnhKmgiUu3N9HjyFqefUR7pOrknVG6FZ3CX9HSQA8HTP1XVAf2/qdkI3m42tSnedtKFuGTcD7Y9TiaR3d7r645mfT+mJIhaTETmwsLtQ+ubAr+ZalJzXlNveo7zw10/UxNZbygi/BjB2DpE7R9i5y0g1gh08ZGnnK5XQpMI+I/pdydRD/y+9yEJwmIeBJAHH2r8mLdezVSGB0xvuesx5G9Qexv8eQ7660ceEbf4894x2l4fhUKQXhTN3wTirNNeTInu1S159VaBCRNgSumXiitHp5CelOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhYMSnqw3/JFPCG4sGunZ4ZdARPu04BLpTUVwvkbexA=;
 b=m7CxHhgQ8pNp7MShH6WN1mVKSFTjNhhsdIdJJcmkzhck06bONbl+t/QDmfOlQxBXYOGL4Ldqtc8H88vvaiRW7DPUqM3uN+O95LJzmPwZbEz8MfkJrWiwsqroDsw7UIiFSeVk24F8HYWz9k6Gn0xEhpBSOfWUVBLFfCWscLAbnQfUUfMtdcNqTL/KhlrHD12HNZr2Wftg+gNAQfgtZK8sUSfg8LjOeKC+rVk/yoehMLNeAdKA2H3k9klrPzPG5PCAHPuP9gx+oGwFmrIl28KPUIjI6GYkZ93X8qJeIupTXDOIIYbU74aRwANyIiZeUjP+KlP+qMlXJWffcghaSHfdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhYMSnqw3/JFPCG4sGunZ4ZdARPu04BLpTUVwvkbexA=;
 b=sPGkx13C5rT/ienEuHyUK7+XKGYEP11MWbVfFuIBVh3TpAwRGYNWysYbsCMUnjpX1lF1nySK8nWPr7JO3DKeQWERyULaIMAoe/sHt6DwbuLL/YyVez3YTx4ULNFKaT4k2c0vfLe5x9ts5nQ79bmVN4317r+/My+Ug78yLQkuvnqw29Lzym4HGSu0puKfYZiQaWJGS0NpEbyVIAY4Cho7gankbOiWOpyDqrSCoBnXnD3Yx21nch6/56B+49uLhT+gqIBYTUDRL8GRznF3pQp0/VsLbf90BuS1NaVCLQm0qHTIYZk0NxZoioYjGiBH+p5iknx9ALzki5Vu+f7Hs1M8Kw==
Received: from MW4PR03CA0165.namprd03.prod.outlook.com (2603:10b6:303:8d::20)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:30:50 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::e0) by MW4PR03CA0165.outlook.office365.com
 (2603:10b6:303:8d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Tue, 19 Dec 2023 11:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.8 via Frontend Transport; Tue, 19 Dec 2023 11:30:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 03:30:33 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 03:30:33 -0800
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
Subject: Re: [PATCH 5.4 00/40] 5.4.265-rc1 review
In-Reply-To: <20231218135042.748715259@linuxfoundation.org>
References: <20231218135042.748715259@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <43b1ad94-e7ea-4823-bc66-1f67bfe4b70b@rnnvmail204.nvidia.com>
Date: Tue, 19 Dec 2023 03:30:33 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: c061f633-1797-423f-0b12-08dc0085f3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kuAeIZzeTsMvSz1WtH06MGWB1aolmOkxcFF6ZptC0muijYY8QfppvQH+Ac4O6+MirkMq+e8kiibazhgConj+og5EjsYtEaIapZz9BnWkPhP/7ZizecDIIOAB7G7vVVG9t2swLrW92fReB04X/Fjyi+5cEPhjfkF80ttp6H1MKWvJGoK3tnSDORbHqf/1ivYgPPNtKrVUIYEjQBb2BSA+/RIDE+NAsLlOsFwl134G5KhM6E8inU75AP+FOaZ7Vm8TZqs8jFo2RQ2pDw2HDyX6S19jBlbCnLrDg5U/H6qcePZd0zdzyQdIley+yP5h7bXIn83143agg1NR0smKBSSt33qUKEELNHNJZBf1I3/67laMoG4yXEUON8Mz6o763GGgDPvMcHWKl2vq6jCFrbbZGShxcHNgoczE4ukH0zll0btGSupghtoYXiSN22NosxgcHuPmwqpKD3kiwR/tTinMJT6pkAnSC+DbFooOyJk2GZI08yS71mW+Ol5+rQfTQy8DuZUbOV56jgGrbRAoccSMLgzgHxx0wR7g48nl9LsA3x6HTECCFzfihhuKPQoRsFLGiYyT7MuY/xK64kaRe/k53QpTINK/Yc9mV6MfF55te/epPMazNqTSFJHAEAm4mK6P4OSPxSzOaLYP+Ynaideeq6D2E2OKm70tvoz0aOkAllRZR3k3/C4TcqET/aeqdJf8yr8X8tpP83nt1e+BRMFwxam7b2CbrO6LfKh9X3rCMcJAe7SM4CZfldmI6SB1Iy2qN2UnhN8bbEdEjvZxtplU7Q0ilalZe4oTOEj4Mz/nyHk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(26005)(336012)(426003)(356005)(8936002)(36860700001)(47076005)(5660300002)(2906002)(966005)(41300700001)(7416002)(478600001)(70206006)(8676002)(70586007)(316002)(4326008)(54906003)(6916009)(82740400003)(31696002)(7636003)(86362001)(31686004)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:30:50.0492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c061f633-1797-423f-0b12-08dc0085f3df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

On Mon, 18 Dec 2023 14:51:55 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.265 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.265-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.265-rc1-g2be881e11525
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

