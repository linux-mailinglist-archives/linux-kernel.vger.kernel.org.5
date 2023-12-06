Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C23806F00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377901AbjLFLuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377812AbjLFLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:50:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3FAD47;
        Wed,  6 Dec 2023 03:50:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc2qWNf/zqM/4VNJxZy/lwkmYax42PYp9GwnIZgIQrfl1lbWH1nSQDhMnMtW6MsA7tT9O0a5hqAyUS99BMd1iIWFHHq/IWfYSEzbWl4fqWlv6hkDLO6O2rtEoyXJr9seTI8juL1XkQiCJC+4ANRKZPRbC6EQvorsm9fvS4PpEAsMQ961hub2nB8+X2aUSeIQ/DInwuRqMjo8ZEaIp2PwLpnCHfvuyRnpiyJ0CTvJs4eW3Z2kdOrOR0DmtBMzYd5tXSnr+6sVaXfjVBLfFaT82tfC+50Iq/aWrh7LfbPUUrQssmeUteVnwmg9yopDaGps6Px2ikDfBFy1AkAM7mgFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUd+2aPKu8RAZBEV4uqQqCHNyeiQymHGM0N3MP51vLA=;
 b=miex+ftfyP0dbFWf7IrCeDoaNZYLEo3Uphg/Fzho36cIrvZSM/bPJ0yEmPnwgK30qcoJsIQELEueP+v0iYLNcwMer92zBQUMFu1s93jGQ8JpCXVualxSkir1rnnJa5yEa+8NOxZ3MLnegqd2U4qDMp8kk4MwIanqGIOa8TLOPHUTzaSvcJiri5DblVpK+jVdHrXRO9HGEJASajcHp0SHHb4NQkq/VGsK4ShoWoDNi4DgF7tM5vrBgJiuWl+/J7C/tfkCc6QNmqeguh5rGtn/clg9o35LQba6y49PcaNYpDhwssaECVaQK9WRsG+B7NBkUvj6kNKZAUo9xe2poFUjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUd+2aPKu8RAZBEV4uqQqCHNyeiQymHGM0N3MP51vLA=;
 b=QCdF8Txcc+GxtChy2rUNQVcs0WqFyCtMQXzhOFlcPrpHEDHcGSgzINMPuCVzvrdz+T9M7V8T3ML4xb3TBnBGBPHNErjVN8/sLZD/Ky82sm/RdDMkBvVJy1fIu8zF8/gJh/3TPacYhuJbKmB8N7/s3uPGMqlKzZN9mM9AqtIanF7wAdT/1dFuQkGR4Skr5Chja9tTgzFgfrhwT/UzymBe3QTO8mj+x5JmT51rLI+9Dlzadpga/cMLZVB0pm/4E7mKBjSgmm0NNJyyT13HiUm3XRtUuc1PG7kaxEZEtETG6r9c3FD6B6sNFlzvAjIjjKKAEEB3hk/iCmMh1bbD91A65A==
Received: from CY8PR12CA0018.namprd12.prod.outlook.com (2603:10b6:930:4e::18)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 11:50:29 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::1) by CY8PR12CA0018.outlook.office365.com
 (2603:10b6:930:4e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 11:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.26 via Frontend Transport; Wed, 6 Dec 2023 11:50:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 03:50:20 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 6 Dec 2023 03:50:19 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 6 Dec 2023 03:50:19 -0800
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
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
References: <20231205183248.388576393@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <b0f0b502-6fe3-4e53-b920-e15e759269e9@drhqmail203.nvidia.com>
Date:   Wed, 6 Dec 2023 03:50:19 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: e016f996-e0b0-4042-e7ed-08dbf6518b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3riZsXlPkBmkA6ttN8NmYmapctEmLW0f0VDimFdf4dmC6v2T4kFqWsuqEg6MvxoNyOyG32ASpfWAAB+UOYyR0ecMTGVug4GLnoaPNUrdkif5+nmq7zZjby240/mMbMm6dtXYA66eI+qdz9ahnJsPdLVQM5z5E4mp4wcmjY1VauS01lWp6Lie8svGxy9I371I4JFXMNI07sRKE1xHt890J9cE/ByyggYMrd1ja0kQvC8IzWeLbqtGsTm91T2yi7G75UuhswEieCUg905d3oYdDdMOu5JRGGCF6T5nBNHZ2HbfzefB6GMRmN5ImTfy3tTc/lFZom+RBet3O8VHoZ9FEX64RyTXMuxaNPPTRTyiLjiEFGkmSF5GxxToPIJzZGEGWT1ydkJIvRgHYnNiRJBMRIKWd//GrgWDlHHdHUPii75tEkvnTwbKtHhmkRHeRdpJ/6Rgvlbe06VVVgf5UCtZ3/Af+Kg6SejPyzfkt58zSpxtDr8hRMy0VlsOz4D/xbVuP2Bpoo9vti6q72MHToTgicF7xejyKCOGufjfsTs8rjnyRm66kWYI/n99TCL0C6qG1+UyRwU7eSxgU7uv4L3r8FnTf4Jtg+yX0XP/q7yNWDKBeq4jQVdS4Igu1v1PeoeGQW86PVOB1AT+8w3KgwISwV8/kk0LxsTzDX0MLuhxKVo6t3SycnGb+TJ5mIZXxDz49gqSXArebHrS/CW+qcn8tXypXuM4rUTevMYfmXJgR48cInfiJZ3bRo1WIq7ddvIF3R6pBLm3d/pgPHJArugsXwuYVLrvIhxcRlSmaf+83Ug=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(70586007)(36860700001)(7636003)(40480700001)(356005)(966005)(478600001)(31686004)(47076005)(82740400003)(426003)(40460700003)(70206006)(8676002)(4326008)(2906002)(7416002)(5660300002)(31696002)(86362001)(41300700001)(6916009)(54906003)(8936002)(316002)(26005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:50:28.6995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e016f996-e0b0-4042-e7ed-08dbf6518b00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec 2023 04:22:38 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.1.66-rc2-gb22b2d52d0a3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
