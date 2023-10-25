Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC037D73F2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343695AbjJYTKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJYTKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:10:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81881BB;
        Wed, 25 Oct 2023 12:10:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgV0No201PFb9svzzlu4GdLZfD/CSgTR/Wh3VUiVT1Bs5b4ft5q4NeIAluqzYyVDJxx9qTQwxzapTt+upbNJMFwuunjvwfsDuhdrGF05p28fXLabjHzihPBAJjeinTl7uLe5sYzeRfKOX3gplBNftTNmlVLyZDzPQBTV3p+KtsvK+HYE38v8dgtjIpTuspgPr971ueD6s0O5TOH5BvPCDR/TcR4XZT4jyC+qDiA1ktzchTkzmMYGyd9fMCIlAzbKXWM7RtPAtvPVdFJrtB2USz4Q4juXAMEAB8EZzZ1EoRdkj61r2vTbt+d2+OxfsUf94gA4QaaNvR45Pj0q8EC8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+xJCZleh86HvoE45PGQ37GcpVNnuTuP1nCIA8ZWoMI=;
 b=ZfxBVuzyZJXqKn7eqTdjKnK3y1Z796pBRV4/SGxu/09ArHU19mzjYGdEmjf54vDLs5+e6/XER26Iq1p4d9ntl8t1ygzaEwzAT48LVuBETTsCOifDG0lfFU+mD93ivBc5VCAFqLhRiVMkIx1m9gMZ+znzWghMFiuJTwpAvYgmq+en/+s1LCzSO2fL8ARI3+qsLUuBAf2zdzSS7Fh6YR28/+3Fd+/dzQ3PbM/2q6p4MzVoKLh5GwqJBzyIrZ/8avi7lpWCQaL4AgFMv8LJ+o5gT1lzythB0dYgkJW/qhstQ1Cf9ostIjG9hv7adCi0m5GYLfuoNxPg7IYYKlIQxy0xQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+xJCZleh86HvoE45PGQ37GcpVNnuTuP1nCIA8ZWoMI=;
 b=pL/+INDFT0QTLmQ5mr6GpqKzbiHE7DAE+atPgMPib66dbAC3zqFgcHwCY3eDdEBzf8V3kSr9IpNVRim3Zx5b87vIlbY2YKuvW4nvBHN7ZjYcW14+qjPDfvcplk6WItbLm2De+yX980wE22SLud00SBx+uF95RNkLlHAk3lRnwH/0anf61BHrQb8EximSvyuzMN6GLfccZI2E7P3OVvmQJggpP6fQunfLkq+hAuzKG+kPgbSdoUGGRGIHz2i1gSHgd0iYRuOYcGc6p7zWLuaq8saozwV+ZdkEnemGcLLGX2/z8oexUTtwXhK5On5X10w3std4Dak+aW+/FyT5PM9JvA==
Received: from CY5P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::29) by
 MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 19:09:59 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::13) by CY5P221CA0013.outlook.office365.com
 (2603:10b6:930:b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 19:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 19:09:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 12:09:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 12:09:47 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 12:09:46 -0700
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
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b851c68e-e14a-4888-bb60-3de32e967902@rnnvmail203.nvidia.com>
Date:   Wed, 25 Oct 2023 12:09:46 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: b09f367f-85d0-4af4-ce9a-08dbd58dfbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BkM8VgOnK2XtFoF+htb3X+ewV4L44PwLCyGK3Uoox68W/5j7lVxepHvBr+YRSjXacoKBsVK1fAFywGK96JayoBR6PwxFg7s/u6vpZg/eyWdwPZzhYosNCEcLCJMiPox3jj26fiQpaMbaMlX4bFXNKPRgrQeR/ae9xLxhnxF8RdvqwFYsdxztKmjxGq8KT8hj7S2c+7QLigLd3siqP0K+JEXcPtv//gEaabD67PhGNruhYBMyEU6NQP8wvAZRHPhDfH1luZqX1aVO9EZngZATKMqVDbxfkxkhuwphwCvU1WzclFBIU/v0y8sWhE234BXwv9ZNrgocdwsU3rim1JiXYYf8gfBeApTk4ihgaz5Byqw+ETEJbjcZC60DOWJy4V9oqYloGl4trnA4y2lLkXk+nhCXgOWboGQ1zLynmlOGrDnYAcB1d5HQARwOTEWomJxIIrnlma6/VHmSeaH0vH2EcrP52WsToDfQm8DPrPm9bTv9TnNpIdS5zFBxOrH3yNlrRVbiMp1+oMB30Nb+7uJPks7YUWT8vYZGCT8A7ARsUE9NeBgjo/r5tmEcaCnfcHz/LXWuxSAu/qbUS1NMOk5SyqbdNzEYmKJBde5Q/TIlVjHqO3d2ZoRyfebrro0gFntLAB8FtTmPDLv+5sb/IIjlwP5CoWu34PsL2GKKdRckUuOvDDfKSPN4TNhoedOA0q0RByfIyTc2v4ueOUv7bcax8uTyKcofneVkv+gKgPuBVhtuOrPWQdZQiS/Zp0ftAcNJc2WYK9juh/dlIQdoLPPNs/RvEyZV2/xD8L0Pjc+OF0=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(40480700001)(8676002)(2906002)(8936002)(41300700001)(4326008)(7416002)(40460700003)(5660300002)(426003)(26005)(356005)(336012)(7636003)(82740400003)(36860700001)(47076005)(31686004)(54906003)(70586007)(6916009)(86362001)(70206006)(31696002)(316002)(478600001)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:09:59.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09f367f-85d0-4af4-ce9a-08dbd58dfbb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 10:39:59 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.136 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
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

Linux version:	5.15.136-rc1-gf11fc66f963f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
