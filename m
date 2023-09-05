Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCC792BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbjIERBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354378AbjIELJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:09:23 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2058132;
        Tue,  5 Sep 2023 04:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGA0HWu22rXfcXqI06WM6I0fJwrbhvgtPYlEfxUX1FClhAhn6GralvZkQ1bjE7AYXZiauS1B7kaBQ/U4WsdMajyGXmljDBxxrE106q/vp56yxafkN7d/AFsRDJrZJY/1n/GN589HAYt3PsBsk/UEbM5cNoicT1PMYIWsdktGKWb7qV96sNprnb/1GeXvRwE6Z9zF86cRSv0eUuf69V8CwMdtCMFI8sTdlOvLDt9FThj39zn2kSaz2hnHT1qzK94MhJW0ygvR6WMHObauP1J8xZvqozcUURZKLjeLleQcuxHHIrpl8v5kH0sIAsxn6Ef37w4PUIUADJ2xxcHR2S1Sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJM1tcRTKaBEkCCJX2zkRTTsvOBL40nz1wSiazdBVSA=;
 b=E03hKMf+b76DL6/XojjDDPLyGLRwbxsJn+K/doSu3nFy2KuUKyIB7hVIfJSNN0sTUSKqYUqqMRJYvVTtuQpVENW6KY3fxs0TS7WnzrjYUYMA4segdVG73sHcRXtAj+flf51zd6JwElQH2OSb89SDpbsCBrTa3CBkqVdoe92KU6zLyhiszCB/1Xn2nFoZTYWBMdgMiwSp8M75uiAdt8DiCQ9ioa1W++7UsUHMVTQWpHGkw3bCTToC8iVan2LyMrWUaJA+Z4xm+YEncsxh0WeljV3FSUkldpb/qtR2ziq118XcH6aDL/bzqk/zVjpe3UO4UUE94vA0GTD7MwE4JVLsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJM1tcRTKaBEkCCJX2zkRTTsvOBL40nz1wSiazdBVSA=;
 b=Aibu6vd9HQNGwK9yRaet19B4SoKKEgKJ9hwUK94aeibhJ65E3xmMAv48IK8VibeeFnejjxe9+phSyRvJwsEHIOHBzuN6BQpfEQz575UYyZY23jNuSvGP5k9uN4RtgKio2U8dcc1PTrnxH3KKA7d/pZGybq8LuP5YUDaVLmAvu+Jn0WAouXuCXeuPbuUi8aEeEDEcntQquIwEplAGVqeZWzWOSimRlxUVYV4aYngJ8fdLVNGscHW2nGV23TwzpXptEZc4XMDO/s8IFcL4aK8u520oxiUuJnceqiXWZFhjZ3fFFGt8rqTECgX2lMW4FYQpAbz/X2EfjhShYIhBFT2kmQ==
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:09:12 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::9e) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 11:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 11:09:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 04:08:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 5 Sep 2023
 04:08:57 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 04:08:57 -0700
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
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9f9043cd-149f-407f-9861-7885018b3aa5@rnnvmail204.nvidia.com>
Date:   Tue, 5 Sep 2023 04:08:57 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f082927-c441-47e4-10b1-08dbae0088ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8saBYf7VBdu46dF3bTNtAyDYZB45S6OSLC7QtNYbk3U5GSxliv1kgF1zoJXh2fcaxBq5sNH8YcGhuCeZLf0hhVqaKRdpedjeUWpNNy2JPxzGY2P/PwhbjKGiGNFJG2glmpBUWJFCQP08DeqrjE1hY7WY6utiDM6gQ7DOLxm4XFdQV/hEtRP/9VrQHGuib9G/qlMP7aLzONznae3QMZErXPfPm/To2KYY3uBxwbylvFdRPpMTqsTdLeAupaWIqOyWICLz5H7bWH3hhFdpYMxg1x1+kookjIKaj6iuoX2YvLu22EbbYn7OXMWiwVYDH/EyDG/OHAnyywOYPsNLuXKLn2J3H0h3z//XC2JOZVuWINqSouqeShi+P55N/G3Tp5mndD4lZPyGwMtROCXH5PiU81n7KmM8SBXmTLbl3jzUQtadpzrJArpYGpGqj6PsOFt968vei4TgrhS5ec/M53qjVU8kvINaRPzH/AuRXDhztmhoNENLzn3HEfcz+egZ597Q7gw3J+sczx60CfTM5EYrv5YggCcMlsz8GM4qUTOG7rqpNe8PQZazrG2HxbD4AH+YQNnyEjjyou5amG1tPGGrs5m0nMZ3F3PQ8QtXojnMhwukwly1cCFsuiNIQrnDZbOErvd7Es6Un/zNDnMg50WxLIV5wqCslLyrDOAf6TTqNjWL9e0rB34T4oyahXGCGde4hVCmZMq1eYtD3L/ADG5g3LoOIZTXFRc4fV/yolZYLmrrB1WwMycBtUhWneEoMg7E0FfXb8JVW2uSpdzywmcNePrnjrXEtLquYvV8I/NvkHQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(26005)(40460700003)(86362001)(4326008)(7416002)(5660300002)(8676002)(31696002)(2906002)(8936002)(70586007)(41300700001)(316002)(6916009)(70206006)(54906003)(356005)(7636003)(478600001)(966005)(426003)(47076005)(336012)(82740400003)(36860700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:09:11.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f082927-c441-47e4-10b1-08dbae0088ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 19:29:47 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.5:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.5.2-rc1-g3b1345379dfa
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
