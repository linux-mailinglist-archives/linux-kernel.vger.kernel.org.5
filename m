Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9697CA894
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjJPMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJPMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:54:47 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7F9E6;
        Mon, 16 Oct 2023 05:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG9fgYhJ3ssumZWxwOtIXh2a4ua+i/BLXwGlyS/fz5vtaF0wF8tp/irjbIAENaTfylkG4Ht/CrN8U9zFROMVbIg+to1jWxaAt67ULyKqy9DztPfauOEFFr66qVOf/xlRFP9yfvpUe207rFbv9GHmIMEquzMWMH1bdNLF0xo9CEvhjUps4p85Ez3nJUdPZtGnb/3d9xVvM80uylbaNI+RNe6poV5huJnnBQdzXSChIU1bEAQW7sSQIhoYcm+0GP7RjBaYmC28PxXjZgSvNTlSLDh3/9KJnj6fMwyxmWenCbRCk5Hwcd2xYiNZvrIxxINzGVQj6hdiosywKLAkJ6SZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+xJCZleh86HvoE45PGQ37GcpVNnuTuP1nCIA8ZWoMI=;
 b=KtGHHiwsMNky1Gak1CNbKjz43gRNQsiVsKg9jQxk7zSRdsFBxMZaTpkRjuhr/BvGBA6Vg2B0WHlb4docVkSCNYj6BgGYeq1O+TllKNh55CbZRF+AOFU32GjGYnb2oBS5A7Yv09lYQ+Jsx8Yxf205Cp+8AW3KM59caXmqKjSc7goshCVsXgoQNrNgoj4Um9SEFC04BuTxGZsigyOoI/ooXLZ+FB+7OcIYkZcVCYosHj2cS/zhb9pvTP7zeWPDoZGKdZqfiEydb1KogVkUmuqfcfrHiLwfqvsCtcYD33Un+gaqysYvYXJCs6dfyN579qw9Wb3joVfXUGB9V7VXqeoITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+xJCZleh86HvoE45PGQ37GcpVNnuTuP1nCIA8ZWoMI=;
 b=IIWxThE8g+Q7XJ+poP20U8z9MNjP56WKUWnDHePP9G3gSfPW2QMaTRZkr/kS9Hr5i9UH3ClZV8MxFmQn3BUUfIaFgcV46gfCZAN5LS0rXQI4TytAoBFUiCFxmxhhRg9PjdkZMRQqKKX0Qc39uc93EcLyou7jdcskRp+/MuV753xspSMeMCMQyy6AI5d/scqfA1e7FN46seEMbVB8TT/CHVkoKlkQxX1rjKvfBw8fh6gPe9XjmhvJrjy5P6chwmG5Xb1yuQhy/cg5ZqewYejBZvggQHYnxntp0bgQMWtIkxEj/tGINwZomELpBMHUVi0ZMq6syOcGzXIyauw4KGschA==
Received: from SA1PR05CA0013.namprd05.prod.outlook.com (2603:10b6:806:2d2::19)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 12:54:43 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::79) by SA1PR05CA0013.outlook.office365.com
 (2603:10b6:806:2d2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16 via Frontend
 Transport; Mon, 16 Oct 2023 12:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 12:54:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 05:54:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 05:54:41 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 16 Oct 2023 05:54:41 -0700
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
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9ed756e4-8441-4229-a69b-2b5ca20d4a32@drhqmail203.nvidia.com>
Date:   Mon, 16 Oct 2023 05:54:41 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 08915f7c-cfdf-4558-45b0-08dbce471133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GWGx7p14iO/8980WmPrF18scBYUPluq4vJAW7j06BlHr2/Zjmtt34VZCH7D99+Dt1cKfLeAewz7w+H8W+V7Zd+0WvYGOguCAvR+T09x8qH0QuyOATuZS/DT7Rzfhzjlw9wEMQ9z+fHiApD/nmgytxYSkFPhOUK0aWlQnns7FwYbTC9SV/PXvGQFMzRMpyusLlpqhFiyeaP/VRqbGzDU4AnAUrPGhMljItMsWWA/2/smYCYXOjkcJ51cREghuirXNM+/7g5oK+TAaV7WgJQHilbTLdjv9TG+NhQp8S6V1CitY3RdSPe9WrbVvMRqFP5yN5eqo9XIE46xWsGHEru7ls3/U77xCIu9RugGlCekG/LpLrFSRLnhiux52T7u6cdmU8JP3IqtSfFf6pSyIVCSJQ5Lwm3cJdg7s2ArWG6g6oiWYnRS6esKKBsLtm+bX95ZqgfOiOR7JzpWvVPUMusBNlKVYA2rI2S9xIE65sKm0miooh3G2VMmxhGG0twKltVBGiHyO+fUPaUKGSQ7v2uqbd0BUMLtxHyMO/2PVq8/1FjBx6O7WiIP4Imhfp10djm4Y+KPvhKGqhR1XrndUI8Wg7n8N4cYCz1eGTiMnaFzJtG3ueer7JUz1UH5Xshh7czZi50ZKwfPcG1i/blbJkKhlew/Ucd/b1FIYARlPvgWG0drvN55L3HjYDSCcgD6O6/YxhC5yeH77aFzY7YIVQ3qLXTN32PtQMHyRiqHCnymifge1WKXK1JTedSeZ1113U+8mIKzVTDiXD2nX+NPIyTHmvYU1n5Em6IzoLm76doVwvI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(5660300002)(8936002)(8676002)(4326008)(31686004)(966005)(478600001)(47076005)(336012)(426003)(26005)(36860700001)(6916009)(316002)(40480700001)(7636003)(41300700001)(54906003)(70206006)(70586007)(82740400003)(356005)(86362001)(31696002)(7416002)(40460700003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 12:54:42.8223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08915f7c-cfdf-4558-45b0-08dbce471133
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 10:39:59 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.136 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	5.15.136-rc1-gf11fc66f963f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
