Return-Path: <linux-kernel+bounces-16975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0F98246B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563121C2409A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8411F25554;
	Thu,  4 Jan 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aSboh1XZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A112555E;
	Thu,  4 Jan 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffP6SjrwfO97KiGElNY3VMcg7hSCJP+de6sKP88QpU6KGHR7mVnID+wYYx46c9+1APYVR+qIK6Au+lHqMKJ3SWmBefDj+4Y5G0zQVWndH/TCik21sVa6oeWH8pkfhK7eU0fLyKk7Z9kXziJt6nRKtkqNwbehHLKm4ct+SnCT52yFvoLl5CKOOIc36FL9w20zBcciCYvKksX6tu1vqR8MVUuTb6IPdnF0mxlMq88ZByfwz91V14bwjjXAoKwNc5SPa1IqEcBOBZooGFTbsdQzTI3DnKEVJ4hNQ7GRqM7cZrcRerbIjwz7boewRFUNKQYa1CIdG2ipnOyJ9v/zoeK0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9sjA3im0k3mGBN+vO1RwOWI9QwvJEtTGNuIPKopSWU=;
 b=DemN+wDUJx819YDQSKcaPIw2kJBCRueXURoe6XEFkWp4BwfDk45Ojcx7kj4g8+SZypMtgbhCtzQgamTzDMJejp7+orAcqZKX+IE1d6UkhDwh1AXG1x3vbfRAa8632wWzGn7yNWm0Z1wuRXFHW4+jJU/eUYE7enz61gWPcU25hLR+k8iwvtHyvw4F8S2N1cCTJqfpowiAnMSCvSDnpeVF7KFFrHUxyG4RGXdp0Jjuw7m3DiyG9rFh3qnxabq1A/U8DJt82kGg2l6F5cvrWfCF75U/SeBPFzQg0btFFBaiXqXwinOZ3m7dwZfPnTDGGM4wD/xRWaohbxVyo5w4YUmcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9sjA3im0k3mGBN+vO1RwOWI9QwvJEtTGNuIPKopSWU=;
 b=aSboh1XZfscI6sx8TKEEBfHtqIqqScwHH18pnIKzBIdmsxH/+fRE08/H/fbM0sBmWpY8iIPcB3E2AvqqsU0MdilIhmtWyqQKoga7mQOKYnEV//2LFOVvPJv4Q3XUTskCgGxiTfFQq1SSqX5rn6cvZtQw2HZJWy2JvTGxjYH8ZWkEd8JGFGfecZtxnlwYGUT8Cu8I92zq7llVIHiBz6Rn7xOL4Hh8X3iS99HmxwilVtVatjBitI6oNzNWX1Mugwz4TgALNLHrZ/Pb/di/kEUfjbVhJlwETS/lDEaWCCj4m0KAuXbTdZgCUTUmxg9eBlpCAVtimGzOHtXnWB18dTTMag==
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 16:52:17 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::b5) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 16:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 16:52:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 08:52:04 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 08:52:03 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 08:52:03 -0800
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
Subject: Re: [PATCH 5.15 00/95] 5.15.146-rc1 review
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <a0b98e18-5373-422a-a4e7-96b22ac45ffe@rnnvmail205.nvidia.com>
Date: Thu, 4 Jan 2024 08:52:03 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5893b8-eef3-4951-046f-08dc0d4582a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2867UbQukGKv49EAQnMwPDI5joqWSyPHLlZY4MQ7KVFn1TLcDs4jAu7LeQV6LQsefE56oVuMSLFNdS+JyZZqJ0YQMx6IVWniTxOsHJAmDnCofMCm0l6jB1WMQgh/SqZ310o1wDMR50yHZu2qTLZlJ5fG/Yj3tMgjDLq6CVFS2wXihPWYVWwq3HkeACUS/fEO1Ixd2hF3yk+I7PxAnIMTpbC1FQPgg1n+wHjjt0USjtUz3w04Z9UYuRv1NLzH3iIutzDosk8xXziGIU8aZYTMPgkShhIHQLPQiKbFYhH8Lb/saBqNZd8o0+y4OlRnrFKQwKxvOt6KaArXMn6zBXtfb7goC0MjtdJ66CgacTrABbYrY/rPamyXrBq5Z2EgWX+GPwFmH5Wa5gSYCfb1x3yR6r13NBgX5unqEovaTzXrB0rIbHlqtMHtqYAakzActUCOf6/HPe1+CB0JOoqoJdWf4iZ9amG+wDggIVOJ8HnFt8QMt5MFOSF0VWmkWccPLTU8k/yTKqT6wNZ3xmHoITnYmGkzPZ+hQ6iitWYF8oXKxH7nA8js2Wr0VqQH+gODljLUzLyY2XPBQa1/Ngwh4R/+l5+eaazOzabIaoG9btYpnVK0RQSG7dfXojQkpnGqDbKeZvMqvqZXc3D3yByMyr1XEKQ7JR79BzwnZnUXuGW8k8N/XAK2UW4jDyfWHT7YsXRAWcRSJHr2I/I4wBNJ/POzhrE/enXo7EnuP7zhP1KUoWYuaeIcIuj9tdOU9itho7SyZkljwMydxGGzeG8BzzCA056VjnH/WJosk27+8DI6NCc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(31686004)(40480700001)(40460700003)(70586007)(6916009)(86362001)(31696002)(336012)(2906002)(82740400003)(7636003)(356005)(26005)(47076005)(41300700001)(7416002)(426003)(70206006)(478600001)(5660300002)(4326008)(8936002)(54906003)(36860700001)(316002)(8676002)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:52:17.3922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5893b8-eef3-4951-046f-08dc0d4582a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

On Wed, 03 Jan 2024 17:54:08 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.146 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.146-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.146-rc1-g927631a7bbf0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

