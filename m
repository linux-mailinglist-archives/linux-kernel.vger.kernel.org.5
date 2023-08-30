Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A23E78DD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbjH3Sul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbjH3KYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:24:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0126C1B3;
        Wed, 30 Aug 2023 03:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m94KgsoMnXG9b3DE8Afh6d6rfNgHRaUH7lwe+RjY8E496OfTPHLeDh1UvR6RUafIzNBASgIxWHFH/GzEoLSdqM7InIt3rAqVO14xcLRX2qYyFVj4a8aQJgY62I8mYULvPp+d/zWrxmc38qmnHBIT03CzG26qUI1MLWMXg4xsUnFzhLMuI597JkahjEqjGZY6knMXoiiLhuZBpQ16puPu+IhPvIDluhLliHEzUDvZQAgEcNFqbVOh+kUrXEWxcFTrLWaqjVLWy2VEju2Ch6VH/zKyt096AjpGRKVH7zyvrU1w/GaQcnXmTPnPx2f4lfMm0zbeB1gim6QHJmwDn5GCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGAqdSmQdxi6aN+nvxUPc6JDstc/mE2EopjUnesz8D0=;
 b=jgt6vWVucI9GLxkv6lB5gs4G96sbSLTfr218hk0fBuW6LratkHJNfjecc25TVasDJuX/Bednh/zlUi7ooO1JVtexEztoT/6faddnhKxSd1U4epjcIRCkUqiu/GItJHzRKL4KPNRY3vKAonIC+Epg0J1u1kzKWid3+uY5cemJ0wnirUR9vzhBeUksv7qTSw+BgqFtGYJf5h/a5QmwM5nECyge249WY5qkotyNAtROK8cfCJ8+ce5yp0AlpryH70Kz7BNp//S+DhW3LETLbIiIko6KSoieOmqgthTv9C2T5QEQkWYZcaMta3ksRbIH6l3qO806cbGpeJxzZaDJMnYcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGAqdSmQdxi6aN+nvxUPc6JDstc/mE2EopjUnesz8D0=;
 b=NfxDqLUn4j2B5JJrWM3B7NwKPmG5+K+nLuDSZorXHK5uspvXd2PpmDOImbdaPGrsX4lwPPy/r8gPWmWYP7IhW5bWQ2X1KKHuYcwOS8KxShHr31sd+fUQJ27HPpWLfIoHAdrYEYHBdhjUvwamVRuvbziinl1Tedj2syLhx/3VGrHo1cl74NyHBpRh48wxP5nKfmCK6yqzizV0h2W7vTVPwFtnSEuNHuyS0FCwhIO9N2e+MC+Ct+kcbJrGFi7DA/57Oxbqug7dJ7Ph7hr8QTFxQdP50FnmB8Vm9Gxt9rdbGIMKxxKcSgIWRcH12GwxTFAJllS1LqDVcmt1YVoOUf9BQg==
Received: from DS7PR03CA0001.namprd03.prod.outlook.com (2603:10b6:5:3b8::6) by
 CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Wed, 30 Aug 2023 10:24:18 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::f3) by DS7PR03CA0001.outlook.office365.com
 (2603:10b6:5:3b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 10:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 10:24:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 03:24:07 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 30 Aug
 2023 03:24:07 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 03:24:07 -0700
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
Subject: Re: [PATCH 4.14 00/57] 4.14.324-rc1 review
In-Reply-To: <20230828101144.231099710@linuxfoundation.org>
References: <20230828101144.231099710@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <8a120e56-66b9-41a0-b9db-bcbbd4d19627@rnnvmail201.nvidia.com>
Date:   Wed, 30 Aug 2023 03:24:07 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8ca598-d276-4044-11cb-08dba9434460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrYrZJL+ZNZ6pVpc2UkfuMwiD3JO6WzCJCbiEhXqNhFI6bh8Qa5X/2sjfOewkXdAArXl0N+bptDcuizqqDDrlls8HnoA1ai0ilrKgT3/XgM7kfV4dzzZ0LZCrqzDx8/OEt8EjC1JFSiJRrvRSjNpwJKMs3a1ywPXHO93sttDS5wD4vuwg3HonasNfX5up99VzWY3KRV+VTbtQiLIt7Yxqwy7uIrzKshdPf5lO2pgzItIhQ3KDkPqsop2XwuLejxs/60uH/l9RmeuynxLCXZhsDsJZU3KUD38F6JxnRDrdhiIUlYPMjPTaddiL1COZf6iQenVorHzUS15UQW6WOtjFkEFy+YG7xX6dYfOmDsnwpGT0KexYdWGRn2FrP8XFggJvNjlZnKJ60aqP8aoqwWlh9bfciHsfArIfYgv6L0DJ+Q4w26T+wu+rM1ITPpdASBiOHqzpHq+VmvSuEPTBqyd3rWXSVB3DryfNtf+rmVzluSraxSqmxWA2D6xevXoqUaQaZaZRJmI0zqOFElnrtuz0ctVhWrN66+xqkJx/yLfEONtZTkf1JIM1MRQIJRKn0SHUDTXMJM1PvcN8Ccx4PoQdjWEkN2sA/CMLB3Bl+s+sJeG8myUg/tE1z58legV1cAgmzKIDQXgQdHQNgsbqe3eyVMBkPJlHBgSeQaxkU60OcoxHIeWwUpcCpGFngnBEABFRGet8XykKlnVOJAIIXpQr+pRtjN5vP2l7xxX1isWFegHqwvy12S66lTLxC+pS41KPtWs0JORh4k3BvnRWH01106tW+uhtw9uYMA4014YGvA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(4326008)(478600001)(966005)(26005)(336012)(70206006)(54906003)(7416002)(6916009)(316002)(8936002)(70586007)(41300700001)(8676002)(5660300002)(86362001)(40460700003)(40480700001)(47076005)(2906002)(426003)(36860700001)(7636003)(356005)(31696002)(31686004)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:24:17.7013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8ca598-d276-4044-11cb-08dba9434460
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 12:12:20 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.324 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.324-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    11 builds:	11 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.324-rc1-g01b341fdf42f
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
