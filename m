Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B1D80092E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378431AbjLAK6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378359AbjLAK6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:58:08 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E507F193;
        Fri,  1 Dec 2023 02:58:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyn0xGDGtryUf5HO3wZB6Ekda5v2yjOpW5APbVNCihVUwWge5ScZ+H2jakvh5vKzIZTMBXxFFT70BhWZdcMtIA54slo4z2Erj++W+1N5a/efEqJKoxnOWdq+nCRVv+iUITTljKkgQbgNnJs2c26zcySMrtvHr7zMiB7y8c7ZU2Wfh37lEh2RhaORJoTz2SijuqtShXC2GiDAlFZNHSUWZJboWJZr+3LiOJwMs2ywETdEeKadbYVMG0v53ehPhiXqEa9L8TmKJ921eRMr5OG6xI+GTsRWmhzl3vrr9Oka4g1uTISixDVxH8iY/WnD2mWc65V/YAZ6JDWH+U6G1Prhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpCvoex/hummGcJ/Lxt3vwxHc80WWRrYFLiPOsXlxeE=;
 b=gdhsB1nutoXn2c0HQIsrKC7PebwPZTo8QlophREazetuOGa9BxxrJcbpPRwQaZz9izqPtuevuCPn3fsL9N8LpfpGKR9kCzaVPpMt6/GeybG/bozJ29sjLpr/B/yC7pIEHSB319tXmgbUNPkFAufDL4aWtRgSCVGAdyf7l4BDfie0QaqpYwNXSzvkEcMQQCE3X0Ev4ynpedbvWOU6iQCoAsyIv3r3WPSPDF1/n/a+e/yLNSguQrAoUoaMBZccHL1wGJ3kKqPp42wfrCeXBSzncPeXl7cQRGizE0Zhk1hNrbR4i7Js1WYJuHMgLcr+00NznDM+xLKuyS0Y0/h+96oHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpCvoex/hummGcJ/Lxt3vwxHc80WWRrYFLiPOsXlxeE=;
 b=nFWPgWM2Unjbv0JIboZOkRguVYWZgHX9UV1WdpMXN8qlXtiPADdp2HFldWX0qcOA2dgdqviHhsqc5APzew4js5Z+9Er86cA8LwBD5CEzR/cJ+bHKL9V4KpXMAUulSxEACXhGx3vnug7pfKHDP4aoCjYZclKpUSj4y4pSy/FgOoaupqD2RoBSq4DXNDc4ifoHFqRC3UtfEph/hpBOJyy57EVBgWauTKy/knFQ2h/+yEOpO6pKtrsZKZE6GWoohqYy225jIPhMO0ewlAqB+ZlSZejdG4o01E8jdUv3Z8+M+wyghJdAgg3y0Wl7n3kQFc791f+toGQFy6F/S3Ri2v74+Q==
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 10:58:11 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::ad) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.32 via Frontend
 Transport; Fri, 1 Dec 2023 10:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 10:58:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 02:58:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 1 Dec 2023 02:58:10 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 1 Dec 2023 02:58:10 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <aea02578-2910-417f-8678-a97c2dcc61dd@drhqmail202.nvidia.com>
Date:   Fri, 1 Dec 2023 02:58:10 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: b17481e0-7063-46e9-583a-08dbf25c68f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XqOUjFDBu0/WQYm0PCI3x7Dej+/s+57EtCjRfXD7W0ZwCfoZSO1wD7HnQeCja6m6bvBRlDi3DYjRXJA7owLWxE5IsxbmkJ8Qxx0glGnCFT0cc1ztjqP7mPE0tv7ldKssSswz/3ZkSQOLAtuITsl3swUwhG+rUSASDJzqyLcpNIkZWQX47siWINMoPY/O0hrpPCiBUCJst6BlGnMIN0ESKmX5wCFW3p9cKrf5/uRUFKX45aESD77MGRE4UhHqvfxuIMXyYn5J0Kb3A3U9H2nHfnXzO0xnZp2bBZxUzBqwTWlJfUHX5SiSjmiJ3SKg+LoymhX5Hb1iZKvIiHd/6HdJtNFRG8cXeJ5YBbaiFSagXiY+VCHErNqMLcdfTO3EUAKM+P1hwX3irev4wlJRJ1qkOsx910mFS/mNo9jFKUADrHxPBfmqdj3HU0AKWcOi7Tr1jq60gDQpHkshEAx7EGafCAWP7+sdAMAkDFrQ/JdfSX0n0zo8vROIYKEBPmh2lUmHokm5AIcy1iF84blr9Uy3D1aATU7izWI36Abr9zVRR7CKMR1GkgQOKZwZHYY+xK9AltPfKz4dlWe+WUwIiz2Jg7iphOK1o8EK0BDief2atE/zvmBh2xjogPlOQkoZPW0pFZCa5mqFYumVwB7UfXqD54YQGGHUYmguU07PjZWlO7YevKa4vdmrQJVmXvLTRbV4tnRNnbgLMXpl4ar54r+qPsUqIzNj7d7L+iXIY5KHfguOxuNRshbKYPiagCi6n0nj+t661WoG9cchRuB/M2sxU8NdH85rkNLzheDGpaU6Qds=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(6916009)(316002)(26005)(4326008)(40480700001)(8676002)(2906002)(8936002)(478600001)(7416002)(426003)(966005)(5660300002)(41300700001)(336012)(36860700001)(54906003)(47076005)(31686004)(70206006)(70586007)(7636003)(356005)(82740400003)(40460700003)(31696002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 10:58:11.3942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17481e0-7063-46e9-583a-08dbf25c68f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 16:20:47 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.4-rc1.gz
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

Linux version:	6.6.4-rc1-gd7aca62a9eef
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
