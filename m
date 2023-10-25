Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CCF7D73C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjJYTBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYTBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:01:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2BB18C;
        Wed, 25 Oct 2023 12:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlbBuxZH4OJe8/uwCzkKrkA7Kf5LRfOaEtcUZ9P6sca2aI2g/AV/NyVW9FAvDzHj96jn52WEbkHlmZbjiu5NjIj3GkV3v8J4TCdT8vfM72rtZTZxVTOOGeuWx20Y77v2ddHNzdryhXxi5zJfBfIUX/ICt0w+T31OJhpHKgLO3hlBHxD0w2naNe00/6wsrHfj6+8SER1pfOLaARztBkTjmWCkJUpX2NDy7cvSPepJ8/I5leTBOzhqTdHvNzAQuJ90sezfZki4D+gnpMH+gtS0Rp2eFjeTOpofSzlHyrkUtwuP3tPgDpO5oaQvDBxs9tazFY6/Tr3zwy72NfhMmHPQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5/+GCn74eI9+LNZwHPxBaGbV5bP9C+fGQws/6WTEuQ=;
 b=XtFtkmhND0229wfGNEoUgw3bEtF2EvhqaLxz3qY0jh9WzsgliVJ1dfS7b4Ss5yapFnnpGFkKdVJfsqlY8viocIHPpRLmtDZPu9f4bn8G2i9cNx0dibbzUZyEswj6oYzZEzGVC6zaNMCN9aNSueGjl2vw8YSYJt4MJBPx8h3RAp+5lJajRgHhLkcIoamtD8Y6DyjIREb4kDzjS36E9EDLcsNaLSpQP/VCiJOySkW6hfF5mrCEkd7DsPVUyO8R+DQgdRCQp55t/xSjAobb/HXsNCKUnrZ/ajuFEIBRCpzxFOySdWCMxw3SbsEIEP83N22h5pV4Okr2eDvmA85wHk7jeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5/+GCn74eI9+LNZwHPxBaGbV5bP9C+fGQws/6WTEuQ=;
 b=loqH2bYCEn0adDcaqXpuMDoeD4dqOgKRoGREx1z3vXTMpHZmQZBuuQ4kGieHV+Ot3In+t+WkxaVUvWXvdYt9usQIPF5L7eHJXeh1bTawwU0mRvBt/08c5BU2KaqAke48qpzdRbzbrfF99OmxKd2ahHAz7awbzGR4VPzEhAAcTkejamQQ6y2Krrgz5GjBiFsZ2SFUwIEUncIQ7o34FIONgI9M3WQA48GMAYAaYoIIXMJvIB4nYzFuDctcjKfGnMP7ELgAOSUr1DfBMgbGsZm90v/gB7dWQCfDhxlTCMIuL5H0laCFk1jVW1jSvutYd4KR49okRiN6GCxdoBp8c3cHmg==
Received: from CYXPR02CA0077.namprd02.prod.outlook.com (2603:10b6:930:ce::25)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 19:01:14 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::c4) by CYXPR02CA0077.outlook.office365.com
 (2603:10b6:930:ce::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.34 via Frontend
 Transport; Wed, 25 Oct 2023 19:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 19:01:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 12:01:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 12:01:05 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 12:01:05 -0700
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
Subject: Re: [PATCH 5.10 000/202] 5.10.199-rc1 review
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1009ae70-160f-4fa2-a7ed-c54666d897fb@drhqmail201.nvidia.com>
Date:   Wed, 25 Oct 2023 12:01:05 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 24081f9b-8a9d-4381-44ae-08dbd58cc22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVsnjg4DG6X0L+POnC9pVJuYNpa45xK2vTW8sRE1n3aO2Z4gsC3KD6VZO2CPkydkogtFSXKLSQ7TGYjOB8lcW7QSVyWh5HLzOAO6tbpo2dPBDfbrzunKd9SwHG1HrkIHmB1vwxMSnWeWcZFoVUQa5buZ9tDQJACyecLHkZFoqCH6bomniYz30ZmRZNaCPzZ60V7H1Cbost9TrsOM3+sjMl0CA+BlmwMgXm/+X4n8XmjDi0n5rOzMawfFuNsXDaRBcu/1eG+AP8CI2gZUge0xV4UMWX6p9lVEOWie6WWm353gmcoXEnWMBQaO2X8k4dNzQmAJwyjCB9n8fusd7Wtk3PRg2pkdCJEVxFH9gNMiLQCRY5KRmiX3c5Es732xUXaL/yiHTpV6j21k2HX1WbAQujrwS/7bgfEooJJab8E3qTVI4YD0Oebxcz+nJp4flbfVh8+rc6rgugGo40qfc68a/igAiwSUSFK1QazYFf0sls/00rbOr35eygC1cGVarGbw4NdvRmyA4gdGnwpf55Tn00TMH2rOM/xAiIf7sXFdOH8fH+3PvnfQXOY0nywSvvS7PgFA08fe1eGvmT/IpRGZF9HRyPJhunJjqOSw9mhdWz5N7y8G65Vsmm8udzRNFbc09LHeW/Q1JK9025cUTF4bmN8TwtYZ7WAuz0BHbBwZChzTx+O3XibD2XNz4hFY5MDXnJ8kBf5Tg8997kVxmyy0NuGf9LYrifLv+4b1P9VJHBRbrEgYXHnRWiW+/FsekEYhk2DkiesJ0EY1VK3v47+iphYG1y8BlldiNnLEXwb7ge4=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(966005)(8676002)(40460700003)(7416002)(40480700001)(70586007)(31696002)(86362001)(7636003)(41300700001)(54906003)(316002)(70206006)(82740400003)(478600001)(6916009)(356005)(2906002)(8936002)(4326008)(426003)(36860700001)(5660300002)(336012)(47076005)(26005)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:01:13.1847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24081f9b-8a9d-4381-44ae-08dbd58cc22d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 12:55:07 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.199-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    68 tests:	68 pass, 0 fail

Linux version:	5.10.199-rc1-gf622826e6370
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
