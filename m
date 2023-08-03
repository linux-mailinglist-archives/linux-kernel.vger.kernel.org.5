Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDA76E4E2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjHCJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjHCJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:48:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5022D73;
        Thu,  3 Aug 2023 02:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb6SeXiwdCa9qfMxcgJOQVHqQFdY+bOOzfQwCMyclDZ+Tu6S5a3LYiWytYH8M9i/FWSREm62Aleztgk05oM08NdXEoVTbdtFedM19Ka7BwghmK8zzCK7e0jErblr0tRFVQ5demb4f/MXZ56YaPelm4oL+hkJHXGxueQu9WpLX0mlESIqDk2THhMySCTGJf3D4sZh+OAa/Uy4nblKpDsOcSq2tigcrjwUrTt3a/3IM+Xt5GwxZ7/vJLMRGBiO/WiBW3CrHPYBZaH4lqthuR4GmkCu7cgu03BG7sFznj+ryKPFyGZqoY2V1fpFLhMvlX+hCWPW1i2nuRWK+sDOwqmG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+K+tVgC5gCMQySJB2HqHy0YJJ2o6Dh/l2u0Lj0T+vc=;
 b=kYsRyCS+693VEXKbf88PW5w1f6gZbuHSnN0Vs60hLy+1dvpN/RNCXPe6Us4iSydQ2ASwE/L6Uayc78bLsHP8kfKXd9d/UTMnLQLrqzLkcwXEXKH0H8P/VRZ1tIyxYZ4yeHHPQ1Xsh6X056w/Jgm6zc2pIF2qae4nyUgZJmxToIFrJqYg9AneS7xUUW8VrWxU82UWivXsPDSP1KA+gDjQgWUjJvWBWNu+0pNkJQoXWG1glRdD80ZFpPG1rQSmBHqaOTnD00lwh/5/leOPGHdJkDUegTxIL5Sig2BfewBWyZ1J2QSP2HgH3UiBLxqp9eNTNNjlnzVTSokOkf97PQNcbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+K+tVgC5gCMQySJB2HqHy0YJJ2o6Dh/l2u0Lj0T+vc=;
 b=pjOYmgt47vFI73ZkOkNBruGiokFaPPRZgbT8w1WPmGQOZBVYQXUj53Fv2iezz1C0DDDGmq6B6UTokpmfVNB7GnjQ33M9RpsMZgaHaaGpBl4/ufTEg8rCrsE3ni06VMab2U9fX9mcbvxR0/mf+KILUHApCF6Xzpt8+qK0WKLOnrFOdovfZT9Q+BNuxx27u4cwCfnPAjANrEVesZtiuifrYNEMZc7dnWaQbPwppsTjtLGg0nxyQ/VTbvqYHI5+kVWHmRUuj7AeTO9+TKxAfNdqMJBUhWw+njhPAMxvnwclhe89ZKAeMYi/FKor141m3iPL0ZvLDubBAKTVhZkpCA6hlA==
Received: from DM6PR02CA0122.namprd02.prod.outlook.com (2603:10b6:5:1b4::24)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 09:48:33 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::61) by DM6PR02CA0122.outlook.office365.com
 (2603:10b6:5:1b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 09:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 09:48:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 3 Aug 2023
 02:48:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 3 Aug 2023
 02:48:23 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 3 Aug 2023 02:48:23 -0700
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
Subject: Re: [PATCH 6.1 000/225] 6.1.43-rc2 review
In-Reply-To: <20230802065510.869511253@linuxfoundation.org>
References: <20230802065510.869511253@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <e33e5c68-930a-44ad-9c04-212d2ecbcd14@rnnvmail204.nvidia.com>
Date:   Thu, 3 Aug 2023 02:48:23 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 65cb8ce1-627b-4209-9fad-08db9406cd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dKedp5fOXXps6W+zwmuPae9SNdddeXqvnO6jJdgIVmAjsA1pJ3ktdlfiSqOOFyhiqmB0XI50f/mKKtUyE62DUjjxwaD94BTe3vncTmvHyVNqJpYaFZr1ui/SBON591Ka12nqs3r05aNXosxqt+/8dzcX3j6BDEdeUfTlRriizcVTE5TVuVqQ5U1D07hcYpJrwrhectCem0Fc2zEcGWpw4YnQdJRAN8IuRngTRIi0EuZQcwq4gILE0pDq0t3e4YP1SU6PMuOsfIHbdpzfPkYoitYa+pCSAoe4WxiK7dRi5s6wG7gRoDaGVDakGYXgZhz+M+9yE+MypP98TjjwuntiR9zq/rhZZLTwlGKlsVgyuAOLOb4M52nrL3gySmrEAmZM4r8zhuZkAXtzqB43Anxtqj1aYjOUWIGuSXfIZ0mHooDaDhcuF0B9LE15lCE8atwOftSGyPXYa4UnQmUK6+uIZjuF0Vbyq/98Xnl918c5icki1KqYPQaYXdV6lskz1+52U7v+jJb+6R+8wKSeDWy+M0LE/nxmGcZuu23+IbGRz0843pWU2hz30mMfK1NsP8EYqiaec2i50HVlG2o099r1qugIywJIHRYGGZDA6+TPpgpnv7Q6071YoLGoYnuP1bitSG9zNTiabYHDGzcOcH2ZWpam1IGWYw3pS8pKw4UQKQ7JAAGLWpp93hiMlUsGB+95Mke/GGxgvFrDEvvaoeRFbeYjIL8YyCioSu0DtCYYkUj3ZKiXrO5cW/0LDrLD0Ib1VZdIYNoEIsk7l0xngfPwkiE3W8AeWoszQ1MulNLG14=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(426003)(26005)(186003)(336012)(47076005)(36860700001)(316002)(2906002)(70586007)(70206006)(4326008)(5660300002)(6916009)(7416002)(41300700001)(8676002)(8936002)(966005)(54906003)(478600001)(40480700001)(356005)(7636003)(31696002)(86362001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 09:48:33.2653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cb8ce1-627b-4209-9fad-08db9406cd0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 09:41:55 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.43-rc2-gbdcf4e82a088
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
