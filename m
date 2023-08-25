Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE80788495
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbjHYKRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244161AbjHYKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:17:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF71210B;
        Fri, 25 Aug 2023 03:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITtmEM1VqPRI3wubhU2AlDpGeZyUolWRpjklUtylk5/3abgA7mzWrSrGQKH9rTg7yBXcZNcRFq795vXl2rB1Gt8QHErcgzL68BrNRvEbSbDAor40aS/RdPNL68Enwhoyout/DZS5JwpEm6VVfHW5oAqDFTj07eZWtz9Xjqqn7FwnJKNcrysK6prVxXCcfvvWWnZ273HQK6DM8pqBeu+nkcg5nsInXrqA3y851Z3g9rFPH7/A1ohu907Xkh8lQXofuEAF+pWjV4NHYWg92c9zBmj4QWIIAki+t82xqT4jxAssh2RPFhtbzjxslbtqxqG3NAbUdxBGslOJB+wAr9wU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUSMHK27Taad8TDXd6xfubD06oLoueIndVR761+Jc80=;
 b=dqrxDbDfU1EijnOAVOPZm3d2f8TggstpfJiDxU/ZbBKwa/OllzYBsUFGQYVpFxSTLRsi11bEpmQwsxFtrxcKOIB3hNw7dohipUdI+6cOP5wI0Hl6kKVHFplTLd2ViCor9l6hJ1Dz+A6SD8laP06Xl5gIDE8OmmS9hlzfi7AZA2AhXPzFXJLA4PmC47OvAejXb9rQ1DHM5AEvIdXWoTyZ9NTl7P7w4jD0apf0c+yFiZQfU5SVoDoHw2aVK80PRaLm2IiJoJ6Nk89JI154Mn1XvFI2pMbYwdxU1mRjif6RuPeBMzFC64w5MbULaCDVywQbTGEnT7UmPGL/XH3FM4Ffww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUSMHK27Taad8TDXd6xfubD06oLoueIndVR761+Jc80=;
 b=tTRD/IuqOX/eC/DTxES7NCNg+4P7syRy7ToK6QfQxaKF6+hyHliFjj88LYH54uLN+6ipSgVb7xqPqM8eEqN0gNncNQ0tkenZ5rtL+PumFD5VkjfVgmLai1BISLAZne4yhU9NbFKG3al3VQYPv0knq+GRtzF9OBHAjvkXFzm8KCMG+1+c4ViDv41/swTljqgNUZrEPTvd5b8Ie2w6Q8EvW77f6jBLCknxO5lpGsN3eiFtt7+pXxwa8cIuOvaa45pWD1tL0Qu18VS0OQVK4YKqJiuZtwFs/HNulRNYrKtAWj5w7pxxCJcCx/wAwMwtRxHCq3pBaCoM8/bXUtvTmD7aMA==
Received: from SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::33)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 10:15:15 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::bc) by SA9P223CA0028.outlook.office365.com
 (2603:10b6:806:26::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.33 via Frontend
 Transport; Fri, 25 Aug 2023 10:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 10:15:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 03:15:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 25 Aug
 2023 03:15:02 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 25 Aug 2023 03:15:02 -0700
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
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
References: <20230824141447.155846739@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <21d07c5b-9599-4150-a9ab-a37037248f11@rnnvmail204.nvidia.com>
Date:   Fri, 25 Aug 2023 03:15:02 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe7bcc6-9b4e-4eb3-bd45-08dba5542ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFoy52F1ySMD+u51LEmOL5ttWQlDDYa179utcOMnhphguL53bys1Yo6O9LOJRO7jgIMXN7fHE6Z6QH5/zM0hhyMy4zt9jgg+PncHyGqx2riSyJJ74IZF67wS+NHCEoJ8yGlOF2Y8phblYekN/gxIkYu4NHvkns0CLbXZLESrsuw5YsDOCIc/yMg2i93qbNDckKy/6h0Mmv68HdMvCoK2L8E8pUukq1QUMG3DGsV6LetPt3TAkLu/C73vizGLmQmhfY5QsKc5jf0zns2oenqpkB9JZnfGCiMJmyzh8+LEIgIKFBu8XorJQ3zrrTy85/Bh8adl1MVAF/gzJgfZkj8ln0nSIknEKxBV71dd7MOK3DcbGpe0eUM8LBARgFLIfc2JudzI3On2VeqYl4qangeE7xf87oZtl6gwVygOcw+CQaUpyeZpwRnXEKp3vDSFVRhxp2Uzc4Oxpe7x78pBzsdktuR1sbVZewyJOy4+FxyeNI4vC2Wa7shRSFCKh69fv5uOJAnbVL6wO8jEPY4g7r/xImHfdeFwu5TedGHap0y83K/QonUb9RrHa3upWvrWk3JT4T60hhaRCc1arjGSq0KBe22N8Xj/KUGgFmXPT1Z24wxYTi0eyd9qLGMsXGNK9MHFQ/L7hfsc0/eqdEgPqvZkaVBxAHJWoU1FJ2x/wRkCJaevL8oEesJIJFnm2XYYi1yVku3/+kyJ66yfKRpzpmJ/BN688HN5Pd7Vn2A8qWyrxw5aVFjKBHwMIT0Y7M7gHfcXQlq+6a4sC+Erc88/bzo3vV4w8QSFG7e5EG73x20NMbM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(5660300002)(4326008)(8676002)(8936002)(426003)(336012)(47076005)(7416002)(36860700001)(26005)(82740400003)(7636003)(356005)(70586007)(70206006)(54906003)(6916009)(40480700001)(316002)(478600001)(966005)(31686004)(41300700001)(2906002)(86362001)(31696002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:15:14.8880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe7bcc6-9b4e-4eb3-bd45-08dba5542ccb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 16:14:56 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    125 tests:	125 pass, 0 fail

Linux version:	6.1.48-rc1-gc079d0dd788a
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
