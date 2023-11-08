Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90A7E5311
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjKHKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjKHKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:07:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF893172A;
        Wed,  8 Nov 2023 02:07:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0nId+ay8kxSE+5rSwYwpsz3GKJVh1JMsq2fClJwuVB9gAE46tf+/BaVQ323HQzx0mddWZRdJ3jE+7dL5e4b9fImpXUqbk8O+Rz1iZHpU9Xb44/pC/YBJljBrbCV8DtOMPhyATRYXUteQrlDZoAd6KQuU4Vvc9y+3LYCZpjr3CzwufVroCnwrMez9C/9aTDPZ2P/khTYfS871DLhDLTMhAwNzxHYkdYppxgiihFZN928cgA7u0ZIASju1BqOvr8ULD5tot43ead/ADdvMWtC66Og5PIh/qSnDh0g13UM4lX1pFZ6EFe81U3AQ0vwK9dNTLAmM5/S5GSkePARuVsqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S5auYlqRUJM0uY/rMNInlx4MHmEsx1WigG2/fQ3ivc=;
 b=ma5xWiwoa7CvnEa+QWQYzWIpcht+dbBy5zdPYrkCUFqYr0Hi8d8mo/d9SJcJ+9p8PFmPh7dCe+oo5O0bRr104i9MmMvUBCBO46L5VWezlKBqhCTpYz8Mnl7jgOrKX4xvTAHbEDANvUMc3FsmN5Fk8ePw86p0sdNcmaCb5KEjNrEI4igWTR7eJThkjKACUp921TL3lSApybgqMz7yHwK0zHSTHFwqv6IRXG1h8UpShIY5GVqWJbKuQaiBW4AhoPN0LhDlx003VIfElwaMm8q0LPUXDWCGXBbj2pdc5nUpzNFNn0iQGPTT3hBFxjCLtCzE93ulubNyDhefgNe3Gla77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S5auYlqRUJM0uY/rMNInlx4MHmEsx1WigG2/fQ3ivc=;
 b=LKb7fIkzYxCU+MyN59C/pnMyADo5cDWMod7aNsFvKt8CNA1jxYm5kIxDT6wwsm0CHlFEZEyFIQF0ulgBgssXM/WVoKOnVK9JUcnl1SSZyXidOz4YioU4hjmkG3YBm+nKVT1rDJc7UXnAJ6F6e8qu1h+GWgi+2QxFQU6Gp/nCeNSPVolACwKDGW/5GlvQ+9SZR0UJ30trueT9leLVCajvuvR0JE2EI5MgFF9BV4ZubmggFU6hgleIKk3qUSSBP/eVrG5rZBUOILuMpzgX3MtSKRnOLZmzA7Cvwl+cmLClCSJZ4WztTjG4REfSelnvB8nMwcoNcyLl+Bm8A39hjgQI7A==
Received: from SA1PR05CA0013.namprd05.prod.outlook.com (2603:10b6:806:2d2::19)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 10:07:50 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2d2:cafe::12) by SA1PR05CA0013.outlook.office365.com
 (2603:10b6:806:2d2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 10:07:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 10:07:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 02:07:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Nov 2023
 02:07:30 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 8 Nov 2023 02:07:30 -0800
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
Subject: Re: [PATCH 5.10 00/91] 5.10.200-rc2 review
In-Reply-To: <20231107202447.670990820@linuxfoundation.org>
References: <20231107202447.670990820@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <ca0f9e27-2081-42c0-a5b7-4a8c15acc5ae@rnnvmail202.nvidia.com>
Date:   Wed, 8 Nov 2023 02:07:30 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fa531b-5f9b-4bfb-7514-08dbe04290a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP+xn0iuIZrDUd6BeIoqBVyH+RO55ELwFlXJVC/h2ynJUji/SELYLj5p2IamehOvHLPYoJiOYJI2zaIQK15AniQHgrH6H7aB9ji78TtcbsaVEjRvWcq8G0tu4FG1vOnxx3BoS9PAzG66AYctsAYec/lVv0rWcvXwwfquNHEZXbfA8DBjQPAuQPtV5YmjfVuqGOSbQNbXhz/Zx9d6Eb21UIAdJN/VUBi8vJsZ4BSkWtX7/bYsvM2nN4mbQNm/qn4FT8hmYjBljEe8rQO1mGTeqLAKTGhOwYJ6eZ01fEPDKd6d914196X4qsRIHqvsVV0PL6Xfttj23f+LIu0mOjhuGSSaU6JJGEXU2YUnaEQwM0lwNzgKmScou0QjEhWn1wvwFB12esBK3eLIM2P0/iDqeb5TMJ1Ng0Fr2JBHeWdeEVsqFv408SrC4/953p1wv3kBvpgteWL98vptgnsT/HAr/2sbwqoWkxK/6vTpDo5M3PO7ozmFegs2LI+3IioQWkwECEuf8mZ39Bp0ja0Y3q2iE6sd9zZ/wDskQhZkyaoNru9uLDOAAH9E2l/sErLbCCZTP5wpk6aSXayr6jPA3a7vP5iahzj/SwBVSDK5s5MemgKlHPf1nE3PGIKMSb5ebs/4pzXNTvDJgEha7qYOo+PG1Yx9APXac9v+q2KHwy5iJxhkwOK8jK02sprik77t99VGG6WBX6X5OySSLyaqvcmd5YEeNfELsJV3+LHgXR21Fd20SnKN9bwYiz1vHOQgtXw65qBT129HoBTJA7YAiGZhtfxmRcxmsgOz+EQbuEe/Ye4=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(7636003)(82740400003)(26005)(336012)(40460700003)(70206006)(70586007)(426003)(478600001)(966005)(47076005)(31696002)(2906002)(40480700001)(4326008)(8676002)(41300700001)(8936002)(5660300002)(36860700001)(7416002)(86362001)(54906003)(6916009)(356005)(316002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:07:50.0458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fa531b-5f9b-4bfb-7514-08dbe04290a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2023 21:24:57 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 09 Nov 2023 20:24:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.200-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.200-rc2-gc4863380dfbf
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
