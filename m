Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F527E52DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbjKHJvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjKHJvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:51:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C78199;
        Wed,  8 Nov 2023 01:51:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0nTi+6I21HIJEMoCQgpL2gsxHDla86UoeqXTH7hvTKXwrWf3EI5KoQAjU9XSZJLpKgZ9nndeo8BUChMhblnucPcp7D45M7Wt9P3jSershf4HOMM+vQuddW43iBediGPUlYmQNVoUbRLmiqzkvrvFrUkt17b3/S1mb/s/yevUDqlmPGPxg3lm8YwhBw7+LifQeDuNM3+XUJQg9gs+vm2iuSGnNP098eS+fPxfprjGMBkLhYep4f0SDoJHeSSD4DBt+cyOqx+ymxbPQv89lsCwpTw2Yv9gKKdg2yXr91HA4Jo70gs7NaDDYxvyune7o+ydu8wI0T7KLImA+Kh0ZeB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jELOMhw/U7NmsooejTMn8h9UXfDz++xENlnTdnZu3IM=;
 b=lZaw44Ksodaetgiqj+Em6ARwnUpnphSbPSHCK+MtcgO0RxeB6zsKfA3ztjrNw5TUGp3SGQ8lZcnC62Q2SpnVRmmVicNeSsDsnkndBxE7pAYYD9bU07p4Hh3UZcuvEtFvroGbEi1obyquXj5G7ajkHMx2JK3AuSIVRcgu7wMiTGe5eFTtWdGn7QsTwpvSsc9fC1wfIAry9gtk5M9qMw7MkDAM4PA8ZV/O2nRVyimvF+57VSDTtJ8024qczQoROdKv1vdnmyrS/eQKVBRX1ILk/W+SmbO5oyOllREvsJzayWJY6NcQDRqQFrc6RzHZBFqKo/C9rmkxAx5qM6dd/c2C5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jELOMhw/U7NmsooejTMn8h9UXfDz++xENlnTdnZu3IM=;
 b=cO5Mqypp4b0sUz6x6rMif/9K1sA+vfWmgNbJCUPB53T5AUIbPhVLPtuJhHmSTIxAp+aulMblt80pkCax7bkwf2vRU6cwbmxBg+PGVzFTFi4n6NsuS9hl0Ny89lUy1yoXWRV4fboSwqWsBBOgaVt6tejCeYZ3lfKV3d+7T5dT5yZHVgONN28SxhFph2t5G+tBYuzUu7jQ7Cx0Yqsy69q0UzsZXm5XBEmm6SP1HxChsXVS4iRpWrb4sEVjntdWIcCPrQeT19oMt3t7S/4of7pqHIzahZnOMsA7BBndmK3gmQm0gpYNztO45mMBX7Er/vJ2OroWVS4S4TLzVbaocXXfIg==
Received: from DM6PR18CA0021.namprd18.prod.outlook.com (2603:10b6:5:15b::34)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 09:51:05 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:15b:cafe::67) by DM6PR18CA0021.outlook.office365.com
 (2603:10b6:5:15b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 09:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 09:51:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 01:50:58 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 01:50:58 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 8 Nov 2023 01:50:58 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
References: <20231106130257.903265688@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f9dd36bd-cd8f-40c1-8496-991c27ad0ef9@rnnvmail201.nvidia.com>
Date:   Wed, 8 Nov 2023 01:50:58 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed1cc3c-87a3-46b5-3d7b-08dbe04039c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+XLLxpoX/uTQPftr8gaNBDEed8/CURyGt81v0oTz2Kt3x+Qa7xm0X5KAOzGnrA6PPggtIYMVhL+GoQqAGpj9sZH/eOtkOSstfRxoZuWX2mB/Kcfp4KFkipg9igeXys/ltA7qiNbwDcwJtH6hGMTLO7CD9wcfPnAYbiCxqms0ci9yXEfdKiUMj4g8wRfXs9Pv/SAiQZsG1jOH41dNeaITT8QNSasbINntt/i3EBPd54EngikpXZw1eW0kPNv1Y+jMzka8tvQGPBvz8pvnKi4SDtdxLPX7CFDPxTodjErPNvfzBQv9lmp5/2FqsNnT/b5g5N4iK5wD7RYfDk1vObDF1hvT0R1wpJLl+SybG8h8YEaGB2lYrolUvX8hdHY4B9fo0YE5vgEKt9Q198H8BrwEDR4sht7fCNfKW4IBArlmVXoOW8/Uu15EcQmyy8ZqONz+MqujeTiyKBcPD3NJITzcGOYF2wrcwpRdZympx/2qCileXs0/mi2MaIVTSjyR1Sebi+VD9JcfQQRsKk7Emd3/AuAhiVh/ElBzlvKs0K2rXZTx+6PW6BTCQ5GfWYsobnBiOI2RaAOF5JplSy9qChgfZDqqPBOGEG/nG7oQ/sX84dQE/X0/KKVwDFU1+9KyLGxTMwPy3fJle2BwaDX2LwajREs5FQbkjGwVbZQxxh5i5vwBUOpA5cQeoqsfUOFTe3wD32/SUXp/Yf9hdf8MXUbdPP4DWrJEjkA3UtEBYcvijix3lGFfjyEA0dOk0ps5MZGZGESGyd7yjCHMoxwVdS2QTPaIy3jsCay+R7bUskO6EM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(47076005)(36860700001)(478600001)(7636003)(82740400003)(966005)(54906003)(336012)(70206006)(70586007)(6916009)(26005)(7416002)(426003)(316002)(356005)(5660300002)(4326008)(86362001)(31696002)(8936002)(8676002)(2906002)(41300700001)(31686004)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 09:51:05.2767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed1cc3c-87a3-46b5-3d7b-08dbe04039c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 14:03:18 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.1-rc1.gz
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

Linux version:	6.6.1-rc1-gac6cb619d608
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
