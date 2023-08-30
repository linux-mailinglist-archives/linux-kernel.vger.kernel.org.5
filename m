Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3011578DC60
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbjH3Sp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbjH3KY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:24:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D04BC0;
        Wed, 30 Aug 2023 03:24:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsx+JPfH4qHoy+3Nrjm1AFoW4pTXPUwnvmrKcELQJKHw1z3vwRPsNnhgYab640J0FrDiPJGLtDGumVnEmpqb/SJcJ/ZEDD5azILx8RLO0Bm3vCHJA4wPdD3WzUW0SnK3Axd+GXOJHK9JHzLHco4Vf3RDpj4p5kArdSQmH5nL6v7qgSHJ9kbMgbqtmjvkv4avsGqy1od/HyGxoIe0mshoCFn2uEL3quFUS/XSsp65A1xw87uNzqBpFB36b85E818Ynn0ye7pALLGT9gGTnIddFPkjhga8/idzuk+QFdrUNAdnZBzj/f9sWW1pIOg+MTQJNb/kNy9hVr9vu1lcmVFeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lPiLh9xWN7nrOT8/RU7mr9QnBiQMAadi4l6S2zaXms=;
 b=W5zoDpdlkQu+wlfTzNH8zQv+MYcRAZMHVzXbTqicckoyuo/0vi3dL/PMaJV2YcbCCTL6cdz/aNRmqfqHLXBG2iDEH5fupfqpEJx93BIluSnkmVifbszuTCuJJ3vn5Fb9XnCbBcZFARvSv2jvMXAHkeFyGpWlC27lA0Itm28Mi1hnGh8DiYihlnlw4zoSNETsF4odIld+J9ls3n+YoxOPvLI771HCvzJoGiEDyUIqf6IIBJejibeOqICr+bA8C5JhC8w5y8lhGtAmDguA1KT0hPw8TX0g77OybwdmhqXmKPfer8EqHmSc1iukpHPY6/KeRsdgVVJfjwZc4TNu1nApog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lPiLh9xWN7nrOT8/RU7mr9QnBiQMAadi4l6S2zaXms=;
 b=mrnvg/jCIcbIjwGWCFidnt+t8AGvh+FAiAz8/WQXR+RBBEHUNC2/I+t4Hn/sDwJz/7SIMFi8rHuE4PERTjQCoTY8DjJb2+dFRYB+2tD2gY/4Di+4v8DrE5cwm0NISDsPakN/nefuh5lBdNB8/ESvKGMIcUIwkHVmGcveItwiX0IubvOkqWPsiYbnTLcykqwUxoSAFTZ+cUrPydFLy6OoY3SqsXcSwEDGayFPNutt5kMD6oxgD/sWkxEqwYiA1AAlJMC+UWMfufPCOvA8HBT23L61CPwIE8m9O05NHKRi+dF10xlOtHoS82LaflqrCLjPbKaAGbl0zdicnVP38wv6xw==
Received: from DM6PR12CA0001.namprd12.prod.outlook.com (2603:10b6:5:1c0::14)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 10:24:24 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::9) by DM6PR12CA0001.outlook.office365.com
 (2603:10b6:5:1c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Wed, 30 Aug 2023 10:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 10:24:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 03:24:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 30 Aug
 2023 03:24:12 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 03:24:11 -0700
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
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <5abec972-b704-4d2e-8e49-38a90f2fea74@rnnvmail205.nvidia.com>
Date:   Wed, 30 Aug 2023 03:24:11 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: b320d32a-9af2-4f9a-af4d-08dba9434819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7LZFUku/KO//nZcFCL0263Vqn6S1PJiif8YsxdvGVUqgmk3eDPi0CHV/rO2VjmU8RA/Eqji6UP/higmX7Vd5zPF8/Ao/XIjD0hh2uVh4vZ1Y4HEcBRcd89FUr/2Xws07lNDlUFw2NG68DZVyZ3L9gshcTZf9aBTLD3n2fehIrscgbEkxV98lGqgfQUwN/aRogSjaavQS+h4KqKpSRrBubVY2/cQwmGVddVl8HY74Mb4w9Fn8jjxduz4L3ffUCtCgT+TQzfHwkKla39Ynp8erwrctu6Wry/3wk1+3/mNkJVenHIghqIyjf5LitOfXtyv7iJ1tNBRMp7gje6CG+6Ohjyo3YdcOY8x1SnMkR4xM1VYAx/5jAWVBX92ksvjdjGW1b1HXuZkZXX1OkpIQFubtz0724YbrtgZLYD28EIJDIbA3MFi8Z11VS/Gil/azHC8xgHMbLWky9xuAiWn+5rWYcMwBJABBlRyB5P+5ZyVC0g0eE6TiqIyL2fKPTKlGj2t9GaXBUjH6Hx1GIvQNVIROonj98Q+TfvB4P/kZ3ej4F0YgiXafU6WkhTpoRmkOtLtsZKTLNanIesfCiRwQHEufcEI0vea8O7wNeu1VOz4ltb8lYq31jkL6cmHRRt7ZfyIESWmNlVyvPbdfeD2xpiD5vlz0C/cd7RBfVNh7MMTQIDb/kV4KPndMyKacjBh67N02kWlti75XIAKy9bwJQm5lTwqxJfyIHzbwgPFQNSUkqwi7KH506/L3dx2bpoT7SqKIlfgdbz4taHmFk0F68sTFflF/KKCh+ZIgHi4LogkPj0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(186009)(82310400011)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(2906002)(47076005)(356005)(7636003)(82740400003)(40480700001)(36860700001)(7416002)(40460700003)(6916009)(316002)(54906003)(70206006)(70586007)(41300700001)(8936002)(966005)(478600001)(31696002)(86362001)(31686004)(426003)(26005)(336012)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:24:23.9509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b320d32a-9af2-4f9a-af4d-08dba9434819
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 12:13:01 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.129-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.15:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    114 tests:	114 pass, 0 fail

Linux version:	5.15.129-rc1-g948d61e1588b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
