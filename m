Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BED78DE60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbjH3TCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbjH3KYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:24:31 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7FBC0;
        Wed, 30 Aug 2023 03:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5eFqbNfey8GFcmM8iJFTA27RvQgX3wL+m987+gNdzZYciYg3z59mEhmUwzbkFHnC/dCHfA4A9ysn4gPvWKgg24Yg2iwPtQrWBSOuvaYyZX4RrLQ7hzqTh2lhfyz5cuR4VzI1O4CxvIznYp29HKQafwcg6dSgT5Ff+vO28z9aJv4HXn/UolMyGWr2wwOftE1uJYuWINWiosJZLUMFLIkx3S5926sQJjNlwx/ECnCjnWbU6j/Nt2BtPSsNeF1ofUQX5HgPVkItTNeNhEDmppfpmHm/ucH8ZVTRvm+UzSTKDfkES75g09pP27duwMUWFfSZmNXNPm256TMLVecwRBcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GC4Whf3kcKa4Q8DsFJyc5VCHSPZDL6BnQHnYBF63rA=;
 b=OF94MESakvRgVfnZOLd6n9vHpVpru9Q8kKIEevHrFSGjK9svuEiSqKxPGvBJmhbkl16FO9/tJ0RbugNsInvGUHpyRK16ixYB2cNEFkncQIRfxsqmclmKryb0/lQTBTnD5AnMasH7wsIZttttWePk3PMG8APaQ0pzQuDKOohpApxgEbisT9RrHv+pAhyCtW/fCWIf14Q9wAW8+qaCKX9ecd3E5VSjBof6dZmzjPJB0PO7LpQo+qA4azrUr8P6HGnxr6Yj53BxpClwKPl1Vv+JH4ImoBvzfMaANbXl50N+CRKnNRoJkMulWF0t9jsGZtIkkOPMNTu+J9VYotUXjVx7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GC4Whf3kcKa4Q8DsFJyc5VCHSPZDL6BnQHnYBF63rA=;
 b=kMdMyx11KJXi4I5rFz47hQOn0v2q/aaE/SUHoRJ5LrMBO6Vbo1WpEovY92IzLKyK4srg9jOHVN0mnocTH9vrDhGt+YB8+jTQxwKc8RBfx/JTK5NPOEWXmUDsJ9scxbrrXZad9gx0lDVjHj679NiIVCyi7w5Wr030uJj3hIhzCA7FBK01NjdiU/r3r4sUoUtsjuKboF7ll8v8ARmFbNFmJvcRP5UqJ+ZX352o6mAwIn20XImXbyXjwgNdu4L6AhjPUc15uEORV/r8iLrf9tO9AEhF6+sGLMXojekgFo6Cb7apDdxLqQxCXX+pSLcqaBsPpvL2Df4VTHIWuPmVEplEDw==
Received: from DM6PR12CA0031.namprd12.prod.outlook.com (2603:10b6:5:1c0::44)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 10:24:27 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::6) by DM6PR12CA0031.outlook.office365.com
 (2603:10b6:5:1c0::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 10:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 10:24:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 03:24:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 30 Aug
 2023 03:24:14 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 03:24:13 -0700
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
Subject: Re: [PATCH 6.1 000/122] 6.1.50-rc1 review
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c2cf0ab4-c8d0-4023-831d-bda6ab46183e@rnnvmail205.nvidia.com>
Date:   Wed, 30 Aug 2023 03:24:13 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4c0a07-bec0-4a95-9ced-08dba94349ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IdRN6t6TZXDQOFnTAouRcNgQMPVfhfcLlxKp/3AEX6GPHlfwVnZ10ZBvQ1g1PCi5f8NYe5IkpOA/sfqU1d8ddirqV2XmaFgt5YYG3qqrMLyUmzYYbXGuoVmZPMsbFyxMimsofV5xZPG+G9IyNJIRmaDycTcPYSyY7vlQmdX8NTDcaBj6BgjfatxAL3tWsYotjpBQoKPQiIdJg+zMgVf4m58NIsgnZj8/gIwCHp2T70ZNdT8gDNyOT3sv9QOpeQpUAyy9saQYlvKlVdbS7jslAQ6BNPnfPqw77zb0P7YhuK2Lm5LRkvg9/IV5+E/97sWNtbEcJYG5mbfHNwYPAzwEj+Yx6AaiHPZv5wZG3I2Q/sXdf8S4ESOND3uenDZtAAQoaKAV/Xj0ZxZolLupcuZ6PNzG7ex3q0v8F8/6VWSjimLrzMEjrUdPI/V8la40MtEN1veZItLT8fLN92oUT+900EEyt2MKp+NzwGa6pSPBpxRGk0dSbVtFuFAMrDzoK8XvzSq9YTPvMgwLZhnPe1CIUs8wWzVTHGzDMB/WdZ0eYfvtza/5CXttTQg2ir/1m1gIEvUKJzLKiwsqbDUpqy8fGP87Nnp9pQLL+WgNLCzxRJvdQ0V2LijZ67Oz3PSCBLwrzezH8d9NisSS9vu/f2/NCnPZvDQGjKVsY2c2gUnXClgQ486uVVqzOTs4GpsN7v3sJ329Bh9r58anRCQsESeCdyHoKQTfaCa0Q/IxxD3WugeeYGPUN6aTwcYU9+0Y4Ux3JQcDS+Ij1GendsLBi43TlJklWOqVPoDV8Dhn8ly3kw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(31686004)(40460700003)(40480700001)(8676002)(31696002)(86362001)(7416002)(5660300002)(41300700001)(4326008)(8936002)(26005)(426003)(336012)(36860700001)(47076005)(82740400003)(478600001)(7636003)(2906002)(966005)(356005)(54906003)(70586007)(70206006)(6916009)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:24:26.5602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4c0a07-bec0-4a95-9ced-08dba94349ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 12:11:55 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.50 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.50-rc1.gz
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
    116 tests:	116 pass, 0 fail

Linux version:	6.1.50-rc1-g1aa86af84d82
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
