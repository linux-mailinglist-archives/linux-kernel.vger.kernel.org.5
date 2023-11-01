Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B417DDF0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjKAKJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjKAKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:09:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E90E110;
        Wed,  1 Nov 2023 03:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/canm5YUrbKe+U2DSes67O5A+bPPPZ8GN0JJ5oib2L4EE9Qs3bX/GD4XRX5/Iw6rEDMUrB/KlJD/eA08r6YavAIzu8yn4YOejhpGiEiCOdoMUb6NOJEKWSmFpCSGfYWpoHic/eyaoJAhfu3HDM436OnOHwri9EQz7Zl8q7pWbwzejp2i3WseAfdVTrKrfgv2vOMK6z5wSqdaizlwFAhKGzz3+ZzTkFlTYt4KS+aQRaNVnImqny10Uc6uA/zFg3yOVlm+CSi6E8E22ba2jBf9NznyX0r97mA57Rm8Bik34TP/NnU0WYzBNQ9J3QpJlA5vUm00i8IS3H/cwM5Aw9NJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Waa1+zFQd17VlSMgpECeFDborX4/Nszc1ADXTIXCJQo=;
 b=hBRgxbkAYmKdpL8t9SP9F7II1fRPfWDwUFYmIiOFh0QKFX1Y7DBcptFGJybqq0h4UM4mbuuBfz9r+wHXlR3/atmHuLl1gaM24wrRLiuvDzg2WNRtgAHSA0cmquKfcLxyLtOmhjp0ggWALLBnpKUk7xrTUIVV2bKXwL3jJg8snnYjlMUh0MCXahzOO06r6tdJOiNO5Q/FIBGHq5HHoa0fNkw+dez1olg2zXO6DA4pSXowGPbRLudgsZlSkU4IjesHNHRhUTNMRoAaRW/M8ILtWMc/HKu4Cza01kv7qfML51TJ7L0Tzg7k2XaUZ5xmv14mVVJAK/MTQ52gDRQOegyw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Waa1+zFQd17VlSMgpECeFDborX4/Nszc1ADXTIXCJQo=;
 b=oi1SND4IiIyt0Cim7UBPsWGZMmkJbEE/WoeQ/O4Auuq1Q6G8cSi9Lny3hmlrlg0RTUiwW4fTBV32OYJkBxoWkDjRVuwsM8o/qcaegJASoK1tz4sVivSIHRYTf9XAeAh4L4LCSC0maJBlSe1XohXlnBZmQihUYHsNO6dqg90tHKBKwmaNAMPepzzjqgXy22UO6kH64BHai7U1VI3ch2uPMfdffxBmlwd69znVHcqVsJ42v5NRs+dAQ0KFWMQG/2Jg2CywN2sfMd/THtYd33ehumnTZEYiP4JNP8ETTDR1J3D01ViOdzNUzT0QCHbWYMw5W2/K4/5xAO8BrNxDpj88/Q==
Received: from BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 10:08:37 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::36) by BL0PR02CA0049.outlook.office365.com
 (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 10:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 10:08:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Nov 2023
 03:08:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Nov 2023
 03:08:23 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Wed, 1 Nov 2023 03:08:22 -0700
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
Subject: Re: [PATCH 6.5 000/112] 6.5.10-rc1 review
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5744ef15-bf0c-4796-a3f1-0cb016e8daf5@rnnvmail202.nvidia.com>
Date:   Wed, 1 Nov 2023 03:08:22 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9179dadc-98ca-4f73-a79c-08dbdac283a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZvLiQMAQKsvnh836q9L/urkO/cgVocNBALYJAmKNdU1UDeNpvyNFKTSk2d7OGkfDsLLXdTYmSwaf1s1k2+K+Q8EMAuaoow1dhd8cAPHK04SKQ6XdJoey25/6R+HnUdtF4Zw6iZRBar5/wqrLuX1WnZUyk+1hRCEub1RQ1pAfNZUytdB2BOxt9HCQYpZ+ucbaSKjFb1yLPskHb1Uh4fqOo//ElSrxb5J3j8RZ3GZb5XzBuLUajx6NtxO+DbflJsO/kS60y2EOFxMW86zN21CKBuT2CNYmUylQaxC4ALn/sAerhrveonv0NISE+4WAd2EGVpuX+2i53o3KoEEwRlu5beXSEHmapk54XXRC25RjCLsuyLoC3HXlxpSZ7BZ4EvnpoGDmY6yItw1vVJgmrQiRCUJ0uPhJ3PkReGOwhrAFmtaG4USZ0r1kZ04QwXPzZ4aoPlBwnKcf/j71ykyBaTuPAn5GxddImzYSNDBN5n51DThabL6uNz4UYFUk0ocr/LOaBXdv2V7aSNEpPY2U16SKZHS/W0oMxJouMnXS1AEv29lEZKyFfHm7jTVCsrqJJ2cKNAjwwAMa8jm7U9tkZbxGChB1DW1rM/Ke/CVGLlrUe1SI8eZZz4FwuTI2qgkK7mLjZmcxYxNUXScjfzorOrwKrqXWkI1RCMJ5W5I5vMpFelDKoUSA/p/fMH0pCebYueAgDZCrMrjyBuzUPmxMA9TLaCfyOL0V9vA+dHN7/aiSJbwktLR2olJPqYvmFP5aa28HBhEdnhWtwuqbT2Y+sv/yNV34q2nFWkja3LdTZm4IxE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(4326008)(8936002)(8676002)(426003)(336012)(26005)(7416002)(36860700001)(40460700003)(82740400003)(356005)(7636003)(31696002)(86362001)(2906002)(5660300002)(47076005)(41300700001)(31686004)(966005)(478600001)(6916009)(70586007)(54906003)(316002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 10:08:36.7920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9179dadc-98ca-4f73-a79c-08dbdac283a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 18:00:01 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:58:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.5:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    102 tests:	102 pass, 0 fail

Linux version:	6.5.10-rc1-g43ad4fdc1845
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
