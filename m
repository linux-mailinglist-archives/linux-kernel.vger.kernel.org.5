Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB276B920
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjHAPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHAPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:52:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F21729;
        Tue,  1 Aug 2023 08:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQjsJixiqStqLZwKi4dI2PO4REGD3beXpLXepq+0ZW9VDP7uALUyngpkOkp6zfKNzOkGGhhUsftM8K8UWKUHOhk7W1v3/iIjuJnVQYKUHeQlzrPOpO14lFMovsMK3MD0EcsNnisIYzs3ESRK+AYjMEuh9GLuk/pXYlPDztwYy3BQOPd/koOU5swkExBMuO2X/j57/RhCA+jIOqMg68MbjBQJDZMMFEN4dNClG4WpZiv0D3RdKRj5R13uF5v8Nrab+EjGK/+5WSizsOrGxynO8OWToGGRozV5caTyx2rjj93tq7TZDhzIJTlFDtESEQa67kWdJctdTMVZmtUDk2gN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icWO2EKkPry7ANfyDxW270MoLrUrEq2sVTaAN0ZRudg=;
 b=nf46iPMgy+fm5Ns/oIKphMuGn+DIwWK8XUw+Z++70tN359nMxeH4P5aJbAdRoaZYro1dF3KVjj3PCGVK/UoelLKhP9dQt/3g3yw07dckiyQAwDbawwh5nBTXGY3YT/BdQ+BOA1+pIJhf7eG+z8bQfFdST2qsAtrnDvxJNs69ofAjtPle6TmGVFqrkm1T2Zx1f+Mq9BuGEmfE2+2tjGjtPP9sDycXsgIdsiRObzLJ0y2cRHeMvSsMOzYDLavwpcfPPkvXbyajyGMhhe6COB+k5A7tWf6VpB8U5YxRgFyfGdlicB8HKkPOmOZyDmJwbu5sEJvYuKY2nzsGUBXPFFB5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icWO2EKkPry7ANfyDxW270MoLrUrEq2sVTaAN0ZRudg=;
 b=FSnTeBLpSWxfgCElyBo/hVD2C/gJaxsfTavv/5hFCbvQsugbwUojn3BCtZFzylPX1cYXEkVAwp+kiiXqCQNsBHrUY7/ySxs604KG5sIfeVdz2Pp/elRIii0vxFBSsVdDpgeTf7raIPgfsiIBRkk2uCA9mMXNKuRgL8d9yMcIf1iB1b3vbumTfm8c3sni+oBo8LvTaKHpnjOZctEB8a0m2fmNvwUXwDb2+C61EMc/AqjiqLPXc7n05TpQPlFEm3DPLr81jlOjI/B6ig2CTWLnPaRUF2u0opIlAdrLDWLEmwMzfbJeLYXMIlrOp4VtLYqV6XcXx0oLfYaSGBAzrS55+A==
Received: from SA9PR13CA0095.namprd13.prod.outlook.com (2603:10b6:806:24::10)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 15:52:27 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::a4) by SA9PR13CA0095.outlook.office365.com
 (2603:10b6:806:24::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Tue, 1 Aug 2023 15:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 15:52:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 08:52:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 1 Aug 2023 08:52:20 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 1 Aug 2023 08:52:20 -0700
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
Subject: Re: [PATCH 6.1 000/228] 6.1.43-rc1 review
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7574024c-13a9-45ff-9bd1-8e84a06718a1@drhqmail202.nvidia.com>
Date:   Tue, 1 Aug 2023 08:52:20 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f3cac9-2079-4188-979c-08db92a74e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdPAYKI1vedHzRudgiYlL4Rmxfo+ivlrJd4HGSVG/CFII4nReuZkPx3uvEqK9LYNme8NYx+3ZvKfVGF4Z5E/fUOam0o75znKuhjKDNcP4cdMoZeL4w2+4I8/f74zsoJS10GswmQu0tAah0VjL8kbKD7VP2iEFcwhqbB281ZlowdqBqIpQPmBn1KlPnP3aSoCBZdFurqlS/dYg7IIeaKxoahYTH89lnuqqAq8mgwi+2EcKi2j0IoW2hlDFfTBnZYOXlEe2OLCr4FC4ZReq4+oG7eDEY1/NfCKteFLYYCf46b4kjrQQuoIZsQ18y5FTq4L2362s78wwMUumzLrDF+KkayR39pJCwmy2akV7WOfshyHvnB18osJyPNJ/DID6/HxuQ9NwOGLABnUF4nNhihTn6Dic9J4Zu08pC1PktMgMZ5+11leqypJ24ozyFaIlwcSkuNHKGfYny71iY4UGqI3wK8YU6uWq/8/hu5ktiTZfH4gvDNCiCJv5Vbpo+eN+hrXaMKCaJYFYx7cJINHWFnzXmx5HyXE0BHSeJbbPH5bKuz+PI7zJ6+yXVsbmDYIZwpe64wdfYpeQzr1PPyC1lUuv/xwTloa8dh+Bw1G0bLhjaqOCXJhVLBnX7jiZk4DID7Zx6+22rDP1u3KvwhuyAkJ/HKTVrn/rSW8uZGaHmgPQOWdHELnH4uYYYS0D2wMqo0ssdSa+HMw9966iI86F3ygsTvywgbbi9+U8zoGqedOx42zmMADhF0mZsYxUgR5an/7faLOawfA4F8I4g4OdrM7iZDg7Q1T4wCTT66m853rzfE=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(82740400003)(7636003)(356005)(40480700001)(31696002)(86362001)(40460700003)(966005)(478600001)(336012)(186003)(8936002)(8676002)(26005)(7416002)(4326008)(5660300002)(70206006)(70586007)(31686004)(2906002)(54906003)(6916009)(316002)(41300700001)(36860700001)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:52:27.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f3cac9-2079-4188-979c-08db92a74e2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 11:17:38 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc1.gz
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

Linux version:	6.1.43-rc1-g9f9cafb14305
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
