Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449476B91A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjHAPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHAPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:52:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F541AA;
        Tue,  1 Aug 2023 08:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHk61HI31TTgQPxOxpecn587M4SEI4+o5zkjfcS5bg2ECrO3Q9YKtMGdUX1cA1mQMVmoE6obWdQwyDCBSvkHYVOw2C/oljoRt3RHhSlF8kqB/3wbXco4EAHRTqpiNWAFKwXULs7jH4oJCdD7AxxDo6+8seknlQTNSoDUFtbwR1ce4gM8id0hKKiD94hMsqZJH14DOYMgezJRHLR4DLh9A063Z0Xrqktd4iIpIFw0vTpGQYbOUiRWIg7GGL9L0kjSdQETVqNdbmyCNLHou4N5BLqjsPKwqG6UkokjCHywjy4uUuHLyV7NEuDHg2pHWYOCjmYvEQcBXNnSsq7swmWJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUw7ykoTxepQmoR6ojbOaUU2N6Wzh68ILzO2HZEb7Kg=;
 b=bzzuu57zBurAQCwk4mvPVKQhRefHiCigYOqXvwn6JsfRwEOB/03UI9x+U4Q3RYL06NDmcjMHksySPsyZWPwXYPA9BMyvedL/eJliH6RyMcZpzCQ8+y6nHgaLYBo6YYE8NR7g3JSNzBLSTl2PmX/7UoBZ8qn2h4te9ZXveGJUgiJzeWSbmvX1c5nFn6+dp8zbOtoqEunjDls7h0MXhErFKTK8rpLcP5Qvi70MtiTkK3Af6Fg4O+QZ/Fui/1YOLHRns+SyeSf0A49dvH5ufkMPVYh8EgeINEY8OV6qFXwr6JQyg2cr1BrMOUnpnsLqqQTUifouTDWqwYa/UvSqKFqmCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUw7ykoTxepQmoR6ojbOaUU2N6Wzh68ILzO2HZEb7Kg=;
 b=o1+EiXD3F0T0CyfdyZRee5QuSKyC++CkZS6pV3bFazDeECWXDbDG5WzUKYVX+Z0BMLO6D6md7eHBLw9xjx0LqjHhg6M0f4HfSM57Q33qj5WlLp0UbQbBb0yiNv7eVD6TBR7swq5VsqDrI1mhR5ncbUJsOdeo4jtI3IZ05GDnuiQw+YbY4cbZneZsBAUXbbhC4tZVLGRyhVc1SovMQ2s/XXYoKsTO6ukOeqJsmcEKO2L0DY2wgQVeHj2WmjG2ODTwhcUZBF1tXaKK1VpyPnhZB4e0u0NuuVqgckT7NcRIGZf50HQu2CMx8p1mVUAiwpLPpCbp80EqbkDks4TyN7EWog==
Received: from SA9PR13CA0102.namprd13.prod.outlook.com (2603:10b6:806:24::17)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 15:52:19 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::c6) by SA9PR13CA0102.outlook.office365.com
 (2603:10b6:806:24::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.18 via Frontend
 Transport; Tue, 1 Aug 2023 15:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 15:52:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 1 Aug 2023
 08:52:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 1 Aug 2023
 08:52:09 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 1 Aug 2023 08:52:09 -0700
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
Subject: Re: [PATCH 5.15 000/155] 5.15.124-rc1 review
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <31a94827-0fbc-4903-b87e-f8036c0d5155@rnnvmail202.nvidia.com>
Date:   Tue, 1 Aug 2023 08:52:09 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 42453fa6-1245-4465-6b3d-08db92a7497f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prnH4eyfpYeAkP66VrBZK4wix3MUSdd+/EkhQOcWfrCA8xEGDNpKQRBSgFMgse7w/8w/YuIEb3YuS7QffMLoMZdpAfu8sKA4BZYUskbc1UamSlrRqmS3cD7O3UOdGExenSRnyBPniPZVeT2tcJXB0AugnNuUEdl6g7XXhlR49I/y/Ex62hoxO+Vxxzf/Px9ww9CLOLWnZPzZNwPiEGY0ePd+FFnqsUHwlYM9uAYw+Zo7ukdGDLqfMPwxgE90x+hCUhJ9sSVy8Fiob9m4nAQkWgAyhHty43ALUwf1i3PqzwHcdB5+jem6eGcCu1jQl/PnHsYlZa6Q2t4/1U3CVziTsuNy9hiit/L7YALXi4FJI4g7Z4NaDOcBFNK4rppr/FGCe3p29HLnQXmsjOoTDn/lt/5C9C9jW3ydE9/zmQC2YhksTlP+J+VE6tvnmW2ahbK1agGjVtkK3vstRLzl8idJhpgmbhktWrqG22IvbJbt4WMnwWDkYRt7T/xgk47rTTlVPNH4x5ZNhZDIrT90KoWFXqSJz2gxFrwmXgfSbR0rilwiEJxqLtLLJHAclnv7WRkG1+Acfu6qxFWwxMrLJAJMBdioCva9DhguKU1zwBprJheTB58DbM7mQhb36SfN+tJXuCdX2VJAtTOSOKZhNvTfiZo4iAZjkpmPEBQf328CVB1kvKiEMGIlfbzeLaqItNAsXuhB5/WPsO636JmosrMNCxF4fIAtawJdugxoTQotqiT1KGCbt2qvx8mHGe/f//JsGyj4v2n40kyOEVcV1AeAImJoc05JveFS7ewINbt9Olg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36860700001)(26005)(8936002)(47076005)(31686004)(8676002)(336012)(86362001)(186003)(5660300002)(31696002)(426003)(41300700001)(966005)(82740400003)(356005)(7416002)(2906002)(40460700003)(7636003)(478600001)(54906003)(316002)(40480700001)(70206006)(70586007)(4326008)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 15:52:19.1931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42453fa6-1245-4465-6b3d-08db92a7497f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 11:18:32 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.124 release.
> There are 155 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc1.gz
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

Linux version:	5.15.124-rc1-gb2c388dc2443
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
