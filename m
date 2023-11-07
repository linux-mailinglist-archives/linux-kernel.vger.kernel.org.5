Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF4A7E3B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjKGLn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjKGLnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:43:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C453184;
        Tue,  7 Nov 2023 03:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWMDlgzk01g6NTe5av64tqMMHhI4F/Lb3idaXRb31EHmgUKeFnT8AXTHfdkeAL+qWyiMTdg5qZtC43fRgrkyf2/jW9XugMaTx0/3S2gy1pXY5LOsifmqm9OUoSELqvBHsVjklyNxwB00H46XvGSTlp+m5xaEILH5DWlYDcaT1hbZJb+EqY2mUsoJRE3fDXXum4E+bKqEquSkSgQyxMvTmWqtVmuzy6RN5At9M62dCcHEiv3Vjb75/D+BIWncD4nt1Fetc6WTDLs7pMDzdhX6LXWJiPQs66WyeA6yFm69uEJ36UZ/bAiPLRB92n5FQfVFyGNJQmVC8ibK9dlfRNhBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIbHOsdMsBjoheOJQg3dMGDehWgk6KSYUYZcJSUh2Ls=;
 b=inROFpGCQwPJfX9Gx+xxG15XMKLhhmYPm60VFTL+nAk17hReQrAJCLwMqmh9g56oGgzhg0aYX/PtJCudfBQJP/6+JgAQfZj5OZM0DeMYlGO9/9jCK8bWRTywh9fpbBTNokyYCfnbbo0napEjs/GUciG951Rw3AolbReEe9OaafzobelrDW3s7jwpOgstZ9uJzYbJM0CsqTTjx8Eo9sBDwR8IVes1ExltUqx6GvX2SLVfvz6Cv7Sp5dlbrfjc/LqlNRhkyNYPiOGoTwYvGknxJ8eCMSsLN8JPfkf4scWBkS+2ilj3pfsWcQPmW4BMauOvvlSmliAZNWyXEDvkj26wew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIbHOsdMsBjoheOJQg3dMGDehWgk6KSYUYZcJSUh2Ls=;
 b=haBsDqxS2LHW4UlllnquCHRl4ETqOK0bKOwBmrag9StGBP4mumPn5QFKtY0xMpaJscp4bpQK+7jaJep7GGkgy53I5jzUu3OAK9Lu7j3GgC+PlQq5tYMb4ZRryN4UhBYoS13mlHrhBvhB0uJuW1BNU8eVEYviAc+7W9ThLAdysb6XRtsHUkzJ/DpxER6O2gKNTD5IjAqvX51sqi36Wk9E2sCH15Oa9ghRo3Yq99h2Zl3GLeLqNR2WzXK/Hq2kOMdeaPDS0p3Ek5F6Z3ZhRq0f2mgI0Y2psJJHrvkQ6eMWvKuUA1JJ2sujIEqIZvmybQ5PfevY7G7o7+il28/sag3Qwg==
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Tue, 7 Nov
 2023 11:43:13 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::e3) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 11:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 11:43:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:42:56 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:42:55 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 03:42:55 -0800
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
Subject: Re: [PATCH 4.14 00/48] 4.14.329-rc1 review
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0e5c319a-c183-48e8-aa5b-d6faa4dce950@rnnvmail203.nvidia.com>
Date:   Tue, 7 Nov 2023 03:42:55 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f241782-d32a-465d-4ddd-08dbdf86b950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qt4EHzRV1c9UT1peiZz4vqhad1C5jT6x1Q/HvB/OHL+jchZA2B2ZbQfImZ5If3uZl/QIThOdKXKoTUOGdOUuZm4afBiR/eVGW9siJ6ApELdyrUDM2QP4BSWlDIuMnelOIurguYQbuGILHKNMBXd+znC5bt32zvrm+FLbEFdj/vdWr9FKLrJ/2iG2jq9sJClj/huqQ12/P0V1LkN2u9ZwlYR7zuu1Xab9ElmLrag2kyeOFYFD/CQMmcW0OZCVUTmMz6CRsIbR3XwONukuW7cJ0hD6a6e38SBeDt1TnjnSo6fb6MwXrJu0vRJFvuoGuh1r6FAEOlXAylH/zPT97rnMwFhb0dQXvk47NSffpt6QpfXBomCkByKCo8Y0AsFDdaampYP3cKqJpYvH9/jaDwM2zNpw3h7cLO7hHtgtot9h8pqCubZ2VXDv65uEiwD6synzGCFbCdlGwb31kwXGsgrRJvPXpjHLFMJBrjoaN3JIfi2Sx2i9m287LuvMsbnWwV0LfQxglT/NeoGp3Rm+r2vbE3c3Y70TVUR7/z0FdyUZgNTxxVfwl4Iwsl2P/kAwtEoeMzoMKkYbDRiyYPmrvg+4GM7YfdTOs13tsAKG6ozjaBHJzgwwIjUJigDrn2gUUOiJKeP967FpuxZ4rrYRjVp3oJjsf23F+xHXhjBhqx5xejBfusNzhDieEiBPh4CxtghBUchiKimdUvQ4uyiemWg0bVMyeDEB7mhNHaGWoy1lciazlnRFc5yZNNNsPpEMzIZ9VjYitMGXROPAfvAWDPAG1xyCxosaPHu+gSOb4lZqmyU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(966005)(6916009)(478600001)(5660300002)(2906002)(70586007)(70206006)(316002)(8676002)(4326008)(54906003)(31686004)(7416002)(40480700001)(8936002)(41300700001)(40460700003)(26005)(336012)(36860700001)(31696002)(86362001)(82740400003)(426003)(7636003)(47076005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:43:12.8685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f241782-d32a-465d-4ddd-08dbdf86b950
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 14:02:51 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.329 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.329-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    10 builds:	10 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.329-rc1-g081def1ede2f
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
