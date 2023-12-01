Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2608800920
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378363AbjLAKyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378351AbjLAKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:54:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D874693;
        Fri,  1 Dec 2023 02:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBFLYRuHojHkeziZYb3zcbVY3xoJnE0Dm9YqfLcc6fYFnd+wqoB2ayo2X9plwrDfqCD42DHp5n2yXXYfNUO6BMda9TBuOIvPG34LwACQOmulcwq/O2b7+9Q2jFJ1wApY7E+eo+2pavw70tEJUjEuxD36nhaXVXj66mprxkrLHy+Ou6eVURKb3WPHxFoizyLNMxmT2XhjdAj8XdrYCm/q5qO6FlLiXbMHG8GHq4UVPZX3/kSu/XQrb0U4g9tHvWcNLV2LfTk9iej9Eqz6mDLJphaSg2LOBHAa4JlVmLRpA56vs39TykbDrmQU3wxG7yQmNRjDi6S8kkuX6ojDH1m+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol35lEjGvJczbC80DSp05lNUwZFZbYVtDKwV7u3fm00=;
 b=JN/Cf2OR61cysu5S+bNMgmGTQDFnA075ei7jyz27C1g6UpZX681DowDyFxCkKFUKN9J/Xuk6NOWrquTkLshLAbroVylbDeL3OvZxlN4K62n3K/MXaudqVhVrcr2Uc3vSFnWGnjG7L1S+uvOe8cJK9QkTk7W4yHmh6IBU06uhd5aXttV+dYw5faBlF3kMRnRrr04K6qBGR+Bwcb3McdY4ClMMFW33zqaX+NKvGVCL4xZovE74MT/FW1s5cpWq8D4Afr/ssDtFB1w+T+lM6Zampog517zsOxZ+3b8glro3GzNs/3CXRhPfs/s9515XWTkMMaSEz67NUuFSsoI9LiHfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol35lEjGvJczbC80DSp05lNUwZFZbYVtDKwV7u3fm00=;
 b=B2cn5GOeTUJkXgcEPqRoYuA7UEM9R9hl6ClXpzXeLtOXKg20TRT/fo/MJ1G/s1HJPA4NRE0PZDYYGV48fURiJsNpkVIHx4TGg+rVwK99J0tn9bxepmmnrTi+TaWYVFD1/PpXlrVH8sP73NgSfwQAOx/ZebROaV25qG70RRvxSHyi34gpL7RorAcBlMlKqgf/pHt5kp88HFeowRM4uleA4yko2C3TiFyy97b3dOhJbLOfgLMc2Udhg9nbi1KaltVLxdzaG8GzgBCzE+Yk+UPc5l3hzYPVi6hye1jSyKvxEhvghVYgF/TQq/RgpdUKOrHwDwmAFHMK77kPF0IC9aJMAg==
Received: from CY5PR15CA0092.namprd15.prod.outlook.com (2603:10b6:930:7::6) by
 BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 10:54:40 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::8e) by CY5PR15CA0092.outlook.office365.com
 (2603:10b6:930:7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 10:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 10:54:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 02:54:31 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 1 Dec 2023
 02:54:30 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 1 Dec 2023 02:54:30 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1 00/82] 6.1.65-rc1 review
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
References: <20231130162135.977485944@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <6d4b8a60-3862-43e5-a2bf-cddb08e99f66@rnnvmail202.nvidia.com>
Date:   Fri, 1 Dec 2023 02:54:30 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BN9PR12MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ec05bf-e9a3-4597-4cd7-08dbf25beaea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZLbCbXBapmieQ2/cKHsD93lA4iZzOZlWpGbsm4u+F9WeBm+iZatbDSVmWGqys/a6WL/qOqENIt0AYsw3Zu5Qam4EKL2+EnFj7Vepfb01UD3CNaFPUFFGDjzmQrgh0I4hBbVe06CSxiSI+y9ug4gHfeZ181ttFJOYZd6XvC0dWAGApsrydV1IAde7AxxoCec+JSZQHuQ7bwNVn+F1U09YH278Tw+dB8WP8gMTOJWiJkbzSE/xFNUxJjeNtIZ5AabQujElk3kOcRB5Nfx5XuvBJpUmIctbi3eeY+QAN9UywryLSH5jY+5B/n0m15JtoZeQ8Ahui9ZZmpIBi7IyV6GpO3Sa1KpMmhGgxf5DLOkh3rgVvzAm+mpodVB3vsV9TfclRWpzO2rwJlAd6TLFwC9RPRwDbqQRR77dREaxOyTrXtQvZZMdEmrUovZRothLB/ApkjuV1spj6Fm1oREpHDVz2oQhN7q83bumx3JSYlQIEXA4yu3asW6WexwMBTTuIZxLTkjay/yoyPkPq6+5oFy6rRNsFNNx4MappRKvasS9AqznRBAcsrgeYDK9tH+d9Dk6F/GJOl//BLggsUA16pBu5pAzNleGTDo4xrH4a9vF7l8lmDq/QM2+gEUKHKQE3sBlMuV6jYJdpV518PYXuTSfOLZoFwluUyRWbOHsz1wHEbY5x8MBSiJueuyQR4PkOuUf3MYUyqkZGxUrZuPUh5G9fg25rkfQ3uGI8xKNbsE+l43tZyvkCQhbeHMMyHUkK0+Ru08hSjNyXFCuXb45fIF2elAEPMpFh8L+dN2zFV2dfE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(40470700004)(46966006)(36840700001)(41300700001)(2906002)(5660300002)(7416002)(31696002)(86362001)(40460700003)(40480700001)(26005)(82740400003)(426003)(336012)(966005)(478600001)(356005)(7636003)(47076005)(31686004)(36860700001)(4326008)(6916009)(54906003)(316002)(8936002)(70206006)(70586007)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 10:54:39.8820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ec05bf-e9a3-4597-4cd7-08dbf25beaea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 16:21:31 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.65 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.65-rc1.gz
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

Linux version:	6.1.65-rc1-g7695623e33dd
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
