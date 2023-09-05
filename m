Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56944792B97
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbjIEQzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354377AbjIELIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:08:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B4132;
        Tue,  5 Sep 2023 04:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO2cKbrOQNIhRL1ud8rPQGlFVQolsDlk5pwgsTTH/QxXahrcHDtFsVYH6erM+hW9E+v+vtb6I/UIj6mjMDAMmvtMZAPr1FgEGrqJfiC+WVKW+HBWw5cqVSJ+8UibDDxYwjIvTERk2ioQIutay5tCY98zc+j8KrKzYXpZJGog45CvZ6cOiSDm86ObuH3uzx3NLDeutHQJRs8ch5ZsJf5qCJGVvD1iwxuew/dfMfejqPD5VXn1NUtrukKCxUBr84NzE4DJ9HTrL7LRNDzI35mv0C87IzoBmrvBujOgXQNW04zlu0Z3+/6CbIpYoMRFBq9buHURbKWokOunytD1SyIiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke9cmMB0B7sgAGxWxxd12kKiSEg+MPGrBrwaeBe/1ks=;
 b=neICMt9a8pk3pMxMjEDkhKICYh9N/9YuwcGCbeLUwH6dEKzWqfY11JPnCWNvrWxNk0i2/UbyvVci2/qFwA3ksBnlQf8bwTJ9tYxWhN8XiPY6R6F+BSrPOCVdVGduPC+bVwa6sj4Ndi0kg2QWjZvwMUJBA7XSfBTzPi50DqGrB5Rgrdde7jfSC763Vmekg1RVHlSfkKGqdt7CUwBpE7oFIcO1oVCxk0doIzWRoztykKYO/hg46KSDb9lR+HrEowmvxhm0V3dwaT9QKOOHHkgoN6eCjtX7Q4pFvz3sbIsVuKI+LB3W9DEAnlk0s0GqrXLyBATaYIf+9klkDInUqYtihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke9cmMB0B7sgAGxWxxd12kKiSEg+MPGrBrwaeBe/1ks=;
 b=FAJZTqLHwFJGiGOpvtzPRFGN1MQXYC2fd8kMI6ol3s3sirzIzC8oyGUIXznVKb0cfxTqHO6FCZsY51KBFYHZC8er93V2HjXYyN3bmE5Bfbme60etTB7/2zioQADh7lje0ZIgpTlCv9VWuzrAr5T8fk45mYkKcdQNan7LLdI8YFJKZb6LG8SmEFLPK+M9u/wwBO3+b3+Eg7s+leAEwOcMpfgVFrEl7RXA1MEaPKpzyfC2x8dwoaYO6wFI2IlqnTQU5evKkIhQKIMvoTzit5LFk4jr7DqHknFmHt1vnXzTWlWsizmFk61bhAwxE9roio8trkjJhwyOhXRGr98asyBH+w==
Received: from DM6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:5:1b3::27)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 11:08:46 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::39) by DM6PR17CA0014.outlook.office365.com
 (2603:10b6:5:1b3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 11:08:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 11:08:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 04:08:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 5 Sep 2023
 04:08:34 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 04:08:33 -0700
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
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
References: <20230904182947.899158313@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <8c97d6ce-f7f5-432a-9624-2e0e4d2bde5b@rnnvmail202.nvidia.com>
Date:   Tue, 5 Sep 2023 04:08:33 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: aac2c495-339b-4110-d7cd-08dbae007946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVD7mCI406rObF/2zTzpFkLLL7+59e4X+m+VDeKnlWw9Ntw1jWnvg0hyDCe9br7ZtWHHl0EskOF8dlIqOseTA0b0kVtr9bkIggybGQ4cJZ1zgzBCTjiUItnhhKl/45hdHqvvaaFuRkuAuqjIAFoHR/FYyWEs0Mu2sFEwtqjDjOOGyV0E5uwqboO+J/M1Z7/CZ1n1MRbMZXkfCfNxgtkMXrgYbmTPCltVC1EjDApLGaFbloVwkc/nSky7noxoJGssb2avmNfRTMXmUcxByojoBMHp4U4Z5maUjXyNMQ15B3OfPDVADkbR/I9acITfEH+ATvJSY0/xNVAtbrofwKK4gdI3fusdzfDlPHFmxCzEy5BGgiyev2w2WPJT+5BLBX24OW2mPDCTNizR8jgGSgt1853Tbskwu98n7w0UqzVfxdWNLxi7ngQKa8mRrgEMSdM2a432osQRJ9Hd/U3QHcWgmDsOzE6Zn/vjnhNNWExJO+BclQaSqCxxkZfMX/Ma2CRkCK53ROoT1Vt1xWi9cmr4oiL6QD6RtPWsa+DNxywWDPwmoV76UHAHMoGXRyv4WPXICNAiFPwDaLINU+ZntqbGlGppJA0iqT33eKtGWKtMBm19jBJ30vS40cpcAyydMDZm5qWC9Z/+TF2vPJQCtOUpvgIPfE2NO/cf/qGbgfXeeyozyTJPgSuOq0VpLxuULHwpf85nmtgQg2bXS58ESZCKeo8+fWnsH/8KHkZAy96OtlEvv0SDMpYA9TH/NRU3WV9jeA8/Prk7yetnDrmlTdoE8tniSx4AdIfndHMGHZaF2n0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(41300700001)(7416002)(26005)(356005)(82740400003)(7636003)(86362001)(31696002)(966005)(478600001)(336012)(47076005)(36860700001)(426003)(40480700001)(8676002)(70586007)(70206006)(2906002)(54906003)(6916009)(316002)(8936002)(5660300002)(31686004)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:08:45.9882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aac2c495-339b-4110-d7cd-08dbae007946
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2023 19:29:58 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.4:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.4.15-rc1-g9d9f43e3652f
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
