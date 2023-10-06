Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96927BB445
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjJFJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjJFJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:32:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E99195;
        Fri,  6 Oct 2023 02:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP4a+/0j09WpgEQi670hxiuuAolA62YeWPS5H0MLmik0jYFb46JebstBcpjYSEIzjJ4rNPkpoGoqyTl/UrN0Hn5Htt+1mkLP+iyUt44SyBAubSbP38E/pUEQ6GSM0XtLs4W98IXJ6KxCic2NyTMYVlBhT9Um5BUyz5X4HitqroVJCHl1WVyFf1eMHY/Ab+Kr+fyAR8JGgZUeyr4Xt+0/MzgkWQ2EY2UZrCdh1nydL35w9lw/NLVcNNGiev3mBV7z4XvgcaQtxAai+/ILUstB0pX+PRhchDPxDN6MCZAU7zaHu/bHfRXWBGbnwhHpvkzhCnnUHlRjOi/6IUOSBfcG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo060JCu4P04mta6y2skXgk0sfLRaRnotU8k/LKVvyI=;
 b=Pb79aHbz5ueqrf6CQi6YCMSxotaCnNA6XE1fziK+H5/BiOPpDZDexLM9+lymzVryoF4VDKWZrp9o69zkI/VPKwl0uH5M4+/9Bo/0PGxJRD0LGct6Ap7YLDRhorGzQKogeySh1DJQQhZvWxjU5Ca4gfecBqUNoyED9ShzJH1h9DxkKH6/5TmkNDEKKL6jz+NfBAdjMM808h2gRObasGi/UtmGycPfjvFQhVKFBmen1rRkIhEZUJ+8g80n3s9MTSED0Nzt7V0I3b92lBqmyhdDqGYhlysujI8E2g1wdWv2VHAmkZ1MICv8ANylH9c3U7vTSG9P4anfPAXKT3vnQ6d16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo060JCu4P04mta6y2skXgk0sfLRaRnotU8k/LKVvyI=;
 b=c9jZ48efNgbl3mjKNm4UOGu2tnFSwiyhJnNgY7g+jJmw6KVitC7EYvfMcTa7vkrsnrouNZgvJJE2r7mP2OAKIORyKfRi6sVd+aFE0iuhcKJ4AspWpud6xBfFgIfExt5odDINEB76P3bUC40JWtb+eu2IzLjlwxMMduUNL98kOyx8wknxtJIhhiXubCauNm322pbg0gjjgMmst9yqEj2o2EaITPd4pI/kXJcLELsLWBrgc8PmG4RR9cKZdRtypEi+X/a10+e1f6V263hezaT0lNjRPIjQ1jrv9+uiIPQLhGUVEhzM2F7kYvr3/owTdq1J/VAU9/zgOtZd8bH9oPtwZQ==
Received: from DM6PR05CA0060.namprd05.prod.outlook.com (2603:10b6:5:335::29)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 09:32:34 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::85) by DM6PR05CA0060.outlook.office365.com
 (2603:10b6:5:335::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 09:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 6 Oct 2023 09:32:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 02:32:19 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 02:32:18 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 6 Oct 2023 02:32:18 -0700
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
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <9c7c56e1-4498-464b-85ee-28878ac8e771@rnnvmail201.nvidia.com>
Date:   Fri, 6 Oct 2023 02:32:18 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a62f710-2be5-45e5-5b43-08dbc64f2bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FZ/Y59/2mQl9xsKy6ddW+DwdnU43jL3V75QwggTa0iH0FDGSTJYYIvaPxNmvpIYD1PJCJhooBs6vCC3L4gnDFbZ5rWv5WB3AZ4yRBcBYe8mSVLDRPVjqXD/wJvYZBU0tOkFGdd3lp3QmxHPBXbEPH+9Rzo/h+Q2+Xez+5wLcck/iFEVCg5JcynatMxBrc7ezXzm5TRFIbmupnnXHgr+UvefpqvL3j6J/Xz+SlUsLP1ZNuTus+WQtcS5GflGjQzU+nkUGgb0oKAUGAxz3zZzX8rr+L7e+eR47ylWw/qZjqiI8dojieqCivMmfI7CCC9vn0M44bOtkb5KEBPORS9dLzcxRziaTVYy6r88cjiJI1XU1tmv4FSz3euFYKu+KvD8utVzyda9y9gv9dUPHKIqPpkKeV7QNSnwlyb+WTEOlqo7mkn5+GgO/SpOSJsMklJYhY5g9aaSuLFAGzQH5BzvMQaUN47SJoamoUUPh+0swrO+D314zh3PCuS57FEwzo4bqq79aiqubYToEgkSuVTTGT722/SjC460oAzqYaoAMxbTj2n7jbasbJOZB7lRL9iZEz0c1Lb2C/yuWuSIrjtOR6Mxj1SZNIfM+eXfgQbya/LUS7bMJsoGrbcdOPVFBZwO+F3A/Mw8GYQGbdGzweL9FgJNlHUruwA/pQY0b8K6sSRa2cy/ljKAfgGLvFN2dK3YZcR2yqzpssekBwSkmf3z2KSXeVCI3RHGZ8cEYzi/7aLeMvO0zgoerZlUo/t+wa5BFNgD3IebybfeEQApF74hWvSupp1Iy73N9zWMXXmhgrM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(356005)(7636003)(82740400003)(26005)(36860700001)(336012)(426003)(316002)(54906003)(6916009)(478600001)(966005)(47076005)(70206006)(70586007)(31686004)(31696002)(86362001)(8676002)(2906002)(7416002)(4326008)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:32:33.9501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a62f710-2be5-45e5-5b43-08dbc64f2bb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2023 19:52:53 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.56 release.
> There are 259 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
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

Linux version:	6.1.56-rc1-g0353a7bfd2b6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
