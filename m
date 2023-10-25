Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482EA7D73AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjJYS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJYS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:57:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFAA1989;
        Wed, 25 Oct 2023 11:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnH70jwmEf3wIw+4EnW+vvYIvnjQAsKS/sH3cfgD3JzqdpwBLGYoLckP3bLFLykTJ6NsvcLaRDIBv1KiPVFOPmoc8L1nOjvP/+johm928fgTVNIwybLLXVVCr7NXSaykYIvWIhV5HxgRngjFmLW2KcVIhIALPILfGUNCYrTIfNIOI1PYmyPUihzMKWKhcvQ8kw8Gcwd4D4o6suF3YulGQDcFeKYkT96KDjbarBb+NPh9N/FM7rYOdPS4RjqbAF2yM4EiNeA6UrC1/VzvG10b30CMmDDxrPb/m9gQlKF0uuHAx5Lc2BdSRfDmAtAxB3QPkFHAo2QqDCfWMpMJBUGCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDH4/uqJQARrHKD2Uta09LSGnlLmqb/CMfp6uOqCK8o=;
 b=K1809M4wHWhW2nuMGYrm/rukkIBVK0f8VATHwe2U9Ak2KEBv4s67dEhPv70Ab90XPs6Srl4uZbLfIbMAKvqzuwxTrq5cCqR4sKi+BsTQlYpJQn4jKz3RnL+iIaTW4cFe7wI+PUf+/nLjKNy2C5tSz9ecFZI/Jg+94adjj3g/TsAYmJtJuQnmArkGcG2OgffJxmc8hOZm3Q5KaXHQXiOrAclCmpNgnku1axeakmKLuvHVF+AYJnBg45GbfV0K0CNUbb+SvPv4Si5JYl7kqioZJs4o49y4PlCDxceBQeU/qLfOCW44XEp9iRq5i6kpgWvsbmX6ZDINEI4JZnfUlEbhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDH4/uqJQARrHKD2Uta09LSGnlLmqb/CMfp6uOqCK8o=;
 b=A4oWrICxe38xrkbzmrsRjZCykU6H1K4n4Ix3ozv+vALtxd/PDBG3BVQdFyqphIyNaAAmRS0ixFvkzNgVVve/V60DhiJeippEgAhSXXVWXwyurPeTLVHl2GUR19J18alx7FdFX4IB5ReAqHt06Y6fjAqM9gjyo9S+/hBhlOMy1DXXmuFEK7XN5xFjUGn0d3q0vaf3dGnszXWNy0WaHVonpfx8hQSENODU1C5Bl0GPBfKCSW+nqhs5GLX9UGYyWQ3muYnKkDUlVmjhvltAiLOzx8J6DOc1KYXCdm17r1/mbfCSM5bul0QQI6vCBqPO420PBTbJ4CWYLmSTuJSRlY8/AQ==
Received: from DS7PR03CA0230.namprd03.prod.outlook.com (2603:10b6:5:3ba::25)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 18:57:11 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::be) by DS7PR03CA0230.outlook.office365.com
 (2603:10b6:5:3ba::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.35 via Frontend
 Transport; Wed, 25 Oct 2023 18:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 18:57:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 11:57:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 11:57:03 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 11:57:03 -0700
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
Subject: Re: [PATCH 4.14 00/66] 4.14.328-rc1 review
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <c7b63997-e59b-491a-a573-4323f1254ead@drhqmail203.nvidia.com>
Date:   Wed, 25 Oct 2023 11:57:03 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cde6643-8c9a-458a-3fca-08dbd58c3238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3aagqRxQl/7SB/toqAbfYJo4XTfE4nUnMi8rDuFvre+rPB8sNiQ/x36yZLCjWe5Ni9QwR+ZJL5u/OjemX+aLRbZSza893tPQp6/WX/Iishojzub8+LTLgxU9sBQMo/ZqinX2GUsug6bpXsiWAkLVKMe1dPxOBN1QpnTP7CdA8Rhs1M3GLrSq8/x9YDgljT/prbYFul80hJCDOgbwWHUUYCu2QctOBoEByEsF87/CB9j+TiGpY905TWkKeLyADYuzRNhQ99R6/M+zRPEElurAmaGk6zrCyJegktRlk6IU6/L2/iQABLVsOUcpfiBI4lfcNWFYgprHJPGPvfPU6YM5LnC+1VwHlrFfWX3fgUVv11zJjermCAuQN8iBPzmxO84YzcjVuazKN/Kghb7zoaoAb22ekdUxXfjQXuowFFtWa9Dq17k4jxuAhRK8CMmuFud50A5i4WBnuWp91IoYvYksAuovjAHzvJDekjEBu40b3r15zPrTZCpHSA8DNNWR9MJqBEiVnGqTXxnvHxhJq7IQKcrRYQnKBujUPC2biZbE6knmaq1jrXqitT4KfCqlPB9PXTBXn3zln3Nn8kWl7JgcCKA1PsotvBfLAQVRg8lS7g0EJXuxSls/1wp1igfzCpmPa2TvpqsdXC4/3IZPdAFn0wRY9nm7nR0okIbyLjUdTQGR1wvB80HPUWrCLV+nOLTQiYKeaam1kYVk062UT1CESIN1UCL8yuaGTy0r59CfoLfOJIZMNp8UWpgFEn2xVy/g6my2l5yOB6QOkXkF9LKrTXweL0X3fDP7RfHGqbMMLYI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(478600001)(70586007)(70206006)(54906003)(6916009)(316002)(966005)(31696002)(86362001)(36860700001)(426003)(336012)(47076005)(82740400003)(26005)(7636003)(356005)(41300700001)(8936002)(8676002)(4326008)(7416002)(5660300002)(31686004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:57:11.6335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cde6643-8c9a-458a-3fca-08dbd58c3238
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 12:55:50 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.328 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.328-rc1.gz
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

Linux version:	4.14.328-rc1-gacf25a8a5520
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
