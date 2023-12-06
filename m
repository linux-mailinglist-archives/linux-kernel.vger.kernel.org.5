Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECE806F04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377930AbjLFLvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377907AbjLFLuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:50:40 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1826ED3;
        Wed,  6 Dec 2023 03:50:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW3pkLyEYYCfOa57SqY5p7m55ugB+149tKIbuF07mJFNehdOyq77q1HHEoJo0G322zI14FY6BTvxH76wDeX2PoIR8FISGDOJTtMxpe4GR02rovrIRBPouil6CQceQAw3KJZgkdBhdrtZyzwrBhpMmyCIlsTUewFWHXZkR5vGBjAmzCpExbNbjyQaBO3I7k3g2WkRQ+SaoqMp9i8QrlHnZsCQzdEOLade3rKPJukiDZBKYHt15tOqzSq03wVd7kxLdKPd7pbGxqsjDHhHBu8E0DlzulLySB6T0hyhmv9ncbkWNbQilFfaPbMi5ItIy1M0SSUcGAkJuQ0KML2czZxuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8R7N6KRBvDeoCcGwMc9nb9IyLJBgbxuZp7V6+lHzj8=;
 b=bAxgl8Mr/2xQci0SbMV/EeDuxsRt06boYWJS9xIrFhycSRCXvurpMUJNlmIxmbWxLif41AWhTZKx35WNO4Ud1r3blKzedAOy8LtGxXsSB9LyoCSowkSbroPkwlYUSmzWpdhXSfa7IwFmD4Gk5Qu5xJ6PTQGZSN521UxNbgbHG9vyx5r8rpA6RDcj2kE8iKt0Vvb+3xlfcSVxPHaEtmG6H+txi9KmuQYvSRdO4mFJ1K+Lle1aF1B2OF/+l0ody2xnQreewU81TbxPjwBQYFQc1j7RtKugshU30lhc9KlrRh4NdVX5Fcc5MVnQubTvKoJyo/MzRfqowxILWnPFY4fvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8R7N6KRBvDeoCcGwMc9nb9IyLJBgbxuZp7V6+lHzj8=;
 b=soqbHJHY+BxdhzXp5dy66q2dWjfdvD7+YEkPpsVk0RJaXA+Yo6wFaA6EdoV68YjOxjY9d5PIOSJndYo0QlLHCtO8S87kbw6H2RmX27w/6EYO6GZP/lPhbE9Ka3y2cY8p7D9h0ufPIWg0mn1wT1RutHcQ0GCOZuWnscCKUnYgeujZT7x5ZQugVt/FPkNH5FWRhKARMv0R+zvQs5d5Fgqmzb1pA5uQ9i1iqbnX/HDtnNnNt4rxiij6MA6cCB7HRlrOhEeeY7xBtNLRdz7/eyL4ogVMzyfgZuCsx7DGkjVVCwP3q1QtO8t11Etzqcf5Tt4yzdHrvmxcxF+hT5YhkbAKwg==
Received: from BL1PR13CA0165.namprd13.prod.outlook.com (2603:10b6:208:2bd::20)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 11:50:39 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::73) by BL1PR13CA0165.outlook.office365.com
 (2603:10b6:208:2bd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 11:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 11:50:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 03:50:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 03:50:18 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 6 Dec 2023 03:50:18 -0800
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
Subject: Re: [PATCH 5.15 00/64] 5.15.142-rc2 review
In-Reply-To: <20231205183238.954685317@linuxfoundation.org>
References: <20231205183238.954685317@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <846112a8-e3f7-47d8-82ae-35ede14d22c8@rnnvmail201.nvidia.com>
Date:   Wed, 6 Dec 2023 03:50:18 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 2113c4be-a723-4b91-4de0-08dbf6519167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TEdvpKb8AWL5INibB8J5S6MAXoirr34DmQTgNLnEyhAZp84x2VQHdspWUgI+6TJaPmve4gEbzSNnT/+iqnUDceqDTyG8xi+zO3i2dnNhuQws54Px2xsvzGIv2LoE0sZfvZ3+uP3wkcPN9tpdkSC/kkU1IbV013uwgiKfLWSRsTqbyaq/ZrjJqKIfZJDmowPomhWxLyWwCIhDwh1bwYduvJAec+TkZK6+Nai8xYSuwATiwjlStQif94PMc8A2cBFi+WzcfcLrzw4jrArzKhSqD0dEOlGK3jlv5IBpOeolMDqfS/81URH9eBkR454YmDXYg12xf/7aZCRWYP08OAMd6+/CfPXOmkiuzt8VE4cHZAYIiiWglFonlL/oIVlNHCQxFl9q1UPj59mJC8GQeraFvGlGSp7pXIEOxCcWXmenAaiDqtCKKMvjW1mrvC8CvfVGVSqf9TrTNgK29NAKtVqpdR/lwUfKEUQ96PhXbzOFtt5tVLexXh39rcRR5ewieh+K7RgoSdd8Y6SFDZL4eTs+JkUHFBD3JLqv5b7VUhCr2miMaS2zYKxrP6omLM4UJ3MEqHpkSiy2cjoUG2yWfJVc/NyTUFjBoRAW6eJ2S9iajqJEVubQsNPSdJkwsfIXa7fSO28UuGfMAqW0anN2gT4XNYY9Wnb45fSQpvME6+fTfzKyNBKmdy6AAVjOeqyfiKloyFU4Ps/CzQ4mj0NPW5mzOdOAqEfp9oXwKwbApodzHJLz+TGMMk86fOIxmXp45QCex7faVi6XA+onveK5pHi5it/bKALa8c6PfQrKdyuE2E=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(31696002)(7416002)(40460700003)(5660300002)(2906002)(86362001)(40480700001)(82740400003)(26005)(426003)(336012)(966005)(478600001)(47076005)(356005)(7636003)(36860700001)(31686004)(8676002)(4326008)(8936002)(6916009)(316002)(70586007)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:50:39.3276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2113c4be-a723-4b91-4de0-08dbf6519167
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 04:22:31 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc2.gz
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
    90 tests:	90 pass, 0 fail

Linux version:	5.15.142-rc2-gfef113ea8057
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
