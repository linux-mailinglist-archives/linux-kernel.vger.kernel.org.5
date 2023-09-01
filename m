Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756D8790230
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350626AbjIASpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIASpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:45:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB9A1BF;
        Fri,  1 Sep 2023 11:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAk7CFoCOSRl05CSn+5dIxjRii0avKDtBhVmgCak1I67lrODGs9QY+C2RJygluMK5BRD9hK13asqYKyP+KrcGBud05lcq3WeDmmI0MS2wSt0v4OvF63mhUAFhCYtfzh6dSyoIDvPqszWDFkZSJ4CIzXnU0JL1+clEhqEf7H12sHSSVLy6xwJPEZV8/gc5zNiHALuAJ5qR+rCv5dIF9N29Q3CHUIFe3YIqGotVdEIYzZ2sszmI7qFyaQdUC+ZXWc/m79qkgD8da2E3SwtDacmSgsMP6u8mgZpVlUiDm8cMnQe4FwRG5kZWp8HnkBjArqZtk/d+8cU3PXC+2dcGxyhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMcUN+8oYnXROY74cPibFS02Ju70H+dZlwBm+ZNy3K4=;
 b=cEXg4tFQjgGnjoXIbJBkcSF3cuxMjwk341L8/N3CppJNNgN+U0Dc5OYmV5mYyPsSi/TNDjMSHfCxbMBpm4g69IKrCpwnSrkvi4m5Se7LyKSjgrgU99oEP6abl4tTisFEWpOE1LhPp7Om/OSNDQD++EHcOhRdS9y37XzR5DSOf9iGA3cxq5ffw3iMafXX3l3RdJJMwx+n4a1SB+MF8qBUWUmOC/GZgf3m+8pe57EYX0J7DGISbFefv1+yvsNFocl+cSLaOvGxcrv5JZP0FOP84CGwvsHIljRulnDubwiIpATNz25j1LEx5It2hO0xgowypHp7N+zsWGh26aOT3dR0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMcUN+8oYnXROY74cPibFS02Ju70H+dZlwBm+ZNy3K4=;
 b=aS1RjV0VPwWD94z/fdXQU/pn7oEw7JLriLDEBtDUmO7NDqPZjrCgltUcGWwD9rxIfAkHO88PiQuUrSnHdY+zbEX7AmGxceBOLla92Wh/U4zh1Rb9TN2hi1K6idEa1UNq1vpBmW+f6zeTadtAr4Gelf4GBwFiK36gqCu5yqJJyoiO2q8AKyTDH8c1nLVYKDpR/bXBgswozNTw8ZfH5DLvW8GUWOOj+j1kSVni2TnRH7VTmNd3XZb+409vVBtANcRuL8NA13NKC7Wzk1e0fTMKt3rVj33BWKu83+jZE2LUhrSv5mpoBu1fhLhXviVmdt1JUG9cqmsEG5YbjhG89T7V1w==
Received: from DS7PR05CA0020.namprd05.prod.outlook.com (2603:10b6:5:3b9::25)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26; Fri, 1 Sep
 2023 18:44:55 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::cc) by DS7PR05CA0020.outlook.office365.com
 (2603:10b6:5:3b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.12 via Frontend
 Transport; Fri, 1 Sep 2023 18:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 18:44:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 11:44:41 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 11:44:41 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 11:44:41 -0700
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
Subject: Re: [PATCH 5.15 0/9] 5.15.130-rc1 review
In-Reply-To: <20230831110830.039135096@linuxfoundation.org>
References: <20230831110830.039135096@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <27a61d6d-9094-4bd4-83f0-3c79abb596e8@rnnvmail202.nvidia.com>
Date:   Fri, 1 Sep 2023 11:44:41 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: d923a51d-ecb7-41c4-cd1e-08dbab1b8900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAFIh12qbm0fTQO/V+ZPEfv/PlRZiwapBKqPTYPbokir29ojJeyN4UvNzehFQE7KvX3lyGFvKckL/DXpJ/bIPX8rBjHvt1ngR2mGqcpv1hnOOTda5Frdpje6v8a+loTCPyBRR9v3YMLgJqrNEKzWMwff2e2Zcue37ohR9BohW24V90jyiSaVnbvP9miKQwBELc9jufEAI3qudV5LE4EO31uxIgRbGmsV4HXkVgM8kchQEl7u3qiSW4E6BKn+zl8zmwiT9v2Ho8grvwwGtcD4smuidLb9O6RsMr74nP6WdF2AdrufdTiXePk5TWVlZ6nIkqWjwE9h7Cfnr3S672Qy1DJgZo5Zs3lWTml2GSJsc0lFloMq1H5PbA+aMqwtPpKMfs/iE4fbPHvOG5FdVpWus3FC9Nlrdhi2A5i1ItVM2t24vx0x/B5WvH7reWr5oHsbpvjAoZOoOWYy7ynM0qNlcCfY8YYzg3tMr4VmGXDdK4MIxN2b5Fn4OECHypwiubuH33FjJZTRc9wjt2n9B9M3DTXS0v4kPUsZ78n19cBOoccNTVeKJqkObwO2J2hP3/xBW7TDvtyIbviLo7tHMXbHumYo0Pzbsg7eWsNvCERW3bgMUuRZYj47HeWnjO4m9XxW29OFCslUGtCucPPv8R0VWUZE3H7BWR/cmJ/YZ4cH+r13iifac24eFCjoLvaK9DVSZDzSGeJQYplqHoQnvO79Fwwp4+GNQPaugN0s5/waqqaykzfpvJJwEO0EjBQUUFoEdV9IkjhogtENvaVfhxAqvle6rxE0/Yu0o+KLcQOUpmU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(7416002)(2906002)(6916009)(316002)(41300700001)(5660300002)(40460700003)(8676002)(4326008)(86362001)(8936002)(31696002)(31686004)(966005)(478600001)(356005)(7636003)(82740400003)(336012)(426003)(26005)(70586007)(70206006)(36860700001)(54906003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:44:55.2492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d923a51d-ecb7-41c4-cd1e-08dbab1b8900
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 13:10:08 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.130 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.130-rc1.gz
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

Linux version:	5.15.130-rc1-g46b26da4b872
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
