Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B47E7E3B41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjKGLnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjKGLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:43:22 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D511D;
        Tue,  7 Nov 2023 03:43:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFmEHWyaBbAqZZnmSvIf2eWTLEMfmqcQzCJO0cC65iR/Ymg/aXWZTRjMG8MWbeA0CriP1vnkFNa5Vh/gce8/V9f7vOQ8h9oW8GkWvBSe6/LCWnhKJ/j8Me4v9KPiEQgD5wah+bZJ+2Jm/FOiU4+4W76rHsS+nrBrowD+En9tJKE8wzd1rOoMoBGdwisDpQTZIRnNPzkWLzl3HZbewhXKUAyh9eXf0J4yj/hymfqX5nAcld6bjvRcgq3amcTNO6z3dT4oWovAtufwOOoaUXbcTil7G4HBdY95fYO+AeYGZtradAyLocGDPUEA0E61Kua+z06P+b5NDfoVmhvlFNm/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8YHc6tpWF7MJLTxpw/lMdAnXbNeyW21XDKxxVtSq0E=;
 b=D59fGLcOYasWO1FN3k8+Nzkalvrw0t1q6MUNYvXSL7krk77PqR/m26i7TzoKLhk5budFQ5FvDMZiC5NqzZXpSujCFnps/z+46GiTzh4q//1bxJPUBK9w18/sLjGLMtRe9cw8ThfB5mY9evRnODp9fXIshKtAFhslk37VLF+m5QkzBNlS7qbL8cCLcU9K/WeiN1E131u4/DbILmw8tMpqK2bRP9smXOyFrvG23ZHzHYT47VwzGV1yFDJM8uKC+PSVfGic+hdzsSifGyEf1l1LXZw3TY98KAz75AWTiU3FqsJ6uhjPEBk1ysQ19XUd8C8tkokV6cLg4nA74/SxjzP+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8YHc6tpWF7MJLTxpw/lMdAnXbNeyW21XDKxxVtSq0E=;
 b=RVOd2FVeoxICh6SQ2gp6adyzURvN1YfKkevcy06KxFizHbfP0gZiYbD7cslNG5JYRFpAkNqcZWcj79gbE0hz+XVv1UVR8Zy0J13CFYodA2TntQVtzAWGEqFKAFDYHsAkkys4pgh/VFNMDs6tu+xF/kQAwEZrFfSeY7+Swh0tkyLB0KRBsJkylGO9ZYo8MmFln7jpWyPLalkDL+I35emkUdThraMgwhur+dvjMSP7m/iVQv4E8b9JQmHi7kgbvnzFCiUdyQFtfssrp1w8o1qCduYodAOM5E4N3QsN71HI1GER05C/oer2gc2C5fZj2IMIJbDAPwSZVY63EwXXjCoKgw==
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 11:43:15 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::69) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 11:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 11:43:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:42:57 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:42:57 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 03:42:57 -0800
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
Subject: Re: [PATCH 5.4 00/74] 5.4.260-rc1 review
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a9cb8cb9-e0af-42e3-87b0-9e06cc284e4e@rnnvmail201.nvidia.com>
Date:   Tue, 7 Nov 2023 03:42:57 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: d074b7c6-972f-4ecd-40e9-08dbdf86ba26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K51D9LRPFGgHH5qFm1C+lzvDLSLci7Xn0jJFoMsZQcQrEirWDaommuhbfqG3sQIrB80QNJSwkHpNab6ahT3IjVJw4df0KFob+rB8rVLTwjtRAUpBKHVkE32+XFxRS3nPNSQ7efipT8COXO05smXgGdzn4gXFA+Hk8fvqe10wzrUIn3cqxtAhj8KYMVrQInmGYsyU61EJicFTBuqocKTNXklgRBK6QhrJ+nrHWzH0TmQwlR32B8HNirSg3jT2XBx/uyjfnkBI8wnP0ZovKL1n3NduyCgBVIz7ffoFp0aRrFWIT2a1HJJQUsJJzAeiAx9oiJF1X8W0Y/ZDfKz9NClH3pL9vrHPrr8LVbkWmxyFiFEbQrSgJzBGzZZke9BuYBHOfbYJgd5Azez0WMTNlQOZc/Ti4B+xYigED1+IfPV0lzcp9B5tpM9UV+hceQ3BHvy2JkvzjfxNZX5Gzr/u3/jRugNOopGPa3PsIwzHqZxKLHNEu0PPEKo7epZioj4Z1cW378I/mli1Nl6IMAiTNf0uwXTIjhkNPAm0Zv+Z6pMxlMAlwPVh6XWOX2JiOJDWI50HH8a/RwA4iXFKWHBm/rboxg40gimGCnoG5b5TKwHLSRji7zDONpgTXExKZgcdz3FQMlVHuVeQliLXuDZkPopbwrUWGGrz1N5qI/mdbsgEzH7e8Zr4V/hjiyggEG6Ve5F0YqV7JYp1z9ZrrE65DTIYmLZ3uqXeWZT5/9RXSnA1iuMWbnEVvmRgFiT/l/UjI+6V4watwuz81AGowUW8/DgMSokxTY4cHuUIrNQDHnXo52I=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(46966006)(40470700004)(31686004)(40460700003)(40480700001)(966005)(478600001)(36860700001)(356005)(7636003)(86362001)(31696002)(82740400003)(7416002)(5660300002)(70586007)(70206006)(54906003)(47076005)(2906002)(41300700001)(336012)(26005)(426003)(316002)(6916009)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:43:14.2550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d074b7c6-972f-4ecd-40e9-08dbdf86ba26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 14:03:20 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.260 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.260-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.260-rc1-gca21f12ba7d8
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
