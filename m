Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2981980FA68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377818AbjLLWV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377796AbjLLWVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:21:50 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702EB9C;
        Tue, 12 Dec 2023 14:21:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOy5vat19HPpIbEIQuifG962KBaVtd7fZWQO7bltsMzaHwUoXoIXqEk/0VFwwNfkmorIWfV4jftijpEiH+zVWEf1cr8vq/pb0gGqjIMK0uTc02CsHnwac5GGTJuMlL8xgj5+oxwHKYc3b6pXVPXvPHADNjdqkk4CW4h7idj5dVSdSjBEdBMmwLKaf4g5gHBERyodYPUqnpoR1edHH4eOrq5kKvmCnzMu79O9JevB81eAWPvQXaLSNegBnnLnq/1So0XXdIsi6brikrhZ2T+JgWZ5QyHDhKi9H4IRDbkrC2+1VZBO2bcO8b31DkXhkSU/YEgAzzSMRkulLSEPVJrMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYh9q4EC0A9ngw+0Qhg16MN9XCnNUBXtlOdcmfCrdMg=;
 b=UXpBtvRwHjqsgeH9mcSe+PQd5bqj27J3wjHmn+fu+emxsO7g0+Dh50WFSClnXnecRCRax+lVQikC58MyBM/uZtlR6LXjtLoMNxfcx1RvD6Borsh18xDdWR2D4n3br/0j0wCETZF6UHEFuPpejj159J6CMFiq653MxZkkweqZX1pRgw4QiAhyKPkpySTBYtH5Z8lWR/qjgRBwoX3pQIVG9Ea+HfrG7/l9RsUgJYKnHAXVA+saak9UNsPdNr3PBKDIIiErba43wDekbnwXKqmuVD8me37Ep9JVuWOPjshBCDoBi/XbksufE8R4Q3zWLCGeOTJQhc/Q8vEqcxMC3TR7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYh9q4EC0A9ngw+0Qhg16MN9XCnNUBXtlOdcmfCrdMg=;
 b=V/RCIPAtHQaqEkwF9gHFNX5LKfmVUyPkI7WVK51rrIoXyJl1j/rVH2Ia7797Dy2ezBQLybSUfyhEP7R1TUiYkDWU4lUoaCbr7ZaK3WRZLhQPTEBvauUlOf+QQFOlJDZLKhZg5pcC/rCQVtf10MYRyGF+dbDsnaHWOkGdc08XnB99g93fN6ZDCyjaQlb6DRK0Hn6tUwZhJlEHPtsdi4FCkQkKNvgprJyvMjrRSbuf8MLfI1BEO8iWsZMgh+swBSH0aveAcNE77yqA/gCJ3X1vOSEoNAa2GX7jpogE3KH2C86gv2C7WZiCUCQpZ3pyZnEKdQC2IbpIcAgC0ed0RQ3C/Q==
Received: from BLAPR03CA0068.namprd03.prod.outlook.com (2603:10b6:208:329::13)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 22:21:52 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:329:cafe::b2) by BLAPR03CA0068.outlook.office365.com
 (2603:10b6:208:329::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 22:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 22:21:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 12 Dec
 2023 14:21:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 12 Dec 2023 14:21:33 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 12 Dec 2023 14:21:33 -0800
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
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <80719b6d-1526-4792-a4f2-5e73f282b91a@drhqmail201.nvidia.com>
Date:   Tue, 12 Dec 2023 14:21:33 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c12c18-6433-4277-d65d-08dbfb60bdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZHR8aVG9zSvwKxr5XNbZoe377KWwwEQqc1UnDIFPcDRElJEd0HMsCZEEG3Jt+XW8m2CStWFtHQcSoXPjKYAlqtEDsB23Xr3kq4MP05Flk2aH1+GZjO3GMwt0EwZKG4Df4tT+wUuAF2hsgQpV6QaD4Beys+2Uu87vWUv0fS1tlyr3W8xphT4LmmKkKKMQSbXVWH+QBRQYBQy3aINyFYE0+xUUWq9LICMsPf6NEv1MeJyn6vVFaEY5ud+gTORyY2AwmGZPhKIyd25HIXV+eC4nezd5hxjcIxWI+ZJTi8Q/HMn0lHEOhaGVAo/rIEGIH0ojEuVic9OTl2J+6iRtDG3EO14oSqN4njYxZckRnAxUp721CNydbPrhROW2r9lSXkTzAqdJYSPTknYoxYpzYlsrQO4Y4GvJDw2GsGGTQV+FTz73bx93+WKqUzw4xEqMQSquhnZ0ZHM2MLhHMQ7FJY2XPuVW/3A6niZdN18gVi2NDta9VmpbuG4P4REi4nbOtzE2Dm5SCZNifT/BGT3kl5dmGwOnqyu7yBs/tkJy5amg6QS2NDWKLohtsIHqNQgGjjcfII499Vdx2yULByHhkgG8VXorKixUMXZJBBSIGXgxTjHw64dsrDy4/t4XLTU7ZjSr7iOXTJLBNdSjvmv/0WxsBuQSDYSqzVyXd0rBxGcHJaE0Cwc8yAPIZGcKCadqzcXg/0TQfFb1i/hhHNRTY82IwmAGve49uNPs/Q6SAQenH6MTU4fF56sHFKgRuDoCm+Itgvl/V1JPezrMGK0fj4NoI3sNql38zYVoiLfg6Xe8gw=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(31696002)(426003)(47076005)(36860700001)(8676002)(4326008)(5660300002)(41300700001)(8936002)(7416002)(478600001)(2906002)(966005)(316002)(336012)(26005)(86362001)(54906003)(6916009)(70206006)(70586007)(7636003)(82740400003)(356005)(40480700001)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 22:21:51.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c12c18-6433-4277-d65d-08dbfb60bdb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 19:18:13 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.6:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    116 tests:	116 pass, 0 fail

Linux version:	6.6.7-rc1-g4970875239e5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
