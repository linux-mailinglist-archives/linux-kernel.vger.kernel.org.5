Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F8D761E77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGYQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGYQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:27:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5611A;
        Tue, 25 Jul 2023 09:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFsov5C4eUYt8khrh4GD0cg6FoNec5JBSvGUaSylyv7m3xrx796Y+BENYXMF1FXMRR+kPwywHJCeMre5dnrTTHTmq0IIhyixY0l2pcQTJLjO4RuLsbJAM/04f0lnV3udvmlFCknL/V3kyFQxllrfYr0PzLJH2kH8sSy2xjGkxrHCErOs2wh969m8RahfrgILgtGb2c1OPH4NR0ZQ/EvReI6b3HEgs2NX0xcxrb5hCtyfl/7Zij+s2Dq5B1VXK3ACWCYsnibIeXTGfS0ZJuSi7SqZcw2xONvJtuSjTuEXR2F8++Klbs6TH5JfL1xClNHsqsDZ63p3UyDwdJWik+Bwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+DtaNZ/3XG7+DHiplzwoSIfXnvpDKmjI4ixjwaUzqk=;
 b=c/MMp8atSr0yMzre6gF5SVbrZ5Wm0OPgBGZEnzUMM1/0dm182ZKRDNzslm5jccc01aXU7KRai/rtSqUzgcfEDwrkBH1FsjMARCb3NWj5nqdPs/etIOtHqmzK5g4/VrNRK78dGj6aERNZG5EcEoxPJQgc2XP36KXo1K0LuHrELsNZCPCSxweu9ehxTtiHe8Gqhjl9zFIv/MP00Tjo45BzZAaWN+bcJ1H8Q5bIAlGfObO0S2+L0zUMoIE/t99o4L0NpGaNl0/NxI/LOqA1/U0RYm5bO7l9dldNVaHsq+K8WCwxbmczJiaDQqto2LzKWWS6ez8KqchfDB9eXMvojcFwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+DtaNZ/3XG7+DHiplzwoSIfXnvpDKmjI4ixjwaUzqk=;
 b=pgZImOeEKLa56bnaZLgfocAm8ZFs86oG4vlQHP+14M5qNKd1mmLCPSgaesSmTKowaSiRJnIAJZemJjawEJSY2ceG60LjXcVxDLggUzNJfXqSp70mugBtcrIGzMqD1w8RTBljsuVz4eJX7vid1bx0LtmFn/ziLscEoGkHDH2OJq6Tv7T3IrClpXAGhxrYyo2jTI/xg7qY5WvFDdVtKxu5bDqHRd/zKVEcqQVDaGNpsLtZcp15IUqMMcS8KMqzxSEnu+ZVkZqj9LkPI64Ym1ibwCnklG1JCT38FQGETdkdQLMhlB+z4eiM2o/DJ1WJfrE5tLHPoxeDm2BG5HCDSyAzqw==
Received: from SJ0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:a03:3a1::22)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 16:27:40 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a1:cafe::15) by SJ0PR03CA0377.outlook.office365.com
 (2603:10b6:a03:3a1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 16:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 16:27:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 09:27:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Jul 2023 09:27:30 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Jul 2023 09:27:30 -0700
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
Subject: Re: [PATCH 5.4 000/313] 5.4.251-rc1 review
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9131881b-ea1e-461d-822a-088a5df4ad6c@drhqmail202.nvidia.com>
Date:   Tue, 25 Jul 2023 09:27:30 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|BY5PR12MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 642b38d8-e93e-41ff-f4b3-08db8d2c107e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qymqQCe4NGPtX8OecO9mv0xsql3Fc2hWPx9HzEFbXzmAQtqcME0k/CjAKzz2mf4orqKth71kSS3rffPePBariPCQ6MOLuLtVTy9H4iMY2xFEqYnQR2AlvYq6rf9PEDJWGbgJECpc4gojp+sZv2eKffFLl2GtUVAR+ulwCAPLqAa0CuvICdlprZdgjN+H5XQsVwNHxM1m74rwJD34xeNqZBhPHSOKWel/nq+wJ0ETk0MFsf3PreLaBF3es1S8LPTtpwFHHBj52El1hOzy3mRyASPfGlvQbhkJZpIJRptTDhFKJ/SomuLUHfY+4lWkwCvIiHfozwAp0mhhUZAjIp5LTGmmlYDyZ9EpOQ6b818zrE01huzS+/u2Gxpf9szrs2ImQd9TLlb9OG+lNj4JWwn94lM5qUzZZj3lDDyc2XIxVCkydlBssqGgNQuiPD14b5Nte3giN8SA8Mf99Tg+01hxskM0Ybr7A6CnyoH7GC8yuJfw7W00hDriVYM+de+ZphmDzAnj7WfqzYID4Kb5Rhynhuk/oTfF55qPFPIleH0FtoNTDgN+87CqG0XcamyjCY7RshLioPkMV4qtJ7EQw6Bmy3/qmWfuk/52+gREfPUKJ8Efzjb3ut8PEAicfjXbYJS6OCT1VtK6oaZwVKYzL4e/jjJAQT+5KXfgwViJhURoz3XOJGu2XCQ4Sg3BVq7EdI0NDMzXwwuLCCgxSVq35bxRtclXf4R3bFBynsBkLB8YGK2TUYpgihcQGR3Rf8l5NMKEkax3ilApVmFb/B/R0/dxSiDEDQeRT6yiptfRjF96o4=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(186003)(336012)(26005)(40480700001)(40460700003)(36860700001)(426003)(54906003)(7636003)(47076005)(356005)(82740400003)(31696002)(86362001)(478600001)(70206006)(41300700001)(4326008)(316002)(70586007)(6916009)(2906002)(8936002)(8676002)(5660300002)(7416002)(966005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 16:27:39.6952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642b38d8-e93e-41ff-f4b3-08db8d2c107e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 12:42:33 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.251 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    11 builds:	11 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.251-rc1-g1362bbd1b27c
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
