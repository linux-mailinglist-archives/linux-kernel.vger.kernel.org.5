Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBE7AAEAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjIVJrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjIVJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:47:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39B1BE;
        Fri, 22 Sep 2023 02:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLRryEE/z5UV0Dyifn4U0PtXtBtSeqFVBhqUm5X36udXSsrGUv6Su/q+4H5aj2eBZ66HasgIp1qQCoKVWrCzJaM1186sc9AW5vBV6zqO56CooDdRwaK+fyOC0H37W06ps/KuzPXCGICH8qYQPSsKzRP8SyFxuAy9TCGFRzZ4Q9X2E5Nf5kJsxJy2FjvJ+NVfYp5SMxgFVHy3ofI79g3m4++7VaBgyFvG7Tm5E3lh+khqakW31841MByNCwCx7qu63ct/HoU7fM3ItvR3qZOiD1061pVMc3U5YWIJuw4YVXrRSLTv47mh9Io+R4zEh88BCwdy81D/hgd5jA24m2mW+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZRObVoDx5Qx7BjW/4QTPCOQQZ562gau8JBPx/iAnok=;
 b=UrGE5eNopEFC1XMSoB39af/f73DL4/ux4XqO1sZ3UpLGh09eL1kosY/uN8TGGp40YvDbDw0JU9BRS1hMLZ0cvkWVSXvSXta7iy1YhS+wIesq4cMEOrXLA7fv/s1NyuDtblVcUNsty+9J2jpbvOjze44PhejKb8N0jbQi6qrJD4N+vYcSF9cJIykmhh67hHlQ7CdBlSn3wA/3dKHOjt+VafQfOlpT/WEQTLreQDxkKcp04T5iyJLumUV+BpgfbE4qdUuzmTnGsiYyfdokqEbL3lLTsdPLPHA7LKM2KDzvywI8bJuX50k5yEnehyX2pd/FIW5mB4XrDNApIn2jY5RnlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZRObVoDx5Qx7BjW/4QTPCOQQZ562gau8JBPx/iAnok=;
 b=NYwSDXyzGNePJDkSVBN636zzqMrdegbYGjIjuakiBviVukzF/BKblWgnmXezW1dLY15MOcYMRJCWlq94SKmFMwNuwVRKWNFbz/myQ7FyEC/zljzfmUSpExt9Wms3Hd4dDuzF8+sJzOZH+8zBNFp2cnYY8TYXq94KItV6z7S2s6GWTEmjOOarJpE9gKbm/zVt5TTL+eX+lkBipL+I104h3vZQ6AKaC2xxk5NU5++jwgv2oi79dz7qR0TEtcA8iuFBGUp68Uwdz0ym1XxWztqYm9IsbxsSylzX9L4VLpeB9/uI9Z/23nj8OixybnszME0mkz9SJ1HeKDLt1jVebcHKUw==
Received: from CY5PR15CA0030.namprd15.prod.outlook.com (2603:10b6:930:14::28)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 09:47:13 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:14:cafe::95) by CY5PR15CA0030.outlook.office365.com
 (2603:10b6:930:14::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Fri, 22 Sep 2023 09:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 09:47:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 02:47:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 02:47:01 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 22 Sep 2023 02:47:01 -0700
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
Subject: Re: [PATCH 4.19 000/273] 4.19.295-rc1 review
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <be0d6a4f-536f-4b0a-bfc9-79d54e0b3869@rnnvmail202.nvidia.com>
Date:   Fri, 22 Sep 2023 02:47:01 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e46806-432a-49e1-a77b-08dbbb50e604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXdNdOmrkrKmhyyInHWTMC8L1oiUviGPfMALll1OpWxrhBJ54oxchyBPgYXL2DHtKdxZcfjDsZEEYqTXVnn1ShkVu6zSO198ia0qKr7MpxYmjhBpkHQejQJsk8cNy8V7w1/nW/2RK7w7HV8bEn3Zq+yt3w3XHkZ5GEAHOdqJDVxqhQdy54kBr9pOMUufFpr854B14BAxEmhUWE/FO1Jj5ShWBNrmVkzeucLKUzK+vnjgB0hpdvXUyQxpdmpSe6bhg0AjXTr1/gPZhvEqE19l1PjfdTgZX/AK0hGyB3p+ifCxeYeOwqMcvAq6xaOr3A0Cp1njU1p3MvCDNsHfL7XknRgfL7MZy0vu6dnrMjkoDolX2Gg3NiTKL7rF/Y3lxTgJEhWomnOOt7cGsOt8NGHoOvrCQOvS4u0NOi8y5Zq0hpzqiuLI86llc84TtFgdEHMTVzNmX/PlEVbhBmrbec7aTWqjWS6F4wVp8rjN8R7M+8TgcknFcsIjbZuHVy0TW93LAZSri1pslgkwt7byaosnwXEHTX9nf+IYuTKw3V3QVjEe9VE3EEawaNO60kF7az/sIfFUHEyI36Avk9gLVB4AsGKzXRHGuLikeYKST7Q5EG40bFJwTD0u6OHg4BOLuG+J/IJGWRvEfs0y5v9MRH6NoTkZQwAyY1UGkwKvU1mHX69CfwaYtWF0RkdQOvNlGaDMsQwUzi4+90ge2Hyd76bYf6Jlc/QIU6Zg01vK+Wnz0MywahXBsx/+oPmBtSWoFr6tifBML0SeeQGqIsBMy4JhTgMfjqaRkS67W7ToZMBEIUxWnDf/nY9tw8nd1AKwvVUu
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230921699003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(31686004)(40460700003)(86362001)(31696002)(356005)(7636003)(40480700001)(82740400003)(36860700001)(26005)(7416002)(2906002)(336012)(426003)(47076005)(478600001)(966005)(4326008)(5660300002)(8936002)(8676002)(41300700001)(70586007)(70206006)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:47:13.2180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e46806-432a-49e1-a77b-08dbbb50e604
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 13:27:20 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.295 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.295-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    11 builds:	11 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.295-rc1-gb67b483f6a45
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
