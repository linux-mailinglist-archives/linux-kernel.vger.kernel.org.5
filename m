Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CE580519A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376753AbjLELJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376557AbjLELJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:09:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96F211F;
        Tue,  5 Dec 2023 03:09:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC0fbLqb/JBzHtFX5jUt41StYMyZsWayIgQusuuI9uj3hQK0g7uqgrekDEkgKZ3bFVdI0BB4qckUxobLVh8xFWZzxybSEGzUREpTt1Tl8wGqzBdGAe74F6v7kNJ93J07akVNEJYGLRpvrIGhCmQYN6o+B0P4sd07rkRGjajSKA3leiPpXC6ZEG18lT/owstHbgnN2yneeoLIIIGcSXQ7E6IaQv52ZfA/xW1IQr8jyZY3qsKfyCTtKujXOqDAMOEKLrJcIzzAOCxkCoGy3FgoHJSna9Juwsn2nkxU05HfuPs0otTQUSKNJvXvlK2sFv9n6HvY9T5WFXNI/RBOWAZCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X38+pDy5h5MTuelDMywsbGzj8jhar/mCeWZXePns+BM=;
 b=AZHwrx1nvpCqwbWlDI8PJ9sHboKK0qPgruz+9U3CZ4/M2lad9pUc5jQbOOKtda32X3ihzORznumHkWstLWbjo17v7HLLHmKZrgx7Og9SO5QF4Y0feGjtVk9MpzaEmuDsJX+XFIC/b9ocWjiYhcRQSHxVtzstrS5555Q5ILjuQ5EQLMuFiVsXh2Kdg/L5FnYlJySVpZjPZY2s0eU3WaQwh2MHePrOHz05bTprT/9MUu4EUHh3+9sea/IFiZlLV85ej4sIvgbhHV1DlX/QzaZ5CR5gzbaJFRyPldmfAwuUAw8wLw1h0AP2h+PYv0Sabvhj4RhM/l5ARHdFTRBrxyy4mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X38+pDy5h5MTuelDMywsbGzj8jhar/mCeWZXePns+BM=;
 b=LCEoyrwLQcRJ9bkPeeQrL/RVqugXyq0l0n1OQBHcgRfmpIvWCzQZukiUa2ltKtew/M058RpxoSJItbJzuEn2IY98y7gs6FzwoQYgC1m35Fl1y4BBPh15bSJRhZtqupV3lojPz+PVogiKeEBDhIyTJqf9NcimdTQpgdT6Aou3PwcKWDRtqwQbcmkGsQVqL/TuK14j8cgNzSChtsbyWilvevKsb8Gh7th6DPVyd1Tmk/2ewpbJofYNXt9S7CCw4O1F/1fC22GlfSjb9RlDDdQ0cSNkS3eC6Xk5bBGesbzkEwrfZrM6ASOAghZ4PtV8LbLlXSBzc8HwhAWhOddvHXaypw==
Received: from MN2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:208:239::31)
 by PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 11:09:25 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::fa) by MN2PR08CA0026.outlook.office365.com
 (2603:10b6:208:239::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Tue, 5 Dec 2023 11:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:09:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:09:12 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:09:12 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:09:12 -0800
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
Subject: Re: [PATCH 4.14 00/30] 4.14.332-rc1 review
In-Reply-To: <20231205031511.476698159@linuxfoundation.org>
References: <20231205031511.476698159@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7156a696-7d9b-41ae-84e0-038d440c4718@rnnvmail203.nvidia.com>
Date:   Tue, 5 Dec 2023 03:09:12 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH0PR12MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: b263e960-a4b7-495e-e876-08dbf582a44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLrfwMLlEBy3A+yoTFejTgnd6TMV4jqfCOzfLlnHXdL5OD56Q9GUkH8zrHC3MuNKzYfCXP8lD4Wph4VSwyDM6o4/b66VEedXqR9wrK00S3qQTPPJ5RZYbCpPBy6+gn7nRD6502RAo6fX3Kb9CEA/JQRPT5XQk7+0LWjwL4cLmL9GuzHsczMuWKSDAHZ5XUlYOPGERnB3uvs6vbJ2oXLHnDfz5ho5OpkPMFJidbLZYgA6Z5VEGmG2CDPNecTpIxvbGgGV0V3I86lTW02l2cKIry4a1075zCE5surEAIavt4/OwVuKBeUcVu9RCVCKCiSvaaM+HvQX8Nd9jua4h9idy/OVqe720DAvElq8J5JvVSQv8XnNZtwslmhkmPQ+K5q18083af57hwtQygpU++KLEQIGO14tNp5raBGPvTGISd3jLVak1EiGRUn9UcluwuOW1I626xZBIA5HhjaAfOasBWdiLZ0ZUBt+IAtzpxFdSG3GKTZTWNLhWCUssUeDgn+SeOIo2m8Fq1QiXyzLnJ4dkK5fJz0LCQHrdg+WFNzVnytGFNZPEJGHfYDA2BUapGCuRWrVpjpvnbPvV9L3p1I7gdsIam6CnPlabKGjZZLTVvc1IcRdw+6z702c+oRpHdHGFkcPNkdoVXReRgAr7bnwBqkdP6KwDHGLW+Lvt+Xvg2VW2050dzqtBn7fmW8Hrg+eroVogewRlzWMnyrAkJE+WP4s5gelUB0Fq2xnRA0J3C+5glsCyet1esSJ/mn+xk3cRzx64bMcHhDZ2wqz8qqJoGzwEPAoav0a9Rm3y87HslU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(31686004)(40480700001)(41300700001)(2906002)(40460700003)(7416002)(5660300002)(8676002)(8936002)(966005)(6916009)(54906003)(316002)(478600001)(70586007)(70206006)(356005)(47076005)(7636003)(4326008)(36860700001)(86362001)(26005)(31696002)(426003)(82740400003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:09:25.2123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b263e960-a4b7-495e-e876-08dbf582a44f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8773
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 12:16:07 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.332 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.332-rc1.gz
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

Linux version:	4.14.332-rc1-g4937f1b0d0b4
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
