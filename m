Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96A8051A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376896AbjLELKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376899AbjLELJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:09:53 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61861B6;
        Tue,  5 Dec 2023 03:09:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRo6YRd3nCZ4zFkhv0WSpzPGdiisnPJwbYS0bS0zEwuHNMVz0o8VQ/yTC47rShlAAiTr79XOf4eMMr/WIJ/jxFogakDMdY0SmKMWIOMm97LM1PBwQX3A9LP+xryNjrjAnRRgxH+wM1XM+72CCqrPDOgimldruk3AXqU+YkEBpa98jgU1s7IyrgdbKIK3/mKqhFX5FcMgX9pZRJPra1IHWsICPULB4EdAHJQ4fclQn3Sylcy41YTED6QtbhuQB9pFCJorDUHJ/0YYdKtgR4dXHS8WSeSs4bxSxOdeFlqFQYmPN1GlBfair4OWORetsVTEKP8rFNCx/XaVTuiyzLexYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElD/DS2UHMzV0rR+xY4M/02ffoDeoG0aoqup6fGGC18=;
 b=Fu4sWGIAssu2h8Dmm+R/UmpzjclBj4lC3TgM9BNu7Jx51xj9HYeCLL9un42YxWoHnv9q9BLn1mLKSy+INclSDdH9DLyoJTvDFPfWfX8PSNKfEx6mfYLmyLybFX7thMlXuJHdBPgKB6lZ1MX0jhXKw9YZY/COne3v4ntUsdeGsvgkob14dHXmsG+KAaOkWKvhotErVAQlfddeLLRKnMJZHONAZQehiPxaXf1BJmohBSQZMLtFX0IaXLzSYnXABCkW7IftT8mj3bWpWfynRC9DNTjgD7MwWSzxaWT0sqlqS69OtPaJ71nPzOFaBOKfu4gbFCBdjHfSxsM44cK6MZrJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElD/DS2UHMzV0rR+xY4M/02ffoDeoG0aoqup6fGGC18=;
 b=HyxOHSFZ5iKLWegkrjwe/fsELJdfzyd4tnP34s1Evl2F/USYIqtl+oU0AupS5htClAYRlEDJkASWI19GHVoXFOC3cpknezsPxGpLdixuR5JhZpAfgIO57siP3HfGJPlso/93FrYK3uHg+T41nKEuEUSPLbIlVTzuUPt8TuCYz9vzU4zBhOPJ2aZ912McBQSmqjUjW8D9lAYgmXudej70poC7h5t2EaKi3QmX9u9OGtj7z2W7iX95B1NalysN+KUQt5VUV6HGxVJaJ8jojYMy38MQgYWTRvki7rXmGzLDuH+aONPtzDaTIwVowTgrJBmmf9Qfxo+XxCXFHsY40glFAQ==
Received: from DM6PR07CA0130.namprd07.prod.outlook.com (2603:10b6:5:330::22)
 by SN7PR12MB7177.namprd12.prod.outlook.com (2603:10b6:806:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:09:55 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::1f) by DM6PR07CA0130.outlook.office365.com
 (2603:10b6:5:330::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 11:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 11:09:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 5 Dec 2023
 03:09:49 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 5 Dec 2023 03:09:49 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 5 Dec 2023 03:09:49 -0800
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
Subject: Re: [PATCH 4.19 00/71] 4.19.301-rc1 review
In-Reply-To: <20231205031517.859409664@linuxfoundation.org>
References: <20231205031517.859409664@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <0c5bfcfa-1163-4f13-baa1-1e4dce44adb8@drhqmail201.nvidia.com>
Date:   Tue, 5 Dec 2023 03:09:49 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SN7PR12MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: a41059e2-4da7-4c53-eaab-08dbf582b5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVwEAZJewgf2gftH92YwWa6BPwO3bSVdpLXPE7exSvTvp+M/twVIRqvlEnTML5tGoAJGUt7f1SPVCjLidDVPweeSJAYAumu8jCI9LRlbHviHutG0R9cTsCsH9aBtohJGO/sALqs64OsWJpcsXu5DN9CewYLunYvHL36mPkLZyjHywxM3eB7LonB5njKbd/7in8Iw6MEHt3/6iApXosa5PoZ0z3xZ+CCZNDcb5M4UNkGO0vfva64bpNAlqYYvlRRCCL7/X3msUIPyTnEUg7qtgqkoB2symRHn6/qtk2XlViKpeRFVHbhZxGZXSkBPlubNfzDe01p3AmKDoMkxyFbXAzxLhhKBD/SRdQPmbzCY+wfArgwPlvy0pGOKjAqgk79ek2ZVAi9B5imNZBRa7AqiUxjToAhXC4rxVZFeAZ+M1tNsvWo3enkbNKbzLZgUa4hyL0+ULncaCylemGMs1LRYhZgeHQf1McE6Ym5l5z2wYL7adh95LPk8RDF1HE/gYH1WzZYXlAhZdUWo1GSZdHxCVBzoGUlp1neV0KckOH1+C4LMiFbp6d15pY/9QU0ldxSh3EgRbaW+Zxe1+y5yyyZfLu8lAdefrBau2wbQu+FeJLfL/nWycwF9Ibj92HDUhmnOpS0sDn4fn4e+sDXT5zHh0yd0gV6WgUYyBX9f0V5Jnx3xmJmhkFGPEU4HzOIDc1rjfBWUuwp4cYuzpcy9gOjewB6RCseOUe2p7HJlSTotbCAyBd3MyFpgTgE/SXFbpZPu7q5qkVgUAjCQta9lD+RvUlZ6wJVTXMDY3DuJVTqzDAc=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(7416002)(40480700001)(36860700001)(2906002)(31696002)(316002)(6916009)(54906003)(7636003)(86362001)(70206006)(8676002)(70586007)(41300700001)(4326008)(8936002)(356005)(47076005)(31686004)(5660300002)(82740400003)(966005)(478600001)(40460700003)(426003)(26005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:09:54.6123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41059e2-4da7-4c53-eaab-08dbf582b5c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2023 12:15:58 +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.301 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.301-rc1.gz
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

Linux version:	4.19.301-rc1-g82300ecbea43
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
