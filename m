Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CCD80519B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376794AbjLELJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376557AbjLELJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:09:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBED129;
        Tue,  5 Dec 2023 03:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2pBY7y58F2Oit/qn1LynnWj2Ql74hA5xkjdKYjV81vGMGPcEndYMu7Gv2yuIAjKtNEgo4f+kpNgtzf5lDay6/ODIT23wdROlFtESAB1toJbKB0kKwf6RnNFWM8EO2BPSisGvcWbsSJlriXRlbb/XV4IZOz1Cgj1+pO1erfDCGxWAy3qrWwq9wX0zYp9Hcj5nkyeH8282dEN0gw4LtxyTt9QEjMCGdYXemLW4zQX+symF5jP3wLuVZTDedsToTh9m6EdLGL6BqZVCXlG0C9+mpMdjL4HlQ5PhZdigrZHADfOb80fxE2kaB+R0MdxecQQp0xH78FFBATEHtDkU2yEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jt5xlwoaOj7hFOdrfi9JHZSlmB+SjAQduCz9PyaT1Y=;
 b=V/MFMqNaSDuostGsysca6BlvvCcwJS0rPxIYJNY3pzK8H7apUZ+5US+OXL+/Bm3X1REupK1CsAP8Dpj08KVKbCKVrYI0rC71CU1gKBzXzta2ta27o7HdQDm7FChKliIivoKjEwHmAL2sHw9JjtDM8cwNI2qwNp0cKufx566Y/HKvo4K2ukYIA16sfSFDxGNgefFR/s6UjEAIEPmkQkxogan0oaqiknvAKC6Y5YuU16nEnL1oquYYdIFt+9A6MA5zt+Tna2yZQLz51eNLZ+bDKJK/vln45Pz9KE/TU3nMCbSiv9HS4WIecnB/eF0PNwD1hRu60lVJ4nKBu2bM48Bi5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jt5xlwoaOj7hFOdrfi9JHZSlmB+SjAQduCz9PyaT1Y=;
 b=G5jw3xZnGMZWhdsffoGrI3d0bXVK1ugubx7okS9YSBIo6eAApN5v/3y/BS8UsKlZUBShQa11AzlsEtRDT7FTj2FdFTjO0brnfiKXd439zWwJCfQYCfo7J+67DKUkUQ9bP9VuWImiTh44fXhniB/Qgqc5Nn3II1/nRDYWDscgFwfgXGPQ4MiNNEb5ckN8unQvgKy676rA75Mbn2/xyjDuXJPpWsnKGGzAyWKbYlH5GfdOrHn/aDoo56KaJRQH9VtAVWyn0W6ogsUg7rxkIJ0/1twbwGnKlxU8JlF94Mj+SxNiX4FAdfbAkK8pLQwhoyNkTQ7DJxiva6BZMtnGv5D4qQ==
Received: from MN2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:208:e8::33)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:09:26 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::93) by MN2PR20CA0020.outlook.office365.com
 (2603:10b6:208:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 11:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:09:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:09:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:09:14 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:09:13 -0800
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
Subject: Re: [PATCH 5.4 00/94] 5.4.263-rc1 review
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1c05b529-120e-4f19-afa5-90439df278f5@rnnvmail203.nvidia.com>
Date:   Tue, 5 Dec 2023 03:09:13 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: b599ac0a-7a80-4a38-ba3d-08dbf582a4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxxdoLNN1rGyQBTn+rNquKqIpOxuwRypO58wnD2UQGq05iFsLF2z3Yn4UQQE+skdpPwcw2YiPBiK1zzN12MxaEU/kt0pP3qzLoCLitZbjZfR6w8C6nXDlRjEZ8Is9d5B/JY6ZIk30bhCRrX4GmX3ejJcadKUpimL73H4ujcOyCiH1UBAiaz1Aktvxqim2Qjc2wHXYYhyM33M57PkKYnAG+5Ztn6p9icHLSxcJoza+0/N2tT7qtxs3zPeGQEJ8LBMukzmSlXgGOPPMBfj2egO9IzzXkEfc570f0552DxDUybWdgeT6Mrprid9GV1uEOYfpfe+IAwGKGU4i3ZIj1NPAzAbuma2iKlAAgbmUSFkK1YFkTXgTsEy1SdRCGgEvTEZ3VIXCbQdAh4yxOx+AIHWSaJ5GUlp8PtkbLMeR0uI0iMvSnnd1rLvmN+w5V2ApqaEwNQr1DRRZp7Edmo5YacuWRLMUOhf6CDUyJokoY2Z9sVK3BjcO6Ql3rS4/PPn6hd8GLMu25xDq3LruNUGOe5nMroExsGIgVop11e+GncBsfenWtXTNi3iQjY1GWZMJJaE/V7lsyHDVlymED+as9WGFhBcK4hJo+2/PmAA6fiIPXMMwZd9TgdQyP9OK+uDl4RpQ2dLLh4k0pyf4PPZqv6yZ0PnXs/zAeQIH08T8nl4/ldPOUMXdMC/TolLwCDT4gtcxnan8rIX1g5VCC1Am9yhP+TuwK/ZwkkU1S7e8+kA3mWJaj4qhmDBxBLcoYgHW9hpUxf0icnnO1Rh14UenURBnpYq9MhPd8Xr92GXTAVe6r0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(478600001)(966005)(26005)(7636003)(336012)(47076005)(356005)(426003)(40480700001)(82740400003)(316002)(6916009)(54906003)(70586007)(70206006)(36860700001)(31686004)(5660300002)(4326008)(86362001)(2906002)(8936002)(8676002)(40460700003)(7416002)(31696002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:09:26.0812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b599ac0a-7a80-4a38-ba3d-08dbf582a4cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 12:16:28 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 94 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.263-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.263-rc1-g5dd6bc1bd552
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
