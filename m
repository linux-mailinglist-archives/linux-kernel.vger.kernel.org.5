Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3D7DDF13
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjKAKJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjKAKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:09:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4043DA;
        Wed,  1 Nov 2023 03:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAWD9sMirlmwd7OoI1m2zk0z/SoiNEfxg/4Km/6fH9RgsuwERJzAr2+swj5Kb1R7aJ85d3xmhDV84oVDwJXk1jYroPi1IjZeQ9gGb1e31gLMUbKpyGqO0NiYw4TBbfYwqxE1SSKDsoLv7yoA1bjA41ICZqRaqj6zMibM4rbIbE4me38aBstze6+Ld4dM4KZqVvk8RGZv6yuByFiXP/EXM/EpvgSUWwGBS8nS6j8/w2mTLJMeDlH5vxoDsmoGHtppUV+PxdwLO/B8yc3WzE0Mz9G63LlxXuZLtDNkii/WcVQ24vzfTM89L06eq/J3X5zMg6zOmIMn3JKLvt5vVhtF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+L+j1WB3oPqRLtGjcIIBfuWONj/6O/8GnttOq5N1Cc=;
 b=cUz5AWhK0Cdi9aKuKIAmYgMWUaK/yGh6HSz4VjBwmlJ5yipswNBOVnAKCb0gOImbduif8Q8DGQmHtyQzT3LN3SQDKSmtx2himi8gyNNGAWZEkzo7FO/29UIVHBuwhBaz4plsM0EPxD3sPXTiEqVTRVjBlA+JCG/f/7tMagLesFWnbg3ff/+ddrc+qXgqYpkl5Jw/wxOmuf65iKEYdOvFVtRXJbSXrKX4vZZZhxbvJadCq+bF19WQEyeLe2WtqP61mFwiWBPHhj9FV8VSAcArM3wPA/fr1A6ii3fStkVmQxUK/zkAhTE9qW4n7dyqFcMWMMnV8/85k4k8j8TQP591AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+L+j1WB3oPqRLtGjcIIBfuWONj/6O/8GnttOq5N1Cc=;
 b=QJCwG1CUZtzQhlUQq8sHE18qfVw7UKIXB6e16gzrM/uJJb3AWTdPA9tss93gC/hEXUOpsye+swGL401rLkdlsjBDWOxgju5ZX3UNEwpNtX78rkZaLkLTLm/btjUzRD4bGk68CuRfOJ6NWIsd+RMk8KjfvVtjOTq/xvSoKggpVCNGtIio7QfoUnrHnSyWL81Vb2az4EidSbuxIWd7D57Sk3cdEbqMOxsSHyaKqx3C0qajNpeEayrGsn8inW/Lc3XAF7khq0MV92araj7VpQfGfkjzd7HNBmVdyqWF5rr3MpIIOAZcZ6Zy2usa7p2/2XMez6H6/vXuo7wtXbDYIf/YtQ==
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 10:09:07 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::34) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 10:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 10:09:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Nov 2023
 03:08:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Nov 2023
 03:08:50 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 1 Nov 2023 03:08:50 -0700
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
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <10a056d6-4b42-41cd-a1d5-67d3f2c7a73b@rnnvmail202.nvidia.com>
Date:   Wed, 1 Nov 2023 03:08:50 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: b51df2c2-7ea3-4311-b51e-08dbdac295c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehPfCFpi3kbCAyKcCUgOVUDztuyrkts7VduzmQDw3z2rVThcW7cxuuWB9sapn9OhL953XFya6gKyuhvzoUFV6JVPeajBzNVIMFnrH8WufIXA0AzsyvfO/vasfhkI3pHftslX2CEc6jq2gpSyt6MUHs/Xk0QLniCY5bdiRoRRxhn1171jKFCG2656jTkLGBeWkkXCOXB6C2uVegTwMb3ayPSgKQvSk6TcMIhJS1UxHDhac8sm+6tq8oPZFngpwHAMvDKjNfajBHCXa8fifcWnTnDWbSKd4Szx26OP/8cpuUv62O7L44aXehL5VkTfRI1u4mFoGxE+Jw4GpKSnb/MiN6e5ZIl8c5O0NLDh8DlJt9Ox0533v1TYrRj2gzwDEJwhX2h/R6AR7smjNHIBATFMD3F8mNiOYVcPBb3/z1E59x06IKAsSNl/o5+LZk31w5jDGAR++wWdiAuMXthmY6XLrBac7Kq2olhQZSxshV7+/hzvOq5DFQYEmq6v/I5MynWnqpQyVdiui+bFRIudYqrDMcW0qDFpiA1VmKirhuOzz20KdZWZXv1sO32VUWUySLgE9R5OCoI5Ivxj0VdFBSuY2jLfZq1df1pVoUf/6lMiv+YrmsDzlk6m5ms9AJvLQSl1sve48Y9TLP1rbJr3YY8mACPyHgJNNXlCY4sLBG+8GYp8AOKVenR/ZO4oXlitH3e9hscOa/DCss2OOA6AWoKvhM1QXW/PptUEczNnxg4bo6rwOjl52X4M8dydvK59xMDcBUagFHBOsA+X8Lmyc4IDwmW7NpOUF4iv5YmbuQw/NxM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(7416002)(40460700003)(40480700001)(426003)(336012)(26005)(31696002)(86362001)(36860700001)(356005)(82740400003)(7636003)(966005)(47076005)(2906002)(478600001)(70586007)(31686004)(41300700001)(54906003)(316002)(70206006)(6916009)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 10:09:07.2560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51df2c2-7ea3-4311-b51e-08dbdac295c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 18:00:25 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.61-rc1.gz
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

Linux version:	6.1.61-rc1-gd87fdfa71a8c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
