Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0A800911
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378361AbjLAKwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378354AbjLAKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:52:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478EB19F;
        Fri,  1 Dec 2023 02:52:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icOhYIxCNGSExK2jTq2CrxlwpmcNe2eOHF1c2gkTIk0J4MJCzkAr3sOXEwZOhjPbPVRNRejYx2vYJf2Mf/yRjKvREkn9FcVy5tL/OCHFWT6r/Zh1AYVnRf1g2lkun3cjpQq7v4jmvqh9ZMW0vhV5qCPHDDgGY1SST6J9ozgmtiZIkWPjdUNSKEO2ikTL/5LCuny4DVc7GEzMQKiu7q6C20WaWFZdkmzeuye/N24uiSNoidGXp1A8i8p22N4hZuJwWUQVGE7LWcvByZi6feh7Q/gNeA0iFc1J+M8u95XQ0MGdvB2O8UX46oPA4ITWSJPCjxA8kSYXtfAIUQSJ5iaPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qxwnx8yJvQ42owbUT+bzn8sAP7Ypk8qMNFPW5aE14/M=;
 b=nM0L+jfuIQc2k6oZiWWW65bp/NMnjyi4EjG0b3xMo/6e94JJWZYE0TpZBtdBYuhn8Kq7p3IANX9M4lR5FpVwPxwrX0KFBfziFloIEfqLHIkIt6b1CcZMBRqhJ3zA9QSyb0xIN9zybKrk8QhL5MLIbXgfAn1ZqBmPb5Z6SLQ3rm2RgepEyLz8X50yvgDxWQFHHY9c8xWHbHipyiqBHqga+Ex31PqReKfELDmLTL2E8ox8eLl5qpBA3MEfpC7IGlkoiDvqjjOqFpsZt+Ck3uLRA+th+//Cjb87AXjJERIr3jzXRjFkjFHBd1E/nXyYHNIj2+lWrbZ1/wdZzWDk3JhAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qxwnx8yJvQ42owbUT+bzn8sAP7Ypk8qMNFPW5aE14/M=;
 b=S7vfVjMSrV8NLV82VqW8oe9zL16vTU0er7+zkgJYAYlE80mZwaydzKczlCakZaWFt7TBgQBYyUhJ0Ko4GWlc/DAFps2GToRdJsO4x9fEsOwZQ7zjjGh6ygdEGLz8ntRppQkHpfMHdIlh37hDgti3C/xwU0lh5tAg8KlBSnrV6TpS4En5tX6Lh5Tg9wHjGysPAby5vulKkgRRDKs1yCIZiqMTgtiTsbjC9I/s+5vemIu5FM5PoZoJmzaKSygmDPwZvQjyFQSA05SR0Pi/j8U1JVseCpdAdIVtshnm2hDh0VcF3SMmZY3bnatvKDL3SYKlE+ls+KHAwiWqW+aEW8F+sw==
Received: from BN0PR04CA0113.namprd04.prod.outlook.com (2603:10b6:408:ec::28)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 10:52:52 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::80) by BN0PR04CA0113.outlook.office365.com
 (2603:10b6:408:ec::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26 via Frontend
 Transport; Fri, 1 Dec 2023 10:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 10:52:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 02:52:50 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 1 Dec 2023 02:52:50 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 1 Dec 2023 02:52:50 -0800
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
Subject: Re: [PATCH 5.15 00/68] 5.15.141-rc2 review
In-Reply-To: <20231201082345.123842367@linuxfoundation.org>
References: <20231201082345.123842367@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a7a3ed3b-26c5-4c30-b5b9-3949ffbd4e54@drhqmail203.nvidia.com>
Date:   Fri, 1 Dec 2023 02:52:50 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9bc0f4-1f81-48a4-0c07-08dbf25baa93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGqgVWmV26cs2Q6QITZZfZFRm/85GMX4iRM8nQPt8AMXXW6/PRrPVxotT/CZ8BOD0RRNvWpuZIhjVnnbrw4Wuft77JZsmMzqc4xTYY2njPcr0GFkxgsavyJYV7GFjsZmiPfqxCS7AGBu+qS6MehwhrXFXsrpUtfT+Xvcx/Ab651oRTE1AdMDG+zDW03ifonBxrH9uaMjjveH+BYuZebwSVptlnDSKTe0G1AvdSMgD+9M8gWAHYzMcYPeke4X1MGVOQP5IB+Pu1aW2qpGbY8eGbN6RuFxDjbgY5qnTA7ga53b7yqn0rH9TOn1CklFoRpTo5sfPdSrFsoTprZAilLV+gzTmI4GWQe4hQYyUxAuMD3BY8QAfHv9rLFEj5sSzKiv0O67PLbn+BtuHXcdn57Sb3l0/olBjuPXFSzam3mlrS8GECQHMsDmI6F3ChJiwtokHMMJjDxYY7DadVU8KpF2/hxUVMcoR1wD8Q5fLr9AWiATyr9ZKn0F8AIvXj+VinJiaYTmUHES0wOYT3dI4UBrG35DqNgMg159D6HfuzaCxN29YkaZ5LzMBmY2JTyrNQ0iKCWVn5pFJLVYdKOTS+yl+ZdDRGRXCCu24HkUBx2fsh0I9LuSwHSGZmhtoGiV8EAjP0h5CvjAI6imBJ3JT12cZ4nTeAVGnlyqHwor3J1DSi4eQ57jiQZPZ9lq285/9cz5rbA8sIV04bTprXEfNwOTbeu7nA0S/Q9C3qi6FtqDeEnwWlZ4jIKjLyJzOvlKRebfU8AnDlU915ONuvfqz55PMIthJB/XD7Z+XERZM10BEy0=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(82740400003)(356005)(7636003)(7416002)(36860700001)(5660300002)(40460700003)(2906002)(41300700001)(86362001)(31696002)(54906003)(8676002)(966005)(478600001)(4326008)(8936002)(26005)(426003)(6916009)(336012)(316002)(40480700001)(31686004)(70586007)(70206006)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 10:52:51.9516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9bc0f4-1f81-48a4-0c07-08dbf25baa93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Dec 2023 08:25:54 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 03 Dec 2023 08:23:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.141-rc2.gz
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

Linux version:	5.15.141-rc2-gc66b1a8641b0
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
