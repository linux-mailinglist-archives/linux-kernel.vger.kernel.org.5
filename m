Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4879F7BF81D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjJJJ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjJJJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:59:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E5C6;
        Tue, 10 Oct 2023 02:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQd8WAJJbkqdyUR0e8Unrmn0DajMoGixGflk02YMsvhecHCeTyv11c6AbbTN6PMlhGWgjKo9iy507ZvMFzDKaBZfmpSmCaHaqzfXXuLJ47S36sFhEzKc4TS23VN3zgwCAaXqtzpfIkBMgdVGOJ5C+yOyG1j/3OlNiTATfZVTdNCifysCq2fiQdT5xLrgRlrYsVxhfGOt2uP19mGrnL+yn4Cz/JsbSXrhsEBI9yFlelYTzjsAVS9p/X9r6R6PNJeqc0Ceh0Wbh3Ow6mCAUSdCX4VjBFcwCaTlpYM5GYnhQqNvp2mkv2p9ZZNecfgC/6RxiqN4YwgqWUz7aT3oWJFckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CByRsV9svRbDn0jxscZtlTcaXJOKxLVcVx4CaOXCRSU=;
 b=b89rbtlCoDxu3ndKEhIu5bjbdHHEMRBIuFItGVtk/oZhbyKBYFZvd6ok2b7uduBxjzWKzW9MHuWJkBELgE5f3TWZ8K4f+wexTNMh1IL2omA696esFI/oXYGM9fuKAoWLLKsJyfBSya+eCpaxc+jFdHjMkBXp2Sgn4EQf6S3RVBP7yXz4w1XQlsi7FrMoXK/sUASZB7kKw+el+72cjuRJa2nAxSZmuD1eSTv2GJ2aATadSoWY7lLC8fERH24tIHCnQQ6JHuHv2otK+DrN+rbOus4HOm4gEQUuTwtXiJm1NexWgx0mtoyFccc02iz78yrVSbqj4+D5rVmhO9bwqFg4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CByRsV9svRbDn0jxscZtlTcaXJOKxLVcVx4CaOXCRSU=;
 b=Qj5w0MyxCJtzTM2YNKekGHeEMyewyGeudUw9Cc5OInFyCXjbnEyOedIMEkXFDCQxpNRiYxMs8RSWpA5u0ui5xlZALy9OX7rcjLJ7s7Pk+fUebRtr1AU5TM84N6HPj961BY6H7rk1wWDFwhjNMAIE10lDsdsYbePdtYcFwIXSOCUpeC+bYB6DkdxMYmRC1AdjkQiEjSqzmMdbbKSJ7MpRdjZjqXCCEijoVTTuVoYiQ+7BbNHnY6Uvqe7p99SqEckji2VZ1lZwGTzCAgAjk35050ZRIO8kr55h8dya5lDEzcPdC9cRNwTjI7CqVb4L5W/wNZiTtn43jd0LaUHMdLqZhw==
Received: from SN7PR04CA0074.namprd04.prod.outlook.com (2603:10b6:806:121::19)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 09:59:45 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::d2) by SN7PR04CA0074.outlook.office365.com
 (2603:10b6:806:121::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 09:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 09:59:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:59:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:59:35 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 02:59:35 -0700
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
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a1d4b53b-d68a-44dd-9de5-27bbcb909f3d@rnnvmail201.nvidia.com>
Date:   Tue, 10 Oct 2023 02:59:35 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 66090c0e-e09b-4353-3ce1-08dbc977a1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBeXa/IN0FPIFUJymtzqqqkA6R3EKmCGO9ewrNqTbpa4S9LnxveMoHYFGjJKvAJr4rvqp/w6G+maEKji8ALVdcO2g2YdgPmF94GCfxlN40jK8iLjn0v4oAW6F5lC1RVl+vGs8VZzGVzTbq8rd5mbUPe0J3drbzoGwmRxOWRt/ky2cbTJl/gPh/SvWgPQQ0RuO7Zl+vL+QsurwVP4DzpFaXOra6iKw4eKCVC56Csl/PKIpvx+n6sMM8Hz7Vlvp++A6eEXWyXpZQkmmLGEf8mIRHyMTylL7EoAxgZzgHG0bmnqqwCc8aVZmlxVeJuFaXEQaKKS+M/L/wtPDYd7RmyHHV+NBcpHmlITgrF+f5a59x8aatKizqKwA2ypW6joo9qmE6MYsvzXPkAF2WQGblf0wBWCGnVDpGZa4XNuR/TTbzpdxOeGODBKRfaqawSFXeIzihxHLri4lbGG9EQnRdYISfFeQjoFHlkHVnmQxzlZvaiYi0gWbmY89Xt0e71ERpo0D0lI6h8mkrD8Chtl03zWa/fiRH4tIQoern2Pm8uzZ/Zh1G/l6ALrgYlj+T4YPN+RSBCV0mprAJ1PRTD0l4bx9uBiUUZJxbplOxF/oWnxFhC78B6wHUx2Dzh6BqM0ajGcfNhYuc71gsOMyzS3XhPEZxS9sp7Yl2mnPE4FyWAx/AyAWpJ7rbjHJaVrE/GGJhA39oZPfEK4egTL8wlkC+U46YVRldOHqg9pIU0NURZT141tFASfCzr8b9IN7SRKLB5TeyezKESYHHPbo6Xab7aYIujhHHnfFYAOWWxa4X+TvAU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(31686004)(82740400003)(31696002)(40460700003)(7636003)(86362001)(40480700001)(36860700001)(356005)(336012)(7416002)(2906002)(966005)(47076005)(426003)(41300700001)(316002)(478600001)(8676002)(8936002)(70206006)(26005)(4326008)(5660300002)(70586007)(6916009)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:59:45.4655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66090c0e-e09b-4353-3ce1-08dbc977a1cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2023 14:59:41 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-rc1.gz
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

Linux version:	6.1.57-rc1-g32856ae49e9f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
