Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB70E7FAE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjK0X0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0X0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:26:09 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956711AD;
        Mon, 27 Nov 2023 15:26:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfFEOeIrbU0M4PNVfMdhnqz3xS2+7lcVVl75fcf/iTpIUFo1leCJxKcCviIukUvTJBMk0Mn1fJ1m6sWs3jfTh/TpsyQCAuTNum+oJb36gEhKfZIOrVSHdNX/QoObUFJUYcAbNvK8jtLkZ66fXxUxaRbh2c1kMVHgjHqpe5RaUC0zO9iRvkee/UY5nS7qLMOEP48Uprfmx+8TPI6ZuDTqvgqiQIXDPZ9Q8FUf4YRM4ntWyRKq1RmyOWbKz1Yj4vaqp0DA742ehLz6B7ZrOFXzRgt2nsZFIBoiBgSwU+7mXAMNs9I2ioQcG43xwIYoLp2KHwjiarem8CqNSrSuBZUeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgTbKKrR2mAFemsaMG8bFsZ2eR9xHdSy4KDQE4KZl+Y=;
 b=Ax37XR794BD+Wpvxl0aWSpCLEsLW72qLwrz4/Oabl0tZ2ZRIfiBQrrkmSGKSaStecVAMUHc6po+Hen1UJFkw08DZ+r76us9GQJB58P85CBETAuhjA7AghEHXD1x8SceNUaxpFomPAfgbLqzcHnPlvSBQLmw5IMZSocBc2YOkhlR7ddKM+WwLYWdWcxLlBgs2stUg18YmdqhC7AqLV98BMlz0OCPPf0W9FrT31tFxsr1DKRATWRAPtlhabA7PMolt+bbfQlui2+j/xVH0/qcGJgjOjRnsrJK70e02JpJqo5M1PVuprRhTHmsfZpmatTDmjpwsyqd4TiwItIwItBe1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgTbKKrR2mAFemsaMG8bFsZ2eR9xHdSy4KDQE4KZl+Y=;
 b=hx5oy3pZKWu9IPA6TOO5DecogkUTcc1HWrWL3Lg0r/vfxhizIW6a76HsSiTDJh6+e+LVyqxLi4ZLWSr/8xztnsB2Ef/PtrFdl9DbEdn2++DLVm4TnLUtj+IUxm0OQmePtZA0bFR6jx2Bu2k9xXb28a9GExtLRVkZWxKvOBHNeLl4x7F5jCj8Z48Xg79IOUmwpBAuFAtu+IrKrb8SrmdGZhI4K5VaFwTj6tRkQdvXLRD09v/+X3O0KBEZ7KrvCd+j1S/J+o7A7A+zWmPqEfxUuVgdDL6NCbckTVJPJahcf8hJIKSXZCnuxpENzQ6OjlTgqui6I7wIx2YDOwTditRsOQ==
Received: from CY5PR15CA0153.namprd15.prod.outlook.com (2603:10b6:930:67::23)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 23:26:13 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::f5) by CY5PR15CA0153.outlook.office365.com
 (2603:10b6:930:67::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Mon, 27 Nov 2023 23:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Mon, 27 Nov 2023 23:26:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 15:26:00 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 15:25:59 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 27 Nov 2023 15:25:59 -0800
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
Subject: Re: [PATCH 4.19 00/92] 4.19.300-rc3 review
In-Reply-To: <20231126154323.146332656@linuxfoundation.org>
References: <20231126154323.146332656@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <1bc56a0c-f9c4-4e28-ab53-eff4e6e2a80e@rnnvmail203.nvidia.com>
Date:   Mon, 27 Nov 2023 15:25:59 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: cd95bcab-f48e-4a11-ae12-08dbefa03e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2ZLhJgIRFTPgKbjq7Sfg0HaivEHrtNhLuWZupWXExbKKJkekiOPhFqlC+oeW1+XjgplKBn2g2JMoCayzAVzPQ+FQ1rsxBUaee+STf8MGxaGeXySAcoAdxFhUuNvbYdUvqjFkTjr29oLXdYQm6mhMyuRZbWvLp1YdwwyhwpLBeqaUJ9kY4SAVVIKqyQVpUd0wPP4aMlnpEdsAvfCHutWCOr86eizbxWfB7hqKgjfU0FM3CvMz8qcpxntfcUQqdNjUk0mjNBe2BiVD0kQnf7TrnT1+y53RdITn1TC5ZtTDOw9lj3lkhJ/ysuyzI8Zi5X2MO2wJ7MTXiTYnUsxfhQEymprTezYwCj3VhXVPDZHNcRiQpH2srwRGWpyEXtWFOCOfrkdV6wscYx/6AfzslA/KCMjQsAUFn4GGpP5Gw1jBQ6karOC5GDawto0jgAHFSmChUDKRSfGbumsjcLnUNPPzfQBEI9c/ytVhsL/wQPewawrrCkQEJ04ymfZnNfcodfkLgDCQTCvPE2AXp9Gu64Op0IEOgKlr05J9MTXupeloJl41Xta5Cy7pcHyi2+n2dndEYv9oGFpucbRJemNM/mQvZclVUx+mggx2+ueHG9Tat4lT4iTFy0KAsXt+XQs0XDzLaixE08lS3IpWsZQ37onV3+FJuMb8A2GxVADcMgKag3wxLYJYoHLSufZREIw3/+cgp94U86A0h9Ri0TmbdD+oKEQM61k1nwFxmZG1apE0IwsS3XaclnY7HQln3iTyoe8G87YHNmQwEAf7+LsU9a9iFehGRS94ZbYJqI6g07ME78=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(40460700003)(26005)(426003)(336012)(82740400003)(8676002)(8936002)(4326008)(5660300002)(7416002)(86362001)(31696002)(478600001)(966005)(6916009)(316002)(70586007)(70206006)(54906003)(36860700001)(47076005)(7636003)(356005)(31686004)(41300700001)(40480700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 23:26:12.3759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd95bcab-f48e-4a11-ae12-08dbefa03e74
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2023 15:45:59 +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.300 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.300-rc3.gz
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

Linux version:	4.19.300-rc3-gc66845304b46
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
