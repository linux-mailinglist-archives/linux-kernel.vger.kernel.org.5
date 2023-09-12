Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3B79D47B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbjILPLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjILPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:11:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7891E10C0;
        Tue, 12 Sep 2023 08:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHgujDer8OQXE7TIqtyb4sw+7fUgIs+i9r998HkX1oIXZ3myQSsvjvtF820TfUQFLHlv6CCRbr7jRjCD4iFqHsVT7XASNKsVf75MqWVynpl9mr0BLs2cvXsKahi5/vyRPfcscGEMCxnCyEMwhvgvf6w7NrQ2HpCZaCfRrci0rtnvYyPWz+kJhWOZbNiHcy62G4ZhkxUSwAIWbNwK/mMdpoIP21QekYcLyvWgKjMP4vVG7ZzbR7m+vchLIVzlhKSjk3AgQVKkdzoq0Ha2Dkhi5zFDZ+PjVJIt+0EEKjhNRJS/NM2kCgxFc6Q5zVMa6xkTHAhSu+Y3FR/5W9QNW6xp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2H/z0UDjdWw+HtED8jOj5oE6j9f/Rid94O8+wwgS9p0=;
 b=fRhlJ6eSHKuLrWWsiuzOC4o5I8jIRfNHxnEFXsRa75Wv9NCRoN6/ok/hHpAcolJhNnfrJRQz63ClX5vm0sONgjxr4gXxatcXF7h2tQNT9n1OQCH5BTlVc+VM/9Oprtcgdqo8pRqDHH9/lRquywwY2j2kW82wkGUy7b35WCcpzer/miHnF7qeAEQCzztmskc5d5MwyJK43bmDPlQQplKFXdd6wsYp6+2Uv9Zkg5pjFhdE3t+XVW7KQTg9oonKCMnDmKWX8itLZ8iHpDi6tOT1u2JvSBPKUMZ0WhG0EnxVLiYEhMiMi28E58+Fwa/P2+fpUv1M0DhnPS7xMmWBF3h0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2H/z0UDjdWw+HtED8jOj5oE6j9f/Rid94O8+wwgS9p0=;
 b=XtsWBZNnlnZP1CeffLIvX0+MTK7gEphImBHKM/T5ucfsZvU1+cXCvwZTbPbrjCIbOTblkbdLSEysT+15WO18qQ+XU4ZPke4nvPkr6jcvC7A/3R7OW1YPRjm7u3BizMxDmiJszOANXQCIAsCdyvoBJzdrsQt4diQBYgj/7b8mic0hmqJJk4CqpsDyEAc4ylR9qRYA49VPsJTVksGHvGey3ESFdBv0YafCm/ijCPUWWdv68nytTMEHIBd8uz9tFIMLobKcpnndkGB9eD9GQQt1alkZBoCvJH0YFoCfzyAML/I3yV60osx7+pFdRbBXh4fKoHXhk4aHm0XFFwenGI/wUQ==
Received: from BL1PR13CA0322.namprd13.prod.outlook.com (2603:10b6:208:2c1::27)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 15:11:07 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::cd) by BL1PR13CA0322.outlook.office365.com
 (2603:10b6:208:2c1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.18 via Frontend
 Transport; Tue, 12 Sep 2023 15:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.11 via Frontend Transport; Tue, 12 Sep 2023 15:11:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 12 Sep 2023
 08:10:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 12 Sep
 2023 08:10:51 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 12 Sep 2023 08:10:50 -0700
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
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <97974e13-ed0c-4553-b17c-103279fd4f1b@rnnvmail205.nvidia.com>
Date:   Tue, 12 Sep 2023 08:10:50 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|MN2PR12MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: fba27fd9-d5cb-4624-2e44-08dbb3a27c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WyX8tRmQGBlwq9EsR5WVdO0fIB9lVTs2GTwIuvM9Q2IiY9pSzP2ULaDkcCvKnxzrfBG8bArl8ujzcYOMAhSGoj0AM1xJouY8wOcpuKRdFGpBVgNyjzTQtY0GOQqxYtlncCwNZz9dgRcYSlzIQ7WFrCnI5YSQ3YXHj5vB4FAdUt8mJiIDlKbmaWCVGWRVCUhHiLTXaBPDoEWTZm6PPkX3mEnnG9MEROjeRRRJ5dPcKdGZLFH0kIyNK6NpMyEKFuCYT9PqlH9rj5z7VhZ2nE3RuPBWIU+1JP/xYJ4OAIyyTwkb5MHEBNOaPO0Q+x+MwA9JzjOfZW+Rsj+AjgbBgw2Lr4mUtRggIb66bdiTnhUtuOeYssRtZ4jInnygwkUcrrVOn8doBw3x8SXWS0LeoNeGb3u5JYDLea4FBc+sz/Gw2KjzuSwrDBUPNX1mQ8kkXGI3Fx3FeaD7abJs4912nD1JJtJWMdZ0biuYeMsVGNAuGAlkrrBwvszQUpNUU7+nDnAbymKZ3uTada/yPkOQG6tu3xBTGJrVyZBXH9cFa05zV3qRZF0tH58Zt7VQQ8kYQ1/YzjaToguzc+4Ke4xAzNb6kf1T35J0+BoQJplK5ZNMusw/QGT9BdcUV6zjJJe50vdnLjtuK1S7YwSppYrEAMNCwP3gA5DZPPjwUk2FC7TwbuAhR6tppEc5hCs3Cx1gn3a585sJ2ILsLzxgGyGRV6STyfuAFKjPn5YC8/+IRPlcaxkLPWbJMMyRAcdNVajlrYlXyIDL2Crtyc+/dY4Jr5OI3y5eUtZJsNIBK5pKyme2SnM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(426003)(356005)(7636003)(82740400003)(336012)(36860700001)(41300700001)(31686004)(6916009)(478600001)(26005)(966005)(54906003)(47076005)(316002)(70206006)(70586007)(7416002)(5660300002)(4326008)(8676002)(86362001)(8936002)(31696002)(40480700001)(2906002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:11:05.5915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba27fd9-d5cb-4624-2e44-08dbb3a27c83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 15:37:39 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.4.16-rc1-gc38397858482
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
