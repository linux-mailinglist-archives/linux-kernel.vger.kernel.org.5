Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B67905C5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351721AbjIBH3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351700AbjIBH33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:29:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BC1722;
        Sat,  2 Sep 2023 00:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVOwxHeYMXSiQN4AtugXPoSJJ+mAUxYXC8Xj3LPQkHK2xTd6R52N4kDvUA9cR7XGKew3AWPS7GJ2SvGpne4LQYY7C1H4dfG/8Ad7udQ1oYGMpHE0ccnIQ/1lU+joXuTGR/WH2tQPMBNP3YSvyFvSh9JILgKIs9T5LhfBLPduk285eGl6c9E5EwhdDg4f36RIA030tQqHD4vzXybSZLcVwvVtIZaoEo3DoEOOJJvrgHkqp/yrnIMVed7dy2BcqUQV9n3PtpH+nw03CvdnGN+i/WFIcwZs+1dhNRKJ4bNqtA569vjYRY0OabWnxWyedZKYCLsQA90BF6DtXFKtxybkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjHftmJR5pH9wQ935WcHiZihyOStc2rFkdR9o7Gfo38=;
 b=XyQ5XKjMjh4zXeJeafGsewlzD3Lm4s+jCMyTSTU0Bt8a6SyRjwRLAqEinMEkTaN4dAV7zpzCWk296hdXsG6ZlheEUghkJTM0JDL+yRlwjbWEppaBfr48l3GEAxF76F0BT85Cx77SY72j+KpoQZ9hK9Gd1cp/+wYOL1YQKtTBB3M4mq7DsM1IbSvj7W7X+ARnzMaySMEZ9UvXwYn9s61nAOiF2sIKnf7Fgb7VrdEBu2OW4mkdo4oEcFauyKJOE+NeFMb/ISdTAY2+px6C3vVJoQGfZWF4CGhCfPXQ28CMas/hIvhdqJ4M3mzYzyU5fopq6Jkafr7zrGZZmFjk0tHPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjHftmJR5pH9wQ935WcHiZihyOStc2rFkdR9o7Gfo38=;
 b=HEDgSRzLSqceS9wLRY0ROmGxw8KzTeGwRUfvGegDw+5iM0zAdIt6Qkd6GsDua8NUZvRUz1BuCaOk4yXpERb30EFX6IouUXSIi06UjmUEJqw9XapSQqkQwhIutT5uE9Wbhs8dgbWdffY+5+JA88Q8WFcoPxSCT39YGfII/yZI/OKS8uD1RIa5IQGxrW3uv+I6D/IIViGppHw4lu/3R2TL8E5o/WNTd0aS3L5KKjrSuMKjajDsqrvs3opCQg7oXEH2WyX0E6tEW5p1ZiefjbpjgVDX3UYGzgECrDLXcTF7Z9UoCnDby1gHxoZab8VVYXUD7lBUghQZh5QKlAW1uzQqtQ==
Received: from CY5PR15CA0249.namprd15.prod.outlook.com (2603:10b6:930:66::16)
 by BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Sat, 2 Sep
 2023 07:29:07 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::50) by CY5PR15CA0249.outlook.office365.com
 (2603:10b6:930:66::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28 via Frontend
 Transport; Sat, 2 Sep 2023 07:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Sat, 2 Sep 2023 07:29:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 2 Sep 2023
 00:28:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 2 Sep 2023
 00:28:57 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sat, 2 Sep 2023 00:28:57 -0700
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
Subject: Re: [PATCH 4.14 0/2] 4.14.325-rc1 review
In-Reply-To: <20230831110828.577111137@linuxfoundation.org>
References: <20230831110828.577111137@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1080f31c-7767-49b8-bf4b-2f44ceb5bde4@rnnvmail201.nvidia.com>
Date:   Sat, 2 Sep 2023 00:28:57 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|BN9PR12MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6b5ac3-1483-4200-a797-08dbab864a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alwOvXFkAg/A3mcKmtj2s5+UsR5/UUwNOUY7zZ2CaVZYzSEIkPNiXhtJpW3gATfh0NvamQP6IYMbFDGAHG60wfgvbkGoOaKpq67OrOalU6EJtWzd/vpahHlhTpK1CpaYGSnj42vSO/QFTto5+Lgn5wqGscqceWjUNGrAWcV0LsHr7WajCCX0PATEy8TDawk2tSvegiHDPhKYyB1Mpd28/fGN7BHyNJ+LbRvTNC0fW+swojWWJhGUNNg04qLuHNBPTmi9HH0k6wT+JNOx9uZ8jfQQg4VZ5Qm3o55xaPKnVNDORgLhwYgAcstai3cloNAssC8vYnzaVATU69lOaDZTTox515sMlZXOO56hwg0+EvI3AxnFqyCxQHyurhIpkK65xD30K3dsZ3OW+lfPoTkWwGssl1oO9fx07mRMwLE/vjvtzRx1Xj1DwK4vepZ/xlpD56Ov7NPlQ4mZ0TC44nl3zAwW99+xoP+2CM3dhrFBnlfgaVeDeSO/yV56cE0d00SzlV/Sm/ImvphURQoUaE9mywC+/Y3F2k0rpNM1WnUwZgM8M4Fje3dL1Hk0MTWks9UwW9uhs7MtJMoVkj/3WkqwQ5OFt6R547NCnSq3TDLOJPxdDy8OnaTZEn+p8Lq5pyBtIEtsQXJLnDVZoaACWK8Ryy6kx5R1D3InCqhu7uATPo2ymsNPvMICTErtLCuObMSKToAG98yGtZvPRhJ55KI+Rume8LRxSCjQtmIRg2MEwAFpoqFhG2p6EWMDZ812PvXfAlqA8y4cwvNZZX8/jw69UXORzjgGij0RrISFCBOW40E=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(26005)(47076005)(7636003)(356005)(82740400003)(31696002)(86362001)(36860700001)(426003)(336012)(40480700001)(966005)(7416002)(8936002)(41300700001)(316002)(6916009)(54906003)(5660300002)(70586007)(70206006)(31686004)(8676002)(4326008)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2023 07:29:06.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6b5ac3-1483-4200-a797-08dbab864a92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 13:09:41 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.325 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.325-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.325-rc1-g9467395c02c9
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
