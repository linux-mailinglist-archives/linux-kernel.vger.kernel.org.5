Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB31080FA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377773AbjLLWS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377698AbjLLWS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:18:57 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF2D2;
        Tue, 12 Dec 2023 14:19:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRDKpdsuHwgsxLfJGqlPqIu1qymJT714poddJ6xw9Vxc2f1a6f9/+0OI2CiSOsuMfJZHJ6ubHh5lnbavcIBOTnr7d2MzF5NwPHVGoEicaB0LlhaDaxCMl5O7PcRgVCu0OGTbbTj/kIoxezO1LiQDkKiYq/Uk0PJWi92aVTEbuNd8tNmtJeMtdNuw2b1CIbSBat+djagpLg9axzbv8qFcQqEcV3JdaHxwgryooYPKH2SgeTpQrpHEPD6Su7ozGi5Jh87+WXrlFGnrG9waWYwRu6jXUQK1qxX7/+PNQypQvh1k4uTLY0GG69JghP7kwJOvlJ8q0O2ZX/JbKg5tj9cKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POtZk2SwxT+Iz5uLHSf+DgDaglmoXbc6DOmSgzTgdxw=;
 b=dXO+ECEfAQFxwnKtx5HphwrBIU8fKR3xpQ+9t4Lzn1cEwxl3zbg8ImjY9AmsRnaCm71pShFO56PxXVEURYM148xEGhYQDqzAPtK8NKlmqfrly3Q5js1P7InQK91sdIJrdd4aDP75+GRmXdiWDlicMIfofSvMuOk9bkUXnyaQOl30f3p4CWB3KmxsUVZhKO3Zvj5rIyk1eIfuiqY9Q/ikFjsDEXN5O2I0bF3iwPdlRa4oOdn5cA1LMYDWBHemg0UlaLBYTgBClt8smbrslvLi7/8QAbWBd0s+df/MjPyX+5EvD7rgDOVxSvFcXJUZJ8R7Hgsf8pvLgg932d221qFt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POtZk2SwxT+Iz5uLHSf+DgDaglmoXbc6DOmSgzTgdxw=;
 b=oboYE7Zcda5onCcSlm3+SKor1AS+w9kahevDZfYIPZwFWVf6++IlqLfxLnXCv1B13HwKt9sBqtJ8Gm7sX9dE5hR4F5pP1EOUr1B9LSKyQYm+4S5Lr/ImZ258l/uY1I8AT5dVm6SCboyDRwTQohDofr8Euk2GSmUp5NJPb4HDJGng85ZGDN9lk6oR8zAyHgiNTFnCU8lBKKg/iYmYP2aVtstiXgymp94D9xHOTsFwOv5n5PoC53g7nu1dh0ZtgZ4orbe9hVxVT6bv0FFYGX/VlkA+LpYtVv9hO/vYVPtu8WKUrWoWmL+uxEjytwGjSnVat5VfKpQlUeyhqADTeo8pTw==
Received: from SA0PR11CA0131.namprd11.prod.outlook.com (2603:10b6:806:131::16)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 22:18:57 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::cd) by SA0PR11CA0131.outlook.office365.com
 (2603:10b6:806:131::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 22:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 22:18:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 14:18:49 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 12 Dec 2023 14:18:49 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 12 Dec 2023 14:18:49 -0800
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
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
References: <20231212120210.556388977@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <10fc9338-409b-4a2c-b8f3-b02609dee146@drhqmail203.nvidia.com>
Date:   Tue, 12 Dec 2023 14:18:49 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fc3f7d-f40d-4eff-3ffa-08dbfb605588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjKINt5EFNDDeJvhd60TCQ3Obv/4INdua1IbBCGaSnlwC8pvThjob2zaVYS20hkG1bY483CF0zSqxEi3XwZx/WieGQ7a+kko5ZbpOwKaakd+VQPCDloo3L6MMHMb3DQO5VuJq2VFoJ3/vd+tFmICOA3M6QxJMCpcsXhvOvEisL9q2faQgArF9MYvlEvoIJje7HREXqrXddEWo1xLMNwCOHBjwa8iwEjT29V96chcmS54XOw3zZH3Dh0CCD9iwVbNa1O3Pymq3pucM+8EO4Mva6BIhWyP5gCTMlRhXwMW2q/awGD1P+qiDYVq57eaKESLg6v7VEbNcfPggAfMyzUCfwjK2bKOFdVRI9ooTyoEO7A6a0FYr07uRV/9XbY+8KEoP0x4GW1rKd8Fwl8MdsDQfZDBjalFcpr2ZPQO4Szfy0cqzx9dDLY9H/Jz96l2NpfZ+i6xSKVUQva9iFn5u7B2vs9ZIcWtjlxXVO5yACk6ua0ItMhyqiEaaJyHpFTAFwcIMgyiVOYZfIhypDaWnN3q1cFmAGwtB66qHUVqZscE/b+IXzIo7iyR6G7zsFEWDAjNFgaYrCl052cm7du3zWrCYmYNxcay7isvsIbN6xdM0ZwPuFxz7KQSKU0QPL2t6No5VIL81NDQ916+1hw99cf/mQK3TVuRyNoG4YhBepSt4QiRqcenFfEwOsypwNB77dEd2hjrh5J8zLeNaHUs92QU5oeHwLCVlXO8wN9s1GE4L6p2vX1ZWetBjKd4nNQ2BYI4WY8uWjkO32/Kplm+ZQDr0iy+OXWNFA3ncqfwWYbX8wU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(26005)(47076005)(478600001)(36860700001)(336012)(426003)(7416002)(70206006)(8936002)(2906002)(41300700001)(5660300002)(70586007)(966005)(4326008)(8676002)(54906003)(316002)(6916009)(7636003)(82740400003)(31696002)(356005)(86362001)(31686004)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 22:18:57.2231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fc3f7d-f40d-4eff-3ffa-08dbfb605588
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 13:04:56 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc2.gz
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

Linux version:	5.15.143-rc2-g58ec986ace5f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
