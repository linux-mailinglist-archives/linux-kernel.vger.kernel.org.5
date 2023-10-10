Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06F97BF801
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjJJJ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjJJJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:57:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D693;
        Tue, 10 Oct 2023 02:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDcBjr5hVTxDlWOm4GseSsj2lZR7zw/hWSYpjmwNIVcRME8bSjbMFseMF0Q9JG3xia3cLNsxkACT49+txLLJ3cgKw0PweyJq4PerR/tFqWxrc43vbWDaenQDXKwWZ01PD81vPh/ZW9BFpdX+inFSq76TkOwECDpyNQY+FTQax+Qd53EphPmuC+wEO3nhXbmAYTDSc7vOU6pcmJA9MBuiSfY6yQ+LqKocSQ8U7DycrqgLphzNbtRwrYesM+5bqHikdG+vOaBeulkO1deBXBLFVrqyi53DGhO2DivM3noEZt/C8q/V88qSTDtXZDvsJBfuRC/sasfyk9VIxHPUofoIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iH50IbryKRaM4K49GBd/IgKkxAeoy0lEhNZSkgL0eQ=;
 b=F9FXb3P2AptDIse5cPtspNf31k2jbVo8ywqMJ+sa9RaSWX00wUIO+EaEUbqZs1/MDIkVzLDJtMXeHWKjekl/+QTQZ28GksBeOwP0b1K+f0LVKNaBIO8CC6G8S59Bvp7Rr8wpBZqeOP5cL23snCtoa/UVbVTHYRFq+lrMkpR+K9b3XDWZ7JgW13OSYRj7gyrykEkuv2AlxSLehXBEAY7SJLHiPeu2leuYT9tnE3oWe1MWPZmdl8Xy/vZh0PhWXO9GtOGkAU1sXd894VOHrsYM53SmY60RFtXLUt8bWjuGf5o5KeBxRAiClz5aSqkVuFEAirmFwDjQD6hdmKDxP5jKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iH50IbryKRaM4K49GBd/IgKkxAeoy0lEhNZSkgL0eQ=;
 b=nFR6WGdZ1O2YpqSi/WvyiVPZx+Yrpl71weXsfG6Sr3EjgOATSmhaReSZf6fzZFaPTFVkOM6Zz/g+G8xQFov/RYyB++brYmj2SRSQbNoX56E4+GfMoQgrxucsEbvxX1kEPtst5gLoz8HBdILxZiuuhqwnbEfG7Ae2la9+k5TT3WXL5yA0LENl0gETyFRYtsPKczOqBTLkfhfx7ptYWfUWbrLzCgWztEUOMlJDVVkaxrjRCgSgshe6Zjg9ccTtl3cocqP+62Q1fKsMWwVadoJW9S1XB6PyR6nZvH9qR9AOSJVc6XcsCqeZSi1hZXBpkpPKwe8HEJlIlLuGVLqs+FocEQ==
Received: from CY5PR17CA0049.namprd17.prod.outlook.com (2603:10b6:930:12::33)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:57:13 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::3c) by CY5PR17CA0049.outlook.office365.com
 (2603:10b6:930:12::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 09:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 09:57:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:06 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 02:57:06 -0700
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
Subject: Re: [PATCH 4.14 00/55] 4.14.327-rc1 review
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
References: <20231009130107.717692466@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <93ee1473-19d1-46eb-a32b-57da0e51e24d@rnnvmail201.nvidia.com>
Date:   Tue, 10 Oct 2023 02:57:06 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b3047b-2c99-4dd4-edc3-08dbc9774718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cVYEKyzuq9B6C8tUhI9Ve31Sx0/asfrXhBvwG9AludeYdlr0Y/D2Wdn1Y9smgTlK72/y+XDNGHp/Xm3D9VJ5EXNLCF3c7JXUm9U6hhDTlHdNGuCxXTGqGWFZAnfDYD0aCZyvL2ksWSMy5OmfuF6fJuoERJRL5otQU2D2kux5IhIZRdjmzwp4ul0AN2KSgvCJY8tj9FS82rM84K8Ohl/KLLRuebQcmBWrpK2sDwTJ+eWMP5onkCRkA59dSnG/DqYvtXBXHQGgN0YF5DzgX1R24Df0NSvF38cwRoJcb8gvUtJzQj+KJq8mQkkTxBlvAqZc9qszYAdIyso3+nb+94FLmgrByAQi2L+6ATy9i7ZPoY5Lh3QIz2wpGh+B7aoVY2RUb0lvmn5vU0idCPN74tccy5384PXO9zqcGZjyDNma/EFxVq89PT4kdngkH/C3oOpKmi6F73ogkTamSean+qydemhmNTy0x7zlz9EaNTHsLKv94ID9jLD41QjBqRfmIllLQwo3Xv/TVwAlqQTYF7XLxXXEMs2/EB8PcvfxzdnUwHDyO2Ehpuv56kgoTx2RXf6jxLHyFSWI8SAVI7JiysPXZYaQR+G7r1S8MT2X5JSCbo2pL2iXkZnJF+FYex3f1+VYREOOf4gOCduYYq4v+Zv+BmiRqcjt397FA8Cm4+C12kqCTit/hfeCKN5frjgowGhpiPrOZD+5NXXJRAEoG2TuqYHCwisFjrSfrJgucBsgG9eOnmlg7u3F2jnhAeAk8lq+tRfqPD8/0Zr0c325heXd5nqBpwvZNkqT0Ju4LczWYU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(70586007)(316002)(40480700001)(6916009)(70206006)(7636003)(54906003)(82740400003)(356005)(426003)(336012)(26005)(966005)(47076005)(478600001)(86362001)(2906002)(7416002)(31696002)(41300700001)(5660300002)(8936002)(8676002)(4326008)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:57:13.3226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b3047b-2c99-4dd4-edc3-08dbc9774718
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2023 15:05:59 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.327 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.327-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    10 builds:	10 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.327-rc1-gbb6db074be99
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
