Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD212790237
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350638AbjIASq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIASq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:46:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8920AE5B;
        Fri,  1 Sep 2023 11:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI7kE6N5gNfEc68yV3CPhE76u+A9Tf0Q8YQor3w9qm/Z1WgG1crfdkhukZrnAzU0hruh+JvftlGD+5Gbb29KpZVB3BYBOpXWOJrpLkNAtt2WivHiCXywe/pNUIzN41NfeygbDEv601s6h3yEg/ob6/6+kHN6qVy9X9CtfmT0x06OIL2mF3MQEv+M7MlEmzofuyi8yXvialC7wX3lmH4vaAEXWw72giS99kBw3RcyYchEKV+xrjulqldZVE4hAOxpNsihdrTMUXUnDUApcqLLRyseWcXNIcCHPoN2x20lbnQZ/1YnXSASMilprnNBQUP96Y2KIdg6ssSn/VhjdLZQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKGMA0R5Jq9XfRo7HtBgRdp42QgYu4FxCc53DMmdM60=;
 b=Z/Q/AgQsGmhOBUN7uHnSYmLoiZuYRFE69d0WqwTkfpSpCshQRVU68VawqrxZInhmnyve2BPK2TkQPIwKpvEebZDLWQJ6Jt+YpjqJBhum1Wi9BqtQ70j+c44JzOSczzbqenuySCeV1cbCiEHutNq5TJp7HA8iOb1at/4aslIe6TeDC1iCqsytsmEEfJcgSvFnzv4vJgUjMLge0R6aaRuSpKL1vAVORlv1vC+vQmFeKVL4PB45Wq3a9wO1RzJdRsSt5eOZ28SIBGiZhREpslTCsEPBrZUh8lm0aBRWVTctQ/6tvhXaP5mHNsGcQ5B9j4lWrXmP07yDFYqbpv7LVgdnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKGMA0R5Jq9XfRo7HtBgRdp42QgYu4FxCc53DMmdM60=;
 b=QnjVNQxJz/jocWjTgUjaOwC5hIO4mcS4JDda12EK1AjuomlK+0WjHSHow6fFVXmvGofJcr2wOUWZtLf1sv/kunqBpy4hWzRlwOzH5pTKrRsabNodPG9lDEgGea/1DPt4H9rz5wMzOj7OstHclimeLpXq2X+N32MBlBhZMNQOKaPzHee+7+ahEVtyuQXmXrhuReYrUX5Okx0LvjSvTPaopArbbC2HhcD5Ck16dRvlntcYWNUijeHDJKhkp5DEz5TFUNdE9RR3AKWJZq/kzJC4+KHnrvhuxcNAUxqk9tuCqgcX/j8ZtFpOmheohZDzabtXrzzGkZpI3WDsGSCls5D5BA==
Received: from DM6PR05CA0042.namprd05.prod.outlook.com (2603:10b6:5:335::11)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 18:46:18 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::d5) by DM6PR05CA0042.outlook.office365.com
 (2603:10b6:5:335::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.17 via Frontend
 Transport; Fri, 1 Sep 2023 18:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 18:46:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 11:46:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 1 Sep 2023 11:46:10 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 11:46:10 -0700
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
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
References: <20230831110831.079963475@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <a0a1be9b-0d11-4ebf-b312-9fba75d482f4@drhqmail203.nvidia.com>
Date:   Fri, 1 Sep 2023 11:46:10 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ccb983-bc2b-4f1c-cf78-08dbab1bba99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmbPmSYv4W+w342quCC1K2f0foITtDnDEru5cfS4GBDktB80AVba+QVsA6xSVn2WCqNjNwlHjpyJuJfaa5EBb+olpUAvWuHU/FAPagriprjQ7fTTksznAxa+q5dsyYN7X5syPRjjgCMVUTm8CXhacSsdlmuHzLiwVuPTAdGQmmk0SfPWd9NOLKb/q3/5pu602/4knPfhox2DgNM6Xz0VfWLgrob7yVdzODFX8LxMtCe5L9quVAUhEdW6tbDU64PMVjvrLs4x1tlIjpU5SIUIE3gEwMpPPxOXEOsqZH3eOYnBWasjo1NwhAvKgiPPGnXdWPDR2ZRLHA3EpczkiWlCNIvEQlnvYdli7qUEbGqkc7RxFMTnyDnDPU495fQuWMPfCxY/nEyr+VbkOG9wqoT6iPl0GzvnONzyP/2QC/W8hTH8NHvAZNVsXHWTibIVSStg6Um/pLBJCigKZR7sdvWfC+IyADqGM4ZjSRNcpZNtmAqR26zkCxlncBAxXG1DOQv73fTDk+Ji4ScdsPxp1zywbaDiCG5kGFDCkjE85xoe4UcWCfzuls8cqJsq4y0CUQH19JHsYc1a7nmK5/WDkCgj2A45t3fVXwI8yqP6cJlZEbXthWBieFnDzkg/USdaId6gKWtiIBRDsKZEae8VqlsESS2J11sj+S+8hPo9ZosFtg8+Yaj907ypBynNSEgON3r8LO1KvlJGAjCnLJYXL6Zx1ESFJvo8P5UxzRJQyfFHrECYqTyJBrAh9kCtlOlNNA2Azc5VyPSRT1KkN+QCoaOUBdjhn7xxI0ngdfA7Ky7rdIo=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(356005)(7636003)(31686004)(82740400003)(40460700003)(36860700001)(86362001)(31696002)(47076005)(40480700001)(2906002)(426003)(336012)(26005)(966005)(478600001)(7416002)(70586007)(4326008)(70206006)(54906003)(8936002)(8676002)(6916009)(5660300002)(316002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:46:18.5072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ccb983-bc2b-4f1c-cf78-08dbab1bba99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 13:10:40 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.51-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.1:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    130 tests:	130 pass, 0 fail

Linux version:	6.1.51-rc1-g1767553758a6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
