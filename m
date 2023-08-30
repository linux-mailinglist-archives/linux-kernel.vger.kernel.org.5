Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61378E022
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbjH3TNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243222AbjH3KYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:24:25 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11AC0;
        Wed, 30 Aug 2023 03:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh6VAczJibwqaQNybmOPGKz1fImpW9tbub9GnTZXX6fw6bKw7wJZ1ToDGUytcA/VQ+GhJWApAeBElnw/qw7pvoP759VLSGUV0YHBTKCBqGsfnE5oIkhybnWPtuUK/3hlZVW9YB87Dlt1L4b+WfsfjTK32DsRj7mkJIUlKui2jrXU7IEC7mWDsFB06GVt7A8MSjjvTD0OBQY8VCbLjPb1UFVm905RZP2kv9imlJiD+QYnUFAWCFcmsD7sG0iW+TCU8ZXrgoA0BiC0G+1x9ZOL2C4rHNa7ydIqTOWalxb1yRViKaUU28JNzBvW+Zw/u9dVsHJnayJ9nZDAM++AryYePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3b5yq7SfNyDxTU+7w792npzXzbjm78HuE36i4Grkxc=;
 b=OIrOIUyeiaT/2LLxgSW50WPZcM5n6tgFwY1s4Q+IPCFGfuHbhiWlMW1YZeaCGLng31oui+ve9ZflP6C/W6w2ZdUpPvi5w7ZVAzTKNfV+x0Q5FacN1/9qjfWOPOafPgAyUHA/EA6L+NK2z7Qi03E2AerXkruFjAc0lxpkjMLZZgg47jXR1j0lFc0JOaO/sUo8G/5kpV0YR3tA4Mn/hIXYpE2TzG++bKojZAa9gWwuTu6Nh1VfA9Ltw5FU0mQhEmc0KrH8nByTWASF4tIK7LJKOp06dDj7Pq4GV5yn12yUYC7aT6QRNC62UQNWyGMqfxdx9SVrBX1SD1JoZiakfpfXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3b5yq7SfNyDxTU+7w792npzXzbjm78HuE36i4Grkxc=;
 b=lxptntm/SWvzRdMKJR8uyLANDIq2Fy3p0cd1uH86ocec74V07AKzACgdjum6pXd5kri/Nd0XukXJOabxEs42+ELDUkHUeAz1dhoGZgCpUY23ggloj3fR9OrJMFxp/cZxANFBs1Nmg8JgQjcMvsVq+tUF+A0WYthouFL1z3sPfJ+aBEhBKfQn0KGsaIwgrIZ2mAWEYZcHXJPbuZBeQ1coVE/ln4vBqbi6n17ttBnUkLOes9GcykuR0530WnlCcOCuj7IEScSIbilXcABzNMuVCfCz9qYFkQHwrKyU2yOGzA82fht/Sbt1rVqXuA/ozNSptCCm8X6uPEhunmv2gL4QTQ==
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 10:24:19 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::c9) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Wed, 30 Aug 2023 10:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 10:24:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 03:24:10 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 30 Aug 2023 03:24:10 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 03:24:10 -0700
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
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <662b481b-5a1f-4bb7-ab0f-dcb29a4de23e@drhqmail202.nvidia.com>
Date:   Wed, 30 Aug 2023 03:24:10 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 454c13a1-c94b-4c82-b23a-08dba9434558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWHxKezinAhrIajK7JTOCoLbPWsJdTdK9svVJOdCdh8wlbCTlc1dNcyBqFqWvnk/uODO2YdvaNhOBf3hVjjZh8uccfqelbuoddxnEriaFHW5SraT4uYBN+3oMKzV1JlaXJ5MmuPmzXPxSbTRW/2GIJfb6GK4oApRO1caYqvrS4nhI8IV6YBGeqCC57faG2DYH9tFboD3DA9c0nNldbleSUc9y02j9U0dr9bPHIUaWDMkpTJWcVrfL7BdLKtOb2jKqa+YU6A2Ydve3lmJJbYmBolA99fqTOsxms3vkosDRSMTnDKcnZzvhaiN4JoyhC3yuMiuJan+Gzr5lvbhfFg0al+Qt8OUm4M7AI/j1kMGbvl5wLpzUE0k9oNROxcYKA24hG4PPkflUHYV0Mm6PRzXij2G22WZcCCHIL+fyAsIZyVao9pDko1uQXeiRMzalTY+CSqGngTKi8PhOvto+b739JfoY3rNZTm98Cnt5fQ+xyAa/NiqrxOJ5Dr7tzdjRFqXjNZImh/MT6qVS2wNNh85jpP6opr6WDwAPie1sWe/Qa34i0gu/qCBFVR33wrHyvaZmM4Idi60iIGkDSuzt7NC9w8Td/lQt4gcXrxXdj1XLqUy45C+4uadR3z7RmR8jRfC0ahqEMINkVNjcrlNM8eBq4sN+g3TTveVdgAt5H+RCW1TuSr/yFyFvCRVTlMHITMPXGu3VI72qy12k7BKLS0K8BEMPUBNuLTCrHsNlecOdM1Bt5ezo9YpJJVTrJo8J28EkCFnFtXZSC8Gb836Gb1IS+NmMZM8mXxThpn+jX6fL84=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(70206006)(47076005)(41300700001)(336012)(8936002)(40480700001)(36860700001)(4326008)(8676002)(478600001)(966005)(70586007)(26005)(316002)(426003)(54906003)(6916009)(2906002)(82740400003)(7636003)(356005)(7416002)(40460700003)(5660300002)(31696002)(86362001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:24:19.3619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 454c13a1-c94b-4c82-b23a-08dba9434558
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 12:13:17 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.193 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.193-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.193-rc1-gc40f751018f9
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
