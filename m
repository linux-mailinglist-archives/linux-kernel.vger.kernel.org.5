Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B5790219
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350608AbjIASig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjIASif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:38:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386B107;
        Fri,  1 Sep 2023 11:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMo2eZper8fEdGBGtdI9qCzT4anLJTQWbcqjLlUO4gO32aBgyQoc4jxSAxO+TMp0OZJZUYRatkgZejjY3CjvQLiFvniq0ni26+kst0lQK2fIJyi2eoWrrhz1qHbPDx/p7D5btAhTBYLJHeGO9F9Wf0WNk3CxER5MwNkycKNApXVsv3vMLFdmf5GDEX2KOH7bG5W+GN8wjDEHI3cofB/CfCXMao1byrCRnTK9I7IY3aT1EIZ34klVUcMGxS4kgTSXXhp5pX0haQKqGY/oLKV79MyAogHyFDMKWnNWgLk52e/UToJa+4Ts35yi9hcq+a5VSWPti4X8161lp2pDEsQqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUXT4ReyLXJxz3/14FJusModeCnTpnXJv+fFQL6CiQE=;
 b=deyZY4xwX4y97zmscyRJ1zO3mnG2hmD15dCxKJjKnooOfZulTvKbg5+FqDOc5ISCSwP5ya3JXaHYe1Uyx8Cqgvh+0PNxkl9H19kc/ATwqmWs5Rso2hAIdDI4kUZWqQXdpMA7vquCo+pAKsPNDO1NWaffB/byCURoAhiOr4zHv6DMf+u8XRMB80zH2VPz5+MTlf1nA/29IYbrm8Mm+wxKscapdkJPQvODBKUpfMYAvlhxLy365k/aP8HstkCpBJJVrZ5tE3lbhfKF53R6+FPNdleDwtTdLeXi2o52NFDtsgzWvl8ro+Hu8arChXCEZvu4OtZJ/GX4uBxxkrFNL9FCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUXT4ReyLXJxz3/14FJusModeCnTpnXJv+fFQL6CiQE=;
 b=OUFKnVaLSk2ITgPmxAPa5EpfRVN9IGHjIzuiWgV7oNk95Vplx3JMjTfX61NdysiA8Hfj4R7Azjc83zQH4+GACi9r4LDjeXZCZMC6fRM/Nl5VY/Eufl6uWma+LMHcA445HFFM04s4HP6QnFL5fL3L9E8psnl0j5u1O1FAaplHgXQURJNAgBRBjJjlE3rK6hXrtZknY+jjkXUDf/MYAGtX07kDs6g23wCAEw8nEdsxMtjuy/OhJyvsoDm4yAPJws1+PRTAbju9vgI+IZwaDhnW2Q7+gkXPOQzQLGlsUEyCasWEEmcRfWH0Jpa4acHep/he/z5MuPj39fVnsyyCF8lTCA==
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.27; Fri, 1 Sep 2023 18:38:29 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::20) by DS7PR06CA0012.outlook.office365.com
 (2603:10b6:8:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Fri, 1 Sep 2023 18:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 18:38:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 11:38:15 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 11:38:15 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 11:38:14 -0700
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
Subject: Re: [PATCH 4.19 0/2] 4.19.294-rc2 review
In-Reply-To: <20230831172214.759342877@linuxfoundation.org>
References: <20230831172214.759342877@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <242a73bb-c355-43e8-9fb0-0d7634d23c6f@rnnvmail202.nvidia.com>
Date:   Fri, 1 Sep 2023 11:38:14 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: d242dfdf-c4dc-4e7d-9e45-08dbab1aa32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7oOhps2UQU/pJmIz4d0ppudKaa+XG0uWhhTN/RZEIzRkzxbCOUmrnKraOSMwySec4pHDG6GlpTLv/WaYc33yYbMq8KYNqp+lc0S2TjCfgJRZwZ5PgPUB3b2pyy9PVilrgf9Zo3tFB3tXlIyQfwTCA6aOR/nCdyzR1LPEDal3s2ljNZvOX86oIYvEa6I7UbYvt/iuHrM0MMh0cBVwGFw0s5e4uhlvng3M4IV0wFiPhtjDi/sySUgWWjSCEa760ya6mn2skUMR9TmvZlMsGWNzxRONOge5f69lmIiChV9aXUdmQGQynmg7JiaHaPrIFk3hM8kz9HGNY8wFIkPcoVVTtDOH1xF8f0xY51aNTY0YAg87yVGYuISzCpfxAAvaaT3fWElggy/sIBSgJu1Mm3t/ERmRAL4elTMj3/8A8khwe77KDAy1y6l/HBcKpQIeorZoEANB/Zw9SfVdxTqDeLjBc7mqkzzjXkjV7GYk/Ouyif7gTifWxKOy0iR+CZJPrJFJD/wbk7wE+r6ShBJAg2uCamwmAC1UvAmioKiOrRRl/bNRhdVwYILuE+EhSvSP7MQ/f/9xErK0QCyIJIZX2Nor7LsbEzgBotXhQ8arEDQgOeGsgaeQIcsuAIu1RVsNdcYMV3dpgoPHxKSesNaY/U+5Wrw8iA93RzXuLYp3e5X1h/nIUxmBTpgXS9s0Pc1SsI85qFXl8t89fzpF5YYx4e6DJCRFKpg8JGarcwQ94k11/swNaisRA5KogHz0zKqjgFsHJMT/0aw/dqVobUwK3Tt4aqLQyAopL2T+fGdKIofg/E=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(316002)(7416002)(2906002)(82740400003)(426003)(26005)(336012)(356005)(40480700001)(5660300002)(7636003)(8936002)(8676002)(4326008)(6916009)(47076005)(36860700001)(966005)(478600001)(31696002)(86362001)(31686004)(70586007)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:38:29.6538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d242dfdf-c4dc-4e7d-9e45-08dbab1aa32b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 19:30:20 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.294 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 17:22:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.294-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.19:
    11 builds:	11 pass, 0 fail
    22 boots:	22 pass, 0 fail
    40 tests:	40 pass, 0 fail

Linux version:	4.19.294-rc2-gcb2cdf227208
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
