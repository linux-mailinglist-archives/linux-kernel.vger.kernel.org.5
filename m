Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5775E092
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGWJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:08:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11B12D;
        Sun, 23 Jul 2023 02:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZpAUogpAfjlIVzetO5gqNV/lOKDOuAZqcx4ao4L2Ntal/r6mPIuSRjKo7y2EtEIEUygU0meUnW1SKCaLDBOgJprU2jOGu5o8klCcw5bP2DhL48a1o5KDZjhY6IY+oJhuGfMZJziXbfo5CTubLgWLKnRdNxUrKu8TbcsCsUxy+GqeSsvUrySD23JJeCM4LVmKNvJl02YB8SVHq8FczIC5wcZ5itI4mxkaemp0/Lz1RPu7Kv6tgDeZqnlXdwF8N0Sfi5JNQDxWWfRdY4qobs2G5Q1U/vKKnfYLPsf8T5L+wY0w4/9qv/9nbIA7EKZFVG9Hy+DPyAktJc6qWFl4Tispw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4Y3ZStcr0+oBCkNjT2W/R3UbAap0tUJlbV6nCt0giY=;
 b=enRVxhaQ1ZLp5jXzlhTANsBO84Uxh8eqkp8BrPfBeD5NKvm3bquYvuAuRY1Yj0Q0cxR1aJsmEqFKrgcpr6s+if9G5cm5PXuoA9jBVkJLlrtURUVhlCDDVdCQ+FDSYNVb3fZkiHhw7vmW4mDbtiLNiICY2SFKyrUVBSPvnIbo8gDUdVsjnPOSKOl0Do5H4RbmXEXVy4J+1cq6uJZYp1LFCdZ9EH2XxOxoxFQ0gCYMpgTxKaZccNskdSL7tByItZNZGIF6bFsz+WgqfamLpGZVbojlDX+LYL25nLLVxVKV39a0sdMFxmHgxcUm4sSM/Ezo1pC8PKAu0KPQxJ+Oaoe/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4Y3ZStcr0+oBCkNjT2W/R3UbAap0tUJlbV6nCt0giY=;
 b=X32IG/4e7rlhZ4ZxFHEHpf7YGkCiIVoWOlhQUhutOl9wCtm/8zTttLLoK+v5jogwZ2FqEYrLi8f1avTHHxTtzSfXF46srfZ/YEikjXbBG+ojw5XLZU6MM7fFN6XMYJgkxt4SKXeChZRbkR37Fy2fRMU7qqjXRM5+TeytMTAK/A+4tnGH1V1N12DsodbCNxYa+OR81hgP+06oMAacXJrQySBTxkLlR9W3exyBNVgN5VEcgV01uqhbZ13u47g5g5+a0Ena1iSK6CXfZ8ucdz/ZNXxIsICDvO2hcVMG3TjHE0FXNAa04wWWX2vN71VlPgSupzz3CW4EORONbDnlHopgag==
Received: from MW4PR04CA0324.namprd04.prod.outlook.com (2603:10b6:303:82::29)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Sun, 23 Jul
 2023 09:08:15 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::d4) by MW4PR04CA0324.outlook.office365.com
 (2603:10b6:303:82::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30 via Frontend
 Transport; Sun, 23 Jul 2023 09:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Sun, 23 Jul 2023 09:08:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Jul 2023
 02:08:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Jul
 2023 02:08:08 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sun, 23 Jul 2023 02:08:08 -0700
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
Subject: Re: [PATCH 5.15 000/532] 5.15.121-rc1 review
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <04a3c91c-8b4e-43e3-aa8b-619f9366b285@rnnvmail205.nvidia.com>
Date:   Sun, 23 Jul 2023 02:08:08 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: ab16a304-1379-49cc-7084-08db8b5c5904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IijPJRADaDHM2QsCwaR/hgEjfMOt2XzlZsHaMAtdVPueW/cKT/V8GUAmSthEtbK00nxrx+d78lJj79vvi0R6GOICqBUJVFzGEz1UCFOO97/flkvEcb83G38euTWdLkamTtuWRPX3ZNeWYRrYoUPB3GeosullCVJ+COC2G4WzqjYtFkQ4dtsr9QVmcHEx7rnVHKmPH/z6uzlvieaL2IvTf3jJHPFQ5L6Zl1HfAvbZZJTMl2q6+l6DBKuYTAZqyVo39R8kKqxidnc40offkLAF6rHhrk1wFM849UVR3DORjipWAaQ31Yuclu503pPr2XqSNsqek/yB5ozwvRGyXfNOyuUl2iUJJAZkXtZiNVEwZGPedDUHnmW8TS8xjpTv/dZa5+OhupkGqG+ko/ENU07JG7/kOoeIDxp/7Hvw5rlmsSfTQ1sFdOqU2RQuOVszIjSpJ8H5FQw18hWtbH0wx7cM0vFUlS0ZC5DzCaGAwv5/ROF7K38py6mnXp3ZE/HrHmu/ckiR4xiJHiGkxClH/7oQcCE7phcUsUaWEZ7Ix0UZHXfQ7/uw/ScNqSb73xlKilAv3n3Z3zLfNgywUGe6O9AzxV5ts3lQFgW/ufOBab39/TyxnNEE1hk0nR834FnXorVH5McaHFKs5zTa6LX8gTPZ2mPDdNLLsm6uty/Eqm34rihXaJm/UQuIqPl+/ZHFVi0j0HTQQp4ITRemsAg4hCUjYbbMqDIVgpQ87tvBnjUt0tA7zVxcTs04Djlq5NNfWt4uerBSUrBkDlBkDGPo8tGBHP5JUWHE+5u8XDLs4RJWsk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(40480700001)(86362001)(31696002)(82740400003)(40460700003)(7636003)(356005)(54906003)(478600001)(2906002)(336012)(186003)(26005)(966005)(31686004)(8936002)(5660300002)(7416002)(8676002)(316002)(41300700001)(70206006)(70586007)(6916009)(4326008)(47076005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 09:08:14.8835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab16a304-1379-49cc-7084-08db8b5c5904
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 17:58:24 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.121 release.
> There are 532 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.121-rc1-g48958c96454b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
