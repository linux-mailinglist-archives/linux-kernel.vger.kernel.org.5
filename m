Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1E87A4A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbjIRMr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242008AbjIRMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:47:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3AF106;
        Mon, 18 Sep 2023 05:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI31fhfoG9Wc2ecJpeVou8AENT/Mn2vqmVP/sSO8fu234MJcD9gnLu+flEIUp8+/LsXCQGjriwz5mnDPzICdlD9qJahYP56fOrb4lGcvCpuHO40skQMJnsL1nsZASJ4OfzGrbHCjB/Z49VyKcHC11muCO4gW+kAHfTC0IK/jcpbQTlB3qfkMWmBBEmTdDrU7sHs9rCi/dRBbaQDDMshQl45ATxZlnuaX4Yah5O0a0UPiYQU5Vut5/dfusuk2En5mN3dh2ml3Tzrisqj2MzG8pXYjTAIQiIYvOwhOFC/0/lyIIkrDpdhUy6JEN1Us6SoC/H3t/vKlhAiscDppC6pwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4Qt0qilhsjaRGaLYks3Muhi5Dj/h3lL2suZzwSrtz4=;
 b=SCIPj86XnsuqoxT3kcf0Pi22sch+yvgli5O4fgNvw3A9Nz2+BleoAA3zzNAGUWxtP65vfsKpY4o6lGmh9jg2oKzX4y9AuFcyyTA9sPS59YcqQQFW//LJjVEcMezHrV2oTS9zYCKl/S2dYBTtGNurSb33byxfAPm/dBqLug7Dlpn25THcXnFyXh5RaZCmILhi7sq7In2PQD/1bC6+QjIMrjEqEKW+5hMS0yEdwV7eZrffXDU6ZUhkPR4Pt00q+ciC0MrI5fxTVcoxGR3W5PmPuX8XA84cG42jO2sTXCMXijXMCGA9S0rYJzBvWLxtVwv6DXqm65y/dleT1ANd0PmtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4Qt0qilhsjaRGaLYks3Muhi5Dj/h3lL2suZzwSrtz4=;
 b=DL7kBAxIh7PBubbyknWobphYK4HQq4jFbQS85m29SUyEZ9bDn0ont6tYZegoy8jnbyNrXkFqOkip240YiOE1/Dd4LzuG+ODrc+hXIrEJRLhGu8zeHd++0unMEsQNbgOdCRvJ2llltmwyOdi1TiQk5ZcHZ2Anyg09bSpTn/QITjTpor8ZcfaC6Z8osYiXl/eYA0TU9sM9iFHqpsX8PO0E3/FfI64Wr8LTCqNLp8fYws5UrH72u2BieH4D2WE/fVt9t7RmcgzCP9nM2/NCF6CqQZlzdDPxKKj1dOD6lQSk5nbbOkNyujbzgpOcLt6AEfMq3QwJR6BzUbljv75e6b8CSg==
Received: from BL0PR0102CA0020.prod.exchangelabs.com (2603:10b6:207:18::33) by
 MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 12:46:35 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::4b) by BL0PR0102CA0020.outlook.office365.com
 (2603:10b6:207:18::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Mon, 18 Sep 2023 12:46:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:46:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Sep
 2023 05:46:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 18 Sep 2023 05:46:21 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 18 Sep 2023 05:46:21 -0700
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
Subject: Re: [PATCH 5.10 000/406] 5.10.195-rc1 review
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <d3e3f3f0-c0bd-4a75-a218-a3068d5ff95a@drhqmail201.nvidia.com>
Date:   Mon, 18 Sep 2023 05:46:21 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 875c61a7-a850-4c7c-1a95-08dbb8454b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xw1TQHmVw+Jvku2/5YrBFfmvU7jgJMo9dgwVrJxhcx6sLqU5MejP6C0qwgS/2IDVSrtYTZBlx2EKABzBlFyfM5v+0Y5dVDTx0q2A76rtJAit+Hq+kbANDbOBzSvhQlKoxBNxh1LEYH8GVlHDGaU/kIq1u/HBUlKsYiUenGy1PG76DvIypQlFjaaQk1dF4GGYI06Q0FYZQhUlQ9uCLhrwU2+FuO/0i4X3a/z7o6j/zTT2m3E22u2BsxUOwp82sifJTrYB7XchOaK+svSN4a+tyffsJVJFesqMzV1dawICFkUJ1/VckWJjK+A+YiYJIm8j1tcssOGlznYwjTlllBZHgcEmqc8XKIxzI86mdZChD5KI1JsVxWxIvTdNnUwzetNznYpSISpVmVPZ2YOP+g4WiO2Iw+abRGDaOOJsXm01frTOHsrkRj4E5CtKKGY6Tfgx1/j8qFxK0+9pePpSiPlEPalOQJOSh5EXVHz6Uq5QIWibvzvVn21dXNZE3Crqw7uMhm6bhIfPVrjlcU3dm9OWXi06NgPguj8pMK90BWhcY4Fd11SpRI/EpFRGhDjSTyo8Cz1WkhaQvAvaMR7k4N+H0uZJCB74miQCSDjRFrf4fYtR4c6HKTdyPRk0nBhSj25nBB84+rAnoWGXMubD9LkJwbglCzQ1eLCf0U4mGPTve4I9ho1hJOEO8mZ8WBB3oXTZRG4lam5lC5HX7Inihj1kJuPHQYcYR+KV8zhr4hx8ANV5cecDRO7WUd8nZx6cYrSTQlqN1IddVKR+uJX1xWh36Un410WYSDIpmVAxziOvg0w=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(4326008)(26005)(40480700001)(426003)(336012)(40460700003)(8676002)(8936002)(82740400003)(356005)(7636003)(2906002)(36860700001)(41300700001)(86362001)(70586007)(70206006)(54906003)(316002)(6916009)(31686004)(31696002)(5660300002)(7416002)(966005)(47076005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:46:35.5959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875c61a7-a850-4c7c-1a95-08dbb8454b4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Sep 2023 21:07:34 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.195 release.
> There are 406 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.195-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    11 builds:	11 pass, 0 fail
    28 boots:	28 pass, 0 fail
    75 tests:	75 pass, 0 fail

Linux version:	5.10.195-rc1-g95379666b7a6
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
