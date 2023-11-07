Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B897E3B40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjKGLnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjKGLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:43:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE57122;
        Tue,  7 Nov 2023 03:43:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f31Bbn+445qKufhtbiXWyo77U493wSMt1Ywr5e+BqA6lRkv+WJ9prLPnn9ECVlXRPbzrdyUkHbcw40cJlSXQEN31lsFkOdvP1YlAtW7GGrDijLuI6B95a7jkYDKe2rYgPVYdZY6ARLBIRKPLjRnx7JMquHrvPEnvgNmaHJCrIsdvFyTiSh2sjpAfiFoG8KoMxJ7+IR2oalcHM3Ib8mFhUtXeoYa/LMHj/fSi3gcRPBJZ0Gzm4UFWtOMk+vgPrzzG9Gzbee9QWyz7wZSTEyv3e2fMk1oFNtofgE/RfxdRrh95gIEBqdlUrNMUIX/zDdP3wsH1sidEJszV2ATzYa4Y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6meC1EewT9B9DM7CmpWUQOhwdou8ag1H1YkYhSpWjNA=;
 b=DXlJrZlv3HnLL6ycOoPcRUKCZXFpuqZozKodqX9VTVq5/FotgMi/T5s3Cm2ts46/QVKfXcrwW3GlndrJipnbPc6S+3MsEQYUObMAHSDvDoSFsuSU26DH4d/CtHcWYfItepU4UO9NoBeEq4HWBwxaEVRBtQzRaEGlYCoQzYzgBJq2Ss6Hi2plMobH3SZYGRB/LwCe7HYeu3EXSa6o2CCvplNPbY04nHApQjtgJtQJrPfAWj8A++FK3jUAHB1JmiVZuy3Jh/mi/kEfhpLO4WbxGZkPtxCwR2ehTaQ64wURgplvxZvbbnOPoa1ZP9ICxR/g2D7ic8hm9l6NruMZb1z21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6meC1EewT9B9DM7CmpWUQOhwdou8ag1H1YkYhSpWjNA=;
 b=jMSATkLkfIUDJLeO2cy267CDdKanEIeuHMgdNABz4Zfy85sbRsn6l6nlclLY0xPDd8xcy63+ZWSn2HfyhBkkYIV2fI75VoltItOO09+CQgAUdRlhO5N3rgVuwcM5vOSc9EPBeAM5HywZpymCbHphx9fwNksdwyY3/dUP1E9f5Gp2eOydLgAKEg9QNSVXupvJ88qbUuthvuAAd3BJAc8bTl7yxFzV/T+TW7q7ygxdafUYAm5WUBXT+AmqiH9kUAq9AASqKrM0uZ62WKy1GFM9Gp5GEFk6MQcTpNPr1XNkFGrFQkFJImb+XdMzcokjuHecN0dSy1D43v7VK+eha7ZKeQ==
Received: from MN2PR18CA0006.namprd18.prod.outlook.com (2603:10b6:208:23c::11)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 11:43:15 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::c4) by MN2PR18CA0006.outlook.office365.com
 (2603:10b6:208:23c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28 via Frontend
 Transport; Tue, 7 Nov 2023 11:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 11:43:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:42:59 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:42:59 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 03:42:58 -0800
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
Subject: Re: [PATCH 4.19 00/61] 4.19.298-rc1 review
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
References: <20231106130259.573843228@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <adf0d9f1-1097-4576-b117-9a10a758ad6f@rnnvmail204.nvidia.com>
Date:   Tue, 7 Nov 2023 03:42:58 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: dc36b65d-3e8d-490c-38e8-08dbdf86bae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZeYvP85BNRwBP4jK0IUlx2GSPD/9ijxGVfjgBEacJyZ8sTRJoY1ZS0JuedEStZUa8oP0X8ZiRUDbLw2M2EMHDybn7JHkVA3F1byFHr/3kmEg6imyGcmwZggnTm2XxgvaJbNcRX8pXdbySmodOLLrerFwFo45piCALsIOA82CuQetDFL8hBBAdJUEigQKJDnH1zSVIiirSG8Mo7FkZkTsctC8i3i3y0SS1j/6+i3hD620JuPiZbjud4qqm+JwlDGSxlp4qFjST5rRI/u0USvfsGwUIYDxOA4Q8bWajYySLdS5ko0hGGHDK3Bx7bGPYO+NzL9Oi9nOCq6mZmMBDXp99r5L7fFoVa5WuySkN2rku7YqtCYd4U78jXIws2a5zbMu8L5ZQCMNenl90KaXWnVl7z/cMQ7hNE1l3aostYOlNjdlw858fObDPS4sdH7rDaVH6KaDBJj6Aso/2mSBMPXF+UjCrjkMfat2vynQTcoMSASh5X+j+wgRoJaN7ivV7jR/i0sbk9yHvBMfbAm9TLLaN6sCaNV2nHp5JOj02OKNJctQOvRz6Me9GBvEbDFkq7WrsVqBTCG8lH1LduUXORdyGgMkFsCKMdGlqHG1wP4Gl/QLngpykkKZZX3G+70NG45oBlm3byZOQzFvtnCTnUfBOKxkfWB+WOSHK91RQK/ZEUSOccXlhXe5LdfjoZkJpdV7cWzTnG44Xhcer7AmC2Yxij4UR851xtdf/USkqTruyIkr7y+FHRLW+CiVWGXFRJzWfi2N3X4RsJVsv7RimMGFG/x/Ux0Yp7CuyMJAVLQfqA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(478600001)(966005)(70586007)(70206006)(6916009)(54906003)(26005)(426003)(336012)(316002)(8936002)(4326008)(8676002)(2906002)(7416002)(41300700001)(5660300002)(31696002)(82740400003)(86362001)(47076005)(36860700001)(356005)(7636003)(40460700003)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:43:15.4425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc36b65d-3e8d-490c-38e8-08dbdf86bae0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 14:02:56 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.298 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.298-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    10 builds:	10 pass, 0 fail
    20 boots:	20 pass, 0 fail
    37 tests:	37 pass, 0 fail

Linux version:	4.19.298-rc1-gcf4a4e22ca8b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
