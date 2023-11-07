Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56157E3B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjKGLsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjKGLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:48:30 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCD6113;
        Tue,  7 Nov 2023 03:48:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyobZ3hg8IQqLfx4shDmMnTmXF4awbOkaxEgRYzU0LqtdVY4uim0jr74EHoDOi126/ZtUkAcs1lsgfjMaK+pwBAPz381rl2PraJucE+0abcDVQZDQ+Ih25lD+knPnaxMQFMm1dlD0Enoo4kyBHa/jVt3sUuFcsnvk8x+/P3OtpIYin0TKoBOrhjh+1WlEQT5rvWp1yqnywz+P2jgLmAGbmBTmN4gXArk5i9+v7PUgfa70qtItDQHBGU5P/UBS56mRC40aYo2wYgJui0fvi/jh7fs8BE66ESzp25Beh22WPb0s7gSWLHOnVayT96TrBUm4lqF/zBA6DL+1c6+hDB/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gOz+xKgU0xAJ2M97JAKlVh17h70rL3lU+93bL7XJs4=;
 b=EdV6N4nxZKWhbiwarYrUaa5CmVvKuWGSdpqPQUmywvkxivjwfQD/CffPgvTajSpibwZJOCAFPbM2SUygNVjuTXJi78A9IzV6gm5Ej8pxbfUXFXVzZ0xVca4Ra/FOtDY+UFF2ssiAOd5MfxvwWiOQuce/7mkFKEDBEaezHjh/QcuFCy3LH9sbWT6BrfwluxtgLl44cccxVHz0oy0hL02rWqbLyYNW9FAyra+MHpEsoXEwC/t+d3aZzdeu8CFEw5/8r9CXQQUzoM5E/87EYVecOLZE/7fnBTdkgdrN6rK8p4tFxFis2W0+sbwIXJIV+QvHrTrtsv3pURBMYc+xXBaNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gOz+xKgU0xAJ2M97JAKlVh17h70rL3lU+93bL7XJs4=;
 b=Zl//uH+WJnrl6bO5HUYRGn4y5puw9pBjCQQqkVT2QZMIuoDWkGjPhO6hQ4ozkA7eilwLayXGt6bUDRGkMmFWXItnG4eZddrh57BhQbxkcnlGKJtnMty3zOuP5BRfnzEk3th3LjxxcBMuG9vV/prSm/TBTLIq+xUHnOyENDr8mM5mjrpZ09c/uCK5C2XZD5Mq+Qvk23pK/WwbUSv8HS9Vq1kzntswwO7Lt5kb5EVWyc4TV36YluP5I5124pum5D7cAQh+E4qBJyBwWXYRebOMcXYmgahazxOVClI0AD29XBy4/t33giHaS62Y4DDxBxGTCpTQi7NiMC0Tu69YKQm/kA==
Received: from DM6PR02CA0123.namprd02.prod.outlook.com (2603:10b6:5:1b4::25)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 11:48:25 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::b8) by DM6PR02CA0123.outlook.office365.com
 (2603:10b6:5:1b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 11:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 11:48:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:48:14 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:48:14 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 03:48:13 -0800
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
Subject: Re: [PATCH 6.1 00/62] 6.1.62-rc1 review
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e9a694c4-4c0b-4ed4-a79e-e33860c30e15@rnnvmail205.nvidia.com>
Date:   Tue, 7 Nov 2023 03:48:13 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 273df71f-a283-4ff1-3717-08dbdf877355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYByOGKRodVHOggKi05MSPhVWlCfvM3YEUcLWw1LNekmoOqxGM94UZkctDhlkkc0i5oHW+ZNQKDRD0iP3RquyiAIGjd2dTBDnrcqUT7KqoC57GTD26nitiOciLop48aktGWkROvBjMvg+15xhn2+B74jTLIfY1X14kvF0txWuwu3LSvqdBnIQu4cfDgb7TrR1T6SbRE9E/lAXpBGXmNZ3xo84EL3oQvjTFn+FY8sofVLz5qHYUjDSgueSGXijCJODhQYyCI6PeCCjJub4Qv2fqv4TloKHKkUvA7ZATpC+mWnYtlwU0xvt4sizvuId4HNpp0mZ1e0ysPbffsn/DIoTw2WzVrmdVguoQBeqaAqKS85Id6hh/rjmtMjdA5yDzSXYCfUkNwX60ZTfOcVh6kzXBAy7GMRGAsZvzZ255Euba2mUTtsHr5SlcBPULFKsCA8Lu7Uk83mEH18eLE2OOy/uuyk90ppgF2S8FlYGPH2akBXXVdpi7jdus3Zy0FMq72AJuSME8I/1q/oszGJV5Hv31b5OygUDpAG0SRdT57NSZjCiFyiXlJD8NJjX/YrPfyxhhYS4ATdNKBQ2XbubYf6b/JAnWqhycFDNBZUNjLL9n4DaUGXJoyk971hrZPnyOUYv6ZJ39Wy00oTyph5cQ5+1Two3ASaZyRDwFYrKHUksTfHQhwMpzL7lyaeZvRTM4WyocATpvMKGZK3t0ztIye+OYVvyJJmjdK7r0ULs2ja2oEqqVV+RCCjxkoxI89cSUJEfNUHn7FC2vw+R9EBMNRpyr/BMA/mgD7No2fFeYNhrqM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(336012)(26005)(82740400003)(426003)(40480700001)(478600001)(966005)(47076005)(356005)(7636003)(31686004)(36860700001)(70586007)(8936002)(70206006)(54906003)(316002)(6916009)(4326008)(7416002)(5660300002)(31696002)(86362001)(2906002)(8676002)(41300700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:48:25.0038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 273df71f-a283-4ff1-3717-08dbdf877355
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 14:03:06 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.62 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.62-rc1.gz
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

Linux version:	6.1.62-rc1-gf2e7db5bff46
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
